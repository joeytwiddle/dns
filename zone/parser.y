%{
// Copyright (c) 2011 CZ.NIC z.s.p.o. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// blame: jnml, labs.nic.cz


// WARNING: If this file is parser.go then DO NOT EDIT.
// parser.go is generated by goyacc from parser.y (see the Makefile).


package zone


import (
	"cznic/dns"
	"cznic/dns/rr"
	"cznic/strutil"
	"fmt"
	"math"
	"net"
)

type rrHead struct{
	ttl   int32
	class rr.Class
}

%}

%union{
	alg    rr.AlgorithmType
	class  rr.Class
	data   []byte
	str    string
	u64    uint64
	int    int
	float  float64
	uint   uint
	ip     net.IP
	rrh    rrHead
	rrData dns.Wirer
	rr     *rr.RR
	typ    rr.Type
	types  []rr.Type
}


%token
	tA
	tA6
	tAAAA
	tAFSDB
	tAPL
	tATMA
	tBACKSLASH_HASH
	tBLANK_START
	tCDS
	tCERT
	tCNAME
	tDHCID
	tDLR_TTL
	tDNAME
	tDNSKEY
	tDNS_PORT
	tDS
	tEID
	tGID
	tGPOS
	tHINFO
	tHIP
	tIPSECKEY
	tISDN
	tKEY
	tKX
	tLOC
	tMB
	tMD
	tMF
	tMG
	tMINFO
	tMR
	tMX
	tNAPTR
	tNIMLOC
	tNINFO
	tNS
	tNSAP
	tNSAP_PTR
	tNSEC
	tNSEC3
	tNSEC3PARAM
	tNULL
	tNXT
	tPTR
	tPX
	tRKEY
	tRP
	tRRSIG
	tRT
	tSIG
	tSMTP_PORT
	tSOA
	tSPF
	tSRV
	tSSHFP
	tTALINK
	tTCP_PROTO
	tTKEY
	tTSIG
	tTXT
	tUDP_PROTO
	tUID
	tUINFO
	tUNSPEC
	tWKS
	tX25

	tTYPE_X

	tTCP_PROTO
	tUDP_PROTO
	tSMTP_PORT
	tDNS_PORT

%token <data>
	tHEX
	t0xHEX

%token <str>
	tBASE32EXT
	tBASE64
	tDOMAIN_NAME
	tSRV_DOMAIN
	tQSTR

%token	<float>
	tFLOAT

%token <class>
	tCLASS

%token <ip>
	tIPV4
	tIPV6

%token <u64>
	tDECADIC

%type <alg>
	alg

%type <data>
	base32ext
	base64
	hex
	wks_ports

%type <int>
	ttl
	uint31
	loc_NS
	loc_EW
	loc_alt_sgn

%type <rrData>
	a
	aaaa
	afsdb
	cert
	cname
	dname
	dnskey
	ds
	gpos
	hinfo
	ipseckey
	ipseckey_0
	isdn
	key
	kx
	loc
	mb
	md
	mf
	mg
	minfo
	mr
	mx
	naptr
	ns
	nsap
	nsap_ptr
	nsec
	nsec3
	nsec3param
	null
	null_1
	ptr
	px
	rp
	rrsig
	rt
	sig
	soa
	srv
	sshfp
	txt
	wks
	x25

%type <rr>
	rr
	srv_rr
	rr2
	srv_rr2

%type <rrh>
	rrHead

%type <str>
	base64str
	txt2

%type <typ>
	rrtype
	rrtypetok

%type <types>
	rrtypes

%type <u64>
	dtg
	loc_lat_dms
	loc_lon_dms
	loc_ms
	loc_s
	loc_ts
	loc_alt
	loc_alt_frac
	loc_prec_frac
	loc_prec

%type <uint>
	dtg32
	uint8
	uint16
	uint32
	loc_s_h_v
	loc_h_v
	loc_v
	tTYPE_X

%%

goal:
	line
|	goal line


a:
 	tA
 	{
		yylex.begin(sc_IPV4)
	}
	tIPV4
	{
		$$ = &rr.A{$3}
	}


