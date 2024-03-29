## arty35t

# Clock
set_property LOC E3 [get_ports {io_mainClk}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_mainClk}]

# Serial
set_property LOC D10 [get_ports {io_uart_txd}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_uart_txd}]

set_property LOC A9 [get_ports {io_uart_rxd}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_uart_rxd}]

# sw[7:0] connected to 4 buttons and 4 switches
set_property LOC A8  [get_ports {sw[0]}]
set_property LOC C11 [get_ports {sw[1]}]
set_property LOC C10 [get_ports {sw[2]}]
set_property LOC A10 [get_ports {sw[3]}]
set_property LOC D9  [get_ports {sw[4]}]
set_property LOC C9  [get_ports {sw[5]}]
set_property LOC B9  [get_ports {sw[6]}]
set_property LOC B8  [get_ports {sw[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]

# out[15:0] connected to 4 user LEDs and 4 RGB leds (4x3)
set_property LOC H5  [get_ports {io_led[0]}]
set_property LOC J5  [get_ports {io_led[1]}]
set_property LOC T9  [get_ports {io_led[2]}]
set_property LOC T10 [get_ports {io_led[3]}]
set_property LOC G6  [get_ports {io_led[4]}]
set_property LOC F6  [get_ports {io_led[5]}]
set_property LOC E1  [get_ports {io_led[6]}]
set_property LOC G3  [get_ports {io_led[7]}]
set_property LOC J4  [get_ports {io_led[8]}]
set_property LOC G4  [get_ports {io_led[9]}]
set_property LOC J3  [get_ports {io_led[10]}]
set_property LOC J2  [get_ports {io_led[11]}]
set_property LOC H4  [get_ports {io_led[12]}]
set_property LOC K1  [get_ports {io_led[13]}]
set_property LOC H6  [get_ports {io_led[14]}]
set_property LOC K2  [get_ports {io_led[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports {io_led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[15]}]
