; src/task1.2.asm
; Task 1 – second example program (similar to slide 22 idea)


%include "asm_io.inc"


segment .data
msg_expr db "Result (x * y - z) = ", 0
x dd 4
y dd 6
z dd 5


segment .text
global asm_main


asm_main:
    enter 0, 0
    pusha

    ; print message
    mov eax, msg_expr
    push eax
    call print_string
    add esp, 4

    ; eax = x * y
    mov eax, [x]
    imul dword [y]

    ; eax = eax - z
    sub eax, [z]

    ; print result
    push eax
    call print_int
    add esp, 4

    call print_nl

    popa
    mov eax, 0
    leave
    ret