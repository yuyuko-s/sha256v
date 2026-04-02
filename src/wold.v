module w (
    input logic [5:0] idx,
    input logic [31:0] iv [0:15],
    output logic [31:0] w_value
);
    wire [31:0] w_block [0:63];
    assign w_block[15:0] = iv;

    wire [31:0] w_sigma0, w_sigma1;
    logic i = 16;

    sigma0 s0 (w_block[i-15], w_sigma0);
    sigma1 s1 (w_block[i-2], w_sigma1);
    always @(*) begin
        for (integer i = 16; i < 64; i++) begin
            w_block[i] = w_block[i-16] + w_sigma0 + w_block[i-7] + w_sigma1;
        end
    end

    assign w_value = w_block[idx];
endmodule
