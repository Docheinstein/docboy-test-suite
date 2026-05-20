CartridgeType $03
RamSize $02

INCLUDE "all.inc"
INCLUDE "mbc/mbc1.inc"

; Check the initial value of RAM (A000:BFFF).

EntryPoint:
    ; Enable RAM
    ld hl, rMBC1_RAM
    ld [hl], MBC_RAM_ON

    ; Check content
    Memtest $A000, $FF, $2000

    jp nz, TestFail
    jp TestSuccess
