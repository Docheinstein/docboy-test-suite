;! MBC_TYPE=19
;! RAM_SIZE=3

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; RTC shouldn't work for MBC3 type without RTC.
; Note: does not pass on my Everdrive x7: probably it does not honor the cartridge and always enables the RTC instead.

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

    ; Reload latch with 0 -> 1
    xor a
    ld [rRTCLATCH], a
    ld a, 1
    ld [rRTCLATCH], a

    ; Wait a bit after reload
    Nops 4

    ; Read RTC register
    ld a, [rRTCRW]
    ld c, a

    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Reload latch with 0 -> 1
    xor a
    ld [rRTCLATCH], a
    ld a, 1
    ld [rRTCLATCH], a

    ; Wait a bit after reload
    Nops 4

    ; Read RTC register
    ld a, [rRTCRW]
    cp c

    jp nz, TestFail
    jp TestSuccess
