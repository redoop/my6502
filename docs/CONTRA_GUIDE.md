# 在 Chisel 6502 上运行魂斗罗指南

## 🎮 概述

本指南说明如何在这个 Chisel 6502 CPU 上运行魂斗罗（Contra）游戏。

## 📋 当前状态

### ✅ 已完成
- **CPU 6502**: 完整实现，通过所有功能测试
- **基础 PPU**: 寄存器、VBlank、NMI 中断
- **内存控制器**: NES 内存映射
- **系统集成**: CPU + PPU + Memory

### 🚧 进行中
- **PPU 渲染**: 背景和精灵渲染
- **Mapper 支持**: MMC3 (魂斗罗需要)

### ⏳ 待实现
- **APU**: 音频处理
- **完整控制器**: 手柄输入
- **ROM 加载器**: 加载游戏 ROM

## 🎯 运行魂斗罗的步骤

### 第 1 步：验证 CPU ✅

CPU 已经完成并通过测试：

```bash
# 运行 CPU 测试
sbt "testOnly cpu6502.CPU6502Test"

# 运行功能测试
sbt "testOnly cpu6502.FunctionalTest"
```

### 第 2 步：测试 NES 系统 ✅

基础系统已经可以运行：

```bash
# 运行 NES 系统测试
sbt "testOnly nes.NESSystemTest"

# 生成 Verilog
sbt "runMain nes.GenerateNESVerilog"
```

输出文件：`generated/nes/NESSystem.v`

### 第 3 步：实现 PPU 渲染 🚧

需要实现以下功能：

#### 3.1 背景渲染
```scala
// 需要添加到 PPU.scala
class BackgroundRenderer extends Module {
  // Nametable 读取
  // Pattern table 解码
  // 调色板查找
  // 滚动支持
}
```

#### 3.2 精灵渲染
```scala
// 需要添加到 PPU.scala
class SpriteRenderer extends Module {
  // OAM 扫描
  // 精灵评估
  // 精灵渲染
  // 精灵 0 碰撞
}
```

#### 3.3 调色板系统
```scala
// NES 调色板 (64 色)
val nesPalette = Seq(
  0x666666, 0x002A88, 0x1412A7, // ...
)
```

### 第 4 步：实现 MMC3 Mapper 🚧

魂斗罗使用 MMC3 mapper，需要实现：

```scala
class MMC3Mapper extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(16.W))
    val cpuData = Input(UInt(8.W))
    val cpuWrite = Input(Bool())
    
    // PRG ROM bank switching
    val prgBank = Output(Vec(4, UInt(14.W)))
    
    // CHR ROM bank switching
    val chrBank = Output(Vec(8, UInt(10.W)))
    
    // IRQ 计数器
    val irqOut = Output(Bool())
  })
  
  // Bank 寄存器
  val bankSelect = RegInit(0.U(3.W))
  val prgBanks = RegInit(VecInit(Seq.fill(4)(0.U(14.W))))
  val chrBanks = RegInit(VecInit(Seq.fill(8)(0.U(10.W))))
  
  // IRQ 计数器
  val irqCounter = RegInit(0.U(8.W))
  val irqReload = RegInit(0.U(8.W))
  val irqEnable = RegInit(false.B)
  
  // 实现 bank switching 逻辑
  // ...
}
```

### 第 5 步：加载魂斗罗 ROM 🚧

魂斗罗 ROM 信息：
- **文件名**: Contra (USA).nes
- **大小**: 256KB (含 iNES header)
- **PRG ROM**: 128KB (8 x 16KB banks)
- **CHR ROM**: 128KB (16 x 8KB banks)
- **Mapper**: 4 (MMC3)
- **Mirroring**: Horizontal

```scala
// ROM 加载器
object ROMLoader {
  def loadNESROM(filename: String): NESROMData = {
    val bytes = Files.readAllBytes(Paths.get(filename))
    
    // 解析 iNES header
    val header = bytes.slice(0, 16)
    val prgSize = header(4) * 16384  // 16KB units
    val chrSize = header(5) * 8192   // 8KB units
    val mapper = (header(6) >> 4) | (header(7) & 0xF0)
    
    // 提取 ROM 数据
    val prgROM = bytes.slice(16, 16 + prgSize)
    val chrROM = bytes.slice(16 + prgSize, 16 + prgSize + chrSize)
    
    NESROMData(prgROM, chrROM, mapper)
  }
}
```

### 第 6 步：集成所有组件 ⏳

```scala
class ContraSystem extends Module {
  val io = IO(new Bundle {
    val videoOut = Output(new VideoSignal)
    val audioOut = Output(UInt(16.W))
    val controller = Input(UInt(8.W))
  })
  
  // 组件
  val cpu = Module(new CPU6502)
  val ppu = Module(new PPU)
  val apu = Module(new APU)
  val mapper = Module(new MMC3Mapper)
  val memory = Module(new MemoryController)
  
  // 连接所有组件
  // ...
  
  // 加载魂斗罗 ROM
  val contraROM = ROMLoader.loadNESROM("Contra.nes")
  // ...
}
```

