INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the OAM corruption pattern for a specific combination of instruction and CPU/PPU timing.

MACRO StoreSP
    ld [$ffa0], sp
ENDM

MACRO RestoreSP
    ld hl, $ffa0
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld h, a
    ld l, b
    ld sp, hl
ENDM

; \1 mask
; \2 address
MACRO CompareWithMaskAndSet
    ld hl, \2

    ld a, b
    and \1

    jp nz, .set1\@
    ld a, $00
    jp .load\@

.set1\@
    ld a, $01
    jp .load\@

.load\@
    ld [hl], a
ENDM


MACRO PopShiftAdd
    pop bc

    ld a, b
    and $01

REPT \1
    sla a
ENDR
    ld b, a

    ld a, d
    add a, b

    ld d, a
ENDM

DoTest:
    StoreSP

    ld sp, $d800

    DisablePPU

    ; Set OAM memory based on iteration number
    ld hl, $d000
    ld b, [hl]

    CompareWithMaskAndSet $80, $fe00
    CompareWithMaskAndSet $80, $fe01
    CompareWithMaskAndSet $40, $fe02
    CompareWithMaskAndSet $40, $fe03
    CompareWithMaskAndSet $20, $fe04
    CompareWithMaskAndSet $20, $fe05
    CompareWithMaskAndSet $10, $fe06
    CompareWithMaskAndSet $10, $fe07
    CompareWithMaskAndSet $08, $fe58
    CompareWithMaskAndSet $08, $fe59
    CompareWithMaskAndSet $04, $fe5a
    CompareWithMaskAndSet $04, $fe5b
    CompareWithMaskAndSet $02, $fe5c
    CompareWithMaskAndSet $02, $fe5d
    CompareWithMaskAndSet $01, $fe5e
    CompareWithMaskAndSet $01, $fe5f

    ; Load value that will be written to OAM
    ld hl, $d002
    ld b, [hl]

	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    ; Skip the first scanline
    Nops 103

	Nops 3
	
    ; Write to OAM
    Nops 2
    ld hl, $fe58
    ld [hl], b

    ; Disable PPU to read OAM safely
    DisablePPU

    ; Read result
    ld hl, $fe00

REPT 8
    ld a, [hli]
    push af
ENDR

    ld d, $00

    PopShiftAdd 0
    PopShiftAdd 1
    PopShiftAdd 2
    PopShiftAdd 3
    PopShiftAdd 4
    PopShiftAdd 5
    PopShiftAdd 6
    PopShiftAdd 7

    ; Store result for this iteration:
    ; 1. Read current iteration
    ld hl, $d000
    ld c, [hl]

    ld hl, $d002
    ld b, [hl]

    ; 2. Store result at $d100 + iteration number
    ld hl, $d100
    add hl, bc

    ; 3. Store result
    ld [hl], d

    RestoreSP

    ret

EntryPoint:
    ; Reset work data
    Memset $d000, $00, $800

    ; Reset OAM
    Memset $fe00, $00, 160

LoopZero:
    ; Load iteration number
    ld hl, $d000
    ld a, [hl]

    call DoTest

    ; Load iteration number
    ld hl, $d000
    ld a, [hl]

    ; Increase iteration number
    inc a

    cp $00
    jp z, TestOne

    ld [hl], a
    jp LoopZero

TestOne:
    ; Reset iteration number
    ld hl, $d000
    xor a
    ld [hl], a

    ; Set value that will be written to OAM to 1
    ld hl, $d002
    ld a, $01
    ld [hl], a

LoopOne:
    ; Load iteration number
    ld hl, $d000
    ld a, [hl]

    call DoTest

    ; Load iteration number
    ld hl, $d000
    ld a, [hl]

    ; Increase iteration number
    inc a

    cp $00
    jp z, TestEnd

    ld [hl], a
    jp LoopOne

TestEnd:
    ; Disable PPU to read OAM safely
    DisablePPU

    ; Compare OAM
    Memcmp $d100, ExpectedData, ExpectedDataEnd - ExpectedData

    jp nz, TestFail
    jp TestSuccess


ExpectedData:
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f

db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f

db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f

db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f

db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f

db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f

db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f

db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f
db $00, $03, $0c, $0f, $30, $33, $3c, $3f
db $40, $43, $4c, $4f, $70, $73, $7c, $7f

db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff

db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff

db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff

db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff

db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff

db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff

db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff

db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
db $80, $83, $8c, $8f, $b0, $b3, $bc, $bf
db $c0, $c3, $cc, $cf, $f0, $f3, $fc, $ff
ExpectedDataEnd: