INCLUDE "all.inc"

; STAT interrupt with VBLANK mode should not be triggered by entering HBLANK.

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

    ; Enable VBLANK interrupt
    ld a, STATF_MODE01
    ldh [rSTAT], a

    ; Enable interrupts
    ei

    ; Reach HBLANK
    Wait 80

    ; This should be reached
    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    ; This should not be triggered
    jp TestFail
