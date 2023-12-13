class driver;
        virtual i2c_if vif;
        transaction tr;
        event drvnext;
        mailbox #(transaction) mbxgd;
        function new(mailbox #(transaction) mbxgd);
                this.mbxgd = mbxgd;
        endfunction
        task reset();
                vif.rst <= 1'b1;
                vif.newd <= 1'b0;
                vif.wr <= 1'b0;
                vif.wdata <= 0;
                vif.addr <= 0;
                repeat(10) @(posedge vif.clk);
                vif.rst <= 1'b0;
                repeat(5) @(posedge vif.clk);
                $display("[DRV]: reset done");
        endtask
        task run();
                forever begin
                        mbxgd.get(tr);
                        @(posedge vif.sclk_ref);
                        vif.rst <= 1'b0;
                        vif.newd <= 1'b1;
                        vif.wr <= tr.wr;
                        vif.wdata <= tr.wdata;
                        vif.addr <= tr.addr;
                        @(posedge vif.sclk_ref);
                        vif.newd <= 1'b0;
                        wait(vif.done == 1'b1);
                        @(posedge vif.sclk_ref);
                        wait(vif.done == 1'b0);
                        $display("[DRV]: wr: %0b wdata: %0d waddr: %0d rdata: %0d",vif.wr, vif.wdata, vif.addr, vif.rdata);
                        ->drvnext;
                end
        endtask
endclass



