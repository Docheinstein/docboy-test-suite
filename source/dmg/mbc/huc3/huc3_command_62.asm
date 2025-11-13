CartridgeType $0254
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; HuC3 games executes command 0x62 and expect 0x01 as least significant nibble for the next read.

EntryPoint:
    HuC3_RtcExecuteCommand $62
    HuC3_RtcRead
    and $0f
    cp $01

    jp nz, TestFail
    jp TestSuccess
