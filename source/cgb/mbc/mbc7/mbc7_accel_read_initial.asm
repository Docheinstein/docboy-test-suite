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

; Read accelerometer and check initial values.

EntryPoint:
    ld hl, rMBC7_RAM_PRIMARY
    ld [hl], MBC_RAM_ON

    ld hl, rMBC7_RAM_SECONDARY
    ld [hl], MBC7_RAM_SECONDARY_ON

    ld hl, rMBC7_ACCEL_X_LOW
    ld a, [hl]
    cp $00
    jp nz, TestFail

    ld hl, rMBC7_ACCEL_X_HIGH
    ld a, [hl]
    cp $80
    jp nz, TestFail

    ld hl, rMBC7_ACCEL_Y_LOW
    ld a, [hl]
    cp $00
    jp nz, TestFail

    ld hl, rMBC7_ACCEL_Y_HIGH
    ld a, [hl]
    cp $80
    jp nz, TestFail

    jp TestSuccess



