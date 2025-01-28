INCLUDE "all.inc"

; STAT interrupt request (due to a transition from HBLANK to OAM mode) should
; clear the internal edge detector, therefore LYC_EQ_LY set for the very next
; line should be triggered.

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

    ; Enable HBLANK and LYC_EQ_LY interrupt.
    ; This should set IF's STAT flag because we are in HBLANK.
    ld a, STATF_MODE00 | STATF_LYC
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

    ; Wait for next line so that LYC=LY
    ; The STAT interrupt should raised because the internal edge detector has been cleared.

    ld hl, TestSuccess

    Nops 20

    jp TestFail

SECTION "STAT handler", ROM0[$48]
    jp hl