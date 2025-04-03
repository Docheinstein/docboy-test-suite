INCLUDE "all.inc"

; STOP while in double speed, then resume through joypad
; (manually on real hardware or artifically on emulators)
; and read TIMA.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Nops 1

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    ; Wait a bit
    Nops 256

    stop

    ldh a, [rTIMA]
    cp $41

    jp nz, TestFail
    jp TestSuccess
