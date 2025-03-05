INCLUDE "all.inc"

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    LongWait 1001

    ldh a, [rSC]
    DumpRegisters
    cp $fd

    jp nz, TestFail
    jp TestSuccess
