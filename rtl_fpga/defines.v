`define NO_HC_CACHE
`define NO_HC_REGF

`define USE_RESET_BTN

`ifdef ICARUS_VERILOG 
    `define ROM_FILE_PATH "../mem/test_rom_v.mem"
    `define RAM_FILE_PATH "../mem/test_ram_v.mem"
`else
    `define ROM_FILE_PATH "test_rom_v.mem"
    `define RAM_FILE_PATH "test_ram_v.mem"
`endif

`ifdef FETCH_FROM_ROM
    `define USE_ROM
    `define ROM_MEM_WORDS 8192
    `define INIT_ROM
    `define PC_START_ADDRESS 32'h4A000000
`else 
    `ifdef FETCH_FROM_RAM
        `define INIT_RAM
        `define PC_START_ADDRESS 32'h20000000
    `else // Fetch from SPI Flash
        `define FETCH_FROM_FLASH
        `define PC_START_ADDRESS 32'h00000000
    `endif

`endif