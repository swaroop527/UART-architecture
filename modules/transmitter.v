`timescale 1ns / 1ps

module uart_tx(
    input clk,
    input rst,
    input baud_tick,
    input tx_start,
    input [7:0] tx_data,
    output reg tx_busy,
    output reg tx_serial
    );
    
    reg [7:0] temp;                         // register to latch the incoming byte
    reg [3:0] state;                        // represents the state
    reg [3:0] counter = 4'b0;               // we will make this count from 0 to 15 so that we can give output for a full input cycles (16 baud_ticks)
    
    initial begin
        state = 4'b0;                         // initial state is 0000
        temp = 8'b0;
    end
    
    always @(negedge clk) begin              // negedge coz, tx_start and clk transition form 0 to 1 at the same time, hence unstable
        
        if (rst) begin
            temp <= 8'b0;
            state <= 4'b0;
            tx_busy <= 1'b0;
            counter <= 4'b0;
            tx_serial <= 1'b1;
        end
        
        if (baud_tick == 1'b1 && state != 4'b0000) begin
            counter <= counter + 1'b1;
        end
        
        
        case (state)
            4'b0000:
                if (tx_start) begin
                    tx_busy <= 1'b1;
                    state <= state + 1'b1;
                    temp <= tx_data;
                    tx_serial <= 1'b0;                             //this is conevention, of uart rx and tx to start the outputs with a 0
                end
            4'b0001,4'b0010,4'b0011,4'b0100,4'b0101,4'b0110,4'b0111,4'b1000:
                if (counter == 4'b1111) begin
                    state <= state + 1'b1;
                    tx_serial <= temp[0];
                    temp <= temp >> 1;
                    counter <= 4'b0000;
                end
            4'b1001:
                if(counter == 4'b1111)begin
                    state <= state + 1'b1;
                    tx_serial <= 1'b1;
                    counter <= 4'b0000;
                end
            4'b1010:
                if(counter == 4'b1111)begin
                    state <= 4'b0000;
                    tx_busy <= 1'b0;
                    counter <= 4'b0000;
                end
            default:begin
                state <= 4'b0000;
                tx_busy <= 1'b0;
                temp <= 8'b0;
                counter <= 4'b0;
            end
        endcase
        
    end
    
endmodule
