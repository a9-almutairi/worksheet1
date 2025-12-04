; file: src/task1.asm
; Task 1.1 — adds two globals in memory, prints result using print_int


%include "asm_io.inc"


section .data
a dd 7
b dd 35
msg_nl db 10,0 ; for clarity when reading output


section .bss
result resd 1


section .text
global asm_main
extern print_int, print_nl


asm_main:
push ebp
mov ebp, esp
; compute result = a + b
mov eax, [a]
add eax, [b]
mov [result], eax


; print result
; print_int reads value from EAX
call print_int
call print_nl


xor eax, eax ; return 0
mov esp, ebp
pop ebp
ret
