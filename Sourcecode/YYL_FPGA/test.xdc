set_property  IOSTANDARD LVCMOS33         [ get_ports   *                   ]
set_property  CLOCK_DEDICATED_ROUTE FALSE [ get_nets    { I_qspi_clk_IBUF } ]
set_property  PACKAGE_PIN P2 	          [ get_ports	{ qspi_d[0] }       ]
set_property  PACKAGE_PIN L14	          [ get_ports	{ qspi_d[1] }       ]
set_property  PACKAGE_PIN J13	          [ get_ports	{ qspi_d[2] }       ]
set_property  PACKAGE_PIN D13	          [ get_ports	{ qspi_d[3] }       ]
set_property  PACKAGE_PIN M13             [ get_ports	{ I_qspi_cs }       ]
set_property  PACKAGE_PIN H14	          [ get_ports	{ I_qspi_clk }      ]
set_property  PACKAGE_PIN D14	          [ get_ports	{ rst_n }           ]


set_property -dict { PACKAGE_PIN H4  IOSTANDARD LVCMOS33 } [get_ports { clk_100MHz }]; #IO_L13P_T2_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk_100MHz }];
#UART0
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports UART0_Rx];
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports UART0_Tx];
#Gyro
set_property -dict {PACKAGE_PIN P12 IOSTANDARD LVCMOS33} [get_ports Gyro_IIC_SCL];
set_property -dict {PACKAGE_PIN P13 IOSTANDARD LVCMOS33} [get_ports Gyro_IIC_SDA];

set_property PULLUP true [get_ports {Gyro_IIC_SCL}]
set_property PULLUP true [get_ports {Gyro_IIC_SDA}]

set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports VCC];
set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports GND];

set_property -dict {PACKAGE_PIN N4  IOSTANDARD LVCMOS33} [get_ports IIC_OE];
set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS33} [get_ports VCCEN];