aaaa:
 	tAAAA
 	{
		yylex.begin(sc_IPV6)
	}
	tIPV6
	{
		$$ = &rr.AAAA{$3}
	}


afsdb:
	tAFSDB
	{
		yylex.begin(sc_NUM)
	}
	uint16
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.AFSDB{uint16($3), $5}
	}


alg:
	uint8
	{
		$$ = rr.AlgorithmType($1)
	}


base32ext:
	{
		yylex.begin(sc_BASE32EXT)
	}
	tBASE32EXT
	{
		yylex.begin(sc_INITIAL)
		if data, err := strutil.Base32ExtDecode([]byte($2)); err != nil {
			yylex.Error(err.Error())
		} else {
			$$ = data
		}
	}


base64:
	base64str '\n'
	{
		yylex.begin(sc_INITIAL)
		if data, err := strutil.Base64Decode([]byte($1)); err != nil {
			yylex.Error(err.Error())
		} else {
			$$ = data
		}
	}


base64str:
	{
		yylex.begin(sc_BASE64)
	}
	tBASE64
	{
		$$ = $2
	}
|	base64str tBASE64
	{
		$$ += $2
	}


cert:
	tCERT
	{
		yylex.begin(sc_NUM)
	}
	uint16 uint16 alg base64
	{
		$$ = &rr.CERT{rr.CertType($3), uint16($4), $5, $6}
	}


cname:
	tCNAME
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.CNAME{$3}
	}


dname:
	tDNAME
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.DNAME{$3}
	}


dnskey:
	tDNSKEY uint16 uint8 alg
	{
		if $3 != 3 {
			yylex.Error(`protocol must be "3"`)
		}
	}
	base64
	{
		$$ = &rr.DNSKEY{uint16($2), byte($3), $4, $6}
	}


ds:
	tDS
	{
		yylex.begin(sc_NUM)
	}
	uint16 uint8 uint8 hex
	{
		if $5 != 1 || len($6) != 20 {
			yylex.Error(`digest type must be "1" and digest must be exactly 20 bytes (40 hex chars)`)
		} else {
			$$ = &rr.DS{uint16($3), rr.AlgorithmType($4), rr.HashAlgorithm($5), $6}
		}
	}


dtg:
	tDECADIC
	{
		if t, err := dns.String2Seconds($<str>1); err != nil {
			yylex.Error(err.Error())
		} else {
			$$ = uint64(t)
		}
	}


dtg32:
	dtg
	{
		$$ = uint($1)
	}


hex:
	{
		yylex.begin(sc_HEX)
	}
	tHEX
	{
		$$ = $2
	}


ipseckey_0:
	tIPSECKEY
	{
		yylex.begin(sc_NUM)
	}
	uint8 uint8 uint8
	{
		x := &rr.IPSECKEY{Precedence: byte($3), GatewayType: rr.GatewayType($4), Algorithm: rr.IPSECKEYAlgorithm($5)}
		$$ = x
		switch x.GatewayType {
		default:
			yylex.Error("Unknown gateway type")
		case rr.GatewayNone, rr.GatewayIPV4, rr.GatewayIPV6, rr.GatewayDomain:
			// OK
		}

		switch x.Algorithm {
		default:
			yylex.Error("Unknown algorithm")
		case rr.IPSECKEYAlgorithmDSA, rr.IPSECKEYAlgorithmRSA:
			// OK
		}

		yylex.begin(sc_IPSSECKEY)
	}

ipseckey:
	ipseckey_0 '.' base64
	{
		x := $1.(*rr.IPSECKEY)
		x.PublicKey = $3
		$$ = x
		switch x.GatewayType {
		case rr.GatewayNone:
			// OK
		case rr.GatewayIPV4:
			yylex.Error("missing gateway IPv4 address")
		case rr.GatewayIPV6:
			yylex.Error("missing gateway IPv6 address")
		case rr.GatewayDomain:
			yylex.Error("missing gateway <domain-name>")
		}
	}
|	ipseckey_0 tIPV4 base64
	{
		x := $1.(*rr.IPSECKEY)
		x.Gateway = $2
		x.PublicKey = $3
		$$ = x
		if x.GatewayType != rr.GatewayIPV4 {
			yylex.Error("expected IPv4 gateway")
		}
	}
