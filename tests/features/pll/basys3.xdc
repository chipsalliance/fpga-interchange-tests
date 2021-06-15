## basys3 breakout board

set_property PACKAGE_PIN  W5 [get_ports clk]

# in[0:15] correspond with SW0-SW15 on the basys3
set_property PACKAGE_PIN V17 [get_ports sw[0]]
set_property PACKAGE_PIN V16 [get_ports sw[1]]

# out[0:15] correspond with LD0-LD15 on the basys3
set_property PACKAGE_PIN U16 [get_ports led[0]]
set_property PACKAGE_PIN E19 [get_ports led[1]]
set_property PACKAGE_PIN U19 [get_ports led[2]]
set_property PACKAGE_PIN V19 [get_ports led[3]]
set_property PACKAGE_PIN W18 [get_ports led[4]]
set_property PACKAGE_PIN U15 [get_ports led[5]]
set_property PACKAGE_PIN U14 [get_ports led[6]]

set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property IOSTANDARD LVCMOS33 [get_ports sw[0]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[1]]

set_property IOSTANDARD LVCMOS33 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led[4]]
set_property IOSTANDARD LVCMOS33 [get_ports led[5]]
set_property IOSTANDARD LVCMOS33 [get_ports led[6]]
