TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
REQUIREMENTS_FILE := requirements.txt
ENVIRONMENT_FILE := environment.yml

third_party/make-env/conda.mk:
	git submodule init
	git submodule update --init --recursive

include third_party/make-env/conda.mk

env:: | $(CONDA_ENV_PYTHON)
	git submodule init
	git submodule update --init --recursive
	# Update RapidWright jars
	pushd third_party/RapidWright && make update_jars && popd
	@$(IN_CONDA_ENV) mkdir -p build && cd build && cmake ..
