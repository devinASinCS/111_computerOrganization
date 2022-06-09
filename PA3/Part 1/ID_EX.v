module ID_EX(
    //Outputs
    output wb_out,
    output [1:0]ALU_OP_out,
    output [31:0]src_data_out,
    output [31:0]tar_data_out,
    output [4:0]shamt_out,
    output [4:0]dst_addr_out,
    output [5:0]funct_ctrl_out,
    //Inputs
    input wb_in,
    input [1:0]ALU_OP_in,
    input [31:0]src_data_in,
    input [31:0]tar_data_in,
    input [4:0]shamt_in,
    input [4:0]dst_addr_in,
    input [5:0]funct_ctrl_in,
    input clk
);

reg wb;
reg [1:0]ALU_OP;
reg [31:0]src_data, tar_data;
reg [4:0]shamt, dst_addr;
reg [5:0]funct_ctrl;

always @(negedge clk) begin
    wb <= wb_in;
    ALU_OP <= ALU_OP_in;
    src_data <= src_data_in;
    tar_data <= tar_data_in;
    shamt <= shamt_in;
    dst_addr <= dst_addr_in;
    funct_ctrl <= funct_ctrl_in;
end

assign wb_out = wb;
assign ALU_OP_out = ALU_OP;
assign src_data_out = src_data;
assign tar_data_out = tar_data;
assign shamt_out = shamt;
assign dst_addr_out = dst_addr;
assign funct_ctrl_out = funct_ctrl;

endmodule