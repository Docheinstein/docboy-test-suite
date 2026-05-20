INCLUDE "all.inc"

; STAT interrupt with HBLANK mode should be triggered by entering HBLANK.

EntryPoint:
    Wait 114

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Go ahead of OAM scan
    Wait 20

    ; Enable HBLANK interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Enable interrupts
    ei

    ; Reach HBLANK
    Wait 80

    ; This should not be reached
    jp TestFail


SECTION "STAT handler", ROM0[$48]
    jp TestSuccess
