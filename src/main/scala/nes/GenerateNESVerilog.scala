package nes

import chisel3._
import chisel3.stage.ChiselStage

object GenerateNESVerilog extends App {
  println("Generating Verilog for NES System...")
  
  (new ChiselStage).emitVerilog(
    new NESSystem,
    Array(
      "--target-dir", "generated/nes",
      "--emission-options", "disableMemRandomization,disableRegisterRandomization"
    )
  )
  
  println("Verilog generated in generated/nes/")
  println("\nGenerated files:")
  println("  - NESSystem.v")
  println("\nYou can now synthesize this for FPGA or use in simulation.")
}

object GeneratePPUVerilog extends App {
  println("Generating Verilog for PPU...")
  
  (new ChiselStage).emitVerilog(
    new PPU,
    Array(
      "--target-dir", "generated/nes",
      "--emission-options", "disableMemRandomization,disableRegisterRandomization"
    )
  )
  
  println("PPU Verilog generated in generated/nes/")
}
