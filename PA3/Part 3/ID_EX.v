module ID_EX(
    //Outputs
    output wb_out,
    output ALU_src_out,
    output mem_read_out,
    output mem_write_out,
    output reg_dst_out,
    output mem2reg_out,
    output branch_out,
    output jump_out,
    output [1:0]ALU_OP_out,
    output [31:0]src_data_out,
    output [31:0]R_tar_data_out,
    output [31:0]I_tar_data_out,
    output [4:0]shamt_out,
    output [4:0]R_dst_addr_out,
    output [4:0]I_dst_addr_out,
    output [4:0]src_addr_out,
    output [5:0]funct_ctrl_out,
    //Inputs
    input wb_in,
    input ALU_src_in,
    input mem_read_in,
    input mem_write_in,
    input reg_dst_in,
    input mem2reg_in,
    input branch_in,
    input jump_in,
    input [1:0]ALU_OP_in,
    input [31:0]src_data_in,
    input [31:0]R_tar_data_in,
    input [31:0]I_tar_data_in,
    input [4:0]shamt_in,
    input [4:0]R_dst_addr_in,
    input [4:0]I_dst_addr_in,
    input [4:0]src_addr_in,
    input [5:0]funct_ctrl_in,
    input clk
);

reg wb, ALU_src, mem_read, mem_write, reg_dst, mem2reg;
reg branch, jump;
reg [1:0]ALU_OP;
reg [31:0]src_data, R_tar_data, I_tar_data;
reg [4:0]shamt, R_dst_addr, I_dst_addr, src_addr;
reg [5:0]funct_ctrl;

always @(negedge clk) begin
    wb <= wb_in;
    ALU_src <= ALU_src_in;
    mem_read <= mem_read_in;
    mem_write <= mem_write_in;
    mem2reg <= mem2reg_in;
    reg_dst <= reg_dst_in;
    branch <= branch_in;
    jump <= jump_in;
    ALU_OP <= ALU_OP_in;
    src_data <= src_data_in;
    R_tar_data <= R_tar_data_in;
    I_tar_data <= I_tar_data_in;
    src_addr <= src_addr_in;
    shamt <= shamt_in;
    R_dst_addr <= R_dst_addr_in;
    I_dst_addr <= I_dst_addr_in;
    funct_ctrl <= funct_ctrl_in;
end

assign wb_out = wb;
assign ALU_src_out = ALU_src;
assign mem_read_out = mem_read;
assign mem_write_out = mem_write;
assign reg_dst_out = reg_dst;
assign mem2reg_out = mem2reg;
assign branch_out = branch;
assign jump_out = jump;
assign ALU_OP_out = ALU_OP;
assign src_data_out = src_data;
assign R_tar_data_out = R_tar_data;
assign I_tar_data_out = I_tar_data;
assign shamt_out = shamt;
assign R_dst_addr_out = R_dst_addr;
assign I_dst_addr_out = I_dst_addr;
assign src_addr_out = src_addr;
assign funct_ctrl_out = funct_ctrl;

endmodule