CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Write to a RTC register and read the value back without reloading latch, while RTC is stopped.

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rRTCEN], a

    ; Disable RTC tick
    ld a, RTC_DH
    ld [rRTCSEL], a
    ld a, $40
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

    ; Increment and write it back
    ld c, a
    inc a
    ld [rRTCRW], a

    ; Read RTC register back again (without reloading)
    ld a, [rRTCRW]
    cp c

    jp nz, TestFail
    jp TestSuccess
