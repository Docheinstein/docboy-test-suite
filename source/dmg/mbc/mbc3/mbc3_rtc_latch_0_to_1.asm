CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Check whether writing 0 -> 1 to RTC latch register actually copies RTC registers.

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rRTCEN], a

    ; Enable RTC tick
    ld a, RTC_DH
    ld [rRTCSEL], a
    xor a
    ld [rRTCRW], a

    ; Set latch to 0
    xor a
    ld [rRTCLATCH], a

    ; Use RTC seconds register
    ld a, RTC_S
    ld [rRTCSEL], a

    ; Read RTC register (without reloading)
    ld a, [rRTCRW]
    ld h, a

    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Set latch to 0 -> 1
    ld a, 1
    ld [rRTCLATCH], a

    Nops 4

    ; Read RTC register
    ld a, [rRTCRW]
    ld l, a

    ; There's a 1/60 change we've been unlikely, do another attempt just in case
    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Read RTC register
    ld a, [rRTCRW]

    cp l
    jp nz, TestSuccess

    cp h
    jp nz, TestSuccess

    jp TestFail
