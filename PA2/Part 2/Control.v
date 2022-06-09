module Control(
    //outputs
    output reg [1:0]ALU_OP,
    output reg reg_write,
    output reg reg_dst,
    output reg ALU_src,
    output reg mem_write,
    output reg mem_read,
    output reg mem2reg,
    //inputs
    input [5:0]OP
);
    always@(*)begin
        case(OP)
	//if is R type -> set ALU_OP = 10
        6'd0:begin
            ALU_OP <= 2'b10;
            reg_write <= 1;
            reg_dst <= 1;
            ALU_src <= 0;
            mem_write <= 0;
            mem_read <= 0;
            mem2reg <= 0;
        end
        //ADD immediate
        6'b001100:begin
            ALU_OP <= 2'b00;
            reg_write <= 1;
            reg_dst <= 0;
            ALU_src <= 1;
            mem_write <= 0;
            mem_read <= 0;
            mem2reg <= 0;
        end
        //SUB immediate
        6'b001101:begin
            ALU_OP <= 2'b01;
            reg_write <= 1;
            reg_dst <= 0;
            ALU_src <= 1;
            mem_write <= 0;
            mem_read <= 0;
            mem2reg <= 0;
        end
        //store
        6'b010000:begin
            ALU_OP <= 2'b00;
            reg_write <= 0;
            //reg_dst <= 0;	Don't care
            ALU_src <= 1;
            mem_write <= 1;
            mem_read <= 0;
            //mem2reg <= 0;	Don't care
        end
        //load
        6'b010001:begin
            ALU_OP <= 2'b00;
            reg_write <= 1;
            reg_dst <= 0;
            ALU_src <= 1;
            mem_write <= 0;
            mem_read <= 1;
            mem2reg <= 1;
        end
        default:begin
            ALU_OP <= 2'b00;
            reg_write <= 0;
            reg_dst <= 0;
            ALU_src <= 0;
            mem_write <= 0;
            mem_read <= 0;
            mem2reg <= 0;
        end
        endcase
    end

endmodule
