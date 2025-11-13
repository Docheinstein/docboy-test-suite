CartridgeType $0254
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Check that HuC3 ticks and tests several HuC3 commands.
; Note: the test lasts 1 minute!

EntryPoint:
    ; Wait 70 frames (> 1 second)
    REPT 70
        Wait 154 * 114
    ENDR

    ; Enable VBlank interrupt
    xor a
    ldh [rIF], a

    ld a, $01
    ldh [rIE], a

    ; Scratchpad <= Clock
    HuC3_RtcExecuteCommand $60

    ; Read Mem[0]
    HuC3_RtcReadMemory $00
    ld hl, $ff80
    ld [hl], a

    ; Wait 60 seconds
    ld hl, 60 * 60

WaitFrame:
    ei
    halt
    dec hl
    ld a, l
    cp $00
    jp nz, WaitFrame
    ld a, h
    cp $00
    jp nz, WaitFrame

    ; Scratchpad <= Clock
    HuC3_RtcExecuteCommand $60

    ; Read Mem[0]
    HuC3_RtcReadMemory $00
    ld b, a

    ; New value should be increased by 1 minute compared to the old one
    ld hl, $ff80
    ld a, [hl]
    cp b

    jp z, TestFail
    jp TestSuccess

SECTION "VBlank handler", ROM0[$40]
    reti


