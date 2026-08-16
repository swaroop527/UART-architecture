`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    input rx_serial,
    input btn_send,
    input [7:0] sw,
    output rx_valid
    );
    
    wire baud_tick,tx_serial,start,tx_busy;
    wire [7:0] rx_data;
    
    //all the modules:
    debouncer deb_module(clk,rst,btn_send,start);
    baud baud_module(clk,rst,baud_tick);
    uart_rx receiver(clk,rst,baud_tick,rx_serial,rx_data,rx_valid);
    uart_tx transmitter(clk,rst,baud_tick,start,sw,tx_busy,tx_serial);
    
endmodule
