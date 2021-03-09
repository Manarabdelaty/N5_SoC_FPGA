SW_PATH ?=../N5_SoC/sw
N5_FPGA_RTL_PATH ?=..
N5_RTL_PATH ?=../N5_SoC/verilog/rtl
N5_SIM_PATH ?=../N5_SoC/dv
DIR := ${CURDIR}
LINKER_SCRIPT ?= $(DIR)/../sw/link.ld

# Specify boot option
# FLASH|RAM|ROM
BOOT?=FLASH

# Hex files
ROM_HEX_INTEL="../mem/test_rom_i.mem"
ROM_HEX_VERILOG="../mem/test_rom_v.mem"
RAM_HEX_INTEL="../mem/test_ram_i.mem"
RAM_HEX_VERILOG="../mem/test_ram_v.mem"

all: sim
.PHONY: all

test.hex: $(SW_PATH)/test.c $(SW_PATH)/crt0.S $(SW_PATH)/link.ld
ifeq ($(BOOT),RAM)
	export LINKER_SCRIPT=$(DIR)/../sw/link_1.ld ; $(MAKE) -C $(SW_PATH) all ; mv $(SW_PATH)/test.hex $(RAM_HEX_INTEL) ;
endif
ifeq ($(BOOT),ROM)
	export LINKER_SCRIPT=$(DIR)/../sw/link_2.ld ; $(MAKE) -C $(SW_PATH) all ; mv $(SW_PATH)/test.hex $(ROM_HEX_INTEL) ;
endif
ifeq ($(BOOT),FLASH)
	$(MAKE) -C $(SW_PATH) all ; mv $(SW_PATH)/test.hex ../mem/test_flash.mem ;
endif

test.vvp: N5_FPGA_TB.v test.hex
ifeq ($(BOOT),RAM)
	sed -i 's/@20/@00/g' $(RAM_HEX_INTEL)
	iverilog -DRAM IntelHexToVHex.v -o hex.vvp ; vvp hex.vvp
	iverilog -o test.vvp -DFETCH_FROM_RAM -DICARUS_VERILOG -DUSE_IO_BUF_BEH \
	-I $(N5_FPGA_RTL_PATH) -I $(N5_RTL_PATH) -I $(N5_SIM_PATH) N5_FPGA_TB.v
endif
ifeq ($(BOOT),ROM)
	sed -i 's/@4A/@00/g' $(ROM_HEX_INTEL)
	iverilog -DROM IntelHexToVHex.v -o hex.vvp ; vvp hex.vvp
	iverilog -o test.vvp -DFETCH_FROM_ROM -DICARUS_VERILOG -DUSE_IO_BUF_BEH \
	-I $(N5_FPGA_RTL_PATH) -I $(N5_RTL_PATH) -I $(N5_SIM_PATH) N5_FPGA_TB.v
endif 
ifeq ($(BOOT),FLASH)
	iverilog -o test.vvp -DICARUS_VERILOG -DUSE_IO_BUF_BEH \
	-I $(N5_FPGA_RTL_PATH) -I $(N5_RTL_PATH) -I $(N5_SIM_PATH) N5_FPGA_TB.v
endif

sim: test.vvp 
	./test.vvp

clean:
	rm *.vvp *.vcd
	rm -f $(SW_PATH)/*.hex $(SW_PATH)/*.elf $(SW_PATH)/*.lst 