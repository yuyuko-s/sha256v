module k (
    input reg [5:0] i,
    output reg [31:0] k
  );
  always @(*)
  begin
    case (i)
      8'd0:
        k = 32'h428a2f98;
      8'd1:
        k = 32'h71374491;
      8'd2:
        k = 32'hb5c0fbcf;
      8'd3:
        k = 32'he9b5dba5;
      8'd4:
        k = 32'h3956c25b;
      8'd5:
        k = 32'h59f111f1;
      8'd6:
        k = 32'h923f82a4;
      8'd7:
        k = 32'hab1c5ed5;
      8'd8:
        k = 32'hd807aa98;
      8'd9:
        k = 32'h12835b01;
      8'd10:
        k = 32'h243185be;
      8'd11:
        k = 32'h550c7dc3;
      8'd12:
        k = 32'h72be5d74;
      8'd13:
        k = 32'h80deb1fe;
      8'd14:
        k = 32'h9bdc06a7;
      8'd15:
        k = 32'hc19bf174;
      8'd16:
        k = 32'he49b69c1;
      8'd17:
        k = 32'hefbe4786;
      8'd18:
        k = 32'h0fc19dc6;
      8'd19:
        k = 32'h240ca1cc;
      8'd20:
        k = 32'h2de92c6f;
      8'd21:
        k = 32'h4a7484aa;
      8'd22:
        k = 32'h5cb0a9dc;
      8'd23:
        k = 32'h76f988da;
      8'd24:
        k = 32'h983e5152;
      8'd25:
        k = 32'ha831c66d;
      8'd26:
        k = 32'hb00327c8;
      8'd27:
        k = 32'hbf597fc7;
      8'd28:
        k = 32'hc6e00bf3;
      8'd29:
        k = 32'hd5a79147;
      8'd30:
        k = 32'h06ca6351;
      8'd31:
        k = 32'h14292967;
      8'd32:
        k = 32'h27b70a85;
      8'd33:
        k = 32'h2e1b2138;
      8'd34:
        k = 32'h4d2c6dfc;
      8'd35:
        k = 32'h53380d13;
      8'd36:
        k = 32'h650a7354;
      8'd37:
        k = 32'h766a0abb;
      8'd38:
        k = 32'h81c2c92e;
      8'd39:
        k = 32'h92722c85;
      8'd40:
        k = 32'ha2bfe8a1;
      8'd41:
        k = 32'ha81a664b;
      8'd42:
        k = 32'hc24b8b70;
      8'd43:
        k = 32'hc76c51a3;
      8'd44:
        k = 32'hd192e819;
      8'd45:
        k = 32'hd6990624;
      8'd46:
        k = 32'hf40e3585;
      8'd47:
        k = 32'h106aa070;
      8'd48:
        k = 32'h19a4c116;
      8'd49:
        k = 32'h1e376c08;
      8'd50:
        k = 32'h2748774c;
      8'd51:
        k = 32'h34b0bcb5;
      8'd52:
        k = 32'h391c0cb3;
      8'd53:
        k = 32'h4ed8aa4a;
      8'd54:
        k = 32'h5b9cca4f;
      8'd55:
        k = 32'h682e6ff3;
      8'd56:
        k = 32'h748f82ee;
      8'd57:
        k = 32'h78a5636f;
      8'd58:
        k = 32'h84c87814;
      8'd59:
        k = 32'h8cc70208;
      8'd60:
        k = 32'h90befffa;
      8'd61:
        k = 32'ha4506ceb;
      8'd62:
        k = 32'hbef9a3f7;
      8'd63:
        k = 32'hc67178f2;
      default:
        k = 32'h00000000;
    endcase
    ;
  end


endmodule
