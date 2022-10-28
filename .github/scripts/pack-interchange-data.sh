#!/bin/bash
#
# Copyright 2018-2022 F4PGA Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

# =============================================================================

# This script is used by CI to create tarballs with device data and techmaps
# for the FPGA interchange format. Additionally creates files with links to
# the tarball on external storage. We upload them to the release section
# in GitHub Actions.
#
# Usage:
# install.sh <interchange-tarballs-dir> <links-dir> <link-prefix>

set -e
set -x

# Global variables
DEVICE_DATA_DIR=$1
LINK_DIR=$2
LINK_PREFIX=$3

INSTALL_DIR="$(pwd)/install"

# Prepare environment
make env
source env/conda/bin/activate fpga-interchange

export CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}"

make build
make update

# Build device data
pushd build
make install
popd

# Copy techmaps
mkdir -p "${INSTALL_DIR}/techmaps"
cp tests/common/libs/*.v "${INSTALL_DIR}/techmaps"

# Create output directories
mkdir -p "${DEVICE_DATA_DIR}"
mkdir -p "${LINK_DIR}"

# Prepare tarballs and links
GIT_HASH=$(git rev-parse --short HEAD)

TECHMAPS_TARBALL_NAME="interchange-techmaps-${GIT_HASH}.tar.xz"
TECHMAPS_LINK_NAME="interchange-techmaps-latest"

tar -I "pixz" -cvf "${DEVICE_DATA_DIR}/${TECHMAPS_TARBALL_NAME}" -C "${INSTALL_DIR}" techmaps
echo "${LINK_PREFIX}/${TECHMAPS_TARBALL_NAME}" > "${LINK_DIR}/${TECHMAPS_LINK_NAME}"

for device in $(ls "${INSTALL_DIR}/devices")
do
    DEVICE_TARBALL_NAME="interchange-${device}-${GIT_HASH}.tar.xz"
    DEVICE_LINK_NAME="interchange-${device}-latest"

    tar -I "pixz" -cvf "${DEVICE_DATA_DIR}/${DEVICE_TARBALL_NAME}" -C "${INSTALL_DIR}/devices" "${device}"
    echo "${LINK_PREFIX}/${DEVICE_TARBALL_NAME}" > "${LINK_DIR}/${DEVICE_LINK_NAME}"
done
