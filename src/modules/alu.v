module alu(input [2:0] op, //operation code
			  input signed [7:0] r1, r2, //operands
			  input [2:0] s, //size of the matrix
			  output reg signed [7:0] outr); //output result
			  
	reg signed [7:0] a, b;
	
	localparam [2:0]
		addM = 3'b000, //(add matrices)
		subM = 3'b001, //(subtract matrices)
		multM = 3'b010, //(multiply matrices)
		multMR = 3'b011, //(multiply by real)
		detM = 3'b100, //(determinant of matrix)
		transM = 3'b101, //(transpose matrix)
		oppM = 3'b110, //(opposite matrix)
		rst = 3'b111; //reset
	
			
	always @(*) begin
		a = r1;
		b = r2;
		
		case (op)
			addM : outr = a + b;
			subM : outr = a - b;
			multM : outr = a * b;
			multMR : outr = a * b;
			detM : outr = 8'b00000001;
			transM : outr = a * b;
			oppM : outr = a * b;
			rst : outr = 1'b1;
			default : outr = -1'b1;
		endcase
	end


endmodule