add_generic_test(
    name pll
    board_list basys3
    sources pll_top.v plle2_test.v
    techmap ../../common/remap_xc7.v
    testbench pll_tb.v
)
