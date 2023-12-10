INCLUDE "hardware.inc"
INCLUDE "common.inc"

; STAT interrupt request (due to a transition from HBLANK to OAM mode) should
; not be raised, if it's not a raising edge for the internal edge dector, moreover
; it should not clear the internal edge detector if it holds,
; therefore LYC_EQ_LY won't be raised for LY=1.
; Instead, the first interrupt that will be requested will be HBLANK for LY=2
; because the internal edge detector has been cleared by mode 3.

EntryPoint:
    ; Reset interrupts
    xor a
    ldh [rIF], a
    ldh [rIE], a

    ; Write LYC = 1
    ld a, $01
    ldh [rLYC], a

    ; Resume from TestContinue at first interrupt
    ld hl, TestContinue

    ; Wait HBLANK
    WaitMode 0

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBLANK, OAM and LYC_EQ_LY interrupt.
    ; This should set IF's STAT flag because we are in HBLANK.
    ld a, STATF_MODE00 | STATF_MODE10 | STATF_LYC
    ldh [rSTAT], a

    ; Enable interrupt: this should raise an interrupt
    ei

    Nops 2

TestContinue:
    ld hl, TestFail

    ; Enable interrupt
    ; (this should not raise an interrupt because has already been handled)
    ei

    Nops 2

    ; At this point we just wait for the next STAT interrupt:
    ; we should receive the interrupt coming from STAT's HBLANK at LY=2.
    ld hl, TestCheck

    Nops 190

    jp TestFail

TestCheck:
    ; Check that we are at HBLANK of LY=2
    ldh a, [rSTAT]
    ld b, a
    ld a, $e8
    cp b
    jp nz, TestFail

    ldh a, [rLY]
    ld b, a
    ld a, $02
    cp b
    jp nz, TestFail

    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    jp hl