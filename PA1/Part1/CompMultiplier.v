module CompMultiplier(Product, ready, Multiplicand, Multiplier, run, reset, clk);
//outputs
output [63:0] Product;
output ready;
//inputs
input [31:0] Multiplicand;
input [31:0] Multiplier;
input run, reset, clk;
//wires between modules
wire w_ctrl, SRL_ctrl, ALU_Carry;
wire [31:0]Multiplicand_out, ALU_Result;
wire [5:0]ADDU_ctrl;

//instantiate Multiplicand Module
Multiplicand multiplicandReg(
	.Multiplicand_in(Multiplicand), 
	.rst(reset), 
	.w_ctrl(w_ctrl), 
	.Multiplicand_out(Multiplicand_out)
);
//instantiate Control Module
Control controler(
	.run(run), 
	.rst(reset), 
	.clk(clk), 
	.LSB(Product[0]), 
	.w_ctrl(w_ctrl), 
	.SRL_ctrl(SRL_ctrl), 
	.ready(ready), 
	.ADDU_ctrl(ADDU_ctrl)
);
//instantiate ALU Module
ALU ALUnit(
	.Src_1(Product[63:32]), 
	.Src_2(Multiplicand_out), 
	.ADDU_ctrl(ADDU_ctrl), 
	.ALU_Result(ALU_Result), 
	.ALU_Carry(ALU_Carry)
);
//instantiate Product Module
Product ProductReg(
	.Multiplier_in(Multiplier), 
	.ALU_Carry(ALU_Carry), 
	.ALU_Result(ALU_Result), 
	.SRL_ctrl(SRL_ctrl), 
	.w_ctrl(w_ctrl), 
	.ready(ready), 
	.rst(reset), 
	.clk(clk), 
	.Product_out(Product)
);
endmodule
