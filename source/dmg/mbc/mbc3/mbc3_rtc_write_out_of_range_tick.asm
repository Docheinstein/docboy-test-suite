;! MBC_TYPE=16
;! RAM_SIZE=3

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Write an out of range value to RTC register that would reach 60 if incremented by tick.
; It should be overflow and restart from 0.

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

    ; Write an out of range value that reaches 60 if incremented by one.
    ld a, $7b
    ld [rRTCRW], a

    ; Wait 60 frames (> 1 second)
    REPT 60
        Wait 154 * 114
    ENDR

    ; Reload latch with 0 -> 1
    xor a
    ld [rRTCLATCH], a
    ld a, 1
    ld [rRTCLATCH], a

    ; Wait a bit after reload
    Nops 4

    ; Read RTC register: it should read the same value
    ld a, [rRTCRW]
    cp $00

    jp nz, TestFail
    jp TestSuccess
