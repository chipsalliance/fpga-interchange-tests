#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Copyright (C) 2022  The Symbiflow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

""" 
Helper script for generating verilog wrappers with a differential clock input around
preexisting designs.

Arguments:
    - variable length list of IOs. Each element of the list is in the following form
      ([io])([0123456789]*):([[:alnum:]])
          - the first group represents the direction: i - input, o - output.
          - the second group, when non-empty, represents the length of a vector
          - the third group is the name of wire/reg.
    - --source (optional) file path name with the original top module (use if you want
                          to include it via `include)
    - --top (optional) to define the top level name of the original design.
E.g.:
    Verilog (top.v):
        module top(input clk_p, input clk_n, input [7:0] par, output ser); endmodule
    shell:
        $ differentiate.py top.v i8:par o:ser
"""

from argparse import ArgumentParser
import os
from datetime import date, datetime

parser = ArgumentParser()
parser.add_argument('io', nargs='*')
parser.add_argument('--source')
parser.add_argument('--top', default='top')

args = parser.parse_args()

now = datetime.now()

verilog = ''

license = f'// Copyright (C) {now.year}  The Symbiflow Authors.\n' \
           '//\n' \
           '// Use of this source code is governed by a ISC-style\n' \
           '// license that can be found in the LICENSE file or at\n' \
           '// https://opensource.org/licenses/ISC\n' \
           '//\n' \
           '// SPDX-License-Identifier: ISC\n'

verilog += license + '\n'
verilog += '// Generated with tests/utils/differentiate.py\n\n'
if args.source is not None:
    verilog += f'`include "{os.path.basename(args.source)}"\n\n'
verilog += f'module {args.top}_diff (\n'

def iogen(io):
    for iodef in io:
        iosplit = iodef.split(':')
        iotype = 'input' if iosplit[0][0] == 'i' else 'output'
        iow = 1
        if len(iosplit[0]) > 1:
            iow = int(iosplit[0][1:])
        
        iowstr = '' if iow == 1 else f'[{iow-1}:0] '

        yield f'{iotype} wire {iowstr}{iosplit[1]}'

def ionames(io):
    for iodef in io:
        iosplit = iodef.split(':')
        yield iosplit[1]

verilog += '    input wire clk_p,\n    input wire clk_n' + (',\n    ' if len(args.io) > 0 else '')
verilog += ',\n    '.join(iogen(args.io)) + '\n);\n'
verilog += '    wire clk;\n    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));\n'

names = list(ionames(args.io)) + ['clk']

verilog += '    top top_ (\n        '
verilog += ',\n        '.join(f'.{n}({n})' for n in names)
verilog += '\n    );\nendmodule\n'

print(verilog)
