module alu(input [2:0] op, //operation code
			  input [7:0] r1, r2, //operands
			  input [2:0] s, //size of the matrix
			  output [7:0] reg outr); //output result
			  
	reg [7:0] negr2, r2f;
	
	assign negbb = ~r2;
	assign r2comp = negbb + 1; //handling 2's complement
			
	always@(*)
	begin
		case (op)
			3'b000: //addM (add matrices)
			3'b001: assign outr = adder(r1,r2comp); //subM (subtract matrices)
			3'b010: //multM (multiply matrices)
			3'b011: //multMR (multiply by real)
			3'b100: //detM (determinant of matrix)
			3'b101: //transM (transpose matrix)
			3'b110: //oppM (opposite matrix)
			3'b111: // reset
		endcase
	end

endmodule