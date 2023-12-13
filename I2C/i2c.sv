`include "eeprom.sv"
`include "i2c_mem.sv"
module i2c(
        input clk,
        input rst,
        input newd,
        input wr,
        input [7:0] wdata,
        input [6:0] addr,
        output [7:0] rdata,
        output done);
wire sdac;
wire sclc;
wire ackc;
eeprom e1(clk, rst, newd, ackc, wr, sclc, sdac, wdata, addr, rdata, done);//i2c controller
i2cmem m1(clk, rst, sclc, sdac, ackc);//memory i2c
endmodule
interface i2c_if;
        logic clk;
        logic rst;
        logic newd;
        logic wr;
        logic [7:0] wdata;
        logic [6:0] addr;
        logic [7:0] rdata;
        logic done;
        logic sclk_ref;
endinterface

