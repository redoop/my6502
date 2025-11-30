# Project Structure Guidelines

## Directory Organization

- **`src/`** - All source code
  - `src/main/rtl/` - SystemVerilog/RTL code
  - `src/main/scala/` - Chisel/Scala code (main branch only)
  - `src/test/` - Test code

- **`docs/`** - All documentation
  - Project documentation
  - Design specifications
  - Debug logs and reports

- **`scripts/`** - All scripts
  - Build scripts
  - Test scripts
  - Utility scripts

- **Root directory** - Keep clean
  - Only core configuration files (`.gitignore`, `Makefile`, etc.)
  - No temporary files or documents

## Branch Strategy

- **`main`** - Chisel/Scala implementation
- **`systemverilog`** - Pure SystemVerilog implementation (nes_system.sv)
