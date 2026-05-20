CartridgeType $1B
RomSize $08

INCLUDE "all.inc"
INCLUDE "mbc/mbc5.inc"

; Check that ROM banks are working even for large ROM (8 MB).

EntryPoint:
    ; Map bank $0000 to $4000:$7FFF
    ld hl, rMBC5_LOWER_ROM_BANK
    ld [hl], $00

    ld hl, rMBC5_UPPER_ROM_BANK
    ld [hl], $00

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $11
    jp nz, TestFail

    ; Map bank $0001 to $4000:$7FFF
    ld hl, rMBC5_LOWER_ROM_BANK
    ld [hl], $01

    ld hl, rMBC5_UPPER_ROM_BANK
    ld [hl], $00

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $22
    jp nz, TestFail

    ; Map bank $0001 to $4000:$7FFF
    ld hl, rMBC5_LOWER_ROM_BANK
    ld [hl], $00

    ld hl, rMBC5_UPPER_ROM_BANK
    ld [hl], $01

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $33
    jp nz, TestFail

    ; Map bank $0100 to $4000:$7FFF
    ld hl, rMBC5_LOWER_ROM_BANK
    ld [hl], $01

    ld hl, rMBC5_UPPER_ROM_BANK
    ld [hl], $01

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $44
    jp nz, TestFail

    jp TestSuccess


SECTION "Bank $0000 Data", ROM0[$2000]
DataBank0:
db $11

SECTION "Bank $0001 Data", ROMX[$6000], BANK[$0001]
DataBank1:
db $22

SECTION "Bank $0100 Data", ROMX[$6000], BANK[$0100]
DataBank256:
db $33

SECTION "Bank $0101 Data", ROMX[$6000], BANK[$0101]
DataBank257:
db $44