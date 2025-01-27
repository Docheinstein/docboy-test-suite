;! MBC_TYPE=16
;! RAM_SIZE=3

INCLUDE "docboy.inc"

; Check whether RTC ticks even if RTC is disabled (it should not).

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rRTCEN], a

    ; Enable RTC tick
    ld a, RTC_DH
    ld [rRTCSEL], a
    xor a
    ld [rRTCRW], a

    ; Disable RTC
    xor a
    ld [rRTCEN], a

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

    ; Set latch to 1
    ld a, 1
    ld [rRTCLATCH], a

    ; Read RTC register
    ld a, [rRTCRW]
    cp b
    jp z, TestSuccess

    jp TestFail
