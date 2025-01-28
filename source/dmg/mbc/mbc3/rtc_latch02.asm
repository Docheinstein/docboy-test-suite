;! MBC_TYPE=16
;! RAM_SIZE=3

INCLUDE "all.inc"

; Check whether writing 0 -> 2 to RTC latch register actually copies RTC registers.

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rRTCEN], a

    ; Enable RTC tick
    ld a, RTC_DH
    ld [rRTCSEL], a
    xor a
    ld [rRTCRW], a

    ; Use RTC seconds register
    ld a, RTC_S
    ld [rRTCSEL], a

    ; Set latch to 0
    xor a
    ld [rRTCLATCH], a

    ; Read RTC register
    ld a, [rRTCRW]
    ld b, a

    ; Wait 70 frames (> 1 second)
    REPT 70
        LongWait 154 * 114
    ENDR

    ; Set latch to 2
    ld a, 2
    ld [rRTCLATCH], a

    ; Read RTC register
    ld a, [rRTCRW]
    cp b
    jp nz, TestSuccess

    jp TestFail
