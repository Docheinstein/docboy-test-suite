CartridgeType $03
RomSize $05
RamSize $02

INCLUDE "all.inc"
INCLUDE "mbc/mbc1.inc"

; Properly map ROM bank $21 to ($4000:$7FFF).

EntryPoint:
    ; Map bank to $4000:$7FFF
    ld hl, rMBC1_ROM_BANK
    ld [hl], $01

    ld hl, rMBC1_RAM_BANK_UPPER_ROM_BANK
    ld [hl], $01

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $44
    jp nz, TestFail
    jp TestSuccess

SECTION "Bank $00 Data", ROM0[$2000]
db $11

SECTION "Bank $01 Data", ROMX[$6000], BANK[$01]
db $22

SECTION "Bank $20 Data", ROMX[$6000], BANK[$20]
db $33

SECTION "Bank $21 Data", ROMX[$6000], BANK[$21]
db $44