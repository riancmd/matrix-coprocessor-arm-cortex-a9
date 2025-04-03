module testOppM();

input clk, //sinal de clock
    reg signed [39:0] m_1,//linha da matriz
    reg rst, //sinal de reset
    reg signed [39:0] m_out //matriz oposta


opp_M uut(
    .m_1 (m_1),
    .rst (rst),
    .m_out (m_out)
)

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
                 $time, rst, m_1, m_out);
        
        #15
        //Teste com números positivos


        #20
        //Teste com números negativos

    end

endmodule