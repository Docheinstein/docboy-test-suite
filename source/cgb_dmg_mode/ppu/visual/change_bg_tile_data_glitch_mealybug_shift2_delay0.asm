; Variation of m3_lcdc_tile_sel_change to verify specific behaviour of changing LCDC[4] during pixel transfer.

; utils.asm

; Copyright (C) 2018 Matt Currie <me@mattcurrie.com>
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

SECTION "utils", ROMX, BANK[1]

; ///////////////////////
; //                   //
; //  File Attributes  //
; //                   //
; ///////////////////////

; Filename: old-skool-outline-thick.png
; Pixel Width: 256px
; Pixel Height: 32px

; /////////////////
; //             //
; //  Tile Data  //
; //             //
; /////////////////

oldskooloutlinethick_tile_data:
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $3C,$3C,$7E,$66,$FF,$C3,$FF,$81,$FF,$E7,$3C,$24,$3C,$24,$3C,$3C
DB $3C,$3C,$3C,$24,$3C,$24,$FF,$E7,$FF,$81,$FF,$C3,$7E,$66,$3C,$3C
DB $1C,$1C,$1E,$16,$FF,$F3,$FF,$81,$FF,$81,$FF,$F3,$1E,$16,$1C,$1C
DB $38,$38,$78,$68,$FF,$CF,$FF,$81,$FF,$81,$FF,$CF,$78,$68,$38,$38
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$6C,$6C,$8A,$8A,$AC,$AC,$AA,$AA,$6C,$6C,$00,$00
DB $00,$00,$00,$00,$60,$60,$80,$80,$80,$80,$80,$80,$60,$60,$00,$00
DB $00,$00,$00,$00,$4A,$4A,$AA,$AA,$AE,$AE,$AE,$AE,$4A,$4A,$00,$00
DB $00,$00,$00,$00,$8A,$8A,$8A,$8A,$8E,$8E,$82,$82,$E2,$E2,$00,$00
DB $00,$00,$00,$00,$35,$35,$45,$45,$25,$25,$15,$15,$67,$67,$00,$00
DB $00,$00,$00,$00,$66,$66,$55,$55,$66,$66,$44,$44,$44,$44,$00,$00
DB $00,$00,$00,$00,$26,$26,$55,$55,$56,$56,$55,$55,$25,$25,$00,$00
DB $00,$00,$00,$00,$73,$73,$24,$24,$22,$22,$21,$21,$26,$26,$00,$00
DB $00,$00,$00,$00,$03,$03,$04,$04,$02,$02,$01,$01,$06,$06,$00,$00
DB $00,$00,$00,$00,$25,$25,$55,$55,$75,$75,$55,$55,$52,$52,$00,$00
DB $00,$00,$00,$00,$70,$70,$40,$40,$60,$60,$40,$40,$70,$70,$00,$00
DB $00,$00,$00,$00,$37,$37,$42,$42,$22,$22,$12,$12,$62,$62,$00,$00
DB $00,$00,$00,$00,$27,$27,$52,$52,$72,$72,$52,$52,$52,$52,$00,$00
DB $00,$00,$00,$00,$73,$73,$44,$44,$62,$62,$41,$41,$76,$76,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $3C,$3C,$3C,$24,$3C,$24,$3C,$24,$3C,$3C,$3C,$24,$3C,$3C,$00,$00
DB $FE,$FE,$FE,$92,$FE,$92,$FE,$92,$FE,$FE,$00,$00,$00,$00,$00,$00
DB $7E,$7E,$FF,$CB,$FF,$81,$FF,$CB,$FF,$81,$FF,$CB,$7E,$7E,$00,$00
DB $FF,$E7,$FF,$81,$FF,$A7,$FF,$81,$FF,$E5,$FF,$81,$FF,$E7,$00,$00
DB $FF,$FF,$FF,$99,$FF,$93,$FF,$E7,$FF,$C9,$FF,$99,$FF,$FF,$00,$00
DB $7C,$7C,$FE,$C6,$FF,$93,$FF,$C5,$FF,$93,$FF,$C9,$7F,$7F,$00,$00
DB $3C,$3C,$3C,$24,$3C,$24,$3C,$24,$3C,$3C,$00,$00,$00,$00,$00,$00
DB $3C,$3C,$7C,$64,$7C,$4C,$78,$48,$7C,$4C,$7C,$64,$3C,$3C,$00,$00
DB $78,$78,$7C,$4C,$7C,$64,$3C,$24,$7C,$64,$7C,$4C,$78,$78,$00,$00
DB $FE,$FE,$FE,$AA,$FE,$C6,$FE,$82,$FE,$C6,$FE,$AA,$FE,$FE,$00,$00
DB $3C,$3C,$3C,$24,$FF,$E7,$FF,$81,$FF,$E7,$3C,$24,$3C,$3C,$00,$00
DB $00,$00,$00,$00,$00,$00,$3C,$3C,$7C,$64,$7C,$4C,$78,$78,$00,$00
DB $00,$00,$00,$00,$7E,$7E,$7E,$42,$7E,$7E,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$78,$78,$78,$48,$78,$48,$78,$78,$00,$00
DB $1E,$1E,$3E,$32,$7E,$62,$FE,$C6,$FC,$8C,$F8,$98,$F0,$F0,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$91,$FF,$89,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $7C,$7C,$7C,$44,$7C,$64,$3C,$24,$3C,$24,$3C,$24,$3C,$3C,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$91,$FF,$F3,$FF,$E7,$FF,$81,$FF,$FF,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$F1,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $FE,$FE,$FE,$92,$FE,$92,$FE,$82,$FE,$F2,$1E,$12,$1E,$1E,$00,$00
DB $FE,$FE,$FE,$82,$FE,$9E,$FF,$83,$FF,$F9,$FF,$83,$FE,$FE,$00,$00
DB $7E,$7E,$FE,$C2,$FE,$9E,$FF,$83,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $FF,$FF,$FF,$81,$FF,$F9,$0F,$09,$0F,$09,$0F,$09,$0F,$0F,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$C3,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $7F,$7F,$FF,$C1,$FF,$99,$FF,$C1,$7F,$79,$0F,$09,$0F,$0F,$00,$00
DB $3C,$3C,$3C,$24,$3C,$24,$3C,$3C,$3C,$24,$3C,$24,$3C,$3C,$00,$00
DB $3C,$3C,$3C,$24,$3C,$24,$3C,$3C,$7C,$64,$7C,$4C,$78,$78,$00,$00
DB $1F,$1F,$7F,$71,$FF,$C7,$FC,$9C,$FF,$C7,$7F,$71,$1F,$1F,$00,$00
DB $00,$00,$FF,$FF,$FF,$81,$FF,$FF,$FF,$81,$FF,$FF,$00,$00,$00,$00
DB $F8,$F8,$FE,$8E,$FF,$E3,$3F,$39,$FF,$E3,$FE,$8E,$F8,$F8,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$F9,$7F,$63,$3E,$3E,$3C,$24,$3C,$3C
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$93,$FF,$9F,$FF,$C1,$7F,$7F,$00,$00
DB $3C,$3C,$7E,$66,$7E,$42,$FF,$DB,$FF,$81,$FF,$99,$FF,$FF,$00,$00
DB $FE,$FE,$FF,$83,$FF,$99,$FF,$83,$FF,$99,$FF,$83,$FE,$FE,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$9F,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $FE,$FE,$FF,$83,$FF,$99,$FF,$99,$FF,$99,$FF,$83,$FE,$FE,$00,$00
DB $FF,$FF,$FF,$81,$FF,$9F,$FE,$82,$FF,$9F,$FF,$81,$FF,$FF,$00,$00
DB $FF,$FF,$FF,$81,$FF,$9F,$FE,$82,$FE,$9E,$F0,$90,$F0,$F0,$00,$00
DB $7E,$7E,$FE,$C2,$FF,$9F,$FF,$91,$FF,$99,$FF,$C1,$7F,$7F,$00,$00
DB $FF,$FF,$FF,$99,$FF,$99,$FF,$81,$FF,$99,$FF,$99,$FF,$FF,$00,$00
DB $7E,$7E,$7E,$42,$7E,$66,$3C,$24,$7E,$66,$7E,$42,$7E,$7E,$00,$00
DB $FF,$FF,$FF,$81,$FF,$E7,$3C,$24,$FC,$E4,$FC,$84,$FC,$FC,$00,$00
DB $FF,$FF,$FF,$99,$FF,$93,$FE,$86,$FF,$93,$FF,$99,$FF,$FF,$00,$00
DB $F0,$F0,$F0,$90,$F0,$90,$F0,$90,$FF,$9F,$FF,$81,$FF,$FF,$00,$00
DB $F7,$F7,$FF,$9D,$FF,$89,$FF,$95,$FF,$95,$FF,$95,$FF,$FF,$00,$00
DB $FF,$FF,$FF,$99,$FF,$89,$FF,$81,$FF,$91,$FF,$99,$FF,$FF,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$99,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $FE,$FE,$FF,$83,$FF,$99,$FF,$83,$FE,$9E,$F0,$90,$F0,$F0,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$99,$FF,$91,$FF,$C3,$7E,$7E,$00,$00
DB $FE,$FE,$FF,$83,$FF,$99,$FF,$83,$FF,$97,$FF,$99,$FF,$FF,$00,$00
DB $7F,$7F,$FF,$C1,$FF,$9F,$FF,$C3,$FF,$F9,$FF,$83,$FE,$FE,$00,$00
DB $FF,$FF,$FF,$81,$FF,$E7,$3C,$24,$3C,$24,$3C,$24,$3C,$3C,$00,$00
DB $FF,$FF,$FF,$99,$FF,$99,$FF,$99,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $FF,$FF,$FF,$99,$FF,$99,$FF,$C3,$7E,$42,$7E,$66,$3C,$3C,$00,$00
DB $FF,$FF,$FF,$9D,$FF,$9D,$FF,$95,$FF,$95,$FF,$C3,$7E,$7E,$00,$00
DB $FF,$FF,$FF,$99,$FF,$C3,$7E,$66,$FF,$C3,$FF,$99,$EF,$EF,$00,$00
DB $FF,$FF,$FF,$99,$FF,$99,$FF,$C3,$7E,$66,$3C,$24,$3C,$3C,$00,$00
DB $FF,$FF,$FF,$81,$FF,$F3,$7E,$66,$FF,$CF,$FF,$81,$FF,$FF,$00,$00
DB $7E,$7E,$7E,$42,$7E,$72,$1E,$12,$7E,$72,$7E,$42,$7E,$7E,$00,$00
DB $F0,$F0,$F8,$98,$FC,$8C,$FE,$C6,$7E,$62,$3E,$32,$1E,$1E,$00,$00
DB $7E,$7E,$7E,$42,$7E,$4E,$78,$48,$7E,$4E,$7E,$42,$7E,$7E,$00,$00
DB $3C,$3C,$7E,$66,$FF,$C3,$FF,$99,$FF,$FF,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$81,$FF,$FF,$00,$00
DB $78,$78,$7C,$4C,$7C,$44,$7C,$64,$3C,$3C,$00,$00,$00,$00,$00,$00
DB $3C,$3C,$7E,$66,$7E,$42,$FF,$DB,$FF,$81,$FF,$99,$FF,$FF,$00,$00
DB $FE,$FE,$FF,$83,$FF,$99,$FF,$83,$FF,$99,$FF,$83,$FE,$FE,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$9F,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $FE,$FE,$FF,$83,$FF,$99,$FF,$99,$FF,$99,$FF,$83,$FE,$FE,$00,$00
DB $FF,$FF,$FF,$81,$FF,$9F,$FE,$82,$FF,$9F,$FF,$81,$FF,$FF,$00,$00
DB $FF,$FF,$FF,$81,$FF,$9F,$FE,$82,$FE,$9E,$F0,$90,$F0,$F0,$00,$00
DB $7E,$7E,$FE,$C2,$FF,$9F,$FF,$91,$FF,$99,$FF,$C1,$7F,$7F,$00,$00
DB $FF,$FF,$FF,$99,$FF,$99,$FF,$81,$FF,$99,$FF,$99,$FF,$FF,$00,$00
DB $7E,$7E,$7E,$42,$7E,$66,$3C,$24,$7E,$66,$7E,$42,$7E,$7E,$00,$00
DB $FF,$FF,$FF,$81,$FF,$E7,$3C,$24,$FC,$E4,$FC,$84,$FC,$FC,$00,$00
DB $FF,$FF,$FF,$99,$FF,$93,$FE,$86,$FF,$93,$FF,$99,$FF,$FF,$00,$00
DB $F0,$F0,$F0,$90,$F0,$90,$F0,$90,$FF,$9F,$FF,$81,$FF,$FF,$00,$00
DB $F7,$F7,$FF,$9D,$FF,$89,$FF,$95,$FF,$95,$FF,$95,$FF,$FF,$00,$00
DB $FF,$FF,$FF,$99,$FF,$89,$FF,$81,$FF,$91,$FF,$99,$FF,$FF,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$99,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $FE,$FE,$FF,$83,$FF,$99,$FF,$83,$FE,$9E,$F0,$90,$F0,$F0,$00,$00
DB $7E,$7E,$FF,$C3,$FF,$99,$FF,$99,$FF,$91,$FF,$C3,$7E,$7E,$00,$00
DB $FE,$FE,$FF,$83,$FF,$99,$FF,$83,$FF,$97,$FF,$99,$FF,$FF,$00,$00
DB $7F,$7F,$FF,$C1,$FF,$9F,$FF,$C3,$FF,$F9,$FF,$83,$FE,$FE,$00,$00
DB $FF,$FF,$FF,$81,$FF,$E7,$3C,$24,$3C,$24,$3C,$24,$3C,$3C,$00,$00
DB $FF,$FF,$FF,$99,$FF,$99,$FF,$99,$FF,$99,$FF,$C3,$7E,$7E,$00,$00
DB $FF,$FF,$FF,$99,$FF,$99,$FF,$C3,$7E,$42,$7E,$66,$3C,$3C,$00,$00
DB $FF,$FF,$FF,$9D,$FF,$9D,$FF,$95,$FF,$95,$FF,$C3,$7E,$7E,$00,$00
DB $FF,$FF,$FF,$99,$FF,$C3,$7E,$66,$FF,$C3,$FF,$99,$EF,$EF,$00,$00
DB $FF,$FF,$FF,$99,$FF,$99,$FF,$C3,$7E,$66,$3C,$24,$3C,$3C,$00,$00
DB $FF,$FF,$FF,$81,$FF,$F3,$7E,$66,$FF,$CF,$FF,$81,$FF,$FF,$00,$00
DB $7C,$7C,$7E,$46,$7F,$73,$1F,$19,$7F,$73,$7E,$46,$7C,$7C,$00,$00
DB $3C,$3C,$3C,$24,$3C,$24,$3C,$24,$3C,$24,$3C,$24,$3C,$3C,$00,$00
DB $3E,$3E,$7E,$62,$FE,$CE,$F8,$98,$FE,$CE,$7E,$62,$3E,$3E,$00,$00
DB $7F,$7F,$FF,$C9,$FF,$93,$FE,$FE,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


