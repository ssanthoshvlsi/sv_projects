class monitor;
        virtual i2c_if vif;
        transaction tr;
        mailbox #(transaction) mbxms;
        event sconext;
        function new(mailbox #(transaction) mbxms);
                this.mbxms = mbxms;
        endfunction
        task run();
                tr = new();
                forever begin
                        @(posedge vif.sclk_ref);
                        if(vif.newd == 1'b1) begin
                                if(vif.wr == 1'b0) begin
                                        tr.wr = vif.wr;
                                        tr.wdata = vif.wdata;
                                        tr.addr = vif.addr;
                                        @(posedge vif.sclk_ref);
                                        wait(vif.done == 1'b1);
                                        tr.rdata = vif.rdata;
                                        repeat(2) @(posedge vif.sclk_ref);
                                        $display("[MON] data read-> waddr: %0d rdata: %0d",tr.addr,tr.rdata);
                                end
                                else begin
                                        tr.wr = vif.wr;
                                        tr.wdata = vif.wdata;
                                        tr.addr = vif.addr;
                                        @(posedge vif.sclk_ref);
                                        wait(vif.done == 1'b1);
                                        tr.rdata = vif.rdata;
                                        repeat(2) @(posedge vif.sclk_ref);
                                        $display("[MON] data write-> wdata: %0d waddr: %0d", tr.wdata, tr.addr);
                                end
                                ->sconext;
                                mbxms.put(tr);
                        end
                end
        endtask
endclass





