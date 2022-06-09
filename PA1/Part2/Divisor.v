module Divisor(Divisor_in, rst, w_ctrl, Divisor_out);
input rst, w_ctrl;
input [31:0]Divisor_in;
output reg [31:0]Divisor_out;

always@(*)begin				//any change of input will action
	if(rst)begin			//reset the output to zero
		Divisor_out <= 0;
	end else if(w_ctrl)begin	//if write control on -> output = input
		Divisor_out <= Divisor_in;
	end
end

endmodule

