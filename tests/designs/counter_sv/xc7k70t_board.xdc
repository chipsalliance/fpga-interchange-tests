# Pinout for FBG484 package
set_property PACKAGE_PIN L19 [get_ports clk]
set_property PACKAGE_PIN E8 [get_ports rst]
set_property PACKAGE_PIN F8 [get_ports io_led[0]]
set_property PACKAGE_PIN C8 [get_ports io_led[1]]
set_property PACKAGE_PIN A8 [get_ports io_led[2]]
set_property PACKAGE_PIN D9 [get_ports io_led[3]]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[3]]
