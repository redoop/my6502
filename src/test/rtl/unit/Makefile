# Unit Test Makefile

RTL_DIR = ../../../main/rtl
VERILATOR = verilator
VFLAGS = --binary --trace -Wall -Wno-fatal

TESTS = test_dma test_apu test_ppu test_cpu test_nmi test_ppu_render

.PHONY: all clean $(TESTS)

all: $(TESTS)

test_dma: test_dma.sv $(RTL_DIR)/nes_dma.sv
	@echo "Testing DMA..."
	@mkdir -p waveforms
	$(VERILATOR) $(VFLAGS) --top-module test_dma $^
	./obj_dir/Vtest_dma
	@echo ""

test_apu: test_apu.sv $(RTL_DIR)/nes_apu.sv
	@echo "Testing APU..."
	@mkdir -p waveforms
	$(VERILATOR) $(VFLAGS) --top-module test_apu $^
	./obj_dir/Vtest_apu
	@echo ""

test_ppu: test_ppu.sv $(RTL_DIR)/nes_ppu.sv
	@echo "Testing PPU..."
	@mkdir -p waveforms
	$(VERILATOR) $(VFLAGS) --top-module test_ppu $^
	./obj_dir/Vtest_ppu
	@echo ""

test_cpu: test_cpu.sv $(RTL_DIR)/cpu_6502.sv
	@echo "Testing CPU..."
	@mkdir -p waveforms
	$(VERILATOR) $(VFLAGS) --top-module test_cpu $^
	./obj_dir/Vtest_cpu
	@echo ""

test_nmi: ../nmi_test.sv $(RTL_DIR)/nes_system.sv $(RTL_DIR)/cpu_6502.sv $(RTL_DIR)/nes_ppu.sv $(RTL_DIR)/nes_apu.sv $(RTL_DIR)/nes_dma.sv
	@echo "Testing NMI..."
	@mkdir -p waveforms
	$(VERILATOR) $(VFLAGS) --top-module nmi_test $^
	./obj_dir/Vnmi_test
	@echo ""

test_ppu_render: ../ppu_render_test.sv $(RTL_DIR)/nes_ppu.sv
	@echo "Testing PPU rendering..."
	@mkdir -p waveforms
	$(VERILATOR) $(VFLAGS) --top-module ppu_render_test $^
	./obj_dir/Vppu_render_test
	@echo ""

clean:
	rm -rf obj_dir waveforms

.PHONY: help
help:
	@echo "Unit Test Targets:"
	@echo "  make all       - Run all unit tests"
	@echo "  make test_dma  - Test DMA controller"
	@echo "  make test_apu  - Test APU audio"
	@echo "  make test_ppu  - Test PPU rendering"
	@echo "  make test_cpu  - Test CPU 6502"
	@echo "  make clean     - Clean build files"
