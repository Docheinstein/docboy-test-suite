IF !DEF(MBC7_INC)
DEF MBC7_INC EQU 1

include "mbc/mbc.inc"

DEF MBC7_RESET_ACCEL            EQU $55
DEF MBC7_LATCH_ACCEL            EQU $AA

DEF MBC7_RAM_SECONDARY_ON       EQU $40

DEF MBC7_EEPROM_DO              EQU %00000001
DEF MBC7_EEPROM_DI              EQU %00000010
DEF MBC7_EEPROM_CLK             EQU %01000000
DEF MBC7_EEPROM_CS              EQU %10000000

DEF rMBC7_RAM_PRIMARY           EQU $0000
DEF rMBC7_ROM_BANK              EQU $2000
DEF rMBC7_RAM_SECONDARY         EQU $4000

DEF rMBC7_ACCEL_RESET           EQU $A000
DEF rMBC7_ACCEL_LATCH           EQU $A010
DEF rMBC7_ACCEL_X_LOW           EQU $A020
DEF rMBC7_ACCEL_X_HIGH          EQU $A030
DEF rMBC7_ACCEL_Y_LOW           EQU $A040
DEF rMBC7_ACCEL_Y_HIGH          EQU $A050
DEF rMBC7_EEPROM                EQU $A080


MACRO Mbc7_EepromWrite
    ld hl, rMBC7_EEPROM
    ld [hl], \1
ENDM

MACRO Mbc7_EepromRead
    ld hl, rMBC7_EEPROM
    ld a, [hl]
    and MBC7_EEPROM_DO
ENDM

MACRO Mbc7_EepromReadShiftIntoRegister
    ld b, a
    sla b
    Mbc7_EepromRead
    or b
ENDM

MACRO Mbc7_EepromStartCommand
    Mbc7_EepromWrite $00
    Mbc7_EepromWrite MBC7_EEPROM_CS
    Mbc7_EepromWrite MBC7_EEPROM_CS | MBC7_EEPROM_CLK
    Mbc7_EepromWrite MBC7_EEPROM_CS | MBC7_EEPROM_DI
    Mbc7_EepromWrite MBC7_EEPROM_CS | MBC7_EEPROM_CLK | MBC7_EEPROM_DI
ENDM

MACRO Mbc7_EepromWriteHigh
    Mbc7_EepromWrite MBC7_EEPROM_CS
    Mbc7_EepromWrite MBC7_EEPROM_CS | MBC7_EEPROM_CLK | MBC7_EEPROM_DI
ENDM

MACRO Mbc7_EepromWriteLow
    Mbc7_EepromWrite MBC7_EEPROM_CS
    Mbc7_EepromWrite MBC7_EEPROM_CS | MBC7_EEPROM_CLK
ENDM

MACRO Mbc7_EepromWriteBit
    IF \1
        Mbc7_EepromWriteHigh
    ELSE
        Mbc7_EepromWriteLow
    ENDC
ENDM

MACRO Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromWrite MBC7_EEPROM_CS
    Mbc7_EepromWrite MBC7_EEPROM_CS | MBC7_EEPROM_CLK

    Mbc7_EepromReadShiftIntoRegister
ENDM

MACRO Mbc7_EepromWaitWriteCompletion
    ; Falling edge of CS initiate transfer
    Mbc7_EepromWrite $00

    ; Wait at least 250ns
    Nops 4

    ; Rising edge of CS enable using DO as write compltetion status
    Mbc7_EepromWrite MBC7_EEPROM_CS

    Mbc7_EepromWrite MBC7_EEPROM_CS | MBC7_EEPROM_CLK

.loop\@
    Mbc7_EepromRead
    cp MBC7_EEPROM_DO
    jp nz, .loop\@
ENDM

; EWEN (Erase/Write enable): 0011xxxxxxb
MACRO Mbc7_EepromEWEN
    Mbc7_EepromStartCommand

    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteHigh ; 1
    Mbc7_EepromWriteHigh ; 1
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
ENDM

; EWDS (Erase/Write disable): 0000xxxxxxb
MACRO Mbc7_EepromEWDS
    Mbc7_EepromStartCommand

    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
ENDM

; READ: 10xAAAAAAAb (then shift out 16 bits)
MACRO Mbc7_EepromREAD
    Mbc7_EepromStartCommand

    Mbc7_EepromWriteHigh ; 1
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteBit  \1 & %01000000
    Mbc7_EepromWriteBit  \1 & %00100000
    Mbc7_EepromWriteBit  \1 & %00010000
    Mbc7_EepromWriteBit  \1 & %00001000
    Mbc7_EepromWriteBit  \1 & %00000100
    Mbc7_EepromWriteBit  \1 & %00000010
    Mbc7_EepromWriteBit  \1 & %00000001

    ; Read 2 byte into DE
    xor a
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    ld d, a

    xor a
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    Mbc7_EepromReadBitIntoRegister
    ld e, a
