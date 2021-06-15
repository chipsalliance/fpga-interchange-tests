add_xc7_test(
    name pll
    board_list basys3
    sources pll_top.v plle2_test.v
    techmap ../../common/remap.v
    testbench pll_tb.v
)
