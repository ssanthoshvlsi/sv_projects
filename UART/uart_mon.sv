class monitor;
        transaction tr;
        mailbox #(bit[7:0]) mbx;
        bit [7:0] srx;//send
        bit [7:0] rrx;//recv
        virtual uart_if vif;
        //event sconext;
        function new(mailbox #(transaction) mbx);
                this.mbx = mbx;
        endfunction
        task run();
                forever begin
                        @(posedge vif.uclktx);
                        if((vif.send == 1'b1) && (vif.rx == 1'b1)) begin
                                @(posedge vif.uclktx)
                                for(int i = 0; i <= 7; i++) begin
                                        @(posedge vif.uclktx);
                                        srx[i] = vif.tx;
                                end
                                $display("[MON]: data send on uart tx %0d",srx);
                                @(posedge vif.uclktx);
                                mbx.put(srx);
                                end
                        else if((vif.send == 1'b0) && (vif.rx == 1'b0)) begin
                                wait (vif.donerx == 1);
                                rrx = vif.doutrx;
                                $display("[MON]: data rcvd rx %0d",rrx);
                                @(posedge vif.uclktx);
                                mbx.put(rrx);
                        end
                       // ->sconext;
                end
        endtask
endclass


