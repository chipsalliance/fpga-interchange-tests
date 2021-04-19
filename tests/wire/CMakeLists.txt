add_xc7_test(
    name wire
    board_list basys3 arty35t zybo arty100t nexys_video
    tcl run.tcl
    sources wire.v
    testbench wire_tb.v
)

add_xc7_validation_test(
    name wire
    board_list arty35t
    testbench wire_tb.v
)
