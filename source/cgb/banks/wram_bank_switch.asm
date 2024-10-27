INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check that WRAM SVBK can be used to switch between 8 different WRAM banks.

MACRO WriteWRAM
    ; Switch WRAM bank
    ld a, \1
    ldh [rSVBK], a

    ; Write
    ld a, \2
    ld hl, $D000
    ld [hl], a
ENDM

MACRO ExpectWRAM
    ; Switch WRAM bank
    ld a, \1
    ldh [rSVBK], a

    ; Read
    ld hl, $D000
    ld a, [hl]
    ld b, a

    ld a, \2
    cp b

    jp nz, TestFailCGB
ENDM

EntryPoint:
    WriteWRAM $00, $11
    WriteWRAM $01, $22
    WriteWRAM $02, $33
    WriteWRAM $03, $44
    WriteWRAM $04, $55
    WriteWRAM $05, $66
    WriteWRAM $06, $77
    WriteWRAM $07, $88

    ExpectWRAM $00, $22 ; }
                        ; } -> Maps to the same WRAM bank
    ExpectWRAM $01, $22 ; }
    ExpectWRAM $02, $33
    ExpectWRAM $03, $44
    ExpectWRAM $04, $55
    ExpectWRAM $05, $66
    ExpectWRAM $06, $77
    ExpectWRAM $07, $88

    jp TestSuccessCGB