|	ipseckey_0 tIPV6 base64
	{
		x := $1.(*rr.IPSECKEY)
		x.Gateway = $2
		x.PublicKey = $3
		$$ = x
		if x.GatewayType != rr.GatewayIPV6 {
			yylex.Error("expected IPv6 gateway")
		}
	}
|	ipseckey_0 tDOMAIN_NAME base64
	{
		x := $1.(*rr.IPSECKEY)
		x.Gateway = $2
		x.PublicKey = $3
		$$ = x
		if x.GatewayType != rr.GatewayDomain {
	println($2)
			yylex.Error("expected <domain-name> gateway")
		}
	}

key:
	tKEY uint16 uint8 alg
	{
		if $3 != 3 {
			yylex.Error(`protocol must be "3"`)
		}
	}
	base64
	{
		$$ = &rr.KEY{uint16($2), byte($3), $4, $6}
	}


kx:
	tKX
	{
		yylex.begin(sc_NUM)
	}
	uint16
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.KX{uint16($3), $5}
	}


line:
	'\n'
	{
		yylex.begin(sc_INITIAL)
	}
|	tDLR_TTL
	{
		yylex.begin(sc_NUM)
	}
	ttl
|	tDOMAIN_NAME
	{
		yylex.begin(sc_RRHEAD)
	}
	rr
	{
		$3.Name = $1
		if !yylex.rrHandler($3) {
			goto ret0
		}
	}
|	tSRV_DOMAIN
	{
		yylex.begin(sc_RRHEAD)
	}
	srv_rr
	{
		$3.Name = $1
		if !yylex.rrHandler($3) {
			goto ret0
		}
	}
|	tBLANK_START rr
	{
		if !yylex.rrHandler($2) {
			goto ret0
		}
	}
|	'@' rr
	{
		$2.Name = "@"
		if !yylex.rrHandler($2) {
			goto ret0
		}
	}

loc:
	tLOC loc_lat_dms loc_lon_dms loc_alt loc_s_h_v
	{
		$$ = &rr.LOC{0, byte($5>>16), byte($5>>8), byte($5), uint32($2), uint32($3), uint32($4)}
	}

loc_s_h_v:
	{
		$$ = uint((*rr.LOC)(nil).EncPrec(100))<<16|uint((*rr.LOC)(nil).EncPrec(1000000))<<8|uint((*rr.LOC)(nil).EncPrec(1000))

	}
|	loc_prec loc_h_v
	{
		$$ = uint((*rr.LOC)(nil).EncPrec($1))<<16|$2
	}

loc_h_v:
	{
		$$ = uint((*rr.LOC)(nil).EncPrec(1000000))<<8|uint((*rr.LOC)(nil).EncPrec(1000))
	}
|	loc_prec loc_v
	{
		$$ = uint((*rr.LOC)(nil).EncPrec($1))<<8|$2
	}

loc_v:
	{
		$$ = uint((*rr.LOC)(nil).EncPrec(1000))
	}
|	loc_prec
	{
		$$ = uint((*rr.LOC)(nil).EncPrec($1))
	}

loc_prec:
	tDECADIC loc_prec_frac loc_optM
	{
		$$ = 100*$1+$2
	}

loc_prec_frac:
	{
		$$ = 0
	}
|	'.' uint8
	{
		for $$ = uint64($2); $$ != 0 && $$ < 10; $$ *= 10 {}
	}

loc_alt:
	loc_alt_sgn uint31 loc_alt_frac loc_optM
	{
		x := (int64($3)+100*int64($2))*int64($1)
		$$ = uint64(x+10000000)
	}

loc_optM:
|	'm'


loc_alt_frac:
	{
		$$ = 0
	}
|	'.' uint8
	{
		for $$ = uint64($2); $$ != 0 && $$ < 10; $$ *= 10 {}
	}

loc_alt_sgn:
	{
		$$ = 1
	}
|	'+'
	{
		$$ = 1
	}
|	'-'
	{
		$$ = -1
	}

