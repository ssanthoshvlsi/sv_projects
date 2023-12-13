`include "fifo.sv"
`include "fifo_trans.sv"
`include "fifo_gen.sv"
`include "fifo_drv.sv"
`include "fifo_mon.sv"
`include "fifo_sco.sv"
`include "fifo_env.sv"
/*
/// to verify the transaction class
module tb;
transaction tr;
initial begin
        tr=new();
        tr.display("TOP");
end
endmodule
*/
/*
/// to verify the generator class
module tb;
generator gen;
mailbox #(transaction) mbx;
initial begin
        mbx = new();
        gen = new(mbx);
        gen.count = 20;
        gen.run();
end
endmodule
*/
/*
/// to verify the driver class
module tb();
        generator gen;
        driver drv;
        event next;
        mailbox #(transaction) mbx;
        fifo_if fif();
        fifo dut(.clock(fif.clock), .rd(fif.rd), .wr(fif.wr), .full(fif.full), .empty(fif.empty), .data_in(fif.data_in), .data_out(fif.data_out), .rst(fif.rst));
        initial begin
                fif.clock <= 0;
        end
        always #10 fif.clock <= ~fif.clock;
        initial begin
                mbx = new();
                gen = new(mbx);
                gen.count = 20;
                drv  = new(mbx);
                //gen.count = 20;
                drv.fif = fif;
                gen.next = next;
                drv.next = next;
        end
        initial begin 
                fork
                        gen.run();
                        drv.run();
                join
        end
        initial begin 
                #800;
                $finish();
        end
        initial begin
                $dumpfile("dump.vcd");
                $dumpvars(0,tb);
        end
endmodule
*/
/*
module tb;
        monitor mon;
        scoreboard sco;
        mailbox #(transaction) mbx;
        event next;
        fifo_if fif();
        fifo dut(.clock(fif.clock), .rd(fif.rd), .wr(fif.wr), .full(fif.full), .empty(fif.empty), .data_in(fif.data_in), .data_out(fif.data_out), .rst(fif.rst));
        initial begin
                fif.clock <= 0;
        end
        always #10 fif.clock <= ~fif.clock;
        initial begin
                mbx = new();
                mon = new(mbx);
                sco = new(mbx);
                mon.fif = fif;
                mon.next = next;
                sco.next = next;
        end
        initial begin 
                fork
                        mon.run();
                        sco.run();
                join
        end
        initial begin 
                #800;
                $finish();
        end
        initial begin
                $dumpfile("dump.vcd");
                $dumpvars;
        end
endmodule
*/
module tb;
        fifo_if fif();
        fifo dut(.clock(fif.clock), .rd(fif.rd), .wr(fif.wr), .full(fif.full), .empty(fif.empty), .data_in(fif.data_in), .data_out(fif.data_out), .rst(fif.rst));
        initial begin
                fif.clock <= 0;
        end
        always #10 fif.clock <= ~fif.clock;
        environment env;
        initial begin
                env = new(fif);
                env.gen.count = 20;
                env.run();
        end
        initial begin
                $dumpfile("dump.vcd");
                $dumpvars;
        end
endmodule
