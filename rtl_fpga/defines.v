`define NO_HC_CACHE
`define NO_HC_REGF

`define USE_RESET_BTN

`ifdef FETCH_FROM_ROM
    `define USE_ROM
    `define ROM_MEM_WORDS 8192
    `define INIT_ROM
    `define PC_START_ADDRESS 32'h4A000000
    `define ROM_FILE_PATH "../mem/test_v.mem"
`else 
    `ifdef FETCH_FROM_RAM
        `define INIT_RAM
        `define PC_START_ADDRESS 32'h20000000
        `define RAM_FILE_PATH "../mem/test_v.mem"
    `else // Fetch from SPI Flash
        `define FETCH_FROM_FLASH
        `define PC_START_ADDRESS 32'h00000000
    `endif

`endif