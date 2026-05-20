CartridgeType $0254
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Check that RAM Read Only mode works.

EntryPoint:
    ; Disable RAM R/W
    ld a, HUC3_RAM_RO
    ld [rHUC3_MAP], a

    ld a, [$A000]
    ld b, a

    ; Write should fail
    ld a, $66
    ld [$A000], a

    ld a, [$A000]
    cp b

    jp nz, TestFail
    jp TestSuccess
