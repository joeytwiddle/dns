// Copyright (c) 2011 CZ.NIC z.s.p.o. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// blame: jnml, labs.nic.cz

package msg

import (
	"fmt"
	"github.com/cznic/dns"
	"github.com/cznic/dns/rr"
	"net"
	"testing"
	"time"
)

func udpAddr(ip net.IP, port uint16) (*net.UDPAddr, error) {
	return net.ResolveUDPAddr("udp", fmt.Sprintf("%s:%d", ip, port))
}

func test0b(t *testing.T, domain string, addr net.IP, all bool) {
	buf := dns.NewWirebuf()
	msg := &Message{}
	msg.Header.ID = GenID()
	msg.Header.RD = true
	if all {
		msg.Question.STAR(domain, rr.CLASS_IN)
	} else {
		msg.Question.NS(domain, rr.CLASS_IN)
	}
	msg.Encode(buf)
	t.Log(msg)
	hd(t, "enc", buf.Buf)

	raddr, err := udpAddr(addr, 53)
	if err != nil {
		t.Fatal(err)
	}

	c, err := net.DialUDP("udp", nil, raddr)
	if err != nil {
		t.Fatal(err)
	}
	defer c.Close()

	c.SetDeadline(time.Now().Add(7 * time.Second))

	t.Logf("remote %s, local %s", raddr, c.LocalAddr())
	n, err := c.Write(buf.Buf)
	if err != nil {
		t.Fatal(err)
	}

	if n != len(buf.Buf) {
		t.Fatalf("%d != %d", n, len(buf.Buf))
	}

	rbuf := make([]byte, 2000)
	n, err = c.Read(rbuf)
	if err != nil {
		t.Fatal(err)
	}

	rbuf = rbuf[:n]
	hd(t, "rcv", rbuf)

	rxm := &Message{}
	p := 0
	if err = rxm.Decode(rbuf, &p, nil); err != nil {
		t.Fatal(err)
	}

	t.Log(rxm)

	buf2 := dns.NewWirebuf()
	rxm.Encode(buf2)
	hd(t, "reenc", buf2.Buf)
	for i, b := range rbuf {
		if b != buf2.Buf[i] {
			t.Logf("[%d] %x<>%x", i, b, buf2.Buf[i])
			hd(t, "rcv", rbuf[:i])
			break
		}
	}

	compr := &Message{}
	p = 0
	if err = compr.Decode(buf2.Buf, &p, nil); err != nil {
		t.Fatal(err)
	}

	t.Log(compr)
}

func test0(t *testing.T, domain string, addr net.IP) {
	test0b(t, domain, addr, false)
	<-time.After(time.Second) // Throttle out server timeouts
}

func Test0(t *testing.T) {
	test0(t, "google.com.", net.ParseIP("8.8.8.8"))
	test0(t, "google.com.", net.ParseIP("8.8.4.4"))
}

func hd(t *testing.T, msg string, b []byte) {
	t.Logf("%s %d", msg, len(b))
	for y := 0; ; y += 16 {
		if y >= len(b) {
			return
		}
		s := b[y:]
		if len(s) > 16 {
			s = s[:16]
		}
		t.Logf("%04x: % x", y, s)
	}
}

func TestExchange1(t *testing.T) {
	m := &Message{}
	m.Header.ID = GenID()
	m.Question.A("localhost", rr.CLASS_IN)
	ch := make(ExchangeChan, 10)
	addr, err := net.ResolveUDPAddr("udp", "127.0.0.1:7")
	if err != nil {
		t.Fatal(err)
	}

	c, err := net.DialUDP("udp", nil, addr)
	if err != nil {
		t.Fatal(10, err)
	}

	defer c.Close()

	c.SetDeadline(time.Now().Add(time.Millisecond))
	re := <-m.GoExchange(c, 2000, ch)
	if re.error == nil {
		t.Fatal(20)
	}

	t.Log(20, re.error)
}

func TestExchange2(t *testing.T) {
	m := &Message{}
	m.Header.ID = GenID()
	m.Question.NS("google.com", rr.CLASS_IN)
	ch := make(ExchangeChan, 10)
	addr, err := net.ResolveUDPAddr("udp", "8.8.8.8:53")
	if err != nil {
		t.Fatal(err)
	}

	c, err := net.DialUDP("udp", nil, addr)
	if err != nil {
		t.Fatal(10, err)
	}

	defer c.Close()

	c.SetDeadline(time.Now().Add(5 * time.Second))
	re := <-m.GoExchange(c, 2000, ch)
	if re.error != nil {
		t.Fatal(20, re.error)
	}

	t.Log(re.Message)
}

func TestExchange3(t *testing.T) {
	m := &Message{}
	m.Header.ID = GenID()
	m.Question.STAR("google.com", rr.CLASS_IN)
	m.RD = true
	m2 := &Message{}
	m2.Header.ID = GenID()
	m2.Question.STAR("google.cz", rr.CLASS_IN)
	m2.RD = true
	addr, err := net.ResolveUDPAddr("udp", "8.8.8.8:53")
	if err != nil {
		t.Fatal(err)
	}

	c, err := net.DialUDP("udp", nil, addr)
	if err != nil {
		t.Fatal(err)
	}

	defer c.Close()
	addr, err = net.ResolveUDPAddr("udp", "8.8.4.4:53")
	if err != nil {
		t.Error(err)
		return
	}

	c.SetDeadline(time.Now().Add(5 * time.Second))
	c2, err := net.DialUDP("udp", nil, addr)
	if err != nil {
		t.Error(err)
		return
	}

	defer c2.Close()
	c2.SetDeadline(time.Now().Add(5 * time.Second))
	ch := m.GoExchange(c, 2000, m2.GoExchange(c2, 2000, nil))

	re := <-ch
	if re.error != nil {
		t.Error(re.error)
		return
	}

	t.Log(re.Message)

	re = <-ch
	if re.error != nil {
		t.Error(40, re.error)
		return
	}

	t.Log(re.Message)
}
