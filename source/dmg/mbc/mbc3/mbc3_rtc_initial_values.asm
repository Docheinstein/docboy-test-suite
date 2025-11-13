CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Check the initial values of RTC latch before any reload.

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rRTCEN], a

    ; Use RTC seconds register
    ld a, RTC_S
    ld [rRTCSEL], a

    ; Read RTC register
    ld a, [rRTCRW]
    ld e, a

    ; Use RTC minutes register
    ld a, RTC_M
    ld [rRTCSEL], a

    ; Read RTC register
    ld a, [rRTCRW]
    ld d, a

    ; Use RTC hours register
    ld a, RTC_H
    ld [rRTCSEL], a

    ; Read RTC register
    ld a, [rRTCRW]
    ld c, a

    ; Use RTC days low register
    ld a, RTC_DL
    ld [rRTCSEL], a

    ; Read RTC register
    ld a, [rRTCRW]
    ld b, a

    ; Use RTC days high register
    ld a, RTC_DH
    ld [rRTCSEL], a

    ; Read RTC register
    ld a, [rRTCRW]

    ; Must be all zeroed
    cp $00
    jp nz, TestFail

    ld b, a
    cp $00
    jp nz, TestFail

    ld c, a
    cp $00
    jp nz, TestFail

    ld d, a
    cp $00
    jp nz, TestFail

    ld e, a
    cp $00
    jp nz, TestFail

    jp TestSuccess
