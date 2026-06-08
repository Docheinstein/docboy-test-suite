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

; Mimic Kirby Tilt 'n' Tumble header.
; This should be read correctly.

EntryPoint:
    jp TestSuccess


