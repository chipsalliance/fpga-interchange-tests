add_xc7_test(
    name ram
    board_list basys3
    tcl run.tcl
    sources ram.v
    testbench ram_tb.v
)

# TODO: add validation test once RAMB FASM Generation is supported
