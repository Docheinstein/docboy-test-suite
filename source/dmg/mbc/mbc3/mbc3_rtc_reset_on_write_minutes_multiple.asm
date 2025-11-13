CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Writing to minutes register should NOT reset the internal counter.

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

    ; Write RTC register
    ld a, $10
    ld [rRTCRW], a

    ; Use RTC minutes register
    ld a, RTC_M
    ld [rRTCSEL], a

REPT 3
    ; Write RTC register
    ld a, $20
    ld [rRTCRW], a

    ; Wait less than 1 second
    REPT 60
        Wait 154 * 114
    ENDR
ENDR

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
    cp $13

    jp nz, TestFail
    jp TestSuccess