wait_vblank::
    ldh a, [rLY]
    cp $90
    jr nz, wait_vblank

    ret


reset_oam::
    ld hl, $fe00
    ld a, $ff
    ld c, 160

.loop:
    ld [hl+], a
    dec c
    jr nz, .loop

    ret


reset_registers::
    call wait_vblank

    xor a
    ldh [rLCDC], a
    ldh [rIF], a
    ldh [rSCX], a
    ldh [rSCY], a

    ; position the window off screen
    ld a, 150
    ldh [rWY], a

    ret


reset_vram::
    ld hl, $9800
    xor a

.loop:
    ld [hl+], a
    bit 2, h       ; bit 2 will be set when value of h register is $9c
    jr z, .loop

    ret


oam_copy::
    ld de, $fe00

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .loop

    ret


copy_font::
    ld hl, oldskooloutlinethick_tile_data
    ld de, $8000

.loop:
    ld a, [hl+]
    ld [de], a
    inc de

    bit 3, d     ; bit 3 will be set when value of d register is $88
    jr z, .loop

    ret


fill_vram_9800::
    ld hl, $9800

.loop:
    ld [hl+], a
    bit 2, h       ; bit 2 will be set when value of h register is $9c
    jr z, .loop

    ret


fill_vram_9c00::
    ld hl, $9c00

