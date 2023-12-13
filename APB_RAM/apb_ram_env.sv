class environment;
        generator gen;
        driver drv;
        event nextgd;
        event nextgs;
        mailbox #(transaction) gdmbx;
        monitor mon;
        scoreboard sco;
        mailbox #(transaction) msmbx;
        virtual apb_if vif;
        function new(virtual apb_if vif);
                gdmbx = new();
                gen = new(gdmbx);
                drv = new(gdmbx);
                msmbx = new();
                mon = new(msmbx);
                sco = new(msmbx);
                this.vif = vif;
                drv.vif = this.vif;
                mon.vif = this.vif;
                gen.nextsco = nextgs;
                sco.nextsco = nextgs;
                gen.nextdrv = nextgd;
                drv.nextdrv = nextgd;
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

                

        
