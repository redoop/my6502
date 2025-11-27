# PPU 实现对比

## PPU.scala vs PPUv3.scala

### PPU.scala (当前使用)

**优点：**
- ✅ 完整实现，可以直接编译运行
- ✅ 集成了渲染逻辑在同一个模块中
- ✅ 使用 `Mem` 实现异步读取，适合组合逻辑
- ✅ 简单直接，易于调试

**缺点：**
- ⚠️ 渲染逻辑和寄存器逻辑混在一起
- ⚠️ 代码较长，不够模块化
- ⚠️ 缺少一些高级功能（如精灵碰撞检测）

**当前状态：**
- 正在使用
- 基本功能已验证工作正常
- 可以显示 CHR ROM 和 nametable 数据

### PPUv3.scala (未使用)

**优点：**
- ✅ 更模块化的设计
- ✅ 分离了渲染管线
- ✅ 更完整的 PPU 功能（Sprite 0 碰撞、精灵溢出等）
- ✅ 更准确的 PPUDATA 读取延迟
- ✅ 更准确的调色板镜像处理

**缺点：**
- ❌ **依赖 `PPURenderPipeline` 模块，但该模块不存在**
- ❌ 无法编译
- ❌ 使用 `SyncReadMem`，需要额外的时钟周期
- ❌ CHR ROM 接口不同，需要修改 NESSystem

**当前状态：**
- 未使用
- 无法编译（缺少依赖）
- 需要实现 `PPURenderPipeline` 模块

## 为什么使用 PPU.scala？

1. **可以工作**：PPU.scala 是完整的实现，可以直接编译运行
2. **已验证**：我们已经验证了它的渲染功能正常
3. **简单**：对于当前的开发阶段，简单的实现更容易调试

## 为什么不使用 PPUv3.scala？

1. **缺少依赖**：`PPURenderPipeline` 模块不存在
2. **需要重构**：需要修改 NESSystem 来适配不同的接口
3. **复杂度**：在基本功能还没完全工作之前，不需要这么复杂的实现

## 建议

### 短期（当前）
继续使用 **PPU.scala**，因为：
- 它可以工作
- 基本功能已经实现
- 更容易调试和修改

### 中期
在 PPU.scala 的基础上逐步添加功能：
1. 实现 NMI 中断支持
2. 优化调色板处理
3. 添加精灵渲染
4. 实现滚动

### 长期
如果需要更完整的 PPU 实现，可以：
1. 实现 `PPURenderPipeline` 模块
2. 迁移到 PPUv3.scala
3. 或者将 PPUv3 的优点合并到 PPU.scala

## 技术差异

### 内存类型
- **PPU.scala**: 使用 `Mem` (异步读取)
- **PPUv3.scala**: 使用 `SyncReadMem` (同步读取)

### CHR ROM 访问
- **PPU.scala**: CHR ROM 集成在 PPU 内部
- **PPUv3.scala**: CHR ROM 通过外部接口访问

### 渲染管线
- **PPU.scala**: 渲染逻辑直接在 PPU 模块中
- **PPUv3.scala**: 渲染逻辑分离到 `PPURenderPipeline` 模块

### 功能完整性
- **PPU.scala**: 基本功能
- **PPUv3.scala**: 更完整的功能（Sprite 0 碰撞、精灵溢出、准确的读取延迟等）

## 结论

当前使用 PPU.scala 是正确的选择，因为它可以工作并且已经验证了基本功能。PPUv3.scala 虽然设计更好，但由于缺少依赖模块而无法使用。
