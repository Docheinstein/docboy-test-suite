MACRO DumpRegistersCGB
    ; Disable interrupts
    di

    ; Save the registers
    push hl
    push de
    push bc
    push af

    DisablePPU
    InitPrint
    SetDefaultBGP

    ; Print each register
    PrintString "AF: "
    pop bc
    PutHex16
    NewLine

    PrintString "BC: "
    pop bc
    PutHex16
    NewLine

    PrintString "DE: "
    pop bc
    PutHex16
    NewLine

    PrintString "HL: "
    pop bc
    PutHex16
    NewLine

    EnablePPU

    ; HALT forever.
    HaltForever
ENDM