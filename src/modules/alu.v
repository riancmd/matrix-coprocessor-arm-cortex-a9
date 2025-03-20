module alu(input [2:0] op, //operation code
			  input signed [7:0] r1, r2, //operands
			  input [2:0] s, //size of the matrix
			  output signed [7:0] reg outr); //output result
			  
	reg signed [7:0] a, b;
	//reg [7:0] negr2, r2f;
	
	assign a = r1;
	assign b = r2;
	
	localparam [2:0]
		3'b000: addM //(add matrices)
		3'b001: subM //(subtract matrices)
		3'b010: multM //(multiply matrices)
		3'b011: multMR //(multiply by real)
		3'b100: detM //(determinant of matrix)
		3'b101: transM //(transpose matrix)
		3'b110: oppM //(opposite matrix)
		3'b111: rst
	
	//assign negbb = ~r2;
	//assign r2comp = negbb + 1; //handling 2's complement
			
	assign outr = (op == addM) ? a + b :
					  (op == subM) ? a - b:
					  (op == multM) ? a * b:
					  (op == multMR) ? a * b:
					  (op == detM) ? 8'b00000001:
					  (op == transM) ? a * b:
					  (op == oppM) ? a * b:
					  (op == rst) ? 1'b1: -1'b1;

endmodule