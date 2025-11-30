# NES Emulator GUI

## 编译和运行

### 编译 GUI 版本
```bash
cd src/test/rtl
make smb_gui
```

### 运行 Super Mario Bros
```bash
make gui_smb
```

或直接运行：
```bash
./obj_dir_gui/Vnes_system ../../../games/Super-Mario-Bros.nes
```

## 控制器映射

| NES 按键 | 键盘按键 |
|---------|---------|
| 方向键上  | ↑       |
| 方向键下  | ↓       |
| 方向键左  | ←       |
| 方向键右  | →       |
| A 按钮   | X       |
| B 按钮   | Z       |
| START   | Enter   |
| SELECT  | Right Shift |

## 退出

按 **ESC** 键退出模拟器

## 窗口大小

- 分辨率：768x720 (NES 原生 256x240 的 3 倍放大)
- 实时 60 FPS 渲染

## 系统要求

- SDL2 库
- Verilator 5.x
- C++17 编译器

## 性能

模拟器以实时速度运行，每帧约 30000 个时钟周期。
实际 FPS 取决于主机性能。

## 调试

控制台会显示：
- ROM 加载信息（PRG/CHR 大小，Mapper 类型）
- 每 60 帧输出一次帧计数
- 退出时显示总帧数

## 已知问题

- Super Mario Bros (384KB 版本) 卡在初始化循环
- 需要标准 40KB 版本或 Mapper 1 (MMC1) 支持
- 当前实现支持 Mapper 0 (NROM) 和 Mapper 4 (MMC3)
