# Makefile for Worksheet 1 – Assembler
NASM = nasm
GCC = gcc
NASMFLAGS = -f elf
CFLAGS = -m32 -Wall -g
LDFLAGS = -m32

SRC_DIR = src

ASM_IO = $(SRC_DIR)/asm_io.o
DRIVER_O = $(SRC_DIR)/driver.o

PROGRAMS = task1 task1_2 task2a task2b task2c
all: $(PROGRAMS)

$(SRC_DIR)/%.o: $(SRC_DIR)/%.asm
$(NASM) $(NASMFLAGS) $< -o $@


# Compile driver.c once
$(DRIVER_O): $(SRC_DIR)/driver.c
$(GCC) $(CFLAGS) -c $< -o $@

$(ASM_IO): $(SRC_DIR)/asm_io.asm
$(NASM) $(NASMFLAGS) $< -o $@


task1: $(DRIVER_O) $(SRC_DIR)/task1.o $(ASM_IO)
$(GCC) $(LDFLAGS) $^ -o $@


"task1_2": $(DRIVER_O) $(SRC_DIR)/task1_2.o $(ASM_IO)
$(GCC) $(LDFLAGS) $^ -o "task1.2"


# Task 2 programs
task2a: $(DRIVER_O) $(SRC_DIR)/task2a.o $(ASM_IO)
$(GCC) $(LDFLAGS) $^ -o $@


task2b: $(DRIVER_O) $(SRC_DIR)/task2b.o $(ASM_IO)
$(GCC) $(LDFLAGS) $^ -o $@


task2c: $(DRIVER_O) $(SRC_DIR)/task2c.o $(ASM_IO)
$(GCC) $(LDFLAGS) $^ -o $@


.PHONY: clean
clean:
rm -f $(SRC_DIR)/*.o $(PROGRAMS)