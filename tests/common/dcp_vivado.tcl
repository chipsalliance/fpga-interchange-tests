# Common TCL file to run the Vivado bistream generation.
#
# Have the following environment variables set to correctly run this script:
#   - OUTPUT_DIR
#   - DCP_FILE
#   - BIT_FILE

open_checkpoint $::env(DCP_FILE)

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.PERFRAMECRC YES [current_design]

# Disable some DRC checks
# TODO: understand why the XDC output with IO constr generated from fasm2bels is empty.
set_property IS_ENABLED 0 [get_drc_checks {NSTD-1}]

# Reports
report_utilization -file $::env(OUTPUT_DIR)/utilization.rpt
report_clock_utilization -file $::env(OUTPUT_DIR)/clock_utilization.rpt
report_timing_summary -datasheet -max_paths 10 -file $::env(OUTPUT_DIR)/timing_summary.rpt
report_power -file $::env(OUTPUT_DIR)/power.rpt
report_route_status -file $::env(OUTPUT_DIR)/route_status.rpt

# Write bitstream
write_bitstream -force $::env(BIT_FILE)
