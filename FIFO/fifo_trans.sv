class transaction;
        rand bit wr, rd;//2 state 
        rand bit [7:0] data_in;
        bit full, empty;
        bit [7:0] data_out;
        constraint wr_rd{
                rd != wr;
                wr dist {0:/50,1:/50};
                rd dist {0:/50,1:/50};
        }
        constraint data_con{
                data_in > 1; data_in < 5;

        }
        function void display(input string tag);
                $display("[%0s]: wr : %0b \t rd : %0b \t datawr : %0d \t datard : %0d \t full = %0d \t empty : %0d @ %0t", tag, wr, rd, data_in, data_out, full,empty, $time);
        endfunction
        function transaction copy();
                copy = new();
                copy.rd = this.rd;
                copy.wr = this.wr;
                copy.data_in = this.data_in;
                copy.data_out = this.data_out;
                copy.full = this.full;
                copy.empty = this.empty;
        endfunction
endclass
