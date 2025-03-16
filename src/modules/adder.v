module adder (input r1, r2, //individual bits
				  input cin, //carryin
				  output s, //sum result
				  output cout); //carryout

	assign s = r1 ^ r2 ^ cin;
	assign cout = (r1 & r2) | (r1 & cin) | (r2 & cin);

endmodule