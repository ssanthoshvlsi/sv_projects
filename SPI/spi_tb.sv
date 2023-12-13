`include "spi.sv"
`include "spi_trans.sv"
`include "spi_gen.sv"
`include "spi_drv.sv"
`include "spi_mon.sv"
`include "spi_sco.sv"
`include "spi_env.sv"
/*
///for gen to drv
module tb;
        generator gen;
        driver drv;
        event next;
        event done;
        mailbox #(transaction) mbxgd;
        mailbox #(bit [11:0]) mbxds;
        spi_if vif();
        spi dut(vif.clk, vif.newd, vif.rst, vif.din, vif.sclk, vif.cs, vif.mosi);
        initial begin
                vif.clk <= 0;
        end
        always #5 vif.clk <= ~vif.clk;
        initial begin 
                mbxgd = new();
                mbxds = new();
                gen = new(mbxgd);
                drv = new(mbxgd, mbxds);
                gen.count = 20;
                drv.vif = vif;
                drv.drvnext = next;
                gen.drvnext = next;
        end
        initial begin 
                fork
                        drv.reset();
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
/*
//gen to mon
module tb;
        generator gen;
        driver drv;
        monitor mon;
        event drvnext, sconext;
        event done;
        mailbox #(transaction) mbxgd;
        mailbox #(bit [11:0]) mbxds, mbxms;
        spi_if vif();
        spi dut(vif.clk, vif.newd, vif.rst, vif.din, vif.sclk, vif.cs, vif.mosi);
        initial begin
                vif.clk <= 0;
        end
        always #5 vif.clk <= ~vif.clk;
        initial begin 
                mbxgd = new();
                mbxds = new();
                mbxms = new();
                gen = new(mbxgd);
                drv = new(mbxgd, mbxds);
                mon = new(mbxms);
                gen.count = 20;
                drv.vif = vif;
                mon.vif = vif;
                drv.drvnext = drvnext;
                gen.drvnext = drvnext;
                gen.sconext = sconext;
                mon.sconext = sconext;
        end
        initial begin 
                fork
                        drv.reset();
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
endmodule
*/
module tb;
        spi_if vif();
        spi dut(vif.clk, vif.newd, vif.rst, vif.din, vif.sclk, vif.cs, vif.mosi);
        initial begin
                vif.clk <= 0;
        end
        always #10 vif.clk <= ~vif.clk;
        environment env;
        initial begin
                env = new(vif);
                env.gen.count = 20;
                env.run();
        end
        initial begin
                $dumpfile("dump.vcd");
                $dumpvars;
        end
endmodule