.loop:
    ld [hl+], a
    bit 5, h       ; bit 5 will be set when value of h register is $a0
    jr z, .loop

    ret


fill_vram_8000::
    ld hl, $8000

.loop:
    ld [hl+], a
    bit 5, h       ; bit 5 will be set when value of h register is $90
    jr z, .loop

    ret


reset_tile_maps::
    ; select vram bank 1
    ld a, 1
    ldh [rVBK], a

    ; set palette 0 by default
    ld a, 0
    call fill_vram_9800
    call fill_vram_9c00

    ; select vram bank 0
    xor a
    ldh [rVBK], a

    ; background defaults to " "
    ld a, " "
    call fill_vram_9800
    call fill_vram_9c00
    ret


; Input:
;   A = value
;   HL = destination
;   BC = length in bytes
; Preserved:
;   none
memset::
    ld e, a
.loop:
    ld a, e
    ld [hl+], a
    dec bc
    ld a, b
    cp c
    jr nz, .loop
    ret


; Input:
;   HL = source
;   DE = destination
;   BC = length in bytes
; Preserved:
;   none
memcpy::
.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret


; line 0 timing is different by 4 cycles, so jump only
; when on line 0
; 24 cycles (or 28 cycles when LY = 0)
MACRO line_0_fix
    ldh a, [rLY]
    and a
    jr nz, .target\@
