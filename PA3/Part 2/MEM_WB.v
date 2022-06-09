module MEM_WB(
    //outputs
    output wb_out,
    output mem2reg_out,
    output [31:0]mem_read_data_out,
    output [31:0]ALU_result_out,
    output [4:0]dst_addr_out,
    //Inputs
    input wb_in,
    input mem2reg_in,
    input [31:0]mem_read_data_in,
    input [31:0]ALU_result_in,
    input [4:0]dst_addr_in,
    input clk
);
reg wb, mem2reg;
reg [31:0]ALU_result, mem_read_data;
reg [4:0]dst_addr;
always @(negedge clk) begin
    wb <= wb_in;
    mem2reg <= mem2reg_in;
    mem_read_data <= mem_read_data_in;
    ALU_result <= ALU_result_in;
    dst_addr <= dst_addr_in;
end

assign wb_out = wb;
assign mem2reg_out = mem2reg;
assign mem_read_data_out = mem_read_data;
assign ALU_result_out = ALU_result;
assign dst_addr_out = dst_addr;

endmodule
