INCLUDE "hardware.inc"
INCLUDE "common.inc"

; STAT interrupt with OAM mode should not be triggered by entering HBLANK.

EntryPoint:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable OAM interrupt
    ld a, STATF_MODE10
    ldh [rSTAT], a

    ; Go ahead of OAM scan
    Nops 20

    ; Enable interrupts
    ei

    ; Reach HBLANK
    Nops 80

    ; This should be reached
    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    ; This should not be triggered
    jp TestFail