.target\@
    ENDM


; Output specified number of nops
; @param \1 Number of nops to output
MACRO nops
    REPT \1
    nop
    ENDR
    ENDM


MACRO cgb_mode
    SECTION "cgb-mode", ROM0[$143]
        db $80
    ENDM


switch_speed:
    xor a
    ldh [rIE], a
    ld a, $30
    ldh [rP1], a
    ld a, $01
    ldh [rKEY1], a
    stop
    ret


; Delay for a specified number of M-cycles
; @param \1 Number of M-cycles to wait for
MACRO delay
DELAY = (\1)

IF DELAY >= 100000
    REPT DELAY / 100000
    call Delay100000MCycles
    ENDR
DELAY = DELAY % 100000
ENDC

IF DELAY >= 10000
    call Delay10000MCycles - (3 * ((DELAY / 10000) - 1))
DELAY = DELAY % 10000
ENDC

IF DELAY >= 1000
    call Delay1000MCycles - (3 * ((DELAY / 1000) - 1))
DELAY = DELAY % 1000
ENDC

IF DELAY >= 100
    call Delay100MCycles - (3 * ((DELAY / 100) - 1))
DELAY = DELAY % 100
ENDC

IF DELAY >= 10
    call Delay10MCycles - (3 * ((DELAY / 10) - 1))
