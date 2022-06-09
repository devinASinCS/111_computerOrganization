module MEM_WB(
    //outputs
    output wb_out,
    output [31:0]ALU_result_out,
    output [4:0]dst_addr_out,
    //Inputs
    input wb_in,
    input [31:0]ALU_result_in,
    input [4:0]dst_addr_in,
    input clk
);
reg wb;
reg [31:0]ALU_result;
reg [4:0]dst_addr;
always @(negedge clk) begin
    wb <= wb_in;
    ALU_result <= ALU_result_in;
    dst_addr <= dst_addr_in;
end

assign wb_out = wb;
assign ALU_result_out = ALU_result;
assign dst_addr_out = dst_addr;

endmodule
