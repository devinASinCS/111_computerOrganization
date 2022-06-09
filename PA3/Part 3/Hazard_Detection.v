module Hazard_Detection (
    //Outputs
    output reg PC_write,
    output reg stall,
    output reg IF_ID_write,
    //Inputs
    input [4:0]EX_tar_addr,
    input [4:0]ID_tar_addr,
    input [4:0]ID_src_addr,
    input EX_mem_read
);
    initial begin
        stall <= 0;
        IF_ID_write <= 1;
        PC_write <= 1;
    end
    always @(*) begin
        if(EX_mem_read && ((ID_src_addr == EX_tar_addr) || (EX_tar_addr == ID_tar_addr)))begin
            stall <= 1;
            IF_ID_write <= 0;
            PC_write <= 0;
        end
        else begin
            stall <= 0;
            IF_ID_write <= 1;
            PC_write <= 1;
        end
    end
endmodule
