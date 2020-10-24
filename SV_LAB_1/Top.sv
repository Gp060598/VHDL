module top;
      logic clk;
		  logic reset;
		  logic write;
		  logic [15:0] data_in;
		  logic [2:0] address;
		 logic [15:0] data_out;
		
		always #50 clk =~clk;
	config_reg t0(clk, reset, write, data_in, address, data_out);
	test t1(clk, reset, write, data_in, address, data_out);	
		
endmodule;

