CartridgeType $03
RomSize $05
RamSize $02

INCLUDE "all.inc"
INCLUDE "mbc/mbc1.inc"

; Try to map ROM bank $21 to ($4000:$7FFF) only through lower bank selector.
; Bank $01 should mapped instead, as upper bank selector is not set.

EntryPoint:
    ; Map bank to $4000:$7FFF
    ld hl, rMBC1_ROM_BANK
    ld [hl], $21

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $22
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