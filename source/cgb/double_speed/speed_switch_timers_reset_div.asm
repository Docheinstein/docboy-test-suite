INCLUDE "all.inc"

; Changing speed should reset DIV.

EntryPoint:
    xor a
    ldh [rDIV], a

    ld a, $20
    ldh [rTIMA], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    ldh a, [rKEY1]

    ; Wait so that DIV will be > 0
    LongWait 256

    ; Change speed
    stop

    ; Read DIV
    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess