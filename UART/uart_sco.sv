class scoreboard;
        mailbox #(bit[7:0]) mbxds,mbxms;
        bit[7:0] ds;
        bit[7:0] ms;
        event sconext;
        function new(mailbox #(bit[7:0]) mbxds, mailbox #(bit[7:0])mbxms);
                this.mbxds = mbxds;
                this.mbxms = mbxms;
        endfunction
        task run();
                forever begin
                        mbxds.get(ds);
                        mbxms.get(ms);
                        $display("[SCO]: drv: %0d mon: %0d",ds,ms);
                        if(ds == ms)
                                $display("data matched");
                        else 
                                $display("data mismatched");
                        ->sconext;
                end
        endtask
endclass



