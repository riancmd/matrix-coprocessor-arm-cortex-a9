module interface_in(
	input clk_b, clk, rst, start
);
	
	//Instanciamento da ferramenta
	wire [15:0] lw;
	reg [15:0] lw_reg;
	wire ready;
	reg [7:0] adrss;
	memory memoria(adrss, clk, result, ready, lw);
	
	//Atribui a saida q da ferramenta de memoria para um registrador
	always @(*) begin
		lw_reg = lw;
	end
	
	reg op = 3'b000;
	reg size = 2'b00;
	reg [7:0] operand1, operand2;
	wire result;
	wire fetch_busy;
	
	always @(*) begin
		operand1 = lw_reg[7:0];
		operand2 = lw_reg[15:8];
	end
	
	control_unit coprocessor(clk_b, rst, start, op, size, operand1, operand2, result, ready);
	
	always @(*) begin
		if(start) begin
			adrss <= 8'b0;
		end
		
		if(ready) begin
			adrss <= 8'b1;
		end
	end
	
endmodule