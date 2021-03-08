ENTRY(_start)

MEMORY
{
    FLASH (x) :
        ORIGIN = 0x20000000 
        LENGTH = 8K
    SRAM (rwx) :
        ORIGIN = 0x20000000 + 8K,
        LENGTH = 8K
    stack (rw):
        ORIGIN = 0x20000000 + 12K
        LENGTH = 4K
}

PROVIDE(_fstack = ORIGIN(stack) + LENGTH(stack) - 4);

SECTIONS
{
    .text : {
        *(.text*)
        *(.rodata*)
        . = ALIGN(8);
        __idata__ = .;
    } > FLASH
    
    .bss (NOLOAD) :
    {
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        __bss_end__ = .;
    } > SRAM

    .data : 
    {
        __data_start__ = .;
        *(.data*);
        __data_end__ = .;
        
    } > SRAM AT > FLASH

}

