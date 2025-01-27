INCLUDE "docboy.inc"

; Check how much time it takes to read LY increased by 1 from boot.
; It should not be affected to SCX

EntryPoint:
    ; Write SCX=0
    ld a, $05
    ldh [rSCX], a

    ; 116 nops should read LY=1
    Nops 116

    ; Read LY
    ldh a, [rLY]
    ld b, a

    ; Check result
    ld a, 01
    cp b
    jp nz, TestFail

    jp TestSuccess

