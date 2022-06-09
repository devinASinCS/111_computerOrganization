module IF_ID(
    //Output
    output [31:0]instr_out,
    //Inputs
    input [31:0]instr_in,
    input IF_ID_write,
    input clk
);

reg [31:0]instr_reg;


always @(negedge clk) begin
    if(IF_ID_write)begin
        instr_reg <= instr_in;
    end
end

assign instr_out = instr_reg;

endmodule