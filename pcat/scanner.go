// Copyright (c) 2011 CZ.NIC z.s.p.o. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// blame: jnml, labs.nic.cz

// WARNING: If this file is scanner.go then DO NOT EDIT.
// scanner.go is generated by golex from scanner.l (see the Makefile).

package pcat

import (
	"encoding/hex"
	"errors"
	"fmt"
	"strconv"
)

func (l *lex) scan() (r *Record, err error) {
	const (
		INITIAL = iota
		ID
		QUERY
		REPLY
	)
	var sc int
	c := l.current
	r = &Record{}

yystate0:

	l.buf = l.buf[:0]

	switch yyt := sc; yyt {
	default:
		panic(fmt.Errorf(`invalid start condition %d`, yyt))
	case 2: // start condition: QUERY
		goto yystart1
	case 3: // start condition: REPLY
		goto yystart5
	case 0: // start condition: INITIAL
		goto yystart8
	case 1: // start condition: ID
		goto yystart11
	}

	goto yystate1 // silence unused label error
yystate1:
	if c, err = l.getc(); err != nil {
		return
	}
yystart1:
	switch {
	default:
		goto yyabort
	case c == '\n':
		goto yystate2
	}

yystate2:
	if c, err = l.getc(); err != nil {
		return
	}
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate3
	}

yystate3:
	if c, err = l.getc(); err != nil {
		return
	}
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate4
	}

yystate4:
	if c, err = l.getc(); err != nil {
		return
	}
	switch {
	default:
		goto yyrule4
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate3
	}

	goto yystate5 // silence unused label error
yystate5:
	if c, err = l.getc(); err != nil {
		return
	}
yystart5:
	switch {
	default:
		goto yyabort
	case c == '\n':
		goto yystate6
	}

yystate6:
	if c, err = l.getc(); err != nil {
		return
	}
	switch {
	default:
		goto yyrule5
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate7
	}

yystate7:
	if c, err = l.getc(); err != nil {
		return
	}
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate6
	}

	goto yystate8 // silence unused label error
yystate8:
	if c, err = l.getc(); err != nil {
		return
	}
yystart8:
	switch {
	default:
		goto yyrule2
	case c == '\x00':
		goto yystate10
	case c == '\n':
		goto yystate9
	}

yystate9:
	if c, err = l.getc(); err != nil {
		return
	}
	switch {
	default:
		goto yyrule2
	case c == '\x00':
		goto yystate10
	case c == '\n':
		goto yystate9
	}

yystate10:
	if c, err = l.getc(); err != nil {
		return
	}
	goto yyrule1

	goto yystate11 // silence unused label error
yystate11:
	if c, err = l.getc(); err != nil {
		return
	}
yystart11:
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate12
	}

yystate12:
	if c, err = l.getc(); err != nil {
		return
	}
	switch {
	default:
		goto yyrule3
	case c >= '0' && c <= '9':
		goto yystate12
	}

yyrule1: // \n*\x00
	{

		return nil, nil
	}
yyrule2: // \n*
	{

		sc = ID
		goto yystate0
	}
yyrule3: // {DD}+
	{

		if r.Id, err = strconv.Atoi(string(l.buf)); err != nil {
			return
		}
		sc = QUERY
		goto yystate0
	}
yyrule4: // \n{HEX}+
	{

		if r.Query, err = hex.DecodeString(string(l.buf[1:])); err != nil {
			return
		}
		sc = REPLY
		goto yystate0
	}
yyrule5: // \n{HEX}*
	{

		r.Reply, err = hex.DecodeString(string(l.buf[1:]))
		return
	}
		panic("unreachable")

		goto yyabort // silence unused label error

yyabort: // no lexem recognized
	return nil, errors.New(fmt.Sprintf("Unexpected char %q", string(int(c))))
}
