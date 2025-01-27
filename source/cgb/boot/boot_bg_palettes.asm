INCLUDE "docboy.inc"

; Check the initial value of BG palettes.
; They should be all white (FF7F).

EntryPoint:
    DisablePPU

    FOR I, 32
        CheckBCPD 2 * I + 0, $ff
        CheckBCPD 2 * I + 1, $7f
    ENDR

    jp TestSuccess
