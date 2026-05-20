CartridgeType $03
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc1.inc"

; Check that RAM banks can be switched and written separately when banking mode is 1.

EntryPoint:
    ; Enable RAM
    ld hl, rMBC1_RAM
    ld [hl], MBC_RAM_ON

    ; Enable banking mode 1
    ld hl, rMBC1_BANK_MODE
    ld [hl], $01

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

    cp $10 * (I + 1)
    jp nz, TestFail
ENDR

    jp TestSuccess
