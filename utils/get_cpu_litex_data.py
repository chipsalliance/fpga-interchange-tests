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

import argparse
import importlib
import os

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--data-file", required=True, help="Data file to locate")
    parser.add_argument("--cpu-library", required=True, help="pyhtondata library")

    args = parser.parse_args()

    cpu_library = importlib.import_module(args.cpu_library)
    print(os.path.join(cpu_library.data_location, args.data_file), end = '')

if __name__ == "__main__":
    main()
