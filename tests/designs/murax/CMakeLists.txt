add_xc7_test(
    name murax
    board_list basys3
    top toplevel
    sources basys3_toplevel.v
    absolute_sources ${CMAKE_SOURCE_DIR}/third_party/murax/Murax.v
    techmap ../../common/remap.v
)
