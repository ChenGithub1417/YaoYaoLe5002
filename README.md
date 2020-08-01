2020年新工科联盟-Xilinx暑期学校
摇摇乐 功能说明：AWS端每隔五秒收到开发板前五秒摇动次数（半周期记一次）（摇动幅度请大于20cm）
本项目基于 Spartan Edge Accelerator Board(Spartan-7 XC7S15)(ESP32)

！！使用前在 aa_aws_setup.h 中设置AWS与Wifi相关参数并重新编译。

工具：
    Arduino1.8.13
    Vidavo18.1/Vivado20.1

外设：无

以下文件来自于对例程与库文件的整理
aa_Gyro_Demo_modified.v
aa_qspi_tb_modified.v
Clk_Division.v
Driver_Gyro.v
Driver_IIC.v
Driver_UART.v
qspi_adder.v
qspi_slave.v
UART_Send.v
aa_aws.h
aa_aws_setup.h
aa_esp32.h
esp32-hal-qspi.c
esp32-hal-qspi.h
sea_esp32_qspi.cpp
sea_esp32_qspi.h