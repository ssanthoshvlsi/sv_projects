`include "apb_ram.sv"
`include "apb_ram_trans.sv"
`include "apb_ram_gen.sv"
`include "apb_ram_drv.sv"
`include "apb_ram_mon.sv"
`include "apb_ram_sco.sv"
`include "apb_ram_env.sv"
/*module tb;
transaction tr;
initial begin
        tr = new();
        tr.display("TOP");
end
endmodule
*//*
module tb;
generator gen;
mailbox #(transaction) mbx;
initial begin
        mbx = new();
        gen = new(mbx);
        gen.count = 20;
        gen.run();
end
initial begin 
        $dumpfile("dump.vcd");
        $dumpvars;
end
endmodule
*//*
module tb;
generator gen;
driver drv;
mailbox #(transaction) mbx;
event next;
apb_if vif();
apb_ram dut(vif.presetn, vif.pclk, vif.psel, vif.penable, vif.pwrite, vif.paddr, vif.pwdata, vif.prdata, vif.pready, vif.pslverr);
initial begin
        vif.pclk <= 0;
end
always #10 vif.pclk <= ~vif.pclk;
initial begin
        mbx = new();
        gen = new(mbx);
        gen.count = 20;
        drv = new(mbx);
        drv.vif = vif;
        gen.nextdrv = next;
        drv.nextdrv = next;
        fork
                gen.run();
                drv.run();
        join_none
        wait(gen.done.triggered);
        $finish();
end
initial begin 
        $dumpfile("dump.vcd");
        $dumpvars;
end
endmodule
*/
module tb;
apb_if vif();
apb_ram dut(vif.presetn, vif.pclk, vif.psel, vif.penable, vif.pwrite, vif.paddr, vif.pwdata, vif.prdata, vif.pready, vif.pslverr);
initial begin
        vif.pclk <= 0;
end
always #10 vif.pclk <= ~vif.pclk;
environment env;
initial begin
        env = new(vif);
        env.gen.count = 30;
        env.run();
end
initial begin 
        $dumpfile("dump.vcd");
        $dumpvars;
end
endmodule

