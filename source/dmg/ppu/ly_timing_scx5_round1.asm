INCLUDE "docboy.inc"

; Check how much time it takes to read LY increased by 1 from boot.
; It should not be affected to SCX

EntryPoint:
    ; Write SCX=0
    ld a, $05
    ldh [rSCX], a

    ; 115 nops should read LY=0
    Nops 115

    ; Read LY
    ldh a, [rLY]
    ld b, a

    ; Check result
    xor a
    cp b
    jp nz, TestFail

    jp TestSuccess

