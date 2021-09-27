yosys -import

foreach src $::env(SOURCES) {
    read_verilog $src
}

if { $::env(RETARGET) != "" } {
    techmap -map $::env(RETARGET)
}

synth_xilinx -flatten -nowidelut -nosrl -nodsp

if { $::env(TECHMAP) != "" } {
    techmap -map $::env(TECHMAP)
}

# opt_expr -undriven makes sure all nets are driven, if only by the $undef
# net.
opt_expr -undriven
opt_clean

setundef -zero -params

write_json $::env(OUT_JSON)
write_verilog $::env(OUT_VERILOG)
