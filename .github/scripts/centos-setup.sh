#!/bin/bash
# Copyright (C) 2022  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

set -e
yum -y update
yum -y install epel-release
yum -y groupinstall 'Development Tools'
yum -y install make which git python3 wget unzip curl \
  java-11-openjdk-headless java-11-openjdk java-11-openjdk-devel capnproto-devel

# Cmake3 install
yum -y install cmake3
ln -s /usr/bin/cmake3 /usr/bin/cmake

# Upgrade make version
wget http://ftp.gnu.org/gnu/make/make-4.2.1.tar.gz
tar -xvf make-4.2.1.tar.gz
pushd make-4.2.1
./configure
make
make install
popd
ln -sf /usr/local/bin/make /usr/bin/make

# Copy java.capnp needed by NISP
cp ./third_party/nextpnr-fpga-interchange-site-preprocessor/third_party/capnproto-java/compiler/src/main/schema/capnp/java.capnp /usr/include/capnp/java.capnp

# Check versions
make --version
cmake --version
java --version
