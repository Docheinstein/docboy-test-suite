;! MBC_TYPE=254
;! RAM_SIZE=3

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Check that RAM Read Only mode works.

EntryPoint:
    ; Enable RAM R/W
    ld a, RAMRO
    ld [rMAP], a

    ld a, [$A000]
    ld b, a

    ; Write should fail
    ld a, $66
    ld [$A000], a

    ld a, [$A000]
    cp b

    jp nz, TestFail
    jp TestSuccess
