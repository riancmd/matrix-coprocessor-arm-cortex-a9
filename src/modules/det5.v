module det5(
	input signed [199:0] matrix, //uma matriz 4x4 com 8 bits cada elemento
    input rst,
    output reg signed [7:0] det,
    output reg ovf
);

    //determinantes da 3x3 resultante
    wire signed [7:0] det1, det2, det3, det4, det5; //determinante da 3x3 resultante eliminando cada elemento da primeira linha
    wire ovf_det1, ovf_det2, ovf_det3, ovf_det4, ovf_det5; //respectivos overflows

    //regs temporários
    reg signed [31:0] temp_det; //grande o suficiente

    //temporarios para multiplicação intermediaria
    wire signed [7:0] n1, n2, n3, n4;
    wire ovf1, ovf2, ovf3, ovf4;

    //multiplicação intermediaria (elemento da matriz x o cofator)
    //o cofator é igual ao det(i,j) * (-1)^(i+j)
    //aqui a linha escolhida é sempre i = 1, portanto, (-1)^(1+j)
    multiplier m1(
        .a(matrix[199:192]),
        .b(det1),
        .rst(rst),
        .prod(n1),
        .ovf(ovf1)
    );
    
    multiplier m2(
        .a(matrix[191:184]),
        .b(-det2),
        .rst(rst),
        .prod(n2),
        .ovf(ovf2)
    );

    multiplier m3(
        .a(matrix[183:176]),
        .b(det3),
        .rst(rst),
        .prod(n3),
        .ovf(ovf3)
    );

    multiplier m4(
        .a(matrix[175:168]),
        .b(-det4),
        .rst(rst),
        .prod(n4),
        .ovf(ovf4)
    );

    multiplier m5(
        .a(matrix[167:160]),
        .b(det5),
        .rst(rst),
        .prod(n4),
        .ovf(ovf5)
    );

    //circuito de cálculo de determinante temporário (após eliminação de linhas e colunas)
    
	  det4 matriz1(
			.matrix({matrix[151:120], matrix[111:80], matrix[71:40], matrix[31:0]}), .rst(rst), .det(det1), .ovf(ovf_det1)
	  );
	  det4 matriz2(
			.matrix({matrix[159:152], matrix[143:112], matrix[103:72], matrix[63:32], matrix[23:0]}), .rst(rst), .det(det2), .ovf(ovf_det2)
	  );
	  det4 matriz3(
			.matrix({matrix[159:144], matrix[135:104], matrix[95:64], matrix[55:24], matrix[15:0]}), .rst(rst), .det(det3), .ovf(ovf_det3)
	  );
	  det4 matriz4(
			.matrix({matrix[159:136], matrix[127:96], matrix[87:56], matrix[47:16], matrix[7:0]}), .rst(rst), .det(det4), .ovf(ovf_det4)
	  );
	  det4 matriz5(
			.matrix({matrix[159:128], matrix[119:88], matrix[79:48], matrix[39:8]}), .rst(rst), .det(det5), .ovf(ovf_det5)
	  );

    //cálculo de determinante da matriz 4x4
    always @(*) begin

        $display("det1; %d", det1);
        $display("det2; %d", det2);
        $display("det3; %d", det3);
        $display("det4; %d", det4);
        $display("det5; %d", det5);
        $display("ovf1; %d", ovf1);
        $display("ovf2; %d", ovf2);
        $display("ovf3; %d", ovf3);
        $display("ovf4; %d", ovf4);
        $display("ovf5; %d", ovf5);
        $display("ovfdet1; %d", ovf_det1);
        $display("ovfdet2; %d", ovf_det2);
        $display("ovfdet3; %d", ovf_det3);
        $display("ovfdet4; %d", ovf_det4);
        $display("ovfdet5; %d", ovf_det5);
        $display("det2 igual -128; %d", (det2 == -128));
        $display("det4 igual -128; %d", (det4 == -128));
        $display("tempdet maior que 127; %d", (temp_det > 127));
        $display("tempdet menor que -128; %d", (temp_det < -128));
        temp_det = det1 + det2 + det3 + det4 + det5;
        det = temp_det[7:0]; 
        ovf = (ovf_det1 || ovf_det2 || ovf_det3 || ovf_det4 || ovf_det5 || det2 == -128 || det4 == -128 || temp_det > 127 || temp_det < -128 ||
               ovf1 || ovf2 || ovf3 || ovf4 || ovf5);
    end

endmodule