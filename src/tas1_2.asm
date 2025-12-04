; /src/task1_2.asm
; Task 1 (slide-22-style follow-up): small array sum and print
%include "src/asm_io.inc"

SECTION .data
arr     dd 3, 1, 4, 1, 5, 9
n       dd 6
msg     db "Sum(arr) = ", 0

SECTION .text
global asm_main
asm_main:
    enter 0,0

    xor eax, eax      ; sum
    xor ecx, ecx      ; i = 0
    mov edx, [n]      ; n

.sum_loop:
    cmp ecx, edx
    jge .done
    add eax, [arr + ecx*4]
    inc ecx
    jmp .sum_loop

.done:
    push dword msg
    call print_string
    add esp, 4

    push eax
    call print_int
    add esp, 4
    call print_nl

    xor eax, eax
    leave
    ret
