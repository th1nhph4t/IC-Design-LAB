module alu(
    input clk, rst_n,
    input [3:0] operand_a, operand_b,
    input [2:0] op,
    output reg [3:0] result,
    output reg carry_flag
    );
//-----define_ALU_case-------//
`define ALU_ADD                 3'b000
`define ALU_SUB                 3'b001
`define ALU_AND                 3'b010
`define ALU_OR                  3'b011
`define ALU_XOR                 3'b100
`define ALU_NOT                 3'b101
`define ALU_A_SHIFT_RIGHT_B     3'b110
`define ALU_A_SHIFT_LEFT_B      3'b111
//--------define temporary data--------//
wire C1, C2, C3, cin_add, cin_sub, c_out_adder, c_out_sub;
wire [3:0] result_adder, result_sub;
reg [3:0] result_add, result_subtractor;
reg co_adder,co_sub;
//----carry of adder and subtractor-----//
assign cin_add = 0;
assign cin_sub = 1;
//-----adder_4bit------//
adder_4bit module_adder4bit (
    .a(operand_a), 
    .b(operand_b),
    .cin(cin_add),
    .s(result_adder),
    .cout(c_out_adder)
);
always @(posedge clk)
	begin
		if (!rst_n)
			result_add <= 4'b0;
		else begin
			result_add <= result_adder;
		end
	end
	
always @(posedge clk)
	begin
		if (!rst_n)
			co_adder <= 1'b0;
		else begin
			co_adder <= c_out_adder;
		end
	end
//------subtractor_reg----//	
always @(posedge clk)
	begin
		if (!rst_n)
			result_subtractor <= 4'b0;
		else begin
			result_subtractor <= result_sub;
		end
	end
	
always @(posedge clk)
	begin
		if (!rst_n)
			co_sub <= 1'b0;
		else begin
			co_sub <= c_out_sub;
		end
	end
//-----subtractor_4bit--------//
sub_4bit module_sub4bit (
    .a(operand_a), 
    .b(operand_b),
    .cin(cin_sub),
    .s(result_sub),
    .cout(c_out_sub)
);
//---variables define for shift bit-----//
reg [3:0] a_shift_left, a_shift_right;
reg [3:0] temp_data_SR, temp_data_SL;
//----a_shift_right_b_bit---//
always @(posedge clk) 
	begin
		if (!rst_n)
		a_shift_right = 4'b0;
		else begin
		  temp_data_SR = operand_a;
        if (operand_b[0]) temp_data_SR = {1'b0, temp_data_SR[3:1]};
        if (operand_b[1]) temp_data_SR = {2'b0, temp_data_SR[3:2]};
        if (operand_b[2]) temp_data_SR = 4'b0;
        if (operand_b[3]) temp_data_SR = 4'b0;
		  a_shift_right = temp_data_SR;
		  end
	end
//----a_shift_left_b_bit---//
always @(posedge clk) 
	begin
		if (!rst_n)
		a_shift_left = 4'b0;
		else begin
		  temp_data_SL = operand_a;
        if (operand_b[0]) temp_data_SL = {temp_data_SL[2:0], 1'b0};
        if (operand_b[1]) temp_data_SL = {temp_data_SL[1:0], 2'b0};
        if (operand_b[2]) temp_data_SL = 4'b0;
        if (operand_b[3]) temp_data_SL = 4'b0;
		  a_shift_left = temp_data_SL;
		  end
	end
//-------ALU Main------//
always @(posedge clk ) begin
    if (!rst_n) begin
        result <= 0;
        carry_flag <= 0;
    end else begin
        case (op)
            `ALU_ADD: begin
                result <= result_add;
                carry_flag <= co_adder;
            end
            `ALU_SUB: begin
                result <= result_subtractor;
                carry_flag <= co_sub;
            end
            `ALU_AND: begin
                result <= operand_a & operand_b;
                carry_flag <= 0;
            end
            `ALU_OR: begin
                result <= operand_a | operand_b;
                carry_flag <= 0;
            end
            `ALU_XOR: begin
                result <= operand_a ^ operand_b;
                carry_flag <= 0;
            end
            `ALU_NOT: begin
                result <= ~operand_a;
                carry_flag <= 0;
            end
            `ALU_A_SHIFT_RIGHT_B: begin
                result <= a_shift_right;
                carry_flag <= 0;
            end
            `ALU_A_SHIFT_LEFT_B: begin
                result <= a_shift_left;
                carry_flag <= 0;
            end
            default: begin
                result <= 0;
                carry_flag <= 0;
            end
        endcase
    end
end

endmodule
