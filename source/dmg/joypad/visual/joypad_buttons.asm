INCLUDE "all.inc"

; Enable Joypad Buttons and dump P1 register.

EntryPoint:
    ; React to buttons
    ld a, $10
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

