module MUX5(
	//Outputs
	output reg [4:0]data_out,
	//Inputs
	input [4:0]data0,
	input [4:0]data1,
	input select
);
always @(*) begin
	if(select)begin
		data_out <= data1;
	end else begin
		data_out <= data0;
	end
end
	
endmodule
