`define NO_HC_CACHE
`define NO_HC_REGF

`ifdef FETCH_FROM_RAM
    `define INIT_MEMORY
    `define PC_START_ADDRESS 32'h20000000
    `define RAM_FILE_PATH "../mem/test_v.mem"
`endif