module Multiplicand(Multiplicand_in, rst, w_ctrl, Multiplicand_out);
input rst, w_ctrl;
input [31:0]Multiplicand_in;
output reg [31:0]Multiplicand_out;

always@(*)begin				//any change of input will action
	if(rst)begin			//reset the output to zero
		Multiplicand_out <= 0;
	end else if(w_ctrl)begin	//if write control on -> output = input
		Multiplicand_out <= Multiplicand_in;
	end
end

endmodule
