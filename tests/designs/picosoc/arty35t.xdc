## arty35t

# Clock
set_property LOC E3 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# Serial
set_property LOC D10 [get_ports {tx}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx}]

set_property LOC A9 [get_ports {rx}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx}]

# swiches
set_property LOC D9 [get_ports {sw[0]}]
set_property LOC C9 [get_ports {sw[1]}]
set_property LOC B9 [get_ports {sw[2]}]
set_property LOC B8 [get_ports {sw[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]

# leds
set_property LOC H5  [get_ports {led[0]}]
set_property LOC J5  [get_ports {led[1]}]
set_property LOC T9  [get_ports {led[2]}]
set_property LOC T10 [get_ports {led[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
