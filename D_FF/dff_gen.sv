class generator;
        transaction tr;
        mailbox #(transaction) mbx;
        int count = 0;
        event sconext;
        event done;
        function new(mailbox #(transaction) mbx);
                this.mbx = mbx;
                tr = new();
        endfunction
        task run();
                repeat (count) begin
                        assert(tr.randomize) else
                                $error("[GEN]: Randomize failed");
                        mbx.put(tr.copy);
                        tr.display("GEN");
                        @(sconext);
                end
                ->done;
        endtask
endclass



