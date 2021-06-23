add_generic_test(
    name counter
    board_list basys3 arty35t arty100t
    sources counter.v
    testbench counter_tb.v
    techmap ../../common/remap_xc7.v
)

add_generic_test(
    name counter
    board_list lifcl40evn
    sources counter.v
    techmap ../../common/remap_nexus.v
)

add_xc7_validation_test(
    name counter
    board_list basys3
    testbench counter_tb.v
)
