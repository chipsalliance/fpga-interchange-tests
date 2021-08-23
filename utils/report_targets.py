#!/usr/bin/env python3
#-*- coding: utf-8 -*-
#
# Copyright (C) 2021  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

"""
"""

import argparse
import re
import os

# =============================================================================


BUILT_TARGET_RE = \
    re.compile(r"^\[\s*[0-9]+\%\]\s+Built\starget\s(?P<target>.*)")

FAILED_TARGET_RE = \
    re.compile(r".*recipe\sfor\starget\s'(?P<target>.*)'\sfailed")

# =============================================================================


def main():
    
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "log",
        type=str,
        help="Build log"
    )
    parser.add_argument(
        "csv",
        type=str,
        help="Output CSV report"
    )

    args = parser.parse_args()

    # Read the log
    with open(args.log, "r") as fp:
        log = fp.readlines()

    # Scan successfully built targets and failed targets
    built_targets = set()
    failed_targets = set()

    for line in log:
        line = line.strip()

        # Built
        match = BUILT_TARGET_RE.fullmatch(line)
        if match is not None:
            built_targets.add(match.group("target"))

        # Failed
        match = FAILED_TARGET_RE.match(line)
        if match is not None:
            path = match.group("target").split(os.path.sep)
            temp = [p for p in path if p.endswith(".dir")]
            if not temp:
                continue

            target = temp[0].replace(".dir", "")
            failed_targets.add(target)

    # Sanity check
    temp = built_targets & failed_targets
    assert not temp, temp

    # Identify tests and their statuses
    all_stages = [
        "json",
        "netlist",
        "phys",
        "fasm",
        "bit",
        "bit-fasm",
        "dcp",
        "dcp-bit",
        "dcp-bit-fasm",
        "dcp-diff-fasm",
    ]

    designs = dict()

    for target in built_targets:

        fields = target.split("-", maxsplit=3)
        if len(fields) < 4:
            continue

        arch, design, board, stage = fields
        if stage not in all_stages:
            continue

        print("V", arch, design, board, stage)

        key = (arch, design, board)
        if key not in designs:
            designs[key] = dict()

        designs[key][stage] = True

    for target in failed_targets:

        fields = target.split("-", maxsplit=3)
        if len(fields) < 4:
            continue

        arch, design, board, stage = fields
        if stage not in all_stages:
            continue

        print("X", arch, design, board, stage)

        key = (arch, design, board)
        if key not in designs:
            designs[key] = dict()

        designs[key][stage] = False

    # Add stages not reported in the log as unknown
    for key in designs:
        for stage in all_stages:
            if stage not in designs[key]:
                designs[key][stage] = None

    # Output report
    with open(args.csv, "w") as fp:

        # Header
        fp.write("design,arch,board," + ",".join(all_stages) + "\n")

        # Data
        keys = sorted(designs.keys(), key=lambda x: x[1])
        for key in keys:
            line = "{},{},{}".format(key[1], key[0], key[2])
            for stage in all_stages:
                status = designs[key][stage]
                if status is True:
                    line += ",1"
                elif status is False:
                    line += ",0"
                else:
                    line += ",?"
            line += "\n"
            fp.write(line)

# =============================================================================


if __name__ == "__main__":
    main()
