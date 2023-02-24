`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:32:59 12/20/2021
// Design Name:   fifo
// Module Name:   fifo_test.v
// Project Name:  fifo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fifo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fifo_test_v;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] buf_in;
	reg wr_en;
	reg rd_en;
	reg i;
	// Outputs
	wire [7:0] buf_out;
	wire buf_empty;
	wire buf_full;
	wire [7:0] fifo_counter;

	// Instantiate the Unit Under Test (UUT)
	fifo uut (
		.clk(clk), 
		.rst(rst), 
		.buf_in(buf_in), 
		.buf_out(buf_out), 
		.wr_en(wr_en), 
		.rd_en(rd_en), 
		.buf_empty(buf_empty), 
		.buf_full(buf_full), 
		.fifo_counter(fifo_counter)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		buf_in = 0;
		wr_en = 0;
		rd_en = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = ~rst;
		#5;
		rst = ~rst;
		

	end
	
	always begin
	#100;
		forever #10 clk = ~clk;
	end
	
	initial begin
		#100;
		forever begin
		wr_en = 1;
		buf_in = $random;
		#40;
		wr_en = 0;
		#10;
		end
	end
	
	
	always begin
		#500;
		rd_en = ~rd_en;
		#240;
		rd_en = ~rd_en;
	end
      
endmodule

