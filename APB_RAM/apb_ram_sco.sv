class scoreboard;
        mailbox #(transaction) mbx;
        transaction tr;
        event nextsco;
        bit [31:0] pwdata[12] = '{default:0};
        bit [31:0] rdata;
        int index;
        function new(mailbox #(transaction) mbx);
                this.mbx = mbx;
        endfunction
        task run();
                forever begin
                        mbx.get(tr);
                        $display("[SCO] data rcvd wdata: %0d rdata: %0d addr: %0d write: %0b",tr.pwdata,tr.prdata,tr.paddr,tr.pwrite);
                        if((tr.pwrite == 1'b1) && (tr.pslverr == 1'b0)) begin
                                pwdata[tr.paddr] = tr.pwdata;
                                $display("[SCO] data stored data : %0d addr %0d", tr.pwdata,tr.paddr);
                        end
                        else if((tr.pwrite == 1'b0) && (tr.pslverr == 1'b0)) begin
                                rdata = pwdata[tr.paddr];
                                if(tr.prdata == rdata)
                                        $display("[SCO] data matched");
                                else 
                                        $display("[SCO] data mismatched");
                        end
                        else if(tr.pslverr == 1'b1) begin
                                $display("[SCO] slv error detected");
                        end
                        ->nextsco;
                end
        endtask
endclass





