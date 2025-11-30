# NES Game Testbench Makefile

RTL_DIR = ../src/main/rtl
VERILATOR = verilator

# RTL files
RTL_FILES = $(RTL_DIR)/nes_system.sv \
            $(RTL_DIR)/cpu_6502.sv \
            $(RTL_DIR)/nes_ppu.sv \
            $(RTL_DIR)/nes_apu.sv \
            $(RTL_DIR)/nes_dma.sv

.PHONY: all clean run help

all:
	@mkdir -p waveforms
	$(VERILATOR) --cc --exe --build -Wall -Wno-fatal \
		--trace \
		--top-module nes_system \
		-CFLAGS "-std=c++17" \
		nes_game_tb.cpp $(RTL_FILES)
	@echo "Build complete: obj_dir/Vnes_system"

run:
	@if [ -z "$(ROM)" ]; then \
		echo "Usage: make run ROM=<path/to/rom.nes> [CYCLES=1000000]"; \
		exit 1; \
	fi
	./obj_dir/Vnes_system $(ROM) $(CYCLES)

clean:
	rm -rf obj_dir *.vcd

help:
	@echo "NES Game Testbench"
	@echo ""
	@echo "Targets:"
	@echo "  make all              - Build testbench"
	@echo "  make run ROM=<file>   - Run NES ROM"
	@echo "  make clean            - Clean build files"
	@echo ""
	@echo "Examples:"
	@echo "  make run ROM=../games/Donkey-Kong.nes"
	@echo "  make run ROM=../games/Donkey-Kong.nes CYCLES=5000000"