DELAY = DELAY % 10
ENDC

IF DELAY > 0
    nops DELAY
ENDC
    ENDM


Delay100000MCycles::
    call Delay10000MCycles
Delay90000MCycles::
    call Delay10000MCycles
Delay80000MCycles::
    call Delay10000MCycles
Delay70000MCycles::
    call Delay10000MCycles
Delay60000MCycles::
    call Delay10000MCycles
Delay50000MCycles::
    call Delay10000MCycles
Delay40000MCycles::
    call Delay10000MCycles
Delay30000MCycles::
    call Delay10000MCycles
Delay20000MCycles::
    call Delay10000MCycles

Delay10000MCycles::
    call Delay1000MCycles
Delay9000MCycles::
    call Delay1000MCycles
Delay8000MCycles::
    call Delay1000MCycles
Delay7000MCycles::
    call Delay1000MCycles
Delay6000MCycles::
    call Delay1000MCycles
Delay5000MCycles::
    call Delay1000MCycles
Delay4000MCycles::
    call Delay1000MCycles
Delay3000MCycles::
    call Delay1000MCycles
Delay2000MCycles::
    call Delay1000MCycles

Delay1000MCycles::
    call Delay100MCycles
Delay900MCycles::
    call Delay100MCycles
Delay800MCycles::
    call Delay100MCycles
Delay700MCycles::
    call Delay100MCycles
Delay600MCycles::
    call Delay100MCycles
Delay500MCycles::
    call Delay100MCycles
Delay400MCycles::
    call Delay100MCycles
Delay300MCycles::
    call Delay100MCycles
Delay200MCycles::
    call Delay100MCycles

Delay100MCycles::
    call Delay10MCycles
Delay90MCycles::
    call Delay10MCycles
Delay80MCycles::
    call Delay10MCycles
Delay70MCycles::
    call Delay10MCycles
Delay60MCycles::
    call Delay10MCycles
Delay50MCycles::
    call Delay10MCycles
Delay40MCycles::
    call Delay10MCycles
Delay30MCycles::
    call Delay10MCycles
Delay20MCycles::
    call Delay10MCycles

Delay10MCycles::
    ret


MACRO rgb_low_byte
    db low(\1 + (\2 << 5) + \3 << 10)
    ENDM


MACRO rgb_high_byte
    db high(\1 + (\2 << 5) + \3 << 10)
    ENDM


MACRO cgb_color
    rgb_low_byte \1, \2, \3
    rgb_high_byte \1, \2, \3
    ENDM


