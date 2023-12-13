class monitor;
        virtual spi_if vif;
        transaction tr;
        mailbox #(bit[11:0]) mbx;
        bit[11:0] srx;
        function new(mailbox #(bit[11:0]) mbx);
                this.mbx = mbx;
        endfunction
        task run();
                forever begin 
                        @(posedge vif.sclk);
                        wait(vif.cs == 1'b0);
                        @(posedge vif.sclk);
                        for(int i=0; i<=11; i++) begin
                                @(posedge vif.sclk);
                                srx[i] = vif.mosi;
                                //@(posedge vif.sclk);
                        end
                        wait(vif.cs == 1'b1);
                        $display("[MON]: data:%0d",srx);
                        mbx.put(srx); 
                end
        endtask
endclass



