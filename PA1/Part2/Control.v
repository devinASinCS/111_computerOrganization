`define add	6'b001001
`define sub	6'b001010
module Control(run, rst, clk, MSB, w_ctrl, SLL_ctrl, SRL_ctrl, ready, OP_ctrl);
//inputs
input run, rst, clk, MSB;
//outputs
output reg w_ctrl, SLL_ctrl, SRL_ctrl, ready;
output reg [5:0]OP_ctrl;

integer counter;

always@(posedge clk)begin
	//reset
	if(rst)begin
		w_ctrl <= 0;
		SLL_ctrl <= 0;
		SRL_ctrl <=0;
		ready <= 0;
		OP_ctrl <= 0;
		counter <= 0;		
	end 
	else if(run) begin
		if(counter < 64)begin
			counter <= counter + 1;
			//step1: Remainder minus divisor
			if(counter % 2 == 0)begin
				w_ctrl <= 1;
				OP_ctrl <= `sub;
				SLL_ctrl <= 0;
			end
			//step2: check the value of remainder
			else if(counter % 2 == 1)begin
				SLL_ctrl <= 1;
				//if is negative -> MSB = 1 -> add divisor back and shift
				if(MSB)begin
					w_ctrl <= 1;
					OP_ctrl <= `add;
				end 
				//if positive -> keep it and shift 
				else begin
					w_ctrl <= 0;
					OP_ctrl <= 0;
				end
			end
		//the last step: shift the remainder right
		end else if(counter == 64)begin
			SRL_ctrl <= 1;
			SLL_ctrl <= 0;
			counter <= counter +1;
		end else ready <= 1;
	end 
end
endmodule
