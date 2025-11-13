CartridgeType $0254
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Command $10 reads from RTC memory and increases the memory address.

EntryPoint:
    HuC3_RtcWriteMemory $00, $1
    HuC3_RtcWriteMemory $01, $2
    HuC3_RtcWriteMemory $02, $3

    HuC3_SetMemoryAddress $00
    HuC3_RtcExecuteCommand $10
    HuC3_RtcRead
    and $0f
    cp $1
    jp nz, TestFail

    HuC3_RtcExecuteCommand $10
    HuC3_RtcRead
    and $0f
    cp $2
    jp nz, TestFail

    HuC3_RtcExecuteCommand $10
    HuC3_RtcRead
    and $0f
    cp $3
    jp nz, TestFail

    jp TestSuccess

