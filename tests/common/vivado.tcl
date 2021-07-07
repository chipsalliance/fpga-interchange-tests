# Common TCL file to run the Vivado bistream generation.
#
# Have the following environment variables set to correctly run this script:
#   - OUTPUT_DIR
#   - NAME
#   - PART
#   - TOP
#   - XDC
#   - SOURCES
#   - BIT_FILE

create_project -force -part $::env(PART) $::env(NAME) $::env(OUTPUT_DIR)

foreach src $::env(SOURCES) {
    read_verilog $src
}

set top $::env(TOP)
if { $::env(TOP) == "" } {
    set top "top"
}

synth_design -top $top
read_xdc -no_add $::env(XDC)

place_design
route_design
if { $::env(ARCH) == "xc7" } {
    set_property CFGBVS VCCO [current_design]
    set_property CONFIG_VOLTAGE 3.3 [current_design]
}
set_property BITSTREAM.GENERAL.PERFRAMECRC YES [current_design]

# Reports
report_utilization -file $::env(OUTPUT_DIR)/utilization.rpt
report_clock_utilization -file $::env(OUTPUT_DIR)/clock_utilization.rpt
report_timing_summary -datasheet -max_paths 10 -file $::env(OUTPUT_DIR)/timing_summary.rpt
report_power -file $::env(OUTPUT_DIR)/power.rpt
report_route_status -file $::env(OUTPUT_DIR)/route_status.rpt

# Write checkpoint
write_checkpoint -force $::env(OUTPUT_DIR)/$::env(NAME).dcp

# Write bitstream
write_bitstream -force $::env(BIT_FILE)
