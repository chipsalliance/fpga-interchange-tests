add_generic_test(
    name counter
    board_list basys3 arty35t arty100t xc7k480t_board xc7vx980t_board lifcl40evn
    sources counter.v
    testbench counter_tb.v
    techmap ../../common/remap_xc7.v
)

add_generic_test(
    name counter
    board_list zcu104
    sources counter_diff_clk.v
)

add_xc7_validation_test(
    name counter
    board_list basys3
    testbench counter_tb.v
    disable_vivado_test
)
