class transaction;
        typedef enum bit[1:0] {write = 2'b00, read = 2'b01} oper_type;
        randc oper_type oper;
        bit rx;
        rand bit[7:0] dintx;
        bit send;
        bit tx;
        bit [7:0] doutrx;
        bit donetx;
        bit donerx;
        function void display(input string tag);
                $display("[%0s]: oper: %0s send: %0b tx_data: %b rx_in: %0b tx_out: %0b rx_out: %0b done_tx: %0b done_rx: %0b", tag, oper.name(), send, dintx, rx, tx, doutrx, donetx, donerx);
        endfunction
        function transaction copy();
                copy = new();
                copy.rx = this.rx;
                copy.dintx = this.dintx;
                copy.send = this.send;
                copy.tx = this.tx;
                copy.doutrx = this.doutrx;
                copy.donetx = this.donetx;
                copy.donerx = this.donerx;
                copy.oper = this.oper;
        endfunction
endclass



