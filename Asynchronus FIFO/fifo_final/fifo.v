`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:33:16 12/23/2021 
// Design Name: 
// Module Name:    fifo 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fifo( clk_r, clk_w, rst, buf_in, buf_out, wr_en, rd_en, buf_empty, buf_full, fifo_counter, uf_check, of_check, thresh_in, thresh_out);

input rst, clk_r, clk_w, wr_en, rd_en;
input [7:0] buf_in;
input [6:0] thresh_in;

output[7:0] buf_out;
output buf_empty, buf_full; 
output[ 7:0] fifo_counter;
output uf_check, of_check;
output thresh_out;

reg thresh_out;
reg uf_check, of_check;
reg[7:0] buf_out; 
reg buf_empty, buf_full; 
reg[7:0] fifo_counter;
reg[6:0] rd_ptr, wr_ptr;
reg[7:0] buf_mem[63 : 0];



always @(fifo_counter) begin
buf_empty = (fifo_counter == 0);
buf_full = (fifo_counter == 64);
of_check = (fifo_counter >= 62) && wr_en;
uf_check = (fifo_counter <= 2) && rd_en;
thresh_out = (fifo_counter <= thresh_in);
end


always@(posedge clk_r or posedge rst) begin
if(rst) fifo_counter <= 0;

else if( !buf_empty && rd_en )
	fifo_counter <= fifo_counter - 1;
	
else
	fifo_counter <= fifo_counter;
end


always@(posedge clk_w or posedge rst) begin
if(rst) fifo_counter <= 0;

else if( !buf_full && wr_en )
	fifo_counter <= fifo_counter + 1;
	
else
	fifo_counter <= fifo_counter;
end



always @( posedge clk_r or posedge rst) begin //read
	if( rst) buf_out <= 0;
	else begin
		if( rd_en && !buf_empty )
			buf_out <= buf_mem[rd_ptr];
		else
			buf_out <= buf_out;
	end
end


always @(posedge clk_w) begin //write
	if( wr_en && !buf_full )
		buf_mem[ wr_ptr ] <= buf_in;
	else
		buf_mem[ wr_ptr ] <= buf_mem[ wr_ptr ];
end


always@(posedge clk_w or posedge rst) begin //wptr
	if( rst ) begin
		wr_ptr <= 0;
		rd_ptr <= 0;
	end
	else begin
		if( !buf_full && wr_en )
			wr_ptr <= wr_ptr%64 + 1;
		else
			wr_ptr <= wr_ptr;
	end
end

		
always@(posedge clk_r) begin //rptr

		if( !buf_empty && rd_en )
			rd_ptr <= rd_ptr%64 + 1;
		else
			rd_ptr <= rd_ptr;
			
end


endmodule

