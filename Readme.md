# Worksheet 1 - An Echo of Assembler

## Overview

This repository contains the full implementation of Worksheet 1 – An Echo of Assembler, completed on the UWE csctcloud Linux environment. The worksheet introduces:

- Basic x86 assembly programming
- Calling assembly functions from C
- Translating loops, conditionals, and arrays from C into assembler
- Automating builds with Makefiles

All programs use **NASM** and **GCC (-m32)** and rely on the provided `asm_io.asm` and `asm_io.inc` libraries for I/O.

## Repository Structure

```
worksheet1/
├── Makefile
├── Readme.md
└── src/
    ├── driver.c
    ├── task1.asm
    ├── task1.2.asm
    ├── task2a.asm
    ├── task2b.asm
    └── task2c.asm
```

## File Summary

| File | Description |
|------|-------------|
| `driver.c` | C program calling the assembler function `asm_main()` |
| `task1.asm` | Adds two integers and prints the result |
| `task1.2.asm` | Performs an arithmetic expression `(x * y) - z` |
| `task2a.asm` | Reads a user name and number; validates input; prints messages in a loop |
| `task2b.asm` | Creates an array of integers (1–100) and prints the sum |
| `task2c.asm` | Reads a range, validates it, and sums that range |

## Why a Makefile?

The Makefile automates the build process:

- Assembling `.asm` files → `.o` object files
- Compiling C driver → object file
- Linking everything to executables

**Benefits:**
- Avoids long manual compile commands
- Ensures correct build ordering
- Supports `make clean` for cleanup
- Matches industry standards for build automation

## Key Learnings

### Assembly Programming Fundamentals

- Register usage (`eax`, `ebx`, `ecx`, `edx`)
- Stack frames (`enter`, `leave`, `ret`)
- Data sections: `.data`, `.bss`, `.text`

### C-to-Assembly Interaction

- Function declarations using `extern`
- Following x86 calling conventions
- Returning values to C

### Translating Logic to Assembly

- Conditional jumps (`jl`, `jg`, `je`, etc.)
- Loop construction with counters
- Implementing array indexing manually

### Makefile Automation

- Use of pattern rules
- Linking object files
- Organizing multi-file projects

## Summary

This worksheet provided foundational experience in system-level programming. I learned how C interacts with assembly, how machine-level instructions implement familiar programming constructs, and how Makefiles streamline development. 