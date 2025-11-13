IF !DEF(HALT_INC)
DEF HALT_INC EQU 1

MACRO HaltForever
    xor a
    ldh [rIE], a
    halt
    nop
ENDM

ENDC