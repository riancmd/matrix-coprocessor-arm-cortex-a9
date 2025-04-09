module testDet4();
    reg clk;
    reg signed [127:0] matrix; //uma matriz 4x4 com 8 bits cada elemento
    reg rst;
    wire signed [7:0] det;
    wire ovf;

    det4 uut(
        .matrix(matrix),
        .rst(rst),
        .det(det),
        .ovf(ovf)
    );

    // Gera sinal de clock
    initial begin
        $display("Inicia clock");
        clk = 1'b0;
        forever #1 clk = ~clk;
    end
    
    // Gera sinal de reset
    initial begin
        $display("Inicia reset");
        rst = 1'b1;
        #10 rst = 1'b0;
    end
    
    // Testa os estímulos
    initial begin
        $display("Testa valores");
        $monitor("tempo=%3d, rst=%b, matriz=%128b, det=%8b(%3d), ovf=%b", 
                 $time, rst, matrix, det, det, ovf);
            
        #15; // Espera reset terminar

        matrix = 128'b00000010_00000011_00000010_00000001_00000001_00000010_00000010_00000001_00000000_00000100_00000001_00000010_00000011_00000101_00000001_00000001;
        //resultado esperado det == 1

        #20
        matrix = 128'b00000010_00000011_00000100_00000011_00000001_00000110_00000100_00000101_00000011_00000000_00001001_00001000_00000001_00000010_00000001_00000001;
        //esta matriz é 2 3 4 3 1 6 4 5 3 0 9 8 1 2 1 1
        //seu det é 37, não há overflow e HÁ overflow intermediário
    end
endmodule