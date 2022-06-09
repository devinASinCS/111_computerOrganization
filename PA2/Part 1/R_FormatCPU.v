/*
 *	Template for Project 2 Part 1
 *	Copyright (C) 2022  Chen Chia Yi or any person belong ESSLab.
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
 *	This file is for people who have taken the cource (1102 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */

/*
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module R_FormatCPU(
	// Outputs
	output	wire	[31:0]	Addr_Out,
	// Inputs
	input	wire	[31:0]	Addr_In,
	input	wire			clk
);
	wire [31:0]INSTR, SRC_DATA, TAR_DATA, DST_DATA;
	wire [5:0]FUNCT;
	wire [1:0]ALU_OP;
	wire REG_WRITE;

	IM Instr_Memory(
		// Outputs
		.instr(INSTR),
		// Inputs
		.instr_addr(Addr_In)
	);
	RF Register_File(
		// Outputs
		.src_data(SRC_DATA),
		.tar_data(TAR_DATA),
		// Inputs
		.src_addr(INSTR[25:21]),
		.tar_addr(INSTR[20:16]),
		.dst_addr(INSTR[15:11]),
		.dst_data(DST_DATA),
		.clk(clk),
		.reg_write(REG_WRITE)
	);
	Control Control_Unit(
		//outputs
		.ALU_OP(ALU_OP),
		.reg_write(REG_WRITE),
		//inputs
		.OP(INSTR[31:26])
	);
	ALU ALU_Unit(
		//outputs
		.dst_data(DST_DATA),
		//inputs
		.src_data(SRC_DATA),
		.tar_data(TAR_DATA),
		.shamt(INSTR[10:6]),
		.funct(FUNCT)
	);
	ALU_Control ALU_Control_Unit(
		//outputs
		.funct(FUNCT),
		//inputs
		.funct_ctrl(INSTR[5:0]),
		.ALU_OP(ALU_OP)
	);
	Adder ADDER(
		//output
		.addr_out(Addr_Out),
		//input
		.addr_in(Addr_In),
		.clk(clk)
	);
endmodule
