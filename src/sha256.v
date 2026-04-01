module sha256 (
    input logic clk,
    input logic [511:0] msg,
    input logic [31:0] size,
    output logic [255:0] hash,
    output logic done
  );
  assign done = 0;
  assign msg = msg | (512'b1 << size); // Append 1 to the msg

  logic [31:0] a = 32'h6a09e667;
  logic [31:0] b = 32'hbb67ae85;
  logic [31:0] c = 32'h3c6ef372;
  logic [31:0] d = 32'ha54ff53a;
  logic [31:0] e = 32'h510e527f;
  logic [31:0] f = 32'h9b05688c;
  logic [31:0] g = 32'h1f83d9ab;
  logic [31:0] h = 32'h5be0cd19;


  logic [31:0] t1, t2;
  logic [5:0] i = 0;
  logic [31:0] k_value;

  k k_block(i, k_value);
  w w_block(i, msg, w_value);

  wire [31:0] S0, S1;
  csigma0 cs0(a, S0);
  csigma1 cs1(e, S1);

  wire [31:0] ch    = (e & f) ^ (~e & g);
  wire [31:0] maj   = (a & b) ^ (a & c) ^ (b & c);

  wire [31:0] t1_next = h + S1 + ch + k_value + w_value;
  wire [31:0] t2_next = S0 + maj;

  always @(posedge clk)
  begin
    if (!done)
    begin
      t1 <= t1_next;
      t2 <= t2_next;
      h <= g;
      g <= f;
      f <= e;
      e <= d + t1;
      d <= c;
      c <= b;
      b <= a;
      a <= t1 + t2;
    end
    if (i == 63)
    begin
      done <= 1;
    end
    else
    begin
      i <= i + 1;
    end
  end
endmodule
