# ZCU-104 board

# Clock
set_property PACKAGE_PIN H11 [get_ports clk_p]
set_property PACKAGE_PIN G11 [get_ports clk_n]

set_property IOSTANDARD LVDS [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports clk_n]

# PMOD GPIO
set_property PACKAGE_PIN  G8 [get_ports led[0]]
set_property PACKAGE_PIN  H8 [get_ports led[1]]
set_property PACKAGE_PIN  G7 [get_ports led[2]]
set_property PACKAGE_PIN  H7 [get_ports led[3]]
set_property PACKAGE_PIN  G6 [get_ports led[4]]
set_property PACKAGE_PIN  H6 [get_ports led[5]]
set_property PACKAGE_PIN  J6 [get_ports led[6]]
set_property PACKAGE_PIN  J7 [get_ports led[7]]
set_property PACKAGE_PIN  J9 [get_ports led[8]]
set_property PACKAGE_PIN  K9 [get_ports led[9]]
set_property PACKAGE_PIN  K8 [get_ports led[10]]
set_property PACKAGE_PIN  L8 [get_ports led[11]]
set_property PACKAGE_PIN L10 [get_ports led[12]]
set_property PACKAGE_PIN M10 [get_ports led[13]]
set_property PACKAGE_PIN  M8 [get_ports led[14]]
set_property PACKAGE_PIN  M9 [get_ports led[15]]

# Pushbuttons
set_property PACKAGE_PIN B4 [get_ports sw[0]]
set_property PACKAGE_PIN C4 [get_ports sw[1]]
set_property PACKAGE_PIN B3 [get_ports sw[2]]
set_property PACKAGE_PIN C3 [get_ports sw[3]]

# DIP SW

set_property PACKAGE_PIN E4 [get_ports sw[4]]
set_property PACKAGE_PIN D4 [get_ports sw[5]]
set_property PACKAGE_PIN F5 [get_ports sw[6]]
set_property PACKAGE_PIN F4 [get_ports sw[7]]

# Abusing HDMI pins

set_property PACKAGE_PIN  B1 [get_ports sw[8]]
set_property PACKAGE_PIN  C1 [get_ports sw[9]]
set_property PACKAGE_PIN  A2 [get_ports sw[10]]
set_property PACKAGE_PIN  A3 [get_ports sw[11]]
set_property PACKAGE_PIN  E3 [get_ports sw[12]]
set_property PACKAGE_PIN N11 [get_ports sw[13]]
set_property PACKAGE_PIN M12 [get_ports sw[14]]
set_property PACKAGE_PIN  F6 [get_ports sw[15]]
set_property PACKAGE_PIN  E5 [get_ports rx]
set_property PACKAGE_PIN  D1 [get_ports tx]
