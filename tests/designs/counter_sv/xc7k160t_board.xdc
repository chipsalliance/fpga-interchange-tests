# Pinout for FFG676 package
set_property PACKAGE_PIN C12 [get_ports clk]
set_property PACKAGE_PIN C21 [get_ports rst]
set_property PACKAGE_PIN D21 [get_ports io_led[0]]
set_property PACKAGE_PIN B20 [get_ports io_led[1]]
set_property PACKAGE_PIN B21 [get_ports io_led[2]]
set_property PACKAGE_PIN C22 [get_ports io_led[3]]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[3]]
