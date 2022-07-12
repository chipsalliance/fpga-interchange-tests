#!/usr/bin/env python3
#-*- coding: utf-8 -*-
#
# Copyright (C) 2022  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

from itertools import product

devices = [
    "xc7a35t",
    "xc7a100t",
    "xc7a200t",
    "xc7s50",
    "xc7z010",
    "xczu7ev",
    "xc7k70t",
    "xc7k160t",
    "xc7k480t",
    "xc7vx980t",
    "testarch",
    "LIFCL-40"
]

tools = [
    "nextpnr",
    "vpr"
]

osvers = [
    ("ubuntu", "focal"),
    ("centos", "7"),
]

jobs = list()

for device, tool, osver in product(devices, tools, osvers):
    os, ver = osver

    if tool == "vpr" and device not in ["xc7a35t", "LIFCL-40", "testarch"]:
        continue

    if os == "centos" and device == "LIFCL-40":
        continue

    jobs += [{
        'tool': tool,
        'device': device,
        'os': os,
        'os-version': ver,
    }]

print(f'::set-output name=matrix::{jobs!s}')

print(str(jobs))
