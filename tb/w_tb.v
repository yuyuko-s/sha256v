`timescale 1ns/1ps

module w_tb;

    // -------------------------
    // DUT signals
    // -------------------------
    reg  [5:0]  idx;
    reg  [31:0] iv [0:15];
    wire [31:0] w_value;

    // -------------------------
    // Instantiate DUT
    // -------------------------
    w dut (
        .idx     (idx),
        .iv      (iv),
        .w_value (w_value)
    );

    // -------------------------
    // Expected values
    // -------------------------
    reg [31:0] expected_w [0:63];

    // -------------------------
    // Helper functions
    // -------------------------
    function [31:0] rotr;
        input [31:0] x;
        input [4:0]  n;
        rotr = (x >> n) | (x << (32 - n));
    endfunction

    function [31:0] sigma0;
        input [31:0] x;
        sigma0 = rotr(x, 7) ^ rotr(x, 18) ^ (x >> 3);
    endfunction

    function [31:0] sigma1;
        input [31:0] x;
        sigma1 = rotr(x, 17) ^ rotr(x, 19) ^ (x >> 10);
    endfunction

    // -------------------------
    // Test logic
    // -------------------------
    integer i;
    integer pass_count;
    integer fail_count;

    initial begin
        pass_count = 0;
        fail_count = 0;

        // SHA-256("abc") padded block
        iv[0]  = 32'h61626380;
        iv[1]  = 32'h00000000;
        iv[2]  = 32'h00000000;
        iv[3]  = 32'h00000000;
        iv[4]  = 32'h00000000;
        iv[5]  = 32'h00000000;
        iv[6]  = 32'h00000000;
        iv[7]  = 32'h00000000;
        iv[8]  = 32'h00000000;
        iv[9]  = 32'h00000000;
        iv[10] = 32'h00000000;
        iv[11] = 32'h00000000;
        iv[12] = 32'h00000000;
        iv[13] = 32'h00000000;
        iv[14] = 32'h00000000;
        iv[15] = 32'h00000018;

        // Compute all 64 expected w values
        for (i = 0;  i < 16; i = i + 1)
            expected_w[i] = iv[i];
        for (i = 16; i < 64; i = i + 1)
            expected_w[i] = expected_w[i-16]
                          + sigma0(expected_w[i-15])
                          + expected_w[i-7]
                          + sigma1(expected_w[i-2]);

        #10;

        // Test all 64 indices
        $display("idx | expected | got      | result");
        $display("----|----------|----------|-------");
        for (i = 0; i < 64; i = i + 1) begin
            idx = i;
            #10;
            if (w_value === expected_w[i]) begin
                $display("%3d | %08h | %08h | PASS", i, expected_w[i], w_value);
                pass_count = pass_count + 1;
            end else begin
                $display("%3d | %08h | %08h | FAIL", i, expected_w[i], w_value);
                fail_count = fail_count + 1;
            end
        end

        $display("\n%0d passed, %0d failed", pass_count, fail_count);
        $finish;
    end

endmodule