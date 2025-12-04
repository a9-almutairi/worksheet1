# Makefile — builds every NASM program in src/*.asm (except asm_io.asm)
# Matches your per-file commands (nasm ... -I src ; gcc -m32 ... -o bin/<name>)

CC       := gcc
AS       := nasm
SRC_DIR  := src
BIN_DIR  := bin

# 32-bit + non-PIE to avoid DT_TEXTREL/PIE warnings on modern distros
CFLAGS   := -m32 -O2 -Wall -Wextra -Werror=implicit-function-declaration -fno-pie
ASFLAGS  := -f elf -I $(SRC_DIR)
LDFLAGS  := -m32 -no-pie

IO_ASM   := $(SRC_DIR)/asm_io.asm
IO_INC   := $(SRC_DIR)/asm_io.inc
DRIVER_C := $(SRC_DIR)/driver.c

# Auto-detect all .asm programs except asm_io.asm
ASM_SRCS := $(filter-out $(IO_ASM), $(wildcard $(SRC_DIR)/*.asm))
PROGS    := $(patsubst $(SRC_DIR)/%.asm,$(BIN_DIR)/%,$(ASM_SRCS))

# Default: build everything found in src/*.asm (excluding asm_io.asm)
.PHONY: all
all: $(BIN_DIR) $(PROGS)
	@echo "Built: $(notdir $(PROGS))"

$(BIN_DIR):
	@mkdir -p $@

# Link rule: each program links its own object with driver.o and asm_io.o
$(BIN_DIR)/%: $(SRC_DIR)/%.o $(SRC_DIR)/driver.o $(SRC_DIR)/asm_io.o | $(BIN_DIR)
	$(CC) $(LDFLAGS) -o $@ $^
	@echo "LD $@"

# Compile C driver once
$(SRC_DIR)/driver.o: $(DRIVER_C)
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "CC $@"

# Assemble support once
$(SRC_DIR)/asm_io.o: $(IO_ASM)
	$(AS) $(ASFLAGS) $< -o $@
	@echo "AS $@"

# Assemble each program; -I src lets %include "asm_io.inc" resolve
$(SRC_DIR)/%.o: $(SRC_DIR)/%.asm $(IO_INC)
	$(AS) $(ASFLAGS) $< -o $@
	@echo "AS $@"

# Convenience: explicit targets if you prefer fixed names
.PHONY: task1 task1_2 t2_welcome task2a task2b task2c
task1:       $(BIN_DIR)/task1
task1_2:     $(BIN_DIR)/task1_2
t2_welcome:  $(BIN_DIR)/t2_welcome
task2a:      $(BIN_DIR)/task2a
task2b:      $(BIN_DIR)/task2b
task2c:      $(BIN_DIR)/task2c

# Clean
.PHONY: clean
clean:
	rm -rf $(BIN_DIR) $(SRC_DIR)/*.o
	@echo "Cleaned"
