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
This script aggregates reports from individual CI runs for each device and
prepares them for presentation on a webpage.
"""
import argparse
import os
import csv
import shutil

# =============================================================================


# Target name map. Maps names of CMake targets to more user-friendly strings
TARGET_NAME_MAP = (
    ("json", "Synthesis"),
    ("netlist", "Logical netlist"),
    ("phys", "Place & route (Physical netlist)"),
    ("fasm", "FASM generation"),
    ("bit", "Bitstream (FASM generator)"),
    ("sim", "Simulation"),
    ("post-synth-sim", "Post-synthesis simulation"),
)

# Architecture specific target name map
ARCH_TARGET_NAME_MAP = {
    "xc7": (
        ("vivado-bit", "Bitstream (Vivado)"),
        ("dcp", "Vivado checkpoint"),
        ("dcp-bit", "Bitstream (DCP)"),
        ("dcp-diff-fasm", "FASM bitstream vs. DCP bitstream"),
        ("fasm2bels", "FASM (fasm2bels)"),
        ("fasm2bels-dcp", "Vivado checkpoint (fasm2bels)"),
        ("fasm2bels-bit", "Bitstream (fasm2bels DCP)"),
        ("fasm2bels-diff-fasm", "fasm2bels bitstream vs. DCP Bitstream"),
    )
}

# Target status string map
STATUS_MAP = {
    "?": "Not run",
    "0": "FAILED",
    "1": "Ok",
}

# =============================================================================

# Per-device RST template for Sphinx
TEMPLATE = """
{device}
##########

Designs support status

.. csv-table::
    :file: {device}.csv
    :header-rows: 1

CI performance graph

.. image:: {device}-perf.svg
    :width: 400

"""

# =============================================================================


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--inp",
        type=str,
        default=".",
    )
    parser.add_argument(
        "--out",
        type=str,
        default="./report/source",
    )
    args = parser.parse_args()

    # Scan for device report files.
    device_files = dict()
    for name in os.listdir(args.inp):

        if not name.startswith("fpga-interchange-tests-"):
            continue

        pathname = os.path.join(args.inp, name)
        if not os.path.isdir(pathname):
            continue

        # Get the device name
        device = name.replace("fpga-interchange-tests-", "")
        device_files[device] = dict()

        # Test status report
        fname = os.path.join(pathname, "build", "report.csv")
        if os.path.isfile(fname):
            device_files[device]["report"] = fname

        # Performance graph
        fname = os.path.join(pathname, "plot_Run_Nextpnr_Tests_{}_.svg".format(device))
        if os.path.isfile(fname):
            device_files[device]["plot"] = fname

        else:
            fname = os.path.join(pathname, "plot_Run_Nextpnr_Tests_{}_.svg".format(
                device.replace("-", "_")))
            if os.path.isfile(fname):
                device_files[device]["plot"] = fname

    # Generate content
    for device, files in device_files.items():

        assert "report" in files, (device, files)

        # Load CSV report
        with open(files["report"], "r") as fp:
            reader = csv.DictReader(fp)
            rows = [r for r in reader]

        # FIXME: Assume that arch is the same everywhere
        # (this is checked later)
        arch = rows[0]["arch"]
        target_name_map = \
            list(TARGET_NAME_MAP) + list(ARCH_TARGET_NAME_MAP.get(arch, ()))

        # Generate CSV table
        designs = dict()
        for row in rows:
            key = (row["design"], row["board"])

            if row["arch"] != arch:
                print("W: Architecture mismatch in '{}'".format(*key))
                continue

            designs[key] = []
            for (old, new) in target_name_map:
                val = row.get(old, "?")
                val = STATUS_MAP.get(val, val)
                designs[key].append(val)

        fname = os.path.join(args.out, "{}.csv".format(device))
        with open(fname, "w") as fp:

            # Header
            line = "Design,Board," + ",".join([m[1] for m in target_name_map])
            fp.write(line + "\n")

            # Data
            keys = sorted(designs.keys())
            for key in keys:
                fields = designs[key]
                line = "{},{},".format(*key) + ",".join(fields)
                fp.write(line + "\n")

        # Copy the performance plot (if present)
        if "plot" in files:
            fname = os.path.join(args.out, "{}-perf.svg".format(device))
            shutil.copy(files["plot"], fname)

        # Render the device RST template
        template_dict = {
            "device": device
        }

        fname = os.path.join(args.out, "{}.rst".format(device))
        with open(fname, "w") as fp:
            fp.write(TEMPLATE.format(**template_dict))

    # "Master" RST file (jist includes)
    fname = os.path.join(args.out, "devices.rst")
    with open(fname, "w") as fp:
        for device in sorted(device_files.keys()):
            fp.write(".. include:: {}.rst\n".format(device))


# =============================================================================


if __name__ == "__main__":
    main()

