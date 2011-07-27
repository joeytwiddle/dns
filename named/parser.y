%{
// Copyright (c) 2011 CZ.NIC z.s.p.o. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// blame: jnml, labs.nic.cz


// WARNING: If this file is parser.go then DO NOT EDIT.
// parser.go is generated by goyacc from parser.y (see the Makefile).


package named


import (
	"github.com/cznic/dns/rr"
	"github.com/cznic/strutil"
	"fmt"
	"io/ioutil"
	"math"
	"net"
	"strings"
)


func todo(msg string) {
	panic(fmt.Errorf("TODO:" + msg))
}


%}


%union {
	acl_name                   *AclName
	address_match_list         AddressMatchList
	address_match_list_element AddressMatchListElement
	alg                        SessionKeyAlg
	alg_list                   []SessionKeyAlg
	class                      ZoneClass
	data                       []byte
	dialup                     DialupOption
	dnskey                     *rr.DNSKEY
	dual_stack_server          DualStackServer
	dual_stack_server_list     []DualStackServer
	dual_stack_servers         DualStackServers
	exclude                    []string
	flag                       bool
	ip                         net.IP
	ip_and_opt_port            IPAndPort
	ip_port                    IPPort
	ips                        IPs
	listen_on                  ListenOn
	managedKey                 *ManagedKey
	managedKeys                []*ManagedKey
	masters                    Masters
	masters_item               Master
	masters_items              []Master
	order_spec                 OrderSpec
	order_specs                []OrderSpec
	ordering                   Ordering
	pip_port                   *IPPort
	port_list                  []uint16
	sizeSpec                   SizeSpec
	str                        string
	typ                        rr.Type
	u16                        uint16
	u64                        uint64
	wfi                        WarnFailIgnore
	zone                       *Zone
}


%token

	tCLASS_CHAOSNET
	tCLASS_HESOID
	tCLASS_INTERNET

	tA
	tAAAA
	tCNAME
	tDNSKEY
	tDS
	tHINFO
	tMB
	tMD
	tMF
	tMG
	tMINFO
	tMR
	tMX
	tNS
	tNSEC
	tNSEC3
	tNSEC3PARAM
	tNULL
	tPTR
	tRRSIG
	tSOA
	tTXT
	tWKS

	tACACHE_CLEANING_INTERVAL
	tACACHE_ENABLE
	tADD_FROM_AUTH
	tADD_FROM_CACHE
	tALLOW
	tALLOW_NOTIFY
	tALLOW_QUERY
	tALLOW_QUERY_CACHE
	tALLOW_QUERY_CACHE_ON
	tALLOW_QUERY_ON
	tALLOW_RECURSION
	tALLOW_RECURSION_ON
	tALLOW_UPDATE
	tALLOW_UPDATE_FWD
	tALLOW_V6_SYNTHESIS
	tALLOW_XFER
	tALSO_NOTIFY
	tALT_XFER_SRC
	tALT_XFER_SRCV6
	tANY
	tAUTH_NXDOMAIN
	tAUTO
	tAUTO_DNSSEC
	tAVOID_V4_UDP_PORTS
	tAVOID_V6_UDP_PORTS
	tBINDKEYS_FILE
	tBLACKHOLE
	tCHECK_DUP_RECS
	tCHECK_INTEGRITY
	tCHECK_MX
	tCHECK_MX_CNAME
	tCHECK_NAMES
	tCHECK_SIBLING
	tCHECK_SRV_CNAME
	tCHECK_WILDCARD
	tCLASS
	tCLEANING_INTERVAL
	tCLIENTS_PER_QUERY
	tCORESIZE
	tCREATE
	tCYCLIC
	tDATABASE
	tDATASIZE
	tDEALLOCATE_ON_EXIT
	tDEFAULT
	tDELEGATION_ONLY
	tDIALUP
	tDIRECTORY
	tDISABLE_ALGORITHMS
	tDISABLE_EMPTY_ZONE
	tDNSSEC_ACCEPT_EXPIRED
	tDNSSEC_DNSKEY_KSKONLY
	tDNSSEC_ENABLE
	tDNSSEC_LOOKASIDE
	tDNSSEC_MUST_BE_SECURE
	tDNSSEC_SECURE2INSECURE
	tDNSSEC_VALIDATION
	tDUAL_STACK_SERVERS
	tDUMP_FILE
	tEDNS_UDP_SIZE
	tEMPTY_CONTACT
	tEMPTY_SERVER
	tEMPTY_ZONES_ENABLE
	tEXCLUDE	
	tEXPLICIT
	tFAIL
	tFAKE_IQUERY
	tFALSE
	tFETCH_GLUE
	tFILE
	tFILES
	tFIRST
	tFIXED
	tFLUSH_ZONES_ON_SHUTDOWN
	tFORWARD
	tFORWARDERS
	tHAS_OLD_CLIENTS
	tHEARTBEAT_INTERVAL
	tHINT
	tHMAC_MD5
	tHMAC_SHA1
	tHMAC_SHA224
	tHMAC_SHA256
	tHMAC_SHA384
	tHMAC_SHA512
	tHOSTNAME
	tHOST_STATISTICS
	tHOST_STATISTICS_MAX
	tIGNORE
	tINCLUDE
	tINITIAL_KEY
	tINTERFACE_INTERVAL
	tIP
	tIXFR_BASE
	tIXFR_FROM_DIFFS
	tIXFR_TMP_FILE
	tJOURNAL
	tKEY
	tKEY_DIRECTORY
	tLAME_TTL
	tLISTEN_ON
	tLISTEN_ON_V6
	tLOCALHOST
	tLOCALNETS
	tMAINTAIN
	tMAINTAIN_IXFR_BASE
	tMANAGED_KEYS
	tMANY_ANSWERS
	tMASTER
	tMASTERS
	tMASTER_FILE_FORMAT
	tMASTER_ONLY
	tMATCH_MAPPED_ADDRESSES
	tMAX_ACACHE_SIZE
	tMAX_CACHE_SIZE
	tMAX_CACHE_TTL
	tMAX_CLIENTS_PER_QUERY
	tMAX_IXFR_LOG_SIZE
	tMAX_JOURNAL_SIZE
	tMAX_NCACHE_TTL
	tMAX_REFRESH_TIME
	tMAX_RETRY_TIME
	tMAX_UDP_SIZE
	tMAX_XFER_IDLE_IN
	tMAX_XFER_IDLE_OUT
	tMAX_XFER_TIME_IN
	tMAX_XFER_TIME_OUT
	tMEMSTATS
	tMEMSTATS_FILE
	tMINIMAL_RESPONSES
	tMIN_REFRESH_TIME
	tMIN_RETRY_TIME
	tMIN_ROOTS
	tMULTIPLE_CNAMES
	tMULTI_MASTER
	tNAME
	tNAMEX_XFER
	tNO
	tNONE
	tNOTIFY
	tNOTIFY_DELAY
	tNOTIFY_PASSIVE
	tNOTIFY_SOURCE
	tNOTIFY_SOURCE_V6
	tNOTIFY_TO_SOA
	tOFF
	tONE_ANSWER
	tONLY
	tOPTIONS
	tORDER
	tPASSIVE
	tPID_FILE
	tPORT
	tPREFERRED_GLUE
	tPROVIDE_IXFR
	tPUBKEY
	tQUERYLOG
	tQUERY_SRC
	tQUERY_SRC_V6
	tRANDOM
	tRANDOM_DEVICE
	tRANGE
	tRAW
	tRECURSING_FILE
	tRECURSION
	tRECURSIVE_CLIENTS
	tREFRESH
	tREQUEST_IXFR
	tRESERVED_SOCKETS
	tRESPONSE
	tRFC2308_TYPE1
	tROOT_DELEGATION_ONLY
	tRRSET_ORDER
	tSERIAL_QUERIES
	tSERIAL_QUERY_RATE
	tSERVER_ID
	tSESSION_KEYALG
	tSESSION_KEYFILE
	tSESSION_KEYNAME
	tSIG_SIGNING_NODES
	tSIG_SIGNING_SIGNATURES
	tSIG_SIGNING_TYPE
	tSIG_VALIDITY_INTERVAL
	tSLAVE
	tSORTLIST
	tSTACK_SIZE
	tSTATISTICS_INTERVAL
	tSTATS_FILE
	tTCP_CLIENTS
	tTCP_LISTEN_QUEUE
	tTEXT
	tTKEY_DHKEY
	tTKEY_DOMAIN
	tTOPOLOGY
	tTREAT_CR_AS_SPACE
	tTRUE
	tTRUST_ANCHOR
	tTRY_TCP_REFRESH
	tTYPE
	tUNLIMITED
	tUPDATE_CHECK_KSK
	tUPDATE_POLICY
	tUSE_ALT_XFER_SRC
	tUSE_ID_POOL
	tUSE_IXFR
	tVERSION
	tWARN
	tXFERS_IN
	tXFERS_OUT
	tXFERS_PER_NS
	tXFER_FMT
	tXFER_SOURCE
	tXFER_SOURCE_V6
	tYES
	tZERO_NO_SOA_TTL
	tZERO_NO_SOA_TTL_CACHE
	tZONE
	tZONE_STATS


