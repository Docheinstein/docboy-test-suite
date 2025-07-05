INCLUDE "all.inc"

; Serial transfer with slave clock should never end (since no external peripheral is connected).

EntryPoint:
    ; Start serial transfer
    ld a, $80
    ldh [rSC], a

    Wait 32768

    ldh a, [rSC]
    cp $fe

    jp nz, TestFail

    ldh a, [rSB]
    cp $00

    jp nz, TestFail

    jp TestSuccess