loc_lat_dms:
	{
		yylex.begin(sc_NUM)
	}
	uint8 loc_ms loc_NS
	{
		ts := $3 % 60000
		m := ($3/60000)%60
		$$ = uint64((*rr.LOC)(nil).EncDMTS(int($2), int(m), int(ts), $4 != 0))
	}

loc_lon_dms:
	{
		yylex.begin(sc_NUM)
	}
	uint8 loc_ms loc_EW
	{
		ts := $3 % 60000
		m := ($3/60000)%60
		$$ = uint64((*rr.LOC)(nil).EncDMTS(int($2), int(m), int(ts), $4 != 0))
	}

loc_NS:
	'N'
	{
		$$ = 1
	}
|	'S'
	{
		$$ = 0
	}


loc_EW:
	'E'
	{
		$$ = 1
	}
|	'W'
	{
		$$ = 0
	}


loc_ms:
	{
		$$ = 0
	}
|	uint8 loc_s
	{
		$$ = 60000*uint64($1)+$2
	}

loc_s:
	{
		$$ = 0
	}
|	uint8 loc_ts
	{
		$$ = 1000*uint64($1)+$2
	}

loc_ts:
      	{
		$$ = 0
	}
|	'.' uint16
	{
		for $$ = uint64($2); $$ != 0 && $$ < 100; $$ *= 10 {}
	}

mb:
  	tMB
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.MB{$3}
	}


md:
  	tMD
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.MD{$3}
	}


mf:
  	tMF
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.MF{$3}
	}


mg:
  	tMG
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.MG{$3}
	}


minfo:
	tMINFO
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME tDOMAIN_NAME
	{
		$$ = &rr.MINFO{$3, $4}
	}


mr:
  	tMR
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.MR{$3}
	}


mx:
	tMX
	{
		yylex.begin(sc_NUM)
	}
	uint16
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.MX{uint16($3), $5}
	}


naptr:
	tNAPTR
	{
		yylex.begin(sc_NUM)
	}
	uint16 uint16 tQSTR tQSTR tQSTR
	{
		yylex.begin(sc_ANY_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.NAPTR{uint16($3), uint16($4), $5, $6, $7, $9}
	}


ns:
  	tNS
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.NS{$3}
	}

nsap:
  	tNSAP
	{
		yylex.begin(sc_0XHEX)
	}
	t0xHEX
	{
		$$ = &rr.NSAP{$3}
	}

nsap_ptr:
	tNSAP_PTR
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.NSAP_PTR{$3}
	}



nsec:
	tNSEC
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		yylex.begin(sc_TYPE)
	}
	rrtypes
	{
		$$ = &rr.NSEC{$3, rr.TypesEncode($5)}
	}


nsec3:
	tNSEC3
	{
		yylex.begin(sc_NUM)
	}
	uint8 uint8 uint16 hex base32ext
	{
		yylex.begin(sc_TYPE)
	}
	rrtypes
	{
		$$ = &rr.NSEC3{rr.NSEC3PARAM{rr.HashAlgorithm($3), byte($4), uint16($5), $6}, $7, rr.TypesEncode($9)}
	}


nsec3param:
	tNSEC3PARAM
	{
		yylex.begin(sc_NUM)
	}
	uint8 uint8 uint16 hex
	{
		$$ = &rr.NSEC3PARAM{rr.HashAlgorithm($3), byte($4), uint16($5), $6}
	}


null:
    	tNULL
	{
		yylex.begin(sc_NUM)
	}
	null_1
	{
		$$ = $3
	}

null_1:
	tBACKSLASH_HASH uint16 hex
	{
		if int($2) != len($3) {
			yylex.Error(fmt.Sprintf("mismatched data len: %d != %d", $2, len($3)))
		}
		$$ = &rr.NULL{$3}
	}
|	tBACKSLASH_HASH
	{
		$$ = &rr.NULL{[]byte{}}
	}


ptr:
   	tPTR
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.PTR{$3}
	}


px:
	tPX
	{
		yylex.begin(sc_NUM)
	}
	uint16
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME tDOMAIN_NAME
	{
		$$ = &rr.PX{uint16($3), $5, $6}
	}


