module Determinante2x2 (
    input signed [15:0] l1, l2, //duas linhas de 16bits cada, sendo 2 números
    input rst, //sinal de reset
    output reg signed [15:0] det // Saída 16 bits com sinal
);

always @(*) begin
    det = (l1[15:8] * l2[7:0]) - (l2[15:8] * l1[7:0]); //
end

endmodule