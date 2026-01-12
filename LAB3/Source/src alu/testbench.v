module alu_testbench;
    reg clk;
    reg rst_n;
    reg [3:0] operand_a;
    reg [3:0] operand_b;
    reg [2:0] op;
    wire [3:0] result;
    wire carry_flag;

    alu dut ( 
        .clk(clk),
        .rst_n(rst_n),
        .operand_a(operand_a),
        .operand_b(operand_b),
        .op(op),
        .result(result),
        .carry_flag(carry_flag)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst_n = 1;  
	operand_a = 4'b0000;
	operand_b = 4'b0000;
	op = 3'b000;
        // Test cases 
	#50;
	operand_a = 4'b0101;  // 5
        operand_b = 4'b0101;  // 5
        op = 3'b000;          // Addition
        #50; 
        operand_a = 4'b1101;  // 13
        operand_b = 4'b0111;  // 7
	#50;
	rst_n = 0;
        #10;
	rst_n = 1;
        operand_a = 4'b1111;  // 15
        operand_b = 4'b0011;  // 3
        op = 3'b001;          // Subtraction
	#50;
	operand_a = 4'b0001;  // 1
        operand_b = 4'b0101;  // 5
	#50;
	rst_n = 0;
        #10;
	rst_n = 1;
        operand_a = 4'b1101;
        operand_b = 4'b1011;  
        op = 3'b010;          // AND
	#50;
	rst_n = 0;
        #10;
	rst_n = 1;
        operand_a = 4'b0101; 
        operand_b = 4'b0011; 
        op = 3'b011;          // OR
	#50;
	rst_n = 0;
        #10;
	rst_n = 1;
        operand_a = 4'b1101; 
        operand_b = 4'b0111; 
        op = 3'b100;          // XOR
	#50;
	rst_n = 0;
        #10;
	rst_n = 1;
        operand_a = 4'b0101; 
        operand_b = 4'b0011;
        op = 3'b101;          // NOT
	#50;
	rst_n = 0;
        #10;
	rst_n = 1;
        operand_a = 4'b1101; 
        operand_b = 4'b0011;  // 3
        op = 3'b110;          // Shift right
	#50;
	rst_n = 0;
        #10;
	rst_n = 1;
        operand_a = 4'b1110;  // 13
        operand_b = 4'b0010;  // 2  
        op = 3'b111;          // Shift left
        #70;

        $stop;  // End the simulation
    end
endmodule
