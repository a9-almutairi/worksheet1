; /src/t2_sum100.asm
; Task 2.2: Define array [1..100], sum, print result.
%include "src/asm_io.inc"

SECTION .data
msg_sum  db "Sum(1..100) = ", 0
; Initialize 1..100
arr:
%assign i 1
%rep 100
    dd i
%assign i i+1
%endrep

SECTION .text
global asm_main
asm_main:
    enter 0,0

    xor eax, eax       ; sum
    xor ecx, ecx       ; i=0

.sum_loop:
    cmp ecx, 100
    jge .done
    add eax, [arr + ecx*4]
    inc ecx
    jmp .sum_loop

.done:
    push dword msg_sum
    call print_string
    add esp, 4
    push eax
    call print_int
    add esp, 4
    call print_nl

    xor eax, eax
    leave
    ret
