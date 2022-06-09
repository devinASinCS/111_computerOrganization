module EX_MEM(
    //outputs
    output wb_out,
    output mem_read_out,
    output mem_write_out,
    output mem2reg_out,
    output branch_out,
    output jump_out,
    output [31:0]mem_write_data_out,
    output [31:0]ALU_result_out,
    output [4:0]dst_addr_out,
    //Inputs
    input wb_in,
    input mem_read_in,
    input mem_write_in,
    input mem2reg_in,
    input branch_in,
    input jump_in,
    input [31:0]mem_write_data_in,
    input [31:0]ALU_result_in,
    input [4:0]dst_addr_in,
    input clk
);
reg wb, mem_read, mem_write, mem2reg, branch, jump;
reg [31:0]ALU_result, mem_write_data;
reg [4:0]dst_addr;

always @(negedge clk) begin
    wb <= wb_in;
    mem_read <= mem_read_in;
    mem_write <= mem_write_in;
    mem2reg <= mem2reg_in;
    branch <= branch_in;
    jump <= jump_in;
    mem_write_data <= mem_write_data_in;
    ALU_result <= ALU_result_in;
    dst_addr <= dst_addr_in;

end
    
assign wb_out = wb;
assign mem_read_out = mem_read;
assign mem_write_out = mem_write;
assign mem2reg_out = mem2reg;
assign branch_out = branch;
assign jump_out = jump;
assign mem_write_data_out = mem_write_data;
assign ALU_result_out = ALU_result;
assign dst_addr_out = dst_addr;
    


endmodule