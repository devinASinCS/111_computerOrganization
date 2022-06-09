module Adder (data1, data2, data_out) ;
    output [31:0]data_out;
    input [31:0]data1, data2;
    
    assign data_out = data1 + data2;
    
endmodule
