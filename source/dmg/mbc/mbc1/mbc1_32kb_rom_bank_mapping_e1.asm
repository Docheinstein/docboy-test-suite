CartridgeType $03
RamSize $02

INCLUDE "all.inc"
INCLUDE "mbc/mbc1.inc"

; Try to map ROM bank $E1 to ($4000:$7FFF).
; Bank $01 should mapped instead (only lower 5 bits are considered).

EntryPoint:
    ; Map bank to $4000:$7FFF
    ld hl, rMBC1_ROM_BANK
    ld [hl], $e1

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