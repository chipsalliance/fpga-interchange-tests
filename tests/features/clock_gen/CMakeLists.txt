add_generic_test(
    name clock_gen
    board_list basys3
    sources clock_gen_top.v plle2.v mmcme2.v
    testbench clock_gen_tb.v
    failure_allowed
)
