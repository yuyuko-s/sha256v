module sigma0 (
    input logic [31:0] a,
    output logic [31:0] o
);
    assign o = {a[6:0], a[31:7]}   // ROTR7
             ^ {a[17:0], a[31:18]} // ROTR18
             ^ (a >> 3);           // SHR3
            
endmodule
