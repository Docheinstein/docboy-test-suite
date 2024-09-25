INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "apu.inc"

; Writing 0 to NRx2 turns off DAC and therefore channel

EntryPoint:
    EnableAPU

    ; Turn on channel
    ld a, $FF
    ldh [rNR12], a

    ld a, $80
    ldh [rNR14], a

    Nops 4

    xor a
    ldh [rNR12], a

    Nops 4

    ldh a, [rNR52]

    cp $f0
    jp nz, TestFail

    jp TestSuccess
