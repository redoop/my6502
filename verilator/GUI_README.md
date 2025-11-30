# NES Emulator GUI

## 功能
实时显示NES游戏画面的图形界面模拟器

## 依赖
- SDL2 (已安装: 2.32.10)

## 编译
```bash
make gui
```

## 运行
```bash
./obj_dir/Vnes_gui <rom_file>
```

或使用Makefile:
```bash
make gui_run ROM=../games/Donkey-Kong.nes
```

## 特性
- **实时渲染**: 256x240分辨率，3倍放大
- **FPS显示**: 窗口标题显示当前帧率
- **键盘控制**: ESC退出

## 窗口
- 分辨率: 768x720 (256x240 × 3)
- 标题: "NES Emulator - XX FPS"
- 居中显示

## 性能
- 使用SDL2硬件加速渲染
- 优化的像素更新（仅在VSync时）
- 实时FPS计数器

## 控制
- **ESC**: 退出模拟器
- **关闭窗口**: 退出

## 示例
```bash
# 运行Donkey Kong
make gui_run ROM=../games/Donkey-Kong.nes

# 运行Super Mario Bros
make gui_run ROM=../games/Super-Mario-Bros.nes
```

## 调试
程序会输出调试信息到终端：
- ROM加载信息
- CPU执行状态
- PPU寄存器写入
- 调色板更新

## 已知问题
- 游戏可能卡在初始化阶段（等待VBlank）
- 使用默认调色板进行测试
- 部分游戏可能需要完整的CPU指令支持

## 技术细节
- 使用SDL2纹理流式更新
- 每帧完整更新framebuffer
- VSync同步显示
- 硬件加速渲染
