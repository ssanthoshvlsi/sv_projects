class environment;
        generator gen;
        driver drv;
        monitor mon;
        scoreboard sco;
        event nextgs;
        mailbox #(transaction) mbxgd;
        mailbox #(transaction) mbxms;
        virtual dff_if vif;
        function new(virtual dff_if vif);
                mbxgd =new();
                gen =new(mbxgd);
                drv = new(mbxgd);
                mbxms = new();
                mon = new(mbxms);
                sco = new(mbxms);
                this.vif = vif;
                mon.vif = this.vif;
                drv.vif = this.vif;
                gen.sconext = nextgs;
                sco.sconext = nextgs;
        endfunction
        task pre_test();
                drv.reset();
        endtask
        task test();
                fork
                        gen.run();
                        drv.run();
                        mon.run();
                        sco.run();
                join_any
        endtask
        task post_test();
                 wait(gen.done.triggered);
                 $finish();
        endtask
        task run();
                pre_test();
                test();
                post_test();
        endtask
endclass

            



                        


