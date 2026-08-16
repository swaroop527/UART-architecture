`timescale 1ns / 1ps

module debouncer_tb(
    );
    
    reg clk = 0;
    reg rst;
    reg btn_raw;
    wire btn_clean;
    
    always #5 clk = ~clk;
    
    debouncer x(clk,rst,btn_raw,btn_clean);
    
    initial begin
        rst = 1'b0;
        btn_raw = 1'b1;
        
        #10000000
        rst = 1'b0;
        btn_raw = 1'b0;
        
    end
    
endmodule
