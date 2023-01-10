# Copyright (C) 2021  The Symbiflow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
REQUIREMENTS_FILE := requirements.txt
ENVIRONMENT_FILE := conda_lock.yml

# Paths
RAPIDWRIGHT_PATH ?= $(TOP_DIR)/third_party/RapidWright
NISP_PATH = third_party/nextpnr-fpga-interchange-site-preprocessor

third_party/make-env/conda.mk:
	git submodule init
	git submodule update --init --recursive

include third_party/make-env/conda.mk

.PHONY: update
update:
	pushd ${RAPIDWRIGHT_PATH} && \
		./gradlew updateJars --no-watch-fs && \
		make compile && \
		popd

${NISP_PATH}/nisp:
	@$(IN_CONDA_ENV) cd ${NISP_PATH} && (FPGA_INTERCHANGE_SCHEMA_DIR=third_party/fpga-interchange-schema cargo build --release)
	@ln -s `realpath ${NISP_PATH}/target/release/nisp` ${NISP_PATH}/nisp

.PHONY: nisp
nisp: ${NISP_PATH}/nisp

.PHONY: clean-nisp
clean-nisp:
	@rm -rf ${NISP_PATH}/target
	@unlink ${NISP_PATH}/nisp || true

.PHONY: build
build: ${NISP_PATH}/nisp
	# Build test suite
	@$(IN_CONDA_ENV) mkdir -p build && cd build && cmake .. ${CMAKE_FLAGS}

.PHONY: clean-build
clean-build: clean-nisp
	rm -rf build/*
