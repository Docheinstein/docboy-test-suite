INCLUDE "all.inc"

; Enable Joypad Buttons and D-Pad and dump P1 register.

EntryPoint:
    ; React to both buttons and D-Pad
    ld a, $00
    ldh [rP1], a

    WaitVBlank

    ld a, [rP1]
    push af

    DisablePPU
    InitPrint
    PrintString "P1: "
    pop af
    PutHex8
    EnablePPU
    halt

