INCLUDE "all.inc"

; Execute STOP.
; Then enable PPU and print a string to screen.
; LCD should correctly be in sync with PPU.

EntryPoint:
    DisablePPU

    ; React to both buttons and D-Pad
    ld a, $00
    ldh [rP1], a

    InitPrint
    PrintString "Hello World!"

    EnablePPU

    stop

    Nops 4

    HaltForever


