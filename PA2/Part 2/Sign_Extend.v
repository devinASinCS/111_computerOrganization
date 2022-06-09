module Sign_Extend(
    //output
    output reg [31:0]extend_out,
    //input
    input [15:0]immediate
);

always @(*) begin
    if(immediate[15] == 0)begin
        extend_out <= {16'd0, immediate};
    end
    else if(immediate[15] == 1)begin
        extend_out <= {16'hFFFF, immediate};
    end
end


endmodule