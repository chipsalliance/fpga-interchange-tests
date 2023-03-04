## basys3 breakout board
set_property PACKAGE_PIN F23 [get_ports clk_p]
set_property PACKAGE_PIN E23 [get_ports clk_n]

set_property PACKAGE_PIN M11 [get_ports rst]
set_property PACKAGE_PIN D5 [get_ports io_led[0]]
set_property PACKAGE_PIN D6 [get_ports io_led[1]]
set_property PACKAGE_PIN A5 [get_ports io_led[2]]
set_property PACKAGE_PIN B5 [get_ports io_led[3]]

set_property IOSTANDARD LVDS [get_ports clk_p]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[3]]
