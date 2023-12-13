class generator;
        transaction tr;
        mailbox #(transaction) mbx;
        event done;//gen sending req. no.of txs
        event drvnext;//drv complete its work
        event sconext;//sco complete its work
        int count = 0;
        function new(mailbox #(transaction) mbx);
                this.mbx = mbx;
                tr = new();
        endfunction
        task run();
                repeat(count) begin
                        assert(tr.randomize)  else
                                $error("randomization failed");
                        mbx.put(tr.copy);
                        tr.display("GEN");
                        @(drvnext);
                        @(sconext);
                end
                ->done;
        endtask
endclass




