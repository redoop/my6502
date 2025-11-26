package cpu6502

import chisel3._
import chisel3.stage.ChiselStage

object GenerateCPU6502 extends App {
  println("Generating Verilog for CPU6502Refactored...")
  (new ChiselStage).emitVerilog(
    new CPU6502Refactored,
    Array(
      "--target-dir", "generated/cpu6502",
      "--emission-options", "disableMemRandomization,disableRegisterRandomization"
    )
  )
  println("Verilog generated in generated/cpu6502/CPU6502Refactored.v")
}

object GenerateCPU6502Refactored extends App {
  println("Generating Verilog for CPU6502Refactored...")
  (new ChiselStage).emitVerilog(
    new CPU6502Refactored,
    Array(
      "--target-dir", "generated/cpu6502_refactored",
      "--emission-options", "disableMemRandomization,disableRegisterRandomization"
    )
  )
  println("Verilog generated in generated/cpu6502_refactored/CPU6502Refactored.v")
}

object GenerateBoth extends App {
  println("=" * 60)
  println("Generating Verilog for CPU6502Refactored...")
  println("=" * 60)
  
  println("\nGenerating refactored CPU6502Refactored...")
  (new ChiselStage).emitVerilog(
    new CPU6502Refactored,
    Array(
      "--target-dir", "generated/cpu6502_refactored",
      "--emission-options", "disableMemRandomization,disableRegisterRandomization"
    )
  )
  println("✓ Refactored CPU6502 generated: generated/cpu6502_refactored/CPU6502Refactored.v")
  
  println("\n" + "=" * 60)
  println("Generation complete!")
  println("=" * 60)
}
