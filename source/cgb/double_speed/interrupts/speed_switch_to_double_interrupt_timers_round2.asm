INCLUDE "all.inc"

; Check the timing of speed switch when timers interrupt is triggered during a speed switch to double speed.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Go to line 42
    Wait 114 * 42

    ; Enable TIMER interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_TIMER
    ldh [rIE], a

    ; Reset DIV
    ldh [rDIV], a

    ; Set TIMA to FF
    ld a, $FF
    ldh [rTIMA], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_65KHZ
    ldh [rTAC], a

    ; Switch to double speed
    stop

    Nops 44

    ; Read DIV
    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess