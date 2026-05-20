CartridgeType $03
RamSize $02

INCLUDE "all.inc"
INCLUDE "mbc/mbc1.inc"

; Check that RAM can't be written while it's disabled.

EntryPoint:
    ; Enable RAM
    ld hl, rMBC1_RAM
    ld [hl], MBC_RAM_ON

    ; Write a value to RAM
    ld hl, $A080
    ld [hl], $66

    ; Disable RAM
    ld hl, rMBC1_RAM
    ld [hl], MBC_RAM_OFF

    ; (Attempt) to write another value to RAM
    ld hl, $A080
    ld [hl], $99

    ; Enable RAM
    ld hl, rMBC1_RAM
    ld [hl], MBC_RAM_ON

    ; Read the value back
    ld hl, $A080
    ld a, [hl]

    ; Should read the first value
    cp $66
    jp nz, TestFail
    jp TestSuccess
