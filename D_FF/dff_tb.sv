`include "dff.sv"
`include "dff_trans.sv"
`include "dff_gen.sv"
`include "dff_drv.sv"
`include "dff_mon.sv"
`include "dff_sco.sv"
`include "dff_env.sv"
module tb;
dff_if vif();
dff dut(vif);
initial begin 
        vif.clk <= 1'b1;
end
always #10 vif.clk <= ~vif.clk;
environment env;
initial begin 
        env=new(vif);
        env.gen.count = 20;
        env.run();
end
initial begin 
        $dumpfile("dump.vcd");
        $dumpvars;
end
endmodule

