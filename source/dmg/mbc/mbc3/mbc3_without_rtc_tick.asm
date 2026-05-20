CartridgeType $13
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; RTC shouldn't work for MBC3 type without RTC.
; Note: does not pass on my Everdrive x7: probably it does not honor the cartridge and always enables the RTC instead.

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

    ; Reload latch with 0 -> 1
    xor a
    ld [rMBC3_RTC_LATCH], a
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    ; Wait a bit after reload
    Wait 4

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]
    ld c, a

    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Reload latch with 0 -> 1
    xor a
    ld [rMBC3_RTC_LATCH], a
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    ; Wait a bit after reload
    Wait 4

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]
    cp c

    jp nz, TestFail
    jp TestSuccess
