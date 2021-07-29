add_generic_test(
    name ram36
    board_list basys3
    sources ram36.v
    testbench ram36_tb.v
)

add_xc7_validation_test(
    name ram36
    board_list basys3
    testbench ram36_tb.v
    disable_vivado_test
)
