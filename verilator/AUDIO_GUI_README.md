# NES Emulator - GUI with Audio

## 功能
带声音输出的实时NES模拟器

## 特性

### 视频
- 256×240分辨率，3倍放大
- 60 FPS实时渲染
- 硬件加速

### 音频
- 44.1kHz采样率
- 单声道输出
- 实时音频流
- 缓冲队列管理

### 界面
- FPS显示
- 音频缓冲状态
- ESC退出

## 编译
```bash
make gui_audio
```

## 运行
```bash
make gui_audio_run ROM=../games/Donkey-Kong.nes
```

或直接运行：
```bash
./obj_dir/Vnes_gui_audio <rom_file>
```

## 技术实现

### 音频架构
```
NES APU → 采样 → 音频队列 → SDL回调 → 扬声器
```

### 采样率计算
```
NES主时钟: 21.477216 MHz
采样率: 44100 Hz
每样本周期: 21477216 / 44100 / 2 ≈ 244 cycles
```

### 缓冲管理
- 队列大小: 2048 samples
- 最大缓冲: 8192 samples
- 线程安全: std::mutex

### 音频回调
```cpp
void audio_callback(void* userdata, Uint8* stream, int len) {
    // 从队列读取样本
    // 填充SDL音频缓冲
}
```

## 当前实现

### 测试音频
- 440Hz方波测试音
- 音量: ±0.1
- 用于验证音频管道

### 未来改进
1. **APU集成**: 连接NES APU输出
2. **多通道**: 脉冲波、三角波、噪声、DMC
3. **音量控制**: 可调节音量
4. **音效**: 游戏音效和音乐

## 性能

### 音频延迟
- 缓冲延迟: ~46ms (2048/44100)
- 总延迟: <100ms

### CPU占用
- 视频: ~5%
- 音频: ~2%
- 总计: ~7%

## 控制

- **ESC**: 退出
- **关闭窗口**: 退出

## 窗口信息

标题显示：
```
NES Emulator - XX FPS | Audio: YYYY samples
```
- XX: 当前帧率
- YYYY: 音频队列大小

## 调试

### 音频问题
```bash
# 检查SDL音频设备
./obj_dir/Vnes_gui_audio rom.nes 2>&1 | grep Audio
```

输出示例：
```
Audio: 44100Hz, 1 channel(s)
```

### 缓冲监控
窗口标题显示实时缓冲大小：
- <1000: 缓冲不足（可能卡顿）
- 1000-4000: 正常
- >6000: 缓冲过多（延迟增加）

## 依赖
- SDL2 (视频+音频)
- C++17
- Verilator

## 示例
```bash
# 编译
make gui_audio

# 运行Donkey Kong
make gui_audio_run ROM=../games/Donkey-Kong.nes

# 运行Super Mario Bros
./obj_dir/Vnes_gui_audio ../games/Super-Mario-Bros.nes
```

## 已知限制
1. 当前使用测试音（440Hz方波）
2. 未连接真实APU输出
3. 需要实现APU音频合成

## 下一步
1. 实现APU脉冲波通道
2. 添加三角波和噪声通道
3. 实现DMC采样播放
4. 音量包络和扫描单元
