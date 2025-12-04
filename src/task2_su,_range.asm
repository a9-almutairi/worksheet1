; /src/t2_sum_range.asm
; Task 2.3: Read start/end; validate 1 <= start <= end <= 100; sum arr[start..end].
%include "asm_io.inc"

SECTION .data
prompt_s  db "Enter start index (1..100): ", 0
prompt_e  db "Enter end index   (1..100): ", 0
err_rng   db "Error: indices must satisfy 1 <= start <= end <= 100.", 0
msg_res   db "Sum(range) = ", 0

; 1..100 array
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

    ; read start
    push dword prompt_s
    call print_string
    add esp, 4
    call read_int
    mov ebx, eax        ; start

    ; read end
    push dword prompt_e
    call print_string
    add esp, 4
    call read_int
    mov edx, eax        ; end

    ; validate: 1 <= start <= end <= 100
    cmp ebx, 1
    jl .bad
    cmp ebx, 100
    jg .bad
    cmp edx, ebx
    jl .bad
    cmp edx, 100
    jg .bad

    ; Convert to zero-based offsets: start' = start-1, end' = end-1
    dec ebx
    dec edx

    xor eax, eax        ; sum
    mov ecx, ebx        ; i = start'

.sum_loop:
    cmp ecx, edx
    jg .done
    add eax, [arr + ecx*4]
    inc ecx
    jmp .sum_loop

.done:
    push dword msg_res
    call print_string
    add esp, 4
    push eax
    call print_int
    add esp, 4
    call print_nl

    xor eax, eax
    leave
    ret

.bad:
    push dword err_rng
    call print_string
    add esp, 4
    call print_nl
    mov eax, 2
    leave
    ret
