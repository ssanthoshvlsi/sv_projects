class driver;
        transaction tr;
        mailbox #(transaction) mbx;
        virtual dff_if vif;
        function new(mailbox #(transaction) mbx);
                this.mbx = mbx;
        endfunction
        task reset();
                vif.rst <= 1'b1;
                repeat(5) @(posedge vif.clk);
                vif.rst <= 1'b0;
                repeat(2) @(posedge vif.clk);
                $display("[DRV] dut reset done");
        endtask
        task run();
                forever begin
                        mbx.get(tr);
                        //@(posedge vif.clk);
                        vif.din <= tr.din;
                        tr.display("DRV");
                        @(posedge vif.clk);
                end
        endtask
endclass



