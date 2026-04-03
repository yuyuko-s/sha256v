module csigma0 (
    input logic [31:0] a,
    output logic [31:0] o
);

    assign o = {a[1:0], a[31:2]} // rotr2
             ^ {a[12:0], a[31:13]} // rotr13
             ^ {a[21:0], a[31:22]}; // rotr22
endmodule