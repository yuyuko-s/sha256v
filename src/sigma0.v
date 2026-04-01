module sigma0 (
    input reg [31:0] a,
    output reg [31:0] o
);
    assign o = {a[24:0], a[31:25]} ^ {a[13:0], a[31:14]} ^ (a >> 3);
            
endmodule