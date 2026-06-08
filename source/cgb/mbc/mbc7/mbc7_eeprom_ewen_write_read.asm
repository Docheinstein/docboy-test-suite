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

; Run some EEPROM command and see the result:
; EWEN
; WRITE
; READ

EntryPoint:
    ; Enable primary and secondary RAM
    ld hl, rMBC7_RAM_PRIMARY
    ld [hl], MBC_RAM_ON

    ld hl, rMBC7_RAM_SECONDARY
    ld [hl], MBC7_RAM_SECONDARY_ON

    Mbc7_EepromEWEN

    Mbc7_EepromWRITE $01, $abcd
    
    Mbc7_EepromREAD $01

    ld a, $ab
    cp d
    jp nz, TestFail

    ld a, $cd
    cp e
    jp nz, TestFail

    jp TestSuccess