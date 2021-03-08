`include "rtl_fpga/defines.v"

/* Need to export N5_RTL_ROOT and pass it to iverilog using -I */
`include "AHB_sys_0/AHBlite_sys_0.v"
`include "AHB_sys_0/AHBlite_bus0.v"
`include "AHB_sys_0/AHBlite_GPIO.v"
`include "AHB_sys_0/AHBlite_db_reg.v"

`include "AHB_sys_0/APB_sys_0/APB_WDT32.v"
`include "AHB_sys_0/APB_sys_0/APB_TIMER32.v"
`include "AHB_sys_0/APB_sys_0/APB_PWM32.v"
`include "AHB_sys_0/APB_sys_0/AHB_2_APB.v"
`include "AHB_sys_0/APB_sys_0/APB_bus0.v"
`include "AHB_sys_0/APB_sys_0/APB_sys_0.v"

`include "IPs/TIMER32.v"
`include "IPs/PWM32.v"
`include "IPs/WDT32.v"
`include "IPs/spi_master.v"
`include "IPs/i2c_master.v"
`include "IPs/GPIO.v"
`include "IPs/APB_UART.v"
`include "IPs/APB_SPI.v"
`include "IPs/APB_I2C.v"
`include "IPs/AHBSRAM.v"
`include "IPs/AHBROM.v"
`include "IPs/ROM.v"
`include "IPs/QSPI_XIP_CTRL.v"

`include "acc/AHB_SPM.v"

`include "NfiVe32.v" 

`include "rtl_fpga/btn_sync.v"
`include "rtl_fpga/gpio_bidir.v"
`include "rtl_fpga/RAM_4Kx32.v"
`include "rtl_fpga/soc_core.v"

