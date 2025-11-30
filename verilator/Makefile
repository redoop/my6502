# NES Game Testbench Makefile

RTL_DIR = ../src/main/rtl
VERILATOR = verilator

# RTL files
RTL_FILES = $(RTL_DIR)/nes_system.sv \
            $(RTL_DIR)/cpu_6502.sv \
            $(RTL_DIR)/nes_ppu.sv \
            $(RTL_DIR)/nes_apu.sv \
            $(RTL_DIR)/nes_dma.sv

.PHONY: all clean run help capture gui

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

capture:
	@mkdir -p frames
	$(VERILATOR) --cc --exe --build -Wall -Wno-fatal \
		--top-module nes_system \
		-CFLAGS "-std=c++17 -O3" \
		nes_capture_tb.cpp $(RTL_FILES) \
		-o Vnes_capture
	@echo "Build complete: obj_dir/Vnes_capture"

capture_run:
	@if [ -z "$(ROM)" ]; then \
		echo "Usage: make capture_run ROM=<path/to/rom.nes> [DIR=frames]"; \
		exit 1; \
	fi
	./obj_dir/Vnes_capture $(ROM) $(DIR)

gui:
	@echo "Building GUI emulator..."
	$(VERILATOR) --cc --exe --build -Wall -Wno-fatal \
		--top-module nes_system \
		-CFLAGS "-std=c++17 -O3 $$(sdl2-config --cflags)" \
		-LDFLAGS "$$(sdl2-config --libs)" \
		nes_gui_tb.cpp $(RTL_FILES) \
		-o Vnes_gui
	@echo "Build complete: obj_dir/Vnes_gui"

gui_run:
	@if [ -z "$(ROM)" ]; then \
		echo "Usage: make gui_run ROM=<path/to/rom.nes>"; \
		exit 1; \
	fi
	./obj_dir/Vnes_gui $(ROM)

clean:
	rm -rf obj_dir *.vcd frames

help:
	@echo "NES Game Testbench"
	@echo ""
	@echo "Targets:"
	@echo "  make all                    - Build testbench"
	@echo "  make run ROM=<file>         - Run NES ROM"
	@echo "  make capture                - Build frame capture tool"
	@echo "  make capture_run ROM=<file> - Capture frames to directory"
	@echo "  make gui                    - Build GUI emulator"
	@echo "  make gui_run ROM=<file>     - Run GUI emulator"
	@echo "  make clean                  - Clean build files"
	@echo ""
	@echo "Examples:"
	@echo "  make run ROM=../games/Donkey-Kong.nes"
	@echo "  make capture_run ROM=../games/Donkey-Kong.nes DIR=dk_frames"
	@echo "  make gui_run ROM=../games/Donkey-Kong.nes"
