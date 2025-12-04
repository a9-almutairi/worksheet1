; file: src/t2_sum100.asm
; Task 2b — Define array[100], init to 1..100, sum and print result

%include "asm_io.inc"

section .data
    out_label   db "Sum(1..100) = ",0

section .bss
    arr         resd 100

section .text
    global asm_main
    extern print_string, print_int, print_nl

asm_main:
    push ebp
    mov  ebp, esp

    ; Initialize arr[i] = i+1 for i=0..99
    xor  ecx, ecx            ; i = 0
.init_loop:
    cmp  ecx, 100
    jge  .init_done
    mov  eax, ecx
    inc  eax                 ; eax = i+1
    mov  [arr + ecx*4], eax
    inc  ecx
    jmp  .init_loop
.init_done:

    ; Sum all 100 elements
    xor  ecx, ecx
    xor  edx, edx            ; sum = 0
.sum_loop:
    cmp  ecx, 100
    jge  .sum_done
    add  edx, [arr + ecx*4]
    inc  ecx
    jmp  .sum_loop
.sum_done:

    ; Print
    mov  eax, out_label
    call print_string
    mov  eax, edx
    call print_int
    call print_nl

    xor  eax, eax
    mov  esp, ebp
    pop  ebp
    ret
