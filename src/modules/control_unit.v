module control_unit(
	input clk, rst, start, //Sinal de clock, reset e inicio de uma nova op. respectivamente
	input [2:0] op_code, //Código da operação
	input [1:0] matrix_size, //Tamanho das matrizes
	input [7:0] operand1, operand2, //Operandos(elementos)
	output reg [7:0] result, //Resultado da operação
	output reg ready //Sinal para receber o resultado final
	//output wire fetch_busy //Sinal para indicar primeiro estágio ocupado 
);
	
	//Registradores intermediários entre os estágio
	reg [2:0] matrix_size_reg; //Reg para tamanho da matriz
	reg [2:0] op_code_reg1, op_code_reg2; //Regs para o código de operação
	reg [7:0] operand1_reg1, operand1_reg2; //Regs para o operando 1
	reg [7:0] operand2_reg1, operand2_reg2; //Regs para o operando 2
	reg [7:0] result_reg; //Reg para o resultado por elemento
    
   // Sinais de validação para indicar quais estágios estão ocupados
	reg valid1, valid2, valid3;
	 
	//Fetch_busy indica para o processador que ainda não podem ser lidos novos dados
	//assign fetch_busy = valid1;
 
	//ALU ULA
	alu (op_code_reg2, operand1_reg2, operand2_reg2, matrix_size_reg, result_reg);
	
	reg rst_reg = rst;
	//Contador do número de elementos das matrizes
	reg [4:0] counter, total_elements;
 
	always @(*) begin
		if(start) begin
			matrix_size_reg <= matrix_size;
	
			case (matrix_size_reg)
				2'b00: assign total_elements = 4; //Total para matriz 2x2
				2'b01: assign total_elements = 9; //Total para matriz 3x3
				2'b10: assign total_elements = 16; //Total para matriz 4x4
				2'b11: assign total_elements = 25; //Total para matriz 5x5
		  endcase
		 end
	end
 
	always @(posedge clk or posedge rst) begin
		//Reset geral dos registradores e do pipeline
		if (rst_reg) begin
			ready <= 0;
			//fetch_busy <= 0;
			op_code_reg1 <= 0;
			op_code_reg2 <= 0;
			operand1_reg1 <= 0;
			operand1_reg2 <= 0;
			operand2_reg1 <= 0;
			operand2_reg2 <= 0;
			result_reg <= 0;
			valid1 <= 0;
			valid2 <= 0;
			valid3 <= 0;
			counter <= 0;
			total_elements <= 0;
			matrix_size_reg <= 0;
		end 
		
		else begin
		
		if(start) begin
			counter <= 0;
		end
		
		// Fase FETCH (Lendo dados)
		if (start || (!valid1 && counter < total_elements)) begin
			 op_code_reg1 <= op_code;
			 operand1_reg1 <= operand1;
			 operand2_reg1 <= operand2;
			 valid1 <= 1; //Estágio 1 ocupado
		end

		// Fase DECODE (Decodificando)
		if (valid1) begin
			 op_code_reg2 <= op_code_reg1;
			 operand1_reg2 <= operand1_reg1;
			 operand2_reg2 <= operand2_reg1;
			 valid2 <= 1; //Estágio 2 ocupado
			 valid1 <= 0; //Libera o estágio 1
		end

		// Fase EXECUTE (Realiza a operação matemática)
		if (valid2) begin
			 valid3 <= 1; // Ativa o terceiro estágio
			 valid2 <= 0; // Libera o segundo estágio
		end

		// Fase WRITE BACK (Escreve o resultado e sinaliza que está pronto)
		if (valid3) begin
			 result[counter] <= result_reg;
			 valid3 <= 0; // Libera o terceiro estágio
			 counter <= counter + 1;
		end 
		if (counter == total_elements) begin
			ready <= 1;
			rst_reg <= 1;
		
		end
  end
end
endmodule
