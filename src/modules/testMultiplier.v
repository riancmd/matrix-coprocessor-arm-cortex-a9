`timescale 1ns / 1ps

module testMultiplier();
    reg clk;
    reg rst;
    reg signed [7:0] a, b;  // 80 bits = 10 números de 8 bits
    wire signed [7:0] prod;    // 32 bits = 4 números de 8 bits
    wire ovf;
    
    // Instância do módulo de multiplicação

    multiplier uut(
        .a(a),
        .b(b),
        .rst(rst),
        .prod(prod),
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
        $monitor("tempo=%3d, rst=%b, a=%80b, b=%80b, prod=%32b, ovf=%b", 
                 $time, rst, a, b, prod, ovf);
            
        #15; // Espera reset terminar
            
        // CASO 1: Valores pequenos positivos (sem overflow)
        a = 8'b11110001; //-15
        b = 8'b00000010; //2
        // prod esperado: -30
        // Resultado esperado: 11100010

        #20
        a = 8'b10000000; //(-128)
        b = 8'b11111111; //(-1)
        //vai dar overflow pois o prod esperado seria 128, que excede

        #20
        a = 8'b00000100; //4
        b = 8'b00000100; ///4
        //não dá overflow, prod esperado: 00010000 (16)

    end
endmodule