add_generic_test(
    name ram_36bit
    board_list basys3
    sources ram_36bit.v
    testbench ram_36bit_tb.v
)

add_xc7_validation_test(
    name ram_36bit
    board_list basys3
    testbench ram_36bit_tb.v
    disable_vivado_test
)

add_generic_test(
    name ram_36bit
    board_list zcu104
    sources ram_36bit.v ram_36bit_diff.v
    top top_diff
)
