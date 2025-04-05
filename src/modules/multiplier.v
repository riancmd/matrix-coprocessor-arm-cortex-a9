module multiplier(
    input signed [7:0] a, b, //fatores da multiplicação, 8 bits cada
    input rst, //sinal de reset
    output reg signed [7:0] prod, //produto da multiplicação
    output reg ovf
)

    reg [15:0] temp_prod; //registrador que guarda o produto no caso de overflow

    always @(*) begin
        //caso de reset
        if (rst) begin
            temp_prod = 16'b0;
            ovf = 0;
        end

        //se reset estiver off, multiplica
        else begin

        end

        prod = temp_prod[7:0];
        ovf = (prod > 127 || prod < -128);

    end

endmodule