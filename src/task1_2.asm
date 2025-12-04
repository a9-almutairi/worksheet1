; file: src/task1_2.asm
; Task 1.2 — read two integers, print their sum


%include "asm_io.inc"


section .data
prompt1 db "Enter first integer: ",0
prompt2 db "Enter second integer: ",0
out_label db "Sum = ",0


section .bss
tmp resd 1


section .text
global asm_main
extern print_string, print_int, print_nl, read_int


asm_main:
push ebp
mov ebp, esp


; prompt 1
mov eax, prompt1
call print_string
call read_int ; eax <- first
mov [tmp], eax


; prompt 2
mov eax, prompt2
call print_string
call read_int ; eax <- second
add eax, [tmp] ; eax <- sum


; print result
mov edx, eax ; preserve sum
mov eax, out_label
call print_string
mov eax, edx
call print_int
call print_nl


xor eax, eax ; return 0
mov esp, ebp
pop ebp
ret
