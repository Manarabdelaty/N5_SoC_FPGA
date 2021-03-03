SW_PATH ?=../N5_SoC/sw
N5_FPGA_RTL_PATH ?=..
N5_RTL_PATH ?=../N5_SoC/verilog/rtl
N5_SIM_PATH ?=../N5_SoC/dv
DIR := ${CURDIR}
LINKER_SCRIPT ?= $(DIR)/../sw/link.ld

SIM?=FLASH

all: sim
.PHONY: all

test.hex: $(SW_PATH)/test.c $(SW_PATH)/crt0.S $(SW_PATH)/link.ld
ifeq ($(SIM),RAM)
	export LINKER_SCRIPT=$(DIR)/../sw/link.ld ; $(MAKE) -C $(SW_PATH) all ; mv $(SW_PATH)/test.hex ../mem/test_i.mem ;
else
	$(MAKE) -C $(SW_PATH) all ; mv $(SW_PATH)/test.hex ../mem/test_i.mem ;
endif

test.vvp: N5_FPGA_TB.v test.hex
ifeq ($(SIM),RAM)
	sed -i 's/@20/@00/g' ../mem/test_i.mem
	iverilog IntelHexToVHex.v -o hex.vvp ; vvp hex.vvp
	iverilog -o test.vvp -DFETCH_FROM_RAM -DICARUS_VERILOG -DUSE_IO_BUF_BEH \
	-I $(N5_FPGA_RTL_PATH) -I $(N5_RTL_PATH) -I $(N5_SIM_PATH) N5_FPGA_TB.v
else
	iverilog -o test.vvp -DICARUS_VERILOG -DUSE_IO_BUF_BEH \
	-I $(N5_FPGA_RTL_PATH) -I $(N5_RTL_PATH) -I $(N5_SIM_PATH) N5_FPGA_TB.v
endif

sim: test.vvp 
	./test.vvp

clean:
	rm *.vvp *.vcd
	rm -f $(SW_PATH)/*.hex $(SW_PATH)/*.elf $(SW_PATH)/*.lst 