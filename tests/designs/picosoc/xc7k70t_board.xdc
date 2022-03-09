## LPDDR4 test board

# Clock
set_property LOC L19 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# Serial
set_property LOC AB18 [get_ports {tx}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx}]

set_property LOC AA18 [get_ports {rx}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx}]

# assign buttons to switches
set_property LOC E8 [get_ports {sw[0]}]
set_property LOC B8 [get_ports {sw[1]}]
set_property LOC C9 [get_ports {sw[2]}]
set_property LOC E9 [get_ports {sw[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]

# leds
set_property LOC F8 [get_ports {led[0]}]
set_property LOC C8 [get_ports {led[1]}]
set_property LOC A8 [get_ports {led[2]}]
set_property LOC D9 [get_ports {led[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
