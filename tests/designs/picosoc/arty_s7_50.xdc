## arty s7-50

# Clock
set_property LOC R2 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# Serial
set_property LOC R12 [get_ports {tx}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx}]

set_property LOC V12 [get_ports {rx}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx}]

# swiches
set_property LOC H14 [get_ports {sw[0]}]
set_property LOC H18 [get_ports {sw[1]}]
set_property LOC G18 [get_ports {sw[2]}]
set_property LOC M5  [get_ports {sw[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]

# leds
set_property LOC E18 [get_ports {led[0]}]
set_property LOC F13 [get_ports {led[1]}]
set_property LOC E13 [get_ports {led[2]}]
set_property LOC H15 [get_ports {led[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
