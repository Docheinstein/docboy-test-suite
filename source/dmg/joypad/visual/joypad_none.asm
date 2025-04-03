INCLUDE "all.inc"

; Disable both Joypad Buttons and D-Pad and dump P1 register.

EntryPoint:
    ; React to nothing
    ld a, $30
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

