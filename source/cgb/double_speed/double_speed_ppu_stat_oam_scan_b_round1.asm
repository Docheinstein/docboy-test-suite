INCLUDE "all.inc"

; Check that PPU speed remains the same also in double speed mode by evaluating STAT.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Nops 1

    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 42 * 114

    Nops 223

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess