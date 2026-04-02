module sigma1 (
    input logic [31:0] a,
    output logic [31:0] o
);
    assign o = {a[14:0], a[31:15]} ^ {a[12:0], a[31:13]} ^ (a >> 10);
endmodule