%token <ip>  tIP
%token <str> tQSTR
%token <u64> tDECADIC

%type <acl_name>                   acl_name
%type <address_match_list>         address_match_list
%type <address_match_list_element> address_match_list_element, address_match_list_element, address_match_list_element2
%type <alg>                        alg
%type <alg_list>                   alg_list
%type <class>                      class
%type <data>                       base64
%type <dialup>                     dialup_option
%type <dnskey>                     dnskey
%type <dual_stack_server>          dual_stack_server
%type <dual_stack_server_list>     dual_stack_server_list
%type <dual_stack_servers>         dual_stack_servers
%type <exclude>                    exclude, excude_list
%type <flag>                       yes_or_no
%type <ip>                         ip
%type <ips>                        ips, forwarders
%type <ip_port>                    ip_port
%type <pip_port>                   port_and_portnum, port_and_portnum_opt
%type <ip_and_opt_port>                ip_and_opt_port
%type <listen_on>                  listen_on, listen_on_v6
%type <managedKey>                 managed_key
%type <managedKeys>                managed_keys
%type <masters>                    masters_body
%type <masters_item>               masters_item
%type <masters_items>              masters_items
%type <ordering>                   ordering
%type <order_spec>                 order_spec
%type <order_specs>                order_specs
%type <port_list>                  port_list, port_list_elem
%type <sizeSpec>                   size_spec
%type <str>                        domain_name, file, zone_name
%type <typ>                        type
%type <u16>                        uint16
%type <wfi>                        warn_fail_ignore
%type <zone>                       zone, zone_body, master_zone, hint_zone

%%


goal:
	statement
|	goal statement


acl_name:
	tANY
	{
		$$ = NewAclName(AclNameAny, "")
	}
|	tNONE
	{
		$$ = NewAclName(AclNameNone, "")
	}
|	tLOCALHOST
	{
		$$ = NewAclName(AclNameLocalhost, "")
	}
|	tLOCALNETS
	{
		$$ = NewAclName(AclNameLocalnets, "")
	}
|	domain_name
	{
		$$ = NewAclName(AclNameDomainName, $1)
	}


//address_match_list = address_match_list_element ; [ address_match_list_element; ... ]
address_match_list:
	address_match_list_element ';'
	{
		$$ = append($$, $1)
	}
|	address_match_list address_match_list_element ';'
	{
		$$ = append($$, $2)
	}


//address_match_list_element = [ ! ] (ip_address [/length] | key key_id | acl_name | { address_match_list } )
address_match_list_element:
	'!' address_match_list_element2
	{
		$$.Neg = true
	}
|	address_match_list_element2


alg:
	tHMAC_MD5
	{
		$$ = SessionKeyAlg_HMAC_MD5
	}
|	tHMAC_SHA1
	{
		$$ = SessionKeyAlg_HMAC_SHA1
	}
|	tHMAC_SHA224
	{
		$$ = SessionKeyAlg_HMAC_SHA224
	}
|	tHMAC_SHA256
	{
		$$ = SessionKeyAlg_HMAC_SHA256
	}
|	tHMAC_SHA384
	{
		$$ = SessionKeyAlg_HMAC_SHA384
	}
|	tHMAC_SHA512
	{
		$$ = SessionKeyAlg_HMAC_SHA512
	}


alg_list:
	alg ';'
	{
		$$ = []SessionKeyAlg{$1}
	}
