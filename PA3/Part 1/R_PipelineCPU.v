/*
 *	Template for Project 3 Part 1
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
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module R_PipelineCPU(
	// Outputs
	output	wire	[31:0]	Addr_Out,
	// Inputs
	input	wire	[31:0]	Addr_In,
	input	wire		clk
);
	wire [31:0]IM_OUT, INSTR;
	wire [31:0]RF_SRC_OUT, SRC_DATA; 
	wire [31:0]RF_TAR_OUT, TAR_DATA;
	
	wire [31:0]ALU_OUT, MEM_ALU_OUT, WB_ALU_OUT;
	wire [4:0]EX_DST_ADDR, MEM_DST_ADDR, DST_ADDR;
	wire [5:0]FUNCT, FUNCT_CTRL;
	wire [4:0]SHAMT;
	wire [1:0]CTRL_ALU_OP, ALU_OP;
	wire CTRL_REG_WRITE, EX_REG_WRITE, MEM_REG_WRITE, REG_WRITE;
	
	Adder Address_Adder(
		//Output
		.data_out(Addr_Out),
		//Inputs
		.data1(Addr_In),
		.data2(32'd4)
	);
	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
		.instr(IM_OUT),
		// Inputs
		.instr_addr(Addr_In)
	);

	IF_ID IF_ID_Register(
		//Output
		.instr_out(INSTR),
		//Inputs
		.instr_in(IM_OUT),
		.clk(clk)
	);

	Control Controller(
		//Outputs
		.ALU_OP(CTRL_ALU_OP),
		.reg_write(CTRL_REG_WRITE),
		//Inputs
		.OP(INSTR[31:26])
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
		.src_data(RF_SRC_OUT),
		.tar_data(RF_TAR_OUT),
		// Inputs
		.src_addr(INSTR[25:21]),
		.tar_addr(INSTR[20:16]),
		.dst_addr(DST_ADDR),
		.dst_data(WB_ALU_OUT),
		.clk(clk),
		.reg_write(REG_WRITE)
	);

	ID_EX ID_EX_Register(
		//Outputs
		.wb_out(EX_REG_WRITE),
		.ALU_OP_out(ALU_OP),
		.src_data_out(SRC_DATA),
		.tar_data_out(TAR_DATA),
		.shamt_out(SHAMT),
		.dst_addr_out(EX_DST_ADDR),
		.funct_ctrl_out(FUNCT_CTRL),
		//Inputs
		.wb_in(CTRL_REG_WRITE),
		.ALU_OP_in(CTRL_ALU_OP),
		.src_data_in(RF_SRC_OUT),
		.tar_data_in(RF_TAR_OUT),
		.shamt_in(INSTR[10:6]),
		.dst_addr_in(INSTR[15:11]),
		.funct_ctrl_in(INSTR[5:0]),
		.clk(clk)
	);

	ALU ALU_Unit(
		//outputs
		.data_out(ALU_OUT),
		//inputs
		.src_data(SRC_DATA),
		.tar_data(TAR_DATA),
		.shamt(SHAMT),
		.funct(FUNCT)
	);

	ALU_Control ALU_Controller(
		//Output
		.funct(FUNCT),
    	//inputs
		.funct_ctrl(FUNCT_CTRL),
		.ALU_OP(ALU_OP)
	);

	EX_MEM EX_MEM_Register(
		//Outputs
		.wb_out(MEM_REG_WRITE),
		.ALU_result_out(MEM_ALU_OUT),
		.dst_addr_out(MEM_DST_ADDR),
		//Inputs
		.wb_in(EX_REG_WRITE),
		.ALU_result_in(ALU_OUT),
		.dst_addr_in(EX_DST_ADDR),
		.clk(clk)
	);

	MEM_WB MEM_WB_Register(
		.wb_out(REG_WRITE),
		.ALU_result_out(WB_ALU_OUT),
		.dst_addr_out(DST_ADDR),
		//Inputs
		.wb_in(MEM_REG_WRITE),
		.ALU_result_in(MEM_ALU_OUT),
		.dst_addr_in(MEM_DST_ADDR),
		.clk(clk)
	);

endmodule
