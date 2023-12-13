`include "i2c.sv"
`include "i2c_trans.sv"
`include "i2c_gen.sv"
`include "i2c_drv.sv"
`include "i2c_mon.sv"
`include "i2c_sco.sv"
module tb;
generator gen;
driver drv;
monitor mon;
scoreboard sco;
event nextgd;
event nextgs;
mailbox #(transaction) mbxgd, mbxms;
i2c_if vif();
i2c dut(.clk(vif.clk), .rst(vif.rst), .newd(vif.newd), .wr(vif.wr), .wdata(vif.wdata), .addr(vif.addr), .rdata(vif.rdata), .done(vif.done));
initial begin
        vif.clk <= 0;
end
always #5 vif.clk <= ~vif.clk;
initial begin
        mbxgd = new();
        mbxms = new();
        gen = new(mbxgd);
        drv = new(mbxgd);
        mon = new(mbxms);
        sco = new(mbxms);
        gen.count = 20;
        drv.vif = vif;
        mon.vif = vif;
        gen.drvnext = nextgd;
        drv.drvnext = nextgd;
        gen.sconext = nextgs;
        sco.sconext = nextgs;
end
task pre_test;
        drv.reset();
endtask
task test;
        fork
                gen.run();
                drv.run();
                mon.run();
                sco.run();
        join_any
endtask
task post_test;
        wait(gen.done.triggered);
        $finish();
endtask
task run();
        pre_test;
        test;
        post_test;
endtask
initial begin
        run();
end
initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(1,tb);
end
assign vif.sclk_ref = dut.e1.sclk_ref;
endmodule



