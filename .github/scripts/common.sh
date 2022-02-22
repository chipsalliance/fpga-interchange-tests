#!/bin/bash
# Copyright (C) 2022  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

function enable_vivado() {
    echo
    echo "======================================="
    echo "Creating Vivado Symbolic Link"
    echo "---------------------------------------"
	ln -s /mnt/aux/Xilinx /opt/Xilinx
	ls /opt/Xilinx/Vivado
	export XRAY_VIVADO_SETTINGS="/opt/Xilinx/Vivado/$1/settings64.sh"
	source /opt/Xilinx/Vivado/$1/settings64.sh
	vivado -version
}
