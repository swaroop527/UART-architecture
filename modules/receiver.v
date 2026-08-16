`timescale 1ns / 1ps

module uart_rx(
    input clk,
    input rst,
    input baud_tick,
    input rx_serial,
    output reg [7:0] rx_data,
    output reg rx_valid
    );
    reg [3:0] y = 4'b0;           // to  represent the states
    reg [3:0] x = 3'b0;           // to locate the middle of input pulse we make x count form 0 to 8 baud_ticks (coz the input period is evenly broken in 16 parts)
    reg [7:0] z = 8'b0;           // we receive 1 bit at a time so this combines all the bits and makes the whole required byte and then loads it in rx_data
    

    always @(negedge clk) begin
        
        if (x == 4'b1110 && y == 4'b0000 && rx_serial == 1'b1) begin
            y <= 4'b0;
        end
        
        if (rst) begin
            rx_data <= 8'b0;
            rx_valid <= 1'b0;
            z <= 8'b0;
            y <= 4'b0;
            x <= 4'b0;
        end
    
        if (baud_tick == 1'b1) begin
            if (y != 4'b0000 || rx_serial == 1'b0) begin                // this or statement basically checks that the x counter only works only when rx_serial is low or the state is not ideal
                if (x == 4'b1111) x = 4'b0;
                else x = x + 4'b0001;
            end
                
            if (x == 4'b0111) begin                                         // this block runs when x comes to 7 in binary ie the middle of input cycle
                case (y)
                4'b0000:                                               // ideal state
                    if (rx_serial == 1'b0) begin
                        y <= y + 1'b1;
                    end
                
                4'b0001,4'b0010,4'b0011,4'b0100,4'b0101,4'b0110,4'b0111,4'b1000,4'b1001:                   // this is the fecth state
                    if (y == 4'b1001) begin
                        rx_data <= z;
                        y <= y + 1'b1;
                        rx_valid <= 1'b1;
                    end
            
                    else begin
                        z <= {rx_serial,z[7:1]};
                        y <= y + 1'b1;
                    end
                
                4'b1010: begin                                            // tells other module that they can now access the byte by making rx_serial == 1
                    rx_valid <= 1'b0;
                    y <= 4'b0;
                end
                
                default: begin                                            // default is important because we are making a mux
                    y <= 4'b0000;
                    rx_valid <= 1'b0;
                end
                    
                endcase
            end
        end
    end
endmodule

