/*
 *	Template for Project 2 Part 3
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
module SimpleCPU(
	// Outputs
	output	wire	[31:0]	Addr_Out,
	// Inputs
	input	wire	[31:0]	Addr_In,
	input	wire			clk
);
	wire [31:0]INSTR, SRC_DATA, TAR_DATA, DST_DATA;
	wire [31:0]ALU_IN, ALU_OUT, IMM, DM_OUT, NEXT_PC;
	wire [31:0]BRANCH_ADDR, NON_JUMP_ADDR;
	wire [5:0]FUNCT;
	wire [4:0]DST_ADDR;
	wire [1:0]ALU_OP;
	wire REG_WRITE, REG_DST, ALU_SRC, MEM_READ;
	wire MEM_WRITE, MEM2REG, BRANCH, JUMP, ZERO;
	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
		.instr(INSTR),
		// Inputs
		.instr_addr(Addr_In)
	);
	Adder Address_Adder(
		//output
		.data_out(NEXT_PC),
		//inputs
		.data1(Addr_In),
		.data2(32'd4)
	);
	
	MUX5 DST_Addr_MUX(
		//outputs
		.data_out(DST_ADDR),
		//inputs
		.data0(INSTR[20:16]),
		.data1(INSTR[15:11]),
		.select(REG_DST)
	);

	RF Register_File(
		// Outputs
		.src_data(SRC_DATA),
		.tar_data(TAR_DATA),
		// Inputs
		.src_addr(INSTR[25:21]),
		.tar_addr(INSTR[20:16]),
		.dst_addr(DST_ADDR),
		.dst_data(DST_DATA),
		.reg_write(REG_WRITE),
		.clk(clk)
	);

	Control Controller(
		//Outputs
		.ALU_OP(ALU_OP),
		.reg_write(REG_WRITE),
		.reg_dst(REG_DST),
		.ALU_src(ALU_SRC),
		.mem_write(MEM_WRITE),
		.mem_read(MEM_READ),
		.mem2reg(MEM2REG),
		.branch(BRANCH),
		.jump(JUMP),
		//Input
		.OP(INSTR[31:26])
	);

	ALU_Control ALU_Controller(
		//Output
		.funct(FUNCT),
		//Inputs
		.funct_ctrl(INSTR[5:0]),
		.ALU_OP(ALU_OP)
	);

	Sign_Extend Sign_Extend_Unit(
		//output
		.extend_out(IMM),
		//input
		.immediate(INSTR[15:0])
	);

	MUX32 ALU_MUX(
		//outputs
		.data_out(ALU_IN),
		//inputs
		.data0(TAR_DATA),
		.data1(IMM),
		.select(ALU_SRC)
	);

	ALU ALU_Unit(
		//output
		.data_out(ALU_OUT),
		.zero(ZERO),
		//inputs
		.src_data(SRC_DATA),
		.tar_data(ALU_IN),
		.shamt(INSTR[10:6]),
		.funct(FUNCT)
	);

	DM Data_Memory(
		// Outputs
		.read_data(DM_OUT),
		// Inputs
		.write_data(TAR_DATA),
		.addr(ALU_OUT),
		.mem_read(MEM_READ),
		.mem_write(MEM_WRITE),
		.clk(clk)
	);

	MUX32 DST_MUX(
		//outputs
		.data_out(DST_DATA),
		//inputs
		.data0(ALU_OUT),
		.data1(DM_OUT),
		.select(MEM2REG)
	);

	Adder Branch_Adder(
		//Output
		.data_out(BRANCH_ADDR),
		//Inputs
		.data1(NEXT_PC),
		.data2(IMM << 2)
	);

	MUX32 Branch_MUX(
		//Output
		.data_out(NON_JUMP_ADDR),
		//Inputs
		.data0(NEXT_PC),
		.data1(BRANCH_ADDR),
		.select(BRANCH && ZERO)
	);

	MUX32 ADDR_OUT_MUX(
		//Output
		.data_out(Addr_Out),
		//Inputs
		.data0(NON_JUMP_ADDR),
		.data1({NEXT_PC[31:28], INSTR[25:0], 2'b00}),
		.select(JUMP)
	);

endmodule
