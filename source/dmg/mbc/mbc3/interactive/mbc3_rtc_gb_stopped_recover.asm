CartridgeType $10
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/mbc3.inc"

; Check whether RTC ticks while the GameBoy is STOPped.

EntryPoint:
    ; React to Buttons
    ld a, $10
    ldh [rP1], a

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

    Wait 1048576 * 2 ; Wait 2 seconds

    ; Read RTC

    ; Reload latch with 0 -> 1
    xor a
    ld [rMBC3_RTC_LATCH], a
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    ; Wait a bit after reload
    Wait 4

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]

    ; Plus 2
    inc a
    inc a
    ld b, a

    ; Wait until RTC is ticked by 2 seconds

SyncPoint:
    ; Reload latch with 0 -> 1
    xor a
    ld [rMBC3_RTC_LATCH], a
    ld a, 1
    ld [rMBC3_RTC_LATCH], a

    ; Wait a bit after reload
    Wait 4

    ; Read RTC register
    ld a, [rMBC3_RTC_RW]
    cp b

    jp nz, SyncPoint

    ; >> Here we are "synched" with the RTC tick <<

    ; Wait for almost 1 second
    ; Wait 1048576 <-- 1 second
    ; Wait 1000000 ; <-- little bit less than 1 second

StopPoint:
    ; Stop
    stop
    nop

ResumePoint:
    ; Exit stop: play a button after a few seconds (emulator should simulate input)

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

    ; Read RTC register back again
    ld a, [rMBC3_RTC_RW]

    ; Seconds should have been increased and thus should differ
    cp b

    jp z, TestFail
    jp TestSuccess