|	alg_list alg ';'
	{
		$$ = append($$, $2)
	}


class:
	{
		$$ = ZoneClassInternet
	}
|	tCLASS_INTERNET
	{
		$$ = ZoneClassInternet
	}
|	tCLASS_HESOID
	{
		$$ = ZoneClassHesiod
	}
|	tCLASS_CHAOSNET
	{
		$$ = ZoneClassChaosnet
	}


// ip_address [/length] | key key_id | acl_name | { address_match_list }
address_match_list_element2:
	tIP '/' tDECADIC
	{
		todo("address_match_list_element2a")
	}
|	tIP
	{
		todo("address_match_list_element2b")
	}
|	tKEY key_id
	{
		todo("address_match_list_element2c")
	}
|	acl_name
	{
		$$.Item = $1
	}
|	'{' address_match_list '}'
	{
		todo("address_match_list_element2e")
	}


base64:
	tQSTR
	{
		if data, err := strutil.Base64Decode([]byte($1)); err != nil {
			panic(err)
		} else {
			$$ = data
		}
	}


dialup_option:
	tNO
	{
		$$ = DialupNo
	}
|	tYES
	{
		$$ = DialupYes
	}
|	tNOTIFY
	{
		$$ = DialupNotify
	}
|	tREFRESH
	{
		$$ = DialupRefresh
	}
|	tPASSIVE
	{
		$$ = DialupPassive
	}
|	tNOTIFY_PASSIVE
	{
		$$ = DialupNotifyPassive
	}


dnskey:
	tDECADIC tDECADIC tDECADIC base64 ';'
	{
		if $2 != 3 {
			panic(fmt.Errorf(`DNSKEY invalid protocol number "%d", must be "3"`, $2))
		}
		
		$$ = rr.NewDNSKEY(uint16($1), rr.AlgorithmType($3), $4)
	}


domain_name:
	tQSTR //TODO:validate


dual_stack_servers:
	port_and_portnum_opt '{' dual_stack_server_list '}'
	{
		$$ = DualStackServers{$1, $3}
	}


dual_stack_server_list:
	dual_stack_server ';'
	{
		$$ = []DualStackServer{$1}
	}
|	dual_stack_server_list dual_stack_server ';'
	{
		$$ = append($1, $2)
	}


dual_stack_server:
	domain_name port_and_portnum_opt
	{
		$$ = DualStackServer{$1, nil, $2}
	}
|	ip_and_opt_port
	{
		$$ = DualStackServer{"", $1.IP, $1.Port}
	}


exclude:
	{
		$$ = []string{}
	}
|	tEXCLUDE '{' excude_list '}'
	{
		$$ = $3
	}


excude_list:
	tQSTR ';'
	{
		$$ = []string{$1}
	}
|	excude_list tQSTR ';'
	{
		$$ = append($1, $2)
	}


file:
	tFILE tQSTR ';'
	{
		$$ = $2
	}


// forwarders { [ ip_addr [port ip_port] ; ... ] };
forwarders:
	tFORWARDERS '{' ips '}' ';'
	{
		$$ = $3
	}


ip:
	tIP
|	'*'
	{
		$$ = nil
	}


ips:
	{
		$$ = nil
	}
|	ips ip_and_opt_port ';'
	{
		$$ = append($$, $2)
	}


ip_port:
	tDECADIC
	{
		if $1 > math.MaxUint16 {
			panic(fmt.Errorf("invalid port number %d", $1))
		}
		$$ = IPPort($1)
	}


ip_and_opt_port:
	tIP port_and_portnum_opt
	{
		$$ = IPAndPort{$1, $2}
	}


key_id:
	domain_name


// listen-on [ port ip_port ] { address_match_list };
listen_on:
	tLISTEN_ON tPORT ip_port '{' address_match_list '}' ';'
	{
		$$ = ListenOn{NewIPPort($3), $5}
	}
|	tLISTEN_ON '{' address_match_list '}' ';'
	{
		$$ = ListenOn{nil, $3}
	}


// listen-on-v6 [ port ip_port ] { address_match_list };
listen_on_v6:
	tLISTEN_ON_V6 tPORT ip_port '{' address_match_list '}' ';'
	{
		$$ = ListenOn{NewIPPort($3), $5}
	}
|	tLISTEN_ON_V6 '{' address_match_list '}' ';'
	{
		$$ = ListenOn{nil, $3}
	}


managed_key:
	tQSTR tINITIAL_KEY dnskey
	{
		$$ = NewManagedKey($1, $3)
	}


managed_keys:
	managed_key
	{
		$$ = ManagedKeys{$1}
	}
|	managed_keys managed_key
	{
		$$ = append($$, $2)
	}



// masters name [port ip_port] { ( masters_list | ip_addr [port ip_port] [key key] ) ; [...] };
masters_body:
	tQSTR port_and_portnum_opt '{' masters_items '}'
	{
		$$ = Masters{$1, $2, $4}
	}


masters_item:
	tQSTR ';'
	{
		$$ = Master{Include: $1}
	}
|	ip_and_opt_port ';'
	{
		$$ = Master{IPAndPort: $1}
	}
|	ip_and_opt_port tKEY tQSTR ';'
	{
		$$ = Master{IPAndPort: $1, Key: $3}
	}



masters_items:
	masters_item
	{
		$$ = []Master{$1}
	}
|	masters_items masters_item
	{
		$$ = append($1, $2)
	}


option:
	tACACHE_CLEANING_INTERVAL tDECADIC ';'
	{
		yylex.conf.Options.ACacheCleaningInterval = int($2)
	}
|	tACACHE_ENABLE yes_or_no ';'
	{
		yylex.conf.Options.ACacheEnable = $2
	}
|	tADD_FROM_AUTH yes_or_no ';'
	{
		yylex.conf.Options.AdditionalFromAuth = $2
	}
|	tADD_FROM_CACHE yes_or_no ';'
	{
		yylex.conf.Options.AdditionalFromCache = $2
	}
|	tALLOW_NOTIFY '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowNotify = $3
	}
|	tALLOW_QUERY '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowQuery = $3
	}
|	tALLOW_QUERY_CACHE '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowQueryCache = $3
	}
|	tALLOW_QUERY_CACHE_ON '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowQueryCacheOn = $3
	}
|	tALLOW_RECURSION '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowRecursion = $3
	}
|	tALLOW_RECURSION_ON '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowRecursionOn = $3
	}
|	tALLOW_QUERY_ON '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowQueryOn = $3
	}
|	tALLOW_UPDATE '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowUpdate = $3
	}
|	tALLOW_UPDATE_FWD '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowUpdateForwarding = $3
	}
|	tALLOW_V6_SYNTHESIS '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowV6Synthesis = $3
	}
|	tALLOW_XFER '{' address_match_list '}' ';'
	{
		yylex.conf.Options.AllowTransfer = $3
	}
|	tALSO_NOTIFY '{' ip_and_opt_port ';' ips '}' ';'
	{
		yylex.conf.Options.AlsoNotify = append(IPs{$3}, $5...)
	}
|	tALT_XFER_SRC ip port_and_portnum_opt ';'
	{
		ip := $2
		if ip != nil && ip.To4() == nil {
			yylex.Error(fmt.Sprintf("invalid IP address %q", ip))
		}
		yylex.conf.Options.AltTransferSource = &IPAndPort{ip, $3}
	}
|	tALT_XFER_SRCV6 ip port_and_portnum_opt ';'
	{
		ip := $2
		if ip != nil && ip.To16() == nil {
			yylex.Error(fmt.Sprintf("invalid IP address %q", ip))
		}
		yylex.conf.Options.AltTransferSourceV6 = &IPAndPort{ip, $3}
	}
|	tAUTH_NXDOMAIN yes_or_no ';'
	{
		yylex.conf.Options.AuthNXDomain = $2
	}	  
|	tAVOID_V4_UDP_PORTS '{' port_list '}' ';'
	{
		yylex.conf.Options.AvoidV4UdpPorts = $3
	}
|	tAVOID_V6_UDP_PORTS '{' port_list '}' ';'
	{
		yylex.conf.Options.AvoidV6UdpPorts = $3
	}
|	tBINDKEYS_FILE tQSTR ';'
	{
		yylex.conf.Options.BindKeysFile = $2
	}
|	tBLACKHOLE '{' address_match_list '}' ';'
	{
		yylex.conf.Options.Blackhole = $3
	}
|	tCHECK_DUP_RECS warn_fail_ignore ';'
	{
		yylex.conf.Options.CheckDupRecs = $2
	}
|	tCHECK_INTEGRITY yes_or_no ';'
	{
		yylex.conf.Options.CheckIntegrity = $2
	}
|	tCHECK_MX warn_fail_ignore ';'
	{
		yylex.conf.Options.CheckMx = $2
	}
|	tCHECK_MX_CNAME warn_fail_ignore ';'
	{
		yylex.conf.Options.CheckMxCname = $2
	}
|	tCHECK_NAMES tMASTER warn_fail_ignore ';'
	{
		yylex.conf.Options.CheckNamesMaster = $3
	}
|	tCHECK_NAMES tSLAVE warn_fail_ignore ';'
	{
		yylex.conf.Options.CheckNamesSlave = $3
	}
|	tCHECK_NAMES tRESPONSE warn_fail_ignore ';'
	{
		yylex.conf.Options.CheckNamesResponse = $3
	}
|	tCHECK_SIBLING yes_or_no ';'
	{
		yylex.conf.Options.CheckSibling = $2
	}
|	tCHECK_SRV_CNAME warn_fail_ignore ';'
	{
		yylex.conf.Options.CheckSrvCname = $2
	}
|	tCHECK_WILDCARD yes_or_no ';'
	{
		yylex.conf.Options.CheckWildcard = $2
	}
|	tCLEANING_INTERVAL tDECADIC ';'
	{
		yylex.conf.Options.CleaningInterval = int($2)
	}
|	tCLIENTS_PER_QUERY tDECADIC ';'
	{
		yylex.conf.Options.ClientsPerQuery = int($2)
	}
|	tCORESIZE size_spec ';'
	{
		yylex.conf.Options.Coresize = $2
	}
|	tDATASIZE size_spec ';'
	{
		yylex.conf.Options.Datasize = $2
	}
|	tDEALLOCATE_ON_EXIT yes_or_no ';'
	{
		yylex.conf.Options.DeallocateOnExit = $2
	}
|	tDIALUP dialup_option ';'
	{
		yylex.conf.Options.Dialup = $2
	}
|	tDIRECTORY tQSTR ';'
	{
		yylex.conf.Options.Directory = $2
	}
|	tDISABLE_ALGORITHMS domain_name '{' alg_list '}' ';'
	{
		yylex.conf.Options.DisableAlgorithms = append(yylex.conf.Options.DisableAlgorithms, DisabledAlgorithms{$2, $4})
	}
|	tDISABLE_EMPTY_ZONE domain_name ';'
	{
		yylex.conf.Options.DisableEmptyZone = append(yylex.conf.Options.DisableEmptyZone, $2)
	}
|	tDNSSEC_ACCEPT_EXPIRED yes_or_no ';'
	{
		yylex.conf.Options.DNSSecAcceptExpired = $2
	}
|	tDNSSEC_DNSKEY_KSKONLY yes_or_no ';'
	{
		yylex.conf.Options.DNSSecDnsKeyKskOnly = $2
	}
|	tDNSSEC_ENABLE yes_or_no ';'
	{
		yylex.conf.Options.DNSSecEnable = $2
	}
|	tDNSSEC_LOOKASIDE tAUTO ';'
	{
		yylex.conf.Options.DNSSecLookaside = append(yylex.conf.Options.DNSSecLookaside, DNSSecDelegation{})
	}
|	tDNSSEC_LOOKASIDE domain_name tTRUST_ANCHOR domain_name ';'
	{
		yylex.conf.Options.DNSSecLookaside = append(yylex.conf.Options.DNSSecLookaside, DNSSecDelegation{$2, $4})
	}
|	tDNSSEC_MUST_BE_SECURE domain_name yes_or_no ';'
	{
		yylex.conf.Options.DNSSecMustBeSecure = append(yylex.conf.Options.DNSSecMustBeSecure, DNSSecMustBeSecured{$2, $3})
	}
|	tDNSSEC_SECURE2INSECURE yes_or_no ';'
	{
		yylex.conf.Options.DNSSecSecure2Insecure = $2
	}
|	tDNSSEC_VALIDATION yes_or_no ';'
	{
		yylex.conf.Options.DNSSecValidation = $2
	}
