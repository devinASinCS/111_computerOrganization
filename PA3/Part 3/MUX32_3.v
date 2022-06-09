module MUX32_3(
	//Outputs
	output reg [31:0]data_out,
	//Inputs
	input [31:0]data0,
	input [31:0]data1,
    input [31:0]data2,
	input [1:0]select
);
always @(*) begin
	case(select)
		0:  data_out <= data0;
		1:  data_out <= data1;
        2:  data_out <= data2;
        default:
            data_out <= 0;
	endcase
end
	
endmodule
