class generator;
        transaction tr;
        mailbox #(transaction) mbx;
        function new (mailbox #(transaction) mbx);//adding constructor
                this.mbx = mbx;
                tr = new();
        endfunction
        int count = 0;
        event next;//when to send next trans.
        event done;//complition of request.
        task run();
                repeat(count) begin
                        assert(tr.randomize()) else 
                                $error("RANDOMIZATION IS FAILED");
                        mbx.put(tr.copy);//transaction copy to driver 
                        tr.display("GEN");
                        @(next);
                end
                ->done;
        endtask
endclass
