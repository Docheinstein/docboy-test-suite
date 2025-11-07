INCLUDE "all.inc"

; Check if VBK can be accessed in DMG mode.

EntryPoint:
    ld a, $00
    ldh [rVBK], a

    ldh a, [rVBK]
    cp $fe

    jp nz, TestFailBeep

    ld a, $01
    ldh [rVBK], a

    ldh a, [rVBK]
    cp $ff

    jp nz, TestFailBeep

    jp TestSuccess