INCLUDE "all.inc"

; Check the timing of HBlank in double speed mode by reading STAT with various SCX.
; Disable and enable PPU several times before the test.

EntryPoint:
    DisablePPU

    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Enable and disable PPU several times
REPT 10
    DisablePPU

    Nops 32

    EnablePPU
ENDR

    LongWait 228

    Nops 122

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess