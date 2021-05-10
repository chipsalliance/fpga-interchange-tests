add_xc7_test(
    name murax
    board_list basys3
    top toplevel
    sources Murax.v basys3_toplevel.v
    techmap ../common/remap.v
)
