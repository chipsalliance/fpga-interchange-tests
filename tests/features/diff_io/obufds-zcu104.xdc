# ZCU-104 board

# PMOD GPIO

set_property PACKAGE_PIN G8 [get_ports sw]

set_property PACKAGE_PIN H11 [get_ports diff_p]
set_property PACKAGE_PIN G11 [get_ports diff_n]

set_property IOSTANDARD LVDS [get_ports diff_p]
set_property IOSTANDARD LVDS [get_ports diff_n]
