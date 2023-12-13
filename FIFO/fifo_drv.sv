class driver;
    virtual fifo_if fif;
    mailbox #(transaction) mbx;
    transaction datac;
    event next;
function new (mailbox #(transaction) mbx);
        this.mbx = mbx;
endfunction
task reset();
        fif.rst <= 1'b1;
        fif.rd <= 1'b0;
        fif.wr <= 1'b0;
        fif.data_in <= 0;
        repeat(5) @(posedge fif.clock);
        fif.rst <= 1'b0;
        $display("[DRV]: DUT reset done");
endtask
task run();
        forever begin 
                mbx.get(datac);
                datac.display("DRV");
                fif.rd <= datac.rd;
                fif.wr <= datac.wr;
                fif.data_in <= datac.data_in;
                repeat(2) @(posedge fif.clock);
                ->next;
        end
endtask
endclass



