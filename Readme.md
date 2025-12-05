# UFCFWK-15-2 Worksheet 1 – Assembly & Make

**Student:** Ahmad Almutairi  
**Deadline:** 4th December, 2025

This repo contains solutions for Tasks 1-4 using NASM (32-bit) and GCC `-m32`.

Build everything:
```bash
make
```

Run programs:
```bash
./bin/task1
./bin/task1_2
./bin/task2a
./bin/task2b
./bin/task2c
```

---

## Task 1 - Basic Assembly Programming (20%)

### Task 1.1 - Adding Two Integers

Program adds two integers from memory and prints result.

**Code snippet from task1.asm:**
```asm
mov eax, [a]      ; load first number
add eax, [b]      ; add second number
mov [result], eax ; store result
call print_int    ; print output
```

**How it works:**
- Loads value 7 from memory into EAX
- Adds value 35 to EAX
- Stores result (42) back to memory
- Prints result using print_int function

**Screenshot:**


![task1](https://github.com/user-attachments/assets/9c7c2657-661c-404d-b373-04a08c421f69)

---

### Task 1.2 - Read and Add Two Integers

Program reads two integers from user and prints their sum.

**Code snippet from task1_2.asm:**
```asm
call read_int     ; read first integer
mov [tmp], eax    ; save it
call read_int     ; read second integer
add eax, [tmp]    ; add first to second
call print_int    ; print sum
```

**How it works:**
- Prompts user for first integer
- Stores first value in temporary location
- Prompts for second integer
- Adds both values
- Displays "Sum = " with result

**Screenshot:**


![task1_2](https://github.com/user-attachments/assets/a87f8e0e-92f0-48d2-bf95-3ddf2dee3124)

---

## Task 2 - Loops and Conditionals (20%)

### Task 2a - Welcome Message with Validation

Program asks for name and number, validates input (50 < N < 100), prints welcome N times.

**Code snippet from task2a.asm:**
```asm
; Validate N
cmp eax, 51
jl .bad          ; jump if less than 51
cmp eax, 100
jge .bad         ; jump if >= 100

; Print N times
mov ecx, [n_value]
.print_loop:
    ; print welcome message
    loop .print_loop
```

**How it works:**
- Reads username using read_char in loop
- Reads number N from user
- Validates: N must be between 51 and 99
- If valid: prints "Welcome, [name]!" N times using loop instruction
- If invalid: prints error message

**Screenshot:**


![task2a](https://github.com/user-attachments/assets/6803082e-fa3c-45a4-ae31-e4f22aba88e1)

---

### Task 2b - Sum Array (1 to 100)

Program creates array of 100 elements, initializes to 1..100, sums all elements.

**Code snippet from task2b.asm:**
```asm
; Initialize array
xor ecx, ecx           ; i = 0
.init_loop:
    mov eax, ecx
    inc eax                ; eax = i+1
    mov [arr + ecx*4], eax
    inc ecx
    cmp ecx, 100
    jl .init_loop

; Sum array
xor edx, edx           ; sum = 0
.sum_loop:
    add edx, [arr + ecx*4]
    inc ecx
    cmp ecx, 100
    jl .sum_loop
```

**How it works:**
- Uses loop to initialize array: arr[0]=1, arr[1]=2, ... arr[99]=100
- Uses second loop to sum all elements
- Result is 5050 (formula: n*(n+1)/2 = 100*101/2)
- Prints "Sum(1..100) = 5050"

**Screenshot:**


![task2b](https://github.com/user-attachments/assets/5bc5b4fb-3567-4c7b-bfe9-d3e544c59709)

---

### Task 2c - Sum Range with User Input

Program asks user for range [lo, hi], validates range, sums that portion of array.

**Code snippet from task2c.asm:**
```asm
; Validate range
mov eax, [lo]
cmp eax, 1
jl .bad              ; lo must be >= 1
mov edx, [hi]
cmp edx, eax
jl .bad              ; hi must be >= lo
cmp edx, 100
jg .bad              ; hi must be <= 100

; Sum range
.sum_loop:
    add edx, [arr + ecx*4]
    inc ecx
    cmp ecx, ebx
    jle .sum_loop
```

**How it works:**
- Initializes array same as Task 2b
- Prompts user for lower bound (1..100)
- Prompts user for upper bound (1..100)
- Validates: 1 ≤ lo ≤ hi ≤ 100
- Sums elements from arr[lo-1] to arr[hi-1]
- Prints "Range sum = " with result

**Screenshot:**


![task2c](https://github.com/user-attachments/assets/69f07941-8d7f-4707-9ea4-2e687c53b6c4)

---

## Task 3 - Makefile Build System (20%)

Created Makefile to automate building all programs.

**Makefile features:**
- `make` or `make all` - builds all targets
- Auto-detects all .asm files in src/ (except asm_io.asm)
- Compiles driver.c and asm_io.asm once
- Links each program with driver.o and asm_io.o
- Outputs executables to bin/ directory
- `make clean` - removes all build artifacts

**Key rules:**
```makefile
all: $(BIN_DIR) $(PROGS)

$(BIN_DIR)/%: $(SRC_DIR)/%.o $(SRC_DIR)/driver.o $(SRC_DIR)/asm_io.o
	$(CC) $(LDFLAGS) -o $@ $^

$(SRC_DIR)/%.o: $(SRC_DIR)/%.asm
	$(AS) $(ASFLAGS) $< -o $@
```

**How it works:**
- Default target "all" builds everything
- Each .asm file is assembled to .o file
- driver.c is compiled to driver.o
- asm_io.asm is assembled to asm_io.o
- Final executable links program.o + driver.o + asm_io.o

**Screenshot:**


![makefile](https://github.com/user-attachments/assets/d439ebf6-ef02-4456-8af2-455b99358447)

---

## Task 4 - Documentation (40%)

This README documents all work with:
- Code snippets showing key assembly instructions
- Explanations of how each program works
- Screenshots demonstrating programs running
- Clear structure following worksheet requirements

**Repository structure:**
```
worksheet1/
├── README.md          (this file)
├── Makefile
├── bin/               (executables)
└── src/
    ├── asm_io.asm
    ├── asm_io.inc
    ├── driver.c
    ├── task1.asm
    ├── task1_2.asm
    ├── task2a.asm
    ├── task2b.asm
    └── task2c.asm
```

---

## Notes

- Requires `nasm` and `gcc-multilib` on 64-bit Linux
- All programs use 32-bit mode (`-m32` flag)
- Uses provided `asm_io.asm` and `asm_io.inc` helper files
- Each program exposes `asm_main` function called by `driver.c`

---
