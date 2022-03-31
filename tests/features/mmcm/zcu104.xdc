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
set_property PACKAGE_PIN B4 [get_ports rst]
