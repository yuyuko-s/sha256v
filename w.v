module w (
    input logic clk,
    input logic [31:0] iv [0:15],
    output logic [31:0] w_value
);
    wire [31:0] w_sigma0, w_sigma1; 
    logic [31:0] w [0:15];
    logic ldiv = 1;

    sigma0 s0 (w[1], w_sigma0);
    sigma1 s1 (w[14], w_sigma1);

    assign w_value = w[0];

    always @(posedge clk) begin
        if (ldiv) begin
            for (integer i = 0; i < 16; i++)
                w[i] <= iv[i];
            
            ldiv <= 0;
        end 
        else begin
            w[15] <= w[0] + w_sigma0 + w[9] + w_sigma1;
            for (integer i = 0; i < 15; i++) begin
                w[i] <= w[i+1];
            end
        end
    end

endmodule
