`timescale 1ns / 1ps

module baud(
    input clk,
    input rst,
    output reg baud_tick
    );
    reg [9:0] counter;
    initial begin
        counter = 10'b0;
    end
    always @(posedge clk or posedge rst) begin
    baud_tick = 0;
        if (rst) begin
            baud_tick <= 1'b0;
            counter <= 10'b0;
        end
        else if (counter == 10'b1010001010) begin
            baud_tick <= 1'b1;
            counter <= 10'b0;
        end
        else begin
            baud_tick <= 1'b0;
            counter <= counter +1'b1;
        end
    end
endmodule
