`define add	6'b001001

module ALU(Src_1, Src_2, ADDU_ctrl, ALU_Result, ALU_Carry);
//inputs
input [31:0]Src_1,Src_2;
input [5:0]ADDU_ctrl;

//outputs
output reg [31:0]ALU_Result;
output reg ALU_Carry;

always@(Src_1 or Src_2 or ADDU_ctrl)begin
	//Perform ADDU operation
	if(ADDU_ctrl == `add)begin
		{ALU_Carry, ALU_Result} <= Src_1 + Src_2;
	end else begin
		ALU_Result <= 0;
		ALU_Carry <= 0;
	end

end
endmodule
