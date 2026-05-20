CartridgeType $03
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc1.inc"

; RAM banks can't be switched if banking mode is 0.

EntryPoint:
    ; Enable RAM
    ld hl, rMBC1_RAM
    ld [hl], MBC_RAM_ON

FOR I, 4
    ; Switch ram bank
    ld hl, rMBC1_RAM_BANK_UPPER_ROM_BANK
    ld [hl], I

    ; Write a value to RAM
    ld hl, $A080
    ld [hl], $10 * (I + 1)
ENDR

FOR I, 4
    ; Switch ram bank
    ld hl, rMBC1_RAM_BANK_UPPER_ROM_BANK
    ld [hl], I

    ; Read value from RAM
    ld hl, $A080
    ld a, [hl]

    ; We should always read the last written value
    cp $40
    jp nz, TestFail
ENDR

    jp TestSuccess
