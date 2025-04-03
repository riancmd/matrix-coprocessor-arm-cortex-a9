module det2 (
    input signed [15:0] l1, l2, //duas linhas de 16bits cada, sendo 2 números
    input rst, //sinal de reset
    output reg signed [7:0] det // Saída 16 bits com sinal
);

    reg signed [15:0] temp_det; // caso de overflow

always @(*) begin
    if (rst) begin
        temp_det = 16'b0;
    end

    else begin
        temp_det = (l1[15:8] * l2[7:0]) - (l2[15:8] * l1[7:0]);
    end

    det = temp_det;
end

endmodule