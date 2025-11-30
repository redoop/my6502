# NES APU 音频使用指南

## 快速开始

### 1. 编译带音频支持的模拟器
```bash
cd src/test/rtl
make smb_gui_mmc1
```

### 2. 运行游戏
```bash
# Super Mario Bros
./obj_dir_gui_mmc1/Vnes_system ../../../games/SuperMarioBros_mapper0.nes

# The Legend of Zelda
./obj_dir_gui_mmc1/Vnes_system ../../../games/Zelda_mapper1.nes

# Donkey Kong
./obj_dir_gui_mmc1/Vnes_system ../../../games/DonkeyKong_mapper0.nes
```

### 3. 或使用测试脚本
```bash
./test_audio.sh
```

## 音频特性

### 支持的音频通道
1. **Pulse 1** - 脉冲波通道1（旋律）
2. **Pulse 2** - 脉冲波通道2（和声）
3. **Triangle** - 三角波通道（低音）
4. **Noise** - 噪声通道（打击乐/音效）
5. **DMC** - Delta调制通道（采样，当前未实现）

### 音频规格
- **采样率**: 44.1 kHz
- **位深度**: 16-bit
- **声道**: 立体声 (Stereo)
- **延迟**: < 20ms

## 音频控制

### 游戏中的音频
大多数NES游戏会自动播放音乐和音效：
- **背景音乐**: 自动循环播放
- **音效**: 响应游戏事件（跳跃、碰撞、收集等）

### 系统音量
使用系统音量控制调节音量：
- **macOS**: 使用音量键或系统设置
- **Linux**: 使用alsamixer或pavucontrol
- **Windows**: 使用音量混合器

## 故障排除

### 没有声音
1. **检查SDL2音频初始化**
   ```
   应该看到: "Audio: 44100Hz, 2 channels"
   ```

2. **检查系统音量**
   - 确保系统音量未静音
   - 确保应用程序音量未静音

3. **检查音频设备**
   ```bash
   # macOS
   system_profiler SPAudioDataType
   
   # Linux
   aplay -l
   ```

### 音频卡顿或延迟
1. **降低缓冲区大小** (在smb_gui.cpp中)
   ```cpp
   want.samples = 256;  // 默认512
   ```

2. **增加队列大小限制**
   ```cpp
   if (SDL_GetQueuedAudioSize(audio_device) < 16384) {  // 默认8192
   ```

### 音频失真
1. **检查音量混合**
   - 当前使用简单线性混合
   - 多个通道同时播放可能导致削波

2. **调整混合比例** (在nes_apu.sv中)
   ```systemverilog
   // 降低音量避免削波
   mixed_output = (pulse_sum + tnd_sum) >> 1;
   ```

## 技术细节

### APU寄存器
```
$4000-$4003: Pulse 1 (占空比, 包络, 频率)
$4004-$4007: Pulse 2 (占空比, 包络, 频率)
$4008-$400B: Triangle (线性计数器, 频率)
$400C-$400F: Noise (包络, 周期, 模式)
$4010-$4013: DMC (频率, 采样地址, 长度)
$4015: 通道使能/状态
$4017: 帧计数器模式
```

### 音频流程
```
游戏写入APU寄存器
    ↓
APU生成音频波形 (1.79 MHz)
    ↓
采样率转换 (~44.7 kHz)
    ↓
SDL2音频队列
    ↓
系统音频输出
```

### 性能优化
- APU在硬件模拟中运行，CPU开销最小
- 音频缓冲区使用非阻塞队列
- 自动丢弃过多的音频数据防止延迟累积

## 开发者信息

### 修改音频输出
编辑 `src/test/rtl/smb_gui.cpp`:
```cpp
// 修改采样率
want.freq = 48000;  // 默认44100

// 修改缓冲区大小
want.samples = 1024;  // 默认512

// 修改队列阈值
if (SDL_GetQueuedAudioSize(audio_device) < 4096) {  // 默认8192
```

### 修改APU实现
编辑 `src/main/rtl/nes_apu.sv`:
```systemverilog
// 修改采样分频器
if (sample_divider >= 40) begin  // 默认40 (~44.7kHz)

// 修改音频混合
mixed_output = {pulse_sum, 8'b0} + {tnd_sum, 8'b0};
```

### 添加音频滤波
在C++端添加简单的高通滤波器：
```cpp
// 移除DC偏移
static int16_t last_sample = 0;
int16_t filtered = sample - last_sample;
last_sample = sample;
audio_buffer.push_back(filtered);
```

## 已知限制

1. **DMC通道未实现**
   - 使用PCM采样的游戏可能缺少某些音效
   - 例如：Super Mario Bros 3的鼓声

2. **简单混合算法**
   - 未实现NES的非线性混合曲线
   - 可能与真实硬件音质略有差异

3. **无频率扫描**
   - 脉冲通道的频率扫描单元未实现
   - 某些音效（如滑音）可能不正确

4. **无IRQ支持**
   - 帧计数器和DMC的IRQ未实现
   - 极少数游戏可能依赖这些功能

## 参考资料

- [NESdev APU Wiki](https://www.nesdev.org/wiki/APU)
- [APU实现总结](APU实现总结.md)
- [SDL2 Audio Documentation](https://wiki.libsdl.org/SDL2/CategoryAudio)

## 反馈

如果遇到音频问题或有改进建议，请：
1. 检查上述故障排除步骤
2. 查看APU实现文档
3. 提交issue并附上：
   - 游戏ROM名称
   - 音频问题描述
   - 系统信息（OS, SDL2版本）
   - 控制台输出
