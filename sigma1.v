module sigma1 (
    input  logic [31:0] a,
    output logic [31:0] o
);
    assign o = {a[16:0], a[31:17]}   // ROTR17
             ^ {a[18:0], a[31:19]}   // ROTR19
             ^ (a >> 10);            // SHR10
endmodule