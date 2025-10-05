INCLUDE "all.inc"

; Check STAT mode for LY 153 between end of VBlank and OAM Scan.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    DisablePPU
    EnablePPU

    Wait 152 * 114 * 2

    Nops 428

    ldh a, [rSTAT]
    cp $85

    jp nz, TestFail
    jp TestSuccess
