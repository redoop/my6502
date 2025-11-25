module CPU6502(
  input         clock,
  input         reset,
  output [15:0] io_memAddr,
  output [7:0]  io_memDataOut,
  input  [7:0]  io_memDataIn,
  output        io_memWrite,
  output        io_memRead,
  output [7:0]  io_debug_regA,
  output [7:0]  io_debug_regX,
  output [7:0]  io_debug_regY,
  output [15:0] io_debug_regPC,
  output        io_debug_flagC,
  output        io_debug_flagZ,
  output        io_debug_flagN,
  output        io_debug_flagV,
  output [7:0]  io_debug_opcode
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] regA; // @[CPU6502.scala 18:21]
  reg [7:0] regX; // @[CPU6502.scala 19:21]
  reg [7:0] regY; // @[CPU6502.scala 20:21]
  reg [15:0] regPC; // @[CPU6502.scala 22:22]
  reg  flagC; // @[CPU6502.scala 25:22]
  reg  flagZ; // @[CPU6502.scala 26:22]
  reg  flagV; // @[CPU6502.scala 30:22]
  reg  flagN; // @[CPU6502.scala 31:22]
  reg [1:0] state; // @[CPU6502.scala 35:22]
  reg [7:0] opcode; // @[CPU6502.scala 37:23]
  reg [15:0] operand; // @[CPU6502.scala 38:24]
  reg [2:0] cycle; // @[CPU6502.scala 39:22]
  wire [15:0] _regPC_T_1 = regPC + 16'h1; // @[CPU6502.scala 59:22]
  wire  _T_3 = cycle == 3'h0; // @[CPU6502.scala 68:22]
  wire [7:0] _GEN_2 = cycle == 3'h0 ? io_memDataIn : regA; // @[CPU6502.scala 68:31 71:18 18:21]
  wire  _GEN_3 = cycle == 3'h0 ? io_memDataIn[7] : flagN; // @[CPU6502.scala 49:11 31:22 68:31]
  wire  _GEN_4 = cycle == 3'h0 ? io_memDataIn == 8'h0 : flagZ; // @[CPU6502.scala 50:11 26:22 68:31]
  wire [15:0] _GEN_5 = cycle == 3'h0 ? _regPC_T_1 : regPC; // @[CPU6502.scala 68:31 73:19 22:22]
  wire [1:0] _GEN_6 = cycle == 3'h0 ? 2'h0 : state; // @[CPU6502.scala 68:31 74:19 35:22]
  wire  _T_6 = cycle == 3'h1; // @[CPU6502.scala 85:28]
  wire [15:0] _GEN_7 = cycle == 3'h1 ? operand : regPC; // @[CPU6502.scala 42:14 85:37 86:24]
  wire [7:0] _GEN_9 = cycle == 3'h1 ? io_memDataIn : regA; // @[CPU6502.scala 85:37 88:18 18:21]
  wire  _GEN_10 = cycle == 3'h1 ? io_memDataIn[7] : flagN; // @[CPU6502.scala 49:11 31:22 85:37]
  wire  _GEN_11 = cycle == 3'h1 ? io_memDataIn == 8'h0 : flagZ; // @[CPU6502.scala 50:11 26:22 85:37]
  wire [1:0] _GEN_12 = cycle == 3'h1 ? 2'h0 : state; // @[CPU6502.scala 85:37 90:19 35:22]
  wire [15:0] _GEN_13 = _T_3 ? regPC : _GEN_7; // @[CPU6502.scala 79:31 80:24]
  wire  _GEN_14 = _T_3 | _T_6; // @[CPU6502.scala 79:31 81:24]
  wire [15:0] _GEN_15 = _T_3 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502.scala 79:31 82:21 38:24]
  wire [2:0] _GEN_17 = _T_3 ? 3'h1 : cycle; // @[CPU6502.scala 79:31 84:19 39:22]
  wire [7:0] _GEN_18 = _T_3 ? regA : _GEN_9; // @[CPU6502.scala 18:21 79:31]
  wire  _GEN_19 = _T_3 ? flagN : _GEN_10; // @[CPU6502.scala 31:22 79:31]
  wire  _GEN_20 = _T_3 ? flagZ : _GEN_11; // @[CPU6502.scala 26:22 79:31]
  wire [1:0] _GEN_21 = _T_3 ? state : _GEN_12; // @[CPU6502.scala 35:22 79:31]
  wire [7:0] _GEN_24 = _T_3 ? io_memDataIn : regX; // @[CPU6502.scala 96:31 99:18 19:21]
  wire [7:0] _GEN_31 = _T_3 ? io_memDataIn : regY; // @[CPU6502.scala 108:31 111:18 20:21]
  wire [7:0] _GEN_37 = _T_6 ? regA : 8'h0; // @[CPU6502.scala 126:37 128:27 43:17]
  wire [7:0] _GEN_45 = _T_3 ? 8'h0 : _GEN_37; // @[CPU6502.scala 120:31 43:17]
  wire  _GEN_46 = _T_3 ? 1'h0 : _T_6; // @[CPU6502.scala 120:31 44:15]
  wire [8:0] _sum_T = regA + io_memDataIn; // @[CPU6502.scala 139:28]
  wire [8:0] _GEN_516 = {{8'd0}, flagC}; // @[CPU6502.scala 139:44]
  wire [9:0] sum = _sum_T + _GEN_516; // @[CPU6502.scala 139:44]
  wire [7:0] _GEN_50 = _T_3 ? sum[7:0] : regA; // @[CPU6502.scala 136:31 140:18 18:21]
  wire  _GEN_51 = _T_3 ? sum[8] : flagC; // @[CPU6502.scala 136:31 141:19 25:22]
  wire  _GEN_52 = _T_3 ? sum[7] : flagN; // @[CPU6502.scala 136:31 49:11 31:22]
  wire  _GEN_53 = _T_3 ? sum[7:0] == 8'h0 : flagZ; // @[CPU6502.scala 136:31 50:11 26:22]
  wire  _GEN_54 = _T_3 ? regA[7] == io_memDataIn[7] & regA[7] != sum[7] : flagV; // @[CPU6502.scala 136:31 144:19 30:22]
  wire [8:0] _diff_T = regA - io_memDataIn; // @[CPU6502.scala 155:29]
  wire  _diff_T_2 = ~flagC; // @[CPU6502.scala 155:49]
  wire [8:0] _GEN_517 = {{8'd0}, _diff_T_2}; // @[CPU6502.scala 155:45]
  wire [9:0] diff = _diff_T - _GEN_517; // @[CPU6502.scala 155:45]
  wire [7:0] _GEN_59 = _T_3 ? diff[7:0] : regA; // @[CPU6502.scala 152:31 156:18 18:21]
  wire  _GEN_60 = _T_3 ? ~diff[8] : flagC; // @[CPU6502.scala 152:31 157:19 25:22]
  wire  _GEN_61 = _T_3 ? diff[7] : flagN; // @[CPU6502.scala 152:31 49:11 31:22]
  wire  _GEN_62 = _T_3 ? diff[7:0] == 8'h0 : flagZ; // @[CPU6502.scala 152:31 50:11 26:22]
  wire  _GEN_63 = _T_3 ? regA[7] != io_memDataIn[7] & regA[7] != diff[7] : flagV; // @[CPU6502.scala 152:31 159:19 30:22]
  wire [7:0] result = regA & io_memDataIn; // @[CPU6502.scala 170:31]
  wire [7:0] _GEN_68 = _T_3 ? result : regA; // @[CPU6502.scala 167:31 171:18 18:21]
  wire  _GEN_69 = _T_3 ? result[7] : flagN; // @[CPU6502.scala 167:31 49:11 31:22]
  wire  _GEN_70 = _T_3 ? result == 8'h0 : flagZ; // @[CPU6502.scala 167:31 50:11 26:22]
  wire [7:0] result_1 = regA | io_memDataIn; // @[CPU6502.scala 183:31]
  wire [7:0] _GEN_75 = _T_3 ? result_1 : regA; // @[CPU6502.scala 180:31 184:18 18:21]
  wire  _GEN_76 = _T_3 ? result_1[7] : flagN; // @[CPU6502.scala 180:31 49:11 31:22]
  wire  _GEN_77 = _T_3 ? result_1 == 8'h0 : flagZ; // @[CPU6502.scala 180:31 50:11 26:22]
  wire [7:0] result_2 = regA ^ io_memDataIn; // @[CPU6502.scala 196:31]
  wire [7:0] _GEN_82 = _T_3 ? result_2 : regA; // @[CPU6502.scala 193:31 197:18 18:21]
  wire  _GEN_83 = _T_3 ? result_2[7] : flagN; // @[CPU6502.scala 193:31 49:11 31:22]
  wire  _GEN_84 = _T_3 ? result_2 == 8'h0 : flagZ; // @[CPU6502.scala 193:31 50:11 26:22]
  wire [7:0] result_3 = regX + 8'h1; // @[CPU6502.scala 206:29]
  wire [7:0] result_4 = regY + 8'h1; // @[CPU6502.scala 214:29]
  wire [7:0] result_5 = regX - 8'h1; // @[CPU6502.scala 222:29]
  wire [7:0] result_6 = regY - 8'h1; // @[CPU6502.scala 230:29]
  wire [15:0] _regPC_T_25 = {io_memDataIn,operand[7:0]}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_89 = _T_6 ? _regPC_T_25 : regPC; // @[CPU6502.scala 319:37 322:19 22:22]
  wire [15:0] _GEN_94 = _T_3 ? _regPC_T_1 : _GEN_89; // @[CPU6502.scala 313:31 317:19]
  wire [7:0] offset = io_memDataIn; // @[CPU6502.scala 334:41]
  wire [15:0] _GEN_518 = {{8{offset[7]}},offset}; // @[CPU6502.scala 335:38]
  wire [15:0] _regPC_T_32 = $signed(regPC) + $signed(_GEN_518); // @[CPU6502.scala 335:48]
  wire [15:0] _GEN_97 = flagZ ? _regPC_T_32 : _regPC_T_1; // @[CPU6502.scala 332:19 333:25 335:21]
  wire [15:0] _GEN_100 = _T_3 ? _GEN_97 : regPC; // @[CPU6502.scala 22:22 329:31]
  wire [15:0] _GEN_102 = ~flagZ ? _regPC_T_32 : _regPC_T_1; // @[CPU6502.scala 346:19 347:26 349:21]
  wire [15:0] _GEN_105 = _T_3 ? _GEN_102 : regPC; // @[CPU6502.scala 22:22 343:31]
  wire [15:0] _GEN_107 = flagC ? _regPC_T_32 : _regPC_T_1; // @[CPU6502.scala 360:19 361:25 363:21]
  wire [15:0] _GEN_110 = _T_3 ? _GEN_107 : regPC; // @[CPU6502.scala 22:22 357:31]
  wire [15:0] _GEN_112 = _diff_T_2 ? _regPC_T_32 : _regPC_T_1; // @[CPU6502.scala 374:19 375:26 377:21]
  wire [15:0] _GEN_115 = _T_3 ? _GEN_112 : regPC; // @[CPU6502.scala 22:22 371:31]
  wire  _GEN_118 = 8'h90 == opcode & _T_3; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_119 = 8'h90 == opcode ? _GEN_115 : regPC; // @[CPU6502.scala 22:22 65:22]
  wire [1:0] _GEN_120 = 8'h90 == opcode ? _GEN_6 : state; // @[CPU6502.scala 35:22 65:22]
  wire  _GEN_122 = 8'hb0 == opcode ? _T_3 : _GEN_118; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_123 = 8'hb0 == opcode ? _GEN_110 : _GEN_119; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_124 = 8'hb0 == opcode ? _GEN_6 : _GEN_120; // @[CPU6502.scala 65:22]
  wire  _GEN_126 = 8'hd0 == opcode ? _T_3 : _GEN_122; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_127 = 8'hd0 == opcode ? _GEN_105 : _GEN_123; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_128 = 8'hd0 == opcode ? _GEN_6 : _GEN_124; // @[CPU6502.scala 65:22]
  wire  _GEN_130 = 8'hf0 == opcode ? _T_3 : _GEN_126; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_131 = 8'hf0 == opcode ? _GEN_100 : _GEN_127; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_132 = 8'hf0 == opcode ? _GEN_6 : _GEN_128; // @[CPU6502.scala 65:22]
  wire  _GEN_134 = 8'h4c == opcode ? _GEN_14 : _GEN_130; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_135 = 8'h4c == opcode ? _GEN_15 : operand; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_136 = 8'h4c == opcode ? _GEN_94 : _GEN_131; // @[CPU6502.scala 65:22]
  wire [2:0] _GEN_137 = 8'h4c == opcode ? _GEN_17 : cycle; // @[CPU6502.scala 39:22 65:22]
  wire [1:0] _GEN_138 = 8'h4c == opcode ? _GEN_21 : _GEN_132; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_139 = 8'hea == opcode ? 2'h0 : _GEN_138; // @[CPU6502.scala 308:17 65:22]
  wire  _GEN_141 = 8'hea == opcode ? 1'h0 : _GEN_134; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_142 = 8'hea == opcode ? operand : _GEN_135; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_143 = 8'hea == opcode ? regPC : _GEN_136; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_144 = 8'hea == opcode ? cycle : _GEN_137; // @[CPU6502.scala 39:22 65:22]
  wire  _GEN_145 = 8'hb8 == opcode ? 1'h0 : flagV; // @[CPU6502.scala 302:17 30:22 65:22]
  wire [1:0] _GEN_146 = 8'hb8 == opcode ? 2'h0 : _GEN_139; // @[CPU6502.scala 303:17 65:22]
  wire  _GEN_148 = 8'hb8 == opcode ? 1'h0 : _GEN_141; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_149 = 8'hb8 == opcode ? operand : _GEN_142; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_150 = 8'hb8 == opcode ? regPC : _GEN_143; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_151 = 8'hb8 == opcode ? cycle : _GEN_144; // @[CPU6502.scala 39:22 65:22]
  wire [1:0] _GEN_153 = 8'h78 == opcode ? 2'h0 : _GEN_146; // @[CPU6502.scala 297:17 65:22]
  wire  _GEN_154 = 8'h78 == opcode ? flagV : _GEN_145; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_156 = 8'h78 == opcode ? 1'h0 : _GEN_148; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_157 = 8'h78 == opcode ? operand : _GEN_149; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_158 = 8'h78 == opcode ? regPC : _GEN_150; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_159 = 8'h78 == opcode ? cycle : _GEN_151; // @[CPU6502.scala 39:22 65:22]
  wire [1:0] _GEN_161 = 8'h58 == opcode ? 2'h0 : _GEN_153; // @[CPU6502.scala 291:17 65:22]
  wire  _GEN_162 = 8'h58 == opcode ? flagV : _GEN_154; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_164 = 8'h58 == opcode ? 1'h0 : _GEN_156; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_165 = 8'h58 == opcode ? operand : _GEN_157; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_166 = 8'h58 == opcode ? regPC : _GEN_158; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_167 = 8'h58 == opcode ? cycle : _GEN_159; // @[CPU6502.scala 39:22 65:22]
  wire [1:0] _GEN_169 = 8'hf8 == opcode ? 2'h0 : _GEN_161; // @[CPU6502.scala 285:17 65:22]
  wire  _GEN_171 = 8'hf8 == opcode ? flagV : _GEN_162; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_173 = 8'hf8 == opcode ? 1'h0 : _GEN_164; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_174 = 8'hf8 == opcode ? operand : _GEN_165; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_175 = 8'hf8 == opcode ? regPC : _GEN_166; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_176 = 8'hf8 == opcode ? cycle : _GEN_167; // @[CPU6502.scala 39:22 65:22]
  wire [1:0] _GEN_178 = 8'hd8 == opcode ? 2'h0 : _GEN_169; // @[CPU6502.scala 279:17 65:22]
  wire  _GEN_180 = 8'hd8 == opcode ? flagV : _GEN_171; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_182 = 8'hd8 == opcode ? 1'h0 : _GEN_173; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_183 = 8'hd8 == opcode ? operand : _GEN_174; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_184 = 8'hd8 == opcode ? regPC : _GEN_175; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_185 = 8'hd8 == opcode ? cycle : _GEN_176; // @[CPU6502.scala 39:22 65:22]
  wire  _GEN_186 = 8'h38 == opcode | flagC; // @[CPU6502.scala 272:17 25:22 65:22]
  wire [1:0] _GEN_187 = 8'h38 == opcode ? 2'h0 : _GEN_178; // @[CPU6502.scala 273:17 65:22]
  wire  _GEN_190 = 8'h38 == opcode ? flagV : _GEN_180; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_192 = 8'h38 == opcode ? 1'h0 : _GEN_182; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_193 = 8'h38 == opcode ? operand : _GEN_183; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_194 = 8'h38 == opcode ? regPC : _GEN_184; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_195 = 8'h38 == opcode ? cycle : _GEN_185; // @[CPU6502.scala 39:22 65:22]
  wire  _GEN_196 = 8'h18 == opcode ? 1'h0 : _GEN_186; // @[CPU6502.scala 266:17 65:22]
  wire [1:0] _GEN_197 = 8'h18 == opcode ? 2'h0 : _GEN_187; // @[CPU6502.scala 267:17 65:22]
  wire  _GEN_200 = 8'h18 == opcode ? flagV : _GEN_190; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_202 = 8'h18 == opcode ? 1'h0 : _GEN_192; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_203 = 8'h18 == opcode ? operand : _GEN_193; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_204 = 8'h18 == opcode ? regPC : _GEN_194; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_205 = 8'h18 == opcode ? cycle : _GEN_195; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_206 = 8'h98 == opcode ? regY : regA; // @[CPU6502.scala 259:16 18:21 65:22]
  wire  _GEN_207 = 8'h98 == opcode ? regY[7] : flagN; // @[CPU6502.scala 49:11 31:22 65:22]
  wire  _GEN_208 = 8'h98 == opcode ? regY == 8'h0 : flagZ; // @[CPU6502.scala 50:11 26:22 65:22]
  wire [1:0] _GEN_209 = 8'h98 == opcode ? 2'h0 : _GEN_197; // @[CPU6502.scala 261:17 65:22]
  wire  _GEN_210 = 8'h98 == opcode ? flagC : _GEN_196; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_213 = 8'h98 == opcode ? flagV : _GEN_200; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_215 = 8'h98 == opcode ? 1'h0 : _GEN_202; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_216 = 8'h98 == opcode ? operand : _GEN_203; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_217 = 8'h98 == opcode ? regPC : _GEN_204; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_218 = 8'h98 == opcode ? cycle : _GEN_205; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_219 = 8'h8a == opcode ? regX : _GEN_206; // @[CPU6502.scala 252:16 65:22]
  wire  _GEN_220 = 8'h8a == opcode ? regX[7] : _GEN_207; // @[CPU6502.scala 49:11 65:22]
  wire  _GEN_221 = 8'h8a == opcode ? regX == 8'h0 : _GEN_208; // @[CPU6502.scala 50:11 65:22]
  wire [1:0] _GEN_222 = 8'h8a == opcode ? 2'h0 : _GEN_209; // @[CPU6502.scala 254:17 65:22]
  wire  _GEN_223 = 8'h8a == opcode ? flagC : _GEN_210; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_226 = 8'h8a == opcode ? flagV : _GEN_213; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_228 = 8'h8a == opcode ? 1'h0 : _GEN_215; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_229 = 8'h8a == opcode ? operand : _GEN_216; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_230 = 8'h8a == opcode ? regPC : _GEN_217; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_231 = 8'h8a == opcode ? cycle : _GEN_218; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_232 = 8'ha8 == opcode ? regA : regY; // @[CPU6502.scala 245:16 20:21 65:22]
  wire  _GEN_233 = 8'ha8 == opcode ? regA[7] : _GEN_220; // @[CPU6502.scala 49:11 65:22]
  wire  _GEN_234 = 8'ha8 == opcode ? regA == 8'h0 : _GEN_221; // @[CPU6502.scala 50:11 65:22]
  wire [1:0] _GEN_235 = 8'ha8 == opcode ? 2'h0 : _GEN_222; // @[CPU6502.scala 247:17 65:22]
  wire [7:0] _GEN_236 = 8'ha8 == opcode ? regA : _GEN_219; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_237 = 8'ha8 == opcode ? flagC : _GEN_223; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_240 = 8'ha8 == opcode ? flagV : _GEN_226; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_242 = 8'ha8 == opcode ? 1'h0 : _GEN_228; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_243 = 8'ha8 == opcode ? operand : _GEN_229; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_244 = 8'ha8 == opcode ? regPC : _GEN_230; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_245 = 8'ha8 == opcode ? cycle : _GEN_231; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_246 = 8'haa == opcode ? regA : regX; // @[CPU6502.scala 238:16 19:21 65:22]
  wire  _GEN_247 = 8'haa == opcode ? regA[7] : _GEN_233; // @[CPU6502.scala 49:11 65:22]
  wire  _GEN_248 = 8'haa == opcode ? regA == 8'h0 : _GEN_234; // @[CPU6502.scala 50:11 65:22]
  wire [1:0] _GEN_249 = 8'haa == opcode ? 2'h0 : _GEN_235; // @[CPU6502.scala 240:17 65:22]
  wire [7:0] _GEN_250 = 8'haa == opcode ? regY : _GEN_232; // @[CPU6502.scala 20:21 65:22]
  wire [7:0] _GEN_251 = 8'haa == opcode ? regA : _GEN_236; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_252 = 8'haa == opcode ? flagC : _GEN_237; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_255 = 8'haa == opcode ? flagV : _GEN_240; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_257 = 8'haa == opcode ? 1'h0 : _GEN_242; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_258 = 8'haa == opcode ? operand : _GEN_243; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_259 = 8'haa == opcode ? regPC : _GEN_244; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_260 = 8'haa == opcode ? cycle : _GEN_245; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_261 = 8'h88 == opcode ? result_6 : _GEN_250; // @[CPU6502.scala 231:16 65:22]
  wire  _GEN_262 = 8'h88 == opcode ? result_6[7] : _GEN_247; // @[CPU6502.scala 49:11 65:22]
  wire  _GEN_263 = 8'h88 == opcode ? result_6 == 8'h0 : _GEN_248; // @[CPU6502.scala 50:11 65:22]
  wire [1:0] _GEN_264 = 8'h88 == opcode ? 2'h0 : _GEN_249; // @[CPU6502.scala 233:17 65:22]
  wire [7:0] _GEN_265 = 8'h88 == opcode ? regX : _GEN_246; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_266 = 8'h88 == opcode ? regA : _GEN_251; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_267 = 8'h88 == opcode ? flagC : _GEN_252; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_270 = 8'h88 == opcode ? flagV : _GEN_255; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_272 = 8'h88 == opcode ? 1'h0 : _GEN_257; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_273 = 8'h88 == opcode ? operand : _GEN_258; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_274 = 8'h88 == opcode ? regPC : _GEN_259; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_275 = 8'h88 == opcode ? cycle : _GEN_260; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_276 = 8'hca == opcode ? result_5 : _GEN_265; // @[CPU6502.scala 223:16 65:22]
  wire  _GEN_277 = 8'hca == opcode ? result_5[7] : _GEN_262; // @[CPU6502.scala 49:11 65:22]
  wire  _GEN_278 = 8'hca == opcode ? result_5 == 8'h0 : _GEN_263; // @[CPU6502.scala 50:11 65:22]
  wire [1:0] _GEN_279 = 8'hca == opcode ? 2'h0 : _GEN_264; // @[CPU6502.scala 225:17 65:22]
  wire [7:0] _GEN_280 = 8'hca == opcode ? regY : _GEN_261; // @[CPU6502.scala 20:21 65:22]
  wire [7:0] _GEN_281 = 8'hca == opcode ? regA : _GEN_266; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_282 = 8'hca == opcode ? flagC : _GEN_267; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_285 = 8'hca == opcode ? flagV : _GEN_270; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_287 = 8'hca == opcode ? 1'h0 : _GEN_272; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_288 = 8'hca == opcode ? operand : _GEN_273; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_289 = 8'hca == opcode ? regPC : _GEN_274; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_290 = 8'hca == opcode ? cycle : _GEN_275; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_291 = 8'hc8 == opcode ? result_4 : _GEN_280; // @[CPU6502.scala 215:16 65:22]
  wire  _GEN_292 = 8'hc8 == opcode ? result_4[7] : _GEN_277; // @[CPU6502.scala 49:11 65:22]
  wire  _GEN_293 = 8'hc8 == opcode ? result_4 == 8'h0 : _GEN_278; // @[CPU6502.scala 50:11 65:22]
  wire [1:0] _GEN_294 = 8'hc8 == opcode ? 2'h0 : _GEN_279; // @[CPU6502.scala 217:17 65:22]
  wire [7:0] _GEN_295 = 8'hc8 == opcode ? regX : _GEN_276; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_296 = 8'hc8 == opcode ? regA : _GEN_281; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_297 = 8'hc8 == opcode ? flagC : _GEN_282; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_300 = 8'hc8 == opcode ? flagV : _GEN_285; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_302 = 8'hc8 == opcode ? 1'h0 : _GEN_287; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_303 = 8'hc8 == opcode ? operand : _GEN_288; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_304 = 8'hc8 == opcode ? regPC : _GEN_289; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_305 = 8'hc8 == opcode ? cycle : _GEN_290; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_306 = 8'he8 == opcode ? result_3 : _GEN_295; // @[CPU6502.scala 207:16 65:22]
  wire  _GEN_307 = 8'he8 == opcode ? result_3[7] : _GEN_292; // @[CPU6502.scala 49:11 65:22]
  wire  _GEN_308 = 8'he8 == opcode ? result_3 == 8'h0 : _GEN_293; // @[CPU6502.scala 50:11 65:22]
  wire [1:0] _GEN_309 = 8'he8 == opcode ? 2'h0 : _GEN_294; // @[CPU6502.scala 209:17 65:22]
  wire [7:0] _GEN_310 = 8'he8 == opcode ? regY : _GEN_291; // @[CPU6502.scala 20:21 65:22]
  wire [7:0] _GEN_311 = 8'he8 == opcode ? regA : _GEN_296; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_312 = 8'he8 == opcode ? flagC : _GEN_297; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_315 = 8'he8 == opcode ? flagV : _GEN_300; // @[CPU6502.scala 30:22 65:22]
  wire  _GEN_317 = 8'he8 == opcode ? 1'h0 : _GEN_302; // @[CPU6502.scala 45:14 65:22]
  wire [15:0] _GEN_318 = 8'he8 == opcode ? operand : _GEN_303; // @[CPU6502.scala 65:22 38:24]
  wire [15:0] _GEN_319 = 8'he8 == opcode ? regPC : _GEN_304; // @[CPU6502.scala 22:22 65:22]
  wire [2:0] _GEN_320 = 8'he8 == opcode ? cycle : _GEN_305; // @[CPU6502.scala 39:22 65:22]
  wire  _GEN_322 = 8'h49 == opcode ? _T_3 : _GEN_317; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_323 = 8'h49 == opcode ? _GEN_82 : _GEN_311; // @[CPU6502.scala 65:22]
  wire  _GEN_324 = 8'h49 == opcode ? _GEN_83 : _GEN_307; // @[CPU6502.scala 65:22]
  wire  _GEN_325 = 8'h49 == opcode ? _GEN_84 : _GEN_308; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_326 = 8'h49 == opcode ? _GEN_5 : _GEN_319; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_327 = 8'h49 == opcode ? _GEN_6 : _GEN_309; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_328 = 8'h49 == opcode ? regX : _GEN_306; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_329 = 8'h49 == opcode ? regY : _GEN_310; // @[CPU6502.scala 20:21 65:22]
  wire  _GEN_330 = 8'h49 == opcode ? flagC : _GEN_312; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_333 = 8'h49 == opcode ? flagV : _GEN_315; // @[CPU6502.scala 30:22 65:22]
  wire [15:0] _GEN_334 = 8'h49 == opcode ? operand : _GEN_318; // @[CPU6502.scala 65:22 38:24]
  wire [2:0] _GEN_335 = 8'h49 == opcode ? cycle : _GEN_320; // @[CPU6502.scala 39:22 65:22]
  wire  _GEN_337 = 8'h9 == opcode ? _T_3 : _GEN_322; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_338 = 8'h9 == opcode ? _GEN_75 : _GEN_323; // @[CPU6502.scala 65:22]
  wire  _GEN_339 = 8'h9 == opcode ? _GEN_76 : _GEN_324; // @[CPU6502.scala 65:22]
  wire  _GEN_340 = 8'h9 == opcode ? _GEN_77 : _GEN_325; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_341 = 8'h9 == opcode ? _GEN_5 : _GEN_326; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_342 = 8'h9 == opcode ? _GEN_6 : _GEN_327; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_343 = 8'h9 == opcode ? regX : _GEN_328; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_344 = 8'h9 == opcode ? regY : _GEN_329; // @[CPU6502.scala 20:21 65:22]
  wire  _GEN_345 = 8'h9 == opcode ? flagC : _GEN_330; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_348 = 8'h9 == opcode ? flagV : _GEN_333; // @[CPU6502.scala 30:22 65:22]
  wire [15:0] _GEN_349 = 8'h9 == opcode ? operand : _GEN_334; // @[CPU6502.scala 65:22 38:24]
  wire [2:0] _GEN_350 = 8'h9 == opcode ? cycle : _GEN_335; // @[CPU6502.scala 39:22 65:22]
  wire  _GEN_352 = 8'h29 == opcode ? _T_3 : _GEN_337; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_353 = 8'h29 == opcode ? _GEN_68 : _GEN_338; // @[CPU6502.scala 65:22]
  wire  _GEN_354 = 8'h29 == opcode ? _GEN_69 : _GEN_339; // @[CPU6502.scala 65:22]
  wire  _GEN_355 = 8'h29 == opcode ? _GEN_70 : _GEN_340; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_356 = 8'h29 == opcode ? _GEN_5 : _GEN_341; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_357 = 8'h29 == opcode ? _GEN_6 : _GEN_342; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_358 = 8'h29 == opcode ? regX : _GEN_343; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_359 = 8'h29 == opcode ? regY : _GEN_344; // @[CPU6502.scala 20:21 65:22]
  wire  _GEN_360 = 8'h29 == opcode ? flagC : _GEN_345; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_363 = 8'h29 == opcode ? flagV : _GEN_348; // @[CPU6502.scala 30:22 65:22]
  wire [15:0] _GEN_364 = 8'h29 == opcode ? operand : _GEN_349; // @[CPU6502.scala 65:22 38:24]
  wire [2:0] _GEN_365 = 8'h29 == opcode ? cycle : _GEN_350; // @[CPU6502.scala 39:22 65:22]
  wire  _GEN_367 = 8'he9 == opcode ? _T_3 : _GEN_352; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_368 = 8'he9 == opcode ? _GEN_59 : _GEN_353; // @[CPU6502.scala 65:22]
  wire  _GEN_369 = 8'he9 == opcode ? _GEN_60 : _GEN_360; // @[CPU6502.scala 65:22]
  wire  _GEN_370 = 8'he9 == opcode ? _GEN_61 : _GEN_354; // @[CPU6502.scala 65:22]
  wire  _GEN_371 = 8'he9 == opcode ? _GEN_62 : _GEN_355; // @[CPU6502.scala 65:22]
  wire  _GEN_372 = 8'he9 == opcode ? _GEN_63 : _GEN_363; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_373 = 8'he9 == opcode ? _GEN_5 : _GEN_356; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_374 = 8'he9 == opcode ? _GEN_6 : _GEN_357; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_375 = 8'he9 == opcode ? regX : _GEN_358; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_376 = 8'he9 == opcode ? regY : _GEN_359; // @[CPU6502.scala 20:21 65:22]
  wire [15:0] _GEN_379 = 8'he9 == opcode ? operand : _GEN_364; // @[CPU6502.scala 65:22 38:24]
  wire [2:0] _GEN_380 = 8'he9 == opcode ? cycle : _GEN_365; // @[CPU6502.scala 39:22 65:22]
  wire  _GEN_382 = 8'h69 == opcode ? _T_3 : _GEN_367; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_383 = 8'h69 == opcode ? _GEN_50 : _GEN_368; // @[CPU6502.scala 65:22]
  wire  _GEN_384 = 8'h69 == opcode ? _GEN_51 : _GEN_369; // @[CPU6502.scala 65:22]
  wire  _GEN_385 = 8'h69 == opcode ? _GEN_52 : _GEN_370; // @[CPU6502.scala 65:22]
  wire  _GEN_386 = 8'h69 == opcode ? _GEN_53 : _GEN_371; // @[CPU6502.scala 65:22]
  wire  _GEN_387 = 8'h69 == opcode ? _GEN_54 : _GEN_372; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_388 = 8'h69 == opcode ? _GEN_5 : _GEN_373; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_389 = 8'h69 == opcode ? _GEN_6 : _GEN_374; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_390 = 8'h69 == opcode ? regX : _GEN_375; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_391 = 8'h69 == opcode ? regY : _GEN_376; // @[CPU6502.scala 20:21 65:22]
  wire [15:0] _GEN_394 = 8'h69 == opcode ? operand : _GEN_379; // @[CPU6502.scala 65:22 38:24]
  wire [2:0] _GEN_395 = 8'h69 == opcode ? cycle : _GEN_380; // @[CPU6502.scala 39:22 65:22]
  wire [15:0] _GEN_396 = 8'h85 == opcode ? _GEN_13 : regPC; // @[CPU6502.scala 65:22]
  wire  _GEN_397 = 8'h85 == opcode ? _T_3 : _GEN_382; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_398 = 8'h85 == opcode ? _GEN_15 : _GEN_394; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_399 = 8'h85 == opcode ? _GEN_5 : _GEN_388; // @[CPU6502.scala 65:22]
  wire [2:0] _GEN_400 = 8'h85 == opcode ? _GEN_17 : _GEN_395; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_401 = 8'h85 == opcode ? _GEN_45 : 8'h0; // @[CPU6502.scala 43:17 65:22]
  wire [1:0] _GEN_403 = 8'h85 == opcode ? _GEN_21 : _GEN_389; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_404 = 8'h85 == opcode ? regA : _GEN_383; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_405 = 8'h85 == opcode ? flagC : _GEN_384; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_406 = 8'h85 == opcode ? flagN : _GEN_385; // @[CPU6502.scala 31:22 65:22]
  wire  _GEN_407 = 8'h85 == opcode ? flagZ : _GEN_386; // @[CPU6502.scala 26:22 65:22]
  wire  _GEN_408 = 8'h85 == opcode ? flagV : _GEN_387; // @[CPU6502.scala 30:22 65:22]
  wire [7:0] _GEN_409 = 8'h85 == opcode ? regX : _GEN_390; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_410 = 8'h85 == opcode ? regY : _GEN_391; // @[CPU6502.scala 20:21 65:22]
  wire [15:0] _GEN_413 = 8'ha0 == opcode ? regPC : _GEN_396; // @[CPU6502.scala 65:22]
  wire  _GEN_414 = 8'ha0 == opcode ? _T_3 : _GEN_397; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_415 = 8'ha0 == opcode ? _GEN_31 : _GEN_410; // @[CPU6502.scala 65:22]
  wire  _GEN_416 = 8'ha0 == opcode ? _GEN_3 : _GEN_406; // @[CPU6502.scala 65:22]
  wire  _GEN_417 = 8'ha0 == opcode ? _GEN_4 : _GEN_407; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_418 = 8'ha0 == opcode ? _GEN_5 : _GEN_399; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_419 = 8'ha0 == opcode ? _GEN_6 : _GEN_403; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_420 = 8'ha0 == opcode ? operand : _GEN_398; // @[CPU6502.scala 65:22 38:24]
  wire [2:0] _GEN_421 = 8'ha0 == opcode ? cycle : _GEN_400; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_422 = 8'ha0 == opcode ? 8'h0 : _GEN_401; // @[CPU6502.scala 43:17 65:22]
  wire  _GEN_423 = 8'ha0 == opcode ? 1'h0 : 8'h85 == opcode & _GEN_46; // @[CPU6502.scala 44:15 65:22]
  wire [7:0] _GEN_424 = 8'ha0 == opcode ? regA : _GEN_404; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_425 = 8'ha0 == opcode ? flagC : _GEN_405; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_426 = 8'ha0 == opcode ? flagV : _GEN_408; // @[CPU6502.scala 30:22 65:22]
  wire [7:0] _GEN_427 = 8'ha0 == opcode ? regX : _GEN_409; // @[CPU6502.scala 19:21 65:22]
  wire [15:0] _GEN_430 = 8'ha2 == opcode ? regPC : _GEN_413; // @[CPU6502.scala 65:22]
  wire  _GEN_431 = 8'ha2 == opcode ? _T_3 : _GEN_414; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_432 = 8'ha2 == opcode ? _GEN_24 : _GEN_427; // @[CPU6502.scala 65:22]
  wire  _GEN_433 = 8'ha2 == opcode ? _GEN_3 : _GEN_416; // @[CPU6502.scala 65:22]
  wire  _GEN_434 = 8'ha2 == opcode ? _GEN_4 : _GEN_417; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_435 = 8'ha2 == opcode ? _GEN_5 : _GEN_418; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_436 = 8'ha2 == opcode ? _GEN_6 : _GEN_419; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_437 = 8'ha2 == opcode ? regY : _GEN_415; // @[CPU6502.scala 20:21 65:22]
  wire [15:0] _GEN_438 = 8'ha2 == opcode ? operand : _GEN_420; // @[CPU6502.scala 65:22 38:24]
  wire [2:0] _GEN_439 = 8'ha2 == opcode ? cycle : _GEN_421; // @[CPU6502.scala 39:22 65:22]
  wire [7:0] _GEN_440 = 8'ha2 == opcode ? 8'h0 : _GEN_422; // @[CPU6502.scala 43:17 65:22]
  wire  _GEN_441 = 8'ha2 == opcode ? 1'h0 : _GEN_423; // @[CPU6502.scala 44:15 65:22]
  wire [7:0] _GEN_442 = 8'ha2 == opcode ? regA : _GEN_424; // @[CPU6502.scala 18:21 65:22]
  wire  _GEN_443 = 8'ha2 == opcode ? flagC : _GEN_425; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_444 = 8'ha2 == opcode ? flagV : _GEN_426; // @[CPU6502.scala 30:22 65:22]
  wire [15:0] _GEN_447 = 8'ha5 == opcode ? _GEN_13 : _GEN_430; // @[CPU6502.scala 65:22]
  wire  _GEN_448 = 8'ha5 == opcode ? _GEN_14 : _GEN_431; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_449 = 8'ha5 == opcode ? _GEN_15 : _GEN_438; // @[CPU6502.scala 65:22]
  wire [15:0] _GEN_450 = 8'ha5 == opcode ? _GEN_5 : _GEN_435; // @[CPU6502.scala 65:22]
  wire [2:0] _GEN_451 = 8'ha5 == opcode ? _GEN_17 : _GEN_439; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_452 = 8'ha5 == opcode ? _GEN_18 : _GEN_442; // @[CPU6502.scala 65:22]
  wire  _GEN_453 = 8'ha5 == opcode ? _GEN_19 : _GEN_433; // @[CPU6502.scala 65:22]
  wire  _GEN_454 = 8'ha5 == opcode ? _GEN_20 : _GEN_434; // @[CPU6502.scala 65:22]
  wire [1:0] _GEN_455 = 8'ha5 == opcode ? _GEN_21 : _GEN_436; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_456 = 8'ha5 == opcode ? regX : _GEN_432; // @[CPU6502.scala 19:21 65:22]
  wire [7:0] _GEN_457 = 8'ha5 == opcode ? regY : _GEN_437; // @[CPU6502.scala 20:21 65:22]
  wire [7:0] _GEN_458 = 8'ha5 == opcode ? 8'h0 : _GEN_440; // @[CPU6502.scala 43:17 65:22]
  wire  _GEN_459 = 8'ha5 == opcode ? 1'h0 : _GEN_441; // @[CPU6502.scala 44:15 65:22]
  wire  _GEN_460 = 8'ha5 == opcode ? flagC : _GEN_443; // @[CPU6502.scala 25:22 65:22]
  wire  _GEN_461 = 8'ha5 == opcode ? flagV : _GEN_444; // @[CPU6502.scala 30:22 65:22]
  wire [15:0] _GEN_464 = 8'ha9 == opcode ? regPC : _GEN_447; // @[CPU6502.scala 65:22]
  wire  _GEN_465 = 8'ha9 == opcode ? _T_3 : _GEN_448; // @[CPU6502.scala 65:22]
  wire [7:0] _GEN_475 = 8'ha9 == opcode ? 8'h0 : _GEN_458; // @[CPU6502.scala 43:17 65:22]
  wire  _GEN_476 = 8'ha9 == opcode ? 1'h0 : _GEN_459; // @[CPU6502.scala 44:15 65:22]
  wire [15:0] _GEN_481 = 2'h1 == state ? _GEN_464 : regPC; // @[CPU6502.scala 42:14 54:17]
  wire  _GEN_482 = 2'h1 == state & _GEN_465; // @[CPU6502.scala 45:14 54:17]
  wire [7:0] _GEN_492 = 2'h1 == state ? _GEN_475 : 8'h0; // @[CPU6502.scala 43:17 54:17]
  assign io_memAddr = 2'h0 == state ? regPC : _GEN_481; // @[CPU6502.scala 54:17 56:18]
  assign io_memDataOut = 2'h0 == state ? 8'h0 : _GEN_492; // @[CPU6502.scala 43:17 54:17]
  assign io_memWrite = 2'h0 == state ? 1'h0 : 2'h1 == state & _GEN_476; // @[CPU6502.scala 44:15 54:17]
  assign io_memRead = 2'h0 == state | _GEN_482; // @[CPU6502.scala 54:17 57:18]
  assign io_debug_regA = regA; // @[CPU6502.scala 391:17]
  assign io_debug_regX = regX; // @[CPU6502.scala 392:17]
  assign io_debug_regY = regY; // @[CPU6502.scala 393:17]
  assign io_debug_regPC = regPC; // @[CPU6502.scala 394:18]
  assign io_debug_flagC = flagC; // @[CPU6502.scala 396:18]
  assign io_debug_flagZ = flagZ; // @[CPU6502.scala 397:18]
  assign io_debug_flagN = flagN; // @[CPU6502.scala 398:18]
  assign io_debug_flagV = flagV; // @[CPU6502.scala 399:18]
  assign io_debug_opcode = opcode; // @[CPU6502.scala 400:19]
  always @(posedge clock) begin
    if (reset) begin // @[CPU6502.scala 18:21]
      regA <= 8'h0; // @[CPU6502.scala 18:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (8'ha9 == opcode) begin // @[CPU6502.scala 65:22]
          regA <= _GEN_2;
        end else begin
          regA <= _GEN_452;
        end
      end
    end
    if (reset) begin // @[CPU6502.scala 19:21]
      regX <= 8'h0; // @[CPU6502.scala 19:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (!(8'ha9 == opcode)) begin // @[CPU6502.scala 65:22]
          regX <= _GEN_456;
        end
      end
    end
    if (reset) begin // @[CPU6502.scala 20:21]
      regY <= 8'h0; // @[CPU6502.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (!(8'ha9 == opcode)) begin // @[CPU6502.scala 65:22]
          regY <= _GEN_457;
        end
      end
    end
    if (reset) begin // @[CPU6502.scala 22:22]
      regPC <= 16'h0; // @[CPU6502.scala 22:22]
    end else if (2'h0 == state) begin // @[CPU6502.scala 54:17]
      regPC <= _regPC_T_1; // @[CPU6502.scala 59:13]
    end else if (2'h1 == state) begin // @[CPU6502.scala 54:17]
      if (8'ha9 == opcode) begin // @[CPU6502.scala 65:22]
        regPC <= _GEN_5;
      end else begin
        regPC <= _GEN_450;
      end
    end
    if (reset) begin // @[CPU6502.scala 25:22]
      flagC <= 1'h0; // @[CPU6502.scala 25:22]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (!(8'ha9 == opcode)) begin // @[CPU6502.scala 65:22]
          flagC <= _GEN_460;
        end
      end
    end
    if (reset) begin // @[CPU6502.scala 26:22]
      flagZ <= 1'h0; // @[CPU6502.scala 26:22]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (8'ha9 == opcode) begin // @[CPU6502.scala 65:22]
          flagZ <= _GEN_4;
        end else begin
          flagZ <= _GEN_454;
        end
      end
    end
    if (reset) begin // @[CPU6502.scala 30:22]
      flagV <= 1'h0; // @[CPU6502.scala 30:22]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (!(8'ha9 == opcode)) begin // @[CPU6502.scala 65:22]
          flagV <= _GEN_461;
        end
      end
    end
    if (reset) begin // @[CPU6502.scala 31:22]
      flagN <= 1'h0; // @[CPU6502.scala 31:22]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (8'ha9 == opcode) begin // @[CPU6502.scala 65:22]
          flagN <= _GEN_3;
        end else begin
          flagN <= _GEN_453;
        end
      end
    end
    if (reset) begin // @[CPU6502.scala 35:22]
      state <= 2'h0; // @[CPU6502.scala 35:22]
    end else if (2'h0 == state) begin // @[CPU6502.scala 54:17]
      state <= 2'h1; // @[CPU6502.scala 60:13]
    end else if (2'h1 == state) begin // @[CPU6502.scala 54:17]
      if (8'ha9 == opcode) begin // @[CPU6502.scala 65:22]
        state <= _GEN_6;
      end else begin
        state <= _GEN_455;
      end
    end
    if (reset) begin // @[CPU6502.scala 37:23]
      opcode <= 8'h0; // @[CPU6502.scala 37:23]
    end else if (2'h0 == state) begin // @[CPU6502.scala 54:17]
      opcode <= io_memDataIn; // @[CPU6502.scala 58:14]
    end
    if (reset) begin // @[CPU6502.scala 38:24]
      operand <= 16'h0; // @[CPU6502.scala 38:24]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (!(8'ha9 == opcode)) begin // @[CPU6502.scala 65:22]
          operand <= _GEN_449;
        end
      end
    end
    if (reset) begin // @[CPU6502.scala 39:22]
      cycle <= 3'h0; // @[CPU6502.scala 39:22]
    end else if (!(2'h0 == state)) begin // @[CPU6502.scala 54:17]
      if (2'h1 == state) begin // @[CPU6502.scala 54:17]
        if (!(8'ha9 == opcode)) begin // @[CPU6502.scala 65:22]
          cycle <= _GEN_451;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regA = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  regX = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  regY = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  regPC = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  flagC = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  flagZ = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  flagV = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  flagN = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  state = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  opcode = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  operand = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  cycle = _RAND_11[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Memory(
  input         clock,
  input  [15:0] io_addr,
  input  [7:0]  io_dataIn,
  output [7:0]  io_dataOut,
  input         io_write,
  input         io_read
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem [0:65535]; // @[Memory.scala 16:24]
  wire  mem_io_dataOut_MPORT_en; // @[Memory.scala 16:24]
  wire [15:0] mem_io_dataOut_MPORT_addr; // @[Memory.scala 16:24]
  wire [7:0] mem_io_dataOut_MPORT_data; // @[Memory.scala 16:24]
  wire [7:0] mem_MPORT_data; // @[Memory.scala 16:24]
  wire [15:0] mem_MPORT_addr; // @[Memory.scala 16:24]
  wire  mem_MPORT_mask; // @[Memory.scala 16:24]
  wire  mem_MPORT_en; // @[Memory.scala 16:24]
  reg  mem_io_dataOut_MPORT_en_pipe_0;
  reg [15:0] mem_io_dataOut_MPORT_addr_pipe_0;
  assign mem_io_dataOut_MPORT_en = mem_io_dataOut_MPORT_en_pipe_0;
  assign mem_io_dataOut_MPORT_addr = mem_io_dataOut_MPORT_addr_pipe_0;
  assign mem_io_dataOut_MPORT_data = mem[mem_io_dataOut_MPORT_addr]; // @[Memory.scala 16:24]
  assign mem_MPORT_data = io_dataIn;
  assign mem_MPORT_addr = io_addr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_write;
  assign io_dataOut = io_read ? mem_io_dataOut_MPORT_data : 8'h0; // @[Memory.scala 18:14 24:17 25:16]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[Memory.scala 16:24]
    end
    mem_io_dataOut_MPORT_en_pipe_0 <= io_read;
    if (io_read) begin
      mem_io_dataOut_MPORT_addr_pipe_0 <= io_addr;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 65536; initvar = initvar+1)
    mem[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_io_dataOut_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_dataOut_MPORT_addr_pipe_0 = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MyCpu6502(
  input         clock,
  input         reset,
  output [7:0]  io_debug_regA,
  output [7:0]  io_debug_regX,
  output [7:0]  io_debug_regY,
  output [15:0] io_debug_regPC,
  output [7:0]  io_debug_regSP,
  output        io_debug_flagC,
  output        io_debug_flagZ,
  output        io_debug_flagN,
  output        io_debug_flagV,
  output [7:0]  io_debug_opcode
);
  wire  cpu_clock; // @[MyCpu6502.scala 11:19]
  wire  cpu_reset; // @[MyCpu6502.scala 11:19]
  wire [15:0] cpu_io_memAddr; // @[MyCpu6502.scala 11:19]
  wire [7:0] cpu_io_memDataOut; // @[MyCpu6502.scala 11:19]
  wire [7:0] cpu_io_memDataIn; // @[MyCpu6502.scala 11:19]
  wire  cpu_io_memWrite; // @[MyCpu6502.scala 11:19]
  wire  cpu_io_memRead; // @[MyCpu6502.scala 11:19]
  wire [7:0] cpu_io_debug_regA; // @[MyCpu6502.scala 11:19]
  wire [7:0] cpu_io_debug_regX; // @[MyCpu6502.scala 11:19]
  wire [7:0] cpu_io_debug_regY; // @[MyCpu6502.scala 11:19]
  wire [15:0] cpu_io_debug_regPC; // @[MyCpu6502.scala 11:19]
  wire  cpu_io_debug_flagC; // @[MyCpu6502.scala 11:19]
  wire  cpu_io_debug_flagZ; // @[MyCpu6502.scala 11:19]
  wire  cpu_io_debug_flagN; // @[MyCpu6502.scala 11:19]
  wire  cpu_io_debug_flagV; // @[MyCpu6502.scala 11:19]
  wire [7:0] cpu_io_debug_opcode; // @[MyCpu6502.scala 11:19]
  wire  mem_clock; // @[MyCpu6502.scala 12:19]
  wire [15:0] mem_io_addr; // @[MyCpu6502.scala 12:19]
  wire [7:0] mem_io_dataIn; // @[MyCpu6502.scala 12:19]
  wire [7:0] mem_io_dataOut; // @[MyCpu6502.scala 12:19]
  wire  mem_io_write; // @[MyCpu6502.scala 12:19]
  wire  mem_io_read; // @[MyCpu6502.scala 12:19]
  CPU6502 cpu ( // @[MyCpu6502.scala 11:19]
    .clock(cpu_clock),
    .reset(cpu_reset),
    .io_memAddr(cpu_io_memAddr),
    .io_memDataOut(cpu_io_memDataOut),
    .io_memDataIn(cpu_io_memDataIn),
    .io_memWrite(cpu_io_memWrite),
    .io_memRead(cpu_io_memRead),
    .io_debug_regA(cpu_io_debug_regA),
    .io_debug_regX(cpu_io_debug_regX),
    .io_debug_regY(cpu_io_debug_regY),
    .io_debug_regPC(cpu_io_debug_regPC),
    .io_debug_flagC(cpu_io_debug_flagC),
    .io_debug_flagZ(cpu_io_debug_flagZ),
    .io_debug_flagN(cpu_io_debug_flagN),
    .io_debug_flagV(cpu_io_debug_flagV),
    .io_debug_opcode(cpu_io_debug_opcode)
  );
  Memory mem ( // @[MyCpu6502.scala 12:19]
    .clock(mem_clock),
    .io_addr(mem_io_addr),
    .io_dataIn(mem_io_dataIn),
    .io_dataOut(mem_io_dataOut),
    .io_write(mem_io_write),
    .io_read(mem_io_read)
  );
  assign io_debug_regA = cpu_io_debug_regA; // @[MyCpu6502.scala 22:12]
  assign io_debug_regX = cpu_io_debug_regX; // @[MyCpu6502.scala 22:12]
  assign io_debug_regY = cpu_io_debug_regY; // @[MyCpu6502.scala 22:12]
  assign io_debug_regPC = cpu_io_debug_regPC; // @[MyCpu6502.scala 22:12]
  assign io_debug_regSP = 8'hff; // @[MyCpu6502.scala 22:12]
  assign io_debug_flagC = cpu_io_debug_flagC; // @[MyCpu6502.scala 22:12]
  assign io_debug_flagZ = cpu_io_debug_flagZ; // @[MyCpu6502.scala 22:12]
  assign io_debug_flagN = cpu_io_debug_flagN; // @[MyCpu6502.scala 22:12]
  assign io_debug_flagV = cpu_io_debug_flagV; // @[MyCpu6502.scala 22:12]
  assign io_debug_opcode = cpu_io_debug_opcode; // @[MyCpu6502.scala 22:12]
  assign cpu_clock = clock;
  assign cpu_reset = reset;
  assign cpu_io_memDataIn = mem_io_dataOut; // @[MyCpu6502.scala 19:20]
  assign mem_clock = clock;
  assign mem_io_addr = cpu_io_memAddr; // @[MyCpu6502.scala 15:15]
  assign mem_io_dataIn = cpu_io_memDataOut; // @[MyCpu6502.scala 16:17]
  assign mem_io_write = cpu_io_memWrite; // @[MyCpu6502.scala 17:16]
  assign mem_io_read = cpu_io_memRead; // @[MyCpu6502.scala 18:15]
endmodule
