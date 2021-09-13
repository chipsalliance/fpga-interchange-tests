add_generic_test(
    name mmcm_int_fb
    board_list basys3
    sources mmcm_int_basys3.v mmcme2_test.v
)

add_generic_test(
    name mmcm_int_fb_frac
    board_list basys3
    sources mmcm_int_frac_basys3.v mmcme2_test.v
)

add_generic_test(
    name mmcm_ext_fb
    board_list basys3
    sources mmcm_ext_basys3.v mmcme2_test.v
)

add_generic_test(
    name mmcm_buf_fb
    board_list basys3
    sources mmcm_buf_basys3.v mmcme2_test.v
)