## 🧪 测试策略

### 1. 单元测试
```bash
# 测试各个组件
sbt "testOnly nes.PPUTest"
sbt "testOnly nes.MMC3Test"
sbt "testOnly nes.MemoryControllerTest"
```

### 2. 集成测试
```bash
# 测试简单的 NES 程序
sbt "testOnly nes.SimpleROMTest"
```

### 3. 游戏测试
```bash
# 先测试简单游戏
sbt "testOnly nes.DonkeyKongTest"  # NROM mapper

# 再测试魂斗罗
sbt "testOnly nes.ContraTest"      # MMC3 mapper
```

## 📊 开发进度

| 组件 | 状态 | 完成度 | 说明 |
|------|------|--------|------|
| CPU 6502 | ✅ | 100% | 完整实现 |
| 基础 PPU | ✅ | 30% | 寄存器和时序 |
| PPU 渲染 | 🚧 | 0% | 待实现 |
| Memory | ✅ | 80% | 基础映射完成 |
| MMC3 | 🚧 | 0% | 待实现 |
| APU | ⏳ | 0% | 未开始 |
| 控制器 | ✅ | 50% | 基础接口 |
| ROM 加载 | ⏳ | 0% | 未开始 |

## 🎯 里程碑

### 里程碑 1: 显示静态画面 (2-3 周)
- [ ] 实现背景渲染
- [ ] 实现调色板
- [ ] 显示魂斗罗标题画面

### 里程碑 2: 显示动画 (1-2 周)
- [ ] 实现精灵渲染
- [ ] 实现滚动
- [ ] 显示游戏画面

### 里程碑 3: 可玩游戏 (2-3 周)
- [ ] 实现 MMC3 mapper
- [ ] 实现控制器输入
- [ ] 可以玩第一关

### 里程碑 4: 完整体验 (1-2 周)
- [ ] 实现 APU
- [ ] 优化性能
- [ ] 完整游戏体验

**总计：约 6-10 周**

## 🔧 开发工具

### 调试工具
- **FCEUX**: NES 模拟器和调试器
- **Mesen**: 高精度模拟器
- **NesDev Wiki**: 技术文档

### 测试 ROM
1. **nestest.nes**: CPU 测试
2. **sprite_hit_tests**: 精灵测试
3. **ppu_vbl_nmi**: VBlank 测试
4. **mmc3_test**: MMC3 测试

### 波形查看
```bash
# 生成 VCD 波形
sbt "testOnly nes.NESSystemTest"

# 使用 GTKWave 查看
gtkwave test_run_dir/*/NESSystem.vcd
```

## 📚 参考资料

### 必读文档
1. [NesDev Wiki](https://www.nesdev.org/)
2. [PPU Rendering](https://www.nesdev.org/wiki/PPU_rendering)
3. [MMC3 Mapper](https://www.nesdev.org/wiki/MMC3)
4. [Contra Technical Info](https://www.nesdev.org/wiki/Contra)

### 开源实现
1. [FPGANES](https://github.com/strigeus/fpganes)
2. [Mesen Source](https://github.com/SourMesen/Mesen2)
3. [FCEUX Source](https://github.com/TASEmulators/fceux)

### 视频教程
1. [NES Emulator From Scratch](https://www.youtube.com/watch?v=F8kx56OZQhg)
2. [How the NES Works](https://www.youtube.com/watch?v=fWqBmmPQP40)

## 💡 快速开始

想要快速看到效果？从简单的开始：

### 1. 运行测试 ROM
```scala
// 加载 nestest.nes
val testROM = ROMLoader.loadNESROM("nestest.nes")
// 运行并对比日志
```

### 2. 显示简单图形
```scala
// 写入 nametable
for (i <- 0 until 960) {
  ppu.writeVRAM(0x2000 + i, 0x01)  // 填充图案
}
```

### 3. 移动精灵
```scala
// 写入 OAM
ppu.writeOAM(0, y)      // Y 坐标
ppu.writeOAM(1, 0x01)   // 图案索引
ppu.writeOAM(2, 0x00)   // 属性
ppu.writeOAM(3, x)      // X 坐标
```

## 🤝 贡献

欢迎贡献！优先级：

1. **高优先级**
   - PPU 背景渲染
   - PPU 精灵渲染
   - MMC3 mapper

2. **中优先级**
   - APU 实现
   - ROM 加载器
   - 测试 ROM 集成

3. **低优先级**
   - 性能优化
   - 其他 mapper
   - 调试工具

## 📞 联系

有问题？欢迎提 Issue 或 PR！

---

**注意**: 这是一个教育项目。请确保你拥有合法的游戏 ROM。
