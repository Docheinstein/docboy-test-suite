INCLUDE "all.inc"

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

	EnablePPU

    ; Skip the first scanline
    Nops 103

	Nops 3
	
    ; Write to OAM
    Nops 1
    ld a, b
    ld hl, $fe5f
    ld [hli], a

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
db $00, $02, $0c, $0e, $30, $32, $3c, $3e
db $00, $82, $0c, $8e, $30, $b2, $3c, $be
db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $01, $83, $0d, $8f, $31, $b3, $3d, $bf

db $00, $02, $0c, $0e, $30, $32, $3c, $3e
db $00, $82, $0c, $8e, $30, $b2, $3c, $be
db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $01, $83, $0d, $8f, $31, $b3, $3d, $bf

db $00, $02, $0c, $0e, $30, $32, $3c, $3e
db $00, $82, $0c, $8e, $30, $b2, $3c, $be
db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $01, $83, $0d, $8f, $31, $b3, $3d, $bf

db $00, $02, $0c, $0e, $30, $32, $3c, $3e
db $00, $82, $0c, $8e, $30, $b2, $3c, $be
db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $01, $83, $0d, $8f, $31, $b3, $3d, $bf

db $00, $82, $0c, $8e, $30, $b2, $3c, $be
db $c0, $c2, $cc, $ce, $f0, $f2, $fc, $fe
db $01, $83, $0d, $8f, $31, $b3, $3d, $bf
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff

db $00, $82, $0c, $8e, $30, $b2, $3c, $be
db $c0, $c2, $cc, $ce, $f0, $f2, $fc, $fe
db $01, $83, $0d, $8f, $31, $b3, $3d, $bf
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff

db $00, $82, $0c, $8e, $30, $b2, $3c, $be
db $c0, $c2, $cc, $ce, $f0, $f2, $fc, $fe
db $01, $83, $0d, $8f, $31, $b3, $3d, $bf
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff

db $00, $82, $0c, $8e, $30, $b2, $3c, $be
db $c0, $c2, $cc, $ce, $f0, $f2, $fc, $fe
db $01, $83, $0d, $8f, $31, $b3, $3d, $bf
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff

db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff

db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff

db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff

db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $01, $03, $0d, $0f, $31, $33, $3d, $3f
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff

db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff

db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff

db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff

db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff
db $41, $c3, $4d, $cf, $71, $f3, $7d, $ff
db $c1, $c3, $cd, $cf, $f1, $f3, $fd, $ff
ExpectedDataEnd: