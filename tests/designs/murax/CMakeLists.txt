set(murax ${CMAKE_SOURCE_DIR}/third_party/murax/Murax.v)

add_generic_test(
    name murax
    board_list basys3
    top toplevel
    sources basys3_toplevel.v
    absolute_sources ${murax}
)

add_generic_test(
    name murax
    board_list arty35t
    top toplevel
    sources arty35t_toplevel.v
    absolute_sources ${murax}
)

add_generic_test(
    name murax
    board_list lifcl40evn
    top toplevel
    sources lifcl40evn_toplevel.v
    absolute_sources ${murax}
)
