module Product(Multiplier_in, ALU_Carry, ALU_Result, SRL_ctrl, w_ctrl, ready, rst, clk, Product_out);
//inputs
input [31:0]Multiplier_in, ALU_Result;
input ALU_Carry, SRL_ctrl, w_ctrl, ready, rst, clk;

//output
output reg [63:0]Product_out;

reg [63:0]tempReg;
//the value to check if the multiplier loaded
reg loaded;

always@(negedge clk)begin
	//reset the product register
	if(rst)begin
		Product_out <= 0;
		tempReg <= 0;
		loaded <= 0;
	end else begin
		if(~ready)begin
			if(~loaded)begin	//has not load multiplier yet -> put multiplier to the rightmost
				tempReg[31:0] = Multiplier_in;
				Product_out = tempReg;
			end 
			else begin
				if(SRL_ctrl)begin
					//if LSB = 1 -> w_ctrl = 1 -> add the multiplicand to the leftmost and shift
					if(w_ctrl)begin
						tempReg[63:32] = ALU_Result;
						tempReg = tempReg >> 1;
						tempReg[63] = ALU_Carry;
						Product_out = tempReg;
					end 
					//if LSB != 1 -> w_ctrl = 0 -> shift right directly
					else begin
						tempReg = tempReg >> 1;
						Product_out = tempReg;
					end
				end
			end
			loaded = 1;
		//if the loop is done -> ready = 1 -> output stays the same
		end else Product_out <= Product_out;
	end
end
endmodule
