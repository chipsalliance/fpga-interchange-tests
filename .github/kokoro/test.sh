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

INSTALL_DIR="$(pwd)/install"
export CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}"

DEVICES="xc7a35t xc7a100t xc7a200t xc7z010 xczu7ev"

source ./.github/kokoro/steps/xilinx.sh
source ./.github/kokoro/steps/hostsetup.sh
source ./.github/kokoro/steps/hostinfo.sh
source ./.github/kokoro/steps/git.sh

if [ -z $NUM_CORES  ]; then
    echo "Missing $$NUM_CORES value"
    exit 1
fi

echo
echo "==========================================="
echo "Building device data"
echo "-------------------------------------------"
(
    source env/conda/bin/activate fpga-interchange
    pushd build
    for DEVICE in $DEVICES
    do
        make chipdb-$DEVICE-bin -j$NUM_CORES
    done
    popd
)
echo "-------------------------------------------"

echo
echo "==========================================="
echo "Running FPGA interchange tests"
echo "-------------------------------------------"
(
    source env/conda/bin/activate fpga-interchange
    pushd build
    set +e
    for TARGET in simulation-tests tests validation-tests vendor-bit-tests timing-comparison-tests
    do
        for DEVICE in $DEVICES
        do
            make all-$DEVICE-$TARGET -j$NUM_CORES -k --output-sync=target 2>&1 | tee all-${DEVICE}-${TARGET}.log
        done
    done
    make list-allowed-failing-tests | tee allowed-failures.log
    popd
)
echo "-------------------------------------------"

echo
echo "==========================================="
echo "Preparing design status report"
echo "-------------------------------------------"
(
    source env/conda/bin/activate fpga-interchange
    pushd build
    python ../utils/report_targets.py --log `find . -name "all*tests.log"` --csv report.csv --allowed-failures allowed-failures.log
    cat report.csv
    popd
)

echo
echo "==========================================="
echo "Install interchange devices"
echo "-------------------------------------------"
(
    source env/conda/bin/activate fpga-interchange
    pushd build
    make install
    popd
    cp environment.yml $INSTALL_DIR
    mkdir -p $INSTALL_DIR/techmaps
    cp tests/common/remap*.v $INSTALL_DIR/techmaps

    du -ah $INSTALL_DIR
    export GIT_HASH=$(git rev-parse --short HEAD)
    tar -I "pixz" -cvf interchange-techmaps-${GIT_HASH}.tar.xz -C $INSTALL_DIR techmaps
    for device in $(ls $INSTALL_DIR/devices)
    do
        tar -I "pixz" -cvf interchange-$device-${GIT_HASH}.tar.xz -C $INSTALL_DIR/devices $device
    done
)
echo "-------------------------------------------"
