INCLUDE "docboy.inc"

; Check that if BGP is written and read, it yields the same result.

EntryPoint:
    DisablePPU

    SetBGP 0, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 1, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 2, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 3, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 4, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 5, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 6, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 7, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    CheckBGP 0, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 1, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 2, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 3, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 4, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 5, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 6, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 7, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    SetBGP 0, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 1, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 2, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 3, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 4, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 5, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 6, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 7, $00, $00, $00, $00, $00, $00, $00, $00,

    CheckBGP 0, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 1, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 2, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 3, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 4, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 5, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 6, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 7, $00, $00, $00, $00, $00, $00, $00, $00,

    jp TestSuccess