rp:
	tRP
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME tDOMAIN_NAME
	{
		$$ = &rr.RP{$3, $4}
	}


srv_rr:
	{
		yylex.begin(sc_RRHEAD)
	}
	srv_rr2
	{
		$$ = $2
	}


srv_rr2:
	rrHead srv
	{
		$$ = &rr.RR{"", rr.TYPE_SRV, $1.class, $1.ttl, $2}
	}

rr:
	{
		yylex.begin(sc_RRHEAD)
	}
	rr2
	{
		$$ = $2
	}


rr2:
	rrHead a
	{
		$$ = &rr.RR{"", rr.TYPE_A, $1.class, $1.ttl, $2}
	}
|	rrHead aaaa
	{
		$$ = &rr.RR{"", rr.TYPE_AAAA, $1.class, $1.ttl, $2}
	}
|	rrHead afsdb
	{
		$$ = &rr.RR{"", rr.TYPE_AFSDB, $1.class, $1.ttl, $2}
	}
|	rrHead cert
	{
		$$ = &rr.RR{"", rr.TYPE_CERT, $1.class, $1.ttl, $2}
	}
|	rrHead cname
	{
		$$ = &rr.RR{"", rr.TYPE_CNAME, $1.class, $1.ttl, $2}
	}
|	rrHead dname
	{
		$$ = &rr.RR{"", rr.TYPE_DNAME, $1.class, $1.ttl, $2}
	}
|	rrHead dnskey
	{
		$$ = &rr.RR{"", rr.TYPE_DNSKEY, $1.class, $1.ttl, $2}
	}
|	rrHead ds
	{
		$$ = &rr.RR{"", rr.TYPE_DS, $1.class, $1.ttl, $2}
	}
|	rrHead ipseckey
	{
		$$ = &rr.RR{"", rr.TYPE_IPSECKEY, $1.class, $1.ttl, $2}
	}
|	rrHead key
	{
		$$ = &rr.RR{"", rr.TYPE_KEY, $1.class, $1.ttl, $2}
	}
|	rrHead kx
	{
		$$ = &rr.RR{"", rr.TYPE_KX, $1.class, $1.ttl, $2}
	}
|	rrHead loc
	{
		$$ = &rr.RR{"", rr.TYPE_LOC, $1.class, $1.ttl, $2}
	}

|	rrHead mb
	{
		$$ = &rr.RR{"", rr.TYPE_MB, $1.class, $1.ttl, $2}
	}
|	rrHead md
	{
		$$ = &rr.RR{"", rr.TYPE_MD, $1.class, $1.ttl, $2}
	}
|	rrHead mf
	{
		$$ = &rr.RR{"", rr.TYPE_MF, $1.class, $1.ttl, $2}
	}
|	rrHead mg
	{
		$$ = &rr.RR{"", rr.TYPE_MG, $1.class, $1.ttl, $2}
	}
|	rrHead minfo
	{
		$$ = &rr.RR{"", rr.TYPE_MINFO, $1.class, $1.ttl, $2}
	}
|	rrHead mr
	{
		$$ = &rr.RR{"", rr.TYPE_MR, $1.class, $1.ttl, $2}
	}
|	rrHead mx
	{
		$$ = &rr.RR{"", rr.TYPE_MX, $1.class, $1.ttl, $2}
	}
|	rrHead naptr
	{
		$$ = &rr.RR{"", rr.TYPE_NAPTR, $1.class, $1.ttl, $2}
	}
|	rrHead ns
	{
		$$ = &rr.RR{"", rr.TYPE_NS, $1.class, $1.ttl, $2}
	}
|	rrHead nsap
	{
		$$ = &rr.RR{"", rr.TYPE_NSAP, $1.class, $1.ttl, $2}
	}
|	rrHead nsap_ptr
	{
		$$ = &rr.RR{"", rr.TYPE_NSAP_PTR, $1.class, $1.ttl, $2}
	}
|	rrHead nsec
	{
		$$ = &rr.RR{"", rr.TYPE_NSEC, $1.class, $1.ttl, $2}
	}
