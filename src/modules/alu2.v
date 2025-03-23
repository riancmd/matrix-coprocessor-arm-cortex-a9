module alu2(input [2:0] op, //operation code
			  input signed [39:0] r1_1, r1_2, r1_3, r1_4, r1_5, //operand 1
			  input signed [39:0] r2_1, r2_2, r2_3, r2_4, r2_5, //operand 2
			  input [2:0] s, //size of the matrix
			  output reg signed [39:0] outr, //output result
			  output reg ovf); //lembrar de talvez mandar flag de overflow p cada bit

	//reg signed [7:0] a [24:0];
	//reg signed [7:0] b [24:0];
	reg signed [44:0] temp_m;
	
	
	
	localparam [2:0]
		addM = 3'b000, //(add matrices)
		subM = 3'b001, //(subtract matrices)
		multM = 3'b010, //(multiply matrices)
		multMR = 3'b011, //(multiply by real)
		detM = 3'b100, //(determinant of matrix)
		transM = 3'b101, //(transpose matrix)
		oppM = 3'b110, //(opposite matrix)
		rst = 3'b111; //reset
		
	
	initial begin
		$display("Foi 1");
	end
		
	always @(*) begin
		//a = r1;
		//b = r2;
		//Atribuição de zero para os MSB após calcular o tamanho da matriz e quais bits não serão utilizados
		//a exemplo a M[3x3] na qual se utiliza 72bits e do 199 ao 72 seriam zeros	
		case (op)
			//soma
			addM : begin
				temp_m[8:0] = r1_1[7:0] + r2_1[7:0];
				temp_m[17:9] = r1_1[15:8] + r2_1[15:8];
				temp_m[26:18] = r1_1[23:16] + r2_1[23:16];
				temp_m[35:27] = r1_1[31:24] + r2_1[31:24];
				temp_m[44:36] = r1_1[39:32] + r2_1[39:32];
				
				ovf = temp_m[8] || temp_m[17] || temp_m[26] || temp_m[35] ||temp_m[44];//Se houve overflow em qualquer um, flag
			end
			//subtração
			subM : begin
				temp_m[8:0] = r1_1[7:0] - r2_1[7:0];
				temp_m[17:9] = r1_1[15:8] - r2_1[15:8];
				temp_m[26:18] = r1_1[23:16] - r2_1[23:16];
				temp_m[35:27] = r1_1[31:24] - r2_1[31:24];
				temp_m[44:36] = r1_1[39:32] - r2_1[39:32];
				
				ovf = temp_m[8] || temp_m[17] || temp_m[26] || temp_m[35] ||temp_m[44];//Se houve overflow em qualquer um, flag
			end
			//multiplicação matricial
			multM : begin
				$display("Foi 2");
			end
			//multiplicação real por matriz
			multMR : begin
				temp_m[8:0] = r1_1[7:0] * r2_1[7:0];
				temp_m[17:9] = r1_1[15:8] * r2_1[15:8];
				temp_m[26:18] = r1_1[23:16] * r2_1[23:16];
				temp_m[35:27] = r1_1[31:24] * r2_1[31:24];
				temp_m[44:36] = r1_1[39:32] * r2_1[39:32];
				
				ovf = temp_m[8] || temp_m[17] || temp_m[26] || temp_m[35] ||temp_m[44];//Se houve overflow em qualquer um, flag
			end
			//detM : outr = 8'b00000001;
			//transM : outr = a * b;
			//oppM : outr = a * b;
			//rst : outr = 1'b1;
			//default : outr = -1'b1;
		endcase
	end


endmodule