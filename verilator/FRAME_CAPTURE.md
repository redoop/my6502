# NES Frame Capture Tool

## 功能
从NES游戏ROM中抽样导出画面帧到PPM图像文件。

## 编译
```bash
make capture
```

## 使用方法

### 基本用法
```bash
./obj_dir/Vnes_capture <rom_file> [output_dir] [interval]
```

### 参数
- `rom_file`: NES ROM文件路径（必需）
- `output_dir`: 输出目录（默认: frames）
- `interval`: 抽样间隔，每N帧保存一次（默认: 60）

### 示例

**每60帧保存一次（默认）**
```bash
./obj_dir/Vnes_capture ../games/Donkey-Kong.nes
```

**每10帧保存一次**
```bash
./obj_dir/Vnes_capture ../games/Donkey-Kong.nes dk_frames 10
```

**每帧都保存**
```bash
./obj_dir/Vnes_capture ../games/Super-Mario-Bros.nes mario_frames 1
```

## 输出格式
- 格式: PPM (P6)
- 分辨率: 256x240
- 文件名: frame_NNNN.ppm
- 大小: 约180KB/帧

## 转换为其他格式

### 使用ImageMagick转换为PNG
```bash
cd frames
for f in *.ppm; do convert "$f" "${f%.ppm}.png"; done
```

### 使用FFmpeg生成视频
```bash
ffmpeg -framerate 60 -pattern_type glob -i 'frames/*.ppm' \
       -c:v libx264 -pix_fmt yuv420p output.mp4
```

### 批量转换为GIF
```bash
convert -delay 1.67 -loop 0 frames/frame_*.ppm output.gif
```

## 性能
- 模拟速度: 约1-2秒/帧（取决于CPU）
- 最大帧数: 600帧（10秒@60fps）
- 可通过修改MAX_FRAMES调整

## 注意事项
1. PPM文件较大，建议使用抽样模式
2. 确保有足够磁盘空间（180KB×帧数）
3. 可以用Ctrl+C提前终止
4. 输出目录会自动创建

## 示例输出
```
ROM: PRG=16384 CHR=8192
Output: dk_frames (every 10 frames)
Frame 0 saved
Frame 10 saved
Frame 20 saved
...
Complete: 600 frames
```
