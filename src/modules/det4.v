module det4(
    input signed [127:0] m, //uma matriz 4x4 com 8 bits cada elemento
    input rst,
    output reg signed [7:0] det,
    output reg ovf
);

    //cofatores
    wire signed [7:0] cof1, cof2, cof3, cof4;

    //determinantes da 3x3 resultante
    wire signed [7:0] det1, det2, det3, det4; //determinante da 3x3 resultante eliminando cada elemento da primeira linha
    wire ovf_det1, ovf_det2, ovf_det3, ovf_det4; //respectivos overflows

    //flags
    reg flagOvf128;

    //regs temporários
    reg [9:0] temp_det; //grande o suficiente para conter uma soma de 4 números de 8 bits

    //circuito de cálculo de determinante temporário (após eliminação de linhas e colunas)
    always @(*) begin
        det3 matriz1(
            .m({m[8:31], m[40:63], m[72:95], m[104:127]}), .rst(rst), .det(det1). ovf(ovf_det1)
        );
        det3 matriz2(
            .m({m[0:7], m[16:39], m[48:71], m[72:103], m[112:127]}), .rst(rst), .det(det2). ovf(ovf_det2)
        );
        det3 matriz3(
            .m({m[0:15], m[24:47], m[56:79], m[88:111], m[120:127]}), .rst(rst), .det(det3). ovf(ovf_det3)
        );
        det3 matriz4(
            .m({m[0:23], m[32:55], m[64:87], m[96:119]}), .rst(rst), .det(det4). ovf(ovf_det4)
        );
    end

    //circuito de cálculo dos cofatores
    always @(*) begin
        if (det2 == -128 || det4 == -128) begin //se o determinante 2 ou 4for -128, ao multiplicar por -1, resultará em overflow
            flagOvf128 = 1;
        end
        //simplificando o cálculo de cofator, cof = det(i,j) * (-1)^(i+j)
        cof1 = det1; //i = 1, j = 1
        cof2 = -det2;//i = 1, j = 2
        cof3 = det3; //i = 1, j = 3
        cof4 = -det4;//i = 1, j = 4
    end

    //cálculo de determinante da matriz 4x4
    always @(*) begin
        if (ovf_det1 == 1 || ovf_det2 == 1 || ovf_det3 == 1 || ovf_det4 == 1 || flagOvf128) begin //verifica situações de overflow
            det = 8'b0;
            ovf = 1;
        end

        else begin //se não houve overflow antes, realiza a soma para o det final e verifica overflow
            temp_det = det1 + det2 + det3 + det4;
            ovf = (temp_det > 127 || temp_det < -128) ? 1 : 0;
            det = temp_det[7:0]; 
        end
    end

endmodule