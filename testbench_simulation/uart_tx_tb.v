`timescale 1ns / 1ps

module uart_tx_tb(

    );
    
    reg clk = 1'b0;
    reg rst = 1'b0;
    wire baud_tick;
    reg tx_start = 1'b0;
    reg [7:0] tx_data;
    wire tx_busy;
    wire tx_serial;
    
    baud y(clk,rst,baud_tick);
    uart_tx x(clk,rst,baud_tick,tx_start,tx_data,tx_busy,tx_serial);
    
    always #5 clk = ~clk;
    
    initial begin
        #10000;
        tx_start = 1'b1;
        #10;
        tx_start = 1'b0;
        #10;
    end
    
    initial begin
        //rst = 1'b1;
        tx_start = 1'b0;
        #10000;
        tx_data = 8'b10100011;
        #104160;
        tx_data = 8'b0;
        #10000;
        rst = 1'b1;
        #10;
    end
    
endmodule
