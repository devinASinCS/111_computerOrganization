module ALU (
    //outputs
    output reg [31:0]dst_data,
    //inputs
    input [31:0]src_data,
    input [31:0]tar_data,
    input [4:0]shamt,
    input [5:0]funct
);
    always@(*)begin
        case(funct)
            //ADDU
            6'b001001:  dst_data <= src_data + tar_data;
            //SUBU
            6'b001010:  dst_data <= src_data - tar_data;
            //OR
            6'b010010:  dst_data <= src_data | tar_data;
            //SRL
            6'b100010:  dst_data <= src_data >> shamt;
            default:    dst_data <= 32'd0;
        endcase
    end
endmodule
