class scoreboard;
        mailbox #(transaction) mbx;
        transaction tr;
        event next;
        bit [7:0] din[$];
        bit [7:0] temp;
        function new(mailbox #(transaction) mbx);
                this.mbx = mbx;
        endfunction
        task run();
                forever begin
                        mbx.get(tr);
                        tr.display("SCO");
                        if(tr.wr == 1'b1) begin
                                din.push_front(tr.data_in);
                                $display("[SCO]: data stored in queue: %0d",tr.data_in);
                        end
                        if(tr.rd == 1'b1) begin
                                if(tr.empty == 1'b0) begin
                                        temp = din.pop_back();
                                        if(tr.data_out == temp)
                                                $display("[SCO]: data match");
                                        else
                                                $display("[SCO]: data mismatch");
                                end
                                else begin
                                                $display("[SCO]: FIFO empty");
                                end
                        end
                        ->next;
                end
        endtask
endclass



