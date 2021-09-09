cmake_minimum_required(VERSION 3.5)
project(fpga-interchange)

# RapidWright paths
set(RAPIDWRIGHT_PATH ${PROJECT_SOURCE_DIR}/third_party/RapidWright CACHE PATH "Path to RapidWright")
set(INVOKE_RAPIDWRIGHT "${RAPIDWRIGHT_PATH}/scripts/invoke_rapidwright.sh" CACHE PATH "Path to RapidWright invocation script")
set(JAVA_HEAP_SPACE "-Xmx32g" CACHE STRING "Heap space reserved for Java")

# Interchange paths
set(PYTHON_INTERCHANGE_PATH ${PROJECT_SOURCE_DIR}/third_party/python-fpga-interchange CACHE PATH "Path to the Python FPGA interchange library")
set(INTERCHANGE_SCHEMA_PATH ${PROJECT_SOURCE_DIR}/third_party/fpga-interchange-schema/interchange CACHE PATH "Path to the FPGA interchange schema dir")

# Simulation libraries paths
set(XILINX_UNISIM_DIR ${PROJECT_SOURCE_DIR}/third_party/xilinx-unisims/verilog/src/unisims CACHE PATH "Path to the Xilinx Unisims libraries")

set(VIVADO_VERSION 2019.2 CACHE STRING "Vivado version")
set(VIVADO_SETTINGS /opt/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh CACHE PATH "Path to the Vivado settings script")

# FASM database directory
find_program(PRJXRAY_CONFIG prjxray-config)
if (NOT ${PRJXRAY_CONFIG} STREQUAL "PRJXRAY_CONFIG-NOTFOUND")
  execute_process(
    COMMAND
      bash ${PRJXRAY_CONFIG}
      OUTPUT_VARIABLE PRJXRAY_DB_DIR
  )
  string(STRIP "${PRJXRAY_DB_DIR}" PRJXRAY_DB_DIR)
else ()
  set(PRJXRAY_DB_DIR "PRJXRAY_DB_DIR-NOTFOUND")
endif ()

set(PRJXRAY_DB_DIR "${PRJXRAY_DB_DIR}"
  CACHE PATH "Path to prjxray database directory")

if (${PRJXRAY_DB_DIR} STREQUAL "PRJXRAY_DB_DIR-NOTFOUND")
  message(FATAL_ERROR "Could not find the project xray database directory! Please provide it with the PRJXRAY_DB_DIR variable")
endif ()

include(utils/utils.cmake)

add_custom_target(programs)
set_program(python3)
set_program(yosys)
set_program(nextpnr-fpga_interchange)
set_program(bbasm)
set_program(xcfasm)
set_program(bitread)
set_program(bit2fasm)
set_program(iverilog)
set_program(vvp)
set_program(prjoxide)

include(boards/boards.cmake)
include(devices/chipdb.cmake)

# Tests CMake functions
include(tests/arch_tests.cmake)
include(tests/tests.cmake)
include(tests/litex.cmake)

add_custom_target(all-tests)
add_custom_target(all-timing-comparison-tests)
add_custom_target(all-validation-tests)
add_custom_target(all-vendor-bit-tests)
add_custom_target(all-simulation-tests)
add_custom_target(list-allowed-failing-tests)

add_subdirectory(boards)
add_subdirectory(devices)
add_subdirectory(tests)
