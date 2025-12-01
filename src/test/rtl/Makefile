RTL_DIR = ../../main/rtl
VERILATOR = verilator
VFLAGS = --cc -Wall -Wno-fatal --exe
GAMES_DIR = ../../../games

.PHONY: all clean run_mario run_nestest render_smb gui_smb gui_smb_mmc1 interactive

all: runner_nrom runner_mmc1 runner_mmc3 interactive

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

runner_mmc1: nes_runner.cpp
	@echo "Building NES runner (MMC1)..."
	$(VERILATOR) $(VFLAGS) --top-module nes_system \
		-GMAPPER=1 \
		--Mdir obj_dir_mmc1 --build \
		nes_runner.cpp \
		$(RTL_DIR)/nes_system.sv \
		$(RTL_DIR)/cpu_6502.sv \
		$(RTL_DIR)/nes_ppu.sv \
		$(RTL_DIR)/nes_apu.sv \
		$(RTL_DIR)/nes_dma.sv \
		$(RTL_DIR)/mapper_mmc1.sv
	@echo "MMC1 runner built successfully"

run_mario: runner_mmc3
	@echo "Running Super Mario Bros 3..."
	./obj_dir_mmc3/Vnes_system $(GAMES_DIR)/SuperMarioBros3_mapper4.nes

run_nestest: runner_nrom
	@echo "Running nestest..."
	./obj_dir_nrom/Vnes_system $(GAMES_DIR)/nestest_mapper0.nes

smb_render: smb_render.cpp
	@echo "Building SMB renderer..."
	$(VERILATOR) $(VFLAGS) --top-module nes_system \
		-GMAPPER=4 \
		--Mdir obj_dir_smb --build \
		smb_render.cpp \
		$(RTL_DIR)/nes_system.sv \
		$(RTL_DIR)/cpu_6502.sv \
		$(RTL_DIR)/nes_ppu.sv \
		$(RTL_DIR)/nes_apu.sv \
		$(RTL_DIR)/nes_dma.sv \
		$(RTL_DIR)/mapper_mmc3.sv
	@echo "SMB renderer built successfully"

render_smb: smb_render
	@echo "Rendering Super Mario Bros 3..."
	./obj_dir_smb/Vnes_system $(GAMES_DIR)/SuperMarioBros3_mapper4.nes

smb_gui: smb_gui.cpp
	@echo "Building SMB GUI..."
	$(VERILATOR) $(VFLAGS) --top-module nes_system \
		-GMAPPER=4 \
		--Mdir obj_dir_gui --build \
		-CFLAGS "`sdl2-config --cflags`" \
		-LDFLAGS "`sdl2-config --libs`" \
		smb_gui.cpp \
		$(RTL_DIR)/nes_system.sv \
		$(RTL_DIR)/cpu_6502.sv \
		$(RTL_DIR)/nes_ppu.sv \
		$(RTL_DIR)/nes_apu.sv \
		$(RTL_DIR)/nes_dma.sv \
		$(RTL_DIR)/mapper_mmc3.sv
	@echo "SMB GUI built successfully"

gui_smb: smb_gui
	@echo "Running Super Mario Bros 3 with GUI..."
	./obj_dir_gui/Vnes_system $(GAMES_DIR)/SuperMarioBros3_mapper4.nes

smb_gui_mmc1: smb_gui.cpp
	@echo "Building SMB GUI (MMC1)..."
	$(VERILATOR) $(VFLAGS) --top-module nes_system \
		-GMAPPER=1 \
		--Mdir obj_dir_gui_mmc1 --build \
		-CFLAGS "`sdl2-config --cflags`" \
		-LDFLAGS "`sdl2-config --libs`" \
		smb_gui.cpp \
		$(RTL_DIR)/nes_system.sv \
		$(RTL_DIR)/cpu_6502.sv \
		$(RTL_DIR)/nes_ppu.sv \
		$(RTL_DIR)/nes_apu.sv \
		$(RTL_DIR)/nes_dma.sv \
		$(RTL_DIR)/mapper_mmc1.sv
	@echo "SMB GUI (MMC1) built successfully"

gui_smb_mmc1: smb_gui_mmc1
	@echo "Running Super Mario Bros with GUI (Mapper 0)..."
	./obj_dir_gui_mmc1/Vnes_system $(GAMES_DIR)/SuperMarioBros_mapper0.nes

clean:
	rm -rf obj_dir obj_dir_nrom obj_dir_mmc1 obj_dir_mmc3 obj_dir_smb obj_dir_gui obj_dir_gui_mmc1 *.ppm

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
	@echo "Rendering Super Mario Bros 3..."
	./obj_dir/Vnes_system $(GAMES_DIR)/SuperMarioBros3_mapper4.nes 180

render_nestest: render
	@echo "Rendering nestest..."
	./obj_dir/Vnes_system $(GAMES_DIR)/nestest_mapper0.nes 60

interactive: run_interactive.cpp
	@echo "Building interactive runner..."
	$(VERILATOR) $(VFLAGS) --top-module cpu_6502 \
		--Mdir obj_dir_interactive --build \
		run_interactive.cpp \
		$(RTL_DIR)/cpu_6502.sv \
		-o Vinteractive
	@echo "Interactive runner built successfully"
