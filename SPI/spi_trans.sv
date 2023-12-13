class transaction;
        rand bit [11:0] din;
        rand bit newd;
        bit cs;
        bit mosi;
        function void display(input string tag);
                $display("[%0s]: din: %0d, newd : %0b, cs : %0b, mosi : %0b",tag,din,newd,cs,mosi);
        endfunction
        function transaction copy();
                copy = new();
                copy.newd = this.newd;
                copy.din = this.din;
                copy.cs = this.cs;
                copy.mosi = this.mosi;
        endfunction
endclass

