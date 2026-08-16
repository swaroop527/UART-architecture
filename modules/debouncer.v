`timescale 1ns / 1ps

module debouncer(
    input clk,
    input rst,
    input btn_raw,
    output reg btn_clean
    );
    
    reg [19:0] counter = 20'b0;               //this is so that we can count form 0 to 10ms, which is essential to check if we have a stable input
    
    always @(posedge clk) begin
    
        if (rst) begin
            counter <= 20'b0;
            btn_clean <= 1'b0;
        end
        
        else if (counter == 20'd1000000) begin
            counter <= 20'b0;
            btn_clean <= 1'b1;
        end
        
        else begin
            btn_clean <= 1'b0;
            if (btn_raw == 1'b1) begin
                counter <= counter + 1'b1;
            end
            
            else begin
                counter <= 20'b0;
            end
        end
    end
    
endmodule
