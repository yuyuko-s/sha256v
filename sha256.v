module sha256 (
    input reg [511:0] msg,
    input reg [31:0] size
)
    assign msg = msg | (512'b1 << size); // Append 1 to the msg
    
endmodule