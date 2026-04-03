`timescale 1ns/1ps

module w_tb;

    logic  clk;
    logic  [31:0] iv [0:15];
    logic  [31:0] w_value;

    w dut (
        .clk     (clk),
        .iv      (iv),
        .w_value (w_value)
    );

    reg [31:0] expected_w [0:63];


    integer i;
    integer pass_count;
    integer fail_count;
    logic done = 0;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        i = 0;
        pass_count = 0;
        fail_count = 0;

        expected_w[0] = 32'h61626380;
        expected_w[1] = 32'h0;
        expected_w[2] = 32'h0;
        expected_w[3] = 32'h0;
        expected_w[4] = 32'h0;
        expected_w[5] = 32'h0;
        expected_w[6] = 32'h0;
        expected_w[7] = 32'h0;
        expected_w[8] = 32'h0;
        expected_w[9] = 32'h0;
        expected_w[10] = 32'h0;
        expected_w[11] = 32'h0;
        expected_w[12] = 32'h0;
        expected_w[13] = 32'h0;
        expected_w[14] = 32'h0;
        expected_w[15] = 32'h18;
        expected_w[16] = 32'h61626380;
        expected_w[17] = 32'hf0000;
        expected_w[18] = 32'h7da86405;
        expected_w[19] = 32'h600003c6;
        expected_w[20] = 32'h3e9d7b78;
        expected_w[21] = 32'h183fc00;
        expected_w[22] = 32'h12dcbfdb;
        expected_w[23] = 32'he2e2c38e;
        expected_w[24] = 32'hc8215c1a;
        expected_w[25] = 32'hb73679a2;
        expected_w[26] = 32'he5bc3909;
        expected_w[27] = 32'h32663c5b;
        expected_w[28] = 32'h9d209d67;
        expected_w[29] = 32'hec8726cb;
        expected_w[30] = 32'h702138a4;
        expected_w[31] = 32'hd3b7973b;
        expected_w[32] = 32'h93f5997f;
        expected_w[33] = 32'h3b68ba73;
        expected_w[34] = 32'haff4ffc1;
        expected_w[35] = 32'hf10a5c62;
        expected_w[36] = 32'ha8b3996;
        expected_w[37] = 32'h72af830a;
        expected_w[38] = 32'h9409e33e;
        expected_w[39] = 32'h24641522;
        expected_w[40] = 32'h9f47bf94;
        expected_w[41] = 32'hf0a64f5a;
        expected_w[42] = 32'h3e246a79;
        expected_w[43] = 32'h27333ba3;
        expected_w[44] = 32'hc4763f2;
        expected_w[45] = 32'h840abf27;
        expected_w[46] = 32'h7a290d5d;
        expected_w[47] = 32'h65c43da;
        expected_w[48] = 32'hfb3e89cb;
        expected_w[49] = 32'hcc7617db;
        expected_w[50] = 32'hb9e66c34;
        expected_w[51] = 32'ha9993667;
        expected_w[52] = 32'h84badedd;
        expected_w[53] = 32'hc21462bc;
        expected_w[54] = 32'h1487472c;
        expected_w[55] = 32'hb20f7a99;
        expected_w[56] = 32'hef57b9cd;
        expected_w[57] = 32'hebe6b238;
        expected_w[58] = 32'h9fe3095e;
        expected_w[59] = 32'h78bc8d4b;
        expected_w[60] = 32'ha43fcf15;
        expected_w[61] = 32'h668b2ff8;
        expected_w[62] = 32'heeaba2cc;
        expected_w[63] = 32'h12b1edeb;

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

        $display("idx | expected | got      | result");
        $display("----|----------|----------|-------");

        @(posedge done);

        $display("\n%0d passed, %0d failed", pass_count, fail_count);
        $finish;
    end
    always @(posedge clk) begin
        #1;
        if (!done) begin
            if (w_value === expected_w[i]) begin
                $display("%3d | %08h | %08h | PASS", i, expected_w[i], w_value);
                pass_count = pass_count + 1;
            end else begin
                $display("%3d | %08h | %08h | FAIL", i, expected_w[i], w_value);
                fail_count = fail_count + 1;
            end
            if (i == 63) begin
                done <= 1;
            end
            i <= i + 1;
        end
    end
endmodule