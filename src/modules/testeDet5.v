module testDet4();
    reg clk;
    reg signed [199:0] matrix; //uma matriz 4x4 com 8 bits cada elemento
    reg rst;
    wire signed [7:0] det;
    wire ovf;

    det5 uut(
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
/*
        matrix = 200'b00000010_00000011_00000010_00000101_00000110_00000011_00000010_00000010_00000001_00000100_00000011_00000001_00000011_00000010_00000001_00000001_00000001_00000000_00000110_00000101_00000010_00000001_00000010_00000001_00000011;
        //esta matriz é 2 3 2 5 6 3 2 2 1 4 3 1 3 2 1 1 1 0 6 5 2 1 2 1 3
        //seu det é -90, há overflow e nn há overflow intermediário

        #20; //esta da certo */
        matrix = 200'b00000001_00000001_00000001_00000001_00000001_00000001_00000001_00000001_00000000_00000001_00000001_00000010_00000001_00000001_00000001_00000000_00000000_00000001_00000001_00000001_00000001_00000001_00000000_00000001_00000001_;
        //seu det é -1
    end
endmodule