|	tDUAL_STACK_SERVERS dual_stack_servers ';'
	{
		yylex.conf.Options.DualStackServers = $2
	}
|	tDUMP_FILE tQSTR ';'
	{
		yylex.conf.Options.DumpFile = $2
	}
|	tEDNS_UDP_SIZE tDECADIC ';'
	{
		x := $2
		switch {
		case x < 1024:
			x = 1024
		case x > 4096:
			x = 4096
		}
		yylex.conf.Options.EdnsUdpSize = int(x)
	}
|	tEMPTY_CONTACT tQSTR ';'
	{
		yylex.conf.Options.EmptyContact = $2
	}
|	tEMPTY_SERVER tQSTR ';'
	{
		yylex.conf.Options.EmptyServer = $2
	}
|	tEMPTY_ZONES_ENABLE yes_or_no ';'
	{
		yylex.conf.Options.EmptyZonesEnable = $2
	}
|	tFAKE_IQUERY yes_or_no ';'
	{
		yylex.conf.Options.FakeIQuery = $2
	}
|	tFETCH_GLUE yes_or_no ';'
	{
		yylex.conf.Options.FetchGlue = $2
	}
|	tFILES size_spec ';'
	{
		yylex.conf.Options.Files = $2
	}
|	tFORWARD tFIRST ';'
	{
		yylex.conf.Options.Forward = ForwardFirst
	}
|	tFORWARD tONLY ';'
	{
		yylex.conf.Options.Forward = ForwardOnly
	}
|	tHAS_OLD_CLIENTS yes_or_no ';'
	{
		yylex.conf.Options.HasOldClients = $2
	}
|	tHEARTBEAT_INTERVAL tDECADIC ';'
	{
		x := $2
		switch {
		case x > 40320:
			x = 40320
		}
		yylex.conf.Options.HeartbeatInterval = int(x)
	}
|	tHOSTNAME tQSTR ';'
	{
		yylex.conf.Options.Hostname = $2
	}
|	tHOSTNAME tNONE ';'
	{
		yylex.conf.Options.Hostname = ""
	}
|	tHOST_STATISTICS yes_or_no ';'
	{
		yylex.conf.Options.HostStatistics = $2
	}
|	tHOST_STATISTICS_MAX tDECADIC ';'
	{
		yylex.conf.Options.HostStatisticsMax = $2
	}
|	tINTERFACE_INTERVAL tDECADIC ';'
	{
		x := $2
		switch {
		case x > 40320:
			x = 40320
		}
		yylex.conf.Options.InterfaceInterval = int(x)
	}
|	tSTATISTICS_INTERVAL tDECADIC ';'
	{
		x := $2
		switch {
		case x > 40320:
			x = 40320
		}
		yylex.conf.Options.StatisticsInterval = int(x)
	}
|	tIXFR_FROM_DIFFS yes_or_no ';'
	{
		switch $2 {
		case false:
			yylex.conf.Options.IxfrFromDiffs = IxfrFromDiffsNo
		case true:
			yylex.conf.Options.IxfrFromDiffs = IxfrFromDiffsYes
		}
	}
|	tIXFR_FROM_DIFFS tMASTER ';'
	{
		yylex.conf.Options.IxfrFromDiffs = IxfrFromDiffsMaster
	}
|	tIXFR_FROM_DIFFS tSLAVE ';'
	{
		yylex.conf.Options.IxfrFromDiffs = IxfrFromDiffsSlave
	}
|	tKEY_DIRECTORY tQSTR ';'
	{
		yylex.conf.Options.KeyDirectory = $2
	}
|	tLAME_TTL tDECADIC ';'
	{
		x := $2
		switch {
		case x > 1800:
			x = 1800
		}
		yylex.conf.Options.LameTtl = int(x)
	}
|	tFLUSH_ZONES_ON_SHUTDOWN yes_or_no ';'
	{
		yylex.conf.Options.FlushZonesOnShutdown = $2
	}
|	forwarders
	{
		yylex.conf.Options.Forwarders = append(yylex.conf.Options.Forwarders, $1...)
	}
|	listen_on
	{
		yylex.conf.Options.ListenOn = append(yylex.conf.Options.ListenOn, $1)
	}
|	listen_on_v6
	{
		yylex.conf.Options.ListenOnV6 = append(yylex.conf.Options.ListenOnV6, $1)
	}
|	tMAINTAIN_IXFR_BASE yes_or_no ';'
	{
		yylex.conf.Options.MaintainIxfrBase = $2	
	}
|	tMEMSTATS yes_or_no ';'
	{
		yylex.conf.Options.MemStats = $2
	}
|	tMASTER_FILE_FORMAT tTEXT ';'
	{
		yylex.conf.Options.MasterFileFormat = MasterFileFormatText
	}
|	tMASTER_FILE_FORMAT tRAW ';'
	{
		yylex.conf.Options.MasterFileFormat = MasterFileFormatRaw
	}
|	tMATCH_MAPPED_ADDRESSES yes_or_no ';'
	{
		yylex.conf.Options.MatchMappedAddresses = $2
	}
|	tMAX_ACACHE_SIZE size_spec ';'
	{
		yylex.conf.Options.MaxACacheSize = $2
	}
|	tMAX_CACHE_SIZE size_spec ';'
	{
		x := $2
		switch {
		case x == SizeSpecDefault || x > 0 && x < 1<<21:
			x = 1<<21
		case x == SizeSpecUnlimited:
			x = math.MaxUint32
		}
		yylex.conf.Options.MaxCacheSize = x
	}
|	tMAX_CACHE_TTL tDECADIC ';'
	{
		yylex.conf.Options.MaxCacheTtl = int($2)
	}
|	tMAX_CLIENTS_PER_QUERY tDECADIC ';'
	{
		yylex.conf.Options.MaxClientsPerQuery = int($2)
	}
|	tMAX_IXFR_LOG_SIZE tDECADIC ';'
	{
		yylex.conf.Options.MaxIxfrLogSize = $2
	}
|	tMAX_JOURNAL_SIZE size_spec ';'
	{
		yylex.conf.Options.MaxJournalSize = $2
	}
|	tMAX_NCACHE_TTL tDECADIC ';'
	{
		x := $2
		switch {
		case x > 3600*24*7:
			x = 3600*24*7
		}
		yylex.conf.Options.MaxNCacheTtl = int(x)
	}
