module w (
    input reg [5:0] idx,
    input reg [31:0] iv [0:15],
    output reg [31:0] w_value
)

w_sub w1()
w_sub w2()
w_sub w3()

endmodule

module w_sub (
    input reg [3:0] idx,
    input reg [31:0] w_i [0:15],
    output reg [31:0] w_o [0:15], // export for next w block
    output reg [31:0] w // export w value
);

wire [31:0] w_block [0:31] = {w_i, w_o};
wire w_sigma0;
wire w_sigma1;
always @(*)
    begin
        for (integer i=16; i < 64; i++) 
            begin
                sigma0 s0 (w_block[i-15], w_sigma0);
                sigma1 s1 (w_block[i-2], w_sigma1);
                w_block[i] <= w[i-16] + w_sigma0 + w[i-7] + w_sigma1;
            end
        w <= w_o[idx];
    end
endmodule