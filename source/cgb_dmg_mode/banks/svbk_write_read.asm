INCLUDE "all.inc"

; Check if SVBK can be accessed in DMG mode.

EntryPoint:
    ld a, $01
    ldh [rSVBK], a

    ldh a, [rSVBK]
    cp $ff

    jp nz, TestFailBeep
    jp TestSuccess