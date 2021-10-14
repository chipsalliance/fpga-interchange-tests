add_generic_test(
    name lut
    board_list arty35t
    sources lut.v
)

add_generic_test(
    name lut
    board_list testboard
    sources lut_testarch.v
)

add_xc7_validation_test(
    name lut
    board_list arty35t
)
