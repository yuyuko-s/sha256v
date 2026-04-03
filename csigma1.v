module csigma1 (
    input logic [31:0] a,
    output logic [31:0] o
);
    assign o = {a[5:0], a[31:6]} // rotr6
             ^ {a[10:0], a[31:11]} // rotr11
             ^ {a[24:0], a[31:25]};  // rotr25
endmodule