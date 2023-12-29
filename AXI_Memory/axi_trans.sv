class transaction;
    rand bit[3:0] id;
    rand bit awvalid;
    bit awready;
    bit[3:0] awid;
    rand bit[3:0] awlen;
    rand bit[2:0] awsize;
    rand bit[31:0] awaddr;
    rand bit[1:0] awburst;
    bit wvalid;
    bit wready;
    bit[3:0] wid;
    rand bit[31:0] wdata;
    rand bit[3:0] wstrb;
    bit wlast;
    bit bready;
    bit bvalid;
    bit[3:0] bid;
    bit[1:0] bresp;
    rand bit arvalid;//master is sending new addr
    bit arready;//slave is rady to accept request
    bit[3:0] arid;//unique id for each transaction
    rand bit[3:0] arlen;//burst len 1 to 16 for axi3, axi4 1 to 256
    bit[2:0] arsize;//unique transaction 1to 128 bytes
    rand bit[31:0] araddr;//write address of transaction
    rand bit[1:0] arburst;//burst size fixed. incr, wrap
    bit rvalidti;
    bit rready;
    bit[3:0] rid;
    bit[31:0] rdata;
    bit[3:0] rstrb;
    bit rlast;
    bit[1:0] rresp;
constraint valid_c{arvalid != awvalid;}
constraint addr_c{awaddr == 5;}
constraint awsize_c{awsize >= 0; awsize < 3;}
constraint awburst_c{awburst == 2;}
constraint arlen_c{arlen > 0; arlen <= 7;}
constraint araddr_c{araddr == 5;}
constraint arburst_c{arburst == 0;}
endclass


