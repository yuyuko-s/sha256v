module csigma1 (
    input logic [31:0] a,
    output logic [31:0] o
);
    assign o = {a[25:0], a[31:26]} ^ {a[20:0], a[31:21]} ^ {a[6:0], a[31:7]};
endmodule