module Remainder(Dividend_in, ALU_Carry, ALU_Result, SLL_ctrl, SRL_ctrl, w_ctrl, ready, rst, clk, Remainder_out);
//inputs
input [31:0]Dividend_in, ALU_Result;
input ALU_Carry, SLL_ctrl, SRL_ctrl, w_ctrl, ready, rst, clk;
//output
output reg [63:0]Remainder_out;
reg [63:0]tempReg;
//the value to check if the devidend loaded
reg loaded;

always@(negedge clk)begin
	//reset the product register
	if(rst)begin
		Remainder_out <= 0;
		tempReg <= 0;
		loaded <= 0;
	end else begin
		if(~ready)begin
			if(~loaded)begin	
				//has not load multiplier yet -> put dividend to the rightmost and shift left 1
				tempReg[32:1] = Dividend_in;
				Remainder_out = tempReg;
			end 
			else begin
				//step2 of the controller
				if(SLL_ctrl)begin
					//if MSB = 1 -> w_ctrl = 1 -> add the divisor back to the leftmost and shift
					if(w_ctrl)begin
						tempReg[63:32] = ALU_Result;
						tempReg = tempReg << 1;
						tempReg[0] = 1'b0;	//fill right most bit with 0
						Remainder_out = tempReg;
					end
					//if MSB != 1 -> w_ctrl = 0 -> move and shift
					else begin
						tempReg = tempReg << 1;
						tempReg[0] = 1'b1;	//fill right most bit with 1
						Remainder_out = tempReg;
					end
				end
				//step1 of the controller
				//no shift left
				else begin
					if(SRL_ctrl)begin
						Remainder_out[62:32] = tempReg[63:33];
						Remainder_out[63] = 1'b0;	
					end 
					else if(w_ctrl)begin
						tempReg[63:32] = ALU_Result; 
						Remainder_out = tempReg;
					end
				end
			end
			loaded = 1;
		//if the loop is done -> ready = 1 -> output stays the same
		end else Remainder_out <= Remainder_out;
	end
end
endmodule
