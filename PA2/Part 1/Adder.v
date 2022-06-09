module Adder (addr_in, addr_out, clk) ;
    output reg [31:0]addr_out;
    input [31:0]addr_in;
    input clk;
    
    always@(posedge clk)begin
        addr_out <= addr_in + 31'd4;
    end
endmodule
