module uartrx #(
        parameter clk_freq = 1000000,//1MHz
        parameter baurd_rate = 9600)//o/p baurd rate from system
        (input clk,rst,
         input rx,
         output reg [7:0] rx_data,
         output reg donerx);
 localparam clkcount = (clk_freq/baurd_rate);//if x
 integer count = 0;
 integer counts = 0;
 reg uclk = 0;//if count is x/2
 enum bit[1:0] {idle = 2'b00, start = 2'b01, transfer = 2'b10, done = 2'b11} state;
 always @(posedge clk) begin//uart clk generation
         if(count < clkcount/2)
                 count <= count + 1;
         else begin
                 count <= 0;
                 uclk <= ~uclk;
         end
 end
reg [7:0] din;
always @(posedge uclk) begin //reset decoder
        if(rst) begin
                rx_data <= 8'h00;
                counts <= 0;
                donerx <= 1'b0;
        end
        else begin
                case(state)
                        idle: begin
                                rx_data <= 8'h00;
                                counts <= 0;
                                donerx <= 1'b0;
                                if(rx == 1'b0)
                                        state <= start;
                                else 
                                        state <= idle;
                        end
                        start: begin
                                if(counts <= 7)
                                begin
                                        counts <= counts + 1;
                                        rx_data <= {rx, rx_data[7:1]};
                                end
                                else begin
                                        counts <= 0;
                                        donerx <= 1'b1;
                                        state <= idle;
                                end
                        end
                        default : state <= idle;
                endcase
        end
end
endmodule
