INCLUDE "all.inc"

; Check the phase of DIV at boot time.

EntryPoint:
    Nops 17
    ldh a, [rDIV]

    cp $1f
    jp nz, TestFail

    jp TestSuccess