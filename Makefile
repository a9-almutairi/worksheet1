# /Makefile — fixed include path + filenames that match your tree

NASM    := nasm
GCC     := gcc
ASFLAGS := -f elf -I src/           # include src/ so %include "asm_io.inc" works
CFLAGS  := -m32 -Wall -Wextra -O2 -std=c11
LDFLAGS := -m32

SRC_DIR   := src
BUILD_DIR := build

# Programs in your current tree
PROGS := \
  task1 \
  tas1_2 \
  task2_greet \
  task2_sum100 \
  task2_sum_range

TARGETS := $(addprefix $(BUILD_DIR)/,$(PROGS))

DRIVER      := $(SRC_DIR)/driver.c
ASM_IO_SRC  := $(SRC_DIR)/asm_io.asm
ASM_IO_OBJ  := $(BUILD_DIR)/asm_io.o
DRIVER_OBJ  := $(BUILD_DIR)/driver.o

ASM_SRCS := \
  $(SRC_DIR)/task1.asm \
  $(SRC_DIR)/tas1_2.asm \
  $(SRC_DIR)/task2_greet.asm \
  $(SRC_DIR)/task2_sum100.asm \
  $(SRC_DIR)/task2_sum_range.asm

ASM_OBJS := $(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.o,$(ASM_SRCS))

.PHONY: all clean list run-%

all: $(TARGETS)

list:
	@echo "Programs:" $(PROGS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile C driver
$(DRIVER_OBJ): $(DRIVER) | $(BUILD_DIR)
	$(GCC) $(CFLAGS) -c $< -o $@

# Assemble asm_io separately (shared by all)
$(ASM_IO_OBJ): $(ASM_IO_SRC) | $(BUILD_DIR)
	$(NASM) $(ASFLAGS) $< -o $@

# Generic rule for other .asm sources
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(NASM) $(ASFLAGS) $< -o $@

# Link each program
$(BUILD_DIR)/task1: $(BUILD_DIR)/task1.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/tas1_2: $(BUILD_DIR)/tas1_2.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/task2_greet: $(BUILD_DIR)/task2_greet.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/task2_sum100: $(BUILD_DIR)/task2_sum100.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/task2_sum_range: $(BUILD_DIR)/task2_sum_range.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

# Helpers
run-%: $(BUILD_DIR)/%
	@echo "Running $<"
	@$<

clean:
	rm -rf $(BUILD_DIR)
