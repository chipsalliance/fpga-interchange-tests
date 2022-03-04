#!/bin/bash
# Copyright (C) 2022  The F4PGA Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

source $(dirname "$0")/common.sh
set -e

du -ah ${INSTALL_DIR}
export GIT_HASH=$(git rev-parse --short HEAD)

echo "========================="
echo "Compressing techmap files"
echo "========================="
mkdir -p ${INSTALL_DIR}/techmaps
cp tests/common/libs/*.v ${INSTALL_DIR}/techmaps
tar -I "pixz" -cvf interchange-techmaps-${GIT_HASH}.tar.xz -C ${INSTALL_DIR} techmaps

echo "======================="
echo "Compressing device data"
echo "======================="
for device in $(ls ${INSTALL_DIR}/devices)
do
    tar -I "pixz" -cvf interchange-$device-${GIT_HASH}.tar.xz -C ${INSTALL_DIR}/devices $device
done

exit 0
