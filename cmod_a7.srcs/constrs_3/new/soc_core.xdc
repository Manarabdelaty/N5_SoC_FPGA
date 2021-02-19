create_clock -period 20.000 -name HCLK -waveform {0.000 10.000}


set_property IOSTANDARD LVCMOS33 [get_ports {fcen_Sys0_S0[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fdi_Sys0_S0[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fdi_Sys0_S0[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fdi_Sys0_S0[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fdi_Sys0_S0[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fdo_Sys0_S0[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fdo_Sys0_S0[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fdo_Sys0_S0[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fdo_Sys0_S0[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {fdoe_Sys0_S0[0]}]
