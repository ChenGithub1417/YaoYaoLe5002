module qspi_modified(clk100m,rst_n,qspi_d,I_qspi_cs,I_qspi_clk,datain,addrin,en);
////////////////////////////////////////////////////////////////
    input           clk100m;            //clk 100m
    input           rst_n;
    inout   [3:0]   qspi_d;         //modified
    input           I_qspi_cs;
    input           I_qspi_clk;
////////////////////////////////////////////////////////////////
    input   [7:0]   datain;
    input   [7:0]   addrin;
    input           en;
    wire            en_t;
    pulse   UX(en_t,en,clk100m);
////////////////////////////////////////////////////////////////
    wire    [31:0]  addr;
    wire    [7:0]   o_data;
    wire    [7:0]   i_data;
    wire            o_valid;
    
    wire    [31:0]  addrb;
    wire    [7:0]   dinb;
    wire    [7:0]   doutb;
    wire            web;
////////////////////////////////////////////////////////////////
blk_mem_gen_0 u_blk_mem_gen_0(
    .addra(addr),
    .clka(I_qspi_clk),
    .dina(o_data),
    .douta(i_data),
    .wea(o_valid),
    .addrb(en_t?addrin:addrb),        //modified
    .clkb(clk100m),
    .dinb(en_t?datain:dinb),          //modified
    .doutb(doutb),
    .web(en_t?1'b1:web)               //modified
);
////////////////////////////////////////////////////////////////
qspi_slave u_qspi_slave(
    .I_qspi_clk  (I_qspi_clk),  //in
    .I_qspi_cs   (I_qspi_cs),   //in
    .IO_qspi_io0 (qspi_d[0]),   //in
    .IO_qspi_io1 (qspi_d[1]),   //in
    .IO_qspi_io2 (qspi_d[2]),   //in
    .IO_qspi_io3 (qspi_d[3]),   //in
    .o_addr      (addr),        //out   [31:0]
    .o_data      (o_data),      //out   [7:0]
    .i_data      (i_data),      //in    [7:0]
    .o_valid     (o_valid)      //out
    );

qspi_adder u_qspi_adder(
     .clk(clk100m),                 //in
     .rst_n(rst_n),             //in
     .addr(addrb),              //out   [7:0]
     .data_in(doutb),           //in    [7:0]
     .data_out(dinb),           //out   [7:0]
     .wen(web)                  //out
);

endmodule

module  pulse(out,in,clk);
    output  reg out;
    input       in;
    input       clk;
    reg         temp;
    always@(posedge clk)
        if( 2'b01=={temp,in} ) begin temp <= in; out <= 1'b1; end
        else begin temp <= in; out <= 1'b0; end
endmodule


