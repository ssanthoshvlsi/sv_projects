class driver;
        transaction tr;
        virtual uart_if vif;
        mailbox #(transaction) mbx;
        mailbox #(bit[7:0]) mbxds;//driver to scoreboard/collect data serially in 8 bit regster and compare with dintx data sent from driver
        event drvnext;
        bit[7:0] datarx;
        bit[7:0] din;
        bit wr = 0;
        function new(mailbox #(bit[7:0]) mbxds, mailbox #(transaction) mbx);
                this.mbx = mbx;
                this.mbxds = mbxds;
        endfunction
        task reset();
                vif.rst <= 1'b1;
                vif.dintx <= 0;
                vif.send <= 0;
                vif.rx <= 1'b1;
                vif.doutrx <= 0;
                vif.tx <= 1'b1;
                vif.donerx <= 0;
                vif.donetx <= 0;
                repeat (5) @(posedge vif.uclktx);
                vif.rst <= 1'b0;
                @(posedge vif.uclktx);
                $display("[DRV]: Reset done");
        endtask
        task run();
                forever begin
                        mbx.get(tr);
                        if(tr.oper == 2'b00) begin
                                @(posedge vif.uclktx);
                                vif.rst <= 1'b0;
                                vif.send <= 1'b1;
                                vif.rx <= 1'b1;
                                vif.dintx = tr.dintx;
                                @(posedge vif.uclktx);
                                vif.send <= 1'b0;
                                mbxds.put(tr.dintx);
                                $display("[DRV] data sent: %0d",tr.dintx);
                                wait(vif.donetx == 1'b1);
                                ->drvnext;
                        end
                        else if(tr.oper == 2'b01) begin
                                @(posedge vif.uclkrx);
                                vif.rst <= 1'b0;
                                vif.rx <= 1'b0;
                                vif.send <= 1'b0;
                                @(posedge vif.uclkrx);
                                for(int i=0; i<=7; i++) begin
                                        @(posedge vif.uclkrx);
                                        vif.rx <= $urandom;
                                        datarx[i] = vif.rx;
                                end
                                mbxds.put(datarx);
                                $display("[DRV]: dtat rcvd: %0d",datarx);
                                wait(vif.donerx == 1'b1);
                                vif.rx <= 1'b1;
                                ->drvnext;
                        end
                end
        endtask
endclass




