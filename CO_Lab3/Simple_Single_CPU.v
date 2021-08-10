module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [32-1:0] add_pc;
wire [32-1:0] pc_inst;
wire [32-1:0] instr_o;
wire [5-1:0] Write_reg;
wire RegDst;
wire RegWrite;
wire [3-1:0] ALUOp;
wire ALUSrc;
wire [32-1:0] Write_Data;
wire [32-1:0] rs_data;
wire [32-1:0] rt_data;
wire [4-1:0] ALUCtrl;
wire [2-1:0] FURslt;
wire [32-1:0] sign_instr;
wire [32-1:0] zero_instr;
wire [32-1:0] Src_ALU_Shifter;
wire zero;
wire [32-1:0] result_ALU;
wire [32-1:0] result_Shifter;
wire overflow;
wire [5-1:0] ShamtSrc;
//
wire	Branch;
wire	Jump;
wire	MemRead;
wire	MemWrite;
wire	MemtoReg;
wire	[32-1:0] add_add_pc;
wire	[32-1:0] shift_instr_o;
wire	[32-1:0] shift_sign_instr;
wire	[32-1:0] mux_add_add_pc;
wire	[32-1:0] mux_mux_add_add_pc;
wire	BranchType;
wire	mux_zero;
wire	[32-1:0] mux3_result;
wire	[32-1:0] DM_result;
wire 	[5-1:0] Write_reg_j;
wire 	[32-1:0] Write_Data_j;
wire	jr;
wire	[32-1:0] next_pc;
//

//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(next_pc),
	    .pc_out_o(pc_inst) 
	    );
	
Adder Adder1(
        .src1_i(pc_inst),     
	    .src2_i(32'd4),
	    .sum_o(add_pc)    
	    );
	
//new
Adder Adder2(
        .src1_i(add_pc),     
	    .src2_i(shift_sign_instr),
	    .sum_o(add_add_pc)    
	    );

Shifter shifter_left2_1( 
		.result(shift_instr_o), 
		.leftRight(1'b0),
		.shamt(5'b00010),
		.sftSrc(instr_o) 
		);
		
Shifter shifter_left2_2( 
		.result(shift_sign_instr), 
		.leftRight(1'b0),
		.shamt(5'b00010),
		.sftSrc(sign_instr) 
		);
		
Mux2to1 #(.size(32)) branch(
        .data0_i(add_pc),
        .data1_i(add_add_pc),
        .select_i(mux_zero & Branch),
        .data_o(mux_add_add_pc)
        );	
		
Mux2to1 #(.size(32)) JUMP(
        .data0_i(mux_add_add_pc),
        .data1_i({add_pc[31:28],shift_instr_o[27:0]}),
        .select_i(Jump),
        .data_o(mux_mux_add_add_pc)
        );	
		
Mux2to1 #(.size(1)) ZERO(
        .data0_i(zero),
        .data1_i(~zero),
        .select_i(BranchType),
        .data_o(mux_zero)
        );	
//
Instr_Memory IM(
        .pc_addr_i(pc_inst),  
	    .instr_o(instr_o)    
	    );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_o[20:16]),
        .data1_i(instr_o[15:11]),
        .select_i(RegDst),
        .data_o(Write_reg_j)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instr_o[25:21]) ,  
        .RTaddr_i(instr_o[20:16]) ,  
        .RDaddr_i(Write_reg) ,  
        .RDdata_i(Write_Data)  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(rs_data) ,  
        .RTdata_o(rt_data)   
        );
	
Decoder Decoder(
        .instr_op_i(instr_o[32-1:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst), 
		.Branch_o(Branch),
		.Jump_o(Jump),
		.MemRead_o(MemRead),
		.MemWrite_o(MemWrite),
		.MemtoReg_o(MemtoReg),
		.BranchType_o(BranchType)
		);

ALU_Ctrl AC(
        .funct_i(instr_o[6-1:0]),   
        .ALUOp_i(ALUOp),   
        .ALU_operation_o(ALUCtrl),
		.FURslt_o(FURslt),
		.jr_o(jr)
        );
	
Sign_Extend SE(
        .data_i(instr_o[15:0]),
        .data_o(sign_instr)
        );

Zero_Filled ZF(
        .data_i(instr_o[15:0]),
        .data_o(zero_instr)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(rt_data),
        .data1_i(sign_instr),
        .select_i(ALUSrc),
        .data_o(Src_ALU_Shifter)
        );	

Mux2to1 #(.size(5)) Shamt_Src(
        .data0_i(instr_o[10:6]),
        .data1_i(rs_data[5-1:0]),
        .select_i(ALUCtrl[1]),
        .data_o(ShamtSrc)
        );	

ALU ALU(
		.aluSrc1(rs_data),
	    .aluSrc2(Src_ALU_Shifter),
	    .ALU_operation_i(ALUCtrl),
		.result(result_ALU),
		.zero(zero),
		.overflow(overflow)
	    );
		
Shifter shifter( 
		.result(result_Shifter), 
		.leftRight(ALUCtrl[0]),
		.shamt(ShamtSrc),
		.sftSrc(Src_ALU_Shifter) 
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(result_ALU),
        .data1_i(result_Shifter),
		.data2_i(zero_instr),
        .select_i(FURslt),
        .data_o(mux3_result)
        );			

//
Data_Memory DM(
		.clk_i(clk_i),
		.addr_i(mux3_result),
		.data_i(rt_data),
		.MemRead_i(MemRead),
		.MemWrite_i(MemWrite),
		.data_o(DM_result)
		);

Mux2to1 #(.size(32)) Memto(
        .data0_i(mux3_result),
        .data1_i(DM_result),
        .select_i(MemtoReg),
        .data_o(Write_Data_j)
        );	
//

//jal
Mux2to1 #(.size(5)) Mux_Write_Reg_jal(
        .data0_i(Write_reg_j),
        .data1_i(5'b11111),
        .select_i(jump),
        .data_o(Write_reg)
        );	

Mux2to1 #(.size(32)) Memto_jal(
        .data0_i(Write_Data_j),
        .data1_i(add_pc),
        .select_i(jump),
        .data_o(Write_Data)
        );	
//jr
Mux2to1 #(.size(32)) addr_jr(
        .data0_i(mux_mux_add_add_pc),
        .data1_i(rs_data),
        .select_i(jr),
        .data_o(next_pc)
        );	
//
endmodule



