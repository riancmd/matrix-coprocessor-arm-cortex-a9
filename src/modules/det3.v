module det3(
    input signed [71:0] m, //uma matriz de 3 bytes x 3 bytes
    input rst, //sinal de reset
    output reg signed [7:0] det, // Saída 16 bits com sinal
    output reg ovf
);

    reg signed [31:0] diag_1, diag_2; //regs para as duas diagonais (primária e secundária)
    reg signed [31:0] temp_det; //reg temporário c tamanho suficiente p produto e soma

    always@(*) begin
        if(rst) begin //verifica reset, zerando ovf e det
            det = 8'b0;
            ovf = 0;
        end

        else begin
            //organiza diagonais 1 e 2	
				diag_1 = m[71:64] * m[39:32] * m[7:0] +    // a00 * a11 * a22
							m[63:56] * m[31:24] * m[23:16] +  // a01 * a12 * a20
							m[55:48] * m[47:40] * m[15:8];    // a02 * a10 * a21
							
				diag_2 = m[63:56] * m[47:40] * m[7:0]   +  // a01 * a11 * a22
							m[71:64] * m[31:24] * m[15:8]  +  // a00 * a12 * a21
							m[55:48] * m[39:32] * m[23:16];   // a02 * a10 * a20

            temp_det = diag_1 - diag_2; //subtrai as diagonais encontrando resultante

            det = temp_det[7:0]; //considera apenas os 8 LSBs

            ovf = (temp_det > 127 || temp_det <  -128); //verifica overflow
        end
    end

endmodule