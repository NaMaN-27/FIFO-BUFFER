`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:44:23 12/23/2021
// Design Name:   fifo
// Module Name:   fifo_test.v
// Project Name:  fifo_final
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
	reg clk_r;
	reg clk_w;
	reg rst;
	reg [7:0] buf_in;
	reg wr_en;
	reg rd_en;
	reg [6:0] thresh_in;

	// Outputs
	wire [7:0] buf_out;
	wire buf_empty;
	wire buf_full;
	wire [7:0] fifo_counter;
	wire uf_check;
	wire of_check;
	wire thresh_out;

	// Instantiate the Unit Under Test (UUT)
	fifo uut (
		.clk_r(clk_r), 
		.clk_w(clk_w), 
		.rst(rst), 
		.buf_in(buf_in), 
		.buf_out(buf_out), 
		.wr_en(wr_en), 
		.rd_en(rd_en), 
		.buf_empty(buf_empty), 
		.buf_full(buf_full), 
		.fifo_counter(fifo_counter), 
		.uf_check(uf_check), 
		.of_check(of_check), 
		.thresh_in(thresh_in), 
		.thresh_out(thresh_out)
	);

	initial begin
		// Initialize Inputs
		clk_r = 0;
		clk_w = 0;
		rst = 0;
		buf_in = 0;
		wr_en = 0;
		rd_en = 0;
		thresh_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = ~rst;
		#10;
		rst = ~rst;
		#3000
		rst = ~rst;
		#10;
		rst = ~rst;
		// Add stimulus here

	end
	
	initial begin
		#100;
		thresh_in = 15;
		thresh_in <= #1500 30;
	end
	
	always begin
	#100;
		forever #20 clk_w = ~clk_w;
	end
	
	always begin
	#100;
		forever #25 clk_r = ~clk_r;
	end
	
	initial begin
		#100;
		forever begin
		wr_en = 1;
		buf_in = $random;
		#80;
		wr_en = 0;
		#20;
		end
	end
	
	initial begin
		#100;
		rd_en = 1;
		#200;
		rd_en = 0;
	end
		
	always begin
		#500;
		rd_en = ~rd_en;
		#240;
		rd_en = ~rd_en;
	end
      
endmodule

