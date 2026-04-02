module w (
    input logic clk,
    input logic [31:0] iv [0:15],
    output logic [31:0] w_value
);
    wire [31:0] w_sigma0, w_sigma1; 

    sigma0 s0 (iv[1], w_sigma0);
    sigma1 s1 (iv[13], w_sigma1);
    always @(posedge clk) begin
	iv[15] <= iv[0] + w_sigma0 + iv[9] + w_sigma1;
        for (integer i = 0; i < 15; i++) begin

	    iv[i] <= iv[i+1];
        end
    end

    assign w_value = iv[0];
endmodule