|	rrHead nsec3
	{
		$$ = &rr.RR{"", rr.TYPE_NSEC3, $1.class, $1.ttl, $2}
	}
|	rrHead nsec3param
	{
		$$ = &rr.RR{"", rr.TYPE_NSEC3PARAM, $1.class, $1.ttl, $2}
	}
|	rrHead null
	{
		$$ = &rr.RR{"", rr.TYPE_NULL, $1.class, $1.ttl, $2}
	}
|	rrHead ptr
	{
		$$ = &rr.RR{"", rr.TYPE_PTR, $1.class, $1.ttl, $2}
	}
|	rrHead px
	{
		$$ = &rr.RR{"", rr.TYPE_PX, $1.class, $1.ttl, $2}
	}
|	rrHead rp
	{
		$$ = &rr.RR{"", rr.TYPE_RP, $1.class, $1.ttl, $2}
	}
|	rrHead rrsig
	{
		$$ = &rr.RR{"", rr.TYPE_RRSIG, $1.class, $1.ttl, $2}
	}
|	rrHead rt
	{
		$$ = &rr.RR{"", rr.TYPE_RT, $1.class, $1.ttl, $2}
	}
|	rrHead sig
	{
		$$ = &rr.RR{"", rr.TYPE_SIG, $1.class, $1.ttl, $2}
	}
|	rrHead soa
	{
		$$ = &rr.RR{"", rr.TYPE_SOA, $1.class, $1.ttl, $2}
	}
|	rrHead sshfp
	{
		$$ = &rr.RR{"", rr.TYPE_SSHFP, $1.class, $1.ttl, $2}
	}
|	rrHead gpos
	{
		$$ = &rr.RR{"", rr.TYPE_GPOS, $1.class, $1.ttl, $2}
	}
|	rrHead hinfo
	{
		$$ = &rr.RR{"", rr.TYPE_HINFO, $1.class, $1.ttl, $2}
	}
|	rrHead isdn
	{
		$$ = &rr.RR{"", rr.TYPE_ISDN, $1.class, $1.ttl, $2}
	}
|	rrHead txt
	{
		$$ = &rr.RR{"", rr.TYPE_TXT, $1.class, $1.ttl, $2}
	}
|	rrHead wks
	{
		$$ = &rr.RR{"", rr.TYPE_WKS, $1.class, $1.ttl, $2}
	}
|	rrHead x25
	{
		$$ = &rr.RR{"", rr.TYPE_X25, $1.class, $1.ttl, $2}
	}


rrHead:
	ttl tCLASS
	{
		$$ = rrHead{int32($1), $2}
	}
|	tCLASS ttl
	{
		$$ = rrHead{int32($2), $1}
	}
|	ttl
	{
		$$ = rrHead{int32($1), 0}
	}
|	tCLASS
	{
		$$ = rrHead{-1, $1}
	}


rrsig:
	tRRSIG rrtype
	{
		yylex.begin(sc_NUM)
	}
	alg uint8 ttl dtg32 dtg32 uint16
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME base64
	{
		$$ = &rr.RRSIG{$2, $4, byte($5), int32($6), uint32($7), uint32($8), uint16($9), $11, $12}
	}


rrtype:
	{
		yylex.begin(sc_TYPE)
	}
	rrtypetok
	{
		$$ = $2
	}


rrtypes:
	'\n'
	{
		$$ = nil
		yylex.begin(sc_INITIAL)
	}
|	rrtype
	{
		$$ = []rr.Type{$1}
	}
|	rrtypes rrtype
	{
		$$ = append($$, $2)
	}


rrtypetok:
	tA
	{
		$$ = rr.TYPE_A
	}
|	tA6
	{
		$$ = rr.TYPE_A6
	}
|	tAAAA
	{
		$$ = rr.TYPE_AAAA
	}
|	tAFSDB
	{
		$$ = rr.TYPE_AFSDB
	}
|	tATMA
	{
		$$ = rr.TYPE_ATMA
	}
|	tAPL
	{
		$$ = rr.TYPE_APL
	}
|	tCDS
	{
		$$ = rr.TYPE_CDS
	}
|	tCERT
	{
		$$ = rr.TYPE_CERT
	}
