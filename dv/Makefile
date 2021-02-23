SW_PATH ?=../N5_SoC/sw
N5_FPGA_RTL_PATH ?=..
N5_RTL_PATH ?=../N5_SoC/verilog/rtl
N5_SIM_PATH ?=../N5_SoC/dv

all: sim
.PHONY: all

test.hex: $(SW_PATH)/test.c $(SW_PATH)/crt0.S $(SW_PATH)/link.ld 
	$(MAKE) -C $(SW_PATH) all

test.vvp: N5_FPGA_TB.v test.hex
	iverilog -o test.vvp -DUSE_IO_BUF_BEH \
	-I $(N5_FPGA_RTL_PATH) -I $(N5_RTL_PATH) -I $(N5_SIM_PATH) N5_FPGA_TB.v

sim: test.vvp 
	./test.vvp

clean:
	rm *.vvp *.vcd
	rm -f $(SW_PATH)/*.hex $(SW_PATH)/*.elf $(SW_PATH)/*.lst 