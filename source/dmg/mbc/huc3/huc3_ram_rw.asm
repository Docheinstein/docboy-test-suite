CartridgeType $0254
RamSize $03

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Check that RAM Read/Write mode works.

EntryPoint:
    ; Enable RAM R/W
    ld a, HUC3_RAM_RW
    ld [rHUC3_MAP], a

    ld a, $66
    ld [$A000], a

    ld a, [$A000]
    cp $66

    jp nz, TestFail
    jp TestSuccess
