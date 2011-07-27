// Copyright (c) 2011 CZ.NIC z.s.p.o. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// blame: jnml, labs.nic.cz

// WARNING: If this file is scanner.go then DO NOT EDIT.
// scanner.go is generated by golex from scanner.l (see the Makefile).


package resolv

import (
	"fmt"
	"net"
	"os"
	"strconv"
	"strings"
	"unicode"
)

type lex struct {
	resolv    *Conf
	startCond int
	buf       []byte
	peek      byte
	line      int
	column    int
	name      string
	src       *strings.Reader
}

func (l *lex) getc(c byte) byte {
	if c != 0 {
		l.buf = append(l.buf, c)
	}
	if b, err := l.src.ReadByte(); err == nil {
		l.peek = b
		if b == '\n' {
			l.line++
			l.column = 0
		} else {
			l.column++
		}
		return b
	} else {
		if err == os.EOF {
			l.peek = 0
			return 0
		}
		panic(err)
	}

	panic("unreachable")
}

func newLex(name string, source *strings.Reader) (l *lex) {
	l = &lex{}
	l.resolv = NewConf()
	l.line = 1
	l.name = name
	l.src = source
	l.begin(sc_LINE_START)
	l.getc(0)
	return
}

func (l *lex) Error(e string) {
	panic(os.NewError(e))
}

func (l *lex) begin(sc int) {
	l.startCond = sc
}

const (
	sc_INITIAL = iota
	sc_LINE_START
	sc_IP
	sc_DOMAIN
	sc_OPTS
)

func (l *lex) Lex(lval *yySymType) (ret int) {
	c := l.peek
	ret = -1

yystate0:

	if ret >= 0 {
		lval.str = string(l.buf)
		return
	}
	l.buf = l.buf[:0]

	switch yyt := l.startCond; yyt {
	default:
		panic(fmt.Errorf(`invalid start condition %d`, yyt))
	case 0: // start condition: INITIAL
		goto yystart1
	case 4: // start condition: opts
		goto yystart4
	case 1: // start condition: lineStart
		goto yystart91
	case 2: // start condition: ip
		goto yystart129
	case 3: // start condition: domain
		goto yystart157
	}

	goto yystate1 // silence unused label error
yystate1:
	c = l.getc(c)
yystart1:
	switch {
	default:
		goto yyabort
	case c == '#':
		goto yystate3
	case c == '\t' || c == ' ':
		goto yystate2
	}

yystate2:
	c = l.getc(c)
	switch {
	default:
		goto yyrule22
	case c == '#':
		goto yystate3
	case c == '\t' || c == ' ':
		goto yystate2
	}

yystate3:
	c = l.getc(c)
	switch {
	default:
		goto yyrule23
	case c >= '\x01' && c <= '\t' || c >= '\v' && c <= 'ÿ':
		goto yystate3
	}

	goto yystate4 // silence unused label error
yystate4:
	c = l.getc(c)
yystart4:
	switch {
	default:
		goto yyabort
	case c == 'a':
		goto yystate20
	case c == 'i':
		goto yystate33
	case c == '\t' || c == ' ':
		goto yystate11
	case c == ':':
		goto yystate12
	case c == '#':
		goto yystate3
	case c == 'r':
		goto yystate85
	case c == 'e':
		goto yystate28
	case c == 'd':
		goto yystate6
	case c == 'n':
		goto yystate57
	case c == 't':
		goto yystate13
	case c >= '0' && c <= '9':
		goto yystate5
	}

yystate5:
	c = l.getc(c)
	switch {
	default:
		goto yyrule21
	case c >= '0' && c <= '9':
		goto yystate5
	}

yystate6:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate7
	}

yystate7:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'b':
		goto yystate8
	}

yystate8:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'u':
		goto yystate9
	}

yystate9:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'g':
		goto yystate10
	}

yystate10:
	c = l.getc(c)
	goto yyrule10

yystate11:
	c = l.getc(c)
	switch {
	default:
		goto yyrule22
	case c == '\t' || c == ' ':
		goto yystate11
	case c == ':':
		goto yystate12
	case c == '#':
		goto yystate3
	}

