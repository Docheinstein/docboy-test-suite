IF !DEF(DELAY_INC)
DEF DELAY_INC EQU 1

; Args:
; \1: number of nops
MACRO Nops
REPT \1
    nop
ENDR
ENDM

; Args:
; \1: number of cycles to wait (< 65536)
MACRO ShortWait
IF \1 > 16
    ld de, ((\1) / 8) - ((\1) % 8 < 2)   ; 3

    .loop\@
        dec de            ; 2
        ld a, d           ; 1
        or e              ; 1
        jp nz, .loop\@    ; 3/4

    REPT (((\1) % 8) + 8 - 2) % 8
        nop
    ENDR
ELSE
    Nops \1
ENDC
ENDM


; Args:
; \1: number of cycles to wait
MACRO Wait
IF \1 > 32768
    REPT (\1 / 32768)
        ShortWait 32768
    ENDR
    ShortWait (\1 % 32768)
ELSE
    ShortWait \1
ENDC
ENDM

ENDC