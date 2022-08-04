add_generic_test(
    name counter_sv
    board_list basys3 arty35t arty100t arty_s7_25 arty_s7_50 xc7k70t_board xc7k160t_board xc7k480t_board xc7vx980t_board lifcl40evn
    sources counter.sv
    uhdm
)

add_generic_test(
    name counter_sv
    board_list zcu104
    sources counter_diff_clk.sv
    uhdm
)
