; src/task1.asm
; Task 1 – simple addition of two global integers

%include "asm_io.inc"

segment .data
msg_sum db "Result (a + b) = ", 0
a dd 7 ; first integer
b dd 13 ; second integer


segment .text
global asm_main

asm_main:
    enter 0, 0
    pusha

    ; print text message
    mov eax, msg_sum
    push eax
    call print_string
    add esp, 4

    ; eax = a + b
    mov eax, [a]
    add eax, [b]

    ; print result in eax
    push eax
    call print_int
    add esp, 4

    ; newline
    call print_nl

    popa
    mov eax, 0 ; return status to C
    leave
    ret