INCLUDE "all.inc"

; Check if STAT interrupt is raised for HBlank mode after turn on.

EntryPoint:
    ld a, STATF_MODE00
    ldh [rSTAT], a

    xor a
    ldh [rIF], a

    DisablePPU

    EnablePPU

    ; Read STAT
    ldh a, [rIF]

    ; Check result
    cp $e0
    jp nz, TestFail

    jp TestSuccess