|	tMAX_REFRESH_TIME tDECADIC ';'
	{
		yylex.conf.Options.MaxRefreshTime = $2
	}
|	tMIN_REFRESH_TIME tDECADIC ';'
	{
		yylex.conf.Options.MinRefreshTime = $2
	}
|	tMAX_RETRY_TIME tDECADIC ';'
	{
		yylex.conf.Options.MaxRetryTime = $2
	}
|	tMIN_RETRY_TIME tDECADIC ';'
	{
		yylex.conf.Options.MinRetryTime = $2
	}
|	tMAX_UDP_SIZE tDECADIC ';'
	{
		x := $2
		switch {
		case x < 512:
			x = 512
		case x > 4096:
			x = 4096
		}
		yylex.conf.Options.MaxUdpSize = int(x)
	}
|	tMAX_XFER_IDLE_IN tDECADIC ';'
	{
		x := $2
		switch {
		case x > 40320:
			x = 40320
		}
		yylex.conf.Options.MaxXferIdleIn = int(x)
	}
|	tMAX_XFER_IDLE_OUT tDECADIC ';'
	{
		x := $2
		switch {
		case x > 40320:
			x = 40320
		}
		yylex.conf.Options.MaxXferIdleOut = int(x)
	}
|	tMAX_XFER_TIME_IN tDECADIC ';'
	{
		x := $2
		switch {
		case x > 40320:
			x = 40320
		}
		yylex.conf.Options.MaxXferTimeIn = int(x)
	}
|	tMAX_XFER_TIME_OUT tDECADIC ';'
	{
		x := $2
		switch {
		case x > 40320:
			x = 40320
		}
		yylex.conf.Options.MaxXferTimeOut = int(x)
	}
|	tMEMSTATS_FILE tQSTR ';'
	{
		yylex.conf.Options.MemStatsFile = $2
	}
|	tMINIMAL_RESPONSES yes_or_no ';'
	{
		yylex.conf.Options.MinimalResponses = $2
	}
|	tMIN_ROOTS tDECADIC ';'
	{
		yylex.conf.Options.MinRoots = int($2)
	}
|	tMULTI_MASTER yes_or_no ';'
	{
		yylex.conf.Options.MultiMaster = $2
	}
|	tMULTIPLE_CNAMES yes_or_no ';'
	{
		yylex.conf.Options.MultipleCnames = $2
	}
|	tNAMEX_XFER tQSTR ';'
	{
		yylex.conf.Options.NamedXfer = $2
	}
|	tNOTIFY yes_or_no ';'
	{
		switch $2 {
		case false:
			yylex.conf.Options.Notify = NotifyNo
		case true:
			yylex.conf.Options.Notify = NotifyYes
		}
	}
|	tNOTIFY tMASTER_ONLY ';'
	{
		yylex.conf.Options.Notify = NotifyMasterOnly
	}
|	tNOTIFY tEXPLICIT ';'
	{
		yylex.conf.Options.Notify = NotifyExplicit
	}
|	tNOTIFY_DELAY tDECADIC ';'
	{
		yylex.conf.Options.NotifyDelay = int($2)
	}
|	tNOTIFY_SOURCE ip port_and_portnum_opt ';'
	{
		ip := $2
		if ip != nil && ip.To4() == nil {
			yylex.Error(fmt.Sprintf("invalid IP address %q", ip))
		}
		yylex.conf.Options.NotifySource = &IPAndPort{ip, $3}
	}
|	tNOTIFY_SOURCE_V6 ip port_and_portnum_opt ';'
	{
		ip := $2
		if ip != nil && ip.To16() == nil {
			yylex.Error(fmt.Sprintf("invalid IP address %q", ip))
		}
		yylex.conf.Options.NotifySourceV6 = &IPAndPort{ip, $3}
	}
|	tNOTIFY_TO_SOA yes_or_no ';'
	{
		yylex.conf.Options.NotifyToSoa = $2
	}
|	tPID_FILE tQSTR ';'
	{
		yylex.conf.Options.PIDFile = $2
	}
|	tPORT ip_port ';'
	{
		yylex.conf.Options.Port = $2
	}
|	tPREFERRED_GLUE tNONE ';'
|	tPREFERRED_GLUE tA ';'
	{
		x := rr.TYPE_A
		yylex.conf.Options.PreferredGlue = &x
	}
|	tPREFERRED_GLUE tAAAA ';'
	{
		x := rr.TYPE_AAAA
		yylex.conf.Options.PreferredGlue = &x
	}
|	tPROVIDE_IXFR yes_or_no ';'
	{
		v := $2
		yylex.conf.Options.ProvideIxfr = &v
	}
|	tQUERYLOG yes_or_no ';'
	{
		v := $2
		yylex.conf.Options.Querylog = &v
	}
|	tQUERY_SRC ip port_and_portnum_opt ';'
	{
		ip := $2
		if ip != nil && ip.To4() == nil {
			yylex.Error(fmt.Sprintf("invalid IP address %q", ip))
		}
		yylex.conf.Options.QuerySource = &IPAndPort{ip, $3}
	}
|	tQUERY_SRC_V6 ip port_and_portnum_opt ';'
	{
		ip := $2
		if ip != nil && ip.To16() == nil {
			yylex.Error(fmt.Sprintf("invalid IP address %q", ip))
		}
		yylex.conf.Options.QuerySourceV6 = &IPAndPort{ip, $3}
	}
|	tRANDOM_DEVICE tQSTR ';'
	{
		yylex.conf.Options.RandomDevice = $2
	}
|	tRECURSION yes_or_no ';'
	{
		yylex.conf.Options.Recursion = $2
	}
|	tRECURSING_FILE tQSTR ';'
	{
		yylex.conf.Options.RecursingFile = $2
	}
|	tRECURSIVE_CLIENTS tDECADIC ';'
	{
		yylex.conf.Options.RecursiveClients = int($2)
	}
|	tREQUEST_IXFR yes_or_no ';'
	{
		v := $2
		yylex.conf.Options.RequestIxfr = &v
	}
|	tRESERVED_SOCKETS tDECADIC ';'
	{
		x := $2
		switch {
		case x < 128:
			x = 128
		}
		yylex.conf.Options.ReservedSockets = int($2)
	}
