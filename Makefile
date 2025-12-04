# /Makefile
# Build system for UFCFWK-15-2 Worksheet 1

NASM   := nasm
GCC    := gcc
ASFLAGS:= -f elf
CFLAGS := -m32 -Wall -Wextra -O2 -std=c11
LDFLAGS:= -m32

SRC_DIR := src
BUILD_DIR := build

ASM_IO := $(SRC_DIR)/asm_io.asm
ASM_IO_OBJ := $(BUILD_DIR)/asm_io.o
DRIVER := $(SRC_DIR)/driver.c
DRIVER_OBJ := $(BUILD_DIR)/driver.o

PROGS := task1 task1_2 t2_greet t2_sum100 t2_sum_range
TARGETS := $(addprefix $(BUILD_DIR)/,$(PROGS))

ASM_SRCS := \
  $(SRC_DIR)/task1.asm \
  $(SRC_DIR)/task1_2.asm \
  $(SRC_DIR)/t2_greet.asm \
  $(SRC_DIR)/t2_sum100.asm \
  $(SRC_DIR)/t2_sum_range.asm

ASM_OBJS := $(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.o,$(ASM_SRCS))

.PHONY: all clean
all: $(TARGETS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Pattern rules
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(NASM) $(ASFLAGS) $< -o $@

$(DRIVER_OBJ): $(DRIVER) | $(BUILD_DIR)
	$(GCC) $(CFLAGS) -c $< -o $@

$(ASM_IO_OBJ): $(ASM_IO) | $(BUILD_DIR)
	$(NASM) $(ASFLAGS) $< -o $@

# Link each target with shared driver and asm_io
$(BUILD_DIR)/task1: $(BUILD_DIR)/task1.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/task1_2: $(BUILD_DIR)/task1_2.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/t2_greet: $(BUILD_DIR)/t2_greet.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/t2_sum100: $(BUILD_DIR)/t2_sum100.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/t2_sum_range: $(BUILD_DIR)/t2_sum_range.o $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(GCC) $(LDFLAGS) $^ -o $@

clean:
	rm -rf $(BUILD_DIR)
