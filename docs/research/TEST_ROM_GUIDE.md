# NES 测试 ROM 使用指南

**来源**: [christopherpow/nes-test-roms](https://github.com/christopherpow/nes-test-roms)  
**日期**: 2025-11-29

---

## 推荐测试 ROM

### 1. CPU 测试

#### nestest (必测)
- **位置**: `other/nestest.nes`
- **测试**: 所有 CPU 指令
- **特点**: 有详细日志对比
- **用途**: 验证 CPU 正确性

```bash
# 下载
wget https://github.com/christopherpow/nes-test-roms/raw/master/other/nestest.nes

# 运行
./scripts/run.sh other/nestest.nes

# 对比日志
diff nestest.log nestest_expected.log
```

#### blargg_nes_cpu_test5
- **位置**: `blargg_nes_cpu_test5/`
- **测试**: CPU 指令集
- **特点**: 自动化测试，屏幕显示结果

### 2. PPU 测试

#### ppu_vbl_nmi (重要)
- **位置**: `ppu_vbl_nmi/`
- **测试**: VBlank 和 NMI 时序
- **用途**: 验证我们刚修复的问题

```bash
# 测试 VBlank 时序
./scripts/run.sh ppu_vbl_nmi/rom_singles/01-vbl_basics.nes
./scripts/run.sh ppu_vbl_nmi/rom_singles/02-vbl_set_time.nes
./scripts/run.sh ppu_vbl_nmi/rom_singles/03-vbl_clear_time.nes
```

#### vbl_nmi_timing
- **位置**: `vbl_nmi_timing/`
- **测试**: 精确的 VBlank/NMI 时序
- **用途**: 周期级验证

#### ppu_read_buffer
- **位置**: `ppu_read_buffer/`
- **测试**: PPUDATA 读取缓冲
- **用途**: 验证 $2007 读取延迟

### 3. APU 测试

#### blargg_apu_2005.07.30
- **位置**: `blargg_apu_2005.07.30/`
- **测试**: APU 所有通道
- **用途**: 验证音频功能

#### apu_test
- **位置**: `apu_test/`
- **测试**: APU 寄存器和时序

### 4. 综合测试

#### instr_test-v5
- **位置**: `instr_test-v5/`
- **测试**: 指令时序
- **用途**: 验证周期精确度

#### cpu_interrupts_v2
- **位置**: `cpu_interrupts_v2/`
- **测试**: NMI, IRQ, BRK
- **用途**: 验证中断处理

---

## 下载和使用

### 方法 1: 克隆整个仓库

```bash
cd /Users/tongxiaojun/github/my6502
git clone https://github.com/christopherpow/nes-test-roms.git test-roms
```

### 方法 2: 下载单个 ROM

```bash
# 创建目录
mkdir -p test-roms

# 下载 nestest
wget -P test-roms https://github.com/christopherpow/nes-test-roms/raw/master/other/nestest.nes

# 下载 VBlank 测试
wget -P test-roms https://github.com/christopherpow/nes-test-roms/raw/master/ppu_vbl_nmi/ppu_vbl_nmi.nes
```

### 方法 3: 使用脚本

```bash
# 创建下载脚本
cat > scripts/download-tests.sh << 'EOF'
#!/bin/bash
BASE_URL="https://github.com/christopherpow/nes-test-roms/raw/master"
mkdir -p test-roms

# 必测 ROM
wget -P test-roms "$BASE_URL/other/nestest.nes"
wget -P test-roms "$BASE_URL/ppu_vbl_nmi/ppu_vbl_nmi.nes"
wget -P test-roms "$BASE_URL/cpu_interrupts_v2/cpu_interrupts.nes"

echo "✅ 测试 ROM 下载完成"
EOF

chmod +x scripts/download-tests.sh
./scripts/download-tests.sh
```

---

## 测试优先级

### P0 - 立即测试

1. **ppu_vbl_nmi** - 验证 VBlank 修复
2. **nestest** - 验证 CPU 正确性
3. **cpu_interrupts_v2** - 验证 NMI 处理

### P1 - 近期测试

4. **ppu_read_buffer** - 验证 PPU 读取
5. **blargg_nes_cpu_test5** - 完整 CPU 测试
6. **instr_timing** - 时序验证

### P2 - 长期测试

7. **apu_test** - APU 功能
8. **sprite_hit_tests** - Sprite 0 hit
9. **mmc3_test** - Mapper 测试

---

## 测试结果解读

### 成功标志

**屏幕显示**:
```
Passed
All tests passed
```

**或特定数字**:
```
01 02 03 04 05
```

### 失败标志

**屏幕显示**:
```
Failed
Test 03 failed
Error code: XX
```

### 日志对比 (nestest)

```bash
# 生成日志
./scripts/run.sh test-roms/nestest.nes > nestest.log

# 下载预期日志
wget https://github.com/christopherpow/nes-test-roms/raw/master/other/nestest.log

# 对比
diff nestest.log nestest_expected.log
```

---

## 有源码的测试 ROM

### 1. Blargg 测试套件

**源码**: 大部分在 ROM 内包含汇编代码注释

**特点**:
- 详细的错误信息
- 自动化测试
- 屏幕显示结果

### 2. 社区测试 ROM

**GitHub 搜索**:
```
site:github.com NES test ROM source
site:github.com 6502 test assembly
```

### 3. 自制游戏

**推荐**:
- [nes-starter-kit](https://github.com/cppchriscpp/nes-starter-kit)
- [NES Hello World](https://github.com/bbbradsmith/NES-ca65-example)

---

## 创建自己的测试 ROM

### 简单测试

```assembly
; test_vblank.asm
.segment "HEADER"
  .byte "NES", $1A
  .byte 2  ; 2x 16KB PRG ROM
  .byte 1  ; 1x 8KB CHR ROM
  .byte 0  ; Mapper 0

.segment "CODE"
RESET:
  ; 等待 VBlank
:
  LDA $2002
  BPL :-
  
  ; 测试通过
  LDA #$01
  STA $6000  ; 写入特殊地址表示成功
  
  JMP RESET

.segment "VECTORS"
  .word 0, RESET, 0
```

### 编译

```bash
# 使用 ca65
ca65 test_vblank.asm
ld65 -C nes.cfg test_vblank.o -o test_vblank.nes
```

---

## 自动化测试

### 创建测试脚本

```bash
#!/bin/bash
# scripts/run-tests.sh

TESTS=(
  "test-roms/nestest.nes"
  "test-roms/ppu_vbl_nmi.nes"
  "test-roms/cpu_interrupts.nes"
)

for test in "${TESTS[@]}"; do
  echo "Testing: $test"
  timeout 5 ./scripts/run.sh "$test" --quiet
  if [ $? -eq 0 ]; then
    echo "✅ PASS"
  else
    echo "❌ FAIL"
  fi
done
```

### 集成到 CI

```yaml
# .github/workflows/test.yml
name: NES Tests
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Download test ROMs
        run: ./scripts/download-tests.sh
      - name: Build
        run: ./scripts/build.sh fast
      - name: Run tests
        run: ./scripts/run-tests.sh
```

---

## 推荐测试顺序

### 第一阶段: 基础功能

```bash
# 1. CPU 基础
./scripts/run.sh test-roms/nestest.nes

# 2. VBlank 基础
./scripts/run.sh test-roms/ppu_vbl_nmi.nes

# 3. 中断处理
./scripts/run.sh test-roms/cpu_interrupts.nes
```

### 第二阶段: 完整功能

```bash
# 4. CPU 完整测试
./scripts/run.sh test-roms/blargg_nes_cpu_test5.nes

# 5. PPU 读取
./scripts/run.sh test-roms/ppu_read_buffer.nes

# 6. 时序测试
./scripts/run.sh test-roms/instr_timing.nes
```

### 第三阶段: 高级功能

```bash
# 7. APU
./scripts/run.sh test-roms/apu_test.nes

# 8. Sprite 0 hit
./scripts/run.sh test-roms/sprite_hit_tests.nes

# 9. Mapper
./scripts/run.sh test-roms/mmc3_test.nes
```

---

## 常见问题

### Q: 测试 ROM 卡住不动

**A**: 可能是：
1. CPU 指令未实现
2. 时序不正确
3. 中断未触发

**调试**:
```bash
# 使用 VCD 追踪
./scripts/trace.sh test-roms/nestest.nes 1
gtkwave nes_trace.vcd
```

### Q: 测试显示错误代码

**A**: 查看测试 ROM 文档：
```bash
# 大部分测试有 README
cat test-roms/ppu_vbl_nmi/readme.txt
```

### Q: 如何知道测试通过

**A**: 
1. 屏幕显示 "Passed"
2. 特定内存地址有值
3. 日志对比无差异

---

## 资源链接

**测试 ROM 仓库**:
- https://github.com/christopherpow/nes-test-roms

**文档**:
- https://www.nesdev.org/wiki/Emulator_tests

**社区**:
- NESdev Forums: https://forums.nesdev.org/
- NESdev Discord: https://discord.gg/SddKcS6ehE

---

## 下一步

1. ✅ 下载测试 ROM
2. ✅ 运行 ppu_vbl_nmi 验证修复
3. ✅ 运行 nestest 验证 CPU
4. ⏳ 修复发现的问题
5. ⏳ 提高测试通过率

**立即开始**: `./scripts/download-tests.sh`
