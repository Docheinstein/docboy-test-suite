;! MBC_TYPE=16
;! RAM_SIZE=3

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Check whether RTC ticks even if RTC is unmapped.

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

    ; Disable RTC
    xor a
    ld [rRTCEN], a

    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Enable RTC
    ld a, $0a
    ld [rRTCEN], a

    ; Reload latch with 0 -> 1
    xor a
    ld [rRTCLATCH], a
    ld a, 1
    ld [rRTCLATCH], a

    ; Wait a bit after reload
    Nops 4

    ; Read RTC register back again
    ld a, [rRTCRW]

    ; Either is increased by one or by two
    inc c
    cp c
    jp z, TestSuccess

    inc c
    cp c
    jp z, TestSuccess

    ; Last chance: maybe overflow?
    cp $00
    jp z, TestSuccess

    cp $01
    jp z, TestSuccess

    ; Really failed
    jp TestFail
