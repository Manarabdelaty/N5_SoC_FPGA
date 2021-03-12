`timescale 1ns/1ns

`define CLK_PERIOD 83.3333333

`ifdef ICARUS_VERILOG
    `define   SIM_TIME    500_000_000
    `define   SIM_LEVEL   0
    `define   TEST_FILE   "../mem/test_flash.mem" 

    `include "rtl_fpga/n5_netlists.v"
    `include "sst26wf080b.v"
    `include "23LC512.v" 
    `include "M24LC16B.v"
`else
    `define   TEST_FILE   "test_flash.mem" 
`endif

`ifdef USE_RESET_BTN
    `define RESET_DELAY  80000000
    `define RESET_VAL    1     // when button is pressed
`else
    `define RESET_DELAY 800
    `define RESET_VAL   0
`endif

module N5_FPGA_TB;

    reg HCLK, HRESETn;

    wire [3:0]		fdi;
    wire [3:0]    	fdo;
    wire [3:0]      fdio;
    wire     	    fdoe;
    wire          	fsclk;
    wire          	fcen;

    wire [15: 0] GPIO_Sys0_S2;

    wire [0: 0] RsRx_Sys0_SS0_S0;
    wire [0: 0] RsTx_Sys0_SS0_S0;
    
    wire [0: 0] RsRx_Sys0_SS0_S1;
    wire [0: 0] RsTx_Sys0_SS0_S1;

    wire [0: 0] MSI_Sys0_SS0_S2;
    wire [0: 0] MSO_Sys0_SS0_S2;
    wire [0: 0] SSn_Sys0_SS0_S2;
    wire [0: 0] SCLK_Sys0_SS0_S2;

    wire [0: 0] MSI_Sys0_SS0_S3;
    wire [0: 0] MSO_Sys0_SS0_S3;
    wire [0: 0] SSn_Sys0_SS0_S3;
    wire [0: 0] SCLK_Sys0_SS0_S3;

    wire [0: 0] scl_Sys0_SS0_S4;
    wire [0: 0] sda_Sys0_SS0_S4;

    wire [0: 0] scl_Sys0_SS0_S5;
    wire [0: 0] sda_Sys0_SS0_S5;

    wire [0: 0] pwm_Sys0_SS0_S6;
	wire [0: 0] pwm_Sys0_SS0_S7;

    // I2C E2PROM connected to I2C0
    wire    scl, sda;
    
    `ifdef FETCH_FROM_FLASH
        /* Program Flash */
        sst26wf080b flash(
            .SCK(fsclk),
            .SIO(fdio),
            .CEb(fcen)
        );
    `endif

    /* N5_SoC Core */
    soc_core MUV (
    `ifdef USE_POWER_PINS
        .VPWR(1'b1),
        .VGND(1'b0),
    `endif
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        // .SYSTICKCLKDIV(8'd100),
        // .NMI(1'b0),
       
        .fd_Sys0_S0(fdio),
        .fsclk_Sys0_S0(fsclk),
        .fcen_Sys0_S0(fcen),


        .GPIO_Sys0_S2(GPIO_Sys0_S2),
    	
        .RsRx_Sys0_SS0_S0(RsRx_Sys0_SS0_S0),
        .RsTx_Sys0_SS0_S0(RsTx_Sys0_SS0_S0),

        .RsRx_Sys0_SS0_S1(RsRx_Sys0_SS0_S1),
        .RsTx_Sys0_SS0_S1(RsTx_Sys0_SS0_S1),
       
        .MSI_Sys0_SS0_S2(MSI_Sys0_SS0_S2),
        .MSO_Sys0_SS0_S2(MSO_Sys0_SS0_S2),
        .SSn_Sys0_SS0_S2(SSn_Sys0_SS0_S2),
        .SCLK_Sys0_SS0_S2(SCLK_Sys0_SS0_S2),

        .MSI_Sys0_SS0_S3(MSI_Sys0_SS0_S3),
        .MSO_Sys0_SS0_S3(MSO_Sys0_SS0_S3),
        .SSn_Sys0_SS0_S3(SSn_Sys0_SS0_S3),
        .SCLK_Sys0_SS0_S3(SCLK_Sys0_SS0_S3),

        .scl_Sys0_SS0_S4(scl),
        .sda_Sys0_SS0_S4(sda),
    
        .scl_Sys0_SS0_S5(scl_Sys0_SS0_S5),
        .sda_Sys0_SS0_S5(sda_Sys0_SS0_S5),
    
        .pwm_Sys0_SS0_S6(pwm_Sys0_SS0_S6),
	    .pwm_Sys0_SS0_S7(pwm_Sys0_SS0_S7)

    );

    // GPIO Loopback!
    wire [15:0] GPIO_PINS;

    assign GPIO_PINS[15:8] = GPIO_Sys0_S2[7:0];
    assign GPIO_Sys0_S2  = GPIO_PINS;

    // Serial Terminal connected to UART0 TX*/
    terminal term(.rx(RsTx_Sys0_SS0_S0));

    // SPI SRAM connected to SPI0
    wire SPI_HOLD = 1'b1;
    M23LC512 SPI_SRAM(
        .RESET(~HRESETn),
        .SO_SIO1(MSI_Sys0_SS0_S2),
        .SI_SIO0(MSO_Sys0_SS0_S2),
        .CS_N(SSn_Sys0_SS0_S2),
        .SCK(SCLK_Sys0_SS0_S2),
        .HOLD_N_SIO3(SPI_HOLD)
	);

	pullup p1(scl); // pullup scl line
	pullup p2(sda); // pullup sda line

    M24LC16B I2C_E2PROM(
        .A0(1'b0), 
        .A1(1'b0), 
        .A2(1'b0), 
        .WP(1'b0), 
        .SDA(sda), 
        .SCL(scl), 
        .RESET(~HRESETn)
    );

    `ifdef FETCH_FROM_FLASH 
        // Load the application into the flash memory
        initial begin
            #1  $readmemh(`TEST_FILE, flash.I0.memory);
            $display("---------N5 Flash -----------");
            $display("Memory[0]: %0d, Memory[1]: %0d, Memory[2]: %0d, Memory[3]: %0d", 
                flash.I0.memory[0], flash.I0.memory[1], flash.I0.memory[2], flash.I0.memory[3]);
        end
    `endif
    // Clock and Rest Generation
    initial begin
        //Inputs initialization
        HCLK = 0;
        HRESETn = 1'bx;        
        #50;
        HRESETn = `RESET_VAL;
        #(`RESET_DELAY)
        @(posedge HCLK);
        HRESETn <= ~(`RESET_VAL);
    end

    always #(`CLK_PERIOD / 2.00) HCLK = ~ HCLK;

    `ifdef ICARUS_VERILOG
        // Dump file
        initial begin
            $dumpfile("N5_FPGA_TB.vcd");
            $dumpvars(`SIM_LEVEL, N5_FPGA_TB);
            #`SIM_TIME;
            $finish;
        end
    `endif
    // Terminate the smulation with ebreak instruction.
    // Calculate the CPI using the CSRs
    `ifndef GL
        always @ (posedge HCLK) 
            if(MUV.CPU.N5.instr_ebreak) begin
            //$display("CPI=%d.%0d", MUV.N5.CSR_CYCLE/MUV.N5.CSR_INSTRET,(MUV.N5.CSR_CYCLE%MUV.N5.CSR_INSTRET)*10/MUV.N5.CSR_INSTRET );
            $finish;
            end
    `endif
    
    // Monitor Flash memory reads
    //always @(posedge HCLK)
    //    if(MUV.N5.HTRANS[1] & MUV.N5.HREADY & MUV.N5.HSEL_FLASH)
    //    $display("Flash Read A:%X (%0t)", HADDR, $time);


    
endmodule

module terminal #(parameter bit_time = 1333.3333333) (input rx);

    integer i;
    reg [7:0] char;
    initial begin
        forever begin
            @(negedge rx);
            i = 0;
            char = 0;
            #(3*bit_time/2);
            for(i=0; i<8; i=i+1) begin
                char[i] = rx;
                #bit_time;
            end
            $write("%c", char);
        end
    end


endmodule