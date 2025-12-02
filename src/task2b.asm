; src/task2b.asm
; Task 2 – Part 2: array 1..100 and sum


%include "asm_io.inc"


segment .data
msg_start db "Summing the numbers 1..100", 0
msg_result db "Total sum = ", 0


segment .bss
arr resd 100


segment .text
    global asm_main

asm_main:
    enter 0, 0
    pusha

    ; message
    mov eax, msg_start
    push eax
    call print_string
    add esp, 4
    call print_nl

    ; Initialise array: arr[i] = i + 1
    xor ecx, ecx ; i = 0

.init_loop:
    cmp ecx, 100
    jge .init_done

    mov eax, ecx
    inc eax ; eax = i + 1
    mov [arr + ecx*4], eax

    inc ecx
    jmp .init_loop

.init_done:
    ; Sum the array
    xor ecx, ecx ; i = 0
    xor eax, eax ; eax = running sum


.sum_loop:
    cmp ecx, 100
    jge .sum_done

    add eax, [arr + ecx*4]
    inc ecx
    jmp .sum_loop


.sum_done:
    ; Print result
    mov ebx, eax ; keep sum in ebx

    mov eax, msg_result
    push eax
    call print_string
    add esp, 4

    push ebx
    call print_int
    add esp, 4

    call print_nl

    popa
    mov eax, 0
    leave
    ret