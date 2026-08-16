`timescale 1ns / 1ps

module top_tb(

    );
    
    reg rst = 1'b0;
    reg clk = 0;
    reg rx_serial = 1'b1;
    reg btn_send = 1'b0;
    reg [7:0] sw = 8'b0;
    wire rx_valid;
    
    always #5 clk = ~clk;
    
    top x(clk,rst,rx_serial,btn_send,sw,rx_valid);
    
    initial begin
        
        #104160;
        rx_serial = 1'b0;                     //testing rx
        #104160;
        rx_serial = 1'b1;
        #104160;
        rx_serial = 1'b1;
        #104160;
        rx_serial = 1'b1;
        #104160;
        rx_serial = 1'b0;
        #104160;
        rx_serial = 1'b1;
        #104160;
        rx_serial = 1'b1;
        #104160;
        rx_serial = 1'b0;
        #104160;
        rx_serial = 1'b1;
        #104160;
        rx_serial = 1'b1;
        #104160;
        
        #104160;
        rx_serial = 1'b0;                     //testing rx with reset signal
        #104160;
        rx_serial = 1'b1;
        #104160;
        rx_serial = 1'b1;
        #100;
        rst = 1'b1;
        #100;
        rst = 1'b0;
        
        #1000;                                //testing debouncer
        btn_send <= 1'b1;
        #10000;
        btn_send <= 1'b0;
        #1000;
        btn_send <= 1'b1;
        #15000000;
        btn_send <= 1'b0;
        
        #1000;                                //testing devouncer with reset
        btn_send <= 1'b1;
        #10000;
        btn_send <= 1'b0;
        #1000;
        btn_send <= 1'b1;
        #10000000;
        btn_send <= 1'b0;
        #5;
        rst = 1'b1;
        #5;
        rst = 1'b0;
        
        
        #1000;                                //testing transmitter module
        btn_send <= 1'b1;
        #10000;
        btn_send <= 1'b0;
        #1000;
        btn_send <= 1'b1;
        #10000000;
        btn_send <= 1'b0;
        sw <= 8'b10101010;
        
        #1000;                                //testing transmitter with reset
        btn_send <= 1'b1;
        #10000;
        btn_send <= 1'b0;
        #1000;
        btn_send <= 1'b1;
        #10000000;
        btn_send <= 1'b0;
        sw <= 8'b10101010;
        #10000;
        rst <= 1'b1;
        #100
        rst = 1'b0;
        
    end
    
endmodule
