add_xc7_test(
    name wire
    #TODO: add nexys_video once https://github.com/hdl/conda-eda/issues/108 is solved
    board_list basys3 arty35t zybo arty100t
    sources wire.v
    testbench wire_tb.v
)

add_xc7_validation_test(
    name wire
    board_list arty35t
    testbench wire_tb.v
)
