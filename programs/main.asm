; ==============================================================================
; Test Program: Direct Immediate Jumps & Interrupt Safety
; ==============================================================================

.ORG 0xFFF4
DW IRQ ; irq vector

.ORG 0xC000

START:
    SEI
    MOV MARL, 0xFF
    MOV MARH, 0x1F
    MOV A, 0x05
    JZ TARGET_FAIL

    INC A
    CP A, 0x06
    JZ TARGET_PASS

    HALT

IRQ:
    MOV X, 0x10
    MOV Y, 0x44
    LD A, MAR
    JMP START

TARGET_FAIL:
    ; Danger Zone: If JZ incorrectly jumps here on false, test halts.
    HALT

TARGET_PASS:

    MOV MARL, 0xAA
    MOV MARH, 0xBB

    JNZ SUCCESS              

    HALT                     

SUCCESS:
    HALT                     ; Test Passed! PC ends up here safely.START

