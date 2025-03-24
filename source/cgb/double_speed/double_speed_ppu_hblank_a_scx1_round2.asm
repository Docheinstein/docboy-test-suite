INCLUDE "all.inc"

; Check the timing of HBlank in double speed mode by reading STAT with various SCX.

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

    ; Enable PPU
    EnablePPU

    LongWait 228

    Nops 123

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess