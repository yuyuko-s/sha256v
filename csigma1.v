module csigma1 (
    input reg [31:0] a,
    output reg [31:0] o
);
    assign o = {a[25:0], a[31:26]} ^ {a[20:0], a[31:21]} ^ {a[6:0], a[31:7]};
endmodule