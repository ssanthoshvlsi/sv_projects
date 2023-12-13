`include "uart.sv"
`include "uart_trans.sv"
`include "uart_gen.sv"
`include "uart_drv.sv"
`include "uart_mon.sv"
`include "uart_sco.sv"
`include "uart_env.sv"
/*module tb;
transaction tr;
initial begin
        tr = new();
        tr.display("TOP");
end
initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
end
endmodule*/
/*module tb;
generator gen;
driver drv;
event next;
event done;
mailbox #(transaction) mbx;
mailbox #(bit[7:0]) mbxt;
uart_if vif(); uart #(1000000,9600) dut(.clk(vif.clk), .rst(vif.rst),
        .rx(vif.rx), .dintx(vif.dintx), .send(vif.send), .tx(vif.tx),
        .doutrx(vif.doutrx), .donetx(vif.donetx), .donerx(vif.donerx));
initial begin vif.clk <= 0; end always #10 vif.clk <= ~vif.clk; initial begin
        mbx = new(); mbxt = new(); gen = new(mbx); drv = new(mbxt, mbx);
        gen.count = 20; drv.vif = vif; gen.drvnext = next; drv.drvnext = next;
end initial begin fork gen.run(); drv.run(); join_none
wait(gen.done.triggered); $finish(); end
initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
end
assign vif.uclktx = dut.utx.uclk;
assign vif.uclkrx = dut.urx.uclk;
endmodule*/
/*module tb;
generator gen;
driver drv;
monitor mon;
event drvnext;
event sconext;
event done;
mailbox #(transaction) mbx;
mailbox #(bit[7:0]) mbxds;
mailbox #(bit[7:0]) mbxms;
uart_if vif();
uart #(1000000,9600) dut(.clk(vif.clk), .rst(vif.rst), .rx(vif.rx), .dintx(vif.dintx), .send(vif.send), .tx(vif.tx), .doutrx(vif.doutrx), .donetx(vif.donetx), .donerx(vif.donerx));
initial begin
        vif.clk <= 0;
end
always #10 vif.clk <= ~vif.clk;
initial begin
        mbx = new();
        mbxds = new();
        mbxms = new();
        gen = new(mbx);
        drv = new(mbxds, mbx);
        mon = new(mbxms);
        gen.count = 20;
        drv.vif = vif;
        mon.vif = vif;
        gen.drvnext = drvnext;
        drv.drvnext = drvnext;
        gen.sconext = sconext;
        mon.sconext = sconext;
end
initial begin 
        fork
                gen.run();
                drv.run();
                mon.run();
        join_none
        wait(gen.done.triggered);
        $finish();
end
initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
end
assign vif.uclktx = dut.utx.uclk;
assign vif.uclkrx = dut.urx.uclk;
endmodule*/
module tb;
uart_if vif();
uart #(1000000,9600) dut(.clk(vif.clk), .rst(vif.rst), .rx(vif.rx), .dintx(vif.dintx), .send(vif.send), .tx(vif.tx), .doutrx(vif.doutrx), .donetx(vif.donetx), .donerx(vif.donerx));
initial begin
       vif.clk <= 0;
end
always #10 vif.clk <= ~vif.clk;
environment env;
initial begin
        env = new(vif);
        env.gen.count = 5;
        env.run();
end
initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
end
assign vif.uclktx = dut.utx.uclk;
assign vif.uclkrx = dut.urx.uclk;
endmodule




