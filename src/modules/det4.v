module det4(
    input signed [127:0] matrix, //uma matriz 4x4 com 8 bits cada elemento
    input rst,
    output reg signed [7:0] det,
    output reg ovf
);

    //cofatores
    reg signed [7:0] cof1, cof2, cof3, cof4;

    //determinantes da 3x3 resultante
    wire signed [7:0] det1, det2, det3, det4; //determinante da 3x3 resultante eliminando cada elemento da primeira linha
    wire ovf_det1, ovf_det2, ovf_det3, ovf_det4; //respectivos overflows

    //temporarios para multiplicação intermediaria
    wire signed [7:0] n1, n2, n3, n4;
    wire ovf1, ovf2, ovf3, ovf4;

    //multiplicação intermediaria
    multiplier m1(
        .a(matrix[127:120]),
        .b(det1),
        .rst(rst),
        .prod(n1),
        .ovf(ovf1)
    );

    multiplier m2(
        .a(matrix[119:112]),
        .b(-det2),
        .rst(rst),
        .prod(n2),
        .ovf(ovf2)
    );

    multiplier m3(
        .a(matrix[111:104]),
        .b(det3),
        .rst(rst),
        .prod(n3),
        .ovf(ovf3)
    );

    multiplier m4(
        .a(matrix[103:96]),
        .b(-det4),
        .rst(rst),
        .prod(n4),
        .ovf(ovf4)
    );

    //flags
    reg flagOvf128;

    //regs temporários
    reg signed [31:0] temp_det; //grande o suficiente

    //circuito de cálculo de determinante temporário (após eliminação de linhas e colunas)
    
	  det3 matriz1(
			.m({matrix[87:64], matrix[55:32], matrix[23:0]}), .rst(rst), .det(det1), .ovf(ovf_det1)
	  );
	  det3 matriz2(
			.m({matrix[95:88], matrix[79:56], matrix[47:24], matrix[15:0]}), .rst(rst), .det(det2), .ovf(ovf_det2)
	  );
	  det3 matriz3(
			.m({matrix[95:80], matrix[71:48], matrix[39:16], matrix[7:0]}), .rst(rst), .det(det3), .ovf(ovf_det3)
	  );
	  det3 matriz4(
			.m({matrix[95:72], matrix[63:40], matrix[31:8]}), .rst(rst), .det(det4), .ovf(ovf_det4)
	  );

    //circuito de cálculo dos cofatores
    /*always @(*) begin
        if () begin //se o determinante 2 ou 4for -128, ao multiplicar por -1, resultará em overflow
            flagOvf128 = 1;
        end
        //simplificando o cálculo de cofator, cof = det(i,j) * (-1)^(i+j)
        cof1 = det1; //i = 1, j = 1
        cof2 = det2 *(-1);//i = 1, j = 2
        cof3 = det3; //i = 1, j = 3
        cof4 = det4 *(-1);//i = 1, j = 4
    end */

    //cálculo de determinante da matriz 4x4
    always @(*) begin
        /*if (ovf_det1 == 1 || ovf_det2 || ovf_det3 || ovf_det4 || flagOvf128) begin //verifica situações de overflow
            det = 8'b0;
            ovf = 1;
        end

        else begin //se não houve overflow antes, realiza a soma para o det final e verifica overflow
            temp_det = matrix[127:120] * cof1 + matrix[119:112] * cof2 + matrix[111:104] * cof3 + matrix[103:96] * det4;
            ovf = (temp_det > 127 || temp_det < -128) ? 1 : 0;
            det = temp_det[7:0];
        end*/

        //temp_det = matrix[127:120] * det1 + matrix[119:112] * (-det2) + matrix[111:104] * det3 + matrix[103:96] * (-det4);
        temp_det = n1 + n2 + n3 + n4;
        det = temp_det[7:0];

        ovf = (ovf_det1 || ovf_det2 || ovf_det3 || ovf_det4 || det2 == -128 || det4 == -128 || temp_det > 127 || temp_det < -128 ||
               ovf1 || ovf2 || ovf3 || ovf4);

    end

endmodule