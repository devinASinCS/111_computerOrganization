module ALU (
    //outputs
    output reg [31:0]data_out,
    //inputs
    input [31:0]src_data,
    input [31:0]tar_data,
    input [4:0]shamt,
    input [5:0]funct
);
    always@(*)begin
        case(funct)
            //ADDU
            6'b001001:  data_out <= src_data + tar_data;
            //SUBU
            6'b001010:  data_out <= src_data - tar_data;
            //OR
            6'b010010:  data_out <= src_data | tar_data;
            //SRL
            6'b100010:  data_out <= src_data >> shamt;
            default:    data_out <= 32'd0;
        endcase
    end

endmodule
