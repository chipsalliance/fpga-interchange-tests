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
	pushd ${RAPIDWRIGHT_PATH} && \
		make update_jars && \
		popd
	# Build test suite
	@$(IN_CONDA_ENV) mkdir -p build && cd build && cmake ${CMAKE_FLAGS} ..

clean-build:
	rm -rf build
