add_generic_test(
    name obuftds
    board_list basys3
    constr_prefix obuftds
    sources obuftds.v
    testbench obuftds_tb.v
)

add_generic_test(
    name obufds
    board_list basys3
    constr_prefix obufds
    sources obufds.v
    testbench obufds_tb.v
)

add_generic_test(
    name ibufds
    board_list basys3
    constr_prefix ibufds
    sources ibufds.v
    testbench ibufds_tb.v
)

add_generic_test(
    name iobufds
    board_list basys3
    constr_prefix iobufds
    sources iobufds.v
    testbench iobufds_tb.v
)

