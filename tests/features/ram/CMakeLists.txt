add_generic_test(
    name ram
    board_list basys3
    sources ram.v
    testbench ram_tb.v
)

add_xc7_validation_test(
    name ram
    board_list basys3
    testbench ram_tb.v
    disable_vivado_test
)

add_generic_test(
    name ram
    board_list zcu104
    sources ram.v ram_diff.v
    top top_diff
)