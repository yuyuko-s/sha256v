module sigma1 (
    input reg [31:0] a,
    output reg [31:0] o
);
    assign o = {a[14:0], a[31:15]} ^ {a[12:0], a[31:13]} ^ (a >> 10);
endmodule