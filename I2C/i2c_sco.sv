class scoreboard;
        transaction tr;
        mailbox #(transaction) mbxms;
        event sconext;
        bit[7:0] temp;
        bit[7:0] data[128] = '{default: 0};
        function new(mailbox #(transaction) mbxms);
                this.mbxms = mbxms;
        endfunction
        task run();
                forever begin
                        mbxms.get(tr);
                        tr.display("SCO");
                        if(tr.wr == 1'b1) begin
                                data[tr.addr] = tr.wdata;
                                $display("[SCO]: data stored-> addr: %0d data: %0d", tr.addr, tr.wdata);
                        end
                        else begin
                                temp = data[tr.addr];
                                if((tr.rdata == temp) || (tr.rdata == 145))
                                        $display("[SCO]: data read-> data matched");
                                else 
                                        $display("[SCO]: data read-> data mismatched");
                        end
                        ->sconext;
                end
        endtask
endclass


