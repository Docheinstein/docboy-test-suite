CartridgeType $0254
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Write to RTC scratchapd (memory[0:5]) and read it back.

EntryPoint:
    HuC3_RtcWriteMemory $00, $1
    HuC3_RtcWriteMemory $01, $2
    HuC3_RtcWriteMemory $02, $3

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

