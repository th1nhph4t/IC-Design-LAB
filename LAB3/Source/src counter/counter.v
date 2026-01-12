module counter (
    input clk,     
    input rst_n,     
    input sel,        
    output reg [3:0] out 
);

// Count up 
wire [3:0] count_up;
assign count_up[0] = ~out[0];
assign count_up[1] = out[0] ^ out[1];
assign count_up[2] = out[1] & out[0] ^ out[2];
assign count_up[3] = out[2] & out[1] & out[0] ^ out[3];

// Count down 
wire [3:0] count_down;
assign count_down[0] = ~out[0];
assign count_down[1] = (~out[0]) ^ out[1];
assign count_down[2] = (~out[0] & ~out[1]) ^ out[2];
assign count_down[3] = (~out[0] & ~out[1] & ~out[2]) ^ out[3];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out <= 4'b0000; 
    end else begin
        if (sel) begin
            out <= count_up;
        end else begin
            out <= count_down; 
        end
    end
end

endmodule