copy_obj_color_palette_data::
    ld c, low(rOCPD)
    jr copy_bg_color_palette_data.loop

copy_bg_color_palette_data::
    ld c, low(rBCPD)
.loop:
    ld a, [hl+]
    ld [c], a
    dec b
    jr nz, .loop
    ret


; Copyright (C) 2018 Matt Currie <me@mattcurrie.com>
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

; Sets and resets bit 4 (TILE_SEL) of LCDC register during mode 3 with sprites
; at different X coordinates
; Initiated by STAT mode 2 LCDC interrupt in a field of NOPs.


INCLUDE "hardware.inc"

SECTION "wram", WRAM0

counter::
    ds 1


SECTION "vblank", ROM0[$40]

    jp vblank_handler     


SECTION "lcdc", ROM0[$48]

    jp lcdc_handler     


SECTION "boot", ROM0[$100]

    nop                                       
    jp main                          


SECTION "main", ROM0[$150]

main::

    di
    ld sp, $fffe

    xor a
    ld [counter], a

    call reset_registers
    call reset_oam

    ; select mode 2 lcdc interrupt
    ld a, $20
    ldh [rSTAT], a

    ; enable vblank and lcdc interrupts
    ld a, $03
    ldh [rIE], a

    ; map at $9800 is filled with 0
    ld a, $0
    call fill_vram_9800

    ; map at $9c00 is filled with 0
    ld a, $0
    call fill_vram_9c00

    ; white tile at index 0
    xor a
    ld c, 16
    ld hl, $9000
.tile_loop:
    ld [hl+], a
    dec c
    jr nz, .tile_loop

    ; black tile at index 0
    ld a, $ff
    ld c, 16
    ld hl, $8000
.tile_loop2:
    ld [hl+], a
    dec c
    jr nz, .tile_loop2

    ; use the (r) logo as a sprite
    ld hl, sprite_data 
    ld c, 76 ; 19 sprites * 4
    call oam_copy

    ; turn the screen on, $9800-$9BFF window tile map, window off, bg tile data $8800-$97FF, 
    ; bg tile map $9800-$9BFF, obj size 8*8, obj display on, bg display on
    ld b, $83

    ; c has the same value, but with bit 4 set
    ld c, b
    set 4, c

    ld a, $ff
    ldh [rOBP0], a

    ld a, $e4
    ldh [rBGP], a

    ; load hl with address of LCDC register
    ld hl, rLCDC

    ; set initial value
    ld [hl], b

    ; enable interrupts
    ei


nop_slide:
    REPT 1200
    nop
    ENDR


vblank_handler::

    ; let it run for 10 frames
    ld a, [counter]
    inc a

    cp 10
    jp nz, .continue

    ; source code breakpoint - good time to take a screenshot to compare
    ld b,b

.continue:

    ld [counter], a
    reti


lcdc_handler::
    ; 20 cycles interrupt dispatch + 12 cycles to jump here: 32

    line_0_fix 


    REPT 9
    nop
    ENDR    

    ; set the new value: 8 cycles
    ld [hl], c

    ; restore old value
    ld [hl], b

    ; reset the return address to the top of the nops loop
    pop de
    ld de, nop_slide
    push de

    reti


sprite_data::
DEF SHIFT_BY EQU 2

    DB $10, SHIFT_BY + 00, $19, 0
    DB $18, SHIFT_BY + 01, $19, 0
    DB $20, SHIFT_BY + 02, $19, 0
    DB $28, SHIFT_BY + 03, $19, 0
    DB $30, SHIFT_BY + 04, $19, 0
    DB $38, SHIFT_BY + 05, $19, 0
    DB $40, SHIFT_BY + 06, $19, 0
    DB $48, SHIFT_BY + 07, $19, 0
    DB $50, SHIFT_BY + 08, $19, 0
    DB $58, SHIFT_BY + 09, $19, 0
    DB $60, SHIFT_BY + 10, $19, 0
    DB $68, SHIFT_BY + 11, $19, 0
    DB $70, SHIFT_BY + 12, $19, 0
    DB $78, SHIFT_BY + 13, $19, 0
    DB $80, SHIFT_BY + 14, $19, 0
    DB $88, SHIFT_BY + 15, $19, 0
    DB $90, SHIFT_BY + 16, $19, 0
    DB $98, SHIFT_BY + 17, $19, 0


