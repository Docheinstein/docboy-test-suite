;! MBC_TYPE=16
;! RAM_SIZE=3

INCLUDE "all.inc"

; With RTC disabled, write to a RTC register and read the value back.
; It should read the old value, not the new one.

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

    ; Write 0 -> 1 -> 0 to latch.
    xor a
    ld [rRTCLATCH], a
    inc a
    ld [rRTCLATCH], a
    xor a
    ld [rRTCLATCH], a

    ; Read RTC register
    ld a, [rRTCRW]

    ; Increment and write it back
    ld b, a
    inc a
    ld [rRTCRW], a

    ; Read RTC register back again
    ld a, [rRTCRW]

    ; Check the result
    cp b
    jp z, TestSuccess

    jp TestFail
