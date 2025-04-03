INCLUDE "all.inc"

; Execute STOP.
; Then enable PPU and print a string to screen.
; LCD should correctly be in sync with PPU.

EntryPoint:
    DisablePPU

    InitPrint
    PrintString "Hello World!"

    EnablePPU

    stop

    Nops 4

    HaltForever


