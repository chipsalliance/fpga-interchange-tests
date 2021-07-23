add_generic_test(
    name io_obuftds
    board_list basys3
    constr_prefix obuftds
    sources obuftds.v
    testbench obuftds_tb.v
)

add_generic_test(
    name io_obufds
    board_list basys3
    constr_prefix obufds
    sources obufds.v
    testbench obufds_tb.v
)

