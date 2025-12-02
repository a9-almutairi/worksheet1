; src/task2a.asm
; Task 2 – Part 1: loops & conditionals, welcome message

%include "asm_io.inc"

segment .data
    prompt_name db "Enter your name: ", 0
    prompt_times db "How many times (must be > 50 and < 100)? ", 0
    msg_welcome db "Welcome, ", 0
    msg_error db "Error: number must be > 50 and < 100.", 0

segment .bss
    name_buf resb 64
    times resd 1

segment .text
    global asm_main

asm_main:
    enter 0, 0
    pusha

    ; Ask for name
    mov eax, prompt_name
    push eax
    call print_string
    add esp, 4

    mov eax, name_buf ; buffer pointer
    push dword 63 ; max length (leave space for 0)
    push eax
    call read_string
    add esp, 8

    ; Ask for number of times
    mov eax, prompt_times
    push eax
    call print_string

    add esp, 4

    call read_int ; result in eax
    mov [times], eax

    ; Check 50 < times < 100
    mov eax, [times]

    cmp eax, 51
    jl .too_small

    cmp eax, 99
    jg .too_large

    jmp .valid

.too_small:
.too_large:
    mov eax, msg_error
    push eax
    call print_string
    add esp, 4
    call print_nl
    jmp .done

.valid:
    ; ecx = number of times to print
    mov ecx, [times]


.print_loop:
    cmp ecx, 0
    jle .done

    ; "Welcome, "
    mov eax, msg_welcome
    push eax
    call print_string

    add esp, 4

    ; name
    mov eax, name_buf
    push eax
    call print_string
    add esp, 4

    call print_nl

    dec ecx
    jmp .print_loop

.done:
    popa
    mov eax, 0
    leave
    ret