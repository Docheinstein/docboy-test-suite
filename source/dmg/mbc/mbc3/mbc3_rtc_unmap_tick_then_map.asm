CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Check whether RTC ticks even if RTC is unmapped.

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

    ; Disable RTC
    xor a
    ld [rMBC3_RTC_EN], a

    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Enable RTC
    ld a, $0a
    ld [rMBC3_RTC_EN], a

    ; Reload latch with 0 -> 1
    xor a
    ld [rMBC3_RTC_LATCH], a
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    ; Wait a bit after reload
    Wait 4

    ; Read RTC register back again
    ld a, [rMBC3_RTC_RW]

    ; Either is increased by one or by two
    inc c
    cp c
    jp z, TestSuccess

    inc c
    cp c
    jp z, TestSuccess

    ; Last chance: maybe overflow?
    cp $00
    jp z, TestSuccess

    cp $01
    jp z, TestSuccess

    ; Really failed
    jp TestFail
