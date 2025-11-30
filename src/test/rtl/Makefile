RTL_DIR = ../../main/rtl
VERILATOR = verilator
VFLAGS = --cc -Wall -Wno-fatal --exe
GAMES_DIR = ../../../games

.PHONY: all clean run_mario run_nestest

all: runner

runner: nes_runner.cpp
	@echo "Building NES runner..."
	$(VERILATOR) $(VFLAGS) --top-module nes_system \
		--Mdir obj_dir --build \
		nes_runner.cpp \
		$(RTL_DIR)/nes_system.sv \
		$(RTL_DIR)/cpu_6502.sv \
		$(RTL_DIR)/nes_ppu.sv \
		$(RTL_DIR)/nes_apu.sv \
		$(RTL_DIR)/nes_dma.sv
	@echo "Runner built successfully"

run_mario: runner
	@echo "Running Super Mario Bros..."
	./obj_dir/Vnes_system $(GAMES_DIR)/Super-Mario-Bros.nes

run_nestest: runner
	@echo "Running nestest..."
	./obj_dir/Vnes_system $(GAMES_DIR)/nestest.nes

clean:
	rm -rf obj_dir

render: nes_render.cpp
	@echo "Building NES renderer..."
	$(VERILATOR) $(VFLAGS) --top-module nes_system \
		--Mdir obj_dir --build \
		nes_render.cpp \
		$(RTL_DIR)/nes_system.sv \
		$(RTL_DIR)/cpu_6502.sv \
		$(RTL_DIR)/nes_ppu.sv \
		$(RTL_DIR)/nes_apu.sv \
		$(RTL_DIR)/nes_dma.sv
	@echo "Renderer built successfully"

render_mario: render
	@echo "Rendering Super Mario Bros..."
	./obj_dir/Vnes_system $(GAMES_DIR)/Super-Mario-Bros.nes 180

render_nestest: render
	@echo "Rendering nestest..."
	./obj_dir/Vnes_system $(GAMES_DIR)/nestest.nes 60
