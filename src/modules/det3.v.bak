module det3(
    input signed [71:0] m, //uma matriz de 3 bytes x 3 bytes
    input rst, //sinal de reset
    output reg signed [7:0] det, // Saída 16 bits com sinal
    output reg ovf
);

    reg [31:0] diag_1, diag_2; //regs para as duas diagonais (primária e secundária)
    reg [31:0] temp_det; //reg temporário c tamanho suficiente p produto e soma

    always@(*) begin
        if(rst) begin //verifica reset, zerando ovf e det
            det = 8'b0;
            ovf = 0;
        end

        else begin
            //organiza diagonais 1 e 2
            diag_1 = m[0:7] * m[31:39] * m[64:71] + 
                    m[8:15] * m[40:47] * m[48:55] +
                    m[16:23] * m[24:31] * m[56:63];
            diag_2 = m[8:15] * m[24:31] * m[64:71] +
                    m[0:7] * m[40:47] * m[56:63] +
                    m[16:23] * m[32:39] + m[48:55];

            temp_det = diag_1 - diag_2; //subtrai as diagonais encontrando resultante

            det = temp_det[7:0]; //considera apenas os 8 LSBs

            if(det > 8'b127 || det < (-8'b128)) begin //verifica overflow
                ovf = 1;
            end
        end
    end

endmodule