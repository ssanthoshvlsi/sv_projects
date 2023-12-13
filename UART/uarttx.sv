module uarttx #(
        parameter clk_freq = 1000000,//1MHz
        parameter baurd_rate = 9600)//o/p baurd rate from system
        (input clk,rst,
         input send,
         input reg [7:0] tx_data,
         output reg tx,
         output reg donetx);
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
                state <= idle;
        end
        else begin
                case(state)
                        idle: begin
                                count <= 0;
                                counts <= 0;
                                tx <= 1'b1;
                                donetx <= 1'b0;
                                if(send) begin
                                        state <= transfer;
                                        din <= tx_data;
                                        tx <= 1'b0;
                                end
                                else 
                                        state <= idle;
                        end
                        transfer: begin
                                if(counts <= 7)begin
                                        counts <= counts + 1;
                                        tx <= din[counts];
                                        state <= transfer;
                                end
                                else begin
                                        counts <= 0;
                                        tx <= 1'b1;
                                        state <= idle;
                                        donetx <= 1'b1;
                                end
                        end
                        default : state <= idle;
                endcase
        end
end
endmodule
