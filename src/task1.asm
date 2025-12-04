; /src/task1.asm
; Task 1: add two integers in global memory and print using asm_io
; Requires: asm_io.inc / asm_io.asm

%include "asm_io.inc"

SECTION .data
msg_a      db "A = ", 0
msg_b      db "B = ", 0
msg_sum    db "A + B = ", 0
a          dd 17
b          dd 25

SECTION .text
global asm_main
asm_main:
    enter 0,0

    ; print A
    push dword msg_a
    call print_string
    add esp, 4
    mov eax, [a]
    push eax
    call print_int
    add esp, 4
    call print_nl

    ; print B
    push dword msg_b
    call print_string
    add esp, 4
    mov eax, [b]
    push eax
    call print_int
    add esp, 4
    call print_nl

    ; sum and print
    mov eax, [a]
    add eax, [b]
    push dword msg_sum
    call print_string
    add esp, 4
    push eax
    call print_int
    add esp, 4
    call print_nl

    xor eax, eax       ; return 0
    leave
    ret
