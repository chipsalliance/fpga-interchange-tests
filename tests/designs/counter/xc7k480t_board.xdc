# Fake pinout for FFG901 package
set_property PACKAGE_PIN A14 [get_ports clk]
set_property PACKAGE_PIN A15 [get_ports rst]
set_property PACKAGE_PIN A16 [get_ports io_led[4]]
set_property PACKAGE_PIN A17 [get_ports io_led[5]]
set_property PACKAGE_PIN B14 [get_ports io_led[6]]
set_property PACKAGE_PIN B15 [get_ports io_led[7]]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[4]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[5]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[6]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[7]]
