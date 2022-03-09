## LPDDR4 test board

# Clock
set_property LOC L19 [get_ports {io_mainClk}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_mainClk}]

# Serial
set_property LOC AB18 [get_ports {io_uart_txd}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_uart_txd}]

set_property LOC AA18 [get_ports {io_uart_rxd}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_uart_rxd}]

# sw[3:0] connected 4 buttons
set_property LOC E8 [get_ports {sw[0]}]
set_property LOC B8 [get_ports {sw[1]}]
set_property LOC C9 [get_ports {sw[2]}]
set_property LOC E9 [get_ports {sw[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]

# out[4:0] connected to 5 user LEDs
set_property LOC F8 [get_ports {io_led[0]}]
set_property LOC C8 [get_ports {io_led[1]}]
set_property LOC A8 [get_ports {io_led[2]}]
set_property LOC D9 [get_ports {io_led[3]}]
set_property LOC F9 [get_ports {io_led[4]}]

set_property IOSTANDARD LVCMOS33 [get_ports {io_led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {io_led[4]}]
