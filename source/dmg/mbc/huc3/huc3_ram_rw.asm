;! MBC_TYPE=254
;! RAM_SIZE=3

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Check that RAM Read/Write mode works.

EntryPoint:
    ; Enable RAM R/W
    ld a, RAMRW
    ld [rMAP], a

    ld a, $66
    ld [$A000], a

    ld a, [$A000]
    cp $66

    jp nz, TestFail
    jp TestSuccess