|	tCNAME
	{
		$$ = rr.TYPE_CNAME
	}
|	tDHCID
	{
		$$ = rr.TYPE_DHCID
	}
|	tDNAME
	{
		$$ = rr.TYPE_DNAME
	}
|	tDNSKEY
	{
		$$ = rr.TYPE_DNSKEY
	}
|	tDS
	{
		$$ = rr.TYPE_DS
	}
|	tEID
	{
		$$ = rr.TYPE_EID
	}
|	tGID
	{
		$$ = rr.TYPE_GID
	}
|	tGPOS
	{
		$$ = rr.TYPE_GPOS
	}
|	tHINFO
	{
		$$ = rr.TYPE_HINFO
	}
|	tMINFO
	{
		$$ = rr.TYPE_MINFO
	}
|	tHIP
	{
		$$ = rr.TYPE_HIP
	}
|	tIPSECKEY
	{
		$$ = rr.TYPE_IPSECKEY
	}
|	tISDN
	{
		$$ = rr.TYPE_ISDN
	}
|	tKEY
	{
		$$ = rr.TYPE_KEY
	}
|	tKX
	{
		$$ = rr.TYPE_KX
	}
|	tLOC
	{
		$$ = rr.TYPE_LOC
	}
|	tMB
	{
		$$ = rr.TYPE_MB
	}
|	tMD
	{
		$$ = rr.TYPE_MD
	}
|	tMF
	{
		$$ = rr.TYPE_MF
	}
|	tMR
	{
		$$ = rr.TYPE_MR
	}
|	tMX
	{
		$$ = rr.TYPE_MX
	}
|	tNAPTR
	{
		$$ = rr.TYPE_NAPTR
	}
|	tNIMLOC
	{
		$$ = rr.TYPE_NIMLOC
	}
|	tNINFO
	{
		$$ = rr.TYPE_NINFO
	}
|	tNS
	{
		$$ = rr.TYPE_NS
	}
|	tNSAP
	{
		$$ = rr.TYPE_NSAP
	}
|	tNSAP_PTR
	{
		$$ = rr.TYPE_NSAP_PTR
	}
|	tNSEC
	{
		$$ = rr.TYPE_NSEC
	}
|	tNSEC3
	{
		$$ = rr.TYPE_NSEC3
	}
|	tNSEC3PARAM
	{
		$$ = rr.TYPE_NSEC3PARAM
	}
|	tNXT
	{
		$$ = rr.TYPE_NXT
	}
|	tNULL
	{
		$$ = rr.TYPE_NULL
	}
|	tPTR
	{
		$$ = rr.TYPE_PTR
	}
|	tPX
	{
		$$ = rr.TYPE_PX
	}
|	tRRSIG
	{
		$$ = rr.TYPE_RRSIG
	}
|	tRKEY
	{
		$$ = rr.TYPE_RKEY
	}
|	tRP
	{
		$$ = rr.TYPE_RP
	}
|	tRT
	{
		$$ = rr.TYPE_RT
	}
|	tSIG
	{
		$$ = rr.TYPE_SIG
	}
|	tSOA
	{
		$$ = rr.TYPE_SOA
	}
|	tSPF
	{
		$$ = rr.TYPE_SPF
	}
|	tSRV
	{
		$$ = rr.TYPE_SRV
	}
|	tSSHFP
	{
		$$ = rr.TYPE_SSHFP
	}
|	tTALINK
	{
		$$ = rr.TYPE_TALINK
	}
|	tTKEY
	{
		$$ = rr.TYPE_TKEY
	}
|	tTSIG
	{
		$$ = rr.TYPE_TSIG
	}
|	tTXT
	{
		$$ = rr.TYPE_TXT
	}
|	tUID
	{
		$$ = rr.TYPE_UID
	}
|	tUINFO
	{
		$$ = rr.TYPE_UINFO
	}
|	tUNSPEC
	{
		$$ = rr.TYPE_UNSPEC
	}
|	tWKS
	{
		$$ = rr.TYPE_WKS
	}
|	tX25
	{
		$$ = rr.TYPE_X25
	}
