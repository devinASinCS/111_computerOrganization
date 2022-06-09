`define addu	6'b001001
`define subu	6'b001010

module ALU(Src_1, Src_2, OP_ctrl, ALU_Result, ALU_Carry);
//inputs
input [31:0]Src_1, Src_2;
input [5:0]OP_ctrl;

//outputs
output reg [31:0]ALU_Result;
output reg ALU_Carry;

always@(*)begin
	//check the operation code
	case(OP_ctrl)
		`addu:	//perform add unsigned operation
			{ALU_Carry, ALU_Result} <= Src_1 + Src_2;
		`subu:	//perform sub unsigned opoeration
			{ALU_Carry, ALU_Result} <= Src_1 - Src_2;
		default:
			{ALU_Carry, ALU_Result} <= 0;
	endcase

end
endmodule
