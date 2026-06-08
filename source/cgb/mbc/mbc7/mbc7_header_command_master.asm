; ----------------------
; Command Master
Title "CMASTER"
ManufacturerCode $4A45434B
CgbFlag $C0
NewLicenseeCode $3442
SgbFlag $00
CartridgeType $22
RomSize $06
RamSize $00
DestinationCode $00
OldLicenseeCode $33
RomVersion $00
; ----------------------

INCLUDE "all.inc"
INCLUDE "mbc/mbc7.inc"

; Mimic Command Master header.
; This should be read correctly.

EntryPoint:
    jp TestSuccess


