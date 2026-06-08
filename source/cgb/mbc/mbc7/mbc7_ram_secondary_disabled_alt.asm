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

; Read while primary ram is enabled but secondary is disabled.

EntryPoint:
    ld hl, rMBC7_RAM_PRIMARY
    ld [hl], MBC_RAM_ON

    ld hl, rMBC7_RAM_SECONDARY
    ld [hl], MBC_RAM_ON ; only enabled with $40

    ld hl, rMBC7_EEPROM
    ld a, [hl]

    cp $ff
    jp nz, TestFail

    jp TestSuccess


