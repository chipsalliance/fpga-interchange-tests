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

.PHONY: update
update:
	git submodule init
	git submodule update --init --recursive
	pushd ${RAPIDWRIGHT_PATH} && \
		make update_jars && \
		popd
	# FIXME: Temporary patch for RapidWright. See https://github.com/Xilinx/RapidWright/issues/209
	pushd ${RAPIDWRIGHT_PATH} && \
		wget https://github.com/Xilinx/RapidWright/releases/download/v2020.2.7-beta/rapidwright_api_lib-2020.2.7-patch1.zip && \
		unzip -o rapidwright_api_lib-2020.2.7-patch1.zip && \
		rm -rf rapidwright_api_lib-2020.2.7-patch1.zip && \
		popd

.PHONY: build
build: update
	# Build test suite
	@$(IN_CONDA_ENV) mkdir -p build && cd build && cmake ${CMAKE_FLAGS} ..

.PHONY: clean-build
clean-build:
	rm -rf build/*