|	tTYPE_X
	{
		$$ = rr.Type($1)
	}


rt:
	tRT
	{
		yylex.begin(sc_NUM)
	}
	uint16
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.RT{uint16($3), $5}
	}


sig:
	tSIG rrtype
	{
		yylex.begin(sc_NUM)
	}
	alg uint8 ttl dtg32 dtg32 uint16
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME base64
	{
		$$ = &rr.SIG{$2, $4, byte($5), int32($6), uint32($7), uint32($8), uint16($9), $11, $12}
	}


soa:
	tSOA
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME tDOMAIN_NAME
	{
		yylex.begin(sc_NUM)
	}
	uint32 uint32 uint32 uint32 uint32 
	{
		$$ = &rr.SOA{$3, $4, uint32($6), uint32($7), uint32($8), uint32($9), uint32($10)}
	}


srv:
	tSRV
	{
		yylex.begin(sc_NUM)
	}
	uint16 uint16 uint16
	{
		yylex.begin(sc_DOMAIN)
	}
	tDOMAIN_NAME
	{
		$$ = &rr.SRV{uint16($3), uint16($4), uint16($5), $7}
	}

sshfp:
	tSSHFP
	{
		yylex.begin(sc_NUM)
	}
	uint8 uint8 hex
	{
		$$ = &rr.SSHFP{rr.SSHFPAlgorithm($3), rr.SSHFPType($4), $5}
	}


ttl:
	uint31


txt:
	tTXT txt2
	{
		$$ = &rr.TXT{$2}
	}

txt2:
	{
		$$ = ""
	}
|	txt2 tQSTR
	{
		$$ += $2
	}

gpos:
	tGPOS
	{
		yylex.begin(sc_FLOAT)
	}
	tFLOAT tFLOAT tFLOAT
	{
		$$ = &rr.GPOS{$3, $4, $5}
	}


hinfo:
	tHINFO tQSTR tQSTR
	{
		$$ = &rr.HINFO{$2, $3}
	}


isdn:
	tISDN tQSTR
	{
		$$ = &rr.ISDN{$2, ""}
	}
|	tISDN tQSTR tQSTR
	{
		$$ = &rr.ISDN{$2, $3}
	}


uint8:
	tDECADIC
	{
		if $1 > math.MaxUint8 {
			yylex.Error("number out of range")
			$$ = math.MaxUint8
		} else {
			$$ = uint($1)
		}
	}


uint16:
	tDECADIC
	{
		if $1 > math.MaxUint16 {
			yylex.Error("number out of range")
			$$ = math.MaxUint16
		} else {
			$$ = uint($1)
		}
	}


uint31:
	tDECADIC
	{
		if $1 > math.MaxInt32 {
			yylex.Error("number out of range")
			$$ = math.MaxInt32
		} else {
			$$ = int($1)
		}
	}


uint32:
	tDECADIC
	{
		if $1 > math.MaxUint32  {
			yylex.Error("number out of range")
			$$ = math.MaxUint32
		} else {
			$$ = uint($1)
		}
	}

wks:
    	tWKS
 	{
		yylex.begin(sc_IPV4)
	}
	tIPV4
	{
		yylex.begin(sc_PROTO)
	}
	wks_proto
	{
		yylex.begin(sc_PORT)
	}
	wks_ports
	{
		x := &rr.WKS{$3, rr.IP_Protocol($<int>5), map[rr.IP_Port]struct{}{}}
		for i, v := range $7 {
			for j := 8*i; v != 0; j, v = j+1, v>>1 {
				if v&1 != 0 {
					x.Ports[rr.IP_Port(j)] = struct{}{}
				}
			}
		}
		$$ = x
	}
	

wks_proto:
	tTCP_PROTO
|	tUDP_PROTO

wks_port:
	tSMTP_PORT
|	tDNS_PORT

wks_ports:
	{
		$$ = make([]byte, 128)
	}
|	wks_ports wks_port
	{
		i := rr.IP_Port($<int>2)
		$$[i>>3] |= 1<<uint(i&7)
	}

x25:
	tX25 tQSTR
	{
		$$ = &rr.X25{$2}
	}


