# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added - 2025-11-27 (Final Update) 🎵✅

#### Complete APU Implementation
- **Length Counter** - Note duration control
  - 32-value lookup table
  - Automatic countdown
  - Halt flag support
  - Enable control
  - Synchronized with frame counter (half frame)
  - Used by Pulse 1/2, Triangle, and Noise channels

- **Linear Counter** - Triangle channel control
  - 7-bit programmable reload value
  - Automatic countdown
  - Reload flag control
  - Control flag support
  - Synchronized with frame counter (quarter frame)
  - Dual-counter system with length counter

- **Channel Integration Updates**
  - Pulse channels: Added length counter integration
  - Triangle channel: Added both linear and length counters
  - Noise channel: Added length counter integration
  - All channels now properly mute when counters reach zero

- **Complete APU Test Suite** - 12 comprehensive tests
  - LengthCounter tests (2)
  - LinearCounter tests (1)
  - Envelope tests (2)
  - Sweep tests (2)
  - PulseChannel tests (1)
  - TriangleChannel tests (1)
  - NoiseChannel tests (1)
  - APU integration tests (2)
  - All tests passing (100%)

### Technical Details 📊
- APU completion: 95% → 98%
- New modules: LengthCounter, LinearCounter
- Total APU code: ~1,415 lines
- Resource increase: +200 LUTs, +50 FFs
- Test coverage: 12 new tests, 122+ total tests
- All 122+ tests passing

### Added - 2025-11-27 (Evening Update) 🎵⭐

#### Complete APU Audio System
- **Envelope Generator** - Volume envelope control
  - Start flag and decay level
  - Loop and constant volume modes
  - Divider period control
  - Used by Pulse and Noise channels

- **Sweep Unit** - Pitch sweep effects
  - Negate and shift controls
  - Period adjustment
  - Mute conditions (period < 8 or > $7FF)
  - 1's complement for Pulse 1, 2's complement for Pulse 2

- **DMC Channel** - Delta Modulation Channel
  - Sample playback from memory
  - 16 rate settings
  - Loop and IRQ support
  - Direct load register
  - Memory reader with address tracking

- **Frame Counter** - Timing control
  - 4-step and 5-step modes
  - Quarter frame and half frame clocks
  - IRQ generation
  - Proper timing for envelope and sweep

- **Enhanced Channels**
  - Pulse channels with envelope and sweep
  - Noise channel with envelope
  - Length counter support
  - Proper channel muting

### Technical Details 📊
- APU completion: 70% → 95%
- New modules: Envelope, Sweep, DMCChannel
- Total APU code: ~500 lines
- Resource increase: ~900 LUTs for complete audio

### Added - 2025-11-27 (Afternoon Update) ⭐

#### Enhanced Sprite Rendering 🎮
- **8x16 Sprite Support** - Large sprite mode implementation
  - PPUCTRL bit 5 controls sprite size (8x8 or 8x16)
  - Automatic pattern table selection in 8x16 mode
  - Correct handling of vertical flip
  - Support for games like Super Mario Bros, Mega Man

- **Sprite Overflow Detection** - Hardware limit detection
  - Detects more than 8 sprites per scanline
  - Sets PPUSTATUS bit 5 (sprite overflow flag)
  - Accurate NES hardware behavior
  - Used by some games for optimization

#### APU Waveform Generation 🎵
- **PulseChannel** - Square wave generator
  - 4 duty cycles: 12.5%, 25%, 50%, 75%
  - Adjustable volume (0-15)
  - Adjustable frequency (11-bit period)
  - Two independent pulse channels

- **TriangleChannel** - Triangle wave generator
  - 32-step triangle sequence
  - Fixed volume
  - Used for bass and melody

- **NoiseChannel** - Noise generator
  - 15-bit LFSR for pseudo-random noise
  - 16 preset periods
  - Used for percussion and sound effects

- **Audio Mixing** - Real-time channel mixing
  - Mixes 4 audio channels
  - 16-bit audio output
  - 44.1 kHz sample rate

#### MMC3 IRQ Improvements 🔧
- **A12 Debounce Filter** - Prevents spurious triggers
  - 4-cycle filter for stable A12 detection
  - More accurate scanline counting
  - Better compatibility with games

