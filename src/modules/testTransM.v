module testOppM();
    reg clk; //sinal de clock
    reg signed [39:0] col;//coluna da matriz
    reg rst; //sinal de reset
    wire signed [39:0] linha; //linha resultante


trans_M uut(
    .clk (clk),
    .col (col),
    .rst (rst),
    .m_out (linha)
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
        $monitor("tempo=%3d, rst=%b, m_1=%80b, m_out=%32b", 
                 $time, rst, col, linha);
        
        #15
        //Teste com números positivos
        //col = [1, 3, 2, 5, 0]
        col = 40'b00000001_00000011_00000010_00000101_00000000;
        //linha = [1, 3, 2, 5, 0]
        //linha = 00000001_00000011_00000010_00000101_00000000

        #20
        //Teste com números negativos
        //col = [-1, -3, -2, -5, 0]
        col = 40'b11111111_11111101_11111110_11111011_00000000;
        //linha = [-1, -3, -2, -5, 0]
        //linha = 11111111_11111101_11111110_11111011_00000000
    end

endmodule