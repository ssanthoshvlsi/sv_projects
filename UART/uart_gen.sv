class generator;
        transaction tr;
        mailbox #(transaction) mbx;
        event done;
        int count = 0;
        event drvnext;
        event sconext;
        function new(mailbox #(transaction) mbx);
                this.mbx = mbx;
                tr = new();
        endfunction
        task run();
                repeat(count) begin
                        assert(tr.randomize) else
                                $error("[GEN]: randomization failed");
                        mbx.put(tr.copy);
                        tr.display("GEN");
                        @(drvnext);
                        @(sconext);
                end
                ->done;
        endtask
endclass


