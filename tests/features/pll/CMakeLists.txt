add_generic_test(
    name pll_int_fb
    board_list basys3
    sources pll_int_basys3.v plle2_test.v
)

add_generic_test(
    name pll_ext_fb
    board_list basys3
    sources pll_ext_basys3.v plle2_test.v
)

add_generic_test(
    name pll_buf_fb
    board_list basys3
    sources pll_buf_basys3.v plle2_test.v
)
