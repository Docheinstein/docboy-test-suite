INCLUDE "all.inc"

; Check if SVBK can be accessed in DMG mode.

EntryPoint:
    ld a, $01
    ldh [rSVBK], a

    ldh a, [rSVBK]
    cp $f9

    jp nz, TestFailBeep
    jp TestSuccess