
# Entity: axi_slave 
- **File**: axi_mem.sv

## Diagram
![Diagram](axi_slave.svg "Diagram")
## Ports

| Port name | Direction | Type   | Description |
| --------- | --------- | ------ | ----------- |
| clk       | input     |        |             |
| resetn    | input     |        |             |
| awvalid   | input     |        |             |
| awready   | output    |        |             |
| awid      | input     | [3:0]  |             |
| awlen     | input     | [3:0]  |             |
| awsize    | input     | [2:0]  |             |
| awaddr    | input     | [31:0] |             |
| awburst   | input     | [1:0]  |             |
| wvalid    | input     |        |             |
| wready    | output    |        |             |
| wid       | input     | [3:0]  |             |
| wdata     | input     | [31:0] |             |
| wstrb     | input     | [3:0]  |             |
| wlast     | input     |        |             |
| bready    | input     |        |             |
| bvalid    | output    |        |             |
| bid       | output    | [3:0]  |             |
| bresp     | output    | [1:0]  |             |
| arready   | output    |        |             |
| arid      | input     | [3:0]  |             |
| araddr    | input     | [31:0] |             |
| arlen     | input     | [3:0]  |             |
| arsize    | input     | [2:0]  |             |
| arburst   | input     | [1:0]  |             |
| arvalid   | input     |        |             |
| rid       | output    | [3:0]  |             |
| rdata     | output    | [31:0] |             |
| rresp     | output    | [1:0]  |             |
| rlast     | output    |        |             |
| rvalid    | output    |        |             |
| rready    | input     |        |             |

## Signals

| Name                     | Type       | Description |
| ------------------------ | ---------- | ----------- |
| awaddrt                  | reg[31:0]  |             |
| wdatat                   | reg [31:0] |             |
| mem[128] = '{default:12} | reg [7:0]  |             |
| retaddr                  | reg [31:0] |             |
| nextaddr                 | reg [31:0] |             |
| first                    | reg        |             |
| boundary                 | reg[7:0]   |             |
| wlen_count               | reg[3:0]   |             |
| araddrt                  | reg[31:0]  |             |
| rdfirst                  | reg        |             |
| rdnextaddr               | bit[31:0]  |             |
| rdretaddr                | bit[31:0]  |             |
| len_count                | reg[3:0]   |             |
| rdboundary               | reg[7:0]   |             |

## Functions
- data_wr_fixed <font id="function_arguments">(input[3:0] wstrb,<br><span style="padding-left:20px"> input[31:0] awaddrt)</font> <font id="function_return">return (bit[31:0])</font>
- data_wr_incr <font id="function_arguments">(input[3:0] wstrb,<br><span style="padding-left:20px"> input[31:0] awaddrt)</font> <font id="function_return">return (bit[31:0])</font>
- wrap_boundary <font id="function_arguments">(input bit[3:0] awlen,<br><span style="padding-left:20px"> input bit[2:0] awsize)</font> <font id="function_return">return (bit[7:0])</font>
- data_wr_wrap <font id="function_arguments">(input[3:0] wstrb,<br><span style="padding-left:20px"> input[31:0] awaddrt,<br><span style="padding-left:20px"> input[7:0] wboundary)</font> <font id="function_return">return (bit[31:0])</font>
- read_data_fixed <font id="function_arguments">(input [31:0]addr,<br><span style="padding-left:20px"> input[2:0] arsize)</font> <font id="function_return">return (void)</font>
- read_data_incr <font id="function_arguments">(input [31:0] addr,<br><span style="padding-left:20px"> input[2:0] arsize)</font> <font id="function_return">return (bit[31:0])</font>
- read_data_wrap <font id="function_arguments">(input bit[31:0] addr,<br><span style="padding-left:20px"> input bit[2:0] rsize,<br><span style="padding-left:20px"> input[7:0] rboundary)</font> <font id="function_return">return (bit[31:0])</font>

## Processes
- unnamed: ( @(posedge clk, negedge resetn) )
  - **Type:** always_ff
- unnamed: (  )
  - **Type:** always_comb
- unnamed: (  )
  - **Type:** always_comb
- unnamed: (  )
  - **Type:** always_comb
- unnamed: ( @(posedge clk, negedge resetn) )
  - **Type:** always_ff
- unnamed: (  )
  - **Type:** always_comb
- unnamed: (  )
  - **Type:** always_comb

## State machines

![Diagram_state_machine_0]( fsm_axi_slave_00.svg "Diagram")![Diagram_state_machine_1]( fsm_axi_slave_11.svg "Diagram")![Diagram_state_machine_2]( fsm_axi_slave_22.svg "Diagram")![Diagram_state_machine_3]( fsm_axi_slave_33.svg "Diagram")![Diagram_state_machine_4]( fsm_axi_slave_44.svg "Diagram")