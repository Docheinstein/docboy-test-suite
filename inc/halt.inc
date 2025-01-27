MACRO HaltForever
    xor a
    ldh [rIE], a
    halt
    nop
ENDM
