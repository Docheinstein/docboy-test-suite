IF !DEF(HUC3_INC)
DEF HUC3_INC EQU 1

include "mbc/mbc.inc"

DEF HUC3_RAM_RO         EQU $00
DEF HUC3_RAM_RW         EQU $0A
DEF HUC3_RTC_W          EQU $0B
DEF HUC3_RTC_R          EQU $0C
DEF HUC3_RTC_SEM        EQU $0D
DEF HUC3_IR             EQU $0E

DEF rHUC3_MAP           EQU $0000
DEF rHUC3_RTC_RW        EQU $A000

; \1 command
MACRO HuC3_RtcExecuteCommand
   ; Map mode: RTC write
   ld a, HUC3_RTC_W
   ld [rHUC3_MAP], a

   ; Prepare for command
   ld a, \1
   ld [rHUC3_RTC_RW], a

   ; Map mode: RTC semaphore
   ld a, HUC3_RTC_SEM
   ld [rHUC3_MAP], a

   ; Wait until is ready
WaitReady\@:
   ld a, [rHUC3_RTC_RW]
   cp $01
   jp nz, WaitReady\@

   ; Submit command
   ld a, $FE
   ld [rHUC3_RTC_RW], a
ENDM

MACRO HuC3_RtcRead
   ; Map mode: RTC read
   ld a, HUC3_RTC_R
   ld [rHUC3_MAP], a

   ; Read value
   ld a, [rHUC3_RTC_RW]
ENDM

; \1 value
MACRO HuC3_RtcWrite
   ; Map mode: RTC write
   ld a, HUC3_RTC_W
   ld [rHUC3_MAP], a

   ; Write value
   ld [rHUC3_RTC_RW], a
ENDM

; \1 address
MACRO HuC3_SetMemoryAddressLow
   ; Set low nibble
   ld a, \1
   and $0f
   or $40
   ld h, a
   HuC3_RtcExecuteCommand h
ENDM

; \1 address
MACRO HuC3_SetMemoryAddressHigh
   ; Set high nibble
   ld a, \1
   and $0f
   or $50
   ld h, a
   HuC3_RtcExecuteCommand h
ENDM

; \1 address
MACRO HuC3_SetMemoryAddress
   HuC3_SetMemoryAddressLow \1

   ld a, \1
   swap a
   ld h, a
   HuC3_SetMemoryAddressHigh h
ENDM

; \1 address
MACRO HuC3_RtcReadMemory
   HuC3_SetMemoryAddress \1
   HuC3_RtcExecuteCommand $10
   HuC3_RtcRead
   and $0f
ENDM

; \1 address
; \2 value (nibble)
MACRO HuC3_RtcWriteMemory
   HuC3_SetMemoryAddress \1

   ; Set low nibble
   ld a, \2
   and $0f
   or $30
   ld h, a
   HuC3_RtcExecuteCommand h
ENDM

ENDC