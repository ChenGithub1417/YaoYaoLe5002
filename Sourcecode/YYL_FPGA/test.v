module test(clk_100MHz,rst_n,qspi_d,I_qspi_cs,I_qspi_clk,UART0_Rx,Gyro_IIC_SDA,Gyro_IIC_SCL,UART0_Tx,IIC_OE,VCCEN,VCC,GND);
    input           clk_100MHz;        //clk 100m
    input           rst_n;
    inout   [3:0]   qspi_d;         //modified
    input           I_qspi_cs;
    input           I_qspi_clk;
    
    wire    [7:0]   datain;
    wire    [7:0]   addrin;
    wire            en;
    
    wire            clk1k;
    wire            clk1m;
    wire            clk100m;
    clk1m           U1(clk1m,clk100m);
    clk1k           U2(clk1k,clk1m);
    qspi_modified   U0(clk100m,rst_n,qspi_d,I_qspi_cs,I_qspi_clk,datain,addrin,en);
       
    input UART0_Rx;
    inout Gyro_IIC_SDA;
    output Gyro_IIC_SCL;
    output UART0_Tx;
    output IIC_OE;
    output VCCEN;
    output VCC;
    output GND;
    wire [15:0] Gyro_Data_X;
    wire [15:0] Gyro_Data_Y;
    wire [15:0] Gyro_Data_Z;
    wire [15:0] Mag_Data_X;
    wire [15:0] Mag_Data_Y;
    wire [15:0] Mag_Data_Z;
    write UX(datain,addrin,en,clk1k,clk1m,Gyro_Data_X,Gyro_Data_Y,Gyro_Data_Z,Mag_Data_X,Mag_Data_Y,Mag_Data_Z);
    Gyro_Demo UXX(clk_100MHz,UART0_Rx,Gyro_IIC_SDA,Gyro_IIC_SCL,UART0_Tx,IIC_OE,VCCEN,VCC,GND,Gyro_Data_X,Gyro_Data_Y,Gyro_Data_Z,Mag_Data_X,Mag_Data_Y,Mag_Data_Z,clk100m);
endmodule

module write(datain,addrin,en,clk1k,clk1m,Gyro_Data_X,Gyro_Data_Y,Gyro_Data_Z,Mag_Data_X,Mag_Data_Y,Mag_Data_Z);
    output  reg     [7:0]   datain = 8'd0;
    output  reg     [7:0]   addrin = 8'd0;
    output  reg             en = 1'b0;
    input                   clk1k;
    input                   clk1m;
    input   [15:0]          Gyro_Data_X;    //
    input   [15:0]          Gyro_Data_Y;
    input   [15:0]          Gyro_Data_Z;
    input   [15:0]          Mag_Data_X;
    input   [15:0]          Mag_Data_Y;
    input   [15:0]          Mag_Data_Z;
    
    reg     [3:0]   q = 4'd0;
    always@(posedge clk1m)
        if(!clk1k) begin q<=4'd0; en<=1'b0; end
        else if(clk1k&&(4'd0==q)) begin q<=4'd1; en<=1'b0; end
        else 
            case(q)
            4'd1:begin q<=4'd2; en<=1'b0; end
            4'd2:begin q<=4'd3; datain<=Gyro_Data_X[7:0]; addrin<=8'd0; en<=1'b0; end
            4'd3:begin q<=4'd4; en<=1'b1; end
            
            4'd4:begin q<=4'd5; en<=1'b0; end
            4'd5:begin q<=4'd6; datain<=Gyro_Data_X[15:8]; addrin<=8'd1; en<=1'b0; end
            4'd6:begin q<=4'd7; en<=1'b1; end
            default:en<=1'b0;
            endcase
endmodule

module  clk1m(clk1m,clk100m);
    output  reg clk1m = 1'b0;
    input       clk100m;
    reg     [7:0]  q = 8'd0;
    always@(posedge clk100m)
        if(q >= 8'd49) begin q <= 8'd0; clk1m <= ~clk1m; end
        else q <= q + 1'b1;
endmodule

module  clk1k(clk1k,clk1m);
    output  reg clk1k = 1'b0;
    input       clk1m;
    reg     [9:0]  q = 10'd0;
    always@(posedge clk1m)
        if(q >= 10'd499) begin q <= 10'd0; clk1k <= ~clk1k; end
        else q <= q + 1'b1;
endmodule