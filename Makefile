# Copyright (C) 2021  The Symbiflow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
REQUIREMENTS_FILE := requirements.txt
ENVIRONMENT_FILE := environment.yml
CMAKE_FLAGS ?= ""

# Paths
RAPIDWRIGHT_PATH ?= $(TOP_DIR)/third_party/RapidWright

third_party/make-env/conda.mk:
	git submodule init
	git submodule update --init --recursive

include third_party/make-env/conda.mk

build:
	git submodule init
	git submodule update --init --recursive
	# Update RapidWright jars
	# TODO: remove patch once https://github.com/Xilinx/RapidWright/issues/183 is solved
	pushd ${RAPIDWRIGHT_PATH} && \
		make update_jars && \
		wget https://github.com/Xilinx/RapidWright/releases/download/v2020.2.5-beta/rapidwright_api_lib-2020.2.5-patch1.zip && \
		unzip -o rapidwright_api_lib-2020.2.5-patch1.zip && \
		popd
	@$(IN_CONDA_ENV) pushd third_party/prjoxide/libprjoxide && \
		( curl --proto '=https' -sSf https://sh.rustup.rs | sh -s -- -y ) && \
		source ${HOME}/.cargo/env && \
		cargo install --path prjoxide --all-features && \
		popd
	# Build test suite
	@$(IN_CONDA_ENV) mkdir -p build && cd build && cmake $(CMAKE_FLAGS) -DPRJOXIDE=${HOME}/.cargo/bin/prjoxide ..

clean-build:
	rm -rf build
