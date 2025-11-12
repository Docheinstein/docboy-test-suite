;! OLD_LICENSE=51

INCLUDE "all.inc"

; Check the phase of DIV at boot time.
; Note that accurate pridicting of DIV is overly complex becuase the boot rom follows different flows based on the header.
; Here we are checking for a specific instance of header (in particular, it is the same of little-things-gb/whichboot).

EntryPoint:
    Nops 18
    ldh a, [rDIV]

    cp $1f
    jp nz, TestFail

    jp TestSuccess