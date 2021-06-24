add_generic_test(
    name counter
    board_list basys3 arty35t arty100t lifcl40evn
    sources counter.v
    testbench counter_tb.v
    techmap ../../common/remap_xc7.v
)

add_xc7_validation_test(
    name counter
    board_list basys3
    testbench counter_tb.v
)
