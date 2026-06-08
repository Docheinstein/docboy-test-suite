; ----------------------
; Kirby Tilt 'n' Tumble.
Title "KIRBY TNT"
ManufacturerCode $454E544B
CgbFlag $C0
NewLicenseeCode $3031
SgbFlag $00
CartridgeType $22
RomSize $05
RamSize $00
DestinationCode $01
OldLicenseeCode $33
RomVersion $00
; ----------------------

INCLUDE "all.inc"
INCLUDE "mbc/mbc7.inc"

; Check the rom bank mapping works.

EntryPoint:
    ; Map bank 00 to $4000:$7FFF
    ld hl, rMBC7_ROM_BANK
    ld [hl], $00

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $11
    jp nz, TestFail

    ; Map bank 01 to $4000:$7FFF
    ld hl, rMBC7_ROM_BANK
    ld [hl], $01

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $22
    jp nz, TestFail

    ; Map bank 02 to $4000:$7FFF
    ld hl, rMBC7_ROM_BANK
    ld [hl], $02

    ; Check content
    ld hl, $6000
    ld a, [hl]

    cp $33
    jp nz, TestFail

    jp TestSuccess



SECTION "Bank $00 Data", ROM0[$2000]
db $11

SECTION "Bank $01 Data", ROMX[$6000], BANK[$01]
db $22

SECTION "Bank $02 Data", ROMX[$6000], BANK[$02]
db $33
