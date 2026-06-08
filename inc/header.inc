IF !DEF(HEADER_INC)
DEF HEADER_INC EQU 1

MACRO Title
    ASSERT !DEF(HEADER_TITLE)
    DEF HEADER_TITLE EQUS "\1"
ENDM

MACRO ManufacturerCode
    DEF HEADER_MANUFACTURER_CODE = \1
ENDM

MACRO CgbFlag
    DEF HEADER_CGB_FLAG = \1
ENDM

MACRO NewLicenseeCode
    DEF HEADER_NEW_LICENSEE_CODE = \1
ENDM

MACRO NewLicenseeCodeStr
    ASSERT !DEF(HEADER_NEW_LICENSEE_CODE_STR)
    DEF HEADER_NEW_LICENSEE_CODE_STR EQUS "\1"
ENDM

MACRO SgbFlag
    DEF HEADER_SGB_FLAG = \1
ENDM

MACRO CartridgeType
    DEF HEADER_CARTRIDGE_TYPE = \1
ENDM

MACRO RamSize
    DEF HEADER_RAM_SIZE = \1
ENDM

MACRO DestinationCode
    DEF HEADER_DESTINATION_CODE = \1
ENDM

MACRO OldLicenseeCode
    DEF HEADER_OLD_LICENSEE_CODE = \1
ENDM

MACRO RomVersion
    DEF HEADER_ROM_VERSION = \1
ENDM

; ROM size can't be forced in the header, as rgbasm/rgblink will always
; pick the smallest possible ROM size for the defined data.
; Instead, we generate a dummy ROM section in the last possible bank for
; the required ROM size.
MACRO RomSize
    ; 32KB - 2 Banks
    IF \1 == $00
        DEF LAST_ROM_BANK EQU $01
    ; 64KB - 4 Banks
    ELIF \1 == $01
        DEF LAST_ROM_BANK EQU $03
    ; 128KB - 8 Banks
    ELIF \1 == $02
        DEF LAST_ROM_BANK EQU $07
    ; 256KB - 16 Banks
    ELIF \1 == $03
        DEF LAST_ROM_BANK EQU $0F
    ; 512KB - 32 Banks
    ELIF \1 == $04
        DEF LAST_ROM_BANK EQU $1F
    ; 1MB - 64 Banks
    ELIF \1 == $05
        DEF LAST_ROM_BANK EQU $3F
    ; 2MB - 128 Banks
    ELIF \1 == $06
        DEF LAST_ROM_BANK EQU $7F
    ; 4MB - 256 Banks
    ELIF \1 == $07
        DEF LAST_ROM_BANK EQU $FF
    ; 8MB - 512 Banks
    ELIF \1 == $08
        DEF LAST_ROM_BANK EQU $1FF
    ELSE
        FAIL "Invalid ROM size code"
    ENDC
    
    SECTION "Last ROM section", ROMX[$7FFF], BANK[LAST_ROM_BANK]
        db $00

    PURGE LAST_ROM_BANK
ENDM

ENDC