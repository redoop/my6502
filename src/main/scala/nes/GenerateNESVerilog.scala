package nes

import chisel3._
import chisel3.stage.ChiselStage

object GenerateNESVerilog extends App {
  println("Generating Verilog for NES System Refactored...")
  
  (new ChiselStage).emitVerilog(
    new NESSystemRefactored(enableDebug = true),  // 启用调试
    Array(
      "--target-dir", "generated/nes",
      "--emission-options", "disableMemRandomization,disableRegisterRandomization",
      "-o", "NESSystem"  // 输出文件名为 NESSystem.v
    )
  )
  
  println("Verilog generated in generated/nes/")
  println("\nGenerated files:")
  println("  - NESSystem.v")
  println("\nYou can now synthesize this for FPGA or use in simulation.")
}

object GeneratePPUVerilog extends App {
  println("Generating Verilog for PPU Refactored...")
  
  (new ChiselStage).emitVerilog(
    new PPURefactored,
    Array(
      "--target-dir", "generated/nes",
      "--emission-options", "disableMemRandomization,disableRegisterRandomization"
    )
  )
  
  println("PPU Verilog generated in generated/nes/")
}
