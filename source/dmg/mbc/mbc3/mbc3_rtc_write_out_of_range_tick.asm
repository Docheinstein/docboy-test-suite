CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Write an out of range value to RTC register that would reach 60 if incremented by tick.
; It should be overflow and restart from 0.

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

    ; Write an out of range value that reaches 60 if incremented by one.
    ld a, $7b
    ld [rMBC3_RTC_RW], a

    ; Wait 60 frames (> 1 second)
    REPT 60
        Wait 154 * 114
    ENDR

    ; Reload latch with 0 -> 1
    xor a
    ld [rMBC3_RTC_LATCH], a
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    ; Wait a bit after reload
    Wait 4

    ; Read RTC register: it should read the same value
    ld a, [rMBC3_RTC_RW]
    cp $00

    jp nz, TestFail
    jp TestSuccess
