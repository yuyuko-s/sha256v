module sha256 (
    input logic clk,
    input logic [31:0] msg [0:15],
    output logic [255:0] hash,
    output logic done
  );

  logic [31:0] a,b,c,d,e,f,g,h;
  logic [31:0] t1, t2;
  logic [5:0] i;
  logic [31:0] k_value;
  logic [31:0] w_value;

  k k_block(i, k_value);
  w w_block(
    .clk(clk), 
    .iv(msg), 
    .w_value(w_value));

  logic [31:0] S0, S1;
  csigma0 cs0(a, S0);
  csigma1 cs1(e, S1);

  logic [31:0] ch, maj;

  assign t1 = h + S1 + ch + k_value + w_value;
  assign t2 = S0 + maj;
  assign ch      = (e & f) ^ (~e & g);
  assign maj     = (a & b) ^ (a & c) ^ (b & c);


  initial begin
    a = 32'h6a09e667;
    b = 32'hbb67ae85;
    c = 32'h3c6ef372;
    d = 32'ha54ff53a;
    e = 32'h510e527f;
    f = 32'h9b05688c;
    g = 32'h1f83d9ab;
    h = 32'h5be0cd19;

    done = 0;
    i = 0;
  end

  always @(posedge clk) begin
    #1;
    if (!done) begin
      h <= g;
      g <= f;
      f <= e;
      e <= d + t1;
      d <= c;
      c <= b;
      b <= a;
      a <= t1 + t2;
    end
    if (i == 63) begin
      done <= 1;
    end else begin
      i <= i + 1;
    end
  end

  assign hash = {
    a + 32'h6a09e667,
    b + 32'hbb67ae85,
    c + 32'h3c6ef372,
    d + 32'ha54ff53a,
    e + 32'h510e527f,
    f + 32'h9b05688c,
    g + 32'h1f83d9ab,
    h + 32'h5be0cd19
  };
endmodule
