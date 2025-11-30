# Makefile for CPU instruction tests

# Verilator settings
VERILATOR = verilator
VERILATOR_FLAGS = --cc --exe --build --timing
VERILATOR_FLAGS += --trace  # Enable VCD waveform
VERILATOR_FLAGS += -Wno-fatal  # Don't fail on warnings

# Source files
RTL_DIR = ../../../src/main/rtl
TEST_DIR = .
SRC = $(RTL_DIR)/nes_system.sv
TEST = $(TEST_DIR)/cpu_instruction_test.sv
CPP_MAIN = $(TEST_DIR)/test_main.cpp

# Output
BUILD_DIR = obj_dir
EXEC = $(BUILD_DIR)/Vcpu_instruction_test

.PHONY: all test clean

all: test

# Build and run tests
test: $(EXEC)
	@echo "Running CPU instruction tests..."
	@./$(EXEC)

# Build test executable
$(EXEC): $(SRC) $(TEST) $(CPP_MAIN)
	$(VERILATOR) $(VERILATOR_FLAGS) \
		--top-module cpu_instruction_test \
		$(SRC) $(TEST) $(CPP_MAIN)

# Clean build files
clean:
	rm -rf $(BUILD_DIR) *.vcd

# Run with waveform
wave: $(EXEC)
	./$(EXEC)
	@echo "Waveform saved to cpu_test.vcd"
	@echo "View with: gtkwave cpu_test.vcd"
