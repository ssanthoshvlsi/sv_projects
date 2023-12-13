class transaction;
        bit newd;
        rand bit wr;
        rand bit [7:0] wdata;
        rand bit [6:0] addr;
        bit [7:0] rdata;
        bit done;
        constraint addr_c{addr > 0; addr < 5;}
        constraint rd_wr_c{wr dist{1 :/ 50, 0 :/ 50};}
        function void display(input string tag);
                $display("[%0s]: WR: %0b WDATA: %0d ADDR: %0d RDATA: %0d DONE: %0b",tag, wr, wdata, addr, rdata, done);
        endfunction
        function transaction copy();
                copy = new();
                copy.newd = this.newd;
                copy.wr = this.wr;
                copy.wdata = this.wdata;
                copy.addr = this.addr;
                copy.rdata = this.rdata;
                copy.done = this.done;
        endfunction
endclass