|	tRFC2308_TYPE1 yes_or_no ';'
	{
		yylex.conf.Options.Rfc2308Type1 = $2
	}
|	tROOT_DELEGATION_ONLY exclude ';'
	{
		ex := $2
		yylex.conf.Options.RootDelegationOnly = &ex
	}
|	tRRSET_ORDER '{' order_specs  '}' ';'
	{
		yylex.conf.Options.RRSetOrder = $3
	}
|	tSERIAL_QUERIES tDECADIC ';'
	{
		yylex.conf.Options.SerialQueries = $2
	}
|	tSIG_VALIDITY_INTERVAL tDECADIC ';'
	{
		x := $2
		switch {
		case x > 3660:
			x = 3660
		}
		yylex.conf.Options.SigValidityIntervalBase = int(x)
		yylex.conf.Options.SigValidityIntervalExpireHours = int(x)*24/4
	}
|	tSIG_VALIDITY_INTERVAL tDECADIC tDECADIC ';'
	{
		x := $2
		switch {
		case x > 3660:
			x = 3660
		}
		yylex.conf.Options.SigValidityIntervalBase = int(x)
		x2 := $3
		if x > 7 {
			x2 *= 24
		}
		yylex.conf.Options.SigValidityIntervalExpireHours = int(x2)
	}
|	tSIG_SIGNING_NODES tDECADIC ';'
	{
		yylex.conf.Options.SigSigningNodes = int($2)
	}
|	tSIG_SIGNING_SIGNATURES tDECADIC ';'
	{
		yylex.conf.Options.SigSigningSignatures = int($2)
	}
|	tSIG_SIGNING_TYPE tDECADIC ';'
	{
		yylex.conf.Options.SigSigningType = int($2)
	}
|	tSORTLIST '{' address_match_list '}' ';'
	{
		yylex.conf.Options.Sortlist = $3
	}
|	tTCP_CLIENTS tDECADIC ';'
	{
		yylex.conf.Options.TcpClients = int($2)
	}
|	tTCP_LISTEN_QUEUE tDECADIC ';'
	{
		x := $2
		switch {
		case x < 3:
			x = 3
		}
		yylex.conf.Options.TcpListenQueue = int(x)
	}
|	tSERIAL_QUERY_RATE tDECADIC ';'
	{
		yylex.conf.Options.SerialQueryRate = int($2)
	}
|	tSERVER_ID tQSTR ';'
	{
		yylex.conf.Options.ServerId = $2
	}
|	tSESSION_KEYALG alg ';'
	{
		yylex.conf.Options.SessionKeyAlg = $2
	}
|	tSESSION_KEYFILE tQSTR ';'
	{
		yylex.conf.Options.SessionKeyFile = $2
	}
|	tSESSION_KEYNAME tQSTR ';'
	{
		yylex.conf.Options.SessionKeyName = $2
	}
|	tSTATS_FILE tQSTR ';'
	{
		yylex.conf.Options.StatsFile = $2
	}
|	tSTACK_SIZE size_spec ';'
	{
		yylex.conf.Options.Stacksize = $2
	}
|	tTKEY_DHKEY tQSTR tDECADIC ';'
	{
		yylex.conf.Options.TDHKeyName, yylex.conf.Options.TDHKeyTag = $2, $3
	}
|	tTKEY_DOMAIN tQSTR ';'
	{
		yylex.conf.Options.TKeyDomain = $2
	}
|	tTOPOLOGY '{' address_match_list '}' ';'
	{
		yylex.conf.Options.Topology = $3
	}
|	tTREAT_CR_AS_SPACE yes_or_no ';'
	{
		yylex.conf.Options.TreatCrAsSpace = $2
	}
|	tXFER_SOURCE ip port_and_portnum_opt ';'
	{
		ip := $2
		if ip != nil && ip.To4() == nil {
			yylex.Error(fmt.Sprintf("invalid IP address %q", ip))
		}
		yylex.conf.Options.TransferSource = &IPAndPort{ip, $3}
	}
|	tXFER_SOURCE_V6 ip port_and_portnum_opt ';'
	{
		ip := $2
		if ip != nil && ip.To16() == nil {
			yylex.Error(fmt.Sprintf("invalid IP address %q", ip))
		}
		yylex.conf.Options.TransferSourceV6 = &IPAndPort{ip, $3}
	}
|	tXFERS_IN tDECADIC ';'
	{
		yylex.conf.Options.TransfersIn = int($2)
	}
|	tXFERS_OUT tDECADIC ';'
	{
		yylex.conf.Options.TransfersOut = int($2)
	}
|	tXFERS_PER_NS tDECADIC ';'
	{
		yylex.conf.Options.TransfersPerNS = int($2)
	}
|	tXFER_FMT tMANY_ANSWERS ';'
	{
		yylex.conf.Options.TransferFormat = TransferFormatManyAnswers
	}
|	tXFER_FMT tONE_ANSWER ';'
	{
		yylex.conf.Options.TransferFormat = TransferFormatOneAnswer
	}
|	tTRY_TCP_REFRESH yes_or_no ';'
	{
		yylex.conf.Options.TryTcpRefresh = $2
	}
|	tUPDATE_CHECK_KSK yes_or_no ';'
	{
		yylex.conf.Options.UpdateCheckKsk = $2
	}
|	tUSE_ALT_XFER_SRC yes_or_no ';'
	{
		yylex.conf.Options.UseAltTransferSource = $2
	}
|	tUSE_ID_POOL yes_or_no ';'
	{
		yylex.conf.Options.UseIdPool = $2
	}
|	tUSE_IXFR yes_or_no ';'
	{
		yylex.conf.Options.UseIxfr = $2
	}
|	tVERSION tQSTR ';'
	{
		yylex.conf.Options.Version = $2
	}
|	tVERSION tNONE ';'
	{
		yylex.conf.Options.Version = ""
	}
|	tZERO_NO_SOA_TTL yes_or_no ';'
	{
		yylex.conf.Options.ZeroNoSoaTtl = $2
	}
|	tZERO_NO_SOA_TTL_CACHE yes_or_no ';'
	{
		yylex.conf.Options.ZeroNoSoaTtlCache = $2
	}
|	tZONE_STATS yes_or_no ';'
	{
		yylex.conf.Options.ZoneStats = $2
	}


option_star:
|	option_star option


ordering:
	tFIXED
	{
		$$ = OrderingFixed
	}
