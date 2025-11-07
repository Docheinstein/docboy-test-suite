DEF CGB_FLAG = $89

INCLUDE "all.inc"

; Check which operating mode is entered with various CGB flag (cartridge byte $143).
; Unfortunately KEY0 can't be read, therefore we use SVBK and BCPD as proxy:
; If we can read/ write both => CGB mode
; If we can read/write SVBK but not BCPD => DMG ext mode
; If we can't read/write neither one of the two => DMG mode

EntryPoint:
    ld a, $01
    ldh [rSVBK], a

    ldh a, [rSVBK]
    cp $f9
    jp nz, TestFailBeep

    ld a, $00
    ldh [rBCPS], a

    ld a, $66
    ld b, a
    ldh [rBCPD], a

    ldh a, [rBCPD]
    cp b
    jp z, TestFailBeep

    jp TestSuccess
