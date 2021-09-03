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
    re.compile(r".*Built\starget\s(?P<target>.*)")

FAILED_TARGET_RE = \
    re.compile(r".*recipe\sfor\starget\s'(?P<target>.*)'\sfailed")

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
    "vvp",
    "sim",
    "post-synth-vvp",
    "post-synth-sim",
    "fasm2bels",
    "fasm2bels-bit",
    "fasm2bels-fasm",
    "fasm2bels-bit-fasm",
    "fasm2bels-dcp",
    "fasm2bels-diff-fasm",
    "vivado-bit",
    "vivado-report",
    "custom-report",
    "compare-timings",
]


# =============================================================================


def identify_target(target):
    """
    Extracts names of architecture, board, design and stage given the
    executed target name.
    """

    if target.startswith("sim-test-"):
        target = target.replace("sim-test-", "")

        arch = "?"

        if target.startswith("post-synth-"):
            target = target.replace("post-synth-", "")
            pfx = "post-synth-"
        else:
            pfx = ""

        fields = target.split("-")
        if len(fields) == 2:
            design, board = fields
            stage = "sim"

        elif len(fields) == 3:
            design, board, stage = fields

        else:
            return None

        stage = pfx + stage

    else:

        fields = target.split("-", maxsplit=3)
        if len(fields) < 4:
            return None

        arch, design, board, stage = fields
        if stage not in all_stages:
            return None

    return arch, design, board, stage


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--log",
        type=str,
        nargs="+",
        help="Build log"
    )
    parser.add_argument(
        "--csv",
        type=str,
        help="Output CSV report"
    )
    parser.add_argument(
        "--allowed-failures",
        type=str,
        help="Log with allowed failures"
    )

    args = parser.parse_args()

    built_targets = set()
    failed_targets = set()
    allowed_failures = set()

    with open(args.allowed_failures, "r") as fp:
        data = fp.readlines()
        for line in data:
            if "allowed to fail" in line:
                arch, design = line.split()[0].split("-")
                allowed_failures.add((arch, design))

    # Read logs
    for log_name in args.log:

        # Read log
        with open(log_name, "r") as fp:
            log = fp.readlines()

        # Scan successfully built targets and failed targets
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
    designs = dict()
    hard_failures = set()

    for target in built_targets:

        fields = identify_target(target)
        if not fields:
            continue

        arch, design, board, stage = fields

        key = (arch, design, board)
        if key not in designs:
            designs[key] = dict()
        designs[key][stage] = True

    for target in failed_targets:

        fields = identify_target(target)
        if not fields:
            continue

        arch, design, board, stage = fields

        if (arch, design) not in allowed_failures:
            hard_failures.add((arch, design))

        key = (arch, design, board)
        if key not in designs:
            designs[key] = dict()
        designs[key][stage] = False

    # Add stages not reported in the log as unknown
    for key in designs:
        for stage in all_stages:
            if stage not in designs[key]:
                designs[key][stage] = None

    # Aggregate data
    for key, stages in list(designs.items()):
        arch, design, board = key

        if arch == "?":
            del designs[key]

            # Merge statuses by replacing unknown with known
            for key2, stages2 in designs.items():
                if (design, board) == key2[1:]:

                    for stage, v2 in list(stages2.items()):
                        v1 = stages[stage]
                        if v1 is None and v2 is not None:
                            designs[key2][stage] = v2
                        elif v1 is not None and v2 is None:
                            designs[key2][stage] = v1
                        elif v1 is None and v2 is None:
                            pass
                        else:
                            assert False, (key2, stage, v1, v2)

    if hard_failures:
        print("Tests not allowed to fail:")
        for arch, design in hard_failures:
            print(f"\t{arch} {design}")

        exit(1)

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
