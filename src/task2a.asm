; file: src/t2_welcome.asm
; Task 2a — Ask for name and count; validate 50 < N < 100; print welcome N times


%include "asm_io.inc"


%define NL 10


section .data
ask_name db "Enter your name: ",0
ask_n db "Enter a number N (51..99): ",0
err_msg db "Error: N must be > 50 and < 100.",0
hello_pre db "Welcome, ",0
hello_suf db "!",0


section .bss
name_buf resb 128 ; max name length
n_value resd 1


section .text
global asm_main
extern print_string, print_char, print_nl, read_char, read_int


asm_main:
push ebp
mov ebp, esp


; Read name (line buffered using read_char)
mov eax, ask_name
call print_string


mov edi, name_buf
.read_loop:
call read_char ; eax = char or NL
cmp eax, NL
je .name_done
mov [edi], al
inc edi
cmp edi, name_buf+127 ; keep room for NUL
jb .read_loop
.name_done:
mov byte [edi], 0 ; NUL terminate


; Read N
mov eax, ask_n
call print_string
call read_int ; eax = N
mov [n_value], eax


; Validate (N > 50) && (N < 100)
mov eax, [n_value]
cmp eax, 51
jl .bad
cmp eax, 100
jge .bad


; Print welcome N times
mov ecx, [n_value]
.print_loop:
mov eax, hello_pre
call print_string
mov eax, name_buf
call print_string
mov eax, hello_suf
call print_string
call print_nl
loop .print_loop
jmp .done


.bad:
mov eax, err_msg
call print_string
call print_nl


.done:
xor eax, eax
mov esp, ebp
pop ebp
ret
