cmake_minimum_required(VERSION 3.5)
project(fpga-interchange)

set(RAPIDWRIGHT_PATH ${PROJECT_SOURCE_DIR}/third_party/RapidWright CACHE PATH "Path to RapidWright")
set(INVOKE_RAPIDWRIGHT "${RAPIDWRIGHT_PATH}/scripts/invoke_rapidwright.sh" CACHE PATH "Path to RapidWright invocation script")
set(INTERCHANGE_SCHEMA_PATH ${PROJECT_SOURCE_DIR}/third_party/fpga-interchange-schema/interchange CACHE PATH "Path to the FPGA interchange schema dir")
set(NEXTPNR_SHARE_DIR $ENV{CONDA_PREFIX}/share/nextpnr-fpga_interchange CACHE PATH "Path to the nextpnr-fpga_interchange share directory")

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

include(boards/boards.cmake)
include(tests/tests.cmake)

add_custom_target(all-xc7-tests)

add_subdirectory(boards)
add_subdirectory(tests)
