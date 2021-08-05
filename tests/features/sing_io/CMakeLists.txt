add_generic_test(
    name iobuf
    board_list basys3
    constr_prefix iobuf
    sources iobuf.v
    testbench iobuf_tb.v
)

add_generic_test(
    name obuft
    board_list basys3
    constr_prefix obuft
    sources obuft.v
    testbench obuft_tb.v
)

