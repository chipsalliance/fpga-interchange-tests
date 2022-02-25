add_generic_test(
    name serdes
    board_list basys3
    sources serdes.v serdes_test.v
)

# FIXME: routing error
add_generic_test(
    name oserdese3
    board_list zcu104
    sources oserdese3.v
    constr_prefix oserdese3
)
