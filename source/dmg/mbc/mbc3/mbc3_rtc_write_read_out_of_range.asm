;! MBC_TYPE=16
;! RAM_SIZE=3

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Write an out of range value to RTC register and read it back.

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

    ; Write an out of range value to RTC seconds (62)
    ld a, $3e
    ld [rRTCRW], a

    ; Reload latch with 0 -> 1
    xor a
    ld [rRTCLATCH], a
    ld a, 1
    ld [rRTCLATCH], a

    ; Wait a bit after reload
    Nops 4

    ; Read RTC register: it should read the same value
    ld a, [rRTCRW]
    cp $3e

    jp z, TestSuccess
    jp TestFail