yystate12:
	c = l.getc(c)
	switch {
	default:
		goto yyrule20
	case c == '\t' || c == ' ':
		goto yystate12
	}

yystate13:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'i':
		goto yystate14
	}

yystate14:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'm':
		goto yystate15
	}

yystate15:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate16
	}

yystate16:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate17
	}

yystate17:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'u':
		goto yystate18
	}

yystate18:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate19
	}

yystate19:
	c = l.getc(c)
	goto yyrule19

yystate20:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate21
	}

yystate21:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate22
	}

yystate22:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate23
	}

yystate23:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'm':
		goto yystate24
	}

yystate24:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'p':
		goto yystate25
	}

yystate25:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate26
	}

yystate26:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 's':
		goto yystate27
	}

yystate27:
	c = l.getc(c)
	goto yyrule9

yystate28:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'd':
		goto yystate29
	}

yystate29:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'n':
		goto yystate30
	}

yystate30:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 's':
		goto yystate31
	}

yystate31:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '0':
		goto yystate32
	}

yystate32:
	c = l.getc(c)
	goto yyrule11

yystate33:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'p':
		goto yystate34
	case c == 'n':
		goto yystate53
	}

yystate34:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '6':
		goto yystate35
	}

yystate35:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '-':
		goto yystate36
	}

yystate36:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'b':
		goto yystate43
	case c == 'd':
		goto yystate37
	}

yystate37:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate38
	}

yystate38:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate39
	}

yystate39:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'i':
		goto yystate40
	}

yystate40:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'n':
		goto yystate41
	}

yystate41:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate42
	}

yystate42:
	c = l.getc(c)
	goto yyrule14

yystate43:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'y':
		goto yystate44
	}

yystate44:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate45
	}

yystate45:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate46
	}

yystate46:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 's':
		goto yystate47
	}

yystate47:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate48
	}

yystate48:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'r':
		goto yystate49
	}

yystate49:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'i':
		goto yystate50
	}

yystate50:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'n':
		goto yystate51
	}

yystate51:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'g':
		goto yystate52
	}

yystate52:
	c = l.getc(c)
	goto yyrule13

yystate53:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate54
	}

yystate54:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate55
	}

yystate55:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '6':
		goto yystate56
	}

yystate56:
	c = l.getc(c)
	goto yyrule12

yystate57:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate58
	case c == 'd':
		goto yystate81
	}

yystate58:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '-':
		goto yystate59
	}

yystate59:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'c':
		goto yystate60
	case c == 'i':
		goto yystate71
	}

yystate60:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'h':
		goto yystate61
	}

yystate61:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate62
	}

yystate62:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'c':
		goto yystate63
	}

yystate63:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'k':
		goto yystate64
	}

yystate64:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '-':
		goto yystate65
	}

yystate65:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'n':
		goto yystate66
	}

yystate66:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'a':
		goto yystate67
	}

yystate67:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'm':
		goto yystate68
	}

yystate68:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate69
	}

yystate69:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 's':
		goto yystate70
	}

yystate70:
	c = l.getc(c)
	goto yyrule16

yystate71:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'p':
		goto yystate72
	}

yystate72:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '6':
		goto yystate73
	}

yystate73:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '-':
		goto yystate74
	}

yystate74:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'd':
		goto yystate75
	}

yystate75:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate76
	}

yystate76:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate77
	}

yystate77:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'i':
		goto yystate78
	}

yystate78:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'n':
		goto yystate79
	}

yystate79:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate80
	}

yystate80:
	c = l.getc(c)
	goto yyrule17

yystate81:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate82
	}

yystate82:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate83
	}

yystate83:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 's':
		goto yystate84
	}

yystate84:
	c = l.getc(c)
	goto yyrule15

yystate85:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate86
	}

yystate86:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate87
	}

yystate87:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'a':
		goto yystate88
	}

yystate88:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate89
	}

yystate89:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate90
	}

yystate90:
	c = l.getc(c)
	goto yyrule18

	goto yystate91 // silence unused label error
yystate91:
	c = l.getc(c)
