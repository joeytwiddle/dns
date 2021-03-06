%{
// Copyright (c) 2011 CZ.NIC z.s.p.o. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// blame: jnml, labs.nic.cz


// WARNING: If this file is parser.go then DO NOT EDIT.
// parser.go is generated by goyacc from parser.y (see the Makefile).


package resolv


import (
	"fmt"
	"net"
)

%}


%union {
	ip    net.IP
	num   uint
	str   string
	list  []string
	mask  SortlistItem
}


%token
	tDOMAIN
	tNAMESERVER
	tOPTIONS
	tSEARCH
	tSORTLIST
	tATTEMPTS
	tDEBUG
	tEDNS0
	tINET6
	tIP6_BYTESTRING
	tIP6_DOTINT
	tNDOTS
	tNO_CHECK_NAMES
	tNO_IP6_DOTINT
	tROTATE
	tTIMEOUT


%token  <ip>    tIP_ADDRESS
%token  <num>   tDECADIC
%token  <str>   tDOMAIN_NAME
%type   <mask>  ipmask


%%


goal:
|	goal line


ipmask:
	tIP_ADDRESS
	{
		$$.Addr = $1
	}
|	tIP_ADDRESS '/' tIP_ADDRESS
	{
		$$.Addr, $$.NetMask = $1, $3
	}


line:
	'\n'
	{
		yylex.begin(sc_LINE_START)
	}
|	tNAMESERVER
	{
		yylex.begin(sc_IP)
	}
	' ' tIP_ADDRESS
	{
		yylex.resolv.AppendNameserver($4)
	}
|	tSEARCH
	{
		yylex.begin(sc_DOMAIN)
	}
	searchlist
|	tDOMAIN
	{
		yylex.begin(sc_DOMAIN)
	}
	' ' tDOMAIN_NAME
	{
		r := yylex.resolv
		if r.Domain != "" {
			panic(fmt.Errorf("domain %q already defined", r.Domain))
		}

		r.Domain = $4
	}
|	tSORTLIST
	{
		yylex.begin(sc_IP)
	}
	sortlist
|	tOPTIONS
	{
		yylex.begin(sc_OPTS)
	}
	options


option:
	tDEBUG
	{
		yylex.resolv.Opt.Debug = true
	}
|	tROTATE
	{
		yylex.resolv.Opt.Rotate = true
	}
|	tNO_CHECK_NAMES
	{
		yylex.resolv.Opt.NoCheckNames = true
	}
|	tINET6
	{
		yylex.resolv.Opt.Inet6 = true
	}
|	tIP6_BYTESTRING
	{
		yylex.resolv.Opt.Ip6ByteString = true
	}
|	tIP6_DOTINT
	{
		yylex.resolv.Opt.Ip6Dotint = true
	}
|	tNO_IP6_DOTINT
	{
		yylex.resolv.Opt.Ip6Dotint = false
	}
|	tEDNS0
	{
		yylex.resolv.Opt.Edns0 = true
	}
|	tNDOTS ':' tDECADIC
	{
		yylex.resolv.Opt.Ndots = $3
	}
|	tTIMEOUT ':' tDECADIC
	{
		yylex.resolv.Opt.TimeoutSecs = $3
	}
|	tATTEMPTS ':' tDECADIC
	{
		yylex.resolv.Opt.Attempts = $3
	}


options:
	' ' option
|	options ' ' option



searchlist:
	' ' tDOMAIN_NAME
	{
		yylex.resolv.appendSearch($2)
	}
|	searchlist ' ' tDOMAIN_NAME
	{
		yylex.resolv.appendSearch($3)
	}


sortlist:
	' ' ipmask
	{
		yylex.resolv.appendSortlist($2.Addr, $2.NetMask)
	}
|	sortlist ' ' ipmask
	{
		yylex.resolv.appendSortlist($3.Addr, $3.NetMask)
	}
