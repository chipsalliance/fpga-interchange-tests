add_generic_test(
    name pll_int_fb
    board_list basys3
    sources pll_int_basys3.v plle2_test.v
)

# FIXME: Disabled due to https://github.com/SymbiFlow/fpga-interchange-tests/issues/70
#add_generic_test(
#    name pll_ext_fb
#    board_list basys3
#    sources pll_ext_basys3.v plle2_test.v
#)

add_generic_test(
    name pll_buf_fb
    board_list basys3
    sources pll_buf_basys3.v plle2_test.v
)

add_generic_test(
    name plle4_adv
    board_list zcu104
    sources util.v plle4_adv.v
    failure_allowed
)

add_generic_test(
    name plle4_base
    board_list zcu104
    sources util.v plle4_base.v
    failure_allowed
)