|	tCYCLIC
	{
		$$ = OrderingCyclic
	}
|	tRANDOM
	{
		$$ = OrderingRandom
	}


order_spec:
	tCLASS class tTYPE type tNAME tQSTR tORDER ordering
	{
		cls, typ, name := $2, $4, $6
		$$ = OrderSpec{&cls, &typ, &name, $8}
	}
|	tCLASS class tTYPE type tORDER ordering
	{
		cls, typ := $2, $4
		$$ = OrderSpec{&cls, &typ, nil, $6}
	}
|	tCLASS class tNAME tQSTR tORDER ordering
	{
		cls, name := $2, $4
		$$ = OrderSpec{&cls, nil, &name, $6}
	}
|	tCLASS class tORDER ordering
	{
		cls := $2
		$$ = OrderSpec{&cls, nil, nil, $4}
	}
|	tTYPE type tNAME tQSTR tORDER ordering
	{
		typ, name := $2, $4
		$$ = OrderSpec{nil, &typ, &name, $6}
	}
|	tTYPE type tORDER ordering
	{
		typ := $2
		$$ = OrderSpec{nil, &typ, nil, $4}
	}
|	tNAME tQSTR tORDER ordering
	{
		name := $2
		$$ = OrderSpec{nil, nil, &name, $4}
	}
|	tORDER ordering
	{
		$$ = OrderSpec{nil, nil, nil, $2}
	}


order_specs:
	order_spec ';'
	{
		$$ = []OrderSpec{$1}
	}
|	order_specs order_spec ';'
	{
		$$ = append($1, $2)
	}


port_and_portnum:
	tPORT ip_port
	{
		$$ = NewIPPort($2)
	}


port_and_portnum_opt:
	{
		$$ = nil
	}
|	port_and_portnum


port_list:
	port_list_elem
|	port_list port_list_elem
	{
		$$ = append($$, $2...)
	}


port_list_elem:
	uint16 ';'
	{
		$$ = []uint16{$1, $1}
	}
|	tRANGE uint16 uint16 ';'
	{
		$$ = []uint16{$2, $3}
	}


size_spec:
	tDECADIC
	{
		$$ = SizeSpec($1)
	}
|	tDEFAULT
	{
		$$ = SizeSpecDefault
	}
|	tUNLIMITED
	{
		$$ = SizeSpecUnlimited
	}


statement:
	tINCLUDE tQSTR ';'
	{
		buf, err := ioutil.ReadFile($2)
		if err != nil {
			panic(err)
		}
		yylex.include($2, strings.NewReader(string(buf)))
	}
|	tMASTERS masters_body ';'
	{
		yylex.conf.Masters = append(yylex.conf.Masters, $2)
	}
|	tOPTIONS 
	{
		if yylex.sawOptions {
			panic(fmt.Errorf(`"options" statement may appear only once in a configuration file`))
		}

		yylex.sawOptions = true
	}
	'{' option_star '}' ';'
|	zone
	{
		yylex.conf.Zones = append(yylex.conf.Zones, $1)
	}
|	tMANAGED_KEYS '{' managed_keys '}' ';'
	{
		yylex.conf.ManagedKeys = append(yylex.conf.ManagedKeys, $3...)
	}


type:
	tA
	{
		$$ = rr.TYPE_A
	}
|	tAAAA
	{
		$$ = rr.TYPE_AAAA
	}
|	tCNAME
	{
		$$ = rr.TYPE_CNAME
	}
|	tDNSKEY
	{
		$$ = rr.TYPE_DNSKEY
	}
|	tDS
	{
		$$ = rr.TYPE_DS
	}
|	tHINFO
	{
		$$ = rr.TYPE_HINFO
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
|	tMG
	{
		$$ = rr.TYPE_MG
	}
|	tMINFO
	{
		$$ = rr.TYPE_MINFO
	}
|	tMR
	{
		$$ = rr.TYPE_MR
	}
|	tMX
	{
		$$ = rr.TYPE_MX
	}
|	tNS
	{
		$$ = rr.TYPE_NS
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
|	tNULL
	{
		$$ = rr.TYPE_NULL
	}
|	tPTR
	{
		$$ = rr.TYPE_PTR
	}
|	tRRSIG
	{
		$$ = rr.TYPE_RRSIG
	}
|	tSOA
	{
		$$ = rr.TYPE_SOA
	}
|	tTXT
	{
		$$ = rr.TYPE_TXT
	}
|	tWKS
	{
		$$ = rr.TYPE_WKS
	}


uint16:
	tDECADIC
	{
		x := $1
		if x < 0 || x > math.MaxUint32 {
			yylex.Error(fmt.Sprintf("Number out of range %d", x))
		}
		$$ = uint16(x)
	}


warn_fail_ignore:
	tWARN
	{
		$$ = WarnFailIgnore_Warn
	}
|	tFAIL
	{
		$$ = WarnFailIgnore_Fail
	}
|	tIGNORE
	{
		$$ = WarnFailIgnore_Ignore
	}


yes_or_no:
	tYES
	{
		$$ = true
	}
|	tTRUE
	{
		$$ = true
	}
|	tNO
	{
		$$ = false
	}
|	tFALSE
	{
		$$ = false
	}
|	tDECADIC
	{
		switch $1 {
		default:
			panic(fmt.Errorf(`expected "1" or "0"`))
		case 0, 1:
			$$ = $1 != 0
		}
	}

zone:
	tZONE zone_name class '{' zone_body '}' ';'
	{
		$$ = $5
		$$.Name = $2
		$$.Class = $3
	}


zone_name:
	tQSTR


zone_body:
	tTYPE tMASTER ';' master_zone
	{
		$$ = $4
		$$.Type = ZoneTypeMaster
	}
|	tTYPE tHINT ';' file hint_zone
	{
		$$ = $5
		$$.File = $4
		$$.Type = ZoneTypeHint
	}


master_zone:
	{
		$$ = NewZone(yylex.conf.Options)
	}
|	master_zone master_zone_item
	{
		// nop
	}


hint_zone:
	{
		$$ = NewZone(yylex.conf.Options)
	}
|	hint_zone hint_zone_item
	{
		// nop
	}


master_zone_item:
	file
	{
		$<zone>0.File = $1
	}


hint_zone_item: //TODO:+
	'@'
	{
		todo("hint_zone_item")
	}