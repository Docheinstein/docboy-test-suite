INCLUDE "all.inc"

; Check the timing of IF when entering HBlank in double speed mode with various SCX.

EntryPoint:
    DisablePPU

    ; Enable STAT (HBlank) interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Nops 1

    ; Enable PPU
    EnablePPU

    LongWait 228

    ; Reset IF
    xor a
    ldh [rIF], a

    Nops 117

    ; Read IF
    ldh a, [rIF]
    cp $e0

    jp nz, TestFail
    jp TestSuccess