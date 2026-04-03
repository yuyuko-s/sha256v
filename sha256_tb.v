`timescale 1ns/1ps

module sha256_tb;

    logic  clk;
    logic  [31:0] msg [0:15];
    logic  [255:0] hash;
    logic  done;

    sha256 dut (
        .clk     (clk),
        .msg     (msg),
        .hash    (hash),
        .done    (done)
    );

    logic [255:0] expected_hash;
    integer i;



    initial begin
        msg[0]  = 32'h61626380;
        msg[1]  = 32'h00000000;
        msg[2]  = 32'h00000000;
        msg[3]  = 32'h00000000;
        msg[4]  = 32'h00000000;
        msg[5]  = 32'h00000000;
        msg[6]  = 32'h00000000;
        msg[7]  = 32'h00000000;
        msg[8]  = 32'h00000000;
        msg[9]  = 32'h00000000;
        msg[10] = 32'h00000000;
        msg[11] = 32'h00000000;
        msg[12] = 32'h00000000;
        msg[13] = 32'h00000000;
        msg[14] = 32'h00000000;
        msg[15] = 32'h00000018;
        
        @(posedge done);
        $display("%32h", hash);

        $finish;
    end
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
endmodule