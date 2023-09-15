module trafficlightsignal_3(
input logic clk,reset,
input logic x,
output logic [2:0]hwy,[2:0]cntry
);
typedef enum
logic[2:0]{S0=3'd0,S1=3'd1,S2=3'd2,S3=3'd3,S4=3'd4}statetype;
statetype [2:0] state,nextstate;

parameter[2:0]red=3'b001;
parameter [2:0]yellow=3'b010;
parameter [2:0]green=3'b100;

// state register
always_ff @(posedge clk, posedge reset)
if (reset) state <= S0;
else
state <= nextstate;

always_comb
case (state)
S0: if(x)nextstate=S1;
else nextstate=S0;

S1:nextstate = S2;
S2: nextstate = S3;
S3:if(x) nextstate=S3;
else nextstate = S4;
S4:nextstate=S0;
default:nextstate = S0;
endcase

always_comb
case(state)
S0:{hwy,cntry}={green,red};
S1:{hwy,cntry}={yellow,red};
S2:{hwy,cntry}={red,yellow};
S3:{hwy,cntry}={red,green};
S4:{hwy,cntry}={red,yellow};
endcase
endmodule
