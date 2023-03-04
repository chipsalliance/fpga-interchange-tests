set(murax ${CMAKE_SOURCE_DIR}/third_party/murax/Murax.v)

function(murax board)
    add_generic_test(
        name murax
        board_list ${board}
        top toplevel
        sources ${board}_toplevel.v
        absolute_sources ${murax}
    )
endfunction()

murax(basys3)
murax(arty35t)
murax(arty_s7_50)
murax(lifcl40evn)
murax(xc7k70t_board)
murax(xc7vx980t_board)
murax(zcu104)
