## basys3 breakout board

# Differential Clock
set_property PACKAGE_PIN F23 [get_ports clk_p]
set_property PACKAGE_PIN E23 [get_ports clk_n]

set_property IOSTANDARD LVDS [get_ports clk_p]

# Leds
set_property PACKAGE_PIN D5 [get_ports io_led[0]]
set_property PACKAGE_PIN D6 [get_ports io_led[1]]
set_property PACKAGE_PIN A5 [get_ports io_led[2]]
set_property PACKAGE_PIN B5 [get_ports io_led[3]]

set_property IOSTANDARD LVCMOS33 [get_ports io_led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[3]]

# Serial
set_property LOC C19 [get_ports {io_uart_txd}]
set_property IOSTANDARD LVCMOS18 [get_ports {io_uart_txd}]

set_property LOC A20 [get_ports {io_uart_rxd}]
set_property IOSTANDARD LVCMOS18 [get_ports {io_uart_rxd}]
