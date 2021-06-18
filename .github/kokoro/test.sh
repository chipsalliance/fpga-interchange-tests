#!/bin/bash
# Copyright (C) 2021  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

set -e

cd github/$KOKORO_DIR

source ./.github/kokoro/steps/hostsetup.sh
source ./.github/kokoro/steps/hostinfo.sh
source ./.github/kokoro/steps/git.sh

if [ -z $NUM_CORES  ]; then
    echo "Missing $$NUM_CORES value"
    exit 1
fi

echo
echo "==========================================="
echo "Running FPGA interchange tests"
echo "-------------------------------------------"
(
    source env.sh
    pushd build
    make all-simulation-tests -j$NUM_CORES
    make all-tests -j$NUM_CORES
    make all-validation-tests -j$NUM_CORES
    make all-vendor-bit-tests -j$NUM_CORES
    popd
)
echo "-------------------------------------------"
