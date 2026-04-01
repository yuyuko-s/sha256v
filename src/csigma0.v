module csigma0 (
    input reg [31:0] a,
    output reg [31:0] o
);
    assign o = {a[29:0], a[31:30]} ^ {a[18:0], a[31:19]} ^ {a[9:0], a[31:10]};
endmodule