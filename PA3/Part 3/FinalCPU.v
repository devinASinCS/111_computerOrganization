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
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module FinalCPU(
	// Outputs
	output	wire			PCWrite,
	output	wire	[31:0]	Addr_Out,

	// Inputs
	input	wire	[31:0]	Addr_In,
	input	wire			clk
);
	wire [31:0]IM_OUT, INSTR;
	wire [31:0]ID_SRC_DATA, SRC_DATA, FORWARD_SRC_DATA;
	wire [31:0]ID_R_TAR_DATA, R_TAR_DATA, FORWARD_TAR_DATA;
	wire [31:0]ID_I_TAR_DATA, I_TAR_DATA, TAR_DATA;
	wire [31:0]ALU_OUT, MEM_ALU_OUT, WB_ALU_OUT;
	wire [31:0]MEM_READ_DATA, WB_MEM_READ_DATA;
	wire [31:0]MEM_WRITE_DATA;
	wire [31:0]DST_DATA;
	wire [5:0]FUNCT_CTRL, FUNCT;
	wire [4:0]R_DST_ADDR, I_DST_ADDR, EX_DST_ADDR, MEM_DST_ADDR, DST_ADDR;
	wire [4:0]EX_SRC_ADDR;
	wire [4:0]ID_I_DST_ADDR, ID_SRC_ADDR;
	wire [4:0]SHAMT;
	wire [1:0]CTRL_ALU_OP, ID_ALU_OP, ALU_OP;
	wire [1:0]FORWARD_TAR, FORWARD_SRC;
	wire CTRL_REG_WRITE, ID_REG_WRITE, EX_REG_WRITE, MEM_REG_WRITE, REG_WRITE;
	wire CTRL_REG_DST, ID_REG_DST, REG_DST;
	wire CTRL_ALU_SRC, ID_ALU_SRC, ALU_SRC;
	wire CTRL_MEM_WRITE, ID_MEM_WRITE, EX_MEM_WRITE, MEM_WRITE;
	wire CTRL_MEM_READ, ID_MEM_READ, EX_MEM_READ, MEM_READ;
	wire CTRL_MEM2REG, ID_MEM2REG, EX_MEM2REG, MEM_MEM2REG, MEM2REG;
	wire CTRL_BRANCH, ID_BRANCH, EX_BRANCH, BRANCH;
	wire CTRL_JUMP, ID_JUMP, EX_JUMP, JUMP;
	wire ZERO_FLAG;
	wire STALL, IF_ID_WRITE;

	Adder Address_Adder(
		//Outputs
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
		//Outputs
		.instr_out(INSTR),
		//Inputs
		.instr_in(IM_OUT),
		.IF_ID_write(IF_ID_WRITE),
		.clk(clk)
	);

	Hazard_Detection Hazard_Detection_Unit(
		//Outputs
		.PC_write(PCWrite),
		.stall(STALL),
		.IF_ID_write(IF_ID_WRITE),
		//Inputs
		.EX_tar_addr(I_DST_ADDR),
		.ID_tar_addr(INSTR[20:16]),
		.ID_src_addr(INSTR[25:21]),
		.EX_mem_read(EX_MEM_READ)
	);

	Control Controller(
		//outputs
		.ALU_OP(CTRL_ALU_OP),
		.reg_write(CTRL_REG_WRITE),
		.reg_dst(CTRL_REG_DST),
		.ALU_src(CTRL_ALU_SRC),
		.mem_write(CTRL_MEM_WRITE),
		.mem_read(CTRL_MEM_READ),
		.mem2reg(CTRL_MEM2REG),
		.branch(CTRL_BRANCH),
		.jump(CTRL_JUMP),
		//Inputs
		.OP(INSTR[31:26])
	);

	Stall_MUX Stallation_MUX(
		//Outputs
		.src_addr_out(ID_SRC_ADDR),
		.I_dst_addr_out(ID_I_DST_ADDR),
		.ALU_OP_out(ID_ALU_OP),
		.reg_write_out(ID_REG_WRITE),
		.reg_dst_out(ID_REG_DST),
		.ALU_src_out(ID_ALU_SRC),
		.mem_write_out(ID_MEM_WRITE),
		.mem_read_out(ID_MEM_READ),
		.mem2reg_out(ID_MEM2REG),
		.branch_out(ID_BRANCH),
		.jump_out(ID_JUMP),
		//Inputs
		.src_addr_in(INSTR[25:21]),
		.I_dst_addr_in(INSTR[20:16]),
		.ALU_OP_in(CTRL_ALU_OP),
		.reg_write_in(CTRL_REG_WRITE),
		.reg_dst_in(CTRL_REG_DST),
		.ALU_src_in(CTRL_ALU_SRC),
		.mem_write_in(CTRL_MEM_WRITE),
		.mem_read_in(CTRL_MEM_READ),
		.mem2reg_in(CTRL_MEM2REG),
		.branch_in(CTRL_BRANCH),
		.jump_in(CTRL_JUMP),
		//select signal
		.stall(STALL)
	);
	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
		.src_data(ID_SRC_DATA),
		.tar_data(ID_R_TAR_DATA),
		// Inputs
		.src_addr(INSTR[25:21]),
		.tar_addr(INSTR[20:16]),
		.dst_addr(DST_ADDR),
		.dst_data(DST_DATA),
		.reg_write(REG_WRITE),
		.clk(clk)
	);

	Sign_Extend Sign_Extension(
		//Output
		.extend_out(ID_I_TAR_DATA),
		//Input
		.immediate(INSTR[15:0])
	);

	ID_EX ID_EX_Register(
		//Outputs
		.wb_out(EX_REG_WRITE),
		.ALU_src_out(ALU_SRC),
		.mem_read_out(EX_MEM_READ),
		.mem_write_out(EX_MEM_WRITE),
		.reg_dst_out(REG_DST),
		.mem2reg_out(EX_MEM2REG),
		.branch_out(EX_BRANCH),
		.jump_out(EX_JUMP),
		.ALU_OP_out(ALU_OP),
		.src_data_out(SRC_DATA),
		.R_tar_data_out(R_TAR_DATA),
		.I_tar_data_out(I_TAR_DATA),
		.shamt_out(SHAMT),
		.R_dst_addr_out(R_DST_ADDR),
		.I_dst_addr_out(I_DST_ADDR),
		.src_addr_out(EX_SRC_ADDR),
		.funct_ctrl_out(FUNCT_CTRL),
		//Inputs
		.wb_in(ID_REG_WRITE),
		.ALU_src_in(ID_ALU_SRC),
		.mem_read_in(ID_MEM_READ),
		.mem_write_in(ID_MEM_WRITE),
		.reg_dst_in(ID_REG_DST),
		.mem2reg_in(ID_MEM2REG),
		.branch_in(ID_BRANCH),
		.jump_in(ID_JUMP),
		.ALU_OP_in(ID_ALU_OP),
		.src_data_in(ID_SRC_DATA),
		.R_tar_data_in(ID_R_TAR_DATA),
		.I_tar_data_in(ID_I_TAR_DATA),
		.shamt_in(INSTR[10:6]),
		.R_dst_addr_in(INSTR[15:11]),
		.I_dst_addr_in(ID_I_DST_ADDR),
		.src_addr_in(ID_SRC_ADDR),
		.funct_ctrl_in(INSTR[5:0]),
		.clk(clk)
	);

	Forward Forwarding_Unit(
		//Outputs
		.forward_src(FORWARD_SRC),
		.forward_tar(FORWARD_TAR),
		//Inputs
		.MEM_dst_addr(MEM_DST_ADDR),
		.dst_addr(DST_ADDR),
		.EX_src_addr(EX_SRC_ADDR),
		.I_dst_addr(I_DST_ADDR),
		.MEM_reg_write(MEM_REG_WRITE),
		.reg_write(REG_WRITE)
	);

	MUX32_3 Forward_SRC_MUX(
		//output
		.data_out(FORWARD_SRC_DATA),
		//inputs
		.data0(SRC_DATA),
		.data1(DST_DATA),
		.data2(MEM_ALU_OUT),
		.select(FORWARD_SRC)
	);

	MUX32_3 Forward_TAR_MUX(
		//output
		.data_out(FORWARD_TAR_DATA),
		//inputs
		.data0(R_TAR_DATA),
		.data1(DST_DATA),
		.data2(MEM_ALU_OUT),
		.select(FORWARD_TAR)
	);

	ALU_Control ALU_Controller(
		//output
		.funct(FUNCT),
		//inputs
		.funct_ctrl(FUNCT_CTRL),
		.ALU_OP(ALU_OP)
	);

	MUX32 ALU_SRC_MUX(
		//output
		.data_out(TAR_DATA),
		//inputs
		.data0(FORWARD_TAR_DATA),
		.data1(I_TAR_DATA),
		.select(ALU_SRC)
	);

	ALU ALU_Unit(
		//output
		.data_out(ALU_OUT),
		.zero(ZERO_FLAG),
		//inputs
		.src_data(FORWARD_SRC_DATA),
		.tar_data(TAR_DATA),
		.shamt(SHAMT),
		.funct(FUNCT)
	);

	MUX5 Reg_Dst_MUX(
		.data_out(EX_DST_ADDR),
		//inputs
		.data0(I_DST_ADDR),
		.data1(R_DST_ADDR),
		.select(REG_DST)
	);
	
	EX_MEM EX_MEM_Register(
		//outputs
		.wb_out(MEM_REG_WRITE),
		.mem_read_out(MEM_READ),
		.mem_write_out(MEM_WRITE),
		.mem2reg_out(MEM_MEM2REG),
		.branch_out(BRANCH),
		.jump_out(JUMP),
		.mem_write_data_out(MEM_WRITE_DATA),
		.ALU_result_out(MEM_ALU_OUT),
		.dst_addr_out(MEM_DST_ADDR),
		//Inputs
		.wb_in(EX_REG_WRITE),
		.mem_read_in(EX_MEM_READ),
		.mem_write_in(EX_MEM_WRITE),
		.mem2reg_in(EX_MEM2REG),
		.branch_in(EX_BRANCH),
		.jump_in(EX_JUMP),
		.mem_write_data_in(FORWARD_TAR_DATA),
		.ALU_result_in(ALU_OUT),
		.dst_addr_in(EX_DST_ADDR),
		.clk(clk)
	);

	DM Data_Memory(
		//Ouput
		.read_data(MEM_READ_DATA),
		//Inputs
		.write_data(MEM_WRITE_DATA),
		.addr(MEM_ALU_OUT),
		.mem_read(MEM_READ),
		.mem_write(MEM_WRITE),
		.clk(clk)
	);

	MEM_WB MEM_WB_Register(
		//Outputs
		.wb_out(REG_WRITE),
		.mem2reg_out(MEM2REG),
		.mem_read_data_out(WB_MEM_READ_DATA),
		.ALU_result_out(WB_ALU_OUT),
		.dst_addr_out(DST_ADDR),
		//Inputs
		.wb_in(MEM_REG_WRITE),
		.mem2reg_in(MEM_MEM2REG),
		.mem_read_data_in(MEM_READ_DATA),
		.ALU_result_in(MEM_ALU_OUT),
		.dst_addr_in(MEM_DST_ADDR),
		.clk(clk)
	);

	MUX32 Dst_Data_MUX(
		//output
		.data_out(DST_DATA),
		//inputs
		.data0(WB_ALU_OUT),
		.data1(WB_MEM_READ_DATA),
		.select(MEM2REG)
	);

endmodule
