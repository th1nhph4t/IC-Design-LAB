module counter_testbench;
    reg clk;
    reg rst_n;
    reg sel;
    wire [3:0] out;
	 
    counter dut (
        .clk(clk),
        .rst_n(rst_n),
        .sel(sel),
        .out(out)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst_n = 1;
        sel = 0;
        // reset active
        rst_n = 0;
        #10;
        rst_n = 1;
        // count down
        sel = 0;
        #100;
        // count up
        sel = 1;
        #100;
        // reset active again
        rst_n = 0;
        #10;
        rst_n = 1;
        // Continue counting up after reset
        sel = 1;
        #100;
        $stop;
    end

endmodule
