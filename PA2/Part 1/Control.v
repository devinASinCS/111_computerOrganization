module Control(OP, reg_write, ALU_OP);
    //outputs
    output reg [1:0]ALU_OP;
    output reg reg_write;
    //inputs
    input [5:0]OP;

    always@(*)begin
	//if is R type -> set ALU_OP = 10
        if(OP == 6'd0)begin
            ALU_OP <= 2'b10;
            reg_write <= 1;
        end

        else begin
            ALU_OP <= 0;
            reg_write <= 0;
        end
    end

endmodule
