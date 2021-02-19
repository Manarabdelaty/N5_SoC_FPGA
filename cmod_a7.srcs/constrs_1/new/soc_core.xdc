
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { HCLK }]; #IO_L19N_T3_VREF_16 Sch=btn[0]
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { HRESETn }]; #IO_L19P_T3_16 Sch=btn[1]

set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports { NMI }]; #IO_L12N_T1_MRCC_16 Sch=led[0]
set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { SYSTICKCLKDIV[0] }]; #IO_L13P_T2_MRCC_16 Sch=led[1]
