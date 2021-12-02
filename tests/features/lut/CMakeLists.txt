add_generic_test(
    name lut
    board_list arty35t
    sources lut.v
)

add_generic_test(
    name lut_ff
    board_list testboard testboard_noffmux
    sources lut_ff.v
    generated_xdc testboard.xdc
)

add_generic_test(
    name lut_routethru
    board_list testboard_noffmux
    sources lut_routethru.v
    generated_xdc lut_routethru.xdc
)

add_xc7_validation_test(
    name lut
    board_list arty35t
    disable_vivado_test
)
