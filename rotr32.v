module rotr32 (
    input reg [31:0] a,
    input reg [4:0] n,
    output reg [31:0] o
);
    assign o = (a >> n) | (a << (32 - n));
endmodule