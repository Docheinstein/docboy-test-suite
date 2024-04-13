;! MBC_TYPE=16
;! RAM_SIZE=3

INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"
INCLUDE "rtc.inc"

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

    ; Set latch to 0
    xor a
    ld [rRTCLATCH], a

    ; Write an out of range value to RTC seconds
    ld a, $7e
    ld [rRTCRW], a

    ; Set latch to 1
    ld a, 1
    ld [rRTCLATCH], a

    ; Read RTC register: it should read only the used bits
    ld a, [rRTCRW]
    cp $3e
    jp z, TestSuccess

    jp TestFail
