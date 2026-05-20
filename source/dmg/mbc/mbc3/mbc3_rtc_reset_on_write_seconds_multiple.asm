CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Writing to seconds register should reset the internal counter: it should take exactly 1 second to tick again.

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

REPT 3
    ; Write RTC register
    ld a, $10
    ld [rMBC3_RTC_RW], a

    ; Wait less than 1 second
    REPT 50
        Wait 154 * 114
    ENDR
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
    cp $10

    jp nz, TestFail
    jp TestSuccess
