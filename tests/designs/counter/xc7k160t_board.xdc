# Pinout for FFG676 package
set_property PACKAGE_PIN C12 [get_ports clk]
set_property PACKAGE_PIN C21 [get_ports rst]
set_property PACKAGE_PIN D21 [get_ports io_led[4]]
set_property PACKAGE_PIN B20 [get_ports io_led[5]]
set_property PACKAGE_PIN B21 [get_ports io_led[6]]
set_property PACKAGE_PIN C22 [get_ports io_led[7]]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[4]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[5]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[6]]
set_property IOSTANDARD LVCMOS33 [get_ports io_led[7]]
