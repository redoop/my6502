RTL_DIR = ../../main/rtl
VERILATOR = verilator
VFLAGS = --cc -Wall -Wno-fatal --exe
GAMES_DIR = ../../../games

.PHONY: all clean run_mario run_nestest

all: runner_nrom runner_mmc3

runner_nrom: nes_runner.cpp
	@echo "Building NES runner (NROM)..."
	$(VERILATOR) $(VFLAGS) --top-module nes_system \
		-GMAPPER=0 \
		--Mdir obj_dir_nrom --build \
		nes_runner.cpp \
		$(RTL_DIR)/nes_system.sv \
		$(RTL_DIR)/cpu_6502.sv \
		$(RTL_DIR)/nes_ppu.sv \
		$(RTL_DIR)/nes_apu.sv \
		$(RTL_DIR)/nes_dma.sv
	@echo "NROM runner built successfully"

runner_mmc3: nes_runner.cpp
	@echo "Building NES runner (MMC3)..."
	$(VERILATOR) $(VFLAGS) --top-module nes_system \
		-GMAPPER=4 \
		--Mdir obj_dir_mmc3 --build \
		nes_runner.cpp \
		$(RTL_DIR)/nes_system.sv \
		$(RTL_DIR)/cpu_6502.sv \
		$(RTL_DIR)/nes_ppu.sv \
		$(RTL_DIR)/nes_apu.sv \
		$(RTL_DIR)/nes_dma.sv \
		$(RTL_DIR)/mapper_mmc3.sv
	@echo "MMC3 runner built successfully"

run_mario: runner_mmc3
	@echo "Running Super Mario Bros..."
	./obj_dir_mmc3/Vnes_system $(GAMES_DIR)/Super-Mario-Bros.nes

run_nestest: runner_nrom
	@echo "Running nestest..."
	./obj_dir_nrom/Vnes_system $(GAMES_DIR)/nestest.nes

clean:
	rm -rf obj_dir obj_dir_nrom obj_dir_mmc3

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
