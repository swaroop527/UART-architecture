`timescale 1ns / 1ps

module baud_tb();
    reg clk;
    reg rst;
    wire baud_tick;
    initial begin
        clk = 0;
        rst = 0;
        #10000 rst = 1;
        #100 rst = 0;
        $dumpfile("baud_tb.vcd");
        $dumpvars(0,baud_tb);
    end
    always #5 clk = ~clk;
    baud x(clk,rst,baud_tick);
endmodule
