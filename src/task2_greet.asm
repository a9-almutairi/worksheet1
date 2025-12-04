
; /src/t2_greet.asm
; Task 2.1: Ask for name and count. Validate 50 < n < 100. Print "Welcome, <name>!" n times or error.
%include "src/asm_io.inc"

%define NAME_MAX 64

SECTION .data
prompt_name   db "Enter your name: ", 0
prompt_count  db "Enter how many times to print (51..99): ", 0
err_range     db "Error: number must be > 50 and < 100.", 0
welcome_pfx   db "Welcome, ", 0
welcome_sfx   db "!", 0

SECTION .bss
namebuf       resb NAME_MAX+1

SECTION .text
global asm_main
asm_main:
    enter 0,0

    ; Ask for name
    push dword prompt_name
    call print_string
    add esp, 4

    ; Read chars until newline or buffer full; store and NUL-terminate
    xor ecx, ecx                 ; ecx = index
.read_name:
    ; stop if ecx == NAME_MAX
    cmp ecx, NAME_MAX
    jge .term
    call read_char               ; AL = char (zero-extended in EAX)
    cmp eax, 10                  ; '\n'
    je .term
    mov [namebuf + ecx], al
    inc ecx
    jmp .read_name
.term:
    mov byte [namebuf + ecx], 0

    ; Ask for count
    push dword prompt_count
    call print_string
    add esp, 4
    call read_int                ; EAX = n

    ; Validate: 50 < n < 100
    mov ebx, eax                 ; keep n in EBX
    cmp ebx, 51
    jl .bad
    cmp ebx, 99
    jg .bad

    ; Print n times
    xor ecx, ecx
.print_loop:
    cmp ecx, ebx
    jge .done_ok

    push dword welcome_pfx
    call print_string
    add esp, 4

    push dword namebuf
    call print_string
    add esp, 4

    push dword welcome_sfx
    call print_string
    add esp, 4

    call print_nl

    inc ecx
    jmp .print_loop

.done_ok:
    xor eax, eax
    leave
    ret

.bad:
    push dword err_range
    call print_string
    add esp, 4
    call print_nl
    mov eax, 1                  ; non-zero status
    leave
    ret
