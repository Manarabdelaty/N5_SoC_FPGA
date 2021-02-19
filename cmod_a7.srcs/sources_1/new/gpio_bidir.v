`timescale 1ns/1ns

module gpio_bidir #(parameter WIDTH=1) (
        inout wire [WIDTH-1:0] dio_buf,
        input wire [WIDTH-1:0] din_i,
        output wire [WIDTH-1:0] dout_o,
        input wire in_not_out_i
);

IOBUF iob_data[WIDTH-1:0] (
    .O(dout_o),
    .IO(dio_buf),
    .I(din_i),
    .T(in_not_out_i)
);

endmodule
