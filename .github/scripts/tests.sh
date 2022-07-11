#!/bin/bash
# Copyright (C) 2021  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

source $(dirname "$0")/common.sh
set -e
enable_vivado 2017.2

DEVICE=$1

source env/conda/bin/activate fpga-interchange
cd build

make chipdb-${DEVICE}-bin

# Run tests (allow failures)
set +e
for SUITE in simulation-tests tests validation-tests $3
do
    make all-${DEVICE}-${SUITE} -j$(nproc) -k --output-sync=target 2>&1 | tee all-${DEVICE}-${SUITE}.log
done

make list-allowed-failing-tests | tee allowed-failures.log

# Do not fail here so that failing designs are included in the report generated
# later.
exit 0
