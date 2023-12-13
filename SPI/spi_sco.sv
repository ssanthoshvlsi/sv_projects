class scoreboard;
        mailbox #(bit[11:0]) mbxms, mbxds;
        bit[11:0] ds;
        bit[11:0] ms;
        event sconext;
        function new(mailbox #(bit[11:0]) mbxds, mailbox #(bit[11:0]) mbxms);
                this.mbxms = mbxms;
                this.mbxds = mbxds;
        endfunction
        task run();
                forever begin
                        mbxds.get(ds);
                        mbxms.get(ms);
                        $display("[SCO] drv data: %0d mon data: %0d",ds,ms);
                        if(ds==ms)
                                $display("[SCO]: data mathched");
                        else 
                                $display("[SCO]: data mismatched");
                ->sconext;
                end
        endtask
endclass


