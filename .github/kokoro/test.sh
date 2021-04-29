#!/bin/bash

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
    make all-xc7-tests -j$NUM_CORES
    make all-xc7-validation-tests -j$NUM_CORES
    make all-simulation-tests -j$NUM_CORES
)
echo "-------------------------------------------"