yystart91:
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate92
	case c == '#':
		goto yystate3
	case c == 's':
		goto yystate99
	case c == 'd':
		goto yystate112
	case c == 'n':
		goto yystate119
	case c == '\t' || c == ' ':
		goto yystate118
	}

yystate92:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'p':
		goto yystate93
	}

yystate93:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate94
	}

yystate94:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'i':
		goto yystate95
	}

yystate95:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate96
	}

yystate96:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'n':
		goto yystate97
	}

yystate97:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 's':
		goto yystate98
	}

yystate98:
	c = l.getc(c)
	goto yyrule4

yystate99:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate100
	case c == 'e':
		goto yystate107
	}

yystate100:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'r':
		goto yystate101
	}

yystate101:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate102
	}

yystate102:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'l':
		goto yystate103
	}

yystate103:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'i':
		goto yystate104
	}

yystate104:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 's':
		goto yystate105
	}

yystate105:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 't':
		goto yystate106
	}

yystate106:
	c = l.getc(c)
	goto yyrule6

yystate107:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'a':
		goto yystate108
	}

yystate108:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'r':
		goto yystate109
	}

yystate109:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'c':
		goto yystate110
	}

yystate110:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'h':
		goto yystate111
	}

yystate111:
	c = l.getc(c)
	goto yyrule5

yystate112:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'o':
		goto yystate113
	}

yystate113:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'm':
		goto yystate114
	}

yystate114:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'a':
		goto yystate115
	}

yystate115:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'i':
		goto yystate116
	}

yystate116:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'n':
		goto yystate117
	}

yystate117:
	c = l.getc(c)
	goto yyrule2

yystate118:
	c = l.getc(c)
	switch {
	default:
		goto yyrule1
	case c == '#':
		goto yystate3
	case c == '\t' || c == ' ':
		goto yystate118
	}

yystate119:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'a':
		goto yystate120
	}

yystate120:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'm':
		goto yystate121
	}

yystate121:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate122
	}

yystate122:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 's':
		goto yystate123
	}

yystate123:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate124
	}

yystate124:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'r':
		goto yystate125
	}

yystate125:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'v':
		goto yystate126
	}

yystate126:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'e':
		goto yystate127
	}

yystate127:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == 'r':
		goto yystate128
	}

yystate128:
	c = l.getc(c)
	goto yyrule3

	goto yystate129 // silence unused label error
yystate129:
	c = l.getc(c)
yystart129:
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate130
	case c == ':':
		goto yystate156
	case c == '#':
		goto yystate3
	case c == '\t' || c == ' ':
		goto yystate2
	case c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate135
	}

yystate130:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c >= '0' && c <= '9':
		goto yystate131
	case c == ':':
		goto yystate134
	case c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate136
	case c == '.':
		goto yystate144
	}

yystate131:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c == ':':
		goto yystate134
	case c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate137
	case c >= '0' && c <= '9':
		goto yystate132
	case c == '.':
		goto yystate144
	}

yystate132:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate133
	case c == ':':
		goto yystate134
	case c == '.':
		goto yystate144
	}

yystate133:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c == ':':
		goto yystate134
	}

yystate134:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate135
	case c == ':':
		goto yystate138
	}

yystate135:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c == ':':
		goto yystate134
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate136
	}

yystate136:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c == ':':
		goto yystate134
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate137
	}

yystate137:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate133
	case c == ':':
		goto yystate134
	}

yystate138:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate139
	}

yystate139:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c == ':':
		goto yystate143
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate140
	}

yystate140:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate141
	case c == ':':
		goto yystate143
	}

yystate141:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c == ':':
		goto yystate143
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate142
	}

yystate142:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c == ':':
		goto yystate143
	}

yystate143:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'F' || c >= 'a' && c <= 'f':
		goto yystate139
	}

yystate144:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate145
	}

yystate145:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate146
	case c == '.':
		goto yystate148
	}

yystate146:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate147
	case c == '.':
		goto yystate148
	}

yystate147:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '.':
		goto yystate148
	}

yystate148:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate149
	}

yystate149:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate150
	case c == '.':
		goto yystate152
	}

yystate150:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate151
	case c == '.':
		goto yystate152
	}

