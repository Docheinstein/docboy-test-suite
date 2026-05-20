CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Check whether RTC ticks while it is stopped.

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rMBC3_RTC_EN], a

    ; Disable RTC tick
    ld a, MBC3_RTC_DH
    ld [rMBC3_RTC_SEL], a
    ld a, $40
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

    ; Wait 140 frames (> 2 second)
    REPT 140
        Wait 154 * 114
    ENDR

    ; Reload latch with 0 -> 1
    xor a
    ld [rMBC3_RTC_LATCH], a
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    ; Wait a bit after reload
    Wait 4

    ; Read RTC register back again
    ld a, [rMBC3_RTC_RW]
    cp c

    jp z, TestSuccess

    ; Maybe it's incremented by 1?
    inc c
    cp c
    jp z, TestSuccess

    ; Really failed
    jp TestFail
