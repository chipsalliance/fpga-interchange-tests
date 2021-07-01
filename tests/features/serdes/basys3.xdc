# basys3 100 MHz CLK
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# rst signal
set_property PACKAGE_PIN U17 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

# sw[0:15] correspond with SW0-SW15 on the basys3
set_property PACKAGE_PIN V17 [get_ports sw[0]]
set_property PACKAGE_PIN V16 [get_ports sw[1]]
set_property PACKAGE_PIN W16 [get_ports sw[2]]
set_property PACKAGE_PIN W17 [get_ports sw[3]]
set_property PACKAGE_PIN W15 [get_ports sw[4]]
set_property PACKAGE_PIN V15 [get_ports sw[5]]
set_property PACKAGE_PIN W14 [get_ports sw[6]]
set_property PACKAGE_PIN W13 [get_ports sw[7]]

set_property IOSTANDARD LVCMOS33 [get_ports sw[0]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[1]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[2]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[3]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[4]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[5]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[6]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[7]]

# led[0:15] correspond with LD0-LD15 on the basys3
set_property PACKAGE_PIN U16 [get_ports led[0]]
set_property PACKAGE_PIN E19 [get_ports led[1]]
set_property PACKAGE_PIN U19 [get_ports led[2]]
set_property PACKAGE_PIN V19 [get_ports led[3]]
set_property PACKAGE_PIN W18 [get_ports led[4]]
set_property PACKAGE_PIN U15 [get_ports led[5]]
set_property PACKAGE_PIN U14 [get_ports led[6]]
set_property PACKAGE_PIN V14 [get_ports led[7]]
set_property PACKAGE_PIN V13 [get_ports led[8]]
set_property PACKAGE_PIN V3  [get_ports led[9]]

set_property IOSTANDARD LVCMOS33 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led[4]]
set_property IOSTANDARD LVCMOS33 [get_ports led[5]]
set_property IOSTANDARD LVCMOS33 [get_ports led[6]]
set_property IOSTANDARD LVCMOS33 [get_ports led[7]]
set_property IOSTANDARD LVCMOS33 [get_ports led[8]]
set_property IOSTANDARD LVCMOS33 [get_ports led[9]]

# PMOD-A
set_property PACKAGE_PIN K17 [get_ports io]
set_property IOSTANDARD LVCMOS33 [get_ports io]