yystate151:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '.':
		goto yystate152
	}

yystate152:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9':
		goto yystate153
	}

yystate153:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c >= '0' && c <= '9':
		goto yystate154
	}

yystate154:
	c = l.getc(c)
	switch {
	default:
		goto yyrule7
	case c >= '0' && c <= '9':
		goto yystate155
	}

yystate155:
	c = l.getc(c)
	goto yyrule7

yystate156:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == ':':
		goto yystate138
	}

	goto yystate157 // silence unused label error
yystate157:
	c = l.getc(c)
yystart157:
	switch {
	default:
		goto yyabort
	case c == '#':
		goto yystate3
	case c == '\t' || c == ' ':
		goto yystate2
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'Z' || c >= 'a' && c <= 'z':
		goto yystate158
	}

yystate158:
	c = l.getc(c)
	switch {
	default:
		goto yyrule8
	case c == '-':
		goto yystate159
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'Z' || c >= 'a' && c <= 'z':
		goto yystate158
	case c == '.':
		goto yystate160
	}

yystate159:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c == '-':
		goto yystate159
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'Z' || c >= 'a' && c <= 'z':
		goto yystate158
	}

yystate160:
	c = l.getc(c)
	switch {
	default:
		goto yyabort
	case c >= '0' && c <= '9' || c >= 'A' && c <= 'Z' || c >= 'a' && c <= 'z':
		goto yystate158
	}

yyrule1: // [ \t]+
	{
		l.begin(0)
		goto yystate0
	}
yyrule2: // domain
	{
		return tDOMAIN
		goto yystate0
	}
yyrule3: // nameserver
	{
		return tNAMESERVER
		goto yystate0
	}
yyrule4: // options
	{
		return tOPTIONS
		goto yystate0
	}
yyrule5: // search
	{
		return tSEARCH
		goto yystate0
	}
yyrule6: // sortlist
	{
		return tSORTLIST
		goto yystate0
	}
yyrule7: // {ip_address}
	{

		ip := net.ParseIP(string(l.buf))
		if ip == nil {
			panic(fmt.Errorf("invalid IP %q", l.buf))
		}
		lval.ip = ip
		return tIP_ADDRESS
		goto yystate0
	}
yyrule8: // {hostname}
	{
		ret = tDOMAIN_NAME
		goto yystate0
	}
yyrule9: // attempts
	{
		return tATTEMPTS
		goto yystate0
	}
yyrule10: // debug
	{
		return tDEBUG
		goto yystate0
	}
yyrule11: // edns0
	{
		return tEDNS0
		goto yystate0
	}
yyrule12: // inet6
	{
		return tINET6
		goto yystate0
	}
yyrule13: // ip6-bytestring
	{
		return tIP6_BYTESTRING
		goto yystate0
	}
yyrule14: // ip6-dotint
	{
		return tIP6_DOTINT
		goto yystate0
	}
yyrule15: // ndots
	{
		return tNDOTS
		goto yystate0
	}
yyrule16: // no-check-names
	{
		return tNO_CHECK_NAMES
		goto yystate0
	}
yyrule17: // no-ip6-dotint
	{
		return tNO_IP6_DOTINT
		goto yystate0
	}
yyrule18: // rotate
	{
		return tROTATE
		goto yystate0
	}
yyrule19: // timeout
	{
		return tTIMEOUT
		goto yystate0
	}
yyrule20: // [ \t]*:[ \t]*
	{

		return ':'
		goto yystate0
	}
yyrule21: // [0-9]+
	{

		var err os.Error
		if lval.num, err = strconv.Atoui(string(l.buf)); err == nil {
			return tDECADIC
		}
		panic(fmt.Errorf("invalid number %q", string(l.buf)))
		goto yystate0
	}
yyrule22: // [ \t]+
	{

		if c != '\n' { // field sep
			return ' '
		}
		goto yystate0
	}
yyrule23: // [ \t]*#.*

		goto yystate0
		panic("unreachable")

		goto yyabort // silence unused label error

yyabort: // no lexem recognized
	// fail
	if len(l.buf) == 0 {
		ret = int(c)
		l.getc(0)
		return
	}

	return unicode.ReplacementChar
}
