module ALU_Control (
    output reg [5:0]funct,
    //inputs
    input [5:0]funct_ctrl,
    input [1:0]ALU_OP
);
    always@(ALU_OP or funct_ctrl)begin
	//R type
        if(ALU_OP == 2'b10)begin
            case(funct_ctrl)
                6'b001011:  funct <= 6'b001001; //ADDU
                6'b001101:  funct <= 6'b001010; //SUBU
                6'b100101:  funct <= 6'b010010; //OR
                6'b000010:  funct <= 6'b100010; //SRL
            endcase
        end 
        //I type that use ALU?for add only
        else if(ALU_OP == 2'b00)begin
            funct <= 6'b001001;
        end
	//I type that use ALU for subtract only
        else if(ALU_OP == 2'b01)begin
            funct <= 6'b001010;
        end

        else begin
            funct <= 0;
        end
    end
endmodule