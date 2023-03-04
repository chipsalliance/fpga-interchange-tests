yosys -import

set use_uhdm $::env(USE_UHDM)

if { $use_uhdm } {
    plugin -i systemverilog
    yosys -import
}

foreach src $::env(SOURCES) {
    if { $use_uhdm } {
        read_systemverilog $src
    } else {
        read_verilog $src
    }
}

techmap -map $::env(LIB_DIR)/retarget_xc7.v

synth_xilinx -flatten -nowidelut -nosrl -nodsp

techmap -map $::env(LIB_DIR)/remap_xc7.v

# opt_expr -undriven makes sure all nets are driven, if only by the $undef
# net.
opt_expr -undriven
opt_clean

setundef -zero -params

write_json $::env(OUT_JSON)
write_verilog $::env(OUT_VERILOG)
