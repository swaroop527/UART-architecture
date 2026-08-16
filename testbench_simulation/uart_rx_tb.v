`timescale 1ns / 1ps

module uart_rx_tb(
    );
    
    reg clk = 0;
    reg rst = 0;
    reg rx_serial;
    wire baud_tick;
    wire [7:0] rx_data;
    wire rx_valid;
    
    always #5 clk = ~clk;
    
    initial begin
    //rst <= 1'b1;
    rx_serial <= 1'b1;
    #104160;
    rx_serial <= 1'b0;
    #104160;
    rx_serial <= 1'b1;
    #104160;
    rx_serial <= 1'b1;
    #104160;
    rx_serial <= 1'b0;
    #104160;
    rx_serial <= 1'b1;
    #104160;
    rx_serial <= 1'b0;
    #104160;
    rx_serial <= 1'b0;
    #104160;
    rx_serial <= 1'b0;
    #104160;
    rx_serial <= 1'b1;
    #104160;
    rx_serial <= 1'b1;
    #104160;
    $finish;
    end
    
    baud y(clk,rst,baud_tick);
    uart_rx x(clk,rst,baud_tick,rx_serial,rx_data,rx_valid);
    
endmodule
