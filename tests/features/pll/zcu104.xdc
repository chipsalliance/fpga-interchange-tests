# ZCU-104 board

# Clock
set_property PACKAGE_PIN H11 [get_ports clk_p]
set_property PACKAGE_PIN G11 [get_ports clk_n]

set_property IOSTANDARD LVDS [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports clk_n]

# PMOD GPIO
set_property PACKAGE_PIN  G8 [get_ports leds[0]]
set_property PACKAGE_PIN  H8 [get_ports leds[1]]
set_property PACKAGE_PIN  G7 [get_ports leds[2]]
set_property PACKAGE_PIN  H7 [get_ports leds[3]]
set_property PACKAGE_PIN  G6 [get_ports leds[4]]
set_property PACKAGE_PIN  H6 [get_ports leds[5]]
set_property PACKAGE_PIN  J6 [get_ports leds[6]]
set_property PACKAGE_PIN  J7 [get_ports leds[7]]
set_property PACKAGE_PIN  J9 [get_ports rst]