- **Improved IRQ Counter Logic**
  - Correct handling of latch=0 case
  - Immediate IRQ trigger when appropriate
  - Clear pending flag on IRQ disable
  - Used by Contra, Super Mario Bros 3

### Added - 2025-11-27 (Morning)

#### PPUv3 - Integrated Rendering Pipeline 🎨⭐
- **PPUv3 Module** - Complete PPU with integrated rendering
  - Replaces simplified rendering in PPUv2
  - Uses PPURenderPipeline for all rendering
  - Sprite 0 hit detection in PPUSTATUS
  - Improved memory access arbitration
  - Full compatibility with PPUv2 interface

#### Tests
- `src/test/scala/nes/PPUv3Test.scala` - Complete test suite
  - 10 tests covering all PPU functionality
  - 100% pass rate
  - VBlank generation test
  - Register read/write tests
  - Rendering pipeline integration test
  - Sprite 0 hit detection test

#### Documentation
- `docs/PPU_V3_INTEGRATION.md` - PPUv3 integration report
- Updated README with PPUv3 information
- Updated CHANGELOG with PPUv3 details

#### PPU Rendering Pipeline (Complete) 🎨
- **BackgroundRenderer** - Complete background tile rendering
  - Tile coordinate calculation with scrolling support
  - Nametable selection (4 nametables with mirroring)
  - Attribute table decoding for palette selection
  - Pattern table selection via PPUCTRL
  - Dual-plane pattern data extraction
  - 5-stage rendering pipeline

- **SpriteRenderer** - Complete sprite rendering system
  - OAM evaluation (64 sprites)
  - Secondary OAM (up to 8 sprites per scanline)
  - Sprite data prefetching
  - Horizontal and vertical flipping
  - Sprite 0 hit detection
  - Priority handling (foreground/background)
  - 8x8 sprite support

- **PaletteLookup** - Palette selection and priority
  - Background palette selection ($3F00-$3F0F)
  - Sprite palette selection ($3F10-$3F1F)
  - Priority logic (background vs sprite)
  - Sprite 0 collision detection
  - Universal background color handling

- **PPURenderPipeline** - Integrated rendering system
  - Component integration
  - Memory access arbitration (time-division multiplexing)
  - PPUMASK control (show background/sprites)
  - Left 8-pixel clipping
  - Rendering enable control

#### Documentation
- `docs/PPU_RENDERING_PIPELINE.md` - Detailed rendering pipeline documentation
- `docs/PPU_RENDERING_COMPLETE.md` - Completion report with test results

#### Tests
- `src/test/scala/nes/PPURendererTest.scala` - Complete test suite
  - 12 tests covering all rendering components
  - 100% pass rate
  - Background rendering tests (3)
  - Sprite rendering tests (3)
  - Palette lookup tests (3)
  - Integration tests (3)

### Technical Improvements
- Fixed combinational loop in SpriteRenderer using Wire
- Optimized memory access with time-division multiplexing
- Implemented proper attribute table quadrant calculation
- Added sprite flip support (horizontal and vertical)
- Correct sprite priority handling

### Performance
- BackgroundRenderer: ~500 LUTs, ~200 FFs
- SpriteRenderer: ~800 LUTs, ~400 FFs
- PaletteLookup: ~100 LUTs, ~50 FFs
- PPURenderPipeline: ~1500 LUTs, ~700 FFs
- Rendering latency: 4 cycles per pixel

## [0.1.0] - 2025-11-26

### Added
- Complete 6502 CPU implementation
- NES System v2 with PPUv2, APU, and Memory Controller
- CPU Reset Vector support
- MMC3 Mapper (90% complete)
- ROM Loader for iNES format
- Comprehensive test suite (100+ tests)

### Documentation
- Complete 6502 architecture documentation
- NES system architecture guide
- Contra compatibility guide
- Refactoring summary

---

## Legend
- 🎨 Rendering
- 🎮 Gaming
- 🔧 Bug Fix
- ⚡ Performance
- 📚 Documentation
- ✅ Complete
- 🚧 In Progress
- ⏳ Planned
