add_xc7_test(
    name counter
    board_list basys3 arty35t arty100t
    sources counter.v
    testbench counter_tb.v
    techmap ../common/remap.v
)

add_xc7_validation_test(
    name counter
    board_list basys3
    testbench counter_tb.v
)
