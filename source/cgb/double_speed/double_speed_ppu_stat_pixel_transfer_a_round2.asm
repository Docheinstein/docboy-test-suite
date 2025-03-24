INCLUDE "all.inc"

; Check that PPU speed remains the same also in double speed mode by evaluating STAT.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 42 * 114

    Nops 224
    Nops 40

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess