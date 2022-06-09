module IF_ID(
    //Output
    output reg [31:0]instr_out,
    //Inputs
    input [31:0]instr_in,
    input clk
);

reg [31:0]instr_reg;

always @(negedge clk) begin
    instr_reg <= instr_in;
end

assign instr_out = instr_reg;

endmodule