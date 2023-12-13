class scoreboard;
        transaction tr;
        mailbox #(transaction) mbx;
        event sconext;
        function new(mailbox #(transaction) mbx);
                this.mbx = mbx;
        endfunction
        task run();
                forever begin
                        mbx.get(tr);
                        tr.display("SCO");
                        if(tr.din == tr.dout) 
                                $display("[SCO]: Data matched");
                        else 
                                $display("[SCO]: Data missmatched");
                        ->sconext;
                end
        endtask
endclass

