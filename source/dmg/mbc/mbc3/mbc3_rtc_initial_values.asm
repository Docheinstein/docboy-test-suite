CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Check the initial values of RTC latch before any reload.

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rMBC3_RTC_EN], a

    ; Use RTC seconds register
    ld a, MBC3_RTC_S
    ld [rMBC3_RTC_SEL], a

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]
    ld e, a

    ; Use RTC minutes register
    ld a, MBC3_RTC_M
    ld [rMBC3_RTC_SEL], a

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]
    ld d, a

    ; Use RTC hours register
    ld a, MBC3_RTC_H
    ld [rMBC3_RTC_SEL], a

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]
    ld c, a

    ; Use RTC days low register
    ld a, MBC3_RTC_DL
    ld [rMBC3_RTC_SEL], a

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]
    ld b, a

    ; Use RTC days high register
    ld a, MBC3_RTC_DH
    ld [rMBC3_RTC_SEL], a

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]

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
