CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Check whether writing 0 -> 1 to RTC latch register actually copies RTC registers.

EntryPoint:
    ; Enable RTC
    ld a, $0a
    ld [rMBC3_RTC_EN], a

    ; Enable RTC tick
    ld a, MBC3_RTC_DH
    ld [rMBC3_RTC_SEL], a
    xor a
    ld [rMBC3_RTC_RW], a

    ; Set latch to 0
    xor a
    ld [rMBC3_RTC_LATCH], a

    ; Use RTC seconds register
    ld a, MBC3_RTC_S
    ld [rMBC3_RTC_SEL], a

    ; Read RTC register (without reloading)
    ld a, [rMBC3_RTC_RW]
    ld h, a

    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Set latch to 0 -> 1
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    Wait 4

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]
    ld l, a

    ; There's a 1/60 change we've been unlikely, do another attempt just in case
    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]

    cp l
    jp nz, TestSuccess

    cp h
    jp nz, TestSuccess

    jp TestFail
