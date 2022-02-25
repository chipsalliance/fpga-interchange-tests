# ZCU-104 board

# Clock
set_property PACKAGE_PIN H11 [get_ports clk_p]
set_property PACKAGE_PIN G11 [get_ports clk_n]

set_property IOSTANDARD LVDS [get_ports clk_p]
set_property IOSTANDARD LVDS [get_ports clk_n]

# PMOD GPIO
set_property PACKAGE_PIN  H8 [get_ports rst]
set_property PACKAGE_PIN  G7 [get_ports inputs[0]]
set_property PACKAGE_PIN  H7 [get_ports inputs[1]]
set_property PACKAGE_PIN  G6 [get_ports inputs[2]]
set_property PACKAGE_PIN  H6 [get_ports inputs[3]]
set_property PACKAGE_PIN  J6 [get_ports inputs[4]]
set_property PACKAGE_PIN  J7 [get_ports inputs[5]]
set_property PACKAGE_PIN  J9 [get_ports inputs[6]]
set_property PACKAGE_PIN  K9 [get_ports inputs[7]]
set_property PACKAGE_PIN  K8 [get_ports out]
set_property PACKAGE_PIN  B3 [get_ports t_dat]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF_inst/0]
