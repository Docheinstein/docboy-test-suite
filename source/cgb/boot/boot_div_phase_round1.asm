INCLUDE "all.inc"

; Check the phase of DIV at boot time.

EntryPoint:
    Nops 16
    ldh a, [rDIV]

    cp $1e
    jp nz, TestFail

    jp TestSuccess