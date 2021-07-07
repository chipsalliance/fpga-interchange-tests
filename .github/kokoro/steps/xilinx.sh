#!/bin/bash
# Copyright (C) 2021  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

set -e

ls -l ~/.Xilinx
sudo chown -R $USER ~/.Xilinx

export XILINX_LOCAL_USER_DATA=no

if [[ ! -d /image/Xilinx ]]; then
	echo "========================================"
	echo "Mounting image with Vivado 2019.2"
	echo "----------------------------------------"
	sudo mkdir -p /image
	sudo mount UUID=aaa2471f-444f-4353-bdda-1822f48c0cd6 /image
else
	echo "========================================"
	echo "Xilinx image with Vivado 2019.2 mounted"
	echo "----------------------------------------"
fi

ls -l /image/
ls -l /image/Xilinx/Vivado/
export VIVADO_VERSION=2019.2
export VIVADO_SETTINGS=/image/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh
echo "----------------------------------------"
