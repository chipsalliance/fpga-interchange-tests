yosys -import

foreach src $::env(SOURCES) {
    read_verilog $src
}

read_verilog -lib -specify $::env(LIB_DIR)/cell_sim_test.v

synth -lut 4

techmap -map $::env(LIB_DIR)/remap_test.v

# opt_expr -undriven makes sure all nets are driven, if only by the $undef
# net.
opt_expr -undriven
opt_clean

setundef -zero -params

write_json $::env(OUT_JSON)
write_verilog $::env(OUT_VERILOG)
