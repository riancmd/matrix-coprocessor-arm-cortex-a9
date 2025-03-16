module adder (input [7:0] r1, r2, //operands of 8bits
				  input cin, //carryin
				  output reg [7:0] s, //sum result
				  output cout); //carryout
				  
	wire [7:1] ctemp; //temporary carry
	
	//each stage adds an individual bit
	adder stage0 (r1[0], r2[0], cin, s[0], ctemp[1]);
	adder stage1 (r1[1], r2[1], ctemp[1], s[0], ctemp[2]);
	adder stage2 (r1[2], r2[2], ctemp[2], s[0], ctemp[3]);
	adder stage3 (r1[3], r2[3], ctemp[3], s[0], ctemp[4]);
	adder stage4 (r1[4], r2[4], ctemp[4], s[0], ctemp[5]);
	adder stage5 (r1[5], r2[5], ctemp[5], s[0], ctemp[6]);
	adder stage6 (r1[6], r2[6], ctemp[6], s[0], ctemp[7]);
	adder stage7 (r1[7], r2[7], ctemp[7], s[0], cout);


endmodule