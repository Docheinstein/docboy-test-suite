CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Write an out of range value to RTC register and read it back.

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rMBC3_RTC_EN], a

    ; Enable RTC tick
    ld a, MBC3_RTC_DH
    ld [rMBC3_RTC_SEL], a
    xor a
    ld [rMBC3_RTC_RW], a

    ; Use RTC seconds register
    ld a, MBC3_RTC_S
    ld [rMBC3_RTC_SEL], a

    ; Write an out of range value to RTC seconds
    ld a, $7e
    ld [rMBC3_RTC_RW], a

    ; Reload latch with 0 -> 1
    xor a
    ld [rMBC3_RTC_LATCH], a
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    ; Wait a bit after reload
    Wait 4

    ; Read RTC register: it should read only the used bits
    ld a, [rMBC3_RTC_RW]
    cp $3e

    jp z, TestSuccess
    jp TestFail
