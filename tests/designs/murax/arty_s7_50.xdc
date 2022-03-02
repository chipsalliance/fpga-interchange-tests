## arty35t

# Clock
set_property LOC R2 [get_ports {io_mainClk}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_mainClk}]

# Serial
set_property LOC R12 [get_ports {io_uart_txd}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_uart_txd}]

set_property LOC V12 [get_ports {io_uart_rxd}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_uart_rxd}]

# sw[7:0] connected to 4 buttons and 4 switches
set_property LOC H14 [get_ports {sw[0]}]
set_property LOC H18 [get_ports {sw[1]}]
set_property LOC G18 [get_ports {sw[2]}]
set_property LOC M5  [get_ports {sw[3]}]
set_property LOC G15 [get_ports {sw[4]}]
set_property LOC K16 [get_ports {sw[5]}]
set_property LOC J16 [get_ports {sw[6]}]
set_property LOC H13 [get_ports {sw[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]

# out[9:0] connected to 4 user LEDs and 2 RGB leds (2x3)
set_property LOC E18 [get_ports {io_led[0]}]
set_property LOC F13 [get_ports {io_led[1]}]
set_property LOC E13 [get_ports {io_led[2]}]
set_property LOC H15 [get_ports {io_led[3]}]
set_property LOC J15 [get_ports {io_led[4]}]
set_property LOC G17 [get_ports {io_led[5]}]
set_property LOC F15 [get_ports {io_led[6]}]
set_property LOC E15 [get_ports {io_led[7]}]
set_property LOC F18 [get_ports {io_led[8]}]
set_property LOC E14 [get_ports {io_led[9]}]

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
