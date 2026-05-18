CartridgeType $03
RomSize $05
RamSize $02

INCLUDE "all.inc"
INCLUDE "mbc/mbc1.inc"

; Try to map ROM bank $21 to ($0000:$3FFF) with banking mode 1.
; Bank $20 should be mapped instead.

EntryPoint:
    ; Copy routines to WRAM (otheriwse we would switch the bank
    ; from which we are executing under the hood).
    Memcpy $c000, EntryPointRoutine, EntryPointRoutineEnd - EntryPointRoutine

    jp $c000

    jp TestFail

EntryPointRoutine:
    ; Set banking mode 1
    ld hl, rMBC1_BANK_MODE
    ld [hl], $01

    ; Map bank to $0000:$3FFF
    ld hl, rMBC1_ROM_BANK
    ld [hl], $01

    ld hl, rMBC1_RAM_BANK_UPPER_ROM_BANK
    ld [hl], $01

    ; Check content
    ld hl, $2000
    ld a, [hl]

    ; Restore banking mode 0
    ld hl, rMBC1_BANK_MODE
    ld [hl], $00

    cp $33
    jp nz, TestFail
    jp TestSuccess
EntryPointRoutineEnd:


SECTION "Bank $00 Data", ROM0[$2000]
db $11

SECTION "Bank $01 Data", ROMX[$6000], BANK[$01]
db $22

SECTION "Bank $20 Data", ROMX[$6000], BANK[$20]
db $33

SECTION "Bank $21 Data", ROMX[$6000], BANK[$21]
db $44