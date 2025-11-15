Title "REDUCTIONS"
CgbFlag $80
NewLicenseeCode $0000 
SgbFlag $00
CartridgeType $00
RamSize $00
DestinationCode $00
OldLicenseeCode $01
RomVersion $00

INCLUDE "all.inc"

EntryPoint:
    Nops 14
    ldh a, [rDIV]

    cp $2f
    jp nz, TestFail

    jp TestSuccess
