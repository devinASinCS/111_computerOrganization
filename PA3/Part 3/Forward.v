module Forward(
    //Outputs
    output reg [1:0]forward_src,
    output reg [1:0]forward_tar,
    //Inputs
    input [4:0]MEM_dst_addr,
    input [4:0]dst_addr,
    input [4:0]EX_src_addr,
    input [4:0]I_dst_addr,
    input MEM_reg_write,
    input reg_write
);
always@(*)begin
    /*
    *   forward_src signal
    */
    //mem hazard -> forward data from the prior alu result
    if(MEM_reg_write && (MEM_dst_addr != 0) && (MEM_dst_addr == EX_src_addr))begin
        forward_src <= 2'b10;
    end
    //EX hazard -> forward data from data memory or earlier alu result
    else if(reg_write && (dst_addr != 0) && (MEM_dst_addr != EX_src_addr) && (dst_addr ==EX_src_addr))begin
        forward_src = 2'b01;
    end
    else forward_src = 0;
    /*
    *   forward_tar signal
    */
    //mem hazard
    if(MEM_reg_write && (MEM_dst_addr != 0) && (MEM_dst_addr == I_dst_addr))begin
        forward_tar <= 2'b10;
    end
    //EX hazard
    else if(reg_write && (dst_addr != 0) && (MEM_dst_addr != I_dst_addr) && (dst_addr ==I_dst_addr))begin
        forward_tar = 2'b01;
    end
    else forward_tar = 0;
end
endmodule