`define   INTEL_HEX    "../mem/test_i.mem" 
`define   VERILOG_HEX  "../mem/test_v.mem" 


module IntelHextoVHex;

localparam MEMSIZE = 8*1024;
localparam RAMSIZE = MEMSIZE / 4;

reg [7:0] mem [MEMSIZE-1:0]; 
reg [31:0] RAM [RAMSIZE-1:0];

integer i;

initial begin
    $readmemh(`INTEL_HEX, mem);
    for (i = 0; i < RAMSIZE; i = i + 1) begin
        RAM[i] = ({24'b0, mem[i*4 + 3]} << 24) | 
                 ({24'b0, mem[i*4 + 2]} << 16) | 
                 ({24'b0, mem[i*4 + 1]} << 8)  | 
                 (mem[i*4]);
    end

    $writememh(`VERILOG_HEX, RAM);
    
end

endmodule