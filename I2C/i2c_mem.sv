module i2cmem(
        input clk, rst,
        input scl,
        input sda,
        output reg ack);
reg[7:0] mem[128];
reg[7:0] addrin;
reg[7:0] datain;
reg[7:0] temprd;
reg sda_en = 0;
reg sdar = 0;
int i = 0;
int count = 0;
reg sclk_ref = 0;
always @(posedge clk) begin//100M/400K = N => N/2=9
        if(count == 9) begin
                count <= count + 1;
        end
        else begin
                count <= 0;
                sclk_ref <= ~sclk_ref;
        end
end
typedef enum 
        {start = 0,
         store_addr = 1,
         ack_addr = 2,
         store_data = 3,
         ack_data = 4,
         stop = 5,
         send_data = 6} state_type;
state_type  state;
always @(posedge sclk_ref, posedge rst) begin
        if(rst == 1'b1) begin
                for(int j = 0;j < 127; j++) begin
                        mem[j] <= 8'h91;
                end
                sda_en <= 1'b1;
        end
        else begin
                case(state)
                        start: begin//read data
                                sda_en <= 1'b1;
                                if((scl == 1'b1) && (sda == 1'b0)) begin
                                        state <= store_addr;
                                end
                                else 
                                        state <= start;
                        end
                        store_addr: begin
                                sda_en <= 1'b1;
                                if(i <= 7) begin
                                        i <= i + 1;
                                        addrin[i] <= sda;
                                end
                                else begin
                                        state <= ack_addr;
                                        temprd <= mem[addrin[7:1]];
                                        ack <= 1'b1;
                                        i <= 0;
                                end
                        end
                        ack_addr: begin
                                ack <= 1'b0;
                                if(addrin[0] == 1'b1) begin
                                        state <= store_data;
                                        sda_en <= 1'b1;
                                end
                                else begin
                                state <= send_data;
                                i <= 1;
                                sda_en <= 1'b0;//write data
                                sdar <= temprd[0];
                                end
                         end
                         store_data: begin
                                 if(i <= 7) begin
                                 i <= i + 1;
                                 datain[i] <= sda;
                                 end
                                 else begin
                                         state <= ack_data;
                                         ack <= 1'b1;
                                         i <= 0;
                                 end
                         end
                         ack_data: begin
                                 ack <= 1'b0;
                                 mem[addrin[7:1]] <= datain;
                                 state <= stop;
                         end
                         stop: begin
                                 sda_en <= 1'b1;
                                 if((scl == 1'b1) && (sda == 1'b1))
                                         state <= start;
                                 else
                                         state <= stop;
                         end
                         send_data: begin
                                 sda_en <= 1'b0;
                                 if(i <= 7) begin
                                         i <= i + 1;
                                         sdar <= temprd[i];
                                 end
                                 else begin
                                         state <= stop;
                                         i <= 0;
                                         sda_en <= 1'b1;
                                 end
                         end
                         default: state <= start;
                 endcase
         end
 end
 assign sda = (sda_en == 1'b1) ? 1'bz : sdar;
 endmodule









