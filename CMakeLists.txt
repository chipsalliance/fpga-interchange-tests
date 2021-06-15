cmake_minimum_required(VERSION 3.5)
project(fpga-interchange)

set(RAPIDWRIGHT_PATH ${PROJECT_SOURCE_DIR}/third_party/RapidWright CACHE PATH "Path to RapidWright")
set(INVOKE_RAPIDWRIGHT "${RAPIDWRIGHT_PATH}/scripts/invoke_rapidwright.sh" CACHE PATH "Path to RapidWright invocation script")
set(JAVA_HEAP_SPACE "-Xmx8g" CACHE STRING "Heap space reserved for Java")

set(PYTHON_INTERCHANGE_PATH ${PROJECT_SOURCE_DIR}/third_party/python-fpga-interchange CACHE PATH "Path to the Python FPGA interchange library")
set(INTERCHANGE_SCHEMA_PATH ${PROJECT_SOURCE_DIR}/third_party/fpga-interchange-schema/interchange CACHE PATH "Path to the FPGA interchange schema dir")
set(NEXTPNR_SHARE_DIR $ENV{CONDA_PREFIX}/share/nextpnr-fpga_interchange CACHE PATH "Path to the nextpnr-fpga_interchange share directory")
set(XILINX_UNISIM_DIR ${PROJECT_SOURCE_DIR}/third_party/xilinx-unisims/verilog/src/unisims CACHE PATH "Path to the Xilinx Unisims libraries")

set(VIVADO_VERSION 2017.2 CACHE STRING "Vivado version")
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

find_program(python3 python3 REQUIRED)
find_program(yosys yosys REQUIRED)
find_program(nextpnr-interchange nextpnr-fpga_interchange REQUIRED)
find_program(bbasm bbasm REQUIRED)
find_program(xcfasm xcfasm REQUIRED)
find_program(bitread bitread REQUIRED)
find_program(iverilog iverilog REQUIRED)
find_program(vvp vvp REQUIRED)

add_custom_target(programs)
set_target_properties(
  programs
  PROPERTIES
    PYTHON3 ${python3}
    YOSYS ${yosys}
    NEXTPNR_INTERCHANGE ${nextpnr-interchange}
    BBASM ${bbasm}
    XCFASM ${xcfasm}
    BITREAD ${bitread}
    IVERILOG ${iverilog}
    VVP ${vvp}
)

include(boards/boards.cmake)
include(devices/chipdb.cmake)
include(tests/tests.cmake)

add_custom_target(all-xc7-tests)
add_custom_target(all-xc7-validation-tests)
add_custom_target(all-xc7-vivado-bit-tests)
add_custom_target(all-simulation-tests)

add_subdirectory(boards)
add_subdirectory(devices)
add_subdirectory(tests)
