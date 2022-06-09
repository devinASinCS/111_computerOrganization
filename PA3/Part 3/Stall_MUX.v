module Stall_MUX(
    //Outputs
    output reg [4:0]src_addr_out,
    output reg [4:0]I_dst_addr_out,
    output reg [1:0]ALU_OP_out,
    output reg reg_write_out,
    output reg reg_dst_out,
    output reg ALU_src_out,
    output reg mem_write_out,
    output reg mem_read_out,
    output reg mem2reg_out,
    output reg branch_out,
    output reg jump_out,
    //Inputs
    input [4:0]src_addr_in,
    input [4:0]I_dst_addr_in,
    input [1:0]ALU_OP_in,
    input reg_write_in,
    input reg_dst_in,
    input ALU_src_in,
    input mem_write_in,
    input mem_read_in,
    input mem2reg_in,
    input branch_in,
    input jump_in,
    input stall
);

always@(*)begin
    if(stall)begin
        src_addr_out <= 0;
        I_dst_addr_out <= 0;
        ALU_OP_out <= 0;
        reg_write_out <= 0;
        reg_dst_out <= 0;
        ALU_src_out <= 0;
        mem_write_out <= 0;
        mem_read_out <= 0;
        mem2reg_out <= 0;
        branch_out <= 0;
        jump_out <= 0;
    end
    else begin
        src_addr_out <= src_addr_in;
        I_dst_addr_out <= I_dst_addr_in;
        ALU_OP_out <= ALU_OP_in;
        reg_write_out <= reg_write_in;
        reg_dst_out <= reg_dst_in;
        ALU_src_out <= ALU_src_in;
        mem_write_out <= mem_write_in;
        mem_read_out <= mem_read_in;
        mem2reg_out <= mem2reg_in;
        branch_out <= branch_in;
        jump_out <= jump_in;
    end
end


endmodule