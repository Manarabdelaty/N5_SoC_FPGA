module btn_sync(in, clk, out);

input wire in;
input wire clk;

output wire out;

wire en;
wire Q0, Q1, Q2;
wire Q2n; 

clk_div_enable clk_div_en (.clk(clk), .en(en));

dff dff_0(.clk(clk), .en(en), .in(in), .out(Q0));
dff dff_1(.clk(clk), .en(en), .in(Q0), .out(Q1));
dff dff_3(.clk(clk), .en(en), .in(Q1), .out(Q2));

assign out = Q1 & Q2;

endmodule

// Slow clock enable for debouncing button 
module clk_div_enable(clk, en);

input wire clk;
output wire en;

    reg [26:0] counter=0;

    always @(posedge clk)
       counter <= (counter >= 249999) ? 0 : counter+1;

    assign en = (counter == 249999) ? 1'b1 : 1'b0;
endmodule

module dff(clk, en,in, out);

input wire clk;
input wire en;
input wire in;

output reg out;

always @ (posedge clk)
  if(en) out <= in;

endmodule 