ENDM

; WRITE: 01xAAAAAAAb (then shift in 16 bits)
MACRO Mbc7_EepromWRITE
    Mbc7_EepromStartCommand

    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteHigh ; 1
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteBit  \1 & %01000000
    Mbc7_EepromWriteBit  \1 & %00100000
    Mbc7_EepromWriteBit  \1 & %00010000
    Mbc7_EepromWriteBit  \1 & %00001000
    Mbc7_EepromWriteBit  \1 & %00000100
    Mbc7_EepromWriteBit  \1 & %00000010
    Mbc7_EepromWriteBit  \1 & %00000001

    ; Write 2 byte
    Mbc7_EepromWriteBit  \2 & %1000000000000000
    Mbc7_EepromWriteBit  \2 & %0100000000000000
    Mbc7_EepromWriteBit  \2 & %0010000000000000
    Mbc7_EepromWriteBit  \2 & %0001000000000000
    Mbc7_EepromWriteBit  \2 & %0000100000000000
    Mbc7_EepromWriteBit  \2 & %0000010000000000
    Mbc7_EepromWriteBit  \2 & %0000001000000000
    Mbc7_EepromWriteBit  \2 & %0000000100000000
    Mbc7_EepromWriteBit  \2 & %0000000010000000
    Mbc7_EepromWriteBit  \2 & %0000000001000000
    Mbc7_EepromWriteBit  \2 & %0000000000100000
    Mbc7_EepromWriteBit  \2 & %0000000000010000
    Mbc7_EepromWriteBit  \2 & %0000000000001000
    Mbc7_EepromWriteBit  \2 & %0000000000000100
    Mbc7_EepromWriteBit  \2 & %0000000000000010
    Mbc7_EepromWriteBit  \2 & %0000000000000001

    Mbc7_EepromWaitWriteCompletion
ENDM

; ERASE (fill address with FFFF): 11xAAAAAAAb
MACRO Mbc7_EepromERASE
    Mbc7_EepromStartCommand

    Mbc7_EepromWriteHigh ; 1
    Mbc7_EepromWriteHigh ; 1
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteBit  \1 & %01000000
    Mbc7_EepromWriteBit  \1 & %00100000
    Mbc7_EepromWriteBit  \1 & %00010000
    Mbc7_EepromWriteBit  \1 & %00001000
    Mbc7_EepromWriteBit  \1 & %00000100
    Mbc7_EepromWriteBit  \1 & %00000010
    Mbc7_EepromWriteBit  \1 & %00000001

    Mbc7_EepromWaitWriteCompletion
ENDM

; WRAL (fill EEPROM with value): 0001xxxxxxb (then shift in 16 bits)
MACRO Mbc7_EepromWRAL
    Mbc7_EepromStartCommand

    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteHigh ; 1
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x

    ; Write 2 byte
    Mbc7_EepromWriteBit  \1 & %1000000000000000
    Mbc7_EepromWriteBit  \1 & %0100000000000000
    Mbc7_EepromWriteBit  \1 & %0010000000000000
    Mbc7_EepromWriteBit  \1 & %0001000000000000
    Mbc7_EepromWriteBit  \1 & %0000100000000000
    Mbc7_EepromWriteBit  \1 & %0000010000000000
    Mbc7_EepromWriteBit  \1 & %0000001000000000
    Mbc7_EepromWriteBit  \1 & %0000000100000000
    Mbc7_EepromWriteBit  \1 & %0000000010000000
    Mbc7_EepromWriteBit  \1 & %0000000001000000
    Mbc7_EepromWriteBit  \1 & %0000000000100000
    Mbc7_EepromWriteBit  \1 & %0000000000010000
    Mbc7_EepromWriteBit  \1 & %0000000000001000
    Mbc7_EepromWriteBit  \1 & %0000000000000100
    Mbc7_EepromWriteBit  \1 & %0000000000000010
    Mbc7_EepromWriteBit  \1 & %0000000000000001

    Mbc7_EepromWaitWriteCompletion
ENDM

; ERAL (fill EEPROM with FFFF): 0010xxxxxxb
MACRO Mbc7_EepromERAL
    Mbc7_EepromStartCommand

    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteHigh ; 1
    Mbc7_EepromWriteLow  ; 0
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x
    Mbc7_EepromWriteLow  ; x

    Mbc7_EepromWaitWriteCompletion
ENDM
ENDC