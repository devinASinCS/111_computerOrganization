`define add	6'b001001

module Control(run, rst, clk, LSB, w_ctrl, SRL_ctrl, ready, ADDU_ctrl);
//inputs
input run, rst, clk, LSB;

//outputs
output reg w_ctrl, SRL_ctrl, ready;
output reg [5:0]ADDU_ctrl;

integer counter;

always@(posedge clk)begin
	//reset
	if(rst)begin
		w_ctrl <= 0;
		SRL_ctrl <=0;
		ready <= 0;
		ADDU_ctrl <= 0;
		counter <= 0;
	end else begin
		//if the multiplication start -> product start shifting
		if(run)begin
			SRL_ctrl <= 1;
		end else begin
			SRL_ctrl <= 0;
		end

		//if LSB == 1 -> give add instruction, get ALU result
		if(LSB)begin
			w_ctrl <= 1;
			ADDU_ctrl <= `add;
		end 
		//if LSB == 0 -> no instruction, can't get ALU result
		else begin
			w_ctrl <= 0;
			ADDU_ctrl <= 0;
		end

		//check if the loop is over
		if(counter == 33)begin
			ready <= 1;
		end else begin
			ready <= 0;
			counter <= counter + 1;
		end
	end
end
endmodule
