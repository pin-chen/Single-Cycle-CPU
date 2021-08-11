module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o, jr_o );

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;
output		jr_o;
     
//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;
wire		jr_o;

//reg
reg ALU_operation_o_r;
reg FURslt_o_r;

//Main function
assign jr_o = ({ALUOp_i,funct_i} == 9'b010001000) ? 1'b1 : 1'b0;

always@(*)begin
	case(ALUOp_i)
		3'b010:begin
			case(funct_i)
				6'b010011:begin //add
					ALU_operation_o_r 	= 4'b0010; 
					FURslt_o_r 			= 2'b00;
				end
				6'b010001:begin //sub
					ALU_operation_o_r 	= 4'b0110; 
					FURslt_o_r 			= 2'b00;
				end
				6'b010100:begin //and
					ALU_operation_o_r 	= 4'b0000; 
					FURslt_o_r 			= 2'b00;
				end
				6'b010110:begin //or
					ALU_operation_o_r 	= 4'b0001; 
					FURslt_o_r 			= 2'b00;
				end
				6'b010101:begin //nor
					ALU_operation_o_r 	= 4'b1100; 
					FURslt_o_r 			= 2'b00;
				end
				6'b110000:begin //slt
					ALU_operation_o_r 	= 4'b0111; 
					FURslt_o_r 			= 2'b00;
				end
				6'b000000:begin //sll
					ALU_operation_o_r 	= 4'b0000; 
					FURslt_o_r 			= 2'b01;
				end
				6'b000010:begin //srl
					ALU_operation_o_r 	= 4'b0001; 
					FURslt_o_r 			= 2'b01;
				end
				6'b000110:begin //sllv
					ALU_operation_o_r 	= 4'b0010; 
					FURslt_o_r 			= 2'b01;
				end
				6'b000100:begin //srlv
					ALU_operation_o_r 	= 4'b0011; 
					FURslt_o_r 			= 2'b01;
				end
				default:begin //other
					ALU_operation_o_r 	= 4'b0000; 	//x
					FURslt_o_r 			= 2'b00;	//x
				end
			endcase
		end
		3'b100:begin //addi
			ALU_operation_o_r 	= 4'b0010; 
			FURslt_o_r 			= 2'b00;
		end
		3'b101:begin //lui
			ALU_operation_o_r 	= 4'b0000; 
			FURslt_o_r 			= 2'b10;
		end
		3'b000:begin //lw sw
			ALU_operation_o_r 	= 4'b0010; 
			FURslt_o_r 			= 2'b00;
		end
		3'b001:begin //beq
			ALU_operation_o_r 	= 4'b0110; 
			FURslt_o_r 			= 2'b00;
		end
		3'b110:begin //bne
			ALU_operation_o_r 	= 4'b0110; 
			FURslt_o_r 			= 2'b00;
		end
		default:begin //other
			ALU_operation_o_r 	= 4'b0000; 	//x
			FURslt_o_r 			= 2'b00;	//x
		end
	endcase
end

assign ALU_operation_o 	= ALU_operation_o_r;
assign FURslt_o 		= FURslt_o_r;


endmodule     
