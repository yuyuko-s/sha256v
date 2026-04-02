module w (
    input logic clk,
    input logic [31:0] iv [0:15],
    output logic [31:0] w_value
);
    logic [31:0] w_block [0:15];
    w_block = iv;

    wire [31:0] w_sigma0, w_sigma1; 

    sigma0 s0 (w_block[1], w_sigma0);
    sigma1 s1 (w_block[13], w_sigma1);
    always @(posedge clk) begin
	w_block[15] <= w_block[0] + w_sigma0 + w_block[9] + w_sigma1;
        for (integer i = 0; i < 15; i++) begin

	    w_block[i] <= w_block[i+1];
        end
    end

    assign w_value = w_block[0];
endmodule
