CartridgeType $0254
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Command $3x writes to RTC memory and increases the memory address.

EntryPoint:
    HuC3_SetMemoryAddress $00

    HuC3_RtcExecuteCommand $31
    HuC3_RtcExecuteCommand $32
    HuC3_RtcExecuteCommand $33

    HuC3_RtcReadMemory $00
    cp $1
    jp nz, TestFail

    HuC3_RtcReadMemory $01
    cp $2
    jp nz, TestFail

    HuC3_RtcReadMemory $02
    cp $3
    jp nz, TestFail

    jp TestSuccess

