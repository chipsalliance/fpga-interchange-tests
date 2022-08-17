#!/bin/bash
# Copyright (C) 2022  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

set -e
apt-get -qqy update
apt-get -qqy install build-essential git make locales libtinfo-dev \
  cmake python3 wget unzip curl openjdk-11-jdk-headless capnproto
dpkg-reconfigure locales

# Vivado is erroring out due to a missing library in CI.
# https://support.xilinx.com/s/article/76585?language=en_US
ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5
