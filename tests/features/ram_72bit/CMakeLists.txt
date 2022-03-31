add_generic_test(
    name ram_72bit
    board_list zcu104
    sources ram_72bit.v ram_72bit_diff.v
    top top_diff
)
