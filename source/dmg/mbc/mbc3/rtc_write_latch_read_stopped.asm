;! MBC_TYPE=16
;! RAM_SIZE=3

INCLUDE "docboy.inc"

; With RTC disabled, write to a RTC register, latch, and read the value back.
; It should read the new value.

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

    ; Set latch to 0
    xor a
    ld [rRTCLATCH], a

    ; Read RTC register
    ld a, [rRTCRW]

    ; Increment and write it back
    ld b, a
    inc a
    ld [rRTCRW], a

    ; Set latch to 1
    ld a, 1
    ld [rRTCLATCH], a

    ; Read RTC register back again
    ld a, [rRTCRW]

    ; Check the result
    cp b
    jp nz, TestSuccess

    jp TestFail
