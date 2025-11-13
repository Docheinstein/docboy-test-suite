CartridgeType $0254
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Command $5x sets the most significant nibble of the memory address.

EntryPoint:
    HuC3_SetMemoryAddressHigh $2
    HuC3_RtcExecuteCommand $3C

    HuC3_RtcReadMemory $20
    cp $C

    jp nz, TestFail
    jp TestSuccess

