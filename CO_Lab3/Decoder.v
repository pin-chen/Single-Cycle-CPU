module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Branch_o, Jump_o, MemRead_o, MemWrite_o, MemtoReg_o, BranchType_o );
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;

//I/O ports new
output	wire	Branch_o;
output	wire	Jump_o;
output	wire	MemRead_o;
output	wire	MemWrite_o;
output	wire	MemtoReg_o;
output 	wire	[2-1:0] BranchType_o;
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;

//reg
reg	[3-1:0] ALUOp_o_r;
reg			ALUSrc_o_r;
reg			RegWrite_o_r;
reg			RegDst_o_r;
reg	[2-1:0] BranchType_o_r;
reg			Branch_o_r;
reg			Jump_o_r;
reg			MemRead_o_r;
reg			MemWrite_o_r;
reg			MemtoReg_o_r;

//Main function
always@(*)
	case (instr_op_i)
		6'b000000 : begin
			RegDst_o_r		= 1'b1;
			ALUOp_o_r 		= 3'b010;
			ALUSrc_o_r		= 1'b0;
			Branch_o_r		= 1'b0;
			MemRead_o_r		= 1'b0;
			MemWrite_o_r 	= 1'b0;
			RegWrite_o_r 	= 1'b1;
			MemtoReg_o_r 	= 1'b0;
			Jump_o_r		= 1'b0;
			BranchType_o_r 	= 2'b00;	//x
		end
		6'b001000 : begin
			RegDst_o_r 		= 1'b0;
			ALUOp_o_r 	 	= 3'b011;
			ALUSrc_o_r 		= 1'b1;
			Branch_o_r 		= 1'b0;
			MemRead_o_r 	= 1'b0;
			MemWrite_o_r 	= 1'b0;
			RegWrite_o_r 	= 1'b1;
			MemtoReg_o_r 	= 1'b0;
			Jump_o_r 	 	= 1'b0;
			BranchType_o_r 	= 2'b00;		//x
		end
		6'b101100 : begin
			RegDst_o_r 		= 1'b0;
			ALUOp_o_r 	 	= 3'b000;
			ALUSrc_o_r 		= 1'b1;
			Branch_o_r 		= 1'b0;
			MemRead_o_r 	= 1'b1;
			MemWrite_o_r 	= 1'b0;
			RegWrite_o_r 	= 1'b1;
			MemtoReg_o_r 	= 1'b1;
			Jump_o_r 	 	= 1'b0;
			BranchType_o_r 	= 2'b00;		//x
		end
		6'b101101 : begin
			RegDst_o_r 		= 1'b1;		//x
			ALUOp_o_r 	 	= 3'b000;
			ALUSrc_o_r 		= 1'b1;
			Branch_o_r 		= 1'b0;
			MemRead_o_r 	= 1'b0;
			MemWrite_o_r 	= 1'b1;
			RegWrite_o_r 	= 1'b0;
			MemtoReg_o_r 	= 1'b0;		//x
			Jump_o_r 		= 1'b0;
			BranchType_o_r 	= 2'b00;		//x
		end
		6'b001010 : begin
			RegDst_o_r 		= 1'b1;		//x
			ALUOp_o_r 		= 3'b001;
			ALUSrc_o_r 		= 1'b0;
			Branch_o_r 		= 1'b1;
			MemRead_o_r 	= 1'b0;
			MemWrite_o_r 	= 1'b0;
			RegWrite_o_r 	= 1'b0;
			MemtoReg_o_r 	= 1'b0;		//x
			Jump_o_r 	 	= 1'b0;
			BranchType_o_r 	= 2'b00;
		end
		6'b001011 : begin
			RegDst_o_r 		= 1'b1;		//x
			ALUOp_o_r 	 	= 3'b110;
			ALUSrc_o_r 		= 1'b0;
			Branch_o_r 		= 1'b1;
			MemRead_o_r 	= 1'b0;
			MemWrite_o_r 	= 1'b0;
			RegWrite_o_r 	= 1'b0;
			MemtoReg_o_r 	= 1'b0;		//x
			Jump_o_r 	 	= 1'b0;
			BranchType_o_r 	= 2'b01;
		end
		6'b000010 : begin
			RegDst_o_r 		= 1'b1;		//x
			ALUOp_o_r 	 	= 3'b110;	//x
			ALUSrc_o_r 		= 1'b0;		//x
			Branch_o_r 		= 1'b0;		//x
			MemRead_o_r 	= 1'b0;		//x
			MemWrite_o_r 	= 1'b0;		//x
			RegWrite_o_r 	= 1'b0;		
			MemtoReg_o_r 	= 1'b0;		//x
			Jump_o_r 	 	= 1'b1;
			BranchType_o_r 	= 2'b00;		//x
		end
		6'b000011 : begin
			RegDst_o_r 		= 1'b0;		//x
			ALUOp_o_r 	 	= 3'b110;	//x
			ALUSrc_o_r 		= 1'b0;		//x
			Branch_o_r 		= 1'b1;		//x
			MemRead_o_r 	= 1'b0;		//x
			MemWrite_o_r 	= 1'b0;		//x
			RegWrite_o_r 	= 1'b1;		
			MemtoReg_o_r 	= 1'b1;		//x
			Jump_o_r 	 	= 1'b1;
			BranchType_o_r 	= 2'b00;		//x
		end
		6'b001110 : begin
			RegDst_o_r 		= 1'b1;		//x
			ALUOp_o_r 		= 3'b001;
			ALUSrc_o_r 		= 1'b0;
			Branch_o_r 		= 1'b1;
			MemRead_o_r 	= 1'b0;
			MemWrite_o_r 	= 1'b0;
			RegWrite_o_r 	= 1'b0;
			MemtoReg_o_r 	= 1'b0;		//x
			Jump_o_r 	 	= 1'b0;
			BranchType_o_r 	= 2'b10;
		end
		6'b001100 : begin
			RegDst_o_r 		= 1'b1;		//x
			ALUOp_o_r 		= 3'b001;
			ALUSrc_o_r 		= 1'b0;
			Branch_o_r 		= 1'b1;
			MemRead_o_r 	= 1'b0;
			MemWrite_o_r 	= 1'b0;
			RegWrite_o_r 	= 1'b0;
			MemtoReg_o_r 	= 1'b0;		//x
			Jump_o_r 	 	= 1'b0;
			BranchType_o_r 	= 2'b01;
		end
		6'b001101 : begin
			RegDst_o_r 		= 1'b1;		//x
			ALUOp_o_r 		= 3'b001;
			ALUSrc_o_r 		= 1'b0;
			Branch_o_r 		= 1'b1;
			MemRead_o_r 	= 1'b0;
			MemWrite_o_r 	= 1'b0;
			RegWrite_o_r 	= 1'b0;
			MemtoReg_o_r 	= 1'b0;		//x
			Jump_o_r 	 	= 1'b0;
			BranchType_o_r 	= 2'b11;
		end
	endcase

	assign RegDst_o 	= RegDst_o_r;
	assign ALUOp_o 		= ALUOp_o_r;
	assign ALUSrc_o 	= ALUSrc_o_r;
	assign Branch_o 	= Branch_o_r;
	assign MemRead_o 	= MemRead_o_r;
	assign MemWrite_o 	= MemWrite_o_r;
	assign MemtoReg_o 	= MemtoReg_o_r;
	assign BranchType_o = BranchType_o_r;
	assign Jump_o 		= Jump_o_r;
	assign RegWrite_o 	= RegWrite_o_r;
	 	

endmodule
   