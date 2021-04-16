add_xc7_test(
    name lut
    board_list arty35t
    tcl run.tcl
    sources lut.v
)

add_xc7_validation_test(
    name lut
    board_list arty35t
)
