DEF RAMRO          EQU $00
DEF RAMRW          EQU $0A
DEF RTCW           EQU $0B
DEF RTCR           EQU $0C
DEF RTCSEM         EQU $0D
DEF IR             EQU $0E
DEF rMAP           EQU $0000
DEF rRTCRW         EQU $A000

; \1 command
MACRO HuC3_RtcExecuteCommand
   ; Map mode: RTC write
   ld a, RTCW
   ld [rMAP], a

   ; Prepare for command
   ld a, \1
   ld [rRTCRW], a

   ; Map mode: RTC semaphore
   ld a, RTCSEM
   ld [rMAP], a

   ; Wait until is ready
WaitReady\@:
   ld a, [rRTCRW]
   cp $01
   jp nz, WaitReady\@

   ; Submit command
   ld a, $FE
   ld [rRTCRW], a
ENDM

MACRO HuC3_RtcRead
   ; Map mode: RTC read
   ld a, RTCR
   ld [rMAP], a

   ; Read value
   ld a, [rRTCRW]
ENDM

; \1 value
MACRO HuC3_RtcWrite
   ; Map mode: RTC write
   ld a, RTCW
   ld [rMAP], a

   ; Write value
   ld [rRTCRW], a
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

