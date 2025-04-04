module testDet2();
    reg rst;
    reg clk;
    reg signed [15:0] l1, l2;
    wire signed [7:0] det;

    det2 uut(
        .l1 (l1),
        .l2 (l2),
        .rst (rst), 
        .det (det)
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
        $monitor("tempo=%3d, rst=%b, l1=%16b, l2=%16b, det=%8b", 
            $time, rst, l1, l2, det);

    #15

    // Testa uma matriz com números positivos
        l1 = 16'b00000010_00000011;
        l2 = 16'b00000100_00000010;
    // Testa uma matriz com números mistos
    //det = 11111000

    // Testa uma matriz com diagonal nula
    end

endmodule