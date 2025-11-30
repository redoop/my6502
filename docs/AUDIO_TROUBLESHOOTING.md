# 音频问题排查

## 当前状态

### 问题
- ✅ 音频管道已实现
- ✅ SDL音频初始化成功
- ❌ 游戏未写入APU寄存器
- ❌ 游戏卡在初始化阶段

### 根本原因
游戏没有执行到音频初始化代码，因为：
1. CPU卡在VBlank等待循环
2. 游戏需要完整的CPU指令集
3. 可能需要特定的mapper支持

## 测试音验证

### 当前实现
APU包含440Hz测试音，用于验证音频管道：

```systemverilog
// 测试音生成器
test_counter <= test_counter + 1;
if (test_counter >= 2034) begin  // ~440Hz
    test_tone <= ~test_tone[15] ? 16'h2000 : 16'h0000;
end
```

### 验证步骤
1. 运行GUI: `./obj_dir/Vnes_gui_audio rom.nes`
2. 应该听到持续的440Hz音调
3. 如果听到 = 音频管道工作正常
4. 如果听不到 = 检查系统音量/SDL配置

## 音频管道架构

```
APU寄存器 → 脉冲波合成 → 混音器 → SDL队列 → 音频回调 → 扬声器
   ↓            ↓            ↓
游戏写入    周期计数器    test_tone
$4000-$4007  占空比查表   (440Hz)
```

## 调试命令

### 检查APU写入
```bash
./obj_dir/Vnes_gui_audio rom.nes 2>&1 | grep APU
```

期望输出：
```
[APU] Pulse1[$0] = $xx
[APU] Pulse1[$1] = $xx
...
```

### 检查音频初始化
```bash
./obj_dir/Vnes_gui_audio rom.nes 2>&1 | grep Audio
```

期望输出：
```
Audio: 44100Hz, 1 channel(s)
```

### 监控音频队列
窗口标题显示：
```
NES Emulator - XX FPS | Audio: YYYY samples
```
- YYYY应该在1000-4000之间

## 为什么听不到游戏音乐

### 原因1: 游戏未初始化
游戏卡在VBlank等待，未执行到音频代码：
```
[PPU] $2002 read: VBlank=0 status=$00  (重复162k次)
```

### 原因2: CPU指令不完整
游戏可能使用了未实现的CPU指令

### 原因3: Mapper支持
Donkey Kong使用特定的mapper，可能需要额外支持

## 解决方案

### 短期：测试音
当前APU包含440Hz测试音，验证音频管道工作

### 中期：修复游戏初始化
1. 调试CPU执行流程
2. 确保VBlank正确设置/清除
3. 实现缺失的CPU指令

### 长期：完整APU
1. 实现三角波通道
2. 实现噪声通道
3. 实现DMC采样播放
4. 添加音量包络

## 测试其他ROM

尝试更简单的测试ROM：
```bash
# 使用NES测试ROM
./obj_dir/Vnes_gui_audio ../games/nes-test-roms/apu_test/1-len_ctr.nes
```

## 音频参数

### SDL配置
- 采样率: 44100 Hz
- 格式: AUDIO_F32 (32-bit float)
- 声道: 1 (单声道)
- 缓冲: 2048 samples

### APU时钟
- NES主时钟: 21.477216 MHz
- CPU时钟: 1.789773 MHz
- 每样本周期: ~244 CPU cycles

## 下一步

1. **验证测试音**: 确认能听到440Hz音调
2. **调试游戏初始化**: 修复VBlank等待问题
3. **实现完整CPU**: 添加缺失指令
4. **测试简单ROM**: 使用APU测试ROM验证
