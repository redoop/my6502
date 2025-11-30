# Bug分析报告 - 画面全灰问题

## 问题描述
导出的所有帧都显示为单一灰色 RGB(84,84,84)

## 分析过程

### 1. 图像分析
```python
frame_0000.png: 单色: [84 84 84]
frame_0060.png: 单色: [84 84 84]
...所有帧都是相同灰色
```

### 2. 颜色追踪
- RGB(84,84,84) = 0x545454
- 在PPU调色板中对应索引 0x10
- 这是NES标准调色板的中灰色

### 3. 代码分析

**PPU调色板查找** (nes_ppu.sv:177-183)
```systemverilog
always_comb begin
    if (sprite_active && sprite_pixel != 0) 
        final_palette_idx = sprite_palette_idx;
    else 
        final_palette_idx = bg_palette_idx;
    
    palette_color = palette[final_palette_idx];
```

**调色板初始化** (nes_system.sv:78)
```systemverilog
for (int i = 0; i < 32; i++) palette[i] = 8'h00;
```

### 4. 根本原因

**可能原因1: 调色板未写入**
- 游戏ROM应该在启动时写入调色板($3F00-$3F1F)
- 但没有看到PALETTE写入的调试输出
- 说明游戏可能还没有初始化完成，或PPU地址写入有问题

**可能原因2: 背景渲染未启用**
- bg_palette_idx可能始终为0
- palette[0] = 0x00，但显示的是0x10
- 说明palette[0]可能被错误读取或有默认值

**可能原因3: PPUMASK未正确设置**
- 需要检查ppumask[3]和ppumask[4]是否启用了背景/精灵渲染

## Bug定位

### 主要问题
1. **调色板数据未加载** - palette数组全为0，但显示0x10
2. **PPU地址写入可能有问题** - $2006/$2007写入未生效
3. **背景渲染逻辑** - bg_palette_idx计算可能有误

### 需要检查的点
1. ✓ PPU调色板查找逻辑 - 代码正确
2. ✗ 调色板写入 - 未看到写入
3. ? PPUADDR/PPUDATA寄存器 - 需要验证
4. ? 背景tile/attribute读取 - 需要验证
5. ? VRAM初始化 - 可能全为0

## 下一步调试

### 方案1: 添加更多调试输出
```systemverilog
$display("[PPU] scanline=%d dot=%d bg_idx=%d palette_color=$%02x", 
         scanline, dot, bg_palette_idx, palette_color);
```

### 方案2: 检查PPUADDR/PPUDATA写入
```systemverilog
$display("[PPU_WRITE] addr=$%04x data=$%02x", ppuaddr, cpu_data_out);
```

### 方案3: 强制初始化调色板
```systemverilog
// 使用默认NES调色板
palette[0] = 8'h0F;  // 黑色
palette[1] = 8'h30;  // 白色
palette[2] = 8'h16;  // 红色
palette[3] = 8'h27;  // 绿色
```

### 方案4: 检查VRAM内容
验证nametable和attribute table是否有数据

## 结论
画面全灰的根本原因是**PPU渲染管线未正确工作**，最可能是：
1. 调色板未初始化
2. VRAM数据未加载
3. PPU寄存器写入有问题

需要进一步调试PPU寄存器写入和VRAM初始化流程。
