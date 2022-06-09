module EX_MEM(
    //outputs
    output reg wb_out,
    output reg mem_read_out,
    output reg mem_write_out,
    output reg mem2reg_out,
    output reg [31:0]mem_write_data_out,
    output reg [31:0]ALU_result_out,
    output reg [4:0]dst_addr_out,
    //Inputs
    input wb_in,
    input mem_read_in,
    input mem_write_in,
    input mem2reg_in,
    input [31:0]mem_write_data_in,
    input [31:0]ALU_result_in,
    input [4:0]dst_addr_in,
    input clk
);
reg wb, mem_read, mem_write, mem2reg;
reg [31:0]ALU_result, mem_write_data;
reg [4:0]dst_addr;
initial begin
    mem_write_data <= 0;
end
always @(posedge clk) begin
    wb <= wb_in;
    mem_read <= mem_read_in;
    mem_write <= mem_write_in;
    mem2reg <= mem2reg_in;
    mem_write_data <= mem_write_data_in;
    ALU_result <= ALU_result_in;
    dst_addr <= dst_addr_in;

    @(negedge clk) begin
        wb_out <= wb;
        mem_read_out <= mem_read;
        mem_write_out <= mem_write;
        mem2reg_out <= mem2reg;
        mem_write_data_out <= mem_write_data;
        ALU_result_out <= ALU_result;
        dst_addr_out <= dst_addr;
    end
end


endmodule