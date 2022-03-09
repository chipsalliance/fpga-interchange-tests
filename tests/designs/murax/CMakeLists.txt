set(murax ${CMAKE_SOURCE_DIR}/third_party/murax/Murax.v)

add_generic_test(
    name murax
    board_list basys3 xc7vx980t_board
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
    board_list arty_s7_50
    top toplevel
    sources arty_s7_50_toplevel.v
    absolute_sources ${murax}
)

add_generic_test(
    name murax
    board_list lifcl40evn
    top toplevel
    sources lifcl40evn_toplevel.v
    absolute_sources ${murax}
)

add_generic_test(
    name murax
    board_list xc7k70t_board
    top toplevel
    sources xc7k70t_board_toplevel.v
    absolute_sources ${murax}
)
