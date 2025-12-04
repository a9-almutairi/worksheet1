; file: src/t2_sum_range.asm
; Task 2c — Ask user for [lo, hi] within 1..100, validate, sum that range, print

%include "asm_io.inc"

section .data
    ask_lo      db "Enter lower bound (1..100): ",0
    ask_hi      db "Enter upper bound (1..100): ",0
    invalid     db "Error: Range must satisfy 1 <= lo <= hi <= 100.",0
    out_label   db "Range sum = ",0

section .bss
    arr         resd 100
    lo          resd 1
    hi          resd 1

section .text
    global asm_main
    extern print_string, print_int, print_nl, read_int

asm_main:
    push ebp
    mov  ebp, esp

    ; Initialize arr[i] = i+1
    xor  ecx, ecx
.init:
    cmp  ecx, 100
    jge  .after_init
    mov  eax, ecx
    inc  eax
    mov  [arr + ecx*4], eax
    inc  ecx
    jmp  .init
.after_init:

    ; Read lo
    mov  eax, ask_lo
    call print_string
    call read_int
    mov  [lo], eax

    ; Read hi
    mov  eax, ask_hi
    call print_string
    call read_int
    mov  [hi], eax

    ; Validate: 1 <= lo <= hi <= 100
    mov  eax, [lo]
    cmp  eax, 1
    jl   .bad
    mov  edx, [hi]
    cmp  edx, eax
    jl   .bad
    cmp  edx, 100
    jg   .bad

    ; Sum arr[lo..hi]
    mov  ecx, [lo]
    dec  ecx                ; convert to 0-based index
    mov  ebx, [hi]
    dec  ebx
    xor  edx, edx           ; sum = 0
.sum_loop:
    cmp  ecx, ebx
    jg   .sum_done
    add  edx, [arr + ecx*4]
    inc  ecx
    jmp  .sum_loop
.sum_done:
    mov  eax, out_label
    call print_string
    mov  eax, edx
    call print_int
    call print_nl
    jmp  .done

.bad:
    mov  eax, invalid
    call print_string
    call print_nl

.done:
    xor  eax, eax
    mov  esp, ebp
    pop  ebp
    ret
