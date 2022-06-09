/*
 *	Template for Project 3 Part 3
 *	Copyright (C) 2021  Lee Kai Xuan or any person belong ESSLab.
 *	All Right Reserved.
 *
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *	This file is for people who have taken the cource (1092 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */
 
/*
 * Macro of size declaration of register memory
 * CAUTION: DONT MODIFY THE NAME AND VALUE.
 */
`define REG_MEM_SIZE	32	// Words

/*
 * Declaration of Register File for this project.
 * CAUTION: DONT MODIFY THE NAME.
 */
module RF(
	// Outputs
	output [31:0]src_data,
	output [31:0]tar_data,
	// Inputs
	input [4:0]src_addr,
	input [4:0]tar_addr,
	input [4:0]dst_addr,
	input [31:0]dst_data,
	input clk,
	input reg_write
);

	/* 
	 * Declaration of inner register.
	 * CAUTION: DONT MODIFY THE NAME AND SIZE.
	 */
	reg [31:0]R[0:`REG_MEM_SIZE - 1];

		//assign value by register point by address
		assign src_data = R[src_addr];
		assign tar_data = R[tar_addr];
	always@(posedge clk)begin
		//write result to register addressed by dst_data
		if(reg_write)begin
			R[dst_addr] <= dst_data;
		end
	end
endmodule
