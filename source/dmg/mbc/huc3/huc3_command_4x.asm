;! MBC_TYPE=254
;! RAM_SIZE=3

INCLUDE "all.inc"
INCLUDE "mbc/huc3.inc"

; Command $4x sets the least significant nibble of the memory address.

EntryPoint:
    HuC3_SetMemoryAddressLow $2
    HuC3_RtcExecuteCommand $3B

    HuC3_RtcReadMemory $02
    cp $B

    jp nz, TestFail
    jp TestSuccess

