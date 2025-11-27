module CPU6502Core(
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
  output [7:0]  io_debug_regSP,
  output        io_debug_flagC,
  output        io_debug_flagZ,
  output        io_debug_flagN,
  output        io_debug_flagV,
  output [7:0]  io_debug_opcode,
  output [1:0]  io_debug_state,
  output [2:0]  io_debug_cycle,
  input         io_reset,
  input         io_nmi
);
  reg [7:0] regs_a; // @[CPU6502Core.scala 21:21]
  reg [7:0] regs_x; // @[CPU6502Core.scala 21:21]
  reg [7:0] regs_y; // @[CPU6502Core.scala 21:21]
  reg [7:0] regs_sp; // @[CPU6502Core.scala 21:21]
  reg [15:0] regs_pc; // @[CPU6502Core.scala 21:21]
  reg  regs_flagC; // @[CPU6502Core.scala 21:21]
  reg  regs_flagZ; // @[CPU6502Core.scala 21:21]
  reg  regs_flagI; // @[CPU6502Core.scala 21:21]
  reg  regs_flagD; // @[CPU6502Core.scala 21:21]
  reg  regs_flagV; // @[CPU6502Core.scala 21:21]
  reg  regs_flagN; // @[CPU6502Core.scala 21:21]
  reg [2:0] state; // @[CPU6502Core.scala 25:22]
  reg [7:0] opcode; // @[CPU6502Core.scala 27:24]
  reg [15:0] operand; // @[CPU6502Core.scala 28:24]
  reg [2:0] cycle; // @[CPU6502Core.scala 29:24]
  reg  nmiLast; // @[CPU6502Core.scala 32:24]
  reg  nmiEdge; // @[CPU6502Core.scala 33:24]
  wire  _GEN_0 = io_nmi & ~nmiLast | nmiEdge; // @[CPU6502Core.scala 39:28 40:13 33:24]
  wire  _T_4 = cycle == 3'h0; // @[CPU6502Core.scala 70:22]
  wire  _T_5 = cycle == 3'h1; // @[CPU6502Core.scala 76:28]
  wire  _T_6 = cycle == 3'h2; // @[CPU6502Core.scala 83:28]
  wire  _T_7 = cycle == 3'h3; // @[CPU6502Core.scala 89:28]
  wire [15:0] resetVector = {io_memDataIn,operand[7:0]}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_4 = cycle == 3'h3 ? 3'h4 : 3'h0; // @[CPU6502Core.scala 103:19 89:37 93:19]
  wire [15:0] _GEN_5 = cycle == 3'h3 ? regs_pc : resetVector; // @[CPU6502Core.scala 100:21 21:21 89:37]
  wire [7:0] _GEN_6 = cycle == 3'h3 ? regs_sp : 8'hfd; // @[CPU6502Core.scala 101:21 21:21 89:37]
  wire  _GEN_7 = cycle == 3'h3 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 21:21 102:24 89:37]
  wire [2:0] _GEN_8 = cycle == 3'h3 ? state : 3'h1; // @[CPU6502Core.scala 104:19 25:22 89:37]
  wire [2:0] _GEN_11 = cycle == 3'h2 ? 3'h3 : _GEN_4; // @[CPU6502Core.scala 83:37 87:19]
  wire [15:0] _GEN_12 = cycle == 3'h2 ? regs_pc : _GEN_5; // @[CPU6502Core.scala 21:21 83:37]
  wire [7:0] _GEN_13 = cycle == 3'h2 ? regs_sp : _GEN_6; // @[CPU6502Core.scala 21:21 83:37]
  wire  _GEN_14 = cycle == 3'h2 ? regs_flagI : _GEN_7; // @[CPU6502Core.scala 21:21 83:37]
  wire [2:0] _GEN_15 = cycle == 3'h2 ? state : _GEN_8; // @[CPU6502Core.scala 25:22 83:37]
  wire [15:0] _GEN_16 = cycle == 3'h1 ? 16'hfffc : 16'hfffd; // @[CPU6502Core.scala 76:37 78:24]
  wire [15:0] _GEN_18 = cycle == 3'h1 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 76:37 80:21 28:24]
  wire [2:0] _GEN_19 = cycle == 3'h1 ? 3'h2 : _GEN_11; // @[CPU6502Core.scala 76:37 81:19]
  wire [15:0] _GEN_20 = cycle == 3'h1 ? regs_pc : _GEN_12; // @[CPU6502Core.scala 21:21 76:37]
  wire [7:0] _GEN_21 = cycle == 3'h1 ? regs_sp : _GEN_13; // @[CPU6502Core.scala 21:21 76:37]
  wire  _GEN_22 = cycle == 3'h1 ? regs_flagI : _GEN_14; // @[CPU6502Core.scala 21:21 76:37]
  wire [2:0] _GEN_23 = cycle == 3'h1 ? state : _GEN_15; // @[CPU6502Core.scala 25:22 76:37]
  wire [15:0] _GEN_24 = cycle == 3'h0 ? 16'hfffc : _GEN_16; // @[CPU6502Core.scala 70:31 72:24]
  wire [15:0] _regs_pc_T_1 = regs_pc + 16'h1; // @[CPU6502Core.scala 118:32]
  wire [2:0] _GEN_33 = nmiEdge ? 3'h3 : 3'h2; // @[CPU6502Core.scala 111:25 113:19 120:19]
  wire  _GEN_35 = nmiEdge ? 1'h0 : 1'h1; // @[CPU6502Core.scala 111:25 52:17 116:24]
  wire [7:0] _GEN_36 = nmiEdge ? opcode : io_memDataIn; // @[CPU6502Core.scala 111:25 117:20 27:24]
  wire [15:0] _GEN_37 = nmiEdge ? regs_pc : _regs_pc_T_1; // @[CPU6502Core.scala 111:25 118:21 21:21]
  wire  _execResult_T = 8'h18 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_1 = 8'h38 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_2 = 8'hd8 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_3 = 8'hf8 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_4 = 8'h58 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_5 = 8'h78 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_6 = 8'hb8 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _GEN_38 = _execResult_T_6 ? 1'h0 : regs_flagV; // @[Flag.scala 14:13 24:20 31:34]
  wire  _GEN_39 = _execResult_T_5 | regs_flagI; // @[Flag.scala 14:13 24:20 30:34]
  wire  _GEN_40 = _execResult_T_5 ? regs_flagV : _GEN_38; // @[Flag.scala 14:13 24:20]
  wire  _GEN_41 = _execResult_T_4 ? 1'h0 : _GEN_39; // @[Flag.scala 24:20 29:34]
  wire  _GEN_42 = _execResult_T_4 ? regs_flagV : _GEN_40; // @[Flag.scala 14:13 24:20]
  wire  _GEN_43 = _execResult_T_3 | regs_flagD; // @[Flag.scala 14:13 24:20 28:34]
  wire  _GEN_44 = _execResult_T_3 ? regs_flagI : _GEN_41; // @[Flag.scala 14:13 24:20]
  wire  _GEN_45 = _execResult_T_3 ? regs_flagV : _GEN_42; // @[Flag.scala 14:13 24:20]
  wire  _GEN_46 = _execResult_T_2 ? 1'h0 : _GEN_43; // @[Flag.scala 24:20 27:34]
  wire  _GEN_47 = _execResult_T_2 ? regs_flagI : _GEN_44; // @[Flag.scala 14:13 24:20]
  wire  _GEN_48 = _execResult_T_2 ? regs_flagV : _GEN_45; // @[Flag.scala 14:13 24:20]
  wire  _GEN_49 = _execResult_T_1 | regs_flagC; // @[Flag.scala 14:13 24:20 26:34]
  wire  _GEN_50 = _execResult_T_1 ? regs_flagD : _GEN_46; // @[Flag.scala 14:13 24:20]
  wire  _GEN_51 = _execResult_T_1 ? regs_flagI : _GEN_47; // @[Flag.scala 14:13 24:20]
  wire  _GEN_52 = _execResult_T_1 ? regs_flagV : _GEN_48; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagC = _execResult_T ? 1'h0 : _GEN_49; // @[Flag.scala 24:20 25:34]
  wire  execResult_result_newRegs_flagD = _execResult_T ? regs_flagD : _GEN_50; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagI = _execResult_T ? regs_flagI : _GEN_51; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagV = _execResult_T ? regs_flagV : _GEN_52; // @[Flag.scala 14:13 24:20]
  wire  _execResult_T_15 = 8'haa == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_16 = 8'ha8 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_17 = 8'h8a == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_18 = 8'h98 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_19 = 8'hba == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_20 = 8'h9a == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_result_newRegs_flagZ_T = regs_a == 8'h0; // @[Transfer.scala 28:33]
  wire [7:0] _GEN_57 = _execResult_T_20 ? regs_x : regs_sp; // @[Transfer.scala 14:13 24:20 51:20]
  wire [7:0] _GEN_58 = _execResult_T_19 ? regs_sp : regs_x; // @[Transfer.scala 14:13 24:20 46:19]
  wire  _GEN_59 = _execResult_T_19 ? regs_sp[7] : regs_flagN; // @[Transfer.scala 14:13 24:20 47:23]
  wire  _GEN_60 = _execResult_T_19 ? regs_sp == 8'h0 : regs_flagZ; // @[Transfer.scala 14:13 24:20 48:23]
  wire [7:0] _GEN_61 = _execResult_T_19 ? regs_sp : _GEN_57; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_62 = _execResult_T_18 ? regs_y : regs_a; // @[Transfer.scala 14:13 24:20 41:19]
  wire  _GEN_63 = _execResult_T_18 ? regs_y[7] : _GEN_59; // @[Transfer.scala 24:20 42:23]
  wire  _GEN_64 = _execResult_T_18 ? regs_y == 8'h0 : _GEN_60; // @[Transfer.scala 24:20 43:23]
  wire [7:0] _GEN_65 = _execResult_T_18 ? regs_x : _GEN_58; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_66 = _execResult_T_18 ? regs_sp : _GEN_61; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_67 = _execResult_T_17 ? regs_x : _GEN_62; // @[Transfer.scala 24:20 36:19]
  wire  _GEN_68 = _execResult_T_17 ? regs_x[7] : _GEN_63; // @[Transfer.scala 24:20 37:23]
  wire  _GEN_69 = _execResult_T_17 ? regs_x == 8'h0 : _GEN_64; // @[Transfer.scala 24:20 38:23]
  wire [7:0] _GEN_70 = _execResult_T_17 ? regs_x : _GEN_65; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_71 = _execResult_T_17 ? regs_sp : _GEN_66; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_72 = _execResult_T_16 ? regs_a : regs_y; // @[Transfer.scala 14:13 24:20 31:19]
  wire  _GEN_73 = _execResult_T_16 ? regs_a[7] : _GEN_68; // @[Transfer.scala 24:20 32:23]
  wire  _GEN_74 = _execResult_T_16 ? _execResult_result_newRegs_flagZ_T : _GEN_69; // @[Transfer.scala 24:20 33:23]
  wire [7:0] _GEN_75 = _execResult_T_16 ? regs_a : _GEN_67; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_76 = _execResult_T_16 ? regs_x : _GEN_70; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_77 = _execResult_T_16 ? regs_sp : _GEN_71; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_x = _execResult_T_15 ? regs_a : _GEN_76; // @[Transfer.scala 24:20 26:19]
  wire  execResult_result_newRegs_1_flagN = _execResult_T_15 ? regs_a[7] : _GEN_73; // @[Transfer.scala 24:20 27:23]
  wire  execResult_result_newRegs_1_flagZ = _execResult_T_15 ? regs_a == 8'h0 : _GEN_74; // @[Transfer.scala 24:20 28:23]
  wire [7:0] execResult_result_newRegs_1_y = _execResult_T_15 ? regs_y : _GEN_72; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_a = _execResult_T_15 ? regs_a : _GEN_75; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_sp = _execResult_T_15 ? regs_sp : _GEN_77; // @[Transfer.scala 14:13 24:20]
  wire  _execResult_T_26 = 8'he8 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_27 = 8'hc8 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_28 = 8'hca == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_29 = 8'h88 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_30 = 8'h1a == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_31 = 8'h3a == opcode; // @[CPU6502Core.scala 215:20]
  wire [7:0] execResult_result_res = regs_x + 8'h1; // @[Arithmetic.scala 55:26]
  wire [7:0] execResult_result_res_1 = regs_y + 8'h1; // @[Arithmetic.scala 61:26]
  wire [7:0] execResult_result_res_2 = regs_x - 8'h1; // @[Arithmetic.scala 67:26]
  wire [7:0] execResult_result_res_3 = regs_y - 8'h1; // @[Arithmetic.scala 73:26]
  wire [7:0] execResult_result_res_4 = regs_a + 8'h1; // @[Arithmetic.scala 79:26]
  wire [7:0] execResult_result_res_5 = regs_a - 8'h1; // @[Arithmetic.scala 85:26]
  wire [7:0] _GEN_84 = _execResult_T_31 ? execResult_result_res_5 : regs_a; // @[Arithmetic.scala 43:13 53:20 86:19]
  wire  _GEN_85 = _execResult_T_31 ? execResult_result_res_5[7] : regs_flagN; // @[Arithmetic.scala 43:13 53:20 87:23]
  wire  _GEN_86 = _execResult_T_31 ? execResult_result_res_5 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 43:13 53:20 88:23]
  wire [7:0] _GEN_87 = _execResult_T_30 ? execResult_result_res_4 : _GEN_84; // @[Arithmetic.scala 53:20 80:19]
  wire  _GEN_88 = _execResult_T_30 ? execResult_result_res_4[7] : _GEN_85; // @[Arithmetic.scala 53:20 81:23]
  wire  _GEN_89 = _execResult_T_30 ? execResult_result_res_4 == 8'h0 : _GEN_86; // @[Arithmetic.scala 53:20 82:23]
  wire [7:0] _GEN_90 = _execResult_T_29 ? execResult_result_res_3 : regs_y; // @[Arithmetic.scala 43:13 53:20 74:19]
  wire  _GEN_91 = _execResult_T_29 ? execResult_result_res_3[7] : _GEN_88; // @[Arithmetic.scala 53:20 75:23]
  wire  _GEN_92 = _execResult_T_29 ? execResult_result_res_3 == 8'h0 : _GEN_89; // @[Arithmetic.scala 53:20 76:23]
  wire [7:0] _GEN_93 = _execResult_T_29 ? regs_a : _GEN_87; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] _GEN_94 = _execResult_T_28 ? execResult_result_res_2 : regs_x; // @[Arithmetic.scala 43:13 53:20 68:19]
  wire  _GEN_95 = _execResult_T_28 ? execResult_result_res_2[7] : _GEN_91; // @[Arithmetic.scala 53:20 69:23]
  wire  _GEN_96 = _execResult_T_28 ? execResult_result_res_2 == 8'h0 : _GEN_92; // @[Arithmetic.scala 53:20 70:23]
  wire [7:0] _GEN_97 = _execResult_T_28 ? regs_y : _GEN_90; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] _GEN_98 = _execResult_T_28 ? regs_a : _GEN_93; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] _GEN_99 = _execResult_T_27 ? execResult_result_res_1 : _GEN_97; // @[Arithmetic.scala 53:20 62:19]
  wire  _GEN_100 = _execResult_T_27 ? execResult_result_res_1[7] : _GEN_95; // @[Arithmetic.scala 53:20 63:23]
  wire  _GEN_101 = _execResult_T_27 ? execResult_result_res_1 == 8'h0 : _GEN_96; // @[Arithmetic.scala 53:20 64:23]
  wire [7:0] _GEN_102 = _execResult_T_27 ? regs_x : _GEN_94; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] _GEN_103 = _execResult_T_27 ? regs_a : _GEN_98; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] execResult_result_newRegs_2_x = _execResult_T_26 ? execResult_result_res : _GEN_102; // @[Arithmetic.scala 53:20 56:19]
  wire  execResult_result_newRegs_2_flagN = _execResult_T_26 ? execResult_result_res[7] : _GEN_100; // @[Arithmetic.scala 53:20 57:23]
  wire  execResult_result_newRegs_2_flagZ = _execResult_T_26 ? execResult_result_res == 8'h0 : _GEN_101; // @[Arithmetic.scala 53:20 58:23]
  wire [7:0] execResult_result_newRegs_2_y = _execResult_T_26 ? regs_y : _GEN_99; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] execResult_result_newRegs_2_a = _execResult_T_26 ? regs_a : _GEN_103; // @[Arithmetic.scala 43:13 53:20]
  wire [8:0] _execResult_result_sum_T = regs_a + io_memDataIn; // @[Arithmetic.scala 102:22]
  wire [8:0] _GEN_4174 = {{8'd0}, regs_flagC}; // @[Arithmetic.scala 102:35]
  wire [9:0] execResult_result_sum = _execResult_result_sum_T + _GEN_4174; // @[Arithmetic.scala 102:35]
  wire [7:0] execResult_result_newRegs_3_a = execResult_result_sum[7:0]; // @[Arithmetic.scala 103:21]
  wire  execResult_result_newRegs_3_flagC = execResult_result_sum[8]; // @[Arithmetic.scala 104:25]
  wire  execResult_result_newRegs_3_flagN = execResult_result_sum[7]; // @[Arithmetic.scala 105:25]
  wire  execResult_result_newRegs_3_flagZ = execResult_result_newRegs_3_a == 8'h0; // @[Arithmetic.scala 106:32]
  wire  execResult_result_newRegs_3_flagV = regs_a[7] == io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_3_flagN; // @[Arithmetic.scala 107:51]
  wire [8:0] _execResult_result_diff_T = regs_a - io_memDataIn; // @[Arithmetic.scala 127:23]
  wire  _execResult_result_diff_T_2 = ~regs_flagC; // @[Arithmetic.scala 127:40]
  wire [8:0] _GEN_4175 = {{8'd0}, _execResult_result_diff_T_2}; // @[Arithmetic.scala 127:36]
  wire [9:0] execResult_result_diff = _execResult_result_diff_T - _GEN_4175; // @[Arithmetic.scala 127:36]
  wire [7:0] execResult_result_newRegs_4_a = execResult_result_diff[7:0]; // @[Arithmetic.scala 128:22]
  wire  execResult_result_newRegs_4_flagC = ~execResult_result_diff[8]; // @[Arithmetic.scala 129:22]
  wire  execResult_result_newRegs_4_flagN = execResult_result_diff[7]; // @[Arithmetic.scala 130:26]
  wire  execResult_result_newRegs_4_flagZ = execResult_result_newRegs_4_a == 8'h0; // @[Arithmetic.scala 131:33]
  wire  execResult_result_newRegs_4_flagV = regs_a[7] != io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 132:51]
  wire [2:0] execResult_result_result_6_nextCycle = cycle + 3'h1; // @[Arithmetic.scala 371:31]
  wire  _execResult_result_T_20 = 3'h0 == cycle; // @[Arithmetic.scala 379:19]
  wire  _execResult_result_T_21 = 3'h1 == cycle; // @[Arithmetic.scala 379:19]
  wire  _execResult_result_isADC_T_5 = opcode == 8'h6d; // @[Arithmetic.scala 337:25]
  wire  _execResult_result_isADC_T_6 = opcode == 8'h69 | opcode == 8'h65 | opcode == 8'h75 |
    _execResult_result_isADC_T_5; // @[Arithmetic.scala 336:83]
  wire  _execResult_result_isADC_T_7 = opcode == 8'h7d; // @[Arithmetic.scala 337:48]
  wire  _execResult_result_isADC_T_9 = opcode == 8'h79; // @[Arithmetic.scala 337:71]
  wire  _execResult_result_isADC_T_11 = opcode == 8'h61; // @[Arithmetic.scala 338:25]
  wire  _execResult_result_isADC_T_12 = _execResult_result_isADC_T_6 | opcode == 8'h7d | opcode == 8'h79 |
    _execResult_result_isADC_T_11; // @[Arithmetic.scala 337:83]
  wire  execResult_result_isADC = _execResult_result_isADC_T_12 | opcode == 8'h71; // @[Arithmetic.scala 338:37]
  wire [7:0] execResult_result_res_6 = execResult_result_isADC ? execResult_result_newRegs_3_a :
    execResult_result_newRegs_4_a; // @[Arithmetic.scala 345:17 348:14 355:14]
  wire  execResult_result_flagC = execResult_result_isADC ? execResult_result_newRegs_3_flagC :
    execResult_result_newRegs_4_flagC; // @[Arithmetic.scala 345:17 349:13 356:13]
  wire  execResult_result_flagN = execResult_result_isADC ? execResult_result_newRegs_3_flagN :
    execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 345:17 350:13 357:13]
  wire  execResult_result_flagV = execResult_result_isADC ? execResult_result_newRegs_3_flagV :
    execResult_result_newRegs_4_flagV; // @[Arithmetic.scala 345:17 351:13 358:13]
  wire  _execResult_result_newRegs_flagZ_T_15 = execResult_result_res_6 == 8'h0; // @[Arithmetic.scala 395:30]
  wire [15:0] _GEN_113 = 3'h1 == cycle ? operand : 16'h0; // @[Arithmetic.scala 379:19 373:20 388:24]
  wire [7:0] _GEN_115 = 3'h1 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 368:13 379:19 391:19]
  wire  _GEN_116 = 3'h1 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 368:13 379:19 392:23]
  wire  _GEN_117 = 3'h1 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 368:13 379:19 393:23]
  wire  _GEN_118 = 3'h1 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 368:13 379:19 394:23]
  wire  _GEN_119 = 3'h1 == cycle ? execResult_result_res_6 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 368:13 379:19 395:23]
  wire [7:0] execResult_result_newRegs_5_a = 3'h0 == cycle ? regs_a : _GEN_115; // @[Arithmetic.scala 368:13 379:19]
  wire [15:0] execResult_result_newRegs_5_pc = 3'h0 == cycle ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 368:13 379:19 384:20]
  wire  execResult_result_newRegs_5_flagC = 3'h0 == cycle ? regs_flagC : _GEN_116; // @[Arithmetic.scala 368:13 379:19]
  wire  execResult_result_newRegs_5_flagZ = 3'h0 == cycle ? regs_flagZ : _GEN_119; // @[Arithmetic.scala 368:13 379:19]
  wire  execResult_result_newRegs_5_flagV = 3'h0 == cycle ? regs_flagV : _GEN_117; // @[Arithmetic.scala 368:13 379:19]
  wire  execResult_result_newRegs_5_flagN = 3'h0 == cycle ? regs_flagN : _GEN_118; // @[Arithmetic.scala 368:13 379:19]
  wire [15:0] execResult_result_result_6_memAddr = 3'h0 == cycle ? regs_pc : _GEN_113; // @[Arithmetic.scala 379:19 381:24]
  wire  execResult_result_result_6_memRead = 3'h0 == cycle | 3'h1 == cycle; // @[Arithmetic.scala 379:19 382:24]
  wire [15:0] execResult_result_result_6_operand = 3'h0 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Arithmetic.scala 379:19 377:20 383:24]
  wire  execResult_result_result_6_done = 3'h0 == cycle ? 1'h0 : 3'h1 == cycle; // @[Arithmetic.scala 370:17 379:19]
  wire [7:0] _execResult_result_result_operand_T_1 = io_memDataIn + regs_x; // @[Arithmetic.scala 423:38]
  wire [15:0] execResult_result_result_7_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : operand; // @[Arithmetic.scala 419:19 417:20 423:24]
  wire  _execResult_result_T_26 = 3'h2 == cycle; // @[Arithmetic.scala 459:19]
  wire [15:0] _GEN_203 = 3'h2 == cycle ? operand : 16'h0; // @[Arithmetic.scala 459:19 453:20 475:24]
  wire [7:0] _GEN_205 = 3'h2 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 448:13 459:19 478:19]
  wire  _GEN_206 = 3'h2 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 448:13 459:19 479:23]
  wire  _GEN_207 = 3'h2 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 448:13 459:19 480:23]
  wire  _GEN_208 = 3'h2 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 448:13 459:19 481:23]
  wire  _GEN_209 = 3'h2 == cycle ? _execResult_result_newRegs_flagZ_T_15 : regs_flagZ; // @[Arithmetic.scala 448:13 459:19 482:23]
  wire [7:0] _GEN_238 = _execResult_result_T_21 ? regs_a : _GEN_205; // @[Arithmetic.scala 448:13 459:19]
  wire [7:0] execResult_result_newRegs_7_a = _execResult_result_T_20 ? regs_a : _GEN_238; // @[Arithmetic.scala 448:13 459:19]
  wire [15:0] _GEN_225 = _execResult_result_T_21 ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 448:13 459:19 471:20]
  wire [15:0] execResult_result_newRegs_7_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_225; // @[Arithmetic.scala 459:19 464:20]
  wire  _GEN_239 = _execResult_result_T_21 ? regs_flagC : _GEN_206; // @[Arithmetic.scala 448:13 459:19]
  wire  execResult_result_newRegs_7_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_239; // @[Arithmetic.scala 448:13 459:19]
  wire  _GEN_242 = _execResult_result_T_21 ? regs_flagZ : _GEN_209; // @[Arithmetic.scala 448:13 459:19]
  wire  execResult_result_newRegs_7_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_242; // @[Arithmetic.scala 448:13 459:19]
  wire  _GEN_240 = _execResult_result_T_21 ? regs_flagV : _GEN_207; // @[Arithmetic.scala 448:13 459:19]
  wire  execResult_result_newRegs_7_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_240; // @[Arithmetic.scala 448:13 459:19]
  wire  _GEN_241 = _execResult_result_T_21 ? regs_flagN : _GEN_208; // @[Arithmetic.scala 448:13 459:19]
  wire  execResult_result_newRegs_7_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_241; // @[Arithmetic.scala 448:13 459:19]
  wire [15:0] _GEN_222 = _execResult_result_T_21 ? regs_pc : _GEN_203; // @[Arithmetic.scala 459:19 468:24]
  wire  _GEN_223 = _execResult_result_T_21 | 3'h2 == cycle; // @[Arithmetic.scala 459:19 469:24]
  wire [15:0] _GEN_224 = _execResult_result_T_21 ? resetVector : operand; // @[Arithmetic.scala 459:19 457:20 470:24]
  wire  _GEN_243 = _execResult_result_T_21 ? 1'h0 : 3'h2 == cycle; // @[Arithmetic.scala 450:17 459:19]
  wire [15:0] execResult_result_result_8_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_222; // @[Arithmetic.scala 459:19 461:24]
  wire  execResult_result_result_8_memRead = _execResult_result_T_20 | _GEN_223; // @[Arithmetic.scala 459:19 462:24]
  wire [15:0] execResult_result_result_8_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_224; // @[Arithmetic.scala 459:19 463:24]
  wire  execResult_result_result_8_done = _execResult_result_T_20 ? 1'h0 : _GEN_243; // @[Arithmetic.scala 450:17 459:19]
  wire [15:0] _execResult_result_result_operand_T_9 = {operand[15:8],io_memDataIn}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_result_memAddr_T_3 = operand[7:0] + 8'h1; // @[Arithmetic.scala 520:42]
  wire  _execResult_result_T_30 = 3'h3 == cycle; // @[Arithmetic.scala 506:19]
  wire [15:0] _GEN_270 = 3'h3 == cycle ? operand : 16'h0; // @[Arithmetic.scala 506:19 500:20 525:24]
  wire [7:0] _GEN_272 = 3'h3 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 495:13 506:19 528:19]
  wire  _GEN_273 = 3'h3 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 495:13 506:19 529:23]
  wire  _GEN_274 = 3'h3 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 495:13 506:19 530:23]
  wire  _GEN_275 = 3'h3 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 495:13 506:19 531:23]
  wire  _GEN_276 = 3'h3 == cycle ? _execResult_result_newRegs_flagZ_T_15 : regs_flagZ; // @[Arithmetic.scala 495:13 506:19 532:23]
  wire [7:0] _GEN_292 = _execResult_result_T_26 ? regs_a : _GEN_272; // @[Arithmetic.scala 495:13 506:19]
  wire [7:0] _GEN_313 = _execResult_result_T_21 ? regs_a : _GEN_292; // @[Arithmetic.scala 495:13 506:19]
  wire [7:0] execResult_result_newRegs_8_a = _execResult_result_T_20 ? regs_a : _GEN_313; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_293 = _execResult_result_T_26 ? regs_flagC : _GEN_273; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_314 = _execResult_result_T_21 ? regs_flagC : _GEN_293; // @[Arithmetic.scala 495:13 506:19]
  wire  execResult_result_newRegs_8_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_314; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_296 = _execResult_result_T_26 ? regs_flagZ : _GEN_276; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_317 = _execResult_result_T_21 ? regs_flagZ : _GEN_296; // @[Arithmetic.scala 495:13 506:19]
  wire  execResult_result_newRegs_8_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_317; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_294 = _execResult_result_T_26 ? regs_flagV : _GEN_274; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_315 = _execResult_result_T_21 ? regs_flagV : _GEN_294; // @[Arithmetic.scala 495:13 506:19]
  wire  execResult_result_newRegs_8_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_315; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_295 = _execResult_result_T_26 ? regs_flagN : _GEN_275; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_316 = _execResult_result_T_21 ? regs_flagN : _GEN_295; // @[Arithmetic.scala 495:13 506:19]
  wire  execResult_result_newRegs_8_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_316; // @[Arithmetic.scala 495:13 506:19]
  wire [15:0] _GEN_289 = _execResult_result_T_26 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_270; // @[Arithmetic.scala 506:19 520:24]
  wire  _GEN_290 = _execResult_result_T_26 | 3'h3 == cycle; // @[Arithmetic.scala 506:19 521:24]
  wire [15:0] _GEN_291 = _execResult_result_T_26 ? resetVector : operand; // @[Arithmetic.scala 506:19 504:20 522:24]
  wire  _GEN_309 = _execResult_result_T_26 ? 1'h0 : 3'h3 == cycle; // @[Arithmetic.scala 497:17 506:19]
  wire [15:0] _GEN_310 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_289; // @[Arithmetic.scala 506:19 515:24]
  wire  _GEN_311 = _execResult_result_T_21 | _GEN_290; // @[Arithmetic.scala 506:19 516:24]
  wire [15:0] _GEN_312 = _execResult_result_T_21 ? _execResult_result_result_operand_T_9 : _GEN_291; // @[Arithmetic.scala 506:19 517:24]
  wire  _GEN_330 = _execResult_result_T_21 ? 1'h0 : _GEN_309; // @[Arithmetic.scala 497:17 506:19]
  wire [15:0] execResult_result_result_9_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_310; // @[Arithmetic.scala 506:19 508:24]
  wire  execResult_result_result_9_memRead = _execResult_result_T_20 | _GEN_311; // @[Arithmetic.scala 506:19 509:24]
  wire [15:0] execResult_result_result_9_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : _GEN_312; // @[Arithmetic.scala 506:19 510:24]
  wire  execResult_result_result_9_done = _execResult_result_T_20 ? 1'h0 : _GEN_330; // @[Arithmetic.scala 497:17 506:19]
  wire [15:0] _GEN_4184 = {{8'd0}, regs_y}; // @[Arithmetic.scala 572:57]
  wire [15:0] _execResult_result_result_operand_T_17 = resetVector + _GEN_4184; // @[Arithmetic.scala 572:57]
  wire [15:0] _GEN_378 = _execResult_result_T_26 ? _execResult_result_result_operand_T_17 : operand; // @[Arithmetic.scala 556:19 554:20 572:24]
  wire [15:0] _GEN_399 = _execResult_result_T_21 ? _execResult_result_result_operand_T_9 : _GEN_378; // @[Arithmetic.scala 556:19 567:24]
  wire [15:0] execResult_result_result_10_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_399; // @[Arithmetic.scala 556:19 560:24]
  wire [7:0] _execResult_result_res_T_8 = io_memDataIn + 8'h1; // @[Arithmetic.scala 177:52]
  wire [7:0] _execResult_result_res_T_10 = io_memDataIn - 8'h1; // @[Arithmetic.scala 177:69]
  wire [7:0] execResult_result_res_11 = opcode == 8'he6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 177:22]
  wire [7:0] _GEN_441 = _execResult_result_T_26 ? execResult_result_res_11 : 8'h0; // @[Arithmetic.scala 161:19 156:20 178:24]
  wire  _GEN_443 = _execResult_result_T_26 ? execResult_result_res_11[7] : regs_flagN; // @[Arithmetic.scala 150:13 161:19 180:23]
  wire  _GEN_444 = _execResult_result_T_26 ? execResult_result_res_11 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 150:13 161:19 181:23]
  wire  _GEN_463 = _execResult_result_T_21 ? regs_flagZ : _GEN_444; // @[Arithmetic.scala 150:13 161:19]
  wire  execResult_result_newRegs_10_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_463; // @[Arithmetic.scala 150:13 161:19]
  wire  _GEN_462 = _execResult_result_T_21 ? regs_flagN : _GEN_443; // @[Arithmetic.scala 150:13 161:19]
  wire  execResult_result_newRegs_10_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_462; // @[Arithmetic.scala 150:13 161:19]
  wire [15:0] _GEN_457 = _execResult_result_T_21 ? operand : _GEN_203; // @[Arithmetic.scala 161:19 171:24]
  wire [2:0] _GEN_459 = _execResult_result_T_21 ? 3'h2 : execResult_result_result_6_nextCycle; // @[Arithmetic.scala 161:19 153:22 173:26]
  wire [7:0] _GEN_460 = _execResult_result_T_21 ? 8'h0 : _GEN_441; // @[Arithmetic.scala 161:19 156:20]
  wire [15:0] execResult_result_result_11_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_457; // @[Arithmetic.scala 161:19 163:24]
  wire [2:0] execResult_result_result_11_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_459; // @[Arithmetic.scala 161:19 168:26]
  wire [7:0] execResult_result_result_11_memData = _execResult_result_T_20 ? 8'h0 : _GEN_460; // @[Arithmetic.scala 161:19 156:20]
  wire [7:0] execResult_result_res_12 = opcode == 8'hf6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 219:22]
  wire [7:0] _GEN_498 = _execResult_result_T_26 ? execResult_result_res_12 : 8'h0; // @[Arithmetic.scala 205:19 200:20 220:24]
  wire  _GEN_500 = _execResult_result_T_26 ? execResult_result_res_12[7] : regs_flagN; // @[Arithmetic.scala 194:13 205:19 222:23]
  wire  _GEN_501 = _execResult_result_T_26 ? execResult_result_res_12 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 194:13 205:19 223:23]
  wire  _GEN_519 = _execResult_result_T_21 ? regs_flagZ : _GEN_501; // @[Arithmetic.scala 194:13 205:19]
  wire  execResult_result_newRegs_11_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_519; // @[Arithmetic.scala 194:13 205:19]
  wire  _GEN_518 = _execResult_result_T_21 ? regs_flagN : _GEN_500; // @[Arithmetic.scala 194:13 205:19]
  wire  execResult_result_newRegs_11_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_518; // @[Arithmetic.scala 194:13 205:19]
  wire [7:0] _GEN_516 = _execResult_result_T_21 ? 8'h0 : _GEN_498; // @[Arithmetic.scala 205:19 200:20]
  wire [7:0] execResult_result_result_12_memData = _execResult_result_T_20 ? 8'h0 : _GEN_516; // @[Arithmetic.scala 205:19 200:20]
  wire [7:0] execResult_result_res_13 = opcode == 8'hee ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 272:22]
  wire [7:0] _GEN_553 = _execResult_result_T_30 ? execResult_result_res_13 : 8'h0; // @[Arithmetic.scala 247:19 242:20 273:24]
  wire  _GEN_555 = _execResult_result_T_30 ? execResult_result_res_13[7] : regs_flagN; // @[Arithmetic.scala 236:13 247:19 275:23]
  wire  _GEN_556 = _execResult_result_T_30 ? execResult_result_res_13 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 236:13 247:19 276:23]
  wire  _GEN_574 = _execResult_result_T_26 ? regs_flagZ : _GEN_556; // @[Arithmetic.scala 236:13 247:19]
  wire  _GEN_606 = _execResult_result_T_21 ? regs_flagZ : _GEN_574; // @[Arithmetic.scala 236:13 247:19]
  wire  execResult_result_newRegs_12_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_606; // @[Arithmetic.scala 236:13 247:19]
  wire  _GEN_573 = _execResult_result_T_26 ? regs_flagN : _GEN_555; // @[Arithmetic.scala 236:13 247:19]
  wire  _GEN_605 = _execResult_result_T_21 ? regs_flagN : _GEN_573; // @[Arithmetic.scala 236:13 247:19]
  wire  execResult_result_newRegs_12_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_605; // @[Arithmetic.scala 236:13 247:19]
  wire [15:0] _GEN_569 = _execResult_result_T_26 ? operand : _GEN_270; // @[Arithmetic.scala 247:19 266:24]
  wire [7:0] _GEN_571 = _execResult_result_T_26 ? 8'h0 : _GEN_553; // @[Arithmetic.scala 247:19 242:20]
  wire [15:0] _GEN_587 = _execResult_result_T_21 ? regs_pc : _GEN_569; // @[Arithmetic.scala 247:19 258:24]
  wire [7:0] _GEN_603 = _execResult_result_T_21 ? 8'h0 : _GEN_571; // @[Arithmetic.scala 247:19 242:20]
  wire [15:0] execResult_result_result_13_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_587; // @[Arithmetic.scala 247:19 250:24]
  wire [7:0] execResult_result_result_13_memData = _execResult_result_T_20 ? 8'h0 : _GEN_603; // @[Arithmetic.scala 247:19 242:20]
  wire [15:0] _GEN_4187 = {{8'd0}, regs_x}; // @[Arithmetic.scala 311:57]
  wire [15:0] _execResult_result_result_operand_T_26 = resetVector + _GEN_4187; // @[Arithmetic.scala 311:57]
  wire [7:0] execResult_result_res_14 = opcode == 8'hfe ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 321:22]
  wire [7:0] _GEN_628 = _execResult_result_T_30 ? execResult_result_res_14 : 8'h0; // @[Arithmetic.scala 300:19 295:20 322:24]
  wire  _GEN_630 = _execResult_result_T_30 ? execResult_result_res_14[7] : regs_flagN; // @[Arithmetic.scala 289:13 300:19 324:23]
  wire  _GEN_631 = _execResult_result_T_30 ? execResult_result_res_14 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 289:13 300:19 325:23]
  wire  _GEN_649 = _execResult_result_T_26 ? regs_flagZ : _GEN_631; // @[Arithmetic.scala 289:13 300:19]
  wire  _GEN_681 = _execResult_result_T_21 ? regs_flagZ : _GEN_649; // @[Arithmetic.scala 289:13 300:19]
  wire  execResult_result_newRegs_13_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_681; // @[Arithmetic.scala 289:13 300:19]
  wire  _GEN_648 = _execResult_result_T_26 ? regs_flagN : _GEN_630; // @[Arithmetic.scala 289:13 300:19]
  wire  _GEN_680 = _execResult_result_T_21 ? regs_flagN : _GEN_648; // @[Arithmetic.scala 289:13 300:19]
  wire  execResult_result_newRegs_13_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_680; // @[Arithmetic.scala 289:13 300:19]
  wire [7:0] _GEN_646 = _execResult_result_T_26 ? 8'h0 : _GEN_628; // @[Arithmetic.scala 300:19 295:20]
  wire [15:0] _GEN_664 = _execResult_result_T_21 ? _execResult_result_result_operand_T_26 : operand; // @[Arithmetic.scala 300:19 298:20 311:24]
  wire [7:0] _GEN_678 = _execResult_result_T_21 ? 8'h0 : _GEN_646; // @[Arithmetic.scala 300:19 295:20]
  wire [15:0] execResult_result_result_14_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_664; // @[Arithmetic.scala 300:19 304:24]
  wire [7:0] execResult_result_result_14_memData = _execResult_result_T_20 ? 8'h0 : _GEN_678; // @[Arithmetic.scala 300:19 295:20]
  wire  execResult_result_useY = _execResult_result_isADC_T_9 | opcode == 8'hf9; // @[Arithmetic.scala 607:36]
  wire [7:0] execResult_result_index = execResult_result_useY ? regs_y : regs_x; // @[Arithmetic.scala 608:20]
  wire [15:0] _GEN_4188 = {{8'd0}, execResult_result_index}; // @[Arithmetic.scala 629:28]
  wire [15:0] execResult_result_addr = operand + _GEN_4188; // @[Arithmetic.scala 629:28]
  wire  execResult_result_isADC_5 = _execResult_result_isADC_T_9 | _execResult_result_isADC_T_7; // @[Arithmetic.scala 635:41]
  wire [7:0] _GEN_702 = execResult_result_isADC_5 ? execResult_result_newRegs_3_a : execResult_result_newRegs_4_a; // @[Arithmetic.scala 637:21 640:21 648:21]
  wire  _GEN_703 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagC : execResult_result_newRegs_4_flagC; // @[Arithmetic.scala 637:21 641:25 649:25]
  wire  _GEN_704 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagN : execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 637:21 642:25 650:25]
  wire  _GEN_705 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagZ : execResult_result_newRegs_4_flagZ; // @[Arithmetic.scala 637:21 643:25 651:25]
  wire  _GEN_706 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagV : execResult_result_newRegs_4_flagV; // @[Arithmetic.scala 637:21 644:25 652:25]
  wire [7:0] _GEN_707 = _execResult_result_T_30 ? _GEN_702 : regs_a; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_708 = _execResult_result_T_30 ? _GEN_703 : regs_flagC; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_709 = _execResult_result_T_30 ? _GEN_704 : regs_flagN; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_710 = _execResult_result_T_30 ? _GEN_705 : regs_flagZ; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_711 = _execResult_result_T_30 ? _GEN_706 : regs_flagV; // @[Arithmetic.scala 595:13 610:19]
  wire [7:0] _GEN_727 = _execResult_result_T_26 ? regs_a : _GEN_707; // @[Arithmetic.scala 595:13 610:19]
  wire [7:0] _GEN_761 = _execResult_result_T_21 ? regs_a : _GEN_727; // @[Arithmetic.scala 595:13 610:19]
  wire [7:0] execResult_result_newRegs_14_a = _execResult_result_T_20 ? regs_a : _GEN_761; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_728 = _execResult_result_T_26 ? regs_flagC : _GEN_708; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_762 = _execResult_result_T_21 ? regs_flagC : _GEN_728; // @[Arithmetic.scala 595:13 610:19]
  wire  execResult_result_newRegs_14_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_762; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_730 = _execResult_result_T_26 ? regs_flagZ : _GEN_710; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_764 = _execResult_result_T_21 ? regs_flagZ : _GEN_730; // @[Arithmetic.scala 595:13 610:19]
  wire  execResult_result_newRegs_14_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_764; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_731 = _execResult_result_T_26 ? regs_flagV : _GEN_711; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_765 = _execResult_result_T_21 ? regs_flagV : _GEN_731; // @[Arithmetic.scala 595:13 610:19]
  wire  execResult_result_newRegs_14_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_765; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_729 = _execResult_result_T_26 ? regs_flagN : _GEN_709; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_763 = _execResult_result_T_21 ? regs_flagN : _GEN_729; // @[Arithmetic.scala 595:13 610:19]
  wire  execResult_result_newRegs_14_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_763; // @[Arithmetic.scala 595:13 610:19]
  wire [15:0] _GEN_725 = _execResult_result_T_26 ? execResult_result_addr : 16'h0; // @[Arithmetic.scala 610:19 600:20 630:24]
  wire [15:0] _GEN_745 = _execResult_result_T_21 ? regs_pc : _GEN_725; // @[Arithmetic.scala 610:19 621:24]
  wire [15:0] execResult_result_result_15_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_745; // @[Arithmetic.scala 610:19 613:24]
  wire  _execResult_T_73 = 8'h29 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_74 = 8'h9 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_75 = 8'h49 == opcode; // @[CPU6502Core.scala 215:20]
  wire [7:0] _execResult_result_res_T_26 = regs_a & io_memDataIn; // @[Logic.scala 32:34]
  wire [7:0] _execResult_result_res_T_27 = regs_a | io_memDataIn; // @[Logic.scala 33:34]
  wire [7:0] _execResult_result_res_T_28 = regs_a ^ io_memDataIn; // @[Logic.scala 34:34]
  wire [7:0] _GEN_789 = _execResult_T_75 ? _execResult_result_res_T_28 : 8'h0; // @[Logic.scala 31:20 34:24 29:9]
  wire [7:0] _GEN_790 = _execResult_T_74 ? _execResult_result_res_T_27 : _GEN_789; // @[Logic.scala 31:20 33:24]
  wire [7:0] execResult_result_res_15 = _execResult_T_73 ? _execResult_result_res_T_26 : _GEN_790; // @[Logic.scala 31:20 32:24]
  wire  execResult_result_newRegs_15_flagN = execResult_result_res_15[7]; // @[Logic.scala 38:25]
  wire  execResult_result_newRegs_15_flagZ = execResult_result_res_15 == 8'h0; // @[Logic.scala 39:26]
  wire  _GEN_794 = _execResult_result_T_21 ? _execResult_result_res_T_26 == 8'h0 : regs_flagZ; // @[Logic.scala 57:13 68:19 80:23]
  wire  _GEN_795 = _execResult_result_T_21 ? io_memDataIn[7] : regs_flagN; // @[Logic.scala 57:13 68:19 81:23]
  wire  _GEN_796 = _execResult_result_T_21 ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 57:13 68:19 82:23]
  wire  execResult_result_newRegs_16_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_794; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_16_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_796; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_16_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_795; // @[Logic.scala 57:13 68:19]
  wire [2:0] execResult_result_result_17_nextCycle = _execResult_result_T_20 ? 3'h1 :
    execResult_result_result_6_nextCycle; // @[Logic.scala 68:19 60:22 75:26]
  wire  _execResult_result_res_T_36 = opcode == 8'h3d; // @[Logic.scala 95:15]
  wire  _execResult_result_res_T_37 = opcode == 8'h29 | opcode == 8'h25 | opcode == 8'h35 | opcode == 8'h2d |
    _execResult_result_res_T_36; // @[Logic.scala 94:89]
  wire  _execResult_result_res_T_38 = opcode == 8'h39; // @[Logic.scala 95:36]
  wire  _execResult_result_res_T_43 = _execResult_result_res_T_37 | opcode == 8'h39 | opcode == 8'h21 | opcode == 8'h31; // @[Logic.scala 95:68]
  wire  _execResult_result_res_T_52 = opcode == 8'h1d; // @[Logic.scala 97:15]
  wire  _execResult_result_res_T_53 = opcode == 8'h9 | opcode == 8'h5 | opcode == 8'h15 | opcode == 8'hd |
    _execResult_result_res_T_52; // @[Logic.scala 96:89]
  wire  _execResult_result_res_T_54 = opcode == 8'h19; // @[Logic.scala 97:36]
  wire  _execResult_result_res_T_59 = _execResult_result_res_T_53 | opcode == 8'h19 | opcode == 8'h1 | opcode == 8'h11; // @[Logic.scala 97:68]
  wire  _execResult_result_res_T_68 = opcode == 8'h5d; // @[Logic.scala 99:15]
  wire  _execResult_result_res_T_69 = opcode == 8'h49 | opcode == 8'h45 | opcode == 8'h55 | opcode == 8'h4d |
    _execResult_result_res_T_68; // @[Logic.scala 98:89]
  wire  _execResult_result_res_T_70 = opcode == 8'h59; // @[Logic.scala 99:36]
  wire  _execResult_result_res_T_75 = _execResult_result_res_T_69 | opcode == 8'h59 | opcode == 8'h41 | opcode == 8'h51; // @[Logic.scala 99:68]
  wire [7:0] _execResult_result_res_T_77 = _execResult_result_res_T_75 ? _execResult_result_res_T_28 : regs_a; // @[Mux.scala 101:16]
  wire [7:0] _execResult_result_res_T_78 = _execResult_result_res_T_59 ? _execResult_result_res_T_27 :
    _execResult_result_res_T_77; // @[Mux.scala 101:16]
  wire [7:0] execResult_result_res_16 = _execResult_result_res_T_43 ? _execResult_result_res_T_26 :
    _execResult_result_res_T_78; // @[Mux.scala 101:16]
  wire  _execResult_result_newRegs_flagZ_T_31 = execResult_result_res_16 == 8'h0; // @[Logic.scala 132:30]
  wire [7:0] _GEN_832 = _execResult_result_T_21 ? execResult_result_res_16 : regs_a; // @[Logic.scala 107:13 118:19 130:19]
  wire  _GEN_833 = _execResult_result_T_21 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 107:13 118:19 131:23]
  wire  _GEN_834 = _execResult_result_T_21 ? execResult_result_res_16 == 8'h0 : regs_flagZ; // @[Logic.scala 107:13 118:19 132:23]
  wire [7:0] execResult_result_newRegs_17_a = _execResult_result_T_20 ? regs_a : _GEN_832; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_17_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_834; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_17_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_833; // @[Logic.scala 107:13 118:19]
  wire [7:0] _GEN_906 = _execResult_result_T_26 ? execResult_result_res_16 : regs_a; // @[Logic.scala 183:13 194:19 213:19]
  wire  _GEN_907 = _execResult_result_T_26 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 183:13 194:19 214:23]
  wire  _GEN_908 = _execResult_result_T_26 ? _execResult_result_newRegs_flagZ_T_31 : regs_flagZ; // @[Logic.scala 183:13 194:19 215:23]
  wire [7:0] _GEN_937 = _execResult_result_T_21 ? regs_a : _GEN_906; // @[Logic.scala 183:13 194:19]
  wire [7:0] execResult_result_newRegs_19_a = _execResult_result_T_20 ? regs_a : _GEN_937; // @[Logic.scala 183:13 194:19]
  wire  _GEN_939 = _execResult_result_T_21 ? regs_flagZ : _GEN_908; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_939; // @[Logic.scala 183:13 194:19]
  wire  _GEN_938 = _execResult_result_T_21 ? regs_flagN : _GEN_907; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_938; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_useY_1 = _execResult_result_res_T_38 | _execResult_result_res_T_54 |
    _execResult_result_res_T_70; // @[Logic.scala 240:59]
  wire [7:0] execResult_result_index_1 = execResult_result_useY_1 ? regs_y : regs_x; // @[Logic.scala 241:20]
  wire [15:0] _GEN_4191 = {{8'd0}, execResult_result_index_1}; // @[Logic.scala 254:57]
  wire [15:0] _execResult_result_result_operand_T_37 = resetVector + _GEN_4191; // @[Logic.scala 254:57]
  wire [15:0] _GEN_980 = _execResult_result_T_21 ? _execResult_result_result_operand_T_37 : operand; // @[Logic.scala 243:19 237:20 254:24]
  wire [15:0] execResult_result_result_21_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_980; // @[Logic.scala 243:19 247:24]
  wire [7:0] _GEN_1020 = _execResult_result_T_30 ? execResult_result_res_16 : regs_a; // @[Logic.scala 277:13 288:19 314:19]
  wire  _GEN_1021 = _execResult_result_T_30 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 277:13 288:19 315:23]
  wire  _GEN_1022 = _execResult_result_T_30 ? _execResult_result_newRegs_flagZ_T_31 : regs_flagZ; // @[Logic.scala 277:13 288:19 316:23]
  wire [7:0] _GEN_1038 = _execResult_result_T_26 ? regs_a : _GEN_1020; // @[Logic.scala 277:13 288:19]
  wire [7:0] _GEN_1057 = _execResult_result_T_21 ? regs_a : _GEN_1038; // @[Logic.scala 277:13 288:19]
  wire [7:0] execResult_result_newRegs_21_a = _execResult_result_T_20 ? regs_a : _GEN_1057; // @[Logic.scala 277:13 288:19]
  wire  _GEN_1040 = _execResult_result_T_26 ? regs_flagZ : _GEN_1022; // @[Logic.scala 277:13 288:19]
  wire  _GEN_1059 = _execResult_result_T_21 ? regs_flagZ : _GEN_1040; // @[Logic.scala 277:13 288:19]
  wire  execResult_result_newRegs_21_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1059; // @[Logic.scala 277:13 288:19]
  wire  _GEN_1039 = _execResult_result_T_26 ? regs_flagN : _GEN_1021; // @[Logic.scala 277:13 288:19]
  wire  _GEN_1058 = _execResult_result_T_21 ? regs_flagN : _GEN_1039; // @[Logic.scala 277:13 288:19]
  wire  execResult_result_newRegs_21_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1058; // @[Logic.scala 277:13 288:19]
  wire  _execResult_T_117 = 8'ha == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_118 = 8'h4a == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_119 = 8'h2a == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_120 = 8'h6a == opcode; // @[CPU6502Core.scala 215:20]
  wire [8:0] _execResult_result_res_T_329 = {regs_a, 1'h0}; // @[Shift.scala 39:24]
  wire [7:0] _execResult_result_res_T_333 = {regs_a[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_335 = {regs_flagC,regs_a[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_1168 = _execResult_T_120 ? regs_a[0] : regs_flagC; // @[Shift.scala 22:13 36:20 50:23]
  wire [7:0] _GEN_1169 = _execResult_T_120 ? _execResult_result_res_T_335 : regs_a; // @[Shift.scala 36:20 51:13 33:9]
  wire  _GEN_1170 = _execResult_T_119 ? regs_a[7] : _GEN_1168; // @[Shift.scala 36:20 46:23]
  wire [7:0] _GEN_1171 = _execResult_T_119 ? _execResult_result_res_T_333 : _GEN_1169; // @[Shift.scala 36:20 47:13]
  wire  _GEN_1172 = _execResult_T_118 ? regs_a[0] : _GEN_1170; // @[Shift.scala 36:20 42:23]
  wire [7:0] _GEN_1173 = _execResult_T_118 ? {{1'd0}, regs_a[7:1]} : _GEN_1171; // @[Shift.scala 36:20 43:13]
  wire  execResult_result_newRegs_23_flagC = _execResult_T_117 ? regs_a[7] : _GEN_1172; // @[Shift.scala 36:20 38:23]
  wire [7:0] execResult_result_res_22 = _execResult_T_117 ? _execResult_result_res_T_329[7:0] : _GEN_1173; // @[Shift.scala 36:20 39:13]
  wire  execResult_result_newRegs_23_flagN = execResult_result_res_22[7]; // @[Shift.scala 56:25]
  wire  execResult_result_newRegs_23_flagZ = execResult_result_res_22 == 8'h0; // @[Shift.scala 57:26]
  wire  _execResult_T_124 = 8'h6 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_125 = 8'h46 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_126 = 8'h26 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_127 = 8'h66 == opcode; // @[CPU6502Core.scala 215:20]
  wire [8:0] _execResult_result_res_T_336 = {io_memDataIn, 1'h0}; // @[Shift.scala 99:31]
  wire [7:0] _execResult_result_res_T_340 = {io_memDataIn[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_342 = {regs_flagC,io_memDataIn[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_1176 = _execResult_T_127 ? io_memDataIn[0] : regs_flagC; // @[Shift.scala 96:24 112:27 66:13]
  wire [7:0] _GEN_1177 = _execResult_T_127 ? _execResult_result_res_T_342 : 8'h0; // @[Shift.scala 113:17 94:13 96:24]
  wire  _GEN_1178 = _execResult_T_126 ? io_memDataIn[7] : _GEN_1176; // @[Shift.scala 96:24 107:27]
  wire [7:0] _GEN_1179 = _execResult_T_126 ? _execResult_result_res_T_340 : _GEN_1177; // @[Shift.scala 108:17 96:24]
  wire  _GEN_1180 = _execResult_T_125 ? io_memDataIn[0] : _GEN_1178; // @[Shift.scala 96:24 102:27]
  wire [7:0] _GEN_1181 = _execResult_T_125 ? {{1'd0}, io_memDataIn[7:1]} : _GEN_1179; // @[Shift.scala 103:17 96:24]
  wire  _GEN_1182 = _execResult_T_124 ? io_memDataIn[7] : _GEN_1180; // @[Shift.scala 96:24 98:27]
  wire [7:0] execResult_result_res_23 = _execResult_T_124 ? _execResult_result_res_T_336[7:0] : _GEN_1181; // @[Shift.scala 96:24 99:17]
  wire  _GEN_1185 = _execResult_result_T_26 ? _GEN_1182 : regs_flagC; // @[Shift.scala 66:13 77:19]
  wire [7:0] _GEN_1186 = _execResult_result_T_26 ? execResult_result_res_23 : 8'h0; // @[Shift.scala 77:19 117:24 72:20]
  wire  _GEN_1188 = _execResult_result_T_26 ? execResult_result_res_23[7] : regs_flagN; // @[Shift.scala 77:19 119:23 66:13]
  wire  _GEN_1189 = _execResult_result_T_26 ? execResult_result_res_23 == 8'h0 : regs_flagZ; // @[Shift.scala 77:19 120:23 66:13]
  wire  _GEN_1205 = _execResult_result_T_21 ? regs_flagC : _GEN_1185; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1205; // @[Shift.scala 66:13 77:19]
  wire  _GEN_1209 = _execResult_result_T_21 ? regs_flagZ : _GEN_1189; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1209; // @[Shift.scala 66:13 77:19]
  wire  _GEN_1208 = _execResult_result_T_21 ? regs_flagN : _GEN_1188; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1208; // @[Shift.scala 66:13 77:19]
  wire [7:0] _GEN_1206 = _execResult_result_T_21 ? 8'h0 : _GEN_1186; // @[Shift.scala 77:19 72:20]
  wire [7:0] execResult_result_result_25_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1206; // @[Shift.scala 77:19 72:20]
  wire  _execResult_T_131 = 8'h16 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_132 = 8'h56 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_133 = 8'h36 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_134 = 8'h76 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_result_T_92 = 8'he == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_93 = 8'h1e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_99 = 8'h4e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_100 = 8'h5e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_106 = 8'h2e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_107 = 8'h3e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_113 = 8'h6e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_114 = 8'h7e == opcode; // @[Shift.scala 138:20]
  wire  _GEN_1244 = (_execResult_T_127 | _execResult_T_134 | 8'h6e == opcode | 8'h7e == opcode) & io_memDataIn[0]; // @[Shift.scala 136:14 138:20 152:18]
  wire [7:0] _GEN_1245 = _execResult_T_127 | _execResult_T_134 | 8'h6e == opcode | 8'h7e == opcode ?
    _execResult_result_res_T_342 : io_memDataIn; // @[Shift.scala 135:12 138:20 153:16]
  wire  _GEN_1246 = _execResult_T_126 | _execResult_T_133 | 8'h2e == opcode | 8'h3e == opcode ? io_memDataIn[7] :
    _GEN_1244; // @[Shift.scala 138:20 148:18]
  wire [7:0] _GEN_1247 = _execResult_T_126 | _execResult_T_133 | 8'h2e == opcode | 8'h3e == opcode ?
    _execResult_result_res_T_340 : _GEN_1245; // @[Shift.scala 138:20 149:16]
  wire  _GEN_1248 = _execResult_T_125 | _execResult_T_132 | 8'h4e == opcode | 8'h5e == opcode ? io_memDataIn[0] :
    _GEN_1246; // @[Shift.scala 138:20 144:18]
  wire [7:0] _GEN_1249 = _execResult_T_125 | _execResult_T_132 | 8'h4e == opcode | 8'h5e == opcode ? {{1'd0},
    io_memDataIn[7:1]} : _GEN_1247; // @[Shift.scala 138:20 145:16]
  wire  execResult_result_newCarry = _execResult_T_124 | _execResult_T_131 | 8'he == opcode | 8'h1e == opcode ?
    io_memDataIn[7] : _GEN_1248; // @[Shift.scala 138:20 140:18]
  wire [7:0] execResult_result_res_24 = _execResult_T_124 | _execResult_T_131 | 8'he == opcode | 8'h1e == opcode ?
    _execResult_result_res_T_336[7:0] : _GEN_1249; // @[Shift.scala 138:20 141:16]
  wire  _execResult_result_newRegs_flagZ_T_39 = execResult_result_res_24 == 8'h0; // @[Shift.scala 194:30]
  wire [7:0] _GEN_1253 = _execResult_result_T_26 ? execResult_result_res_24 : 8'h0; // @[Shift.scala 175:19 170:20 190:24]
  wire  _GEN_1255 = _execResult_result_T_26 ? execResult_result_newCarry : regs_flagC; // @[Shift.scala 164:13 175:19 192:23]
  wire  _GEN_1256 = _execResult_result_T_26 ? execResult_result_res_24[7] : regs_flagN; // @[Shift.scala 164:13 175:19 193:23]
  wire  _GEN_1257 = _execResult_result_T_26 ? execResult_result_res_24 == 8'h0 : regs_flagZ; // @[Shift.scala 164:13 175:19 194:23]
  wire  _GEN_1274 = _execResult_result_T_21 ? regs_flagC : _GEN_1255; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1274; // @[Shift.scala 164:13 175:19]
  wire  _GEN_1276 = _execResult_result_T_21 ? regs_flagZ : _GEN_1257; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1276; // @[Shift.scala 164:13 175:19]
  wire  _GEN_1275 = _execResult_result_T_21 ? regs_flagN : _GEN_1256; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1275; // @[Shift.scala 164:13 175:19]
  wire [7:0] _GEN_1272 = _execResult_result_T_21 ? 8'h0 : _GEN_1253; // @[Shift.scala 175:19 170:20]
  wire [7:0] execResult_result_result_26_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1272; // @[Shift.scala 175:19 170:20]
  wire [7:0] _GEN_1319 = _execResult_result_T_30 ? execResult_result_res_24 : 8'h0; // @[Shift.scala 218:19 213:20 240:24]
  wire  _GEN_1321 = _execResult_result_T_30 ? execResult_result_newCarry : regs_flagC; // @[Shift.scala 207:13 218:19 242:23]
  wire  _GEN_1322 = _execResult_result_T_30 ? execResult_result_res_24[7] : regs_flagN; // @[Shift.scala 207:13 218:19 243:23]
  wire  _GEN_1323 = _execResult_result_T_30 ? _execResult_result_newRegs_flagZ_T_39 : regs_flagZ; // @[Shift.scala 207:13 218:19 244:23]
  wire  _GEN_1340 = _execResult_result_T_26 ? regs_flagC : _GEN_1321; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1373 = _execResult_result_T_21 ? regs_flagC : _GEN_1340; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1373; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1342 = _execResult_result_T_26 ? regs_flagZ : _GEN_1323; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1375 = _execResult_result_T_21 ? regs_flagZ : _GEN_1342; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1375; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1341 = _execResult_result_T_26 ? regs_flagN : _GEN_1322; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1374 = _execResult_result_T_21 ? regs_flagN : _GEN_1341; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1374; // @[Shift.scala 207:13 218:19]
  wire [7:0] _GEN_1338 = _execResult_result_T_26 ? 8'h0 : _GEN_1319; // @[Shift.scala 218:19 213:20]
  wire [7:0] _GEN_1371 = _execResult_result_T_21 ? 8'h0 : _GEN_1338; // @[Shift.scala 218:19 213:20]
  wire [7:0] execResult_result_result_27_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1371; // @[Shift.scala 218:19 213:20]
  wire  _execResult_T_152 = 8'hc9 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_153 = 8'he0 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_154 = 8'hc0 == opcode; // @[CPU6502Core.scala 215:20]
  wire [7:0] _GEN_1484 = _execResult_T_154 ? regs_y : regs_a; // @[Compare.scala 30:14 32:20 35:29]
  wire [7:0] _GEN_1485 = _execResult_T_153 ? regs_x : _GEN_1484; // @[Compare.scala 32:20 34:29]
  wire [7:0] execResult_result_regValue = _execResult_T_152 ? regs_a : _GEN_1485; // @[Compare.scala 32:20 33:29]
  wire [8:0] execResult_result_diff_7 = execResult_result_regValue - io_memDataIn; // @[Compare.scala 38:25]
  wire  execResult_result_newRegs_28_flagC = execResult_result_regValue >= io_memDataIn; // @[Compare.scala 39:31]
  wire  execResult_result_newRegs_28_flagZ = execResult_result_regValue == io_memDataIn; // @[Compare.scala 40:31]
  wire  execResult_result_newRegs_28_flagN = execResult_result_diff_7[7]; // @[Compare.scala 41:26]
  wire  _execResult_result_regValue_T_4 = opcode == 8'he0 | opcode == 8'he4 | opcode == 8'hec; // @[Compare.scala 97:47]
  wire  _execResult_result_regValue_T_9 = opcode == 8'hc0 | opcode == 8'hc4 | opcode == 8'hcc; // @[Compare.scala 98:47]
  wire [7:0] _execResult_result_regValue_T_10 = _execResult_result_regValue_T_9 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] execResult_result_regValue_1 = _execResult_result_regValue_T_4 ? regs_x : _execResult_result_regValue_T_10; // @[Mux.scala 101:16]
  wire [8:0] execResult_result_diff_8 = execResult_result_regValue_1 - io_memDataIn; // @[Compare.scala 100:25]
  wire  execResult_result_flagC_5 = execResult_result_regValue_1 >= io_memDataIn; // @[Compare.scala 101:26]
  wire  execResult_result_flagZ = execResult_result_regValue_1 == io_memDataIn; // @[Compare.scala 102:26]
  wire  execResult_result_flagN_5 = execResult_result_diff_8[7]; // @[Compare.scala 103:21]
  wire  _GEN_1489 = _execResult_result_T_21 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 111:13 122:19 134:23]
  wire  _GEN_1490 = _execResult_result_T_21 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 111:13 122:19 135:23]
  wire  _GEN_1491 = _execResult_result_T_21 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 111:13 122:19 136:23]
  wire  execResult_result_newRegs_29_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1489; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_29_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1490; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_29_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1491; // @[Compare.scala 111:13 122:19]
  wire  _GEN_1563 = _execResult_result_T_26 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 187:13 198:19 217:23]
  wire  _GEN_1564 = _execResult_result_T_26 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 187:13 198:19 218:23]
  wire  _GEN_1565 = _execResult_result_T_26 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 187:13 198:19 219:23]
  wire  _GEN_1594 = _execResult_result_T_21 ? regs_flagC : _GEN_1563; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1594; // @[Compare.scala 187:13 198:19]
  wire  _GEN_1595 = _execResult_result_T_21 ? regs_flagZ : _GEN_1564; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1595; // @[Compare.scala 187:13 198:19]
  wire  _GEN_1596 = _execResult_result_T_21 ? regs_flagN : _GEN_1565; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1596; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_useY_2 = opcode == 8'hd9; // @[Compare.scala 243:23]
  wire [7:0] execResult_result_index_2 = execResult_result_useY_2 ? regs_y : regs_x; // @[Compare.scala 244:20]
  wire [15:0] _GEN_4194 = {{8'd0}, execResult_result_index_2}; // @[Compare.scala 257:57]
  wire [15:0] _execResult_result_result_operand_T_68 = resetVector + _GEN_4194; // @[Compare.scala 257:57]
  wire [15:0] _GEN_1637 = _execResult_result_T_21 ? _execResult_result_result_operand_T_68 : operand; // @[Compare.scala 246:19 241:20 257:24]
  wire [15:0] execResult_result_result_33_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_1637; // @[Compare.scala 246:19 250:24]
  wire  _GEN_1677 = _execResult_result_T_30 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 280:13 291:19 313:23]
  wire  _GEN_1678 = _execResult_result_T_30 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 280:13 291:19 314:23]
  wire  _GEN_1679 = _execResult_result_T_30 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 280:13 291:19 315:23]
  wire  _GEN_1695 = _execResult_result_T_26 ? regs_flagC : _GEN_1677; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1714 = _execResult_result_T_21 ? regs_flagC : _GEN_1695; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1714; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1696 = _execResult_result_T_26 ? regs_flagZ : _GEN_1678; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1715 = _execResult_result_T_21 ? regs_flagZ : _GEN_1696; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1715; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1697 = _execResult_result_T_26 ? regs_flagN : _GEN_1679; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1716 = _execResult_result_T_21 ? regs_flagN : _GEN_1697; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1716; // @[Compare.scala 280:13 291:19]
  wire [15:0] execResult_result_result_36_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_312; // @[Compare.scala 387:19 391:24]
  wire  _execResult_T_174 = 8'hf0 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_175 = 8'hd0 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_176 = 8'hb0 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_177 = 8'h90 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_178 = 8'h30 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_179 = 8'h10 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_180 = 8'h50 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_181 = 8'h70 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _GEN_1900 = _execResult_T_180 & ~regs_flagV; // @[Branch.scala 18:16 20:20 28:31]
  wire  _GEN_1901 = _execResult_T_181 ? regs_flagV : _GEN_1900; // @[Branch.scala 20:20 27:31]
  wire  _GEN_1902 = _execResult_T_179 ? ~regs_flagN : _GEN_1901; // @[Branch.scala 20:20 26:31]
  wire  _GEN_1903 = _execResult_T_178 ? regs_flagN : _GEN_1902; // @[Branch.scala 20:20 25:31]
  wire  _GEN_1904 = _execResult_T_177 ? _execResult_result_diff_T_2 : _GEN_1903; // @[Branch.scala 20:20 24:31]
  wire  _GEN_1905 = _execResult_T_176 ? regs_flagC : _GEN_1904; // @[Branch.scala 20:20 23:31]
  wire  _GEN_1906 = _execResult_T_175 ? ~regs_flagZ : _GEN_1905; // @[Branch.scala 20:20 22:31]
  wire  execResult_result_takeBranch = _execResult_T_174 ? regs_flagZ : _GEN_1906; // @[Branch.scala 20:20 21:31]
  wire [7:0] execResult_result_offset = io_memDataIn; // @[Branch.scala 32:28]
  wire [15:0] _GEN_4196 = {{8{execResult_result_offset[7]}},execResult_result_offset}; // @[Branch.scala 34:51]
  wire [15:0] _execResult_result_newRegs_pc_T_88 = $signed(regs_pc) + $signed(_GEN_4196); // @[Branch.scala 34:61]
  wire [15:0] execResult_result_newRegs_36_pc = execResult_result_takeBranch ? _execResult_result_newRegs_pc_T_88 :
    regs_pc; // @[Branch.scala 34:22]
  wire  _execResult_T_189 = 8'ha9 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_190 = 8'ha2 == opcode; // @[CPU6502Core.scala 215:20]
  wire  _execResult_T_191 = 8'ha0 == opcode; // @[CPU6502Core.scala 215:20]
  wire [7:0] _GEN_1908 = _execResult_T_191 ? io_memDataIn : regs_y; // @[LoadStore.scala 27:13 29:20 32:30]
  wire [7:0] _GEN_1909 = _execResult_T_190 ? io_memDataIn : regs_x; // @[LoadStore.scala 27:13 29:20 31:30]
  wire [7:0] _GEN_1910 = _execResult_T_190 ? regs_y : _GEN_1908; // @[LoadStore.scala 27:13 29:20]
  wire [7:0] execResult_result_newRegs_37_a = _execResult_T_189 ? io_memDataIn : regs_a; // @[LoadStore.scala 27:13 29:20 30:30]
  wire [7:0] execResult_result_newRegs_37_x = _execResult_T_189 ? regs_x : _GEN_1909; // @[LoadStore.scala 27:13 29:20]
  wire [7:0] execResult_result_newRegs_37_y = _execResult_T_189 ? regs_y : _GEN_1910; // @[LoadStore.scala 27:13 29:20]
  wire  execResult_result_newRegs_37_flagZ = io_memDataIn == 8'h0; // @[LoadStore.scala 36:32]
  wire  execResult_result_isLoadA = opcode == 8'ha5; // @[LoadStore.scala 65:26]
  wire  execResult_result_isLoadX = opcode == 8'ha6; // @[LoadStore.scala 66:26]
  wire  execResult_result_isLoadY = opcode == 8'ha4; // @[LoadStore.scala 67:26]
  wire  execResult_result_isStoreA = opcode == 8'h85; // @[LoadStore.scala 68:27]
  wire  execResult_result_isStoreX = opcode == 8'h86; // @[LoadStore.scala 69:27]
  wire  _execResult_result_T_221 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY; // @[LoadStore.scala 83:33]
  wire [7:0] _GEN_1914 = execResult_result_isLoadX ? io_memDataIn : regs_x; // @[LoadStore.scala 54:13 87:31 88:23]
  wire [7:0] _GEN_1915 = execResult_result_isLoadX ? regs_y : io_memDataIn; // @[LoadStore.scala 54:13 87:31 90:23]
  wire [7:0] _GEN_1916 = execResult_result_isLoadA ? io_memDataIn : regs_a; // @[LoadStore.scala 54:13 85:25 86:23]
  wire [7:0] _GEN_1917 = execResult_result_isLoadA ? regs_x : _GEN_1914; // @[LoadStore.scala 54:13 85:25]
  wire [7:0] _GEN_1918 = execResult_result_isLoadA ? regs_y : _GEN_1915; // @[LoadStore.scala 54:13 85:25]
  wire [7:0] _execResult_result_result_memData_T = execResult_result_isStoreX ? regs_x : regs_y; // @[LoadStore.scala 96:54]
  wire [7:0] _execResult_result_result_memData_T_1 = execResult_result_isStoreA ? regs_a :
    _execResult_result_result_memData_T; // @[LoadStore.scala 96:32]
  wire [7:0] _GEN_1920 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1916
     : regs_a; // @[LoadStore.scala 54:13 83:45]
  wire [7:0] _GEN_1921 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1917
     : regs_x; // @[LoadStore.scala 54:13 83:45]
  wire [7:0] _GEN_1922 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1918
     : regs_y; // @[LoadStore.scala 54:13 83:45]
  wire  _GEN_1923 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? io_memDataIn[7]
     : regs_flagN; // @[LoadStore.scala 54:13 83:45 92:25]
  wire  _GEN_1924 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ?
    execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 54:13 83:45 93:25]
  wire  _GEN_1925 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 1'h0 : 1'h1; // @[LoadStore.scala 61:21 83:45 95:27]
  wire [7:0] _GEN_1926 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 8'h0 :
    _execResult_result_result_memData_T_1; // @[LoadStore.scala 60:20 83:45 96:26]
  wire  _GEN_1928 = _execResult_result_T_21 & _execResult_result_T_221; // @[LoadStore.scala 72:19 62:20]
  wire [7:0] _GEN_1929 = _execResult_result_T_21 ? _GEN_1920 : regs_a; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1930 = _execResult_result_T_21 ? _GEN_1921 : regs_x; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1931 = _execResult_result_T_21 ? _GEN_1922 : regs_y; // @[LoadStore.scala 54:13 72:19]
  wire  _GEN_1932 = _execResult_result_T_21 ? _GEN_1923 : regs_flagN; // @[LoadStore.scala 54:13 72:19]
  wire  _GEN_1933 = _execResult_result_T_21 ? _GEN_1924 : regs_flagZ; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1935 = _execResult_result_T_21 ? _GEN_1926 : 8'h0; // @[LoadStore.scala 72:19 60:20]
  wire [7:0] execResult_result_newRegs_38_a = _execResult_result_T_20 ? regs_a : _GEN_1929; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] execResult_result_newRegs_38_x = _execResult_result_T_20 ? regs_x : _GEN_1930; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] execResult_result_newRegs_38_y = _execResult_result_T_20 ? regs_y : _GEN_1931; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_newRegs_38_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1933; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_newRegs_38_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1932; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_result_39_memRead = _execResult_result_T_20 | _GEN_1928; // @[LoadStore.scala 72:19 75:24]
  wire  execResult_result_result_39_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1925; // @[LoadStore.scala 72:19 61:21]
  wire [7:0] execResult_result_result_39_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1935; // @[LoadStore.scala 72:19 60:20]
  wire  execResult_result_isLoadA_1 = opcode == 8'hb5; // @[LoadStore.scala 121:26]
  wire  execResult_result_isLoadY_1 = opcode == 8'hb4; // @[LoadStore.scala 122:26]
  wire  _execResult_result_T_224 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1; // @[LoadStore.scala 136:22]
  wire [7:0] _GEN_1974 = execResult_result_isLoadA_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 110:13 138:25 139:23]
  wire [7:0] _GEN_1975 = execResult_result_isLoadA_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 110:13 138:25 141:23]
  wire [7:0] _execResult_result_result_memData_T_3 = opcode == 8'h95 ? regs_a : regs_y; // @[LoadStore.scala 147:32]
  wire [7:0] _GEN_1977 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_1974 : regs_a; // @[LoadStore.scala 110:13 136:34]
  wire [7:0] _GEN_1978 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_1975 : regs_y; // @[LoadStore.scala 110:13 136:34]
  wire  _GEN_1979 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 110:13 136:34 143:25]
  wire  _GEN_1980 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? execResult_result_newRegs_37_flagZ :
    regs_flagZ; // @[LoadStore.scala 110:13 136:34 144:25]
  wire  _GEN_1981 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 117:21 136:34 146:27]
  wire [7:0] _GEN_1982 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 8'h0 :
    _execResult_result_result_memData_T_3; // @[LoadStore.scala 116:20 136:34 147:26]
  wire  _GEN_1984 = _execResult_result_T_21 & _execResult_result_T_224; // @[LoadStore.scala 125:19 118:20]
  wire [7:0] _GEN_1985 = _execResult_result_T_21 ? _GEN_1977 : regs_a; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] _GEN_1986 = _execResult_result_T_21 ? _GEN_1978 : regs_y; // @[LoadStore.scala 110:13 125:19]
  wire  _GEN_1987 = _execResult_result_T_21 ? _GEN_1979 : regs_flagN; // @[LoadStore.scala 110:13 125:19]
  wire  _GEN_1988 = _execResult_result_T_21 ? _GEN_1980 : regs_flagZ; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] _GEN_1990 = _execResult_result_T_21 ? _GEN_1982 : 8'h0; // @[LoadStore.scala 125:19 116:20]
  wire [7:0] execResult_result_newRegs_39_a = _execResult_result_T_20 ? regs_a : _GEN_1985; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] execResult_result_newRegs_39_y = _execResult_result_T_20 ? regs_y : _GEN_1986; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_newRegs_39_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1988; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_newRegs_39_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1987; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_result_40_memRead = _execResult_result_T_20 | _GEN_1984; // @[LoadStore.scala 125:19 128:24]
  wire  execResult_result_result_40_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1981; // @[LoadStore.scala 125:19 117:21]
  wire [7:0] execResult_result_result_40_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1990; // @[LoadStore.scala 125:19 116:20]
  wire  execResult_result_isLoad = opcode == 8'hb6; // @[LoadStore.scala 172:25]
  wire [7:0] _execResult_result_result_operand_T_90 = io_memDataIn + regs_y; // @[LoadStore.scala 178:38]
  wire [7:0] _GEN_2029 = execResult_result_isLoad ? io_memDataIn : regs_x; // @[LoadStore.scala 161:13 184:22 186:21]
  wire  _GEN_2030 = execResult_result_isLoad ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 161:13 184:22 187:25]
  wire  _GEN_2031 = execResult_result_isLoad ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 161:13 184:22 188:25]
  wire  _GEN_2032 = execResult_result_isLoad ? 1'h0 : 1'h1; // @[LoadStore.scala 168:21 184:22 190:27]
  wire [7:0] _GEN_2033 = execResult_result_isLoad ? 8'h0 : regs_x; // @[LoadStore.scala 167:20 184:22 191:26]
  wire  _GEN_2035 = _execResult_result_T_21 & execResult_result_isLoad; // @[LoadStore.scala 174:19 169:20]
  wire [7:0] _GEN_2036 = _execResult_result_T_21 ? _GEN_2029 : regs_x; // @[LoadStore.scala 161:13 174:19]
  wire  _GEN_2037 = _execResult_result_T_21 ? _GEN_2030 : regs_flagN; // @[LoadStore.scala 161:13 174:19]
  wire  _GEN_2038 = _execResult_result_T_21 ? _GEN_2031 : regs_flagZ; // @[LoadStore.scala 161:13 174:19]
  wire [7:0] _GEN_2040 = _execResult_result_T_21 ? _GEN_2033 : 8'h0; // @[LoadStore.scala 174:19 167:20]
  wire [7:0] execResult_result_newRegs_40_x = _execResult_result_T_20 ? regs_x : _GEN_2036; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_newRegs_40_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2038; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_newRegs_40_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2037; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_result_41_memRead = _execResult_result_T_20 | _GEN_2035; // @[LoadStore.scala 174:19 177:24]
  wire [15:0] execResult_result_result_41_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_90} : operand; // @[LoadStore.scala 174:19 170:20 178:24]
  wire  execResult_result_result_41_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_2032; // @[LoadStore.scala 174:19 168:21]
  wire [7:0] execResult_result_result_41_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2040; // @[LoadStore.scala 174:19 167:20]
  wire  execResult_result_isLoadA_2 = opcode == 8'had; // @[LoadStore.scala 216:26]
  wire  execResult_result_isLoadX_1 = opcode == 8'hae; // @[LoadStore.scala 217:26]
  wire  execResult_result_isLoadY_2 = opcode == 8'hac; // @[LoadStore.scala 218:26]
  wire  _execResult_result_T_231 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 |
    execResult_result_isLoadY_2; // @[LoadStore.scala 239:33]
  wire [7:0] _GEN_2076 = execResult_result_isLoadX_1 ? io_memDataIn : regs_x; // @[LoadStore.scala 205:13 243:31 244:23]
  wire [7:0] _GEN_2077 = execResult_result_isLoadX_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 205:13 243:31 246:23]
  wire [7:0] _GEN_2078 = execResult_result_isLoadA_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 205:13 241:25 242:23]
  wire [7:0] _GEN_2079 = execResult_result_isLoadA_2 ? regs_x : _GEN_2076; // @[LoadStore.scala 205:13 241:25]
  wire [7:0] _GEN_2080 = execResult_result_isLoadA_2 ? regs_y : _GEN_2077; // @[LoadStore.scala 205:13 241:25]
  wire  _execResult_result_result_memData_T_4 = opcode == 8'h8e; // @[LoadStore.scala 254:21]
  wire  _execResult_result_result_memData_T_5 = opcode == 8'h8c; // @[LoadStore.scala 255:21]
  wire [7:0] _execResult_result_result_memData_T_6 = _execResult_result_result_memData_T_5 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] _execResult_result_result_memData_T_7 = _execResult_result_result_memData_T_4 ? regs_x :
    _execResult_result_result_memData_T_6; // @[Mux.scala 101:16]
  wire [7:0] _GEN_2082 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2078 : regs_a; // @[LoadStore.scala 205:13 239:45]
  wire [7:0] _GEN_2083 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2079 : regs_x; // @[LoadStore.scala 205:13 239:45]
  wire [7:0] _GEN_2084 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2080 : regs_y; // @[LoadStore.scala 205:13 239:45]
  wire  _GEN_2085 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 205:13 239:45 248:25]
  wire  _GEN_2086 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 205:13 239:45 249:25]
  wire  _GEN_2087 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 1'h0 : 1'h1
    ; // @[LoadStore.scala 212:21 239:45 251:27]
  wire [7:0] _GEN_2088 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 8'h0
     : _execResult_result_result_memData_T_7; // @[LoadStore.scala 211:20 239:45 253:26]
  wire  _GEN_2090 = _execResult_result_T_26 & _execResult_result_T_231; // @[LoadStore.scala 220:19 213:20]
  wire [7:0] _GEN_2091 = _execResult_result_T_26 ? _GEN_2082 : regs_a; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2092 = _execResult_result_T_26 ? _GEN_2083 : regs_x; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2093 = _execResult_result_T_26 ? _GEN_2084 : regs_y; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2094 = _execResult_result_T_26 ? _GEN_2085 : regs_flagN; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2095 = _execResult_result_T_26 ? _GEN_2086 : regs_flagZ; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2097 = _execResult_result_T_26 ? _GEN_2088 : 8'h0; // @[LoadStore.scala 220:19 211:20]
  wire [7:0] _GEN_2128 = _execResult_result_T_21 ? regs_a : _GEN_2091; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_41_a = _execResult_result_T_20 ? regs_a : _GEN_2128; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2129 = _execResult_result_T_21 ? regs_x : _GEN_2092; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_41_x = _execResult_result_T_20 ? regs_x : _GEN_2129; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2130 = _execResult_result_T_21 ? regs_y : _GEN_2093; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_41_y = _execResult_result_T_20 ? regs_y : _GEN_2130; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2132 = _execResult_result_T_21 ? regs_flagZ : _GEN_2095; // @[LoadStore.scala 205:13 220:19]
  wire  execResult_result_newRegs_41_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2132; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2131 = _execResult_result_T_21 ? regs_flagN : _GEN_2094; // @[LoadStore.scala 205:13 220:19]
  wire  execResult_result_newRegs_41_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2131; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2112 = _execResult_result_T_21 | _GEN_2090; // @[LoadStore.scala 220:19 231:24]
  wire  _GEN_2133 = _execResult_result_T_21 ? 1'h0 : _execResult_result_T_26 & _GEN_2087; // @[LoadStore.scala 220:19 212:21]
  wire [7:0] _GEN_2134 = _execResult_result_T_21 ? 8'h0 : _GEN_2097; // @[LoadStore.scala 220:19 211:20]
  wire  execResult_result_result_42_memRead = _execResult_result_T_20 | _GEN_2112; // @[LoadStore.scala 220:19 223:24]
  wire  execResult_result_result_42_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2133; // @[LoadStore.scala 220:19 212:21]
  wire [7:0] execResult_result_result_42_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2134; // @[LoadStore.scala 220:19 211:20]
  wire  execResult_result_useY_3 = opcode == 8'hb9 | opcode == 8'hbe | opcode == 8'h99; // @[LoadStore.scala 282:59]
  wire [7:0] execResult_result_indexReg = execResult_result_useY_3 ? regs_y : regs_x; // @[LoadStore.scala 283:23]
  wire [15:0] _GEN_4197 = {{8'd0}, execResult_result_indexReg}; // @[LoadStore.scala 302:57]
  wire [15:0] _execResult_result_result_operand_T_97 = resetVector + _GEN_4197; // @[LoadStore.scala 302:57]
  wire [7:0] _GEN_2163 = _execResult_result_T_26 ? io_memDataIn : regs_a; // @[LoadStore.scala 270:13 290:19 310:19]
  wire  _GEN_2164 = _execResult_result_T_26 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 270:13 290:19 311:23]
  wire  _GEN_2165 = _execResult_result_T_26 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 270:13 290:19 312:23]
  wire [7:0] _GEN_2195 = _execResult_result_T_21 ? regs_a : _GEN_2163; // @[LoadStore.scala 270:13 290:19]
  wire [7:0] execResult_result_newRegs_42_a = _execResult_result_T_20 ? regs_a : _GEN_2195; // @[LoadStore.scala 270:13 290:19]
  wire  _GEN_2197 = _execResult_result_T_21 ? regs_flagZ : _GEN_2165; // @[LoadStore.scala 270:13 290:19]
  wire  execResult_result_newRegs_42_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2197; // @[LoadStore.scala 270:13 290:19]
  wire  _GEN_2196 = _execResult_result_T_21 ? regs_flagN : _GEN_2164; // @[LoadStore.scala 270:13 290:19]
  wire  execResult_result_newRegs_42_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2196; // @[LoadStore.scala 270:13 290:19]
  wire [15:0] _GEN_2180 = _execResult_result_T_21 ? _execResult_result_result_operand_T_97 : operand; // @[LoadStore.scala 290:19 279:20 302:24]
  wire [15:0] execResult_result_result_43_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_2180; // @[LoadStore.scala 290:19 294:24]
  wire  execResult_result_isLoad_1 = opcode == 8'ha1; // @[LoadStore.scala 336:25]
  wire  _GEN_2221 = execResult_result_isLoad_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 332:21 362:22 365:27]
  wire [7:0] _GEN_2222 = execResult_result_isLoad_1 ? 8'h0 : regs_a; // @[LoadStore.scala 331:20 362:22 366:26]
  wire  _execResult_result_T_239 = 3'h4 == cycle; // @[LoadStore.scala 338:19]
  wire [7:0] _GEN_2223 = execResult_result_isLoad_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 325:13 371:22 372:21]
  wire  _GEN_2224 = execResult_result_isLoad_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 325:13 371:22 373:25]
  wire  _GEN_2225 = execResult_result_isLoad_1 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 325:13 371:22 374:25]
  wire [7:0] _GEN_2238 = 3'h4 == cycle ? _GEN_2223 : regs_a; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_2258 = _execResult_result_T_30 ? regs_a : _GEN_2238; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_2279 = _execResult_result_T_26 ? regs_a : _GEN_2258; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_2300 = _execResult_result_T_21 ? regs_a : _GEN_2279; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] execResult_result_newRegs_43_a = _execResult_result_T_20 ? regs_a : _GEN_2300; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2240 = 3'h4 == cycle ? _GEN_2225 : regs_flagZ; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2260 = _execResult_result_T_30 ? regs_flagZ : _GEN_2240; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2281 = _execResult_result_T_26 ? regs_flagZ : _GEN_2260; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2302 = _execResult_result_T_21 ? regs_flagZ : _GEN_2281; // @[LoadStore.scala 325:13 338:19]
  wire  execResult_result_newRegs_43_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2302; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2239 = 3'h4 == cycle ? _GEN_2224 : regs_flagN; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2259 = _execResult_result_T_30 ? regs_flagN : _GEN_2239; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2280 = _execResult_result_T_26 ? regs_flagN : _GEN_2259; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2301 = _execResult_result_T_21 ? regs_flagN : _GEN_2280; // @[LoadStore.scala 325:13 338:19]
  wire  execResult_result_newRegs_43_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2301; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2255 = _execResult_result_T_30 & execResult_result_isLoad_1; // @[LoadStore.scala 338:19 333:20]
  wire [7:0] _GEN_2257 = _execResult_result_T_30 ? _GEN_2222 : 8'h0; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_2273 = _execResult_result_T_30 ? 1'h0 : 3'h4 == cycle; // @[LoadStore.scala 327:17 338:19]
  wire  _GEN_2275 = _execResult_result_T_26 | _GEN_2255; // @[LoadStore.scala 338:19 356:24]
  wire  _GEN_2277 = _execResult_result_T_26 ? 1'h0 : _execResult_result_T_30 & _GEN_2221; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] _GEN_2278 = _execResult_result_T_26 ? 8'h0 : _GEN_2257; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_2294 = _execResult_result_T_26 ? 1'h0 : _GEN_2273; // @[LoadStore.scala 327:17 338:19]
  wire  _GEN_2296 = _execResult_result_T_21 | _GEN_2275; // @[LoadStore.scala 338:19 350:24]
  wire  _GEN_2298 = _execResult_result_T_21 ? 1'h0 : _GEN_2277; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] _GEN_2299 = _execResult_result_T_21 ? 8'h0 : _GEN_2278; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_2315 = _execResult_result_T_21 ? 1'h0 : _GEN_2294; // @[LoadStore.scala 327:17 338:19]
  wire  execResult_result_result_44_memRead = _execResult_result_T_20 | _GEN_2296; // @[LoadStore.scala 338:19 342:24]
  wire  execResult_result_result_44_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2298; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] execResult_result_result_44_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2299; // @[LoadStore.scala 338:19 331:20]
  wire  execResult_result_result_44_done = _execResult_result_T_20 ? 1'h0 : _GEN_2315; // @[LoadStore.scala 327:17 338:19]
  wire  execResult_result_isLoad_2 = opcode == 8'hb1; // @[LoadStore.scala 399:25]
  wire [15:0] execResult_result_finalAddr = operand + _GEN_4184; // @[LoadStore.scala 424:33]
  wire  _GEN_2339 = execResult_result_isLoad_2 ? 1'h0 : 1'h1; // @[LoadStore.scala 395:21 426:22 429:27]
  wire [7:0] _GEN_2340 = execResult_result_isLoad_2 ? 8'h0 : regs_a; // @[LoadStore.scala 394:20 426:22 430:26]
  wire [7:0] _GEN_2341 = execResult_result_isLoad_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 388:13 435:22 436:21]
  wire  _GEN_2342 = execResult_result_isLoad_2 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 388:13 435:22 437:25]
  wire  _GEN_2343 = execResult_result_isLoad_2 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 388:13 435:22 438:25]
  wire [7:0] _GEN_2356 = _execResult_result_T_239 ? _GEN_2341 : regs_a; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_2376 = _execResult_result_T_30 ? regs_a : _GEN_2356; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_2397 = _execResult_result_T_26 ? regs_a : _GEN_2376; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_2418 = _execResult_result_T_21 ? regs_a : _GEN_2397; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] execResult_result_newRegs_44_a = _execResult_result_T_20 ? regs_a : _GEN_2418; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2358 = _execResult_result_T_239 ? _GEN_2343 : regs_flagZ; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2378 = _execResult_result_T_30 ? regs_flagZ : _GEN_2358; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2399 = _execResult_result_T_26 ? regs_flagZ : _GEN_2378; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2420 = _execResult_result_T_21 ? regs_flagZ : _GEN_2399; // @[LoadStore.scala 388:13 401:19]
  wire  execResult_result_newRegs_44_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2420; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2357 = _execResult_result_T_239 ? _GEN_2342 : regs_flagN; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2377 = _execResult_result_T_30 ? regs_flagN : _GEN_2357; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2398 = _execResult_result_T_26 ? regs_flagN : _GEN_2377; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2419 = _execResult_result_T_21 ? regs_flagN : _GEN_2398; // @[LoadStore.scala 388:13 401:19]
  wire  execResult_result_newRegs_44_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2419; // @[LoadStore.scala 388:13 401:19]
  wire [15:0] _GEN_2372 = _execResult_result_T_30 ? execResult_result_finalAddr : 16'h0; // @[LoadStore.scala 401:19 393:20 425:24]
  wire  _GEN_2373 = _execResult_result_T_30 & execResult_result_isLoad_2; // @[LoadStore.scala 401:19 396:20]
  wire [7:0] _GEN_2375 = _execResult_result_T_30 ? _GEN_2340 : 8'h0; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] _GEN_2392 = _execResult_result_T_26 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_2372; // @[LoadStore.scala 401:19 418:24]
  wire  _GEN_2393 = _execResult_result_T_26 | _GEN_2373; // @[LoadStore.scala 401:19 419:24]
  wire  _GEN_2395 = _execResult_result_T_26 ? 1'h0 : _execResult_result_T_30 & _GEN_2339; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] _GEN_2396 = _execResult_result_T_26 ? 8'h0 : _GEN_2375; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] _GEN_2413 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_2392; // @[LoadStore.scala 401:19 412:24]
  wire  _GEN_2414 = _execResult_result_T_21 | _GEN_2393; // @[LoadStore.scala 401:19 413:24]
  wire  _GEN_2416 = _execResult_result_T_21 ? 1'h0 : _GEN_2395; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] _GEN_2417 = _execResult_result_T_21 ? 8'h0 : _GEN_2396; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] execResult_result_result_45_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2413; // @[LoadStore.scala 401:19 404:24]
  wire  execResult_result_result_45_memRead = _execResult_result_T_20 | _GEN_2414; // @[LoadStore.scala 401:19 405:24]
  wire  execResult_result_result_45_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2416; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] execResult_result_result_45_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2417; // @[LoadStore.scala 401:19 394:20]
  wire [7:0] _execResult_result_pushData_T = {regs_flagN,regs_flagV,2'h3,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] execResult_result_pushData = opcode == 8'h8 ? _execResult_result_pushData_T : regs_a; // @[Stack.scala 21:14 23:29 24:16]
  wire [7:0] execResult_result_newRegs_45_sp = regs_sp - 8'h1; // @[Stack.scala 27:27]
  wire [15:0] execResult_result_result_46_memAddr = {8'h1,regs_sp}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_newRegs_sp_T_3 = regs_sp + 8'h1; // @[Stack.scala 57:31]
  wire [7:0] _GEN_2457 = opcode == 8'h68 ? io_memDataIn : regs_a; // @[Stack.scala 44:13 65:33 66:21]
  wire  _GEN_2458 = opcode == 8'h68 ? io_memDataIn[7] : io_memDataIn[7]; // @[Stack.scala 65:33 67:25 75:25]
  wire  _GEN_2459 = opcode == 8'h68 ? execResult_result_newRegs_37_flagZ : io_memDataIn[1]; // @[Stack.scala 65:33 68:25 71:25]
  wire  _GEN_2460 = opcode == 8'h68 ? regs_flagC : io_memDataIn[0]; // @[Stack.scala 44:13 65:33 70:25]
  wire  _GEN_2461 = opcode == 8'h68 ? regs_flagI : io_memDataIn[2]; // @[Stack.scala 44:13 65:33 72:25]
  wire  _GEN_2462 = opcode == 8'h68 ? regs_flagD : io_memDataIn[3]; // @[Stack.scala 44:13 65:33 73:25]
  wire  _GEN_2463 = opcode == 8'h68 ? regs_flagV : io_memDataIn[6]; // @[Stack.scala 44:13 65:33 74:25]
  wire [15:0] _GEN_2464 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : 16'h0; // @[Stack.scala 55:19 49:20 62:24]
  wire [7:0] _GEN_2466 = _execResult_result_T_21 ? _GEN_2457 : regs_a; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2467 = _execResult_result_T_21 ? _GEN_2458 : regs_flagN; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2468 = _execResult_result_T_21 ? _GEN_2459 : regs_flagZ; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2469 = _execResult_result_T_21 ? _GEN_2460 : regs_flagC; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2470 = _execResult_result_T_21 ? _GEN_2461 : regs_flagI; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2471 = _execResult_result_T_21 ? _GEN_2462 : regs_flagD; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2472 = _execResult_result_T_21 ? _GEN_2463 : regs_flagV; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_46_a = _execResult_result_T_20 ? regs_a : _GEN_2466; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_46_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Stack.scala 44:13 55:19 57:20]
  wire  execResult_result_newRegs_46_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_2469; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2468; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2470; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_2471; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_2472; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2467; // @[Stack.scala 44:13 55:19]
  wire [15:0] execResult_result_result_47_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2464; // @[Stack.scala 55:19 49:20]
  wire [15:0] _GEN_2508 = _execResult_result_T_21 ? regs_pc : 16'h0; // @[Jump.scala 26:19 20:20 36:24]
  wire [15:0] _GEN_2510 = _execResult_result_T_21 ? resetVector : regs_pc; // @[Jump.scala 15:13 26:19 38:20]
  wire [15:0] execResult_result_newRegs_47_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2510; // @[Jump.scala 26:19 31:20]
  wire [15:0] execResult_result_result_48_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2508; // @[Jump.scala 26:19 28:24]
  wire [15:0] _execResult_result_indirectAddrHigh_T_3 = {operand[15:8],8'h0}; // @[Cat.scala 33:92]
  wire [15:0] _execResult_result_indirectAddrHigh_T_5 = operand + 16'h1; // @[Jump.scala 89:19]
  wire [15:0] execResult_result_indirectAddrHigh = operand[7:0] == 8'hff ? _execResult_result_indirectAddrHigh_T_3 :
    _execResult_result_indirectAddrHigh_T_5; // @[Jump.scala 87:35]
  wire [15:0] _GEN_2541 = _execResult_result_T_30 ? execResult_result_indirectAddrHigh : 16'h0; // @[Jump.scala 62:19 56:20 90:24]
  wire [15:0] _GEN_2543 = _execResult_result_T_30 ? resetVector : regs_pc; // @[Jump.scala 51:13 62:19 92:20]
  wire [15:0] _GEN_2559 = _execResult_result_T_26 ? regs_pc : _GEN_2543; // @[Jump.scala 51:13 62:19]
  wire [15:0] _GEN_2576 = _execResult_result_T_21 ? _regs_pc_T_1 : _GEN_2559; // @[Jump.scala 62:19 76:20]
  wire [15:0] execResult_result_newRegs_48_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2576; // @[Jump.scala 62:19 68:20]
  wire [15:0] _GEN_2556 = _execResult_result_T_26 ? operand : _GEN_2541; // @[Jump.scala 62:19 81:24]
  wire [15:0] _GEN_2558 = _execResult_result_T_26 ? _execResult_result_result_operand_T_9 : operand; // @[Jump.scala 62:19 60:20 83:24]
  wire [15:0] _GEN_2573 = _execResult_result_T_21 ? regs_pc : _GEN_2556; // @[Jump.scala 62:19 73:24]
  wire [15:0] _GEN_2575 = _execResult_result_T_21 ? resetVector : _GEN_2558; // @[Jump.scala 62:19 75:24]
  wire [15:0] execResult_result_result_49_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2573; // @[Jump.scala 62:19 65:24]
  wire [15:0] execResult_result_result_49_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_2575; // @[Jump.scala 62:19 67:24]
  wire [15:0] _GEN_2607 = _execResult_result_T_30 ? execResult_result_result_46_memAddr : 16'h0; // @[Jump.scala 116:19 110:20 140:24]
  wire [7:0] _GEN_2608 = _execResult_result_T_30 ? regs_pc[7:0] : 8'h0; // @[Jump.scala 116:19 111:20 141:24]
  wire [7:0] _GEN_2610 = _execResult_result_T_30 ? execResult_result_newRegs_45_sp : regs_sp; // @[Jump.scala 105:13 116:19 143:20]
  wire [15:0] _GEN_2611 = _execResult_result_T_30 ? operand : regs_pc; // @[Jump.scala 105:13 116:19 144:20]
  wire [7:0] _GEN_2627 = _execResult_result_T_26 ? execResult_result_newRegs_45_sp : _GEN_2610; // @[Jump.scala 116:19 135:20]
  wire [7:0] _GEN_2649 = _execResult_result_T_21 ? regs_sp : _GEN_2627; // @[Jump.scala 105:13 116:19]
  wire [7:0] execResult_result_newRegs_49_sp = _execResult_result_T_20 ? regs_sp : _GEN_2649; // @[Jump.scala 105:13 116:19]
  wire [15:0] _GEN_2641 = _execResult_result_T_26 ? regs_pc : _GEN_2611; // @[Jump.scala 105:13 116:19]
  wire [15:0] _GEN_2662 = _execResult_result_T_21 ? regs_pc : _GEN_2641; // @[Jump.scala 105:13 116:19]
  wire [15:0] execResult_result_newRegs_49_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2662; // @[Jump.scala 116:19 121:20]
  wire [15:0] _GEN_2624 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : _GEN_2607; // @[Jump.scala 116:19 132:24]
  wire [7:0] _GEN_2625 = _execResult_result_T_26 ? regs_pc[15:8] : _GEN_2608; // @[Jump.scala 116:19 133:24]
  wire [2:0] _GEN_2640 = _execResult_result_T_26 ? 3'h3 : execResult_result_result_6_nextCycle; // @[Jump.scala 116:19 108:22 137:26]
  wire [15:0] _GEN_2643 = _execResult_result_T_21 ? regs_pc : _GEN_2624; // @[Jump.scala 116:19 126:24]
  wire [2:0] _GEN_2646 = _execResult_result_T_21 ? 3'h2 : _GEN_2640; // @[Jump.scala 116:19 129:26]
  wire [7:0] _GEN_2647 = _execResult_result_T_21 ? 8'h0 : _GEN_2625; // @[Jump.scala 116:19 111:20]
  wire  _GEN_2648 = _execResult_result_T_21 ? 1'h0 : _GEN_290; // @[Jump.scala 116:19 112:21]
  wire [15:0] execResult_result_result_50_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2643; // @[Jump.scala 116:19 118:24]
  wire [2:0] execResult_result_result_50_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_2646; // @[Jump.scala 116:19 123:26]
  wire [7:0] execResult_result_result_50_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2647; // @[Jump.scala 116:19 111:20]
  wire  execResult_result_result_50_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2648; // @[Jump.scala 116:19 112:21]
  wire [15:0] _execResult_result_newRegs_pc_T_125 = resetVector + 16'h1; // @[Jump.scala 185:53]
  wire [15:0] _GEN_2685 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : 16'h0; // @[Jump.scala 168:19 162:20 183:24]
  wire [15:0] _GEN_2687 = _execResult_result_T_26 ? _execResult_result_newRegs_pc_T_125 : regs_pc; // @[Jump.scala 157:13 168:19 185:20]
  wire [7:0] _GEN_2703 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 157:13 168:19 178:20]
  wire [7:0] execResult_result_newRegs_50_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_2703; // @[Jump.scala 168:19 170:20]
  wire [15:0] _GEN_2717 = _execResult_result_T_21 ? regs_pc : _GEN_2687; // @[Jump.scala 157:13 168:19]
  wire [15:0] execResult_result_newRegs_50_pc = _execResult_result_T_20 ? regs_pc : _GEN_2717; // @[Jump.scala 157:13 168:19]
  wire [15:0] _GEN_2700 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2685; // @[Jump.scala 168:19 175:24]
  wire [15:0] _GEN_2702 = _execResult_result_T_21 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 168:19 166:20 177:24]
  wire [15:0] execResult_result_result_51_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2700; // @[Jump.scala 168:19 162:20]
  wire  execResult_result_result_51_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_223; // @[Jump.scala 168:19 165:20]
  wire [15:0] execResult_result_result_51_operand = _execResult_result_T_20 ? operand : _GEN_2702; // @[Jump.scala 168:19 166:20]
  wire [15:0] _GEN_2738 = 3'h5 == cycle ? 16'hffff : 16'h0; // @[Jump.scala 209:19 203:20 249:24]
  wire [15:0] _GEN_2740 = 3'h5 == cycle ? resetVector : regs_pc; // @[Jump.scala 198:13 209:19 251:20]
  wire [7:0] _GEN_2820 = _execResult_result_T_21 ? execResult_result_newRegs_45_sp : _GEN_2627; // @[Jump.scala 209:19 219:20]
  wire [7:0] execResult_result_newRegs_51_sp = _execResult_result_T_20 ? regs_sp : _GEN_2820; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2757 = _execResult_result_T_239 ? regs_pc : _GEN_2740; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2792 = _execResult_result_T_30 ? regs_pc : _GEN_2757; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2815 = _execResult_result_T_26 ? regs_pc : _GEN_2792; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2838 = _execResult_result_T_21 ? regs_pc : _GEN_2815; // @[Jump.scala 198:13 209:19]
  wire [15:0] execResult_result_newRegs_51_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2838; // @[Jump.scala 209:19 211:20]
  wire  _GEN_2775 = _execResult_result_T_30 | regs_flagI; // @[Jump.scala 198:13 209:19 237:23]
  wire  _GEN_2811 = _execResult_result_T_26 ? regs_flagI : _GEN_2775; // @[Jump.scala 198:13 209:19]
  wire  _GEN_2834 = _execResult_result_T_21 ? regs_flagI : _GEN_2811; // @[Jump.scala 198:13 209:19]
  wire  execResult_result_newRegs_51_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2834; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2753 = _execResult_result_T_239 ? 16'hfffe : _GEN_2738; // @[Jump.scala 209:19 243:24]
  wire  _GEN_2754 = _execResult_result_T_239 | 3'h5 == cycle; // @[Jump.scala 209:19 244:24]
  wire [15:0] _GEN_2755 = _execResult_result_T_239 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 209:19 207:20 245:24]
  wire [2:0] _GEN_2756 = _execResult_result_T_239 ? 3'h5 : execResult_result_result_6_nextCycle; // @[Jump.scala 209:19 201:22 246:26]
  wire  _GEN_2770 = _execResult_result_T_239 ? 1'h0 : 3'h5 == cycle; // @[Jump.scala 200:17 209:19]
  wire [15:0] _GEN_2771 = _execResult_result_T_30 ? execResult_result_result_46_memAddr : _GEN_2753; // @[Jump.scala 209:19 233:24]
  wire [7:0] _GEN_2772 = _execResult_result_T_30 ? _execResult_result_pushData_T : 8'h0; // @[Jump.scala 209:19 204:20 234:24]
  wire [2:0] _GEN_2789 = _execResult_result_T_30 ? 3'h4 : _GEN_2756; // @[Jump.scala 209:19 240:26]
  wire  _GEN_2790 = _execResult_result_T_30 ? 1'h0 : _GEN_2754; // @[Jump.scala 209:19 206:20]
  wire [15:0] _GEN_2791 = _execResult_result_T_30 ? operand : _GEN_2755; // @[Jump.scala 209:19 207:20]
  wire  _GEN_2793 = _execResult_result_T_30 ? 1'h0 : _GEN_2770; // @[Jump.scala 200:17 209:19]
  wire [15:0] _GEN_2794 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : _GEN_2771; // @[Jump.scala 209:19 224:24]
  wire [7:0] _GEN_2795 = _execResult_result_T_26 ? regs_pc[7:0] : _GEN_2772; // @[Jump.scala 209:19 225:24]
  wire [2:0] _GEN_2810 = _execResult_result_T_26 ? 3'h3 : _GEN_2789; // @[Jump.scala 209:19 229:26]
  wire  _GEN_2813 = _execResult_result_T_26 ? 1'h0 : _GEN_2790; // @[Jump.scala 209:19 206:20]
  wire [15:0] _GEN_2814 = _execResult_result_T_26 ? operand : _GEN_2791; // @[Jump.scala 209:19 207:20]
  wire  _GEN_2816 = _execResult_result_T_26 ? 1'h0 : _GEN_2793; // @[Jump.scala 200:17 209:19]
  wire [15:0] _GEN_2817 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2794; // @[Jump.scala 209:19 216:24]
  wire [7:0] _GEN_2818 = _execResult_result_T_21 ? regs_pc[15:8] : _GEN_2795; // @[Jump.scala 209:19 217:24]
  wire [2:0] _GEN_2833 = _execResult_result_T_21 ? 3'h2 : _GEN_2810; // @[Jump.scala 209:19 221:26]
  wire  _GEN_2836 = _execResult_result_T_21 ? 1'h0 : _GEN_2813; // @[Jump.scala 209:19 206:20]
  wire [15:0] _GEN_2837 = _execResult_result_T_21 ? operand : _GEN_2814; // @[Jump.scala 209:19 207:20]
  wire  _GEN_2839 = _execResult_result_T_21 ? 1'h0 : _GEN_2816; // @[Jump.scala 200:17 209:19]
  wire [2:0] execResult_result_result_52_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_2833; // @[Jump.scala 209:19 213:26]
  wire [15:0] execResult_result_result_52_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2817; // @[Jump.scala 209:19 203:20]
  wire [7:0] execResult_result_result_52_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2818; // @[Jump.scala 209:19 204:20]
  wire  execResult_result_result_52_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_311; // @[Jump.scala 209:19 205:21]
  wire  execResult_result_result_52_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_2836; // @[Jump.scala 209:19 206:20]
  wire [15:0] execResult_result_result_52_operand = _execResult_result_T_20 ? operand : _GEN_2837; // @[Jump.scala 209:19 207:20]
  wire  execResult_result_result_52_done = _execResult_result_T_20 ? 1'h0 : _GEN_2839; // @[Jump.scala 200:17 209:19]
  wire [7:0] _GEN_2881 = _execResult_result_T_26 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 264:13 275:19 298:20]
  wire [7:0] _GEN_2905 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : _GEN_2881; // @[Jump.scala 275:19 290:20]
  wire [7:0] execResult_result_newRegs_52_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_2905; // @[Jump.scala 275:19 277:20]
  wire [15:0] _GEN_2920 = _execResult_result_T_21 ? regs_pc : _GEN_2559; // @[Jump.scala 264:13 275:19]
  wire [15:0] execResult_result_newRegs_52_pc = _execResult_result_T_20 ? regs_pc : _GEN_2920; // @[Jump.scala 264:13 275:19]
  wire  _GEN_2899 = _execResult_result_T_21 ? io_memDataIn[0] : regs_flagC; // @[Jump.scala 264:13 275:19 284:23]
  wire  execResult_result_newRegs_52_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_2899; // @[Jump.scala 264:13 275:19]
  wire  _GEN_2900 = _execResult_result_T_21 ? io_memDataIn[1] : regs_flagZ; // @[Jump.scala 264:13 275:19 285:23]
  wire  execResult_result_newRegs_52_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2900; // @[Jump.scala 264:13 275:19]
  wire  _GEN_2901 = _execResult_result_T_21 ? io_memDataIn[2] : regs_flagI; // @[Jump.scala 264:13 275:19 286:23]
  wire  execResult_result_newRegs_52_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2901; // @[Jump.scala 264:13 275:19]
  wire  _GEN_2902 = _execResult_result_T_21 ? io_memDataIn[3] : regs_flagD; // @[Jump.scala 264:13 275:19 287:23]
  wire  execResult_result_newRegs_52_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_2902; // @[Jump.scala 264:13 275:19]
  wire [15:0] _GEN_2880 = _execResult_result_T_26 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 275:19 273:20 297:24]
  wire [15:0] _GEN_2897 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2624; // @[Jump.scala 275:19 282:24]
  wire [15:0] _GEN_2919 = _execResult_result_T_21 ? operand : _GEN_2880; // @[Jump.scala 275:19 273:20]
  wire [15:0] execResult_result_result_53_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2897; // @[Jump.scala 275:19 269:20]
  wire [15:0] execResult_result_result_53_operand = _execResult_result_T_20 ? operand : _GEN_2919; // @[Jump.scala 275:19 273:20]
  wire  _GEN_2947 = 8'h40 == opcode & execResult_result_result_9_done; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire [2:0] _GEN_2948 = 8'h40 == opcode ? execResult_result_result_50_nextCycle : 3'h0; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire [7:0] _GEN_2952 = 8'h40 == opcode ? execResult_result_newRegs_52_sp : regs_sp; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire [15:0] _GEN_2953 = 8'h40 == opcode ? execResult_result_newRegs_52_pc : regs_pc; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire  _GEN_2954 = 8'h40 == opcode ? execResult_result_newRegs_52_flagC : regs_flagC; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire  _GEN_2955 = 8'h40 == opcode ? execResult_result_newRegs_52_flagZ : regs_flagZ; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire  _GEN_2956 = 8'h40 == opcode ? execResult_result_newRegs_52_flagI : regs_flagI; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire  _GEN_2957 = 8'h40 == opcode ? execResult_result_newRegs_52_flagD : regs_flagD; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire  _GEN_2959 = 8'h40 == opcode ? execResult_result_newRegs_16_flagV : regs_flagV; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire  _GEN_2960 = 8'h40 == opcode ? execResult_result_newRegs_16_flagN : regs_flagN; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire [15:0] _GEN_2961 = 8'h40 == opcode ? execResult_result_result_53_memAddr : 16'h0; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire  _GEN_2964 = 8'h40 == opcode & execResult_result_result_52_memWrite; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire [15:0] _GEN_2965 = 8'h40 == opcode ? execResult_result_result_53_operand : operand; // @[CPU6502Core.scala 213:12 215:20 449:27]
  wire  _GEN_2966 = 8'h0 == opcode ? execResult_result_result_52_done : _GEN_2947; // @[CPU6502Core.scala 215:20 448:27]
  wire [2:0] _GEN_2967 = 8'h0 == opcode ? execResult_result_result_52_nextCycle : _GEN_2948; // @[CPU6502Core.scala 215:20 448:27]
  wire [7:0] _GEN_2971 = 8'h0 == opcode ? execResult_result_newRegs_51_sp : _GEN_2952; // @[CPU6502Core.scala 215:20 448:27]
  wire [15:0] _GEN_2972 = 8'h0 == opcode ? execResult_result_newRegs_51_pc : _GEN_2953; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2973 = 8'h0 == opcode ? regs_flagC : _GEN_2954; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2974 = 8'h0 == opcode ? regs_flagZ : _GEN_2955; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2975 = 8'h0 == opcode ? execResult_result_newRegs_51_flagI : _GEN_2956; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2976 = 8'h0 == opcode ? regs_flagD : _GEN_2957; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2978 = 8'h0 == opcode ? regs_flagV : _GEN_2959; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2979 = 8'h0 == opcode ? regs_flagN : _GEN_2960; // @[CPU6502Core.scala 215:20 448:27]
  wire [15:0] _GEN_2980 = 8'h0 == opcode ? execResult_result_result_52_memAddr : _GEN_2961; // @[CPU6502Core.scala 215:20 448:27]
  wire [7:0] _GEN_2981 = 8'h0 == opcode ? execResult_result_result_52_memData : 8'h0; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2982 = 8'h0 == opcode & execResult_result_result_52_memWrite; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2983 = 8'h0 == opcode ? execResult_result_result_52_memRead : _GEN_2964; // @[CPU6502Core.scala 215:20 448:27]
  wire [15:0] _GEN_2984 = 8'h0 == opcode ? execResult_result_result_52_operand : _GEN_2965; // @[CPU6502Core.scala 215:20 448:27]
  wire  _GEN_2985 = 8'h60 == opcode ? execResult_result_result_8_done : _GEN_2966; // @[CPU6502Core.scala 215:20 447:27]
  wire [2:0] _GEN_2986 = 8'h60 == opcode ? execResult_result_result_11_nextCycle : _GEN_2967; // @[CPU6502Core.scala 215:20 447:27]
  wire [7:0] _GEN_2990 = 8'h60 == opcode ? execResult_result_newRegs_50_sp : _GEN_2971; // @[CPU6502Core.scala 215:20 447:27]
  wire [15:0] _GEN_2991 = 8'h60 == opcode ? execResult_result_newRegs_50_pc : _GEN_2972; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_2992 = 8'h60 == opcode ? regs_flagC : _GEN_2973; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_2993 = 8'h60 == opcode ? regs_flagZ : _GEN_2974; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_2994 = 8'h60 == opcode ? regs_flagI : _GEN_2975; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_2995 = 8'h60 == opcode ? regs_flagD : _GEN_2976; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_2997 = 8'h60 == opcode ? regs_flagV : _GEN_2978; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_2998 = 8'h60 == opcode ? regs_flagN : _GEN_2979; // @[CPU6502Core.scala 215:20 447:27]
  wire [15:0] _GEN_2999 = 8'h60 == opcode ? execResult_result_result_51_memAddr : _GEN_2980; // @[CPU6502Core.scala 215:20 447:27]
  wire [7:0] _GEN_3000 = 8'h60 == opcode ? 8'h0 : _GEN_2981; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_3001 = 8'h60 == opcode ? 1'h0 : _GEN_2982; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_3002 = 8'h60 == opcode ? execResult_result_result_51_memRead : _GEN_2983; // @[CPU6502Core.scala 215:20 447:27]
  wire [15:0] _GEN_3003 = 8'h60 == opcode ? execResult_result_result_51_operand : _GEN_2984; // @[CPU6502Core.scala 215:20 447:27]
  wire  _GEN_3004 = 8'h20 == opcode ? execResult_result_result_9_done : _GEN_2985; // @[CPU6502Core.scala 215:20 446:27]
  wire [2:0] _GEN_3005 = 8'h20 == opcode ? execResult_result_result_50_nextCycle : _GEN_2986; // @[CPU6502Core.scala 215:20 446:27]
  wire [7:0] _GEN_3009 = 8'h20 == opcode ? execResult_result_newRegs_49_sp : _GEN_2990; // @[CPU6502Core.scala 215:20 446:27]
  wire [15:0] _GEN_3010 = 8'h20 == opcode ? execResult_result_newRegs_49_pc : _GEN_2991; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3011 = 8'h20 == opcode ? regs_flagC : _GEN_2992; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3012 = 8'h20 == opcode ? regs_flagZ : _GEN_2993; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3013 = 8'h20 == opcode ? regs_flagI : _GEN_2994; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3014 = 8'h20 == opcode ? regs_flagD : _GEN_2995; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3016 = 8'h20 == opcode ? regs_flagV : _GEN_2997; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3017 = 8'h20 == opcode ? regs_flagN : _GEN_2998; // @[CPU6502Core.scala 215:20 446:27]
  wire [15:0] _GEN_3018 = 8'h20 == opcode ? execResult_result_result_50_memAddr : _GEN_2999; // @[CPU6502Core.scala 215:20 446:27]
  wire [7:0] _GEN_3019 = 8'h20 == opcode ? execResult_result_result_50_memData : _GEN_3000; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3020 = 8'h20 == opcode ? execResult_result_result_50_memWrite : _GEN_3001; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3021 = 8'h20 == opcode ? execResult_result_result_6_memRead : _GEN_3002; // @[CPU6502Core.scala 215:20 446:27]
  wire [15:0] _GEN_3022 = 8'h20 == opcode ? execResult_result_result_8_operand : _GEN_3003; // @[CPU6502Core.scala 215:20 446:27]
  wire  _GEN_3023 = 8'h6c == opcode ? execResult_result_result_9_done : _GEN_3004; // @[CPU6502Core.scala 215:20 445:27]
  wire [2:0] _GEN_3024 = 8'h6c == opcode ? execResult_result_result_6_nextCycle : _GEN_3005; // @[CPU6502Core.scala 215:20 445:27]
  wire [7:0] _GEN_3028 = 8'h6c == opcode ? regs_sp : _GEN_3009; // @[CPU6502Core.scala 215:20 445:27]
  wire [15:0] _GEN_3029 = 8'h6c == opcode ? execResult_result_newRegs_48_pc : _GEN_3010; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3030 = 8'h6c == opcode ? regs_flagC : _GEN_3011; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3031 = 8'h6c == opcode ? regs_flagZ : _GEN_3012; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3032 = 8'h6c == opcode ? regs_flagI : _GEN_3013; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3033 = 8'h6c == opcode ? regs_flagD : _GEN_3014; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3035 = 8'h6c == opcode ? regs_flagV : _GEN_3016; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3036 = 8'h6c == opcode ? regs_flagN : _GEN_3017; // @[CPU6502Core.scala 215:20 445:27]
  wire [15:0] _GEN_3037 = 8'h6c == opcode ? execResult_result_result_49_memAddr : _GEN_3018; // @[CPU6502Core.scala 215:20 445:27]
  wire [7:0] _GEN_3038 = 8'h6c == opcode ? 8'h0 : _GEN_3019; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3039 = 8'h6c == opcode ? 1'h0 : _GEN_3020; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3040 = 8'h6c == opcode ? execResult_result_result_9_memRead : _GEN_3021; // @[CPU6502Core.scala 215:20 445:27]
  wire [15:0] _GEN_3041 = 8'h6c == opcode ? execResult_result_result_49_operand : _GEN_3022; // @[CPU6502Core.scala 215:20 445:27]
  wire  _GEN_3042 = 8'h4c == opcode ? execResult_result_result_6_done : _GEN_3023; // @[CPU6502Core.scala 215:20 444:27]
  wire [2:0] _GEN_3043 = 8'h4c == opcode ? execResult_result_result_17_nextCycle : _GEN_3024; // @[CPU6502Core.scala 215:20 444:27]
  wire [7:0] _GEN_3047 = 8'h4c == opcode ? regs_sp : _GEN_3028; // @[CPU6502Core.scala 215:20 444:27]
  wire [15:0] _GEN_3048 = 8'h4c == opcode ? execResult_result_newRegs_47_pc : _GEN_3029; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3049 = 8'h4c == opcode ? regs_flagC : _GEN_3030; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3050 = 8'h4c == opcode ? regs_flagZ : _GEN_3031; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3051 = 8'h4c == opcode ? regs_flagI : _GEN_3032; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3052 = 8'h4c == opcode ? regs_flagD : _GEN_3033; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3054 = 8'h4c == opcode ? regs_flagV : _GEN_3035; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3055 = 8'h4c == opcode ? regs_flagN : _GEN_3036; // @[CPU6502Core.scala 215:20 444:27]
  wire [15:0] _GEN_3056 = 8'h4c == opcode ? execResult_result_result_48_memAddr : _GEN_3037; // @[CPU6502Core.scala 215:20 444:27]
  wire [7:0] _GEN_3057 = 8'h4c == opcode ? 8'h0 : _GEN_3038; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3058 = 8'h4c == opcode ? 1'h0 : _GEN_3039; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3059 = 8'h4c == opcode ? execResult_result_result_6_memRead : _GEN_3040; // @[CPU6502Core.scala 215:20 444:27]
  wire [15:0] _GEN_3060 = 8'h4c == opcode ? execResult_result_result_6_operand : _GEN_3041; // @[CPU6502Core.scala 215:20 444:27]
  wire  _GEN_3061 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_6_done : _GEN_3042; // @[CPU6502Core.scala 215:20 440:16]
  wire [2:0] _GEN_3062 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_17_nextCycle : _GEN_3043; // @[CPU6502Core.scala 215:20 440:16]
  wire [7:0] _GEN_3063 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_a : regs_a; // @[CPU6502Core.scala 215:20 440:16]
  wire [7:0] _GEN_3066 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_sp : _GEN_3047; // @[CPU6502Core.scala 215:20 440:16]
  wire [15:0] _GEN_3067 = 8'h68 == opcode | 8'h28 == opcode ? regs_pc : _GEN_3048; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3068 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagC : _GEN_3049; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3069 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagZ : _GEN_3050; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3070 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagI : _GEN_3051; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3071 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagD : _GEN_3052; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3073 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagV : _GEN_3054; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3074 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagN : _GEN_3055; // @[CPU6502Core.scala 215:20 440:16]
  wire [15:0] _GEN_3075 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_47_memAddr : _GEN_3056; // @[CPU6502Core.scala 215:20 440:16]
  wire [7:0] _GEN_3076 = 8'h68 == opcode | 8'h28 == opcode ? 8'h0 : _GEN_3057; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3077 = 8'h68 == opcode | 8'h28 == opcode ? 1'h0 : _GEN_3058; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3078 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_6_done : _GEN_3059; // @[CPU6502Core.scala 215:20 440:16]
  wire [15:0] _GEN_3079 = 8'h68 == opcode | 8'h28 == opcode ? 16'h0 : _GEN_3060; // @[CPU6502Core.scala 215:20 440:16]
  wire  _GEN_3080 = 8'h48 == opcode | 8'h8 == opcode | _GEN_3061; // @[CPU6502Core.scala 215:20 435:16]
  wire [2:0] _GEN_3081 = 8'h48 == opcode | 8'h8 == opcode ? 3'h0 : _GEN_3062; // @[CPU6502Core.scala 215:20 435:16]
  wire [7:0] _GEN_3082 = 8'h48 == opcode | 8'h8 == opcode ? regs_a : _GEN_3063; // @[CPU6502Core.scala 215:20 435:16]
  wire [7:0] _GEN_3085 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_newRegs_45_sp : _GEN_3066; // @[CPU6502Core.scala 215:20 435:16]
  wire [15:0] _GEN_3086 = 8'h48 == opcode | 8'h8 == opcode ? regs_pc : _GEN_3067; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3087 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagC : _GEN_3068; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3088 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagZ : _GEN_3069; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3089 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagI : _GEN_3070; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3090 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagD : _GEN_3071; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3092 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagV : _GEN_3073; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3093 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagN : _GEN_3074; // @[CPU6502Core.scala 215:20 435:16]
  wire [15:0] _GEN_3094 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_result_46_memAddr : _GEN_3075; // @[CPU6502Core.scala 215:20 435:16]
  wire [7:0] _GEN_3095 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_pushData : _GEN_3076; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3096 = 8'h48 == opcode | 8'h8 == opcode | _GEN_3077; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3097 = 8'h48 == opcode | 8'h8 == opcode ? 1'h0 : _GEN_3078; // @[CPU6502Core.scala 215:20 435:16]
  wire [15:0] _GEN_3098 = 8'h48 == opcode | 8'h8 == opcode ? 16'h0 : _GEN_3079; // @[CPU6502Core.scala 215:20 435:16]
  wire  _GEN_3099 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_44_done : _GEN_3080; // @[CPU6502Core.scala 215:20 430:16]
  wire [2:0] _GEN_3100 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3081; // @[CPU6502Core.scala 215:20 430:16]
  wire [7:0] _GEN_3101 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_a : _GEN_3082; // @[CPU6502Core.scala 215:20 430:16]
  wire [7:0] _GEN_3104 = 8'h91 == opcode | 8'hb1 == opcode ? regs_sp : _GEN_3085; // @[CPU6502Core.scala 215:20 430:16]
  wire [15:0] _GEN_3105 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3086; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3106 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagC : _GEN_3087; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3107 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_flagZ : _GEN_3088; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3108 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagI : _GEN_3089; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3109 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagD : _GEN_3090; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3111 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagV : _GEN_3092; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3112 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_flagN : _GEN_3093; // @[CPU6502Core.scala 215:20 430:16]
  wire [15:0] _GEN_3113 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memAddr : _GEN_3094; // @[CPU6502Core.scala 215:20 430:16]
  wire [7:0] _GEN_3114 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memData : _GEN_3095; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3115 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memWrite : _GEN_3096; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3116 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memRead : _GEN_3097; // @[CPU6502Core.scala 215:20 430:16]
  wire [15:0] _GEN_3117 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_36_operand : _GEN_3098; // @[CPU6502Core.scala 215:20 430:16]
  wire  _GEN_3118 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_done : _GEN_3099; // @[CPU6502Core.scala 215:20 425:16]
  wire [2:0] _GEN_3119 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_6_nextCycle : _GEN_3100; // @[CPU6502Core.scala 215:20 425:16]
  wire [7:0] _GEN_3120 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_a : _GEN_3101; // @[CPU6502Core.scala 215:20 425:16]
  wire [7:0] _GEN_3123 = 8'ha1 == opcode | 8'h81 == opcode ? regs_sp : _GEN_3104; // @[CPU6502Core.scala 215:20 425:16]
  wire [15:0] _GEN_3124 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_5_pc : _GEN_3105; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3125 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagC : _GEN_3106; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3126 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_flagZ : _GEN_3107; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3127 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagI : _GEN_3108; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3128 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagD : _GEN_3109; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3130 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagV : _GEN_3111; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3131 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_flagN : _GEN_3112; // @[CPU6502Core.scala 215:20 425:16]
  wire [15:0] _GEN_3132 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_9_memAddr : _GEN_3113; // @[CPU6502Core.scala 215:20 425:16]
  wire [7:0] _GEN_3133 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memData : _GEN_3114; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3134 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memWrite : _GEN_3115; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3135 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memRead : _GEN_3116; // @[CPU6502Core.scala 215:20 425:16]
  wire [15:0] _GEN_3136 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_9_operand : _GEN_3117; // @[CPU6502Core.scala 215:20 425:16]
  wire  _GEN_3137 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_8_done : _GEN_3118; // @[CPU6502Core.scala 215:20 420:16]
  wire [2:0] _GEN_3138 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_11_nextCycle : _GEN_3119; // @[CPU6502Core.scala 215:20 420:16]
  wire [7:0] _GEN_3139 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_42_a : _GEN_3120; // @[CPU6502Core.scala 215:20 420:16]
  wire [7:0] _GEN_3142 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? regs_sp : _GEN_3123; // @[CPU6502Core.scala 215:20 420:16]
  wire [15:0] _GEN_3143 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3124; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3144 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagC : _GEN_3125; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3145 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_42_flagZ : _GEN_3126; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3146 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagI : _GEN_3127; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3147 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagD : _GEN_3128; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3149 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagV : _GEN_3130; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3150 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_42_flagN : _GEN_3131; // @[CPU6502Core.scala 215:20 420:16]
  wire [15:0] _GEN_3151 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_8_memAddr : _GEN_3132; // @[CPU6502Core.scala 215:20 420:16]
  wire [7:0] _GEN_3152 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? 8'h0 : _GEN_3133; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3153 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? 1'h0 : _GEN_3134; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3154 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_8_memRead : _GEN_3135; // @[CPU6502Core.scala 215:20 420:16]
  wire [15:0] _GEN_3155 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_43_operand : _GEN_3136; // @[CPU6502Core.scala 215:20 420:16]
  wire  _GEN_3156 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_8_done : _GEN_3137; // @[CPU6502Core.scala 215:20 415:16]
  wire [2:0] _GEN_3157 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_11_nextCycle : _GEN_3138; // @[CPU6502Core.scala 215:20 415:16]
  wire [7:0] _GEN_3158 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_a : _GEN_3139; // @[CPU6502Core.scala 215:20 415:16]
  wire [7:0] _GEN_3159 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_x : regs_x; // @[CPU6502Core.scala 215:20 415:16]
  wire [7:0] _GEN_3160 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_y : regs_y; // @[CPU6502Core.scala 215:20 415:16]
  wire [7:0] _GEN_3161 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? regs_sp : _GEN_3142; // @[CPU6502Core.scala 215:20 415:16]
  wire [15:0] _GEN_3162 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3143; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3163 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagC : _GEN_3144; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3164 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_41_flagZ : _GEN_3145; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3165 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagI : _GEN_3146; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3166 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagD : _GEN_3147; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3168 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagV : _GEN_3149; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3169 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_41_flagN : _GEN_3150; // @[CPU6502Core.scala 215:20 415:16]
  wire [15:0] _GEN_3170 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_8_memAddr : _GEN_3151; // @[CPU6502Core.scala 215:20 415:16]
  wire [7:0] _GEN_3171 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_42_memData : _GEN_3152; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3172 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_memWrite : _GEN_3153; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3173 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_memRead : _GEN_3154; // @[CPU6502Core.scala 215:20 415:16]
  wire [15:0] _GEN_3174 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_8_operand : _GEN_3155; // @[CPU6502Core.scala 215:20 415:16]
  wire  _GEN_3175 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_done : _GEN_3156; // @[CPU6502Core.scala 215:20 410:16]
  wire [2:0] _GEN_3176 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_nextCycle : _GEN_3157; // @[CPU6502Core.scala 215:20 410:16]
  wire [7:0] _GEN_3177 = 8'hb6 == opcode | 8'h96 == opcode ? regs_a : _GEN_3158; // @[CPU6502Core.scala 215:20 410:16]
  wire [7:0] _GEN_3178 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_x : _GEN_3159; // @[CPU6502Core.scala 215:20 410:16]
  wire [7:0] _GEN_3179 = 8'hb6 == opcode | 8'h96 == opcode ? regs_y : _GEN_3160; // @[CPU6502Core.scala 215:20 410:16]
  wire [7:0] _GEN_3180 = 8'hb6 == opcode | 8'h96 == opcode ? regs_sp : _GEN_3161; // @[CPU6502Core.scala 215:20 410:16]
  wire [15:0] _GEN_3181 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_5_pc : _GEN_3162; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3182 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagC : _GEN_3163; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3183 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_flagZ : _GEN_3164; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3184 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagI : _GEN_3165; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3185 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagD : _GEN_3166; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3187 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagV : _GEN_3168; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3188 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_flagN : _GEN_3169; // @[CPU6502Core.scala 215:20 410:16]
  wire [15:0] _GEN_3189 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_memAddr : _GEN_3170; // @[CPU6502Core.scala 215:20 410:16]
  wire [7:0] _GEN_3190 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memData : _GEN_3171; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3191 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memWrite : _GEN_3172; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3192 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memRead : _GEN_3173; // @[CPU6502Core.scala 215:20 410:16]
  wire [15:0] _GEN_3193 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_operand : _GEN_3174; // @[CPU6502Core.scala 215:20 410:16]
  wire  _GEN_3194 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_6_done : _GEN_3175; // @[CPU6502Core.scala 215:20 405:16]
  wire [2:0] _GEN_3195 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_17_nextCycle : _GEN_3176; // @[CPU6502Core.scala 215:20 405:16]
  wire [7:0] _GEN_3196 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_a : _GEN_3177; // @[CPU6502Core.scala 215:20 405:16]
  wire [7:0] _GEN_3197 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_x : _GEN_3178; // @[CPU6502Core.scala 215:20 405:16]
  wire [7:0] _GEN_3198 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_y : _GEN_3179; // @[CPU6502Core.scala 215:20 405:16]
  wire [7:0] _GEN_3199 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_sp : _GEN_3180; // @[CPU6502Core.scala 215:20 405:16]
  wire [15:0] _GEN_3200 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3181; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3201 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagC : _GEN_3182; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3202 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_flagZ : _GEN_3183; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3203 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagI : _GEN_3184; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3204 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagD : _GEN_3185; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3206 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagV : _GEN_3187; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3207 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_flagN : _GEN_3188; // @[CPU6502Core.scala 215:20 405:16]
  wire [15:0] _GEN_3208 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_6_memAddr : _GEN_3189; // @[CPU6502Core.scala 215:20 405:16]
  wire [7:0] _GEN_3209 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memData : _GEN_3190; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3210 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memWrite : _GEN_3191; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3211 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memRead : _GEN_3192; // @[CPU6502Core.scala 215:20 405:16]
  wire [15:0] _GEN_3212 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_7_operand : _GEN_3193; // @[CPU6502Core.scala 215:20 405:16]
  wire  _GEN_3213 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_6_done : _GEN_3194; // @[CPU6502Core.scala 215:20 400:16]
  wire [2:0] _GEN_3214 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_17_nextCycle : _GEN_3195; // @[CPU6502Core.scala 215:20 400:16]
  wire [7:0] _GEN_3215 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_a : _GEN_3196; // @[CPU6502Core.scala 215:20 400:16]
  wire [7:0] _GEN_3216 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_x : _GEN_3197; // @[CPU6502Core.scala 215:20 400:16]
  wire [7:0] _GEN_3217 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_y : _GEN_3198; // @[CPU6502Core.scala 215:20 400:16]
  wire [7:0] _GEN_3218 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? regs_sp : _GEN_3199; // @[CPU6502Core.scala 215:20 400:16]
  wire [15:0] _GEN_3219 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_5_pc : _GEN_3200; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3220 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagC : _GEN_3201; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3221 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_38_flagZ : _GEN_3202; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3222 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagI : _GEN_3203; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3223 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagD : _GEN_3204; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3225 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagV : _GEN_3206; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3226 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_38_flagN : _GEN_3207; // @[CPU6502Core.scala 215:20 400:16]
  wire [15:0] _GEN_3227 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_memAddr : _GEN_3208; // @[CPU6502Core.scala 215:20 400:16]
  wire [7:0] _GEN_3228 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_39_memData : _GEN_3209; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3229 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_39_memWrite : _GEN_3210; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3230 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_39_memRead : _GEN_3211; // @[CPU6502Core.scala 215:20 400:16]
  wire [15:0] _GEN_3231 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_operand : _GEN_3212; // @[CPU6502Core.scala 215:20 400:16]
  wire  _GEN_3232 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_3213; // @[CPU6502Core.scala 215:20 395:16]
  wire [2:0] _GEN_3233 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 3'h0 : _GEN_3214; // @[CPU6502Core.scala 215:20 395:16]
  wire [7:0] _GEN_3234 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_a :
    _GEN_3215; // @[CPU6502Core.scala 215:20 395:16]
  wire [7:0] _GEN_3235 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_x :
    _GEN_3216; // @[CPU6502Core.scala 215:20 395:16]
  wire [7:0] _GEN_3236 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_y :
    _GEN_3217; // @[CPU6502Core.scala 215:20 395:16]
  wire [7:0] _GEN_3237 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_sp : _GEN_3218; // @[CPU6502Core.scala 215:20 395:16]
  wire [15:0] _GEN_3238 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? _regs_pc_T_1 : _GEN_3219; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3239 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagC : _GEN_3220; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3240 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_flagZ : _GEN_3221
    ; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3241 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagI : _GEN_3222; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3242 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagD : _GEN_3223; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3244 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagV : _GEN_3225; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3245 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? io_memDataIn[7] : _GEN_3226; // @[CPU6502Core.scala 215:20 395:16]
  wire [15:0] _GEN_3246 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_pc : _GEN_3227; // @[CPU6502Core.scala 215:20 395:16]
  wire [7:0] _GEN_3247 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 8'h0 : _GEN_3228; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3248 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 1'h0 : _GEN_3229; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3249 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_3230; // @[CPU6502Core.scala 215:20 395:16]
  wire [15:0] _GEN_3250 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 16'h0 : _GEN_3231; // @[CPU6502Core.scala 215:20 395:16]
  wire  _GEN_3251 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_3232; // @[CPU6502Core.scala 215:20 390:16]
  wire [2:0] _GEN_3252 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 3'h0 : _GEN_3233; // @[CPU6502Core.scala 215:20 390:16]
  wire [7:0] _GEN_3253 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_a : _GEN_3234; // @[CPU6502Core.scala 215:20 390:16]
  wire [7:0] _GEN_3254 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_x : _GEN_3235; // @[CPU6502Core.scala 215:20 390:16]
  wire [7:0] _GEN_3255 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_y : _GEN_3236; // @[CPU6502Core.scala 215:20 390:16]
  wire [7:0] _GEN_3256 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_sp : _GEN_3237; // @[CPU6502Core.scala 215:20 390:16]
  wire [15:0] _GEN_3257 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? execResult_result_newRegs_36_pc : _GEN_3238; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3258 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagC : _GEN_3239; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3259 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagZ : _GEN_3240; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3260 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagI : _GEN_3241; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3261 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagD : _GEN_3242; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3263 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagV : _GEN_3244; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3264 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagN : _GEN_3245; // @[CPU6502Core.scala 215:20 390:16]
  wire [15:0] _GEN_3265 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_pc : _GEN_3246; // @[CPU6502Core.scala 215:20 390:16]
  wire [7:0] _GEN_3266 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 8'h0 : _GEN_3247; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3267 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? 1'h0 : _GEN_3248; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3268 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_3249; // @[CPU6502Core.scala 215:20 390:16]
  wire [15:0] _GEN_3269 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 16'h0 : _GEN_3250; // @[CPU6502Core.scala 215:20 390:16]
  wire  _GEN_3270 = 8'hd2 == opcode ? execResult_result_result_9_done : _GEN_3251; // @[CPU6502Core.scala 215:20 385:16]
  wire [2:0] _GEN_3271 = 8'hd2 == opcode ? execResult_result_result_6_nextCycle : _GEN_3252; // @[CPU6502Core.scala 215:20 385:16]
  wire [7:0] _GEN_3272 = 8'hd2 == opcode ? regs_a : _GEN_3253; // @[CPU6502Core.scala 215:20 385:16]
  wire [7:0] _GEN_3273 = 8'hd2 == opcode ? regs_x : _GEN_3254; // @[CPU6502Core.scala 215:20 385:16]
  wire [7:0] _GEN_3274 = 8'hd2 == opcode ? regs_y : _GEN_3255; // @[CPU6502Core.scala 215:20 385:16]
  wire [7:0] _GEN_3275 = 8'hd2 == opcode ? regs_sp : _GEN_3256; // @[CPU6502Core.scala 215:20 385:16]
  wire [15:0] _GEN_3276 = 8'hd2 == opcode ? execResult_result_newRegs_5_pc : _GEN_3257; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3277 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3258; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3278 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3259; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3279 = 8'hd2 == opcode ? regs_flagI : _GEN_3260; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3280 = 8'hd2 == opcode ? regs_flagD : _GEN_3261; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3282 = 8'hd2 == opcode ? regs_flagV : _GEN_3263; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3283 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3264; // @[CPU6502Core.scala 215:20 385:16]
  wire [15:0] _GEN_3284 = 8'hd2 == opcode ? execResult_result_result_9_memAddr : _GEN_3265; // @[CPU6502Core.scala 215:20 385:16]
  wire [7:0] _GEN_3285 = 8'hd2 == opcode ? 8'h0 : _GEN_3266; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3286 = 8'hd2 == opcode ? 1'h0 : _GEN_3267; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3287 = 8'hd2 == opcode ? execResult_result_result_9_memRead : _GEN_3268; // @[CPU6502Core.scala 215:20 385:16]
  wire [15:0] _GEN_3288 = 8'hd2 == opcode ? execResult_result_result_36_operand : _GEN_3269; // @[CPU6502Core.scala 215:20 385:16]
  wire  _GEN_3289 = 8'hd1 == opcode ? execResult_result_result_9_done : _GEN_3270; // @[CPU6502Core.scala 215:20 380:16]
  wire [2:0] _GEN_3290 = 8'hd1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3271; // @[CPU6502Core.scala 215:20 380:16]
  wire [7:0] _GEN_3291 = 8'hd1 == opcode ? regs_a : _GEN_3272; // @[CPU6502Core.scala 215:20 380:16]
  wire [7:0] _GEN_3292 = 8'hd1 == opcode ? regs_x : _GEN_3273; // @[CPU6502Core.scala 215:20 380:16]
  wire [7:0] _GEN_3293 = 8'hd1 == opcode ? regs_y : _GEN_3274; // @[CPU6502Core.scala 215:20 380:16]
  wire [7:0] _GEN_3294 = 8'hd1 == opcode ? regs_sp : _GEN_3275; // @[CPU6502Core.scala 215:20 380:16]
  wire [15:0] _GEN_3295 = 8'hd1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3276; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3296 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3277; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3297 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3278; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3298 = 8'hd1 == opcode ? regs_flagI : _GEN_3279; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3299 = 8'hd1 == opcode ? regs_flagD : _GEN_3280; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3301 = 8'hd1 == opcode ? regs_flagV : _GEN_3282; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3302 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3283; // @[CPU6502Core.scala 215:20 380:16]
  wire [15:0] _GEN_3303 = 8'hd1 == opcode ? execResult_result_result_9_memAddr : _GEN_3284; // @[CPU6502Core.scala 215:20 380:16]
  wire [7:0] _GEN_3304 = 8'hd1 == opcode ? 8'h0 : _GEN_3285; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3305 = 8'hd1 == opcode ? 1'h0 : _GEN_3286; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3306 = 8'hd1 == opcode ? execResult_result_result_9_memRead : _GEN_3287; // @[CPU6502Core.scala 215:20 380:16]
  wire [15:0] _GEN_3307 = 8'hd1 == opcode ? execResult_result_result_10_operand : _GEN_3288; // @[CPU6502Core.scala 215:20 380:16]
  wire  _GEN_3308 = 8'hc1 == opcode ? execResult_result_result_9_done : _GEN_3289; // @[CPU6502Core.scala 215:20 375:16]
  wire [2:0] _GEN_3309 = 8'hc1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3290; // @[CPU6502Core.scala 215:20 375:16]
  wire [7:0] _GEN_3310 = 8'hc1 == opcode ? regs_a : _GEN_3291; // @[CPU6502Core.scala 215:20 375:16]
  wire [7:0] _GEN_3311 = 8'hc1 == opcode ? regs_x : _GEN_3292; // @[CPU6502Core.scala 215:20 375:16]
  wire [7:0] _GEN_3312 = 8'hc1 == opcode ? regs_y : _GEN_3293; // @[CPU6502Core.scala 215:20 375:16]
  wire [7:0] _GEN_3313 = 8'hc1 == opcode ? regs_sp : _GEN_3294; // @[CPU6502Core.scala 215:20 375:16]
  wire [15:0] _GEN_3314 = 8'hc1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3295; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3315 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3296; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3316 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3297; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3317 = 8'hc1 == opcode ? regs_flagI : _GEN_3298; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3318 = 8'hc1 == opcode ? regs_flagD : _GEN_3299; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3320 = 8'hc1 == opcode ? regs_flagV : _GEN_3301; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3321 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3302; // @[CPU6502Core.scala 215:20 375:16]
  wire [15:0] _GEN_3322 = 8'hc1 == opcode ? execResult_result_result_9_memAddr : _GEN_3303; // @[CPU6502Core.scala 215:20 375:16]
  wire [7:0] _GEN_3323 = 8'hc1 == opcode ? 8'h0 : _GEN_3304; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3324 = 8'hc1 == opcode ? 1'h0 : _GEN_3305; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3325 = 8'hc1 == opcode ? execResult_result_result_9_memRead : _GEN_3306; // @[CPU6502Core.scala 215:20 375:16]
  wire [15:0] _GEN_3326 = 8'hc1 == opcode ? execResult_result_result_9_operand : _GEN_3307; // @[CPU6502Core.scala 215:20 375:16]
  wire  _GEN_3327 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_done : _GEN_3308; // @[CPU6502Core.scala 215:20 370:16]
  wire [2:0] _GEN_3328 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_6_nextCycle : _GEN_3309; // @[CPU6502Core.scala 215:20 370:16]
  wire [7:0] _GEN_3329 = 8'hdd == opcode | 8'hd9 == opcode ? regs_a : _GEN_3310; // @[CPU6502Core.scala 215:20 370:16]
  wire [7:0] _GEN_3330 = 8'hdd == opcode | 8'hd9 == opcode ? regs_x : _GEN_3311; // @[CPU6502Core.scala 215:20 370:16]
  wire [7:0] _GEN_3331 = 8'hdd == opcode | 8'hd9 == opcode ? regs_y : _GEN_3312; // @[CPU6502Core.scala 215:20 370:16]
  wire [7:0] _GEN_3332 = 8'hdd == opcode | 8'hd9 == opcode ? regs_sp : _GEN_3313; // @[CPU6502Core.scala 215:20 370:16]
  wire [15:0] _GEN_3333 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_7_pc : _GEN_3314; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3334 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagC : _GEN_3315; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3335 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagZ : _GEN_3316; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3336 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagI : _GEN_3317; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3337 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagD : _GEN_3318; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3339 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagV : _GEN_3320; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3340 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagN : _GEN_3321; // @[CPU6502Core.scala 215:20 370:16]
  wire [15:0] _GEN_3341 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_memAddr : _GEN_3322; // @[CPU6502Core.scala 215:20 370:16]
  wire [7:0] _GEN_3342 = 8'hdd == opcode | 8'hd9 == opcode ? 8'h0 : _GEN_3323; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3343 = 8'hdd == opcode | 8'hd9 == opcode ? 1'h0 : _GEN_3324; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3344 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_memRead : _GEN_3325; // @[CPU6502Core.scala 215:20 370:16]
  wire [15:0] _GEN_3345 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_33_operand : _GEN_3326; // @[CPU6502Core.scala 215:20 370:16]
  wire  _GEN_3346 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_done : _GEN_3327; // @[CPU6502Core.scala 215:20 365:16]
  wire [2:0] _GEN_3347 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3328; // @[CPU6502Core.scala 215:20 365:16]
  wire [7:0] _GEN_3348 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_a : _GEN_3329; // @[CPU6502Core.scala 215:20 365:16]
  wire [7:0] _GEN_3349 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_x : _GEN_3330; // @[CPU6502Core.scala 215:20 365:16]
  wire [7:0] _GEN_3350 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_y : _GEN_3331; // @[CPU6502Core.scala 215:20 365:16]
  wire [7:0] _GEN_3351 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_sp : _GEN_3332; // @[CPU6502Core.scala 215:20 365:16]
  wire [15:0] _GEN_3352 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_7_pc :
    _GEN_3333; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3353 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagC : _GEN_3334
    ; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3354 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagZ : _GEN_3335
    ; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3355 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagI : _GEN_3336; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3356 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagD : _GEN_3337; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3358 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagV : _GEN_3339; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3359 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagN : _GEN_3340
    ; // @[CPU6502Core.scala 215:20 365:16]
  wire [15:0] _GEN_3360 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_memAddr :
    _GEN_3341; // @[CPU6502Core.scala 215:20 365:16]
  wire [7:0] _GEN_3361 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 8'h0 : _GEN_3342; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3362 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 1'h0 : _GEN_3343; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3363 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_memRead : _GEN_3344
    ; // @[CPU6502Core.scala 215:20 365:16]
  wire [15:0] _GEN_3364 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_operand :
    _GEN_3345; // @[CPU6502Core.scala 215:20 365:16]
  wire  _GEN_3365 = 8'hd5 == opcode ? execResult_result_result_6_done : _GEN_3346; // @[CPU6502Core.scala 215:20 360:16]
  wire [2:0] _GEN_3366 = 8'hd5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3347; // @[CPU6502Core.scala 215:20 360:16]
  wire [7:0] _GEN_3367 = 8'hd5 == opcode ? regs_a : _GEN_3348; // @[CPU6502Core.scala 215:20 360:16]
  wire [7:0] _GEN_3368 = 8'hd5 == opcode ? regs_x : _GEN_3349; // @[CPU6502Core.scala 215:20 360:16]
  wire [7:0] _GEN_3369 = 8'hd5 == opcode ? regs_y : _GEN_3350; // @[CPU6502Core.scala 215:20 360:16]
  wire [7:0] _GEN_3370 = 8'hd5 == opcode ? regs_sp : _GEN_3351; // @[CPU6502Core.scala 215:20 360:16]
  wire [15:0] _GEN_3371 = 8'hd5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3352; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3372 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagC : _GEN_3353; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3373 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagZ : _GEN_3354; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3374 = 8'hd5 == opcode ? regs_flagI : _GEN_3355; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3375 = 8'hd5 == opcode ? regs_flagD : _GEN_3356; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3377 = 8'hd5 == opcode ? regs_flagV : _GEN_3358; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3378 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagN : _GEN_3359; // @[CPU6502Core.scala 215:20 360:16]
  wire [15:0] _GEN_3379 = 8'hd5 == opcode ? execResult_result_result_6_memAddr : _GEN_3360; // @[CPU6502Core.scala 215:20 360:16]
  wire [7:0] _GEN_3380 = 8'hd5 == opcode ? 8'h0 : _GEN_3361; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3381 = 8'hd5 == opcode ? 1'h0 : _GEN_3362; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3382 = 8'hd5 == opcode ? execResult_result_result_6_memRead : _GEN_3363; // @[CPU6502Core.scala 215:20 360:16]
  wire [15:0] _GEN_3383 = 8'hd5 == opcode ? execResult_result_result_7_operand : _GEN_3364; // @[CPU6502Core.scala 215:20 360:16]
  wire  _GEN_3384 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_done : _GEN_3365; // @[CPU6502Core.scala 215:20 355:16]
  wire [2:0] _GEN_3385 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3366; // @[CPU6502Core.scala 215:20 355:16]
  wire [7:0] _GEN_3386 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_a : _GEN_3367; // @[CPU6502Core.scala 215:20 355:16]
  wire [7:0] _GEN_3387 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_x : _GEN_3368; // @[CPU6502Core.scala 215:20 355:16]
  wire [7:0] _GEN_3388 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_y : _GEN_3369; // @[CPU6502Core.scala 215:20 355:16]
  wire [7:0] _GEN_3389 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_sp : _GEN_3370; // @[CPU6502Core.scala 215:20 355:16]
  wire [15:0] _GEN_3390 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3371; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3391 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagC : _GEN_3372
    ; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3392 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagZ : _GEN_3373
    ; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3393 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagI : _GEN_3374; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3394 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagD : _GEN_3375; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3396 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagV : _GEN_3377; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3397 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagN : _GEN_3378
    ; // @[CPU6502Core.scala 215:20 355:16]
  wire [15:0] _GEN_3398 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3379; // @[CPU6502Core.scala 215:20 355:16]
  wire [7:0] _GEN_3399 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 8'h0 : _GEN_3380; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3400 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 1'h0 : _GEN_3381; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3401 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memRead : _GEN_3382
    ; // @[CPU6502Core.scala 215:20 355:16]
  wire [15:0] _GEN_3402 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_operand :
    _GEN_3383; // @[CPU6502Core.scala 215:20 355:16]
  wire  _GEN_3403 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_3384; // @[CPU6502Core.scala 215:20 350:16]
  wire [2:0] _GEN_3404 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 3'h0 : _GEN_3385; // @[CPU6502Core.scala 215:20 350:16]
  wire [7:0] _GEN_3405 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_a : _GEN_3386; // @[CPU6502Core.scala 215:20 350:16]
  wire [7:0] _GEN_3406 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_x : _GEN_3387; // @[CPU6502Core.scala 215:20 350:16]
  wire [7:0] _GEN_3407 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_y : _GEN_3388; // @[CPU6502Core.scala 215:20 350:16]
  wire [7:0] _GEN_3408 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_sp : _GEN_3389; // @[CPU6502Core.scala 215:20 350:16]
  wire [15:0] _GEN_3409 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? _regs_pc_T_1 : _GEN_3390; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3410 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagC : _GEN_3391
    ; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3411 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagZ : _GEN_3392
    ; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3412 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagI : _GEN_3393; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3413 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagD : _GEN_3394; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3415 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagV : _GEN_3396; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3416 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagN : _GEN_3397
    ; // @[CPU6502Core.scala 215:20 350:16]
  wire [15:0] _GEN_3417 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_pc : _GEN_3398; // @[CPU6502Core.scala 215:20 350:16]
  wire [7:0] _GEN_3418 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 8'h0 : _GEN_3399; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3419 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 1'h0 : _GEN_3400; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3420 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_3401; // @[CPU6502Core.scala 215:20 350:16]
  wire [15:0] _GEN_3421 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 16'h0 : _GEN_3402; // @[CPU6502Core.scala 215:20 350:16]
  wire  _GEN_3422 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_9_done : _GEN_3403; // @[CPU6502Core.scala 215:20 345:16]
  wire [2:0] _GEN_3423 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_6_nextCycle : _GEN_3404; // @[CPU6502Core.scala 215:20 345:16]
  wire [7:0] _GEN_3424 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_a : _GEN_3405; // @[CPU6502Core.scala 215:20 345:16]
  wire [7:0] _GEN_3425 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_x : _GEN_3406; // @[CPU6502Core.scala 215:20 345:16]
  wire [7:0] _GEN_3426 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_y : _GEN_3407; // @[CPU6502Core.scala 215:20 345:16]
  wire [7:0] _GEN_3427 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_sp : _GEN_3408; // @[CPU6502Core.scala 215:20 345:16]
  wire [15:0] _GEN_3428 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_7_pc : _GEN_3409; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3429 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagC : _GEN_3410; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3430 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagZ : _GEN_3411; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3431 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagI : _GEN_3412; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3432 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagD : _GEN_3413; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3434 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagV : _GEN_3415; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3435 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagN : _GEN_3416; // @[CPU6502Core.scala 215:20 345:16]
  wire [15:0] _GEN_3436 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_13_memAddr : _GEN_3417; // @[CPU6502Core.scala 215:20 345:16]
  wire [7:0] _GEN_3437 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_27_memData : _GEN_3418; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3438 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_9_done : _GEN_3419; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3439 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_8_memRead : _GEN_3420; // @[CPU6502Core.scala 215:20 345:16]
  wire [15:0] _GEN_3440 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_14_operand : _GEN_3421; // @[CPU6502Core.scala 215:20 345:16]
  wire  _GEN_3441 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_9_done : _GEN_3422; // @[CPU6502Core.scala 215:20 340:16]
  wire [2:0] _GEN_3442 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_6_nextCycle : _GEN_3423; // @[CPU6502Core.scala 215:20 340:16]
  wire [7:0] _GEN_3443 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_a : _GEN_3424; // @[CPU6502Core.scala 215:20 340:16]
  wire [7:0] _GEN_3444 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_x : _GEN_3425; // @[CPU6502Core.scala 215:20 340:16]
  wire [7:0] _GEN_3445 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_y : _GEN_3426; // @[CPU6502Core.scala 215:20 340:16]
  wire [7:0] _GEN_3446 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_sp : _GEN_3427; // @[CPU6502Core.scala 215:20 340:16]
  wire [15:0] _GEN_3447 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_newRegs_7_pc : _GEN_3428; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3448 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_newRegs_26_flagC : _GEN_3429; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3449 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_newRegs_26_flagZ : _GEN_3430; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3450 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_flagI : _GEN_3431; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3451 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_flagD : _GEN_3432; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3453 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_flagV : _GEN_3434; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3454 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_newRegs_26_flagN : _GEN_3435; // @[CPU6502Core.scala 215:20 340:16]
  wire [15:0] _GEN_3455 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_13_memAddr : _GEN_3436; // @[CPU6502Core.scala 215:20 340:16]
  wire [7:0] _GEN_3456 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_27_memData : _GEN_3437; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3457 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_9_done : _GEN_3438; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3458 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_8_memRead : _GEN_3439; // @[CPU6502Core.scala 215:20 340:16]
  wire [15:0] _GEN_3459 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_8_operand : _GEN_3440; // @[CPU6502Core.scala 215:20 340:16]
  wire  _GEN_3460 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_8_done : _GEN_3441; // @[CPU6502Core.scala 215:20 335:16]
  wire [2:0] _GEN_3461 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3442; // @[CPU6502Core.scala 215:20 335:16]
  wire [7:0] _GEN_3462 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_a : _GEN_3443; // @[CPU6502Core.scala 215:20 335:16]
  wire [7:0] _GEN_3463 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_x : _GEN_3444; // @[CPU6502Core.scala 215:20 335:16]
  wire [7:0] _GEN_3464 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_y : _GEN_3445; // @[CPU6502Core.scala 215:20 335:16]
  wire [7:0] _GEN_3465 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_sp : _GEN_3446; // @[CPU6502Core.scala 215:20 335:16]
  wire [15:0] _GEN_3466 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3447; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3467 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagC : _GEN_3448; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3468 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagZ : _GEN_3449; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3469 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagI : _GEN_3450; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3470 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagD : _GEN_3451; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3472 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagV : _GEN_3453; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3473 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagN : _GEN_3454; // @[CPU6502Core.scala 215:20 335:16]
  wire [15:0] _GEN_3474 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_11_memAddr : _GEN_3455; // @[CPU6502Core.scala 215:20 335:16]
  wire [7:0] _GEN_3475 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_26_memData : _GEN_3456; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3476 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_8_done : _GEN_3457; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3477 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_6_memRead : _GEN_3458; // @[CPU6502Core.scala 215:20 335:16]
  wire [15:0] _GEN_3478 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_7_operand : _GEN_3459; // @[CPU6502Core.scala 215:20 335:16]
  wire  _GEN_3479 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_8_done : _GEN_3460; // @[CPU6502Core.scala 215:20 330:16]
  wire [2:0] _GEN_3480 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_11_nextCycle : _GEN_3461; // @[CPU6502Core.scala 215:20 330:16]
  wire [7:0] _GEN_3481 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_a : _GEN_3462; // @[CPU6502Core.scala 215:20 330:16]
  wire [7:0] _GEN_3482 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_x : _GEN_3463; // @[CPU6502Core.scala 215:20 330:16]
  wire [7:0] _GEN_3483 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_y : _GEN_3464; // @[CPU6502Core.scala 215:20 330:16]
  wire [7:0] _GEN_3484 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_sp : _GEN_3465; // @[CPU6502Core.scala 215:20 330:16]
  wire [15:0] _GEN_3485 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3466; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3486 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagC : _GEN_3467; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3487 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagZ : _GEN_3468; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3488 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagI : _GEN_3469; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3489 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagD : _GEN_3470; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3491 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagV : _GEN_3472; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3492 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagN : _GEN_3473; // @[CPU6502Core.scala 215:20 330:16]
  wire [15:0] _GEN_3493 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_11_memAddr : _GEN_3474; // @[CPU6502Core.scala 215:20 330:16]
  wire [7:0] _GEN_3494 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_25_memData : _GEN_3475; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3495 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_8_done : _GEN_3476; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3496 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memRead : _GEN_3477; // @[CPU6502Core.scala 215:20 330:16]
  wire [15:0] _GEN_3497 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_operand : _GEN_3478; // @[CPU6502Core.scala 215:20 330:16]
  wire  _GEN_3498 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode | _GEN_3479; // @[CPU6502Core.scala 215:20 325:16]
  wire [2:0] _GEN_3499 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 3'h0 : _GEN_3480; // @[CPU6502Core.scala 215:20 325:16]
  wire [7:0] _GEN_3500 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? execResult_result_res_22
     : _GEN_3481; // @[CPU6502Core.scala 215:20 325:16]
  wire [7:0] _GEN_3501 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_x : _GEN_3482; // @[CPU6502Core.scala 215:20 325:16]
  wire [7:0] _GEN_3502 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_y : _GEN_3483; // @[CPU6502Core.scala 215:20 325:16]
  wire [7:0] _GEN_3503 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_sp : _GEN_3484; // @[CPU6502Core.scala 215:20 325:16]
  wire [15:0] _GEN_3504 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_pc : _GEN_3485; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3505 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagC : _GEN_3486; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3506 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagZ : _GEN_3487; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3507 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagI : _GEN_3488; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3508 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagD : _GEN_3489; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3510 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagV : _GEN_3491; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3511 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagN : _GEN_3492; // @[CPU6502Core.scala 215:20 325:16]
  wire [15:0] _GEN_3512 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_3493; // @[CPU6502Core.scala 215:20 325:16]
  wire [7:0] _GEN_3513 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 8'h0 : _GEN_3494; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3514 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_3495; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3515 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_3496; // @[CPU6502Core.scala 215:20 325:16]
  wire [15:0] _GEN_3516 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_3497; // @[CPU6502Core.scala 215:20 325:16]
  wire  _GEN_3517 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_done : _GEN_3498; // @[CPU6502Core.scala 215:20 320:16]
  wire [2:0] _GEN_3518 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3499; // @[CPU6502Core.scala 215:20 320:16]
  wire [7:0] _GEN_3519 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_a :
    _GEN_3500; // @[CPU6502Core.scala 215:20 320:16]
  wire [7:0] _GEN_3520 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_x : _GEN_3501; // @[CPU6502Core.scala 215:20 320:16]
  wire [7:0] _GEN_3521 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_y : _GEN_3502; // @[CPU6502Core.scala 215:20 320:16]
  wire [7:0] _GEN_3522 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_sp : _GEN_3503; // @[CPU6502Core.scala 215:20 320:16]
  wire [15:0] _GEN_3523 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3504; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3524 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagC : _GEN_3505; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3525 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_3506
    ; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3526 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagI : _GEN_3507; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3527 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagD : _GEN_3508; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3529 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagV : _GEN_3510; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3530 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_flagN : _GEN_3511
    ; // @[CPU6502Core.scala 215:20 320:16]
  wire [15:0] _GEN_3531 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_memAddr :
    _GEN_3512; // @[CPU6502Core.scala 215:20 320:16]
  wire [7:0] _GEN_3532 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 8'h0 : _GEN_3513; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3533 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 1'h0 : _GEN_3514; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3534 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_memRead : _GEN_3515
    ; // @[CPU6502Core.scala 215:20 320:16]
  wire [15:0] _GEN_3535 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_10_operand :
    _GEN_3516; // @[CPU6502Core.scala 215:20 320:16]
  wire  _GEN_3536 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_done : _GEN_3517; // @[CPU6502Core.scala 215:20 315:16]
  wire [2:0] _GEN_3537 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3518; // @[CPU6502Core.scala 215:20 315:16]
  wire [7:0] _GEN_3538 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_a : _GEN_3519
    ; // @[CPU6502Core.scala 215:20 315:16]
  wire [7:0] _GEN_3539 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_x : _GEN_3520; // @[CPU6502Core.scala 215:20 315:16]
  wire [7:0] _GEN_3540 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_y : _GEN_3521; // @[CPU6502Core.scala 215:20 315:16]
  wire [7:0] _GEN_3541 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_sp : _GEN_3522; // @[CPU6502Core.scala 215:20 315:16]
  wire [15:0] _GEN_3542 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3523; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3543 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagC : _GEN_3524; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3544 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_3525; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3545 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagI : _GEN_3526; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3546 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagD : _GEN_3527; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3548 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagV : _GEN_3529; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3549 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_flagN : _GEN_3530; // @[CPU6502Core.scala 215:20 315:16]
  wire [15:0] _GEN_3550 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_memAddr :
    _GEN_3531; // @[CPU6502Core.scala 215:20 315:16]
  wire [7:0] _GEN_3551 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 8'h0 : _GEN_3532; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3552 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 1'h0 : _GEN_3533; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3553 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_memRead : _GEN_3534; // @[CPU6502Core.scala 215:20 315:16]
  wire [15:0] _GEN_3554 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_operand :
    _GEN_3535; // @[CPU6502Core.scala 215:20 315:16]
  wire  _GEN_3555 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_8_done : _GEN_3536; // @[CPU6502Core.scala 215:20 310:16]
  wire [2:0] _GEN_3556 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_6_nextCycle : _GEN_3537; // @[CPU6502Core.scala 215:20 310:16]
  wire [7:0] _GEN_3557 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_19_a : _GEN_3538; // @[CPU6502Core.scala 215:20 310:16]
  wire [7:0] _GEN_3558 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_x : _GEN_3539; // @[CPU6502Core.scala 215:20 310:16]
  wire [7:0] _GEN_3559 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_y : _GEN_3540; // @[CPU6502Core.scala 215:20 310:16]
  wire [7:0] _GEN_3560 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_sp : _GEN_3541; // @[CPU6502Core.scala 215:20 310:16]
  wire [15:0] _GEN_3561 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3542; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3562 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagC : _GEN_3543; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3563 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_19_flagZ : _GEN_3544; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3564 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagI : _GEN_3545; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3565 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagD : _GEN_3546; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3567 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagV : _GEN_3548; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3568 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_19_flagN : _GEN_3549; // @[CPU6502Core.scala 215:20 310:16]
  wire [15:0] _GEN_3569 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_8_memAddr : _GEN_3550; // @[CPU6502Core.scala 215:20 310:16]
  wire [7:0] _GEN_3570 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? 8'h0 : _GEN_3551; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3571 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? 1'h0 : _GEN_3552; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3572 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_8_memRead : _GEN_3553; // @[CPU6502Core.scala 215:20 310:16]
  wire [15:0] _GEN_3573 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_21_operand : _GEN_3554; // @[CPU6502Core.scala 215:20 310:16]
  wire  _GEN_3574 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_done : _GEN_3555; // @[CPU6502Core.scala 215:20 305:16]
  wire [2:0] _GEN_3575 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3556; // @[CPU6502Core.scala 215:20 305:16]
  wire [7:0] _GEN_3576 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_a : _GEN_3557; // @[CPU6502Core.scala 215:20 305:16]
  wire [7:0] _GEN_3577 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_x : _GEN_3558; // @[CPU6502Core.scala 215:20 305:16]
  wire [7:0] _GEN_3578 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_y : _GEN_3559; // @[CPU6502Core.scala 215:20 305:16]
  wire [7:0] _GEN_3579 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_sp : _GEN_3560; // @[CPU6502Core.scala 215:20 305:16]
  wire [15:0] _GEN_3580 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_7_pc : _GEN_3561; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3581 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagC : _GEN_3562; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3582 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagZ : _GEN_3563; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3583 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagI : _GEN_3564; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3584 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagD : _GEN_3565; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3586 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagV : _GEN_3567; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3587 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagN : _GEN_3568; // @[CPU6502Core.scala 215:20 305:16]
  wire [15:0] _GEN_3588 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_memAddr : _GEN_3569; // @[CPU6502Core.scala 215:20 305:16]
  wire [7:0] _GEN_3589 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 8'h0 : _GEN_3570; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3590 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 1'h0 : _GEN_3571; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3591 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_memRead : _GEN_3572; // @[CPU6502Core.scala 215:20 305:16]
  wire [15:0] _GEN_3592 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_operand : _GEN_3573; // @[CPU6502Core.scala 215:20 305:16]
  wire  _GEN_3593 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_done : _GEN_3574; // @[CPU6502Core.scala 215:20 300:16]
  wire [2:0] _GEN_3594 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3575; // @[CPU6502Core.scala 215:20 300:16]
  wire [7:0] _GEN_3595 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_a :
    _GEN_3576; // @[CPU6502Core.scala 215:20 300:16]
  wire [7:0] _GEN_3596 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_x : _GEN_3577; // @[CPU6502Core.scala 215:20 300:16]
  wire [7:0] _GEN_3597 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_y : _GEN_3578; // @[CPU6502Core.scala 215:20 300:16]
  wire [7:0] _GEN_3598 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_sp : _GEN_3579; // @[CPU6502Core.scala 215:20 300:16]
  wire [15:0] _GEN_3599 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3580; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3600 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagC : _GEN_3581; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3601 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_3582
    ; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3602 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagI : _GEN_3583; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3603 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagD : _GEN_3584; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3605 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagV : _GEN_3586; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3606 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_flagN : _GEN_3587
    ; // @[CPU6502Core.scala 215:20 300:16]
  wire [15:0] _GEN_3607 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3588; // @[CPU6502Core.scala 215:20 300:16]
  wire [7:0] _GEN_3608 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 8'h0 : _GEN_3589; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3609 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 1'h0 : _GEN_3590; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3610 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memRead : _GEN_3591
    ; // @[CPU6502Core.scala 215:20 300:16]
  wire [15:0] _GEN_3611 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_7_operand :
    _GEN_3592; // @[CPU6502Core.scala 215:20 300:16]
  wire  _GEN_3612 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_done : _GEN_3593; // @[CPU6502Core.scala 215:20 295:16]
  wire [2:0] _GEN_3613 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3594; // @[CPU6502Core.scala 215:20 295:16]
  wire [7:0] _GEN_3614 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_a : _GEN_3595
    ; // @[CPU6502Core.scala 215:20 295:16]
  wire [7:0] _GEN_3615 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_x : _GEN_3596; // @[CPU6502Core.scala 215:20 295:16]
  wire [7:0] _GEN_3616 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_y : _GEN_3597; // @[CPU6502Core.scala 215:20 295:16]
  wire [7:0] _GEN_3617 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_sp : _GEN_3598; // @[CPU6502Core.scala 215:20 295:16]
  wire [15:0] _GEN_3618 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3599; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3619 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagC : _GEN_3600; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3620 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_3601; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3621 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagI : _GEN_3602; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3622 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagD : _GEN_3603; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3624 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagV : _GEN_3605; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3625 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_flagN : _GEN_3606; // @[CPU6502Core.scala 215:20 295:16]
  wire [15:0] _GEN_3626 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3607; // @[CPU6502Core.scala 215:20 295:16]
  wire [7:0] _GEN_3627 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 8'h0 : _GEN_3608; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3628 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 1'h0 : _GEN_3609; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3629 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memRead : _GEN_3610; // @[CPU6502Core.scala 215:20 295:16]
  wire [15:0] _GEN_3630 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_operand :
    _GEN_3611; // @[CPU6502Core.scala 215:20 295:16]
  wire  _GEN_3631 = 8'h24 == opcode ? execResult_result_result_6_done : _GEN_3612; // @[CPU6502Core.scala 215:20 292:16]
  wire [2:0] _GEN_3632 = 8'h24 == opcode ? execResult_result_result_17_nextCycle : _GEN_3613; // @[CPU6502Core.scala 215:20 292:16]
  wire [7:0] _GEN_3633 = 8'h24 == opcode ? regs_a : _GEN_3614; // @[CPU6502Core.scala 215:20 292:16]
  wire [7:0] _GEN_3634 = 8'h24 == opcode ? regs_x : _GEN_3615; // @[CPU6502Core.scala 215:20 292:16]
  wire [7:0] _GEN_3635 = 8'h24 == opcode ? regs_y : _GEN_3616; // @[CPU6502Core.scala 215:20 292:16]
  wire [7:0] _GEN_3636 = 8'h24 == opcode ? regs_sp : _GEN_3617; // @[CPU6502Core.scala 215:20 292:16]
  wire [15:0] _GEN_3637 = 8'h24 == opcode ? execResult_result_newRegs_5_pc : _GEN_3618; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3638 = 8'h24 == opcode ? regs_flagC : _GEN_3619; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3639 = 8'h24 == opcode ? execResult_result_newRegs_16_flagZ : _GEN_3620; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3640 = 8'h24 == opcode ? regs_flagI : _GEN_3621; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3641 = 8'h24 == opcode ? regs_flagD : _GEN_3622; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3643 = 8'h24 == opcode ? execResult_result_newRegs_16_flagV : _GEN_3624; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3644 = 8'h24 == opcode ? execResult_result_newRegs_16_flagN : _GEN_3625; // @[CPU6502Core.scala 215:20 292:16]
  wire [15:0] _GEN_3645 = 8'h24 == opcode ? execResult_result_result_6_memAddr : _GEN_3626; // @[CPU6502Core.scala 215:20 292:16]
  wire [7:0] _GEN_3646 = 8'h24 == opcode ? 8'h0 : _GEN_3627; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3647 = 8'h24 == opcode ? 1'h0 : _GEN_3628; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3648 = 8'h24 == opcode ? execResult_result_result_6_memRead : _GEN_3629; // @[CPU6502Core.scala 215:20 292:16]
  wire [15:0] _GEN_3649 = 8'h24 == opcode ? execResult_result_result_6_operand : _GEN_3630; // @[CPU6502Core.scala 215:20 292:16]
  wire  _GEN_3650 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_3631; // @[CPU6502Core.scala 215:20 287:16]
  wire [2:0] _GEN_3651 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 3'h0 : _GEN_3632; // @[CPU6502Core.scala 215:20 287:16]
  wire [7:0] _GEN_3652 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_res_15 : _GEN_3633; // @[CPU6502Core.scala 215:20 287:16]
  wire [7:0] _GEN_3653 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_x : _GEN_3634; // @[CPU6502Core.scala 215:20 287:16]
  wire [7:0] _GEN_3654 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_y : _GEN_3635; // @[CPU6502Core.scala 215:20 287:16]
  wire [7:0] _GEN_3655 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_sp : _GEN_3636; // @[CPU6502Core.scala 215:20 287:16]
  wire [15:0] _GEN_3656 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? _regs_pc_T_1 : _GEN_3637; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3657 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagC : _GEN_3638; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3658 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_15_flagZ : _GEN_3639; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3659 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagI : _GEN_3640; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3660 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagD : _GEN_3641; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3662 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagV : _GEN_3643; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3663 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_15_flagN : _GEN_3644; // @[CPU6502Core.scala 215:20 287:16]
  wire [15:0] _GEN_3664 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_pc : _GEN_3645; // @[CPU6502Core.scala 215:20 287:16]
  wire [7:0] _GEN_3665 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 8'h0 : _GEN_3646; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3666 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 1'h0 : _GEN_3647; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3667 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_3648; // @[CPU6502Core.scala 215:20 287:16]
  wire [15:0] _GEN_3668 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 16'h0 : _GEN_3649; // @[CPU6502Core.scala 215:20 287:16]
  wire  _GEN_3669 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_9_done : _GEN_3650; // @[CPU6502Core.scala 215:20 282:16]
  wire [2:0] _GEN_3670 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3651; // @[CPU6502Core.scala 215:20 282:16]
  wire [7:0] _GEN_3671 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_a : _GEN_3652; // @[CPU6502Core.scala 215:20 282:16]
  wire [7:0] _GEN_3672 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_x : _GEN_3653; // @[CPU6502Core.scala 215:20 282:16]
  wire [7:0] _GEN_3673 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_y : _GEN_3654; // @[CPU6502Core.scala 215:20 282:16]
  wire [7:0] _GEN_3674 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_sp : _GEN_3655; // @[CPU6502Core.scala 215:20 282:16]
  wire [15:0] _GEN_3675 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_pc : _GEN_3656; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3676 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagC : _GEN_3657; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3677 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagZ : _GEN_3658; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3678 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagI : _GEN_3659; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3679 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagD : _GEN_3660; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3681 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagV : _GEN_3662; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3682 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagN : _GEN_3663; // @[CPU6502Core.scala 215:20 282:16]
  wire [15:0] _GEN_3683 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_15_memAddr : _GEN_3664; // @[CPU6502Core.scala 215:20 282:16]
  wire [7:0] _GEN_3684 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 8'h0 : _GEN_3665; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3685 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 1'h0 : _GEN_3666; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3686 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_memRead : _GEN_3667; // @[CPU6502Core.scala 215:20 282:16]
  wire [15:0] _GEN_3687 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_operand : _GEN_3668; // @[CPU6502Core.scala 215:20 282:16]
  wire  _GEN_3688 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_9_done : _GEN_3669; // @[CPU6502Core.scala 215:20 277:16]
  wire [2:0] _GEN_3689 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_6_nextCycle : _GEN_3670; // @[CPU6502Core.scala 215:20 277:16]
  wire [7:0] _GEN_3690 = 8'hfe == opcode | 8'hde == opcode ? regs_a : _GEN_3671; // @[CPU6502Core.scala 215:20 277:16]
  wire [7:0] _GEN_3691 = 8'hfe == opcode | 8'hde == opcode ? regs_x : _GEN_3672; // @[CPU6502Core.scala 215:20 277:16]
  wire [7:0] _GEN_3692 = 8'hfe == opcode | 8'hde == opcode ? regs_y : _GEN_3673; // @[CPU6502Core.scala 215:20 277:16]
  wire [7:0] _GEN_3693 = 8'hfe == opcode | 8'hde == opcode ? regs_sp : _GEN_3674; // @[CPU6502Core.scala 215:20 277:16]
  wire [15:0] _GEN_3694 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_7_pc : _GEN_3675; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3695 = 8'hfe == opcode | 8'hde == opcode ? regs_flagC : _GEN_3676; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3696 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_13_flagZ : _GEN_3677; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3697 = 8'hfe == opcode | 8'hde == opcode ? regs_flagI : _GEN_3678; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3698 = 8'hfe == opcode | 8'hde == opcode ? regs_flagD : _GEN_3679; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3700 = 8'hfe == opcode | 8'hde == opcode ? regs_flagV : _GEN_3681; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3701 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_13_flagN : _GEN_3682; // @[CPU6502Core.scala 215:20 277:16]
  wire [15:0] _GEN_3702 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_13_memAddr : _GEN_3683; // @[CPU6502Core.scala 215:20 277:16]
  wire [7:0] _GEN_3703 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_14_memData : _GEN_3684; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3704 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_9_done : _GEN_3685; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3705 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_8_memRead : _GEN_3686; // @[CPU6502Core.scala 215:20 277:16]
  wire [15:0] _GEN_3706 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_14_operand : _GEN_3687; // @[CPU6502Core.scala 215:20 277:16]
  wire  _GEN_3707 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_9_done : _GEN_3688; // @[CPU6502Core.scala 215:20 272:16]
  wire [2:0] _GEN_3708 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_6_nextCycle : _GEN_3689; // @[CPU6502Core.scala 215:20 272:16]
  wire [7:0] _GEN_3709 = 8'hee == opcode | 8'hce == opcode ? regs_a : _GEN_3690; // @[CPU6502Core.scala 215:20 272:16]
  wire [7:0] _GEN_3710 = 8'hee == opcode | 8'hce == opcode ? regs_x : _GEN_3691; // @[CPU6502Core.scala 215:20 272:16]
  wire [7:0] _GEN_3711 = 8'hee == opcode | 8'hce == opcode ? regs_y : _GEN_3692; // @[CPU6502Core.scala 215:20 272:16]
  wire [7:0] _GEN_3712 = 8'hee == opcode | 8'hce == opcode ? regs_sp : _GEN_3693; // @[CPU6502Core.scala 215:20 272:16]
  wire [15:0] _GEN_3713 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_7_pc : _GEN_3694; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3714 = 8'hee == opcode | 8'hce == opcode ? regs_flagC : _GEN_3695; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3715 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_12_flagZ : _GEN_3696; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3716 = 8'hee == opcode | 8'hce == opcode ? regs_flagI : _GEN_3697; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3717 = 8'hee == opcode | 8'hce == opcode ? regs_flagD : _GEN_3698; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3719 = 8'hee == opcode | 8'hce == opcode ? regs_flagV : _GEN_3700; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3720 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_12_flagN : _GEN_3701; // @[CPU6502Core.scala 215:20 272:16]
  wire [15:0] _GEN_3721 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_13_memAddr : _GEN_3702; // @[CPU6502Core.scala 215:20 272:16]
  wire [7:0] _GEN_3722 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_13_memData : _GEN_3703; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3723 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_9_done : _GEN_3704; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3724 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_8_memRead : _GEN_3705; // @[CPU6502Core.scala 215:20 272:16]
  wire [15:0] _GEN_3725 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_8_operand : _GEN_3706; // @[CPU6502Core.scala 215:20 272:16]
  wire  _GEN_3726 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_8_done : _GEN_3707; // @[CPU6502Core.scala 215:20 267:16]
  wire [2:0] _GEN_3727 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_6_nextCycle : _GEN_3708; // @[CPU6502Core.scala 215:20 267:16]
  wire [7:0] _GEN_3728 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_a : _GEN_3709; // @[CPU6502Core.scala 215:20 267:16]
  wire [7:0] _GEN_3729 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_x : _GEN_3710; // @[CPU6502Core.scala 215:20 267:16]
  wire [7:0] _GEN_3730 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_y : _GEN_3711; // @[CPU6502Core.scala 215:20 267:16]
  wire [7:0] _GEN_3731 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_sp : _GEN_3712; // @[CPU6502Core.scala 215:20 267:16]
  wire [15:0] _GEN_3732 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_5_pc : _GEN_3713; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3733 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagC : _GEN_3714; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3734 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_11_flagZ : _GEN_3715; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3735 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagI : _GEN_3716; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3736 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagD : _GEN_3717; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3738 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagV : _GEN_3719; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3739 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_11_flagN : _GEN_3720; // @[CPU6502Core.scala 215:20 267:16]
  wire [15:0] _GEN_3740 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_11_memAddr : _GEN_3721; // @[CPU6502Core.scala 215:20 267:16]
  wire [7:0] _GEN_3741 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_12_memData : _GEN_3722; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3742 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_8_done : _GEN_3723; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3743 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_6_memRead : _GEN_3724; // @[CPU6502Core.scala 215:20 267:16]
  wire [15:0] _GEN_3744 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_7_operand : _GEN_3725; // @[CPU6502Core.scala 215:20 267:16]
  wire  _GEN_3745 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_8_done : _GEN_3726; // @[CPU6502Core.scala 215:20 262:16]
  wire [2:0] _GEN_3746 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_nextCycle : _GEN_3727; // @[CPU6502Core.scala 215:20 262:16]
  wire [7:0] _GEN_3747 = 8'he6 == opcode | 8'hc6 == opcode ? regs_a : _GEN_3728; // @[CPU6502Core.scala 215:20 262:16]
  wire [7:0] _GEN_3748 = 8'he6 == opcode | 8'hc6 == opcode ? regs_x : _GEN_3729; // @[CPU6502Core.scala 215:20 262:16]
  wire [7:0] _GEN_3749 = 8'he6 == opcode | 8'hc6 == opcode ? regs_y : _GEN_3730; // @[CPU6502Core.scala 215:20 262:16]
  wire [7:0] _GEN_3750 = 8'he6 == opcode | 8'hc6 == opcode ? regs_sp : _GEN_3731; // @[CPU6502Core.scala 215:20 262:16]
  wire [15:0] _GEN_3751 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_pc : _GEN_3732; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3752 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagC : _GEN_3733; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3753 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_10_flagZ : _GEN_3734; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3754 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagI : _GEN_3735; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3755 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagD : _GEN_3736; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3757 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagV : _GEN_3738; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3758 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_10_flagN : _GEN_3739; // @[CPU6502Core.scala 215:20 262:16]
  wire [15:0] _GEN_3759 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_memAddr : _GEN_3740; // @[CPU6502Core.scala 215:20 262:16]
  wire [7:0] _GEN_3760 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_memData : _GEN_3741; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3761 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_8_done : _GEN_3742; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3762 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memRead : _GEN_3743; // @[CPU6502Core.scala 215:20 262:16]
  wire [15:0] _GEN_3763 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_operand : _GEN_3744; // @[CPU6502Core.scala 215:20 262:16]
  wire  _GEN_3764 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_done : _GEN_3745; // @[CPU6502Core.scala 215:20 257:16]
  wire [2:0] _GEN_3765 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3746; // @[CPU6502Core.scala 215:20 257:16]
  wire [7:0] _GEN_3766 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_a : _GEN_3747; // @[CPU6502Core.scala 215:20 257:16]
  wire [7:0] _GEN_3767 = 8'h71 == opcode | 8'hf1 == opcode ? regs_x : _GEN_3748; // @[CPU6502Core.scala 215:20 257:16]
  wire [7:0] _GEN_3768 = 8'h71 == opcode | 8'hf1 == opcode ? regs_y : _GEN_3749; // @[CPU6502Core.scala 215:20 257:16]
  wire [7:0] _GEN_3769 = 8'h71 == opcode | 8'hf1 == opcode ? regs_sp : _GEN_3750; // @[CPU6502Core.scala 215:20 257:16]
  wire [15:0] _GEN_3770 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3751; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3771 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagC : _GEN_3752; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3772 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_3753; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3773 = 8'h71 == opcode | 8'hf1 == opcode ? regs_flagI : _GEN_3754; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3774 = 8'h71 == opcode | 8'hf1 == opcode ? regs_flagD : _GEN_3755; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3776 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagV : _GEN_3757; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3777 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagN : _GEN_3758; // @[CPU6502Core.scala 215:20 257:16]
  wire [15:0] _GEN_3778 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_memAddr : _GEN_3759; // @[CPU6502Core.scala 215:20 257:16]
  wire [7:0] _GEN_3779 = 8'h71 == opcode | 8'hf1 == opcode ? 8'h0 : _GEN_3760; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3780 = 8'h71 == opcode | 8'hf1 == opcode ? 1'h0 : _GEN_3761; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3781 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_memRead : _GEN_3762; // @[CPU6502Core.scala 215:20 257:16]
  wire [15:0] _GEN_3782 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_10_operand : _GEN_3763; // @[CPU6502Core.scala 215:20 257:16]
  wire  _GEN_3783 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_done : _GEN_3764; // @[CPU6502Core.scala 215:20 252:16]
  wire [2:0] _GEN_3784 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3765; // @[CPU6502Core.scala 215:20 252:16]
  wire [7:0] _GEN_3785 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_a : _GEN_3766; // @[CPU6502Core.scala 215:20 252:16]
  wire [7:0] _GEN_3786 = 8'h61 == opcode | 8'he1 == opcode ? regs_x : _GEN_3767; // @[CPU6502Core.scala 215:20 252:16]
  wire [7:0] _GEN_3787 = 8'h61 == opcode | 8'he1 == opcode ? regs_y : _GEN_3768; // @[CPU6502Core.scala 215:20 252:16]
  wire [7:0] _GEN_3788 = 8'h61 == opcode | 8'he1 == opcode ? regs_sp : _GEN_3769; // @[CPU6502Core.scala 215:20 252:16]
  wire [15:0] _GEN_3789 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3770; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3790 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagC : _GEN_3771; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3791 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_3772; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3792 = 8'h61 == opcode | 8'he1 == opcode ? regs_flagI : _GEN_3773; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3793 = 8'h61 == opcode | 8'he1 == opcode ? regs_flagD : _GEN_3774; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3795 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagV : _GEN_3776; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3796 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagN : _GEN_3777; // @[CPU6502Core.scala 215:20 252:16]
  wire [15:0] _GEN_3797 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_memAddr : _GEN_3778; // @[CPU6502Core.scala 215:20 252:16]
  wire [7:0] _GEN_3798 = 8'h61 == opcode | 8'he1 == opcode ? 8'h0 : _GEN_3779; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3799 = 8'h61 == opcode | 8'he1 == opcode ? 1'h0 : _GEN_3780; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3800 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_memRead : _GEN_3781; // @[CPU6502Core.scala 215:20 252:16]
  wire [15:0] _GEN_3801 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_operand : _GEN_3782; // @[CPU6502Core.scala 215:20 252:16]
  wire  _GEN_3802 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_done : _GEN_3783; // @[CPU6502Core.scala 215:20 247:16]
  wire [2:0] _GEN_3803 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_6_nextCycle : _GEN_3784; // @[CPU6502Core.scala 215:20 247:16]
  wire [7:0] _GEN_3804 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_a : _GEN_3785; // @[CPU6502Core.scala 215:20 247:16]
  wire [7:0] _GEN_3805 = 8'h6d == opcode | 8'hed == opcode ? regs_x : _GEN_3786; // @[CPU6502Core.scala 215:20 247:16]
  wire [7:0] _GEN_3806 = 8'h6d == opcode | 8'hed == opcode ? regs_y : _GEN_3787; // @[CPU6502Core.scala 215:20 247:16]
  wire [7:0] _GEN_3807 = 8'h6d == opcode | 8'hed == opcode ? regs_sp : _GEN_3788; // @[CPU6502Core.scala 215:20 247:16]
  wire [15:0] _GEN_3808 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_pc : _GEN_3789; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3809 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagC : _GEN_3790; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3810 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagZ : _GEN_3791; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3811 = 8'h6d == opcode | 8'hed == opcode ? regs_flagI : _GEN_3792; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3812 = 8'h6d == opcode | 8'hed == opcode ? regs_flagD : _GEN_3793; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3814 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagV : _GEN_3795; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3815 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagN : _GEN_3796; // @[CPU6502Core.scala 215:20 247:16]
  wire [15:0] _GEN_3816 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_memAddr : _GEN_3797; // @[CPU6502Core.scala 215:20 247:16]
  wire [7:0] _GEN_3817 = 8'h6d == opcode | 8'hed == opcode ? 8'h0 : _GEN_3798; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3818 = 8'h6d == opcode | 8'hed == opcode ? 1'h0 : _GEN_3799; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3819 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_memRead : _GEN_3800; // @[CPU6502Core.scala 215:20 247:16]
  wire [15:0] _GEN_3820 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_operand : _GEN_3801; // @[CPU6502Core.scala 215:20 247:16]
  wire  _GEN_3821 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_done : _GEN_3802; // @[CPU6502Core.scala 215:20 242:16]
  wire [2:0] _GEN_3822 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3803; // @[CPU6502Core.scala 215:20 242:16]
  wire [7:0] _GEN_3823 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_a : _GEN_3804; // @[CPU6502Core.scala 215:20 242:16]
  wire [7:0] _GEN_3824 = 8'h75 == opcode | 8'hf5 == opcode ? regs_x : _GEN_3805; // @[CPU6502Core.scala 215:20 242:16]
  wire [7:0] _GEN_3825 = 8'h75 == opcode | 8'hf5 == opcode ? regs_y : _GEN_3806; // @[CPU6502Core.scala 215:20 242:16]
  wire [7:0] _GEN_3826 = 8'h75 == opcode | 8'hf5 == opcode ? regs_sp : _GEN_3807; // @[CPU6502Core.scala 215:20 242:16]
  wire [15:0] _GEN_3827 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3808; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3828 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagC : _GEN_3809; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3829 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_3810; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3830 = 8'h75 == opcode | 8'hf5 == opcode ? regs_flagI : _GEN_3811; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3831 = 8'h75 == opcode | 8'hf5 == opcode ? regs_flagD : _GEN_3812; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3833 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagV : _GEN_3814; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3834 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagN : _GEN_3815; // @[CPU6502Core.scala 215:20 242:16]
  wire [15:0] _GEN_3835 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_memAddr : _GEN_3816; // @[CPU6502Core.scala 215:20 242:16]
  wire [7:0] _GEN_3836 = 8'h75 == opcode | 8'hf5 == opcode ? 8'h0 : _GEN_3817; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3837 = 8'h75 == opcode | 8'hf5 == opcode ? 1'h0 : _GEN_3818; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3838 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_memRead : _GEN_3819; // @[CPU6502Core.scala 215:20 242:16]
  wire [15:0] _GEN_3839 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_7_operand : _GEN_3820; // @[CPU6502Core.scala 215:20 242:16]
  wire  _GEN_3840 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_done : _GEN_3821; // @[CPU6502Core.scala 215:20 237:16]
  wire [2:0] _GEN_3841 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3822; // @[CPU6502Core.scala 215:20 237:16]
  wire [7:0] _GEN_3842 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_a : _GEN_3823; // @[CPU6502Core.scala 215:20 237:16]
  wire [7:0] _GEN_3843 = 8'h65 == opcode | 8'he5 == opcode ? regs_x : _GEN_3824; // @[CPU6502Core.scala 215:20 237:16]
  wire [7:0] _GEN_3844 = 8'h65 == opcode | 8'he5 == opcode ? regs_y : _GEN_3825; // @[CPU6502Core.scala 215:20 237:16]
  wire [7:0] _GEN_3845 = 8'h65 == opcode | 8'he5 == opcode ? regs_sp : _GEN_3826; // @[CPU6502Core.scala 215:20 237:16]
  wire [15:0] _GEN_3846 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3827; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3847 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagC : _GEN_3828; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3848 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_3829; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3849 = 8'h65 == opcode | 8'he5 == opcode ? regs_flagI : _GEN_3830; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3850 = 8'h65 == opcode | 8'he5 == opcode ? regs_flagD : _GEN_3831; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3852 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagV : _GEN_3833; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3853 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagN : _GEN_3834; // @[CPU6502Core.scala 215:20 237:16]
  wire [15:0] _GEN_3854 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_memAddr : _GEN_3835; // @[CPU6502Core.scala 215:20 237:16]
  wire [7:0] _GEN_3855 = 8'h65 == opcode | 8'he5 == opcode ? 8'h0 : _GEN_3836; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3856 = 8'h65 == opcode | 8'he5 == opcode ? 1'h0 : _GEN_3837; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3857 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_memRead : _GEN_3838; // @[CPU6502Core.scala 215:20 237:16]
  wire [15:0] _GEN_3858 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_operand : _GEN_3839; // @[CPU6502Core.scala 215:20 237:16]
  wire  _GEN_3859 = 8'he9 == opcode | _GEN_3840; // @[CPU6502Core.scala 215:20 233:27]
  wire [2:0] _GEN_3860 = 8'he9 == opcode ? 3'h0 : _GEN_3841; // @[CPU6502Core.scala 215:20 233:27]
  wire [7:0] _GEN_3861 = 8'he9 == opcode ? execResult_result_newRegs_4_a : _GEN_3842; // @[CPU6502Core.scala 215:20 233:27]
  wire [7:0] _GEN_3862 = 8'he9 == opcode ? regs_x : _GEN_3843; // @[CPU6502Core.scala 215:20 233:27]
  wire [7:0] _GEN_3863 = 8'he9 == opcode ? regs_y : _GEN_3844; // @[CPU6502Core.scala 215:20 233:27]
  wire [7:0] _GEN_3864 = 8'he9 == opcode ? regs_sp : _GEN_3845; // @[CPU6502Core.scala 215:20 233:27]
  wire [15:0] _GEN_3865 = 8'he9 == opcode ? _regs_pc_T_1 : _GEN_3846; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3866 = 8'he9 == opcode ? execResult_result_newRegs_4_flagC : _GEN_3847; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3867 = 8'he9 == opcode ? execResult_result_newRegs_4_flagZ : _GEN_3848; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3868 = 8'he9 == opcode ? regs_flagI : _GEN_3849; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3869 = 8'he9 == opcode ? regs_flagD : _GEN_3850; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3871 = 8'he9 == opcode ? execResult_result_newRegs_4_flagV : _GEN_3852; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3872 = 8'he9 == opcode ? execResult_result_newRegs_4_flagN : _GEN_3853; // @[CPU6502Core.scala 215:20 233:27]
  wire [15:0] _GEN_3873 = 8'he9 == opcode ? regs_pc : _GEN_3854; // @[CPU6502Core.scala 215:20 233:27]
  wire [7:0] _GEN_3874 = 8'he9 == opcode ? 8'h0 : _GEN_3855; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3875 = 8'he9 == opcode ? 1'h0 : _GEN_3856; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3876 = 8'he9 == opcode | _GEN_3857; // @[CPU6502Core.scala 215:20 233:27]
  wire [15:0] _GEN_3877 = 8'he9 == opcode ? 16'h0 : _GEN_3858; // @[CPU6502Core.scala 215:20 233:27]
  wire  _GEN_3878 = 8'h69 == opcode | _GEN_3859; // @[CPU6502Core.scala 215:20 232:27]
  wire [2:0] _GEN_3879 = 8'h69 == opcode ? 3'h0 : _GEN_3860; // @[CPU6502Core.scala 215:20 232:27]
  wire [7:0] _GEN_3880 = 8'h69 == opcode ? execResult_result_newRegs_3_a : _GEN_3861; // @[CPU6502Core.scala 215:20 232:27]
  wire [7:0] _GEN_3881 = 8'h69 == opcode ? regs_x : _GEN_3862; // @[CPU6502Core.scala 215:20 232:27]
  wire [7:0] _GEN_3882 = 8'h69 == opcode ? regs_y : _GEN_3863; // @[CPU6502Core.scala 215:20 232:27]
  wire [7:0] _GEN_3883 = 8'h69 == opcode ? regs_sp : _GEN_3864; // @[CPU6502Core.scala 215:20 232:27]
  wire [15:0] _GEN_3884 = 8'h69 == opcode ? _regs_pc_T_1 : _GEN_3865; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3885 = 8'h69 == opcode ? execResult_result_newRegs_3_flagC : _GEN_3866; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3886 = 8'h69 == opcode ? execResult_result_newRegs_3_flagZ : _GEN_3867; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3887 = 8'h69 == opcode ? regs_flagI : _GEN_3868; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3888 = 8'h69 == opcode ? regs_flagD : _GEN_3869; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3890 = 8'h69 == opcode ? execResult_result_newRegs_3_flagV : _GEN_3871; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3891 = 8'h69 == opcode ? execResult_result_newRegs_3_flagN : _GEN_3872; // @[CPU6502Core.scala 215:20 232:27]
  wire [15:0] _GEN_3892 = 8'h69 == opcode ? regs_pc : _GEN_3873; // @[CPU6502Core.scala 215:20 232:27]
  wire [7:0] _GEN_3893 = 8'h69 == opcode ? 8'h0 : _GEN_3874; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3894 = 8'h69 == opcode ? 1'h0 : _GEN_3875; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3895 = 8'h69 == opcode | _GEN_3876; // @[CPU6502Core.scala 215:20 232:27]
  wire [15:0] _GEN_3896 = 8'h69 == opcode ? 16'h0 : _GEN_3877; // @[CPU6502Core.scala 215:20 232:27]
  wire  _GEN_3897 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode | _GEN_3878; // @[CPU6502Core.scala 215:20 228:16]
  wire [2:0] _GEN_3898 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 3'h0 : _GEN_3879; // @[CPU6502Core.scala 215:20 228:16]
  wire [7:0] _GEN_3899 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_a : _GEN_3880; // @[CPU6502Core.scala 215:20 228:16]
  wire [7:0] _GEN_3900 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_x : _GEN_3881; // @[CPU6502Core.scala 215:20 228:16]
  wire [7:0] _GEN_3901 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_y : _GEN_3882; // @[CPU6502Core.scala 215:20 228:16]
  wire [7:0] _GEN_3902 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_sp : _GEN_3883; // @[CPU6502Core.scala 215:20 228:16]
  wire [15:0] _GEN_3903 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_pc : _GEN_3884; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3904 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagC : _GEN_3885; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3905 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagZ : _GEN_3886; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3906 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagI : _GEN_3887; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3907 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagD : _GEN_3888; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3909 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagV : _GEN_3890; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3910 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagN : _GEN_3891; // @[CPU6502Core.scala 215:20 228:16]
  wire [15:0] _GEN_3911 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_3892; // @[CPU6502Core.scala 215:20 228:16]
  wire [7:0] _GEN_3912 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 8'h0 : _GEN_3893; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3913 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_3894; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3914 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_3895; // @[CPU6502Core.scala 215:20 228:16]
  wire [15:0] _GEN_3915 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_3896; // @[CPU6502Core.scala 215:20 228:16]
  wire  _GEN_3916 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode | _GEN_3897; // @[CPU6502Core.scala 215:20 223:16]
  wire [2:0] _GEN_3917 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 3'h0 : _GEN_3898; // @[CPU6502Core.scala 215:20 223:16]
  wire [7:0] _GEN_3918 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_a : _GEN_3899; // @[CPU6502Core.scala 215:20 223:16]
  wire [7:0] _GEN_3919 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_x : _GEN_3900; // @[CPU6502Core.scala 215:20 223:16]
  wire [7:0] _GEN_3920 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_y : _GEN_3901; // @[CPU6502Core.scala 215:20 223:16]
  wire [7:0] _GEN_3921 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_sp : _GEN_3902; // @[CPU6502Core.scala 215:20 223:16]
  wire [15:0] _GEN_3922 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? regs_pc : _GEN_3903; // @[CPU6502Core.scala 215:20 223:16]
  wire  _GEN_3923 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagC : _GEN_3904; // @[CPU6502Core.scala 215:20 223:16]
  wire  _GEN_3924 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagZ : _GEN_3905; // @[CPU6502Core.scala 215:20 223:16]
  wire  _GEN_3925 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagI : _GEN_3906; // @[CPU6502Core.scala 215:20 223:16]
  wire  _GEN_3926 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagD : _GEN_3907; // @[CPU6502Core.scala 215:20 223:16]
  wire  _GEN_3928 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagV : _GEN_3909; // @[CPU6502Core.scala 215:20 223:16]
  wire  _GEN_3929 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagN : _GEN_3910; // @[CPU6502Core.scala 215:20 223:16]
  wire [15:0] _GEN_3930 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_3911; // @[CPU6502Core.scala 215:20 223:16]
  wire [7:0] _GEN_3931 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 8'h0 : _GEN_3912; // @[CPU6502Core.scala 215:20 223:16]
  wire  _GEN_3932 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_3913; // @[CPU6502Core.scala 215:20 223:16]
  wire  _GEN_3933 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_3914; // @[CPU6502Core.scala 215:20 223:16]
  wire [15:0] _GEN_3934 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_3915; // @[CPU6502Core.scala 215:20 223:16]
  wire  execResult_result_1_done = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode | _GEN_3916; // @[CPU6502Core.scala 215:20 218:16]
  wire [2:0] execResult_result_1_nextCycle = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 3'h0 : _GEN_3917; // @[CPU6502Core.scala 215:20 218:16]
  wire [7:0] execResult_result_1_regs_a = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_a : _GEN_3918; // @[CPU6502Core.scala 215:20 218:16]
  wire [7:0] execResult_result_1_regs_x = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_x : _GEN_3919; // @[CPU6502Core.scala 215:20 218:16]
  wire [7:0] execResult_result_1_regs_y = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_y : _GEN_3920; // @[CPU6502Core.scala 215:20 218:16]
  wire [7:0] execResult_result_1_regs_sp = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_sp : _GEN_3921; // @[CPU6502Core.scala 215:20 218:16]
  wire [15:0] execResult_result_1_regs_pc = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_pc : _GEN_3922; // @[CPU6502Core.scala 215:20 218:16]
  wire  execResult_result_1_regs_flagC = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagC : _GEN_3923; // @[CPU6502Core.scala 215:20 218:16]
  wire  execResult_result_1_regs_flagZ = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagZ : _GEN_3924; // @[CPU6502Core.scala 215:20 218:16]
  wire  execResult_result_1_regs_flagI = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagI : _GEN_3925; // @[CPU6502Core.scala 215:20 218:16]
  wire  execResult_result_1_regs_flagD = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagD : _GEN_3926; // @[CPU6502Core.scala 215:20 218:16]
  wire  execResult_result_1_regs_flagV = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagV : _GEN_3928; // @[CPU6502Core.scala 215:20 218:16]
  wire  execResult_result_1_regs_flagN = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagN : _GEN_3929; // @[CPU6502Core.scala 215:20 218:16]
  wire [15:0] execResult_result_1_memAddr = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_3930; // @[CPU6502Core.scala 215:20 218:16]
  wire [7:0] execResult_result_1_memData = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 8'h0 : _GEN_3931; // @[CPU6502Core.scala 215:20 218:16]
  wire  execResult_result_1_memWrite = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_3932; // @[CPU6502Core.scala 215:20 218:16]
  wire  execResult_result_1_memRead = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_3933; // @[CPU6502Core.scala 215:20 218:16]
  wire [15:0] execResult_result_1_operand = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_3934; // @[CPU6502Core.scala 215:20 218:16]
  wire  _GEN_4019 = 3'h2 == state & execResult_result_1_done; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4063 = 3'h1 == state ? 1'h0 : _GEN_4019; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4105 = 3'h0 == state ? 1'h0 : _GEN_4063; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_done = io_reset ? 1'h0 : _GEN_4105; // @[CPU6502Core.scala 56:14 59:18]
  wire [2:0] _GEN_4020 = 3'h2 == state ? execResult_result_1_nextCycle : 3'h0; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [2:0] _GEN_4064 = 3'h1 == state ? 3'h0 : _GEN_4020; // @[CPU6502Core.scala 56:14 66:19]
  wire [2:0] _GEN_4106 = 3'h0 == state ? 3'h0 : _GEN_4064; // @[CPU6502Core.scala 56:14 66:19]
  wire [2:0] execResult_nextCycle = io_reset ? 3'h0 : _GEN_4106; // @[CPU6502Core.scala 56:14 59:18]
  wire [2:0] _GEN_3954 = execResult_done ? 3'h0 : execResult_nextCycle; // @[CPU6502Core.scala 136:19 138:33 139:19]
  wire [2:0] _GEN_3955 = execResult_done ? 3'h1 : state; // @[CPU6502Core.scala 138:33 140:19 25:22]
  wire [7:0] status = {regs_flagN,regs_flagV,2'h2,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_3958 = cycle == 3'h5 ? 3'h6 : 3'h0; // @[CPU6502Core.scala 178:37 182:19 190:19]
  wire [15:0] _GEN_3959 = cycle == 3'h5 ? regs_pc : resetVector; // @[CPU6502Core.scala 178:37 188:21 21:21]
  wire  _GEN_3960 = cycle == 3'h5 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 178:37 21:21 189:24]
  wire [2:0] _GEN_3961 = cycle == 3'h5 ? state : 3'h1; // @[CPU6502Core.scala 178:37 191:19 25:22]
  wire [15:0] _GEN_3962 = cycle == 3'h4 ? 16'hfffa : 16'hfffb; // @[CPU6502Core.scala 172:37 174:24]
  wire [15:0] _GEN_3964 = cycle == 3'h4 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 172:37 176:21 28:24]
  wire [2:0] _GEN_3965 = cycle == 3'h4 ? 3'h5 : _GEN_3958; // @[CPU6502Core.scala 172:37 177:19]
  wire [15:0] _GEN_3966 = cycle == 3'h4 ? regs_pc : _GEN_3959; // @[CPU6502Core.scala 172:37 21:21]
  wire  _GEN_3967 = cycle == 3'h4 ? regs_flagI : _GEN_3960; // @[CPU6502Core.scala 172:37 21:21]
  wire [2:0] _GEN_3968 = cycle == 3'h4 ? state : _GEN_3961; // @[CPU6502Core.scala 172:37 25:22]
  wire [15:0] _GEN_3969 = _T_7 ? execResult_result_result_46_memAddr : _GEN_3962; // @[CPU6502Core.scala 163:37 167:24]
  wire [7:0] _GEN_3970 = _T_7 ? status : 8'h0; // @[CPU6502Core.scala 163:37 168:27 50:17]
  wire [7:0] _GEN_3972 = _T_7 ? execResult_result_newRegs_45_sp : regs_sp; // @[CPU6502Core.scala 163:37 170:21 21:21]
  wire [2:0] _GEN_3973 = _T_7 ? 3'h4 : _GEN_3965; // @[CPU6502Core.scala 163:37 171:19]
  wire  _GEN_3974 = _T_7 ? 1'h0 : 1'h1; // @[CPU6502Core.scala 163:37 52:17]
  wire [15:0] _GEN_3975 = _T_7 ? operand : _GEN_3964; // @[CPU6502Core.scala 163:37 28:24]
  wire [15:0] _GEN_3976 = _T_7 ? regs_pc : _GEN_3966; // @[CPU6502Core.scala 163:37 21:21]
  wire  _GEN_3977 = _T_7 ? regs_flagI : _GEN_3967; // @[CPU6502Core.scala 163:37 21:21]
  wire [2:0] _GEN_3978 = _T_7 ? state : _GEN_3968; // @[CPU6502Core.scala 163:37 25:22]
  wire [15:0] _GEN_3979 = _T_6 ? execResult_result_result_46_memAddr : _GEN_3969; // @[CPU6502Core.scala 156:37 158:24]
  wire [7:0] _GEN_3980 = _T_6 ? regs_pc[7:0] : _GEN_3970; // @[CPU6502Core.scala 156:37 159:27]
  wire  _GEN_3981 = _T_6 | _T_7; // @[CPU6502Core.scala 156:37 160:25]
  wire [7:0] _GEN_3982 = _T_6 ? execResult_result_newRegs_45_sp : _GEN_3972; // @[CPU6502Core.scala 156:37 161:21]
  wire [2:0] _GEN_3983 = _T_6 ? 3'h3 : _GEN_3973; // @[CPU6502Core.scala 156:37 162:19]
  wire  _GEN_3984 = _T_6 ? 1'h0 : _GEN_3974; // @[CPU6502Core.scala 156:37 52:17]
  wire [15:0] _GEN_3985 = _T_6 ? operand : _GEN_3975; // @[CPU6502Core.scala 156:37 28:24]
  wire [15:0] _GEN_3986 = _T_6 ? regs_pc : _GEN_3976; // @[CPU6502Core.scala 156:37 21:21]
  wire  _GEN_3987 = _T_6 ? regs_flagI : _GEN_3977; // @[CPU6502Core.scala 156:37 21:21]
  wire [2:0] _GEN_3988 = _T_6 ? state : _GEN_3978; // @[CPU6502Core.scala 156:37 25:22]
  wire [15:0] _GEN_3989 = _T_5 ? execResult_result_result_46_memAddr : _GEN_3979; // @[CPU6502Core.scala 149:37 151:24]
  wire [7:0] _GEN_3990 = _T_5 ? regs_pc[15:8] : _GEN_3980; // @[CPU6502Core.scala 149:37 152:27]
  wire  _GEN_3991 = _T_5 | _GEN_3981; // @[CPU6502Core.scala 149:37 153:25]
  wire [7:0] _GEN_3992 = _T_5 ? execResult_result_newRegs_45_sp : _GEN_3982; // @[CPU6502Core.scala 149:37 154:21]
  wire [2:0] _GEN_3993 = _T_5 ? 3'h2 : _GEN_3983; // @[CPU6502Core.scala 149:37 155:19]
  wire  _GEN_3994 = _T_5 ? 1'h0 : _GEN_3984; // @[CPU6502Core.scala 149:37 52:17]
  wire [15:0] _GEN_3995 = _T_5 ? operand : _GEN_3985; // @[CPU6502Core.scala 149:37 28:24]
  wire [15:0] _GEN_3996 = _T_5 ? regs_pc : _GEN_3986; // @[CPU6502Core.scala 149:37 21:21]
  wire  _GEN_3997 = _T_5 ? regs_flagI : _GEN_3987; // @[CPU6502Core.scala 149:37 21:21]
  wire [2:0] _GEN_3998 = _T_5 ? state : _GEN_3988; // @[CPU6502Core.scala 149:37 25:22]
  wire [2:0] _GEN_3999 = _T_4 ? 3'h1 : _GEN_3993; // @[CPU6502Core.scala 146:31 148:19]
  wire [15:0] _GEN_4000 = _T_4 ? regs_pc : _GEN_3989; // @[CPU6502Core.scala 146:31 49:17]
  wire [7:0] _GEN_4001 = _T_4 ? 8'h0 : _GEN_3990; // @[CPU6502Core.scala 146:31 50:17]
  wire  _GEN_4002 = _T_4 ? 1'h0 : _GEN_3991; // @[CPU6502Core.scala 146:31 51:17]
  wire [7:0] _GEN_4003 = _T_4 ? regs_sp : _GEN_3992; // @[CPU6502Core.scala 146:31 21:21]
  wire  _GEN_4004 = _T_4 ? 1'h0 : _GEN_3994; // @[CPU6502Core.scala 146:31 52:17]
  wire [15:0] _GEN_4005 = _T_4 ? operand : _GEN_3995; // @[CPU6502Core.scala 146:31 28:24]
  wire [15:0] _GEN_4006 = _T_4 ? regs_pc : _GEN_3996; // @[CPU6502Core.scala 146:31 21:21]
  wire  _GEN_4007 = _T_4 ? regs_flagI : _GEN_3997; // @[CPU6502Core.scala 146:31 21:21]
  wire [2:0] _GEN_4008 = _T_4 ? state : _GEN_3998; // @[CPU6502Core.scala 146:31 25:22]
  wire [2:0] _GEN_4009 = 3'h3 == state ? _GEN_3999 : cycle; // @[CPU6502Core.scala 66:19 29:24]
  wire [15:0] _GEN_4010 = 3'h3 == state ? _GEN_4000 : regs_pc; // @[CPU6502Core.scala 49:17 66:19]
  wire [7:0] _GEN_4011 = 3'h3 == state ? _GEN_4001 : 8'h0; // @[CPU6502Core.scala 50:17 66:19]
  wire  _GEN_4012 = 3'h3 == state & _GEN_4002; // @[CPU6502Core.scala 51:17 66:19]
  wire [7:0] _GEN_4013 = 3'h3 == state ? _GEN_4003 : regs_sp; // @[CPU6502Core.scala 66:19 21:21]
  wire  _GEN_4014 = 3'h3 == state & _GEN_4004; // @[CPU6502Core.scala 52:17 66:19]
  wire [15:0] _GEN_4015 = 3'h3 == state ? _GEN_4005 : operand; // @[CPU6502Core.scala 66:19 28:24]
  wire [15:0] _GEN_4016 = 3'h3 == state ? _GEN_4006 : regs_pc; // @[CPU6502Core.scala 66:19 21:21]
  wire  _GEN_4017 = 3'h3 == state ? _GEN_4007 : regs_flagI; // @[CPU6502Core.scala 66:19 21:21]
  wire [2:0] _GEN_4018 = 3'h3 == state ? _GEN_4008 : state; // @[CPU6502Core.scala 66:19 25:22]
  wire [7:0] _GEN_4021 = 3'h2 == state ? execResult_result_1_regs_a : regs_a; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [7:0] _GEN_4022 = 3'h2 == state ? execResult_result_1_regs_x : regs_x; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [7:0] _GEN_4023 = 3'h2 == state ? execResult_result_1_regs_y : regs_y; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [7:0] _GEN_4024 = 3'h2 == state ? execResult_result_1_regs_sp : regs_sp; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [15:0] _GEN_4025 = 3'h2 == state ? execResult_result_1_regs_pc : regs_pc; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4026 = 3'h2 == state ? execResult_result_1_regs_flagC : regs_flagC; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4027 = 3'h2 == state ? execResult_result_1_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4028 = 3'h2 == state ? execResult_result_1_regs_flagI : regs_flagI; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4029 = 3'h2 == state ? execResult_result_1_regs_flagD : regs_flagD; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4031 = 3'h2 == state ? execResult_result_1_regs_flagV : regs_flagV; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4032 = 3'h2 == state ? execResult_result_1_regs_flagN : regs_flagN; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [15:0] _GEN_4033 = 3'h2 == state ? execResult_result_1_memAddr : 16'h0; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [7:0] _GEN_4034 = 3'h2 == state ? execResult_result_1_memData : 8'h0; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4035 = 3'h2 == state & execResult_result_1_memWrite; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire  _GEN_4036 = 3'h2 == state & execResult_result_1_memRead; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [15:0] _GEN_4037 = 3'h2 == state ? execResult_result_1_operand : operand; // @[CPU6502Core.scala 66:19 126:22 56:14]
  wire [15:0] _GEN_4077 = 3'h1 == state ? 16'h0 : _GEN_4033; // @[CPU6502Core.scala 56:14 66:19]
  wire [15:0] _GEN_4119 = 3'h0 == state ? 16'h0 : _GEN_4077; // @[CPU6502Core.scala 56:14 66:19]
  wire [15:0] execResult_memAddr = io_reset ? 16'h0 : _GEN_4119; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4038 = 3'h2 == state ? execResult_memAddr : _GEN_4010; // @[CPU6502Core.scala 66:19 129:25]
  wire [7:0] _GEN_4078 = 3'h1 == state ? 8'h0 : _GEN_4034; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] _GEN_4120 = 3'h0 == state ? 8'h0 : _GEN_4078; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] execResult_memData = io_reset ? 8'h0 : _GEN_4120; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4039 = 3'h2 == state ? execResult_memData : _GEN_4011; // @[CPU6502Core.scala 66:19 130:25]
  wire  _GEN_4079 = 3'h1 == state ? 1'h0 : _GEN_4035; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4121 = 3'h0 == state ? 1'h0 : _GEN_4079; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_memWrite = io_reset ? 1'h0 : _GEN_4121; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4040 = 3'h2 == state ? execResult_memWrite : _GEN_4012; // @[CPU6502Core.scala 66:19 131:25]
  wire  _GEN_4080 = 3'h1 == state ? 1'h0 : _GEN_4036; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4122 = 3'h0 == state ? 1'h0 : _GEN_4080; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_memRead = io_reset ? 1'h0 : _GEN_4122; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4041 = 3'h2 == state ? execResult_memRead : _GEN_4014; // @[CPU6502Core.scala 66:19 132:25]
  wire [7:0] _GEN_4065 = 3'h1 == state ? regs_a : _GEN_4021; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] _GEN_4107 = 3'h0 == state ? regs_a : _GEN_4065; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] execResult_regs_a = io_reset ? regs_a : _GEN_4107; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4042 = 3'h2 == state ? execResult_regs_a : regs_a; // @[CPU6502Core.scala 134:19 66:19 21:21]
  wire [7:0] _GEN_4066 = 3'h1 == state ? regs_x : _GEN_4022; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] _GEN_4108 = 3'h0 == state ? regs_x : _GEN_4066; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] execResult_regs_x = io_reset ? regs_x : _GEN_4108; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4043 = 3'h2 == state ? execResult_regs_x : regs_x; // @[CPU6502Core.scala 134:19 66:19 21:21]
  wire [7:0] _GEN_4067 = 3'h1 == state ? regs_y : _GEN_4023; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] _GEN_4109 = 3'h0 == state ? regs_y : _GEN_4067; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] execResult_regs_y = io_reset ? regs_y : _GEN_4109; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4044 = 3'h2 == state ? execResult_regs_y : regs_y; // @[CPU6502Core.scala 134:19 66:19 21:21]
  wire [7:0] _GEN_4068 = 3'h1 == state ? regs_sp : _GEN_4024; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] _GEN_4110 = 3'h0 == state ? regs_sp : _GEN_4068; // @[CPU6502Core.scala 56:14 66:19]
  wire [7:0] execResult_regs_sp = io_reset ? regs_sp : _GEN_4110; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4045 = 3'h2 == state ? execResult_regs_sp : _GEN_4013; // @[CPU6502Core.scala 134:19 66:19]
  wire [15:0] _GEN_4069 = 3'h1 == state ? regs_pc : _GEN_4025; // @[CPU6502Core.scala 56:14 66:19]
  wire [15:0] _GEN_4111 = 3'h0 == state ? regs_pc : _GEN_4069; // @[CPU6502Core.scala 56:14 66:19]
  wire [15:0] execResult_regs_pc = io_reset ? regs_pc : _GEN_4111; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4046 = 3'h2 == state ? execResult_regs_pc : _GEN_4016; // @[CPU6502Core.scala 134:19 66:19]
  wire  _GEN_4070 = 3'h1 == state ? regs_flagC : _GEN_4026; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4112 = 3'h0 == state ? regs_flagC : _GEN_4070; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_regs_flagC = io_reset ? regs_flagC : _GEN_4112; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4047 = 3'h2 == state ? execResult_regs_flagC : regs_flagC; // @[CPU6502Core.scala 134:19 66:19 21:21]
  wire  _GEN_4071 = 3'h1 == state ? regs_flagZ : _GEN_4027; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4113 = 3'h0 == state ? regs_flagZ : _GEN_4071; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_regs_flagZ = io_reset ? regs_flagZ : _GEN_4113; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4048 = 3'h2 == state ? execResult_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 134:19 66:19 21:21]
  wire  _GEN_4072 = 3'h1 == state ? regs_flagI : _GEN_4028; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4114 = 3'h0 == state ? regs_flagI : _GEN_4072; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_regs_flagI = io_reset ? regs_flagI : _GEN_4114; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4049 = 3'h2 == state ? execResult_regs_flagI : _GEN_4017; // @[CPU6502Core.scala 134:19 66:19]
  wire  _GEN_4073 = 3'h1 == state ? regs_flagD : _GEN_4029; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4115 = 3'h0 == state ? regs_flagD : _GEN_4073; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_regs_flagD = io_reset ? regs_flagD : _GEN_4115; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4050 = 3'h2 == state ? execResult_regs_flagD : regs_flagD; // @[CPU6502Core.scala 134:19 66:19 21:21]
  wire  _GEN_4075 = 3'h1 == state ? regs_flagV : _GEN_4031; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4117 = 3'h0 == state ? regs_flagV : _GEN_4075; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_regs_flagV = io_reset ? regs_flagV : _GEN_4117; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4052 = 3'h2 == state ? execResult_regs_flagV : regs_flagV; // @[CPU6502Core.scala 134:19 66:19 21:21]
  wire  _GEN_4076 = 3'h1 == state ? regs_flagN : _GEN_4032; // @[CPU6502Core.scala 56:14 66:19]
  wire  _GEN_4118 = 3'h0 == state ? regs_flagN : _GEN_4076; // @[CPU6502Core.scala 56:14 66:19]
  wire  execResult_regs_flagN = io_reset ? regs_flagN : _GEN_4118; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4053 = 3'h2 == state ? execResult_regs_flagN : regs_flagN; // @[CPU6502Core.scala 134:19 66:19 21:21]
  wire [15:0] _GEN_4081 = 3'h1 == state ? operand : _GEN_4037; // @[CPU6502Core.scala 56:14 66:19]
  wire [15:0] _GEN_4123 = 3'h0 == state ? operand : _GEN_4081; // @[CPU6502Core.scala 56:14 66:19]
  wire [15:0] execResult_operand = io_reset ? operand : _GEN_4123; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4054 = 3'h2 == state ? execResult_operand : _GEN_4015; // @[CPU6502Core.scala 135:19 66:19]
  wire [2:0] _GEN_4055 = 3'h2 == state ? _GEN_3954 : _GEN_4009; // @[CPU6502Core.scala 66:19]
  wire [2:0] _GEN_4056 = 3'h2 == state ? _GEN_3955 : _GEN_4018; // @[CPU6502Core.scala 66:19]
  wire [15:0] _GEN_4059 = 3'h1 == state ? regs_pc : _GEN_4038; // @[CPU6502Core.scala 66:19]
  wire  _GEN_4060 = 3'h1 == state ? _GEN_35 : _GEN_4041; // @[CPU6502Core.scala 66:19]
  wire [7:0] _GEN_4082 = 3'h1 == state ? 8'h0 : _GEN_4039; // @[CPU6502Core.scala 50:17 66:19]
  wire  _GEN_4083 = 3'h1 == state ? 1'h0 : _GEN_4040; // @[CPU6502Core.scala 51:17 66:19]
  wire [15:0] _GEN_4096 = 3'h0 == state ? _GEN_24 : _GEN_4059; // @[CPU6502Core.scala 66:19]
  wire  _GEN_4097 = 3'h0 == state | _GEN_4060; // @[CPU6502Core.scala 66:19]
  wire [7:0] _GEN_4124 = 3'h0 == state ? 8'h0 : _GEN_4082; // @[CPU6502Core.scala 50:17 66:19]
  wire  _GEN_4125 = 3'h0 == state ? 1'h0 : _GEN_4083; // @[CPU6502Core.scala 51:17 66:19]
  assign io_memAddr = io_reset ? regs_pc : _GEN_4096; // @[CPU6502Core.scala 49:17 59:18]
  assign io_memDataOut = io_reset ? 8'h0 : _GEN_4124; // @[CPU6502Core.scala 50:17 59:18]
  assign io_memWrite = io_reset ? 1'h0 : _GEN_4125; // @[CPU6502Core.scala 51:17 59:18]
  assign io_memRead = io_reset ? 1'h0 : _GEN_4097; // @[CPU6502Core.scala 52:17 59:18]
  assign io_debug_regA = regs_a; // @[DebugBundle.scala 23:21 24:16]
  assign io_debug_regX = regs_x; // @[DebugBundle.scala 23:21 25:16]
  assign io_debug_regY = regs_y; // @[DebugBundle.scala 23:21 26:16]
  assign io_debug_regPC = regs_pc; // @[DebugBundle.scala 23:21 27:17]
  assign io_debug_regSP = regs_sp; // @[DebugBundle.scala 23:21 28:17]
  assign io_debug_flagC = regs_flagC; // @[DebugBundle.scala 23:21 29:17]
  assign io_debug_flagZ = regs_flagZ; // @[DebugBundle.scala 23:21 30:17]
  assign io_debug_flagN = regs_flagN; // @[DebugBundle.scala 23:21 31:17]
  assign io_debug_flagV = regs_flagV; // @[DebugBundle.scala 23:21 32:17]
  assign io_debug_opcode = opcode; // @[DebugBundle.scala 23:21 33:18]
  assign io_debug_state = state[1:0]; // @[DebugBundle.scala 23:21 34:17]
  assign io_debug_cycle = cycle; // @[DebugBundle.scala 23:21 35:17]
  always @(posedge clock) begin
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_a <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
          regs_a <= _GEN_4042;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_x <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
          regs_x <= _GEN_4043;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_y <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
          regs_y <= _GEN_4044;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_sp <= 8'hff; // @[CPU6502Core.scala 21:21]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      regs_sp <= 8'hff; // @[CPU6502Core.scala 64:13]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 66:19]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 70:31]
        regs_sp <= _GEN_21;
      end
    end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
      regs_sp <= _GEN_4045;
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 21:21]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 63:13]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 66:19]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 70:31]
        regs_pc <= _GEN_20;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 66:19]
      regs_pc <= _GEN_37;
    end else begin
      regs_pc <= _GEN_4046;
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagC <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
          regs_flagC <= _GEN_4047;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagZ <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
          regs_flagZ <= _GEN_4048;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagI <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 66:19]
        if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 70:31]
          regs_flagI <= _GEN_22;
        end
      end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
        regs_flagI <= _GEN_4049;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagD <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
          regs_flagD <= _GEN_4050;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagV <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
          regs_flagV <= _GEN_4052;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagN <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
          regs_flagN <= _GEN_4053;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 25:22]
      state <= 3'h0; // @[CPU6502Core.scala 25:22]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      state <= 3'h0; // @[CPU6502Core.scala 61:11]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 66:19]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 70:31]
        state <= _GEN_23;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 66:19]
      state <= _GEN_33;
    end else begin
      state <= _GEN_4056;
    end
    if (reset) begin // @[CPU6502Core.scala 27:24]
      opcode <= 8'h0; // @[CPU6502Core.scala 27:24]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 66:19]
        if (3'h1 == state) begin // @[CPU6502Core.scala 66:19]
          opcode <= _GEN_36;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 28:24]
      operand <= 16'h0; // @[CPU6502Core.scala 28:24]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 66:19]
        if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 70:31]
          operand <= _GEN_18;
        end
      end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 66:19]
        operand <= _GEN_4054;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 29:24]
      cycle <= 3'h0; // @[CPU6502Core.scala 29:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      cycle <= 3'h0; // @[CPU6502Core.scala 62:11]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 66:19]
      if (cycle == 3'h0) begin // @[CPU6502Core.scala 70:31]
        cycle <= 3'h1; // @[CPU6502Core.scala 74:19]
      end else begin
        cycle <= _GEN_19;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 66:19]
      cycle <= 3'h0;
    end else begin
      cycle <= _GEN_4055;
    end
    if (reset) begin // @[CPU6502Core.scala 32:24]
      nmiLast <= 1'h0; // @[CPU6502Core.scala 32:24]
    end else begin
      nmiLast <= io_nmi; // @[CPU6502Core.scala 36:11]
    end
    if (reset) begin // @[CPU6502Core.scala 33:24]
      nmiEdge <= 1'h0; // @[CPU6502Core.scala 33:24]
    end else if (state == 3'h3) begin // @[CPU6502Core.scala 44:24]
      nmiEdge <= 1'h0; // @[CPU6502Core.scala 45:13]
    end else begin
      nmiEdge <= _GEN_0;
    end
  end
endmodule
module CPU6502Refactored(
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
  output [7:0]  io_debug_regSP,
  output        io_debug_flagC,
  output        io_debug_flagZ,
  output        io_debug_flagN,
  output        io_debug_flagV,
  output [7:0]  io_debug_opcode,
  output [1:0]  io_debug_state,
  output [2:0]  io_debug_cycle,
  input         io_reset,
  input         io_nmi
);
  wire  core_clock; // @[CPU6502Refactored.scala 20:20]
  wire  core_reset; // @[CPU6502Refactored.scala 20:20]
  wire [15:0] core_io_memAddr; // @[CPU6502Refactored.scala 20:20]
  wire [7:0] core_io_memDataOut; // @[CPU6502Refactored.scala 20:20]
  wire [7:0] core_io_memDataIn; // @[CPU6502Refactored.scala 20:20]
  wire  core_io_memWrite; // @[CPU6502Refactored.scala 20:20]
  wire  core_io_memRead; // @[CPU6502Refactored.scala 20:20]
  wire [7:0] core_io_debug_regA; // @[CPU6502Refactored.scala 20:20]
  wire [7:0] core_io_debug_regX; // @[CPU6502Refactored.scala 20:20]
  wire [7:0] core_io_debug_regY; // @[CPU6502Refactored.scala 20:20]
  wire [15:0] core_io_debug_regPC; // @[CPU6502Refactored.scala 20:20]
  wire [7:0] core_io_debug_regSP; // @[CPU6502Refactored.scala 20:20]
  wire  core_io_debug_flagC; // @[CPU6502Refactored.scala 20:20]
  wire  core_io_debug_flagZ; // @[CPU6502Refactored.scala 20:20]
  wire  core_io_debug_flagN; // @[CPU6502Refactored.scala 20:20]
  wire  core_io_debug_flagV; // @[CPU6502Refactored.scala 20:20]
  wire [7:0] core_io_debug_opcode; // @[CPU6502Refactored.scala 20:20]
  wire [1:0] core_io_debug_state; // @[CPU6502Refactored.scala 20:20]
  wire [2:0] core_io_debug_cycle; // @[CPU6502Refactored.scala 20:20]
  wire  core_io_reset; // @[CPU6502Refactored.scala 20:20]
  wire  core_io_nmi; // @[CPU6502Refactored.scala 20:20]
  CPU6502Core core ( // @[CPU6502Refactored.scala 20:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_memAddr(core_io_memAddr),
    .io_memDataOut(core_io_memDataOut),
    .io_memDataIn(core_io_memDataIn),
    .io_memWrite(core_io_memWrite),
    .io_memRead(core_io_memRead),
    .io_debug_regA(core_io_debug_regA),
    .io_debug_regX(core_io_debug_regX),
    .io_debug_regY(core_io_debug_regY),
    .io_debug_regPC(core_io_debug_regPC),
    .io_debug_regSP(core_io_debug_regSP),
    .io_debug_flagC(core_io_debug_flagC),
    .io_debug_flagZ(core_io_debug_flagZ),
    .io_debug_flagN(core_io_debug_flagN),
    .io_debug_flagV(core_io_debug_flagV),
    .io_debug_opcode(core_io_debug_opcode),
    .io_debug_state(core_io_debug_state),
    .io_debug_cycle(core_io_debug_cycle),
    .io_reset(core_io_reset),
    .io_nmi(core_io_nmi)
  );
  assign io_memAddr = core_io_memAddr; // @[CPU6502Refactored.scala 22:17]
  assign io_memDataOut = core_io_memDataOut; // @[CPU6502Refactored.scala 23:17]
  assign io_memWrite = core_io_memWrite; // @[CPU6502Refactored.scala 25:17]
  assign io_memRead = core_io_memRead; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_regA = core_io_debug_regA; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_regX = core_io_debug_regX; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_regY = core_io_debug_regY; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_regPC = core_io_debug_regPC; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_regSP = core_io_debug_regSP; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_flagC = core_io_debug_flagC; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_flagZ = core_io_debug_flagZ; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_flagN = core_io_debug_flagN; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_flagV = core_io_debug_flagV; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_opcode = core_io_debug_opcode; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_state = core_io_debug_state; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_cycle = core_io_debug_cycle; // @[CPU6502Refactored.scala 27:17]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_memDataIn = io_memDataIn; // @[CPU6502Refactored.scala 24:21]
  assign core_io_reset = io_reset; // @[CPU6502Refactored.scala 28:17]
  assign core_io_nmi = io_nmi; // @[CPU6502Refactored.scala 29:17]
endmodule
module PPU(
  input         clock,
  input         reset,
  input  [2:0]  io_cpuAddr,
  input  [7:0]  io_cpuDataIn,
  output [7:0]  io_cpuDataOut,
  input         io_cpuWrite,
  input         io_cpuRead,
  output [8:0]  io_pixelX,
  output [8:0]  io_pixelY,
  output [5:0]  io_pixelColor,
  output        io_vblank,
  output        io_nmiOut,
  input         io_chrLoadEn,
  input  [12:0] io_chrLoadAddr,
  input  [7:0]  io_chrLoadData,
  output [7:0]  io_debug_ppuCtrl,
  output [7:0]  io_debug_ppuMask,
  output [7:0]  io_debug_ppuStatus,
  output [15:0] io_debug_ppuAddrReg,
  output        io_debug_paletteInitDone
);
  reg [7:0] vram [0:2047]; // @[PPU.scala 61:17]
  wire  vram_io_cpuDataOut_MPORT_2_en; // @[PPU.scala 61:17]
  wire [10:0] vram_io_cpuDataOut_MPORT_2_addr; // @[PPU.scala 61:17]
  wire [7:0] vram_io_cpuDataOut_MPORT_2_data; // @[PPU.scala 61:17]
  wire  vram_tileIndex_en; // @[PPU.scala 61:17]
  wire [10:0] vram_tileIndex_addr; // @[PPU.scala 61:17]
  wire [7:0] vram_tileIndex_data; // @[PPU.scala 61:17]
  wire  vram_attrByte_en; // @[PPU.scala 61:17]
  wire [10:0] vram_attrByte_addr; // @[PPU.scala 61:17]
  wire [7:0] vram_attrByte_data; // @[PPU.scala 61:17]
  wire [7:0] vram_MPORT_3_data; // @[PPU.scala 61:17]
  wire [10:0] vram_MPORT_3_addr; // @[PPU.scala 61:17]
  wire  vram_MPORT_3_mask; // @[PPU.scala 61:17]
  wire  vram_MPORT_3_en; // @[PPU.scala 61:17]
  reg [7:0] oam [0:255]; // @[PPU.scala 62:16]
  wire  oam_io_cpuDataOut_MPORT_en; // @[PPU.scala 62:16]
  wire [7:0] oam_io_cpuDataOut_MPORT_addr; // @[PPU.scala 62:16]
  wire [7:0] oam_io_cpuDataOut_MPORT_data; // @[PPU.scala 62:16]
  wire [7:0] oam_MPORT_1_data; // @[PPU.scala 62:16]
  wire [7:0] oam_MPORT_1_addr; // @[PPU.scala 62:16]
  wire  oam_MPORT_1_mask; // @[PPU.scala 62:16]
  wire  oam_MPORT_1_en; // @[PPU.scala 62:16]
  reg [7:0] palette [0:31]; // @[PPU.scala 63:20]
  wire  palette_io_cpuDataOut_MPORT_3_en; // @[PPU.scala 63:20]
  wire [4:0] palette_io_cpuDataOut_MPORT_3_addr; // @[PPU.scala 63:20]
  wire [7:0] palette_io_cpuDataOut_MPORT_3_data; // @[PPU.scala 63:20]
  wire  palette_paletteColor_en; // @[PPU.scala 63:20]
  wire [4:0] palette_paletteColor_addr; // @[PPU.scala 63:20]
  wire [7:0] palette_paletteColor_data; // @[PPU.scala 63:20]
  wire [7:0] palette_MPORT_data; // @[PPU.scala 63:20]
  wire [4:0] palette_MPORT_addr; // @[PPU.scala 63:20]
  wire  palette_MPORT_mask; // @[PPU.scala 63:20]
  wire  palette_MPORT_en; // @[PPU.scala 63:20]
  wire [7:0] palette_MPORT_4_data; // @[PPU.scala 63:20]
  wire [4:0] palette_MPORT_4_addr; // @[PPU.scala 63:20]
  wire  palette_MPORT_4_mask; // @[PPU.scala 63:20]
  wire  palette_MPORT_4_en; // @[PPU.scala 63:20]
  reg [7:0] chrROM [0:8191]; // @[PPU.scala 64:19]
  wire  chrROM_io_cpuDataOut_MPORT_1_en; // @[PPU.scala 64:19]
  wire [12:0] chrROM_io_cpuDataOut_MPORT_1_addr; // @[PPU.scala 64:19]
  wire [7:0] chrROM_io_cpuDataOut_MPORT_1_data; // @[PPU.scala 64:19]
  wire  chrROM_patternLow_en; // @[PPU.scala 64:19]
  wire [12:0] chrROM_patternLow_addr; // @[PPU.scala 64:19]
  wire [7:0] chrROM_patternLow_data; // @[PPU.scala 64:19]
  wire  chrROM_patternHigh_en; // @[PPU.scala 64:19]
  wire [12:0] chrROM_patternHigh_addr; // @[PPU.scala 64:19]
  wire [7:0] chrROM_patternHigh_data; // @[PPU.scala 64:19]
  wire [7:0] chrROM_MPORT_2_data; // @[PPU.scala 64:19]
  wire [12:0] chrROM_MPORT_2_addr; // @[PPU.scala 64:19]
  wire  chrROM_MPORT_2_mask; // @[PPU.scala 64:19]
  wire  chrROM_MPORT_2_en; // @[PPU.scala 64:19]
  wire [7:0] chrROM_MPORT_5_data; // @[PPU.scala 64:19]
  wire [12:0] chrROM_MPORT_5_addr; // @[PPU.scala 64:19]
  wire  chrROM_MPORT_5_mask; // @[PPU.scala 64:19]
  wire  chrROM_MPORT_5_en; // @[PPU.scala 64:19]
  reg [7:0] ppuCtrl; // @[PPU.scala 51:24]
  reg [7:0] ppuMask; // @[PPU.scala 52:24]
  reg [7:0] oamAddr; // @[PPU.scala 54:24]
  reg  ppuAddrLatch; // @[PPU.scala 57:29]
  reg [15:0] ppuAddrReg; // @[PPU.scala 58:27]
  reg  paletteInitDone; // @[PPU.scala 67:32]
  reg [4:0] paletteInitAddr; // @[PPU.scala 68:32]
  wire  _T = ~paletteInitDone; // @[PPU.scala 70:8]
  wire [5:0] _GEN_1 = 5'h1 == paletteInitAddr ? 6'h0 : 6'hf; // @[]
  wire [5:0] _GEN_2 = 5'h2 == paletteInitAddr ? 6'h10 : _GEN_1; // @[]
  wire [5:0] _GEN_3 = 5'h3 == paletteInitAddr ? 6'h30 : _GEN_2; // @[]
  wire [5:0] _GEN_4 = 5'h4 == paletteInitAddr ? 6'hf : _GEN_3; // @[]
  wire [5:0] _GEN_5 = 5'h5 == paletteInitAddr ? 6'h16 : _GEN_4; // @[]
  wire [5:0] _GEN_6 = 5'h6 == paletteInitAddr ? 6'h27 : _GEN_5; // @[]
  wire [5:0] _GEN_7 = 5'h7 == paletteInitAddr ? 6'h18 : _GEN_6; // @[]
  wire [5:0] _GEN_8 = 5'h8 == paletteInitAddr ? 6'hf : _GEN_7; // @[]
  wire [5:0] _GEN_9 = 5'h9 == paletteInitAddr ? 6'h2a : _GEN_8; // @[]
  wire [5:0] _GEN_10 = 5'ha == paletteInitAddr ? 6'h1a : _GEN_9; // @[]
  wire [5:0] _GEN_11 = 5'hb == paletteInitAddr ? 6'ha : _GEN_10; // @[]
  wire [5:0] _GEN_12 = 5'hc == paletteInitAddr ? 6'hf : _GEN_11; // @[]
  wire [5:0] _GEN_13 = 5'hd == paletteInitAddr ? 6'h12 : _GEN_12; // @[]
  wire [5:0] _GEN_14 = 5'he == paletteInitAddr ? 6'h22 : _GEN_13; // @[]
  wire [5:0] _GEN_15 = 5'hf == paletteInitAddr ? 6'h32 : _GEN_14; // @[]
  wire [5:0] _GEN_16 = 5'h10 == paletteInitAddr ? 6'hf : _GEN_15; // @[]
  wire [5:0] _GEN_17 = 5'h11 == paletteInitAddr ? 6'h0 : _GEN_16; // @[]
  wire [5:0] _GEN_18 = 5'h12 == paletteInitAddr ? 6'h10 : _GEN_17; // @[]
  wire [5:0] _GEN_19 = 5'h13 == paletteInitAddr ? 6'h30 : _GEN_18; // @[]
  wire [5:0] _GEN_20 = 5'h14 == paletteInitAddr ? 6'hf : _GEN_19; // @[]
  wire [5:0] _GEN_21 = 5'h15 == paletteInitAddr ? 6'h16 : _GEN_20; // @[]
  wire [5:0] _GEN_22 = 5'h16 == paletteInitAddr ? 6'h27 : _GEN_21; // @[]
  wire [5:0] _GEN_23 = 5'h17 == paletteInitAddr ? 6'h18 : _GEN_22; // @[]
  wire [5:0] _GEN_24 = 5'h18 == paletteInitAddr ? 6'hf : _GEN_23; // @[]
  wire [5:0] _GEN_25 = 5'h19 == paletteInitAddr ? 6'h2a : _GEN_24; // @[]
  wire [5:0] _GEN_26 = 5'h1a == paletteInitAddr ? 6'h1a : _GEN_25; // @[]
  wire [5:0] _GEN_27 = 5'h1b == paletteInitAddr ? 6'ha : _GEN_26; // @[]
  wire [5:0] _GEN_28 = 5'h1c == paletteInitAddr ? 6'hf : _GEN_27; // @[]
  wire [5:0] _GEN_29 = 5'h1d == paletteInitAddr ? 6'h12 : _GEN_28; // @[]
  wire [5:0] _GEN_30 = 5'h1e == paletteInitAddr ? 6'h22 : _GEN_29; // @[]
  wire [5:0] _GEN_31 = 5'h1f == paletteInitAddr ? 6'h32 : _GEN_30; // @[]
  wire [4:0] _paletteInitAddr_T_1 = paletteInitAddr + 5'h1; // @[PPU.scala 84:40]
  wire  _GEN_32 = paletteInitAddr == 5'h1f | paletteInitDone; // @[PPU.scala 86:36 87:23 67:32]
  reg [8:0] renderX; // @[PPU.scala 92:26]
  reg [8:0] renderY; // @[PPU.scala 93:26]
  reg  vblankFlag; // @[PPU.scala 96:27]
  reg  nmiOccurred; // @[PPU.scala 97:28]
  wire [8:0] _scanlineX_T_1 = renderX + 9'h1; // @[PPU.scala 100:26]
  wire [8:0] _scanlineY_T_1 = renderY + 9'h1; // @[PPU.scala 103:28]
  wire  _T_3 = renderY == 9'h105; // @[PPU.scala 105:20]
  wire  _T_5 = renderX == 9'h1; // @[PPU.scala 111:41]
  wire  _GEN_43 = ppuCtrl[7] | nmiOccurred; // @[PPU.scala 113:22 114:19 97:28]
  wire  _GEN_44 = renderY == 9'hf1 & renderX == 9'h1 | vblankFlag; // @[PPU.scala 111:50 112:16 96:27]
  wire  _GEN_45 = renderY == 9'hf1 & renderX == 9'h1 ? _GEN_43 : nmiOccurred; // @[PPU.scala 111:50 97:28]
  wire  _GEN_46 = _T_3 & _T_5 ? 1'h0 : _GEN_44; // @[PPU.scala 118:50 119:16]
  wire  _GEN_47 = _T_3 & _T_5 ? 1'h0 : _GEN_45; // @[PPU.scala 118:50 120:17]
  wire [7:0] _io_cpuDataOut_T = {vblankFlag,7'h0}; // @[Cat.scala 33:92]
  wire  _T_12 = 3'h4 == io_cpuAddr; // @[PPU.scala 127:24]
  wire  _T_13 = 3'h7 == io_cpuAddr; // @[PPU.scala 127:24]
  wire  _T_14 = ppuAddrReg < 16'h2000; // @[PPU.scala 139:25]
  wire  _T_15 = ppuAddrReg < 16'h3f00; // @[PPU.scala 142:31]
  wire [7:0] _GEN_51 = ppuAddrReg < 16'h3f00 ? vram_io_cpuDataOut_MPORT_2_data : palette_io_cpuDataOut_MPORT_3_data; // @[PPU.scala 142:43 144:25 147:25]
  wire  _GEN_54 = ppuAddrReg < 16'h3f00 ? 1'h0 : 1'h1; // @[PPU.scala 142:43 63:20 147:40]
  wire [7:0] _GEN_58 = ppuAddrReg < 16'h2000 ? chrROM_io_cpuDataOut_MPORT_1_data : _GEN_51; // @[PPU.scala 139:37 141:25]
  wire  _GEN_61 = ppuAddrReg < 16'h2000 ? 1'h0 : _T_15; // @[PPU.scala 139:37 61:17]
  wire  _GEN_64 = ppuAddrReg < 16'h2000 ? 1'h0 : _GEN_54; // @[PPU.scala 139:37 63:20]
  wire [15:0] _ppuAddrReg_T_1 = ppuAddrReg + 16'h1; // @[PPU.scala 149:34]
  wire  _GEN_67 = 3'h7 == io_cpuAddr & _T_14; // @[PPU.scala 127:24 64:19]
  wire [7:0] _GEN_68 = 3'h7 == io_cpuAddr ? _GEN_58 : 8'h0; // @[PPU.scala 124:17 127:24]
  wire  _GEN_71 = 3'h7 == io_cpuAddr & _GEN_61; // @[PPU.scala 127:24 61:17]
  wire  _GEN_74 = 3'h7 == io_cpuAddr & _GEN_64; // @[PPU.scala 127:24 63:20]
  wire [15:0] _GEN_75 = 3'h7 == io_cpuAddr ? _ppuAddrReg_T_1 : ppuAddrReg; // @[PPU.scala 127:24 149:20 58:27]
  wire [7:0] _GEN_79 = 3'h4 == io_cpuAddr ? oam_io_cpuDataOut_MPORT_data : _GEN_68; // @[PPU.scala 127:24 135:23]
  wire  _GEN_82 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _T_14; // @[PPU.scala 127:24 64:19]
  wire  _GEN_85 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _GEN_61; // @[PPU.scala 127:24 61:17]
  wire  _GEN_88 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _GEN_64; // @[PPU.scala 127:24 63:20]
  wire [15:0] _GEN_89 = 3'h4 == io_cpuAddr ? ppuAddrReg : _GEN_75; // @[PPU.scala 127:24 58:27]
  wire [7:0] _GEN_90 = 3'h2 == io_cpuAddr ? _io_cpuDataOut_T : _GEN_79; // @[PPU.scala 127:24 129:23]
  wire  _GEN_93 = 3'h2 == io_cpuAddr ? 1'h0 : ppuAddrLatch; // @[PPU.scala 127:24 132:22 57:29]
  wire  _GEN_96 = 3'h2 == io_cpuAddr ? 1'h0 : 3'h4 == io_cpuAddr; // @[PPU.scala 127:24 62:16]
  wire  _GEN_99 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_82; // @[PPU.scala 127:24 64:19]
  wire  _GEN_102 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_85; // @[PPU.scala 127:24 61:17]
  wire  _GEN_105 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_88; // @[PPU.scala 127:24 63:20]
  wire [15:0] _GEN_106 = 3'h2 == io_cpuAddr ? ppuAddrReg : _GEN_89; // @[PPU.scala 127:24 58:27]
  wire  _GEN_110 = io_cpuRead ? _GEN_93 : ppuAddrLatch; // @[PPU.scala 126:20 57:29]
  wire [15:0] _GEN_123 = io_cpuRead ? _GEN_106 : ppuAddrReg; // @[PPU.scala 126:20 58:27]
  wire [7:0] _oamAddr_T_1 = oamAddr + 8'h1; // @[PPU.scala 167:28]
  wire  _T_21 = ~ppuAddrLatch; // @[PPU.scala 170:14]
  wire [13:0] _ppuAddrReg_T_3 = {io_cpuDataIn[5:0],8'h0}; // @[Cat.scala 33:92]
  wire [15:0] _ppuAddrReg_T_5 = {ppuAddrReg[15:8],io_cpuDataIn}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_126 = _T_21 ? {{2'd0}, _ppuAddrReg_T_3} : _ppuAddrReg_T_5; // @[PPU.scala 178:29 179:22 181:22]
  wire [15:0] _GEN_167 = _T_13 ? _ppuAddrReg_T_1 : _GEN_123; // @[PPU.scala 155:24 197:20]
  wire [15:0] _GEN_168 = 3'h6 == io_cpuAddr ? _GEN_126 : _GEN_167; // @[PPU.scala 155:24]
  wire  _GEN_169 = 3'h6 == io_cpuAddr ? _T_21 : _GEN_110; // @[PPU.scala 155:24 183:22]
  wire  _GEN_172 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_67; // @[PPU.scala 155:24 64:19]
  wire  _GEN_177 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_71; // @[PPU.scala 155:24 61:17]
  wire  _GEN_182 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_74; // @[PPU.scala 155:24 63:20]
  wire  _GEN_187 = 3'h5 == io_cpuAddr ? _T_21 : _GEN_169; // @[PPU.scala 155:24 175:22]
  wire [15:0] _GEN_188 = 3'h5 == io_cpuAddr ? _GEN_123 : _GEN_168; // @[PPU.scala 155:24]
  wire  _GEN_191 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_172; // @[PPU.scala 155:24 64:19]
  wire  _GEN_196 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_177; // @[PPU.scala 155:24 61:17]
  wire  _GEN_201 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_182; // @[PPU.scala 155:24 63:20]
  wire [7:0] _GEN_209 = _T_12 ? _oamAddr_T_1 : oamAddr; // @[PPU.scala 155:24 167:17 54:24]
  wire  _GEN_212 = _T_12 ? _GEN_110 : _GEN_187; // @[PPU.scala 155:24]
  wire [15:0] _GEN_213 = _T_12 ? _GEN_123 : _GEN_188; // @[PPU.scala 155:24]
  wire  _GEN_216 = _T_12 ? 1'h0 : _GEN_191; // @[PPU.scala 155:24 64:19]
  wire  _GEN_221 = _T_12 ? 1'h0 : _GEN_196; // @[PPU.scala 155:24 61:17]
  wire  _GEN_226 = _T_12 ? 1'h0 : _GEN_201; // @[PPU.scala 155:24 63:20]
  wire [7:0] _GEN_229 = 3'h3 == io_cpuAddr ? io_cpuDataIn : _GEN_209; // @[PPU.scala 155:24 163:17]
  wire  _GEN_232 = 3'h3 == io_cpuAddr ? 1'h0 : _T_12; // @[PPU.scala 155:24 62:16]
  wire  _GEN_237 = 3'h3 == io_cpuAddr ? _GEN_110 : _GEN_212; // @[PPU.scala 155:24]
  wire [15:0] _GEN_238 = 3'h3 == io_cpuAddr ? _GEN_123 : _GEN_213; // @[PPU.scala 155:24]
  wire  _GEN_241 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_216; // @[PPU.scala 155:24 64:19]
  wire  _GEN_246 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_221; // @[PPU.scala 155:24 61:17]
  wire  _GEN_251 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_226; // @[PPU.scala 155:24 63:20]
  wire  _GEN_258 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_232; // @[PPU.scala 155:24 62:16]
  wire  _GEN_267 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_241; // @[PPU.scala 155:24 64:19]
  wire  _GEN_272 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_246; // @[PPU.scala 155:24 61:17]
  wire  _GEN_277 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_251; // @[PPU.scala 155:24 63:20]
  wire  _GEN_285 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_258; // @[PPU.scala 155:24 62:16]
  wire  _GEN_294 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_267; // @[PPU.scala 155:24 64:19]
  wire  _GEN_299 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_272; // @[PPU.scala 155:24 61:17]
  wire  _GEN_304 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_277; // @[PPU.scala 155:24 63:20]
  wire  _T_30 = renderX < 9'h100; // @[PPU.scala 213:16]
  wire  _T_31 = renderY < 9'hf0; // @[PPU.scala 213:35]
  wire [5:0] tileX = renderX[8:3]; // @[PPU.scala 215:25]
  wire [5:0] tileY = renderY[8:3]; // @[PPU.scala 216:25]
  wire [2:0] pixelInTileX = renderX[2:0]; // @[PPU.scala 217:31]
  wire [2:0] pixelInTileY = renderY[2:0]; // @[PPU.scala 218:31]
  wire [10:0] _nametableAddr_T = {tileY, 5'h0}; // @[PPU.scala 221:32]
  wire [10:0] _GEN_348 = {{5'd0}, tileX}; // @[PPU.scala 221:38]
  wire [3:0] attrX = tileX[5:2]; // @[PPU.scala 225:23]
  wire [3:0] attrY = tileY[5:2]; // @[PPU.scala 226:23]
  wire [6:0] _attrAddr_T = {attrY, 3'h0}; // @[PPU.scala 227:37]
  wire [9:0] _GEN_349 = {{3'd0}, _attrAddr_T}; // @[PPU.scala 227:28]
  wire [9:0] _attrAddr_T_2 = 10'h3c0 + _GEN_349; // @[PPU.scala 227:28]
  wire [9:0] _GEN_350 = {{6'd0}, attrX}; // @[PPU.scala 227:43]
  wire [9:0] attrAddr = _attrAddr_T_2 + _GEN_350; // @[PPU.scala 227:43]
  wire [2:0] _attrShift_T_1 = {tileY[1], 2'h0}; // @[PPU.scala 229:32]
  wire [1:0] _attrShift_T_3 = {tileX[1], 1'h0}; // @[PPU.scala 229:50]
  wire [2:0] _GEN_351 = {{1'd0}, _attrShift_T_3}; // @[PPU.scala 229:38]
  wire [2:0] attrShift = _attrShift_T_1 | _GEN_351; // @[PPU.scala 229:38]
  wire [7:0] _paletteHigh_T = vram_attrByte_data >> attrShift; // @[PPU.scala 230:33]
  wire [7:0] paletteHigh = _paletteHigh_T & 8'h3; // @[PPU.scala 230:47]
  wire [12:0] patternTableBase = ppuCtrl[4] ? 13'h1000 : 13'h0; // @[PPU.scala 233:31]
  wire [11:0] _patternAddr_T = {vram_tileIndex_data, 4'h0}; // @[PPU.scala 234:53]
  wire [12:0] _GEN_352 = {{1'd0}, _patternAddr_T}; // @[PPU.scala 234:40]
  wire [12:0] _patternAddr_T_2 = patternTableBase + _GEN_352; // @[PPU.scala 234:40]
  wire [12:0] _GEN_353 = {{10'd0}, pixelInTileY}; // @[PPU.scala 234:59]
  wire [12:0] patternAddr = _patternAddr_T_2 + _GEN_353; // @[PPU.scala 234:59]
  wire [2:0] bitPos = 3'h7 - pixelInTileX; // @[PPU.scala 241:22]
  wire [7:0] _colorLow_T = chrROM_patternLow_data >> bitPos; // @[PPU.scala 242:32]
  wire [7:0] colorLow = _colorLow_T & 8'h1; // @[PPU.scala 242:43]
  wire [7:0] _colorHigh_T = chrROM_patternHigh_data >> bitPos; // @[PPU.scala 243:34]
  wire [7:0] colorHigh = _colorHigh_T & 8'h1; // @[PPU.scala 243:45]
  wire [8:0] _paletteLow_T = {colorHigh, 1'h0}; // @[PPU.scala 244:33]
  wire [8:0] _GEN_354 = {{1'd0}, colorLow}; // @[PPU.scala 244:39]
  wire [8:0] paletteLow = _paletteLow_T | _GEN_354; // @[PPU.scala 244:39]
  wire [9:0] _fullPaletteIndex_T = {paletteHigh, 2'h0}; // @[PPU.scala 247:41]
  wire [9:0] _GEN_355 = {{1'd0}, paletteLow}; // @[PPU.scala 247:47]
  wire [9:0] fullPaletteIndex = _fullPaletteIndex_T | _GEN_355; // @[PPU.scala 247:47]
  wire  _paletteAddr_T = paletteLow == 9'h0; // @[PPU.scala 250:38]
  wire [9:0] paletteAddr = paletteLow == 9'h0 ? 10'h0 : fullPaletteIndex; // @[PPU.scala 250:26]
  wire [5:0] _pixelColor_T_3 = paletteLow == 9'h2 ? 6'h10 : 6'h30; // @[PPU.scala 258:24]
  wire [5:0] _pixelColor_T_4 = paletteLow == 9'h1 ? 6'h0 : _pixelColor_T_3; // @[PPU.scala 257:24]
  wire [5:0] _pixelColor_T_5 = _paletteAddr_T ? 6'hf : _pixelColor_T_4; // @[PPU.scala 256:24]
  wire [5:0] _GEN_339 = _T ? _pixelColor_T_5 : palette_paletteColor_data[5:0]; // @[PPU.scala 254:28 256:18 261:18]
  assign vram_io_cpuDataOut_MPORT_2_en = io_cpuRead & _GEN_102;
  assign vram_io_cpuDataOut_MPORT_2_addr = ppuAddrReg[10:0];
  assign vram_io_cpuDataOut_MPORT_2_data = vram[vram_io_cpuDataOut_MPORT_2_addr]; // @[PPU.scala 61:17]
  assign vram_tileIndex_en = _T_30 & _T_31;
  assign vram_tileIndex_addr = _nametableAddr_T + _GEN_348;
  assign vram_tileIndex_data = vram[vram_tileIndex_addr]; // @[PPU.scala 61:17]
  assign vram_attrByte_en = _T_30 & _T_31;
  assign vram_attrByte_addr = {{1'd0}, attrAddr};
  assign vram_attrByte_data = vram[vram_attrByte_addr]; // @[PPU.scala 61:17]
  assign vram_MPORT_3_data = io_cpuDataIn;
  assign vram_MPORT_3_addr = ppuAddrReg[10:0];
  assign vram_MPORT_3_mask = 1'h1;
  assign vram_MPORT_3_en = io_cpuWrite & _GEN_299;
  assign oam_io_cpuDataOut_MPORT_en = io_cpuRead & _GEN_96;
  assign oam_io_cpuDataOut_MPORT_addr = oamAddr;
  assign oam_io_cpuDataOut_MPORT_data = oam[oam_io_cpuDataOut_MPORT_addr]; // @[PPU.scala 62:16]
  assign oam_MPORT_1_data = io_cpuDataIn;
  assign oam_MPORT_1_addr = oamAddr;
  assign oam_MPORT_1_mask = 1'h1;
  assign oam_MPORT_1_en = io_cpuWrite & _GEN_285;
  assign palette_io_cpuDataOut_MPORT_3_en = io_cpuRead & _GEN_105;
  assign palette_io_cpuDataOut_MPORT_3_addr = ppuAddrReg[4:0];
  assign palette_io_cpuDataOut_MPORT_3_data = palette[palette_io_cpuDataOut_MPORT_3_addr]; // @[PPU.scala 63:20]
  assign palette_paletteColor_en = _T_30 & _T_31;
  assign palette_paletteColor_addr = paletteAddr[4:0];
  assign palette_paletteColor_data = palette[palette_paletteColor_addr]; // @[PPU.scala 63:20]
  assign palette_MPORT_data = {{2'd0}, _GEN_31};
  assign palette_MPORT_addr = paletteInitAddr;
  assign palette_MPORT_mask = 1'h1;
  assign palette_MPORT_en = ~paletteInitDone;
  assign palette_MPORT_4_data = io_cpuDataIn;
  assign palette_MPORT_4_addr = ppuAddrReg[4:0];
  assign palette_MPORT_4_mask = 1'h1;
  assign palette_MPORT_4_en = io_cpuWrite & _GEN_304;
  assign chrROM_io_cpuDataOut_MPORT_1_en = io_cpuRead & _GEN_99;
  assign chrROM_io_cpuDataOut_MPORT_1_addr = ppuAddrReg[12:0];
  assign chrROM_io_cpuDataOut_MPORT_1_data = chrROM[chrROM_io_cpuDataOut_MPORT_1_addr]; // @[PPU.scala 64:19]
  assign chrROM_patternLow_en = _T_30 & _T_31;
  assign chrROM_patternLow_addr = _patternAddr_T_2 + _GEN_353;
  assign chrROM_patternLow_data = chrROM[chrROM_patternLow_addr]; // @[PPU.scala 64:19]
  assign chrROM_patternHigh_en = _T_30 & _T_31;
  assign chrROM_patternHigh_addr = patternAddr + 13'h8;
  assign chrROM_patternHigh_data = chrROM[chrROM_patternHigh_addr]; // @[PPU.scala 64:19]
  assign chrROM_MPORT_2_data = io_cpuDataIn;
  assign chrROM_MPORT_2_addr = ppuAddrReg[12:0];
  assign chrROM_MPORT_2_mask = 1'h1;
  assign chrROM_MPORT_2_en = io_cpuWrite & _GEN_294;
  assign chrROM_MPORT_5_data = io_chrLoadData;
  assign chrROM_MPORT_5_addr = io_chrLoadAddr;
  assign chrROM_MPORT_5_mask = 1'h1;
  assign chrROM_MPORT_5_en = io_chrLoadEn;
  assign io_cpuDataOut = io_cpuRead ? _GEN_90 : 8'h0; // @[PPU.scala 124:17 126:20]
  assign io_pixelX = renderX; // @[PPU.scala 266:13]
  assign io_pixelY = renderY; // @[PPU.scala 267:13]
  assign io_pixelColor = renderX < 9'h100 & renderY < 9'hf0 ? _GEN_339 : 6'hf; // @[PPU.scala 210:31 213:44]
  assign io_vblank = vblankFlag; // @[PPU.scala 269:13]
  assign io_nmiOut = nmiOccurred; // @[PPU.scala 270:13]
  assign io_debug_ppuCtrl = ppuCtrl; // @[PPU.scala 273:20]
  assign io_debug_ppuMask = ppuMask; // @[PPU.scala 274:20]
  assign io_debug_ppuStatus = {vblankFlag,7'h0}; // @[Cat.scala 33:92]
  assign io_debug_ppuAddrReg = ppuAddrReg; // @[PPU.scala 276:23]
  assign io_debug_paletteInitDone = paletteInitDone; // @[PPU.scala 277:28]
  always @(posedge clock) begin
    if (vram_MPORT_3_en & vram_MPORT_3_mask) begin
      vram[vram_MPORT_3_addr] <= vram_MPORT_3_data; // @[PPU.scala 61:17]
    end
    if (oam_MPORT_1_en & oam_MPORT_1_mask) begin
      oam[oam_MPORT_1_addr] <= oam_MPORT_1_data; // @[PPU.scala 62:16]
    end
    if (palette_MPORT_en & palette_MPORT_mask) begin
      palette[palette_MPORT_addr] <= palette_MPORT_data; // @[PPU.scala 63:20]
    end
    if (palette_MPORT_4_en & palette_MPORT_4_mask) begin
      palette[palette_MPORT_4_addr] <= palette_MPORT_4_data; // @[PPU.scala 63:20]
    end
    if (chrROM_MPORT_2_en & chrROM_MPORT_2_mask) begin
      chrROM[chrROM_MPORT_2_addr] <= chrROM_MPORT_2_data; // @[PPU.scala 64:19]
    end
    if (chrROM_MPORT_5_en & chrROM_MPORT_5_mask) begin
      chrROM[chrROM_MPORT_5_addr] <= chrROM_MPORT_5_data; // @[PPU.scala 64:19]
    end
    if (reset) begin // @[PPU.scala 51:24]
      ppuCtrl <= 8'h0; // @[PPU.scala 51:24]
    end else if (io_cpuWrite) begin // @[PPU.scala 154:21]
      if (3'h0 == io_cpuAddr) begin // @[PPU.scala 155:24]
        ppuCtrl <= io_cpuDataIn; // @[PPU.scala 157:17]
      end
    end
    if (reset) begin // @[PPU.scala 52:24]
      ppuMask <= 8'h0; // @[PPU.scala 52:24]
    end else if (io_cpuWrite) begin // @[PPU.scala 154:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPU.scala 155:24]
        if (3'h1 == io_cpuAddr) begin // @[PPU.scala 155:24]
          ppuMask <= io_cpuDataIn; // @[PPU.scala 160:17]
        end
      end
    end
    if (reset) begin // @[PPU.scala 54:24]
      oamAddr <= 8'h0; // @[PPU.scala 54:24]
    end else if (io_cpuWrite) begin // @[PPU.scala 154:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPU.scala 155:24]
        if (!(3'h1 == io_cpuAddr)) begin // @[PPU.scala 155:24]
          oamAddr <= _GEN_229;
        end
      end
    end
    if (reset) begin // @[PPU.scala 57:29]
      ppuAddrLatch <= 1'h0; // @[PPU.scala 57:29]
    end else if (io_cpuWrite) begin // @[PPU.scala 154:21]
      if (3'h0 == io_cpuAddr) begin // @[PPU.scala 155:24]
        ppuAddrLatch <= _GEN_110;
      end else if (3'h1 == io_cpuAddr) begin // @[PPU.scala 155:24]
        ppuAddrLatch <= _GEN_110;
      end else begin
        ppuAddrLatch <= _GEN_237;
      end
    end else begin
      ppuAddrLatch <= _GEN_110;
    end
    if (reset) begin // @[PPU.scala 58:27]
      ppuAddrReg <= 16'h0; // @[PPU.scala 58:27]
    end else if (io_cpuWrite) begin // @[PPU.scala 154:21]
      if (3'h0 == io_cpuAddr) begin // @[PPU.scala 155:24]
        ppuAddrReg <= _GEN_123;
      end else if (3'h1 == io_cpuAddr) begin // @[PPU.scala 155:24]
        ppuAddrReg <= _GEN_123;
      end else begin
        ppuAddrReg <= _GEN_238;
      end
    end else begin
      ppuAddrReg <= _GEN_123;
    end
    if (reset) begin // @[PPU.scala 67:32]
      paletteInitDone <= 1'h0; // @[PPU.scala 67:32]
    end else if (~paletteInitDone) begin // @[PPU.scala 70:26]
      paletteInitDone <= _GEN_32;
    end
    if (reset) begin // @[PPU.scala 68:32]
      paletteInitAddr <= 5'h0; // @[PPU.scala 68:32]
    end else if (~paletteInitDone) begin // @[PPU.scala 70:26]
      paletteInitAddr <= _paletteInitAddr_T_1; // @[PPU.scala 84:21]
    end
    if (reset) begin // @[PPU.scala 92:26]
      renderX <= 9'h0; // @[PPU.scala 92:26]
    end else if (renderX == 9'h154) begin // @[PPU.scala 101:29]
      renderX <= 9'h0; // @[PPU.scala 102:15]
    end else begin
      renderX <= _scanlineX_T_1; // @[PPU.scala 100:13]
    end
    if (reset) begin // @[PPU.scala 93:26]
      renderY <= 9'h0; // @[PPU.scala 93:26]
    end else if (renderX == 9'h154) begin // @[PPU.scala 101:29]
      if (renderY == 9'h105) begin // @[PPU.scala 105:31]
        renderY <= 9'h0; // @[PPU.scala 106:17]
      end else begin
        renderY <= _scanlineY_T_1; // @[PPU.scala 103:15]
      end
    end
    if (reset) begin // @[PPU.scala 96:27]
      vblankFlag <= 1'h0; // @[PPU.scala 96:27]
    end else if (io_cpuRead) begin // @[PPU.scala 126:20]
      if (3'h2 == io_cpuAddr) begin // @[PPU.scala 127:24]
        vblankFlag <= 1'h0; // @[PPU.scala 130:20]
      end else begin
        vblankFlag <= _GEN_46;
      end
    end else begin
      vblankFlag <= _GEN_46;
    end
    if (reset) begin // @[PPU.scala 97:28]
      nmiOccurred <= 1'h0; // @[PPU.scala 97:28]
    end else if (io_cpuRead) begin // @[PPU.scala 126:20]
      if (3'h2 == io_cpuAddr) begin // @[PPU.scala 127:24]
        nmiOccurred <= 1'h0; // @[PPU.scala 131:21]
      end else begin
        nmiOccurred <= _GEN_47;
      end
    end else begin
      nmiOccurred <= _GEN_47;
    end
  end
endmodule
module MemoryController(
  input         clock,
  input  [15:0] io_cpuAddr,
  input  [7:0]  io_cpuDataIn,
  output [7:0]  io_cpuDataOut,
  input         io_cpuWrite,
  input         io_cpuRead,
  output [2:0]  io_ppuAddr,
  output [7:0]  io_ppuDataIn,
  input  [7:0]  io_ppuDataOut,
  output        io_ppuWrite,
  output        io_ppuRead,
  input  [7:0]  io_controller1,
  input  [7:0]  io_controller2,
  input         io_romLoadEn,
  input  [15:0] io_romLoadAddr,
  input  [7:0]  io_romLoadData,
  input         io_romLoadPRG
);
  reg [7:0] internalRAM [0:2047]; // @[MemoryController.scala 35:32]
  wire  internalRAM_io_cpuDataOut_MPORT_en; // @[MemoryController.scala 35:32]
  wire [10:0] internalRAM_io_cpuDataOut_MPORT_addr; // @[MemoryController.scala 35:32]
  wire [7:0] internalRAM_io_cpuDataOut_MPORT_data; // @[MemoryController.scala 35:32]
  wire [7:0] internalRAM_MPORT_data; // @[MemoryController.scala 35:32]
  wire [10:0] internalRAM_MPORT_addr; // @[MemoryController.scala 35:32]
  wire  internalRAM_MPORT_mask; // @[MemoryController.scala 35:32]
  wire  internalRAM_MPORT_en; // @[MemoryController.scala 35:32]
  reg  internalRAM_io_cpuDataOut_MPORT_en_pipe_0;
  reg [10:0] internalRAM_io_cpuDataOut_MPORT_addr_pipe_0;
  reg [7:0] prgROM [0:32767]; // @[MemoryController.scala 39:19]
  wire  prgROM_io_cpuDataOut_MPORT_1_en; // @[MemoryController.scala 39:19]
  wire [14:0] prgROM_io_cpuDataOut_MPORT_1_addr; // @[MemoryController.scala 39:19]
  wire [7:0] prgROM_io_cpuDataOut_MPORT_1_data; // @[MemoryController.scala 39:19]
  wire [7:0] prgROM_MPORT_1_data; // @[MemoryController.scala 39:19]
  wire [14:0] prgROM_MPORT_1_addr; // @[MemoryController.scala 39:19]
  wire  prgROM_MPORT_1_mask; // @[MemoryController.scala 39:19]
  wire  prgROM_MPORT_1_en; // @[MemoryController.scala 39:19]
  wire [7:0] prgROM_MPORT_2_data; // @[MemoryController.scala 39:19]
  wire [14:0] prgROM_MPORT_2_addr; // @[MemoryController.scala 39:19]
  wire  prgROM_MPORT_2_mask; // @[MemoryController.scala 39:19]
  wire  prgROM_MPORT_2_en; // @[MemoryController.scala 39:19]
  wire  _T = io_cpuAddr < 16'h2000; // @[MemoryController.scala 58:21]
  wire  _T_3 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000; // @[MemoryController.scala 62:39]
  wire  _T_6 = io_cpuAddr >= 16'h8000; // @[MemoryController.scala 73:27]
  wire [15:0] _romAddr_T_1 = io_cpuAddr - 16'h8000; // @[MemoryController.scala 78:33]
  wire [13:0] romAddr = _romAddr_T_1[13:0]; // @[MemoryController.scala 78:44]
  wire [7:0] _GEN_7 = io_cpuAddr >= 16'h8000 ? prgROM_io_cpuDataOut_MPORT_1_data : 8'h0; // @[MemoryController.scala 42:17 73:40 79:21]
  wire [7:0] _GEN_8 = io_cpuAddr == 16'h4017 ? io_controller2 : _GEN_7; // @[MemoryController.scala 70:41 72:21]
  wire  _GEN_11 = io_cpuAddr == 16'h4017 ? 1'h0 : _T_6; // @[MemoryController.scala 39:19 70:41]
  wire [7:0] _GEN_12 = io_cpuAddr == 16'h4016 ? io_controller1 : _GEN_8; // @[MemoryController.scala 67:41 69:21]
  wire  _GEN_15 = io_cpuAddr == 16'h4016 ? 1'h0 : _GEN_11; // @[MemoryController.scala 39:19 67:41]
  wire [2:0] _GEN_16 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? io_cpuAddr[2:0] : 3'h0; // @[MemoryController.scala 43:14 62:65 64:18]
  wire [7:0] _GEN_18 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? io_ppuDataOut : _GEN_12; // @[MemoryController.scala 62:65 66:21]
  wire  _GEN_21 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? 1'h0 : _GEN_15; // @[MemoryController.scala 39:19 62:65]
  wire [7:0] _GEN_25 = io_cpuAddr < 16'h2000 ? internalRAM_io_cpuDataOut_MPORT_data : _GEN_18; // @[MemoryController.scala 58:33 61:21]
  wire [2:0] _GEN_26 = io_cpuAddr < 16'h2000 ? 3'h0 : _GEN_16; // @[MemoryController.scala 43:14 58:33]
  wire  _GEN_27 = io_cpuAddr < 16'h2000 ? 1'h0 : _T_3; // @[MemoryController.scala 46:14 58:33]
  wire  _GEN_30 = io_cpuAddr < 16'h2000 ? 1'h0 : _GEN_21; // @[MemoryController.scala 39:19 58:33]
  wire [2:0] _GEN_35 = io_cpuRead ? _GEN_26 : 3'h0; // @[MemoryController.scala 43:14 57:20]
  wire [2:0] _GEN_45 = _T_3 ? io_cpuAddr[2:0] : _GEN_35; // @[MemoryController.scala 89:65 91:18]
  wire [7:0] _GEN_46 = _T_3 ? io_cpuDataIn : 8'h0; // @[MemoryController.scala 44:16 89:65 92:20]
  wire  _GEN_50 = _T_3 ? 1'h0 : _T_6; // @[MemoryController.scala 39:19 89:65]
  wire [2:0] _GEN_58 = _T ? _GEN_35 : _GEN_45; // @[MemoryController.scala 85:33]
  wire [7:0] _GEN_59 = _T ? 8'h0 : _GEN_46; // @[MemoryController.scala 44:16 85:33]
  wire  _GEN_63 = _T ? 1'h0 : _GEN_50; // @[MemoryController.scala 39:19 85:33]
  wire  _T_13 = io_romLoadEn & io_romLoadPRG; // @[MemoryController.scala 102:21]
  wire  _T_14 = io_romLoadAddr < 16'h8000; // @[MemoryController.scala 104:25]
  assign internalRAM_io_cpuDataOut_MPORT_en = internalRAM_io_cpuDataOut_MPORT_en_pipe_0;
  assign internalRAM_io_cpuDataOut_MPORT_addr = internalRAM_io_cpuDataOut_MPORT_addr_pipe_0;
  assign internalRAM_io_cpuDataOut_MPORT_data = internalRAM[internalRAM_io_cpuDataOut_MPORT_addr]; // @[MemoryController.scala 35:32]
  assign internalRAM_MPORT_data = io_cpuDataIn;
  assign internalRAM_MPORT_addr = io_cpuAddr[10:0];
  assign internalRAM_MPORT_mask = 1'h1;
  assign internalRAM_MPORT_en = io_cpuWrite & _T;
  assign prgROM_io_cpuDataOut_MPORT_1_en = io_cpuRead & _GEN_30;
  assign prgROM_io_cpuDataOut_MPORT_1_addr = {{1'd0}, romAddr};
  assign prgROM_io_cpuDataOut_MPORT_1_data = prgROM[prgROM_io_cpuDataOut_MPORT_1_addr]; // @[MemoryController.scala 39:19]
  assign prgROM_MPORT_1_data = io_cpuDataIn;
  assign prgROM_MPORT_1_addr = _romAddr_T_1[14:0];
  assign prgROM_MPORT_1_mask = 1'h1;
  assign prgROM_MPORT_1_en = io_cpuWrite & _GEN_63;
  assign prgROM_MPORT_2_data = io_romLoadData;
  assign prgROM_MPORT_2_addr = io_romLoadAddr[14:0];
  assign prgROM_MPORT_2_mask = 1'h1;
  assign prgROM_MPORT_2_en = _T_13 & _T_14;
  assign io_cpuDataOut = io_cpuRead ? _GEN_25 : 8'h0; // @[MemoryController.scala 42:17 57:20]
  assign io_ppuAddr = io_cpuWrite ? _GEN_58 : _GEN_35; // @[MemoryController.scala 84:21]
  assign io_ppuDataIn = io_cpuWrite ? _GEN_59 : 8'h0; // @[MemoryController.scala 44:16 84:21]
  assign io_ppuWrite = io_cpuWrite & _GEN_27; // @[MemoryController.scala 45:15 84:21]
  assign io_ppuRead = io_cpuRead & _GEN_27; // @[MemoryController.scala 46:14 57:20]
  always @(posedge clock) begin
    if (internalRAM_MPORT_en & internalRAM_MPORT_mask) begin
      internalRAM[internalRAM_MPORT_addr] <= internalRAM_MPORT_data; // @[MemoryController.scala 35:32]
    end
    internalRAM_io_cpuDataOut_MPORT_en_pipe_0 <= io_cpuRead & _T;
    if (io_cpuRead & _T) begin
      internalRAM_io_cpuDataOut_MPORT_addr_pipe_0 <= io_cpuAddr[10:0];
    end
    if (prgROM_MPORT_1_en & prgROM_MPORT_1_mask) begin
      prgROM[prgROM_MPORT_1_addr] <= prgROM_MPORT_1_data; // @[MemoryController.scala 39:19]
    end
    if (prgROM_MPORT_2_en & prgROM_MPORT_2_mask) begin
      prgROM[prgROM_MPORT_2_addr] <= prgROM_MPORT_2_data; // @[MemoryController.scala 39:19]
    end
  end
endmodule
module NESSystem(
  input         clock,
  input         reset,
  output [8:0]  io_pixelX,
  output [8:0]  io_pixelY,
  output [5:0]  io_pixelColor,
  output        io_vblank,
  input  [7:0]  io_controller1,
  input  [7:0]  io_controller2,
  output [7:0]  io_debug_regA,
  output [7:0]  io_debug_regX,
  output [7:0]  io_debug_regY,
  output [15:0] io_debug_regPC,
  output [7:0]  io_debug_regSP,
  output        io_debug_flagC,
  output        io_debug_flagZ,
  output        io_debug_flagN,
  output        io_debug_flagV,
  output [7:0]  io_debug_opcode,
  output [1:0]  io_debug_state,
  output [2:0]  io_debug_cycle,
  output [7:0]  io_ppuDebug_ppuCtrl,
  output [7:0]  io_ppuDebug_ppuMask,
  output [7:0]  io_ppuDebug_ppuStatus,
  output [15:0] io_ppuDebug_ppuAddrReg,
  output        io_ppuDebug_paletteInitDone,
  input         io_romLoadEn,
  input  [15:0] io_romLoadAddr,
  input  [7:0]  io_romLoadData,
  input         io_romLoadPRG
);
  wire  cpu_clock; // @[NESSystem.scala 41:19]
  wire  cpu_reset; // @[NESSystem.scala 41:19]
  wire [15:0] cpu_io_memAddr; // @[NESSystem.scala 41:19]
  wire [7:0] cpu_io_memDataOut; // @[NESSystem.scala 41:19]
  wire [7:0] cpu_io_memDataIn; // @[NESSystem.scala 41:19]
  wire  cpu_io_memWrite; // @[NESSystem.scala 41:19]
  wire  cpu_io_memRead; // @[NESSystem.scala 41:19]
  wire [7:0] cpu_io_debug_regA; // @[NESSystem.scala 41:19]
  wire [7:0] cpu_io_debug_regX; // @[NESSystem.scala 41:19]
  wire [7:0] cpu_io_debug_regY; // @[NESSystem.scala 41:19]
  wire [15:0] cpu_io_debug_regPC; // @[NESSystem.scala 41:19]
  wire [7:0] cpu_io_debug_regSP; // @[NESSystem.scala 41:19]
  wire  cpu_io_debug_flagC; // @[NESSystem.scala 41:19]
  wire  cpu_io_debug_flagZ; // @[NESSystem.scala 41:19]
  wire  cpu_io_debug_flagN; // @[NESSystem.scala 41:19]
  wire  cpu_io_debug_flagV; // @[NESSystem.scala 41:19]
  wire [7:0] cpu_io_debug_opcode; // @[NESSystem.scala 41:19]
  wire [1:0] cpu_io_debug_state; // @[NESSystem.scala 41:19]
  wire [2:0] cpu_io_debug_cycle; // @[NESSystem.scala 41:19]
  wire  cpu_io_reset; // @[NESSystem.scala 41:19]
  wire  cpu_io_nmi; // @[NESSystem.scala 41:19]
  wire  ppu_clock; // @[NESSystem.scala 42:19]
  wire  ppu_reset; // @[NESSystem.scala 42:19]
  wire [2:0] ppu_io_cpuAddr; // @[NESSystem.scala 42:19]
  wire [7:0] ppu_io_cpuDataIn; // @[NESSystem.scala 42:19]
  wire [7:0] ppu_io_cpuDataOut; // @[NESSystem.scala 42:19]
  wire  ppu_io_cpuWrite; // @[NESSystem.scala 42:19]
  wire  ppu_io_cpuRead; // @[NESSystem.scala 42:19]
  wire [8:0] ppu_io_pixelX; // @[NESSystem.scala 42:19]
  wire [8:0] ppu_io_pixelY; // @[NESSystem.scala 42:19]
  wire [5:0] ppu_io_pixelColor; // @[NESSystem.scala 42:19]
  wire  ppu_io_vblank; // @[NESSystem.scala 42:19]
  wire  ppu_io_nmiOut; // @[NESSystem.scala 42:19]
  wire  ppu_io_chrLoadEn; // @[NESSystem.scala 42:19]
  wire [12:0] ppu_io_chrLoadAddr; // @[NESSystem.scala 42:19]
  wire [7:0] ppu_io_chrLoadData; // @[NESSystem.scala 42:19]
  wire [7:0] ppu_io_debug_ppuCtrl; // @[NESSystem.scala 42:19]
  wire [7:0] ppu_io_debug_ppuMask; // @[NESSystem.scala 42:19]
  wire [7:0] ppu_io_debug_ppuStatus; // @[NESSystem.scala 42:19]
  wire [15:0] ppu_io_debug_ppuAddrReg; // @[NESSystem.scala 42:19]
  wire  ppu_io_debug_paletteInitDone; // @[NESSystem.scala 42:19]
  wire  memory_clock; // @[NESSystem.scala 43:22]
  wire [15:0] memory_io_cpuAddr; // @[NESSystem.scala 43:22]
  wire [7:0] memory_io_cpuDataIn; // @[NESSystem.scala 43:22]
  wire [7:0] memory_io_cpuDataOut; // @[NESSystem.scala 43:22]
  wire  memory_io_cpuWrite; // @[NESSystem.scala 43:22]
  wire  memory_io_cpuRead; // @[NESSystem.scala 43:22]
  wire [2:0] memory_io_ppuAddr; // @[NESSystem.scala 43:22]
  wire [7:0] memory_io_ppuDataIn; // @[NESSystem.scala 43:22]
  wire [7:0] memory_io_ppuDataOut; // @[NESSystem.scala 43:22]
  wire  memory_io_ppuWrite; // @[NESSystem.scala 43:22]
  wire  memory_io_ppuRead; // @[NESSystem.scala 43:22]
  wire [7:0] memory_io_controller1; // @[NESSystem.scala 43:22]
  wire [7:0] memory_io_controller2; // @[NESSystem.scala 43:22]
  wire  memory_io_romLoadEn; // @[NESSystem.scala 43:22]
  wire [15:0] memory_io_romLoadAddr; // @[NESSystem.scala 43:22]
  wire [7:0] memory_io_romLoadData; // @[NESSystem.scala 43:22]
  wire  memory_io_romLoadPRG; // @[NESSystem.scala 43:22]
  CPU6502Refactored cpu ( // @[NESSystem.scala 41:19]
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
    .io_debug_regSP(cpu_io_debug_regSP),
    .io_debug_flagC(cpu_io_debug_flagC),
    .io_debug_flagZ(cpu_io_debug_flagZ),
    .io_debug_flagN(cpu_io_debug_flagN),
    .io_debug_flagV(cpu_io_debug_flagV),
    .io_debug_opcode(cpu_io_debug_opcode),
    .io_debug_state(cpu_io_debug_state),
    .io_debug_cycle(cpu_io_debug_cycle),
    .io_reset(cpu_io_reset),
    .io_nmi(cpu_io_nmi)
  );
  PPU ppu ( // @[NESSystem.scala 42:19]
    .clock(ppu_clock),
    .reset(ppu_reset),
    .io_cpuAddr(ppu_io_cpuAddr),
    .io_cpuDataIn(ppu_io_cpuDataIn),
    .io_cpuDataOut(ppu_io_cpuDataOut),
    .io_cpuWrite(ppu_io_cpuWrite),
    .io_cpuRead(ppu_io_cpuRead),
    .io_pixelX(ppu_io_pixelX),
    .io_pixelY(ppu_io_pixelY),
    .io_pixelColor(ppu_io_pixelColor),
    .io_vblank(ppu_io_vblank),
    .io_nmiOut(ppu_io_nmiOut),
    .io_chrLoadEn(ppu_io_chrLoadEn),
    .io_chrLoadAddr(ppu_io_chrLoadAddr),
    .io_chrLoadData(ppu_io_chrLoadData),
    .io_debug_ppuCtrl(ppu_io_debug_ppuCtrl),
    .io_debug_ppuMask(ppu_io_debug_ppuMask),
    .io_debug_ppuStatus(ppu_io_debug_ppuStatus),
    .io_debug_ppuAddrReg(ppu_io_debug_ppuAddrReg),
    .io_debug_paletteInitDone(ppu_io_debug_paletteInitDone)
  );
  MemoryController memory ( // @[NESSystem.scala 43:22]
    .clock(memory_clock),
    .io_cpuAddr(memory_io_cpuAddr),
    .io_cpuDataIn(memory_io_cpuDataIn),
    .io_cpuDataOut(memory_io_cpuDataOut),
    .io_cpuWrite(memory_io_cpuWrite),
    .io_cpuRead(memory_io_cpuRead),
    .io_ppuAddr(memory_io_ppuAddr),
    .io_ppuDataIn(memory_io_ppuDataIn),
    .io_ppuDataOut(memory_io_ppuDataOut),
    .io_ppuWrite(memory_io_ppuWrite),
    .io_ppuRead(memory_io_ppuRead),
    .io_controller1(memory_io_controller1),
    .io_controller2(memory_io_controller2),
    .io_romLoadEn(memory_io_romLoadEn),
    .io_romLoadAddr(memory_io_romLoadAddr),
    .io_romLoadData(memory_io_romLoadData),
    .io_romLoadPRG(memory_io_romLoadPRG)
  );
  assign io_pixelX = ppu_io_pixelX; // @[NESSystem.scala 68:13]
  assign io_pixelY = ppu_io_pixelY; // @[NESSystem.scala 69:13]
  assign io_pixelColor = ppu_io_pixelColor; // @[NESSystem.scala 70:17]
  assign io_vblank = ppu_io_vblank; // @[NESSystem.scala 71:13]
  assign io_debug_regA = cpu_io_debug_regA; // @[NESSystem.scala 74:12]
  assign io_debug_regX = cpu_io_debug_regX; // @[NESSystem.scala 74:12]
  assign io_debug_regY = cpu_io_debug_regY; // @[NESSystem.scala 74:12]
  assign io_debug_regPC = cpu_io_debug_regPC; // @[NESSystem.scala 74:12]
  assign io_debug_regSP = cpu_io_debug_regSP; // @[NESSystem.scala 74:12]
  assign io_debug_flagC = cpu_io_debug_flagC; // @[NESSystem.scala 74:12]
  assign io_debug_flagZ = cpu_io_debug_flagZ; // @[NESSystem.scala 74:12]
  assign io_debug_flagN = cpu_io_debug_flagN; // @[NESSystem.scala 74:12]
  assign io_debug_flagV = cpu_io_debug_flagV; // @[NESSystem.scala 74:12]
  assign io_debug_opcode = cpu_io_debug_opcode; // @[NESSystem.scala 74:12]
  assign io_debug_state = cpu_io_debug_state; // @[NESSystem.scala 74:12]
  assign io_debug_cycle = cpu_io_debug_cycle; // @[NESSystem.scala 74:12]
  assign io_ppuDebug_ppuCtrl = ppu_io_debug_ppuCtrl; // @[NESSystem.scala 75:15]
  assign io_ppuDebug_ppuMask = ppu_io_debug_ppuMask; // @[NESSystem.scala 75:15]
  assign io_ppuDebug_ppuStatus = ppu_io_debug_ppuStatus; // @[NESSystem.scala 75:15]
  assign io_ppuDebug_ppuAddrReg = ppu_io_debug_ppuAddrReg; // @[NESSystem.scala 75:15]
  assign io_ppuDebug_paletteInitDone = ppu_io_debug_paletteInitDone; // @[NESSystem.scala 75:15]
  assign cpu_clock = clock;
  assign cpu_reset = reset;
  assign cpu_io_memDataIn = memory_io_cpuDataOut; // @[NESSystem.scala 52:20]
  assign cpu_io_reset = reset; // @[NESSystem.scala 46:25]
  assign cpu_io_nmi = ppu_io_nmiOut; // @[NESSystem.scala 47:14]
  assign ppu_clock = clock;
  assign ppu_reset = reset;
  assign ppu_io_cpuAddr = memory_io_ppuAddr; // @[NESSystem.scala 57:18]
  assign ppu_io_cpuDataIn = memory_io_ppuDataIn; // @[NESSystem.scala 58:20]
  assign ppu_io_cpuWrite = memory_io_ppuWrite; // @[NESSystem.scala 60:19]
  assign ppu_io_cpuRead = memory_io_ppuRead; // @[NESSystem.scala 61:18]
  assign ppu_io_chrLoadEn = io_romLoadEn & ~io_romLoadPRG; // @[NESSystem.scala 84:36]
  assign ppu_io_chrLoadAddr = io_romLoadAddr[12:0]; // @[NESSystem.scala 85:39]
  assign ppu_io_chrLoadData = io_romLoadData; // @[NESSystem.scala 86:22]
  assign memory_clock = clock;
  assign memory_io_cpuAddr = cpu_io_memAddr; // @[NESSystem.scala 50:21]
  assign memory_io_cpuDataIn = cpu_io_memDataOut; // @[NESSystem.scala 51:23]
  assign memory_io_cpuWrite = cpu_io_memWrite; // @[NESSystem.scala 53:22]
  assign memory_io_cpuRead = cpu_io_memRead; // @[NESSystem.scala 54:21]
  assign memory_io_ppuDataOut = ppu_io_cpuDataOut; // @[NESSystem.scala 59:24]
  assign memory_io_controller1 = io_controller1; // @[NESSystem.scala 64:25]
  assign memory_io_controller2 = io_controller2; // @[NESSystem.scala 65:25]
  assign memory_io_romLoadEn = io_romLoadEn; // @[NESSystem.scala 78:23]
  assign memory_io_romLoadAddr = io_romLoadAddr; // @[NESSystem.scala 79:25]
  assign memory_io_romLoadData = io_romLoadData; // @[NESSystem.scala 80:25]
  assign memory_io_romLoadPRG = io_romLoadPRG; // @[NESSystem.scala 81:24]
endmodule
