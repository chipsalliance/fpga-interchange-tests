# Fake pinout for FFG901 package
set_property PACKAGE_PIN A14 [get_ports clk]
set_property PACKAGE_PIN A15 [get_ports rst]
set_property PACKAGE_PIN A16 [get_ports io_led[0]]
set_property PACKAGE_PIN A17 [get_ports io_led[1]]
set_property PACKAGE_PIN B14 [get_ports io_led[2]]
set_property PACKAGE_PIN B15 [get_ports io_led[3]]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[3]]
