module CompDivider(Quotient, Remainder, ready, Dividend, Divisor, run, reset, clk);
//outputs
output [31:0]Quotient, Remainder;
output ready;
//inputs
input [31:0]Dividend, Divisor;
input run, reset, clk;
//wires between the modules
wire [63:0]Remainder_out;
wire [31:0]Divisor_out, ALU_Result;
wire [5:0]OP_ctrl;
wire ALU_Carry, w_ctrl, SLL_ctrl, SRL_ctrl;

//instantiate ALU
ALU ALUnit(
	.Src_1(Remainder_out[63:32]), 
	.Src_2(Divisor_out), 
	.OP_ctrl(OP_ctrl), 
	.ALU_Result(ALU_Result), 
	.ALU_Carry(ALU_Carry)
);
//instantiate Divisor register
Divisor DivisorReg(
	.Divisor_in(Divisor), 
	.rst(reset), 
	.w_ctrl(w_ctrl), 
	.Divisor_out(Divisor_out)
);
//instantiate Controller
Control controller(
	.run(run), 
	.rst(reset), 
	.clk(clk), 
	.MSB(Remainder_out[63]), 
	.w_ctrl(w_ctrl), 
	.SLL_ctrl(SLL_ctrl), 
	.SRL_ctrl(SRL_ctrl), 
	.ready(ready), 
	.OP_ctrl(OP_ctrl)
);
//instantiate Remainder register
Remainder RemainderReg(
	.Dividend_in(Dividend), 
	.ALU_Carry(ALU_Carry), 
	.ALU_Result(ALU_Result), 
	.SLL_ctrl(SLL_ctrl), 
	.SRL_ctrl(SRL_ctrl), 
	.w_ctrl(w_ctrl), 
	.ready(ready), 
	.rst(reset), 
	.clk(clk), 
	.Remainder_out(Remainder_out)
);
//assign the value to remainder & Quotient by the value in 64-bit Remainder register
assign Remainder = Remainder_out[63:32];
assign Quotient = Remainder_out[31:0];
endmodule