; src/task2c.asm ; Read end index

mov eax, msg_prompt_e
push eax
call print_string
add esp, 4


call read_int
mov [end_idx], eax


; Validate: 1 <= start <= end <= 100
mov eax, [start_idx]
mov ebx, [end_idx]


cmp eax, 1
jl .bad_range


cmp eax, 100
jg .bad_range


cmp ebx, 1
jl .bad_range


cmp ebx, 100
jg .bad_range


cmp eax, ebx
jg .bad_range


jmp .range_ok


.bad_range:
mov eax, msg_err_range
push eax
call print_string
add esp, 4
call print_nl
jmp .done


.range_ok:
; Convert to 0-based indices: start0 = start-1, end0 = end-1
mov eax, [start_idx]
dec eax
mov [start_idx], eax


mov ebx, [end_idx]
dec ebx
mov [end_idx], ebx


; Sum from arr[start0] to arr[end0]
mov ecx, [start_idx] ; current index
mov edx, [end_idx] ; last index
xor eax, eax ; running sum


.sum_loop:
    cmp ecx, edx
    jg .sum_done

    add eax, [arr + ecx*4]
    inc ecx
    jmp .sum_loop

.sum_done:
    mov ebx, eax

    mov eax, msg_result
    push eax
    call print_string
    add esp, 4

    push ebx
    call print_int
    add esp, 4

    call print_nl

.done:
    popa
    mov eax, 0
    leave
    ret