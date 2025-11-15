Title "SURPRISING"
CgbFlag $00
NewLicenseeCode $0000 
SgbFlag $00
CartridgeType $00
RamSize $00
DestinationCode $00
OldLicenseeCode $01
RomVersion $00

INCLUDE "all.inc"

; Check DIV at boot time.
; Note the value of DIV depends on the cartridge header as the boot rom takes different execution paths.

EntryPoint:
    Nops 19
    ldh a, [rDIV]

    cp $2d
    jp nz, TestFail

    jp TestSuccess
