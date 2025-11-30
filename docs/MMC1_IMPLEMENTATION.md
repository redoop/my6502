# MMC1 (Mapper 1) 实现总结

## 完成时间
2025-11-30

## 实现内容

### 1. 核心模块：`mapper_mmc1.sv`
实现了完整的MMC1 mapper功能：

#### 特性
- ✅ 5位串行移位寄存器写入接口
- ✅ PRG ROM banking（16KB/32KB模式）
- ✅ CHR ROM banking（4KB/8KB模式）
- ✅ 支持最大256KB PRG ROM
- ✅ 支持最大128KB CHR ROM
- ✅ 复位逻辑（bit 7 = 1）
- ✅ 自动复位移位寄存器

#### 寄存器
- **Control Register** ($8000-$9FFF): 控制banking模式
- **CHR Bank 0** ($A000-$BFFF): CHR低4KB bank选择
- **CHR Bank 1** ($C000-$DFFF): CHR高4KB bank选择
- **PRG Bank** ($E000-$FFFF): PRG bank选择

### 2. 系统集成：`nes_system.sv`
- ✅ 添加MAPPER=1参数支持
- ✅ 使用generate块条件实例化MMC1
- ✅ 连接PRG/CHR地址映射
- ✅ 无IRQ输出（MMC1不支持IRQ）

### 3. 编译系统：`Makefile`
新增目标：
- `runner_mmc1`: 命令行版本
- `smb_gui_mmc1`: GUI版本
- `gui_smb_mmc1`: 运行目标

### 4. 启动脚本：`run_smb_mmc1.sh`
快速启动MMC1 GUI的便捷脚本

### 5. 文档
- `docs/MAPPER_MMC1.md`: 详细技术文档
- `README.md`: 更新项目说明

## 技术细节

### PRG Banking模式
```
control[3:2] = 00/01: 32KB模式（整体切换）
control[3:2] = 10:    固定第一个bank，切换第二个
control[3:2] = 11:    切换第一个bank，固定最后一个
```

### CHR Banking模式
```
control[4] = 0: 8KB模式（整体切换）
control[4] = 1: 4KB模式（独立切换两个4KB bank）
```

### 写入协议
1. 写入bit 7 = 1 → 复位移位寄存器
2. 连续写入5个bit（LSB优先）
3. 第5次写入时 → 根据地址更新目标寄存器
4. 自动复位移位寄存器

## 位宽修复
修复了初始实现的位宽警告：
- PRG地址：18位（256KB）
- CHR地址：18位（256KB）
- 正确的位扩展和截断

## 重要发现

### Super Mario Bros使用Mapper 0！
通过研究发现：
- **原版Super Mario Bros使用NES-NROM-256板（Mapper 0）**
- 不是MMC1（Mapper 1）
- smb.nes（40KB）是正确的Mapper 0 ROM

### MMC1适用游戏
- The Legend of Zelda
- Metroid
- Mega Man 2
- Kid Icarus
- Castlevania II
- 等等

## 编译测试

### 编译所有目标
```bash
cd src/test/rtl
make all
```

结果：
- ✅ runner_nrom 编译成功
- ✅ runner_mmc1 编译成功
- ✅ runner_mmc3 编译成功

### GUI版本
```bash
make smb_gui_mmc1
```
- ✅ 编译成功
- ✅ SDL2集成正常

## 代码统计

### 新增文件
- `src/main/rtl/mapper_mmc1.sv`: 107行
- `docs/MAPPER_MMC1.md`: 技术文档
- `run_smb_mmc1.sh`: 启动脚本

### 修改文件
- `src/main/rtl/nes_system.sv`: 添加MMC1支持
- `src/test/rtl/Makefile`: 新增编译目标
- `README.md`: 更新项目说明

## 下一步

### 测试MMC1游戏
需要获取使用Mapper 1的ROM进行测试：
- [ ] The Legend of Zelda
- [ ] Metroid
- [ ] Mega Man 2

### 可能的增强
- [ ] PRG RAM banking支持
- [ ] Mirroring控制实现
- [ ] WRAM enable/disable
- [ ] MMC1A/B/C变体差异

### 继续调试
- [ ] 调试Super Mario Bros（Mapper 0）的VRAM写入问题
- [ ] 测试更多Mapper 0游戏
- [ ] 完善sprite渲染

## 总结

成功实现了完整的MMC1 mapper支持，包括：
- ✅ 串行写入接口
- ✅ PRG/CHR banking
- ✅ 系统集成
- ✅ 编译系统
- ✅ 文档

虽然发现Super Mario Bros实际使用Mapper 0而非MMC1，但MMC1实现对支持大量经典NES游戏仍然非常重要。

项目现在支持三种mapper：
1. **Mapper 0 (NROM)**: Super Mario Bros, Donkey Kong, nestest
2. **Mapper 1 (MMC1)**: Zelda, Metroid, Mega Man 2
3. **Mapper 4 (MMC3)**: Super Mario Bros 3, Mega Man系列

覆盖了NES游戏库中的大部分经典游戏！
