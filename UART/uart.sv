`include "uarttx.sv"
`include "uartrx.sv"
`timescale 1ns / 1ps
module uart #(
        parameter clk_freq = 1000000,
        parameter baurd_rate =9600)
        (input clk,rst,
         input rx,
         input[7:0] dintx,
         input  send,
         output tx,
         output [7:0] doutrx,
         output donetx,
         output donerx);
 uarttx #(clk_freq,baurd_rate)
 utx (clk, rst, send, dintx, tx, donetx);
 uartrx #(clk_freq,baurd_rate)
 urx (clk, rst, rx, doutrx, donerx);
 endmodule
 interface uart_if;
         logic clk;
         logic uclktx;
         logic uclkrx;
         logic rst;
         logic rx;
         logic [7:0] dintx;
         logic send;
         logic tx;
         logic [7:0] doutrx;
         logic donetx;
         logic donerx;
 endinterface


