class driver;
        virtual spi_if vif;
        transaction tr;
        bit[11:0] din;
        mailbox #(transaction) mbx;
        mailbox #(bit [11:0]) mbxds;
        event drvnext;
        function new(mailbox #(bit[11:0]) mbxds,mailbox #(transaction) mbx);
                this.mbxds = mbxds;
                this.mbx = mbx;
        endfunction
        task reset();
                vif.rst <= 1'b1;
                vif.cs <= 1'b1;
                vif.mosi <= 1'b0;
                vif.newd <= 1'b0;
                vif.din <= 1'b0;
                repeat(10) @(posedge vif.clk);
                vif.rst <= 1'b0;
                repeat(5) @(posedge vif.clk);
                $display("[DRV]: reset done");
        endtask
        task run();
                forever begin
                        mbx.get(tr);
                        @(posedge vif.sclk);
                        vif.newd <= 1'b1;
                        vif.din <= tr.din;
                        mbxds.put(tr.din);
                        @(posedge vif.sclk);
                        vif.newd <= 1'b0;
                        wait(vif.cs == 1'b1);
                        $display("[DRV] data sent: %0d",tr.din);
                        ->drvnext;
                end
        endtask
endclass





