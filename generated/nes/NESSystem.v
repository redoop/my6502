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
  reg  nmiPending; // @[CPU6502Core.scala 33:27]
  wire  _GEN_0 = io_nmi & ~nmiLast | nmiPending; // @[CPU6502Core.scala 39:28 40:16 33:27]
  wire  _T_5 = cycle == 3'h0; // @[CPU6502Core.scala 72:22]
  wire  _T_6 = cycle == 3'h1; // @[CPU6502Core.scala 78:28]
  wire  _T_7 = cycle == 3'h2; // @[CPU6502Core.scala 84:28]
  wire  _T_8 = cycle == 3'h3; // @[CPU6502Core.scala 91:28]
  wire  _T_9 = cycle == 3'h4; // @[CPU6502Core.scala 97:28]
  wire [15:0] resetVector = {io_memDataIn,operand[7:0]}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_4 = cycle == 3'h4 ? 3'h5 : 3'h0; // @[CPU6502Core.scala 101:19 111:19 97:37]
  wire [15:0] _GEN_5 = cycle == 3'h4 ? regs_pc : resetVector; // @[CPU6502Core.scala 108:21 21:21 97:37]
  wire [7:0] _GEN_6 = cycle == 3'h4 ? regs_sp : 8'hfd; // @[CPU6502Core.scala 109:21 21:21 97:37]
  wire  _GEN_7 = cycle == 3'h4 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 21:21 110:24 97:37]
  wire [2:0] _GEN_8 = cycle == 3'h4 ? state : 3'h1; // @[CPU6502Core.scala 112:19 25:22 97:37]
  wire [2:0] _GEN_11 = cycle == 3'h3 ? 3'h4 : _GEN_4; // @[CPU6502Core.scala 91:37 95:19]
  wire [15:0] _GEN_12 = cycle == 3'h3 ? regs_pc : _GEN_5; // @[CPU6502Core.scala 21:21 91:37]
  wire [7:0] _GEN_13 = cycle == 3'h3 ? regs_sp : _GEN_6; // @[CPU6502Core.scala 21:21 91:37]
  wire  _GEN_14 = cycle == 3'h3 ? regs_flagI : _GEN_7; // @[CPU6502Core.scala 21:21 91:37]
  wire [2:0] _GEN_15 = cycle == 3'h3 ? state : _GEN_8; // @[CPU6502Core.scala 25:22 91:37]
  wire [15:0] _GEN_16 = cycle == 3'h2 ? 16'hfffc : 16'hfffd; // @[CPU6502Core.scala 84:37 86:24]
  wire [15:0] _GEN_18 = cycle == 3'h2 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 84:37 88:21 28:24]
  wire [2:0] _GEN_19 = cycle == 3'h2 ? 3'h3 : _GEN_11; // @[CPU6502Core.scala 84:37 89:19]
  wire [15:0] _GEN_20 = cycle == 3'h2 ? regs_pc : _GEN_12; // @[CPU6502Core.scala 21:21 84:37]
  wire [7:0] _GEN_21 = cycle == 3'h2 ? regs_sp : _GEN_13; // @[CPU6502Core.scala 21:21 84:37]
  wire  _GEN_22 = cycle == 3'h2 ? regs_flagI : _GEN_14; // @[CPU6502Core.scala 21:21 84:37]
  wire [2:0] _GEN_23 = cycle == 3'h2 ? state : _GEN_15; // @[CPU6502Core.scala 25:22 84:37]
  wire [15:0] _GEN_24 = cycle == 3'h1 ? 16'hfffc : _GEN_16; // @[CPU6502Core.scala 78:37 80:24]
  wire [2:0] _GEN_26 = cycle == 3'h1 ? 3'h2 : _GEN_19; // @[CPU6502Core.scala 78:37 82:19]
  wire [15:0] _GEN_27 = cycle == 3'h1 ? operand : _GEN_18; // @[CPU6502Core.scala 28:24 78:37]
  wire [15:0] _GEN_28 = cycle == 3'h1 ? regs_pc : _GEN_20; // @[CPU6502Core.scala 21:21 78:37]
  wire [7:0] _GEN_29 = cycle == 3'h1 ? regs_sp : _GEN_21; // @[CPU6502Core.scala 21:21 78:37]
  wire  _GEN_30 = cycle == 3'h1 ? regs_flagI : _GEN_22; // @[CPU6502Core.scala 21:21 78:37]
  wire [2:0] _GEN_31 = cycle == 3'h1 ? state : _GEN_23; // @[CPU6502Core.scala 25:22 78:37]
  wire [15:0] _GEN_32 = cycle == 3'h0 ? 16'hfffc : _GEN_24; // @[CPU6502Core.scala 72:31 74:24]
  wire [15:0] _regs_pc_T_1 = regs_pc + 16'h1; // @[CPU6502Core.scala 125:32]
  wire [2:0] _GEN_41 = nmiPending ? 3'h3 : 3'h2; // @[CPU6502Core.scala 118:28 120:19 127:19]
  wire  _GEN_43 = nmiPending ? 1'h0 : 1'h1; // @[CPU6502Core.scala 118:28 52:17 123:24]
  wire [7:0] _GEN_44 = nmiPending ? opcode : io_memDataIn; // @[CPU6502Core.scala 118:28 124:20 27:24]
  wire [15:0] _GEN_45 = nmiPending ? regs_pc : _regs_pc_T_1; // @[CPU6502Core.scala 118:28 125:21 21:21]
  wire  _execResult_T = 8'h18 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_1 = 8'h38 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_2 = 8'hd8 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_3 = 8'hf8 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_4 = 8'h58 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_5 = 8'h78 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_6 = 8'hb8 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _GEN_46 = _execResult_T_6 ? 1'h0 : regs_flagV; // @[Flag.scala 14:13 24:20 31:34]
  wire  _GEN_47 = _execResult_T_5 | regs_flagI; // @[Flag.scala 14:13 24:20 30:34]
  wire  _GEN_48 = _execResult_T_5 ? regs_flagV : _GEN_46; // @[Flag.scala 14:13 24:20]
  wire  _GEN_49 = _execResult_T_4 ? 1'h0 : _GEN_47; // @[Flag.scala 24:20 29:34]
  wire  _GEN_50 = _execResult_T_4 ? regs_flagV : _GEN_48; // @[Flag.scala 14:13 24:20]
  wire  _GEN_51 = _execResult_T_3 | regs_flagD; // @[Flag.scala 14:13 24:20 28:34]
  wire  _GEN_52 = _execResult_T_3 ? regs_flagI : _GEN_49; // @[Flag.scala 14:13 24:20]
  wire  _GEN_53 = _execResult_T_3 ? regs_flagV : _GEN_50; // @[Flag.scala 14:13 24:20]
  wire  _GEN_54 = _execResult_T_2 ? 1'h0 : _GEN_51; // @[Flag.scala 24:20 27:34]
  wire  _GEN_55 = _execResult_T_2 ? regs_flagI : _GEN_52; // @[Flag.scala 14:13 24:20]
  wire  _GEN_56 = _execResult_T_2 ? regs_flagV : _GEN_53; // @[Flag.scala 14:13 24:20]
  wire  _GEN_57 = _execResult_T_1 | regs_flagC; // @[Flag.scala 14:13 24:20 26:34]
  wire  _GEN_58 = _execResult_T_1 ? regs_flagD : _GEN_54; // @[Flag.scala 14:13 24:20]
  wire  _GEN_59 = _execResult_T_1 ? regs_flagI : _GEN_55; // @[Flag.scala 14:13 24:20]
  wire  _GEN_60 = _execResult_T_1 ? regs_flagV : _GEN_56; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagC = _execResult_T ? 1'h0 : _GEN_57; // @[Flag.scala 24:20 25:34]
  wire  execResult_result_newRegs_flagD = _execResult_T ? regs_flagD : _GEN_58; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagI = _execResult_T ? regs_flagI : _GEN_59; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagV = _execResult_T ? regs_flagV : _GEN_60; // @[Flag.scala 14:13 24:20]
  wire  _execResult_T_15 = 8'haa == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_16 = 8'ha8 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_17 = 8'h8a == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_18 = 8'h98 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_19 = 8'hba == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_20 = 8'h9a == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_result_newRegs_flagZ_T = regs_a == 8'h0; // @[Transfer.scala 28:33]
  wire [7:0] _GEN_65 = _execResult_T_20 ? regs_x : regs_sp; // @[Transfer.scala 14:13 24:20 51:20]
  wire [7:0] _GEN_66 = _execResult_T_19 ? regs_sp : regs_x; // @[Transfer.scala 14:13 24:20 46:19]
  wire  _GEN_67 = _execResult_T_19 ? regs_sp[7] : regs_flagN; // @[Transfer.scala 14:13 24:20 47:23]
  wire  _GEN_68 = _execResult_T_19 ? regs_sp == 8'h0 : regs_flagZ; // @[Transfer.scala 14:13 24:20 48:23]
  wire [7:0] _GEN_69 = _execResult_T_19 ? regs_sp : _GEN_65; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_70 = _execResult_T_18 ? regs_y : regs_a; // @[Transfer.scala 14:13 24:20 41:19]
  wire  _GEN_71 = _execResult_T_18 ? regs_y[7] : _GEN_67; // @[Transfer.scala 24:20 42:23]
  wire  _GEN_72 = _execResult_T_18 ? regs_y == 8'h0 : _GEN_68; // @[Transfer.scala 24:20 43:23]
  wire [7:0] _GEN_73 = _execResult_T_18 ? regs_x : _GEN_66; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_74 = _execResult_T_18 ? regs_sp : _GEN_69; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_75 = _execResult_T_17 ? regs_x : _GEN_70; // @[Transfer.scala 24:20 36:19]
  wire  _GEN_76 = _execResult_T_17 ? regs_x[7] : _GEN_71; // @[Transfer.scala 24:20 37:23]
  wire  _GEN_77 = _execResult_T_17 ? regs_x == 8'h0 : _GEN_72; // @[Transfer.scala 24:20 38:23]
  wire [7:0] _GEN_78 = _execResult_T_17 ? regs_x : _GEN_73; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_79 = _execResult_T_17 ? regs_sp : _GEN_74; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_80 = _execResult_T_16 ? regs_a : regs_y; // @[Transfer.scala 14:13 24:20 31:19]
  wire  _GEN_81 = _execResult_T_16 ? regs_a[7] : _GEN_76; // @[Transfer.scala 24:20 32:23]
  wire  _GEN_82 = _execResult_T_16 ? _execResult_result_newRegs_flagZ_T : _GEN_77; // @[Transfer.scala 24:20 33:23]
  wire [7:0] _GEN_83 = _execResult_T_16 ? regs_a : _GEN_75; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_84 = _execResult_T_16 ? regs_x : _GEN_78; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_85 = _execResult_T_16 ? regs_sp : _GEN_79; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_x = _execResult_T_15 ? regs_a : _GEN_84; // @[Transfer.scala 24:20 26:19]
  wire  execResult_result_newRegs_1_flagN = _execResult_T_15 ? regs_a[7] : _GEN_81; // @[Transfer.scala 24:20 27:23]
  wire  execResult_result_newRegs_1_flagZ = _execResult_T_15 ? regs_a == 8'h0 : _GEN_82; // @[Transfer.scala 24:20 28:23]
  wire [7:0] execResult_result_newRegs_1_y = _execResult_T_15 ? regs_y : _GEN_80; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_a = _execResult_T_15 ? regs_a : _GEN_83; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_sp = _execResult_T_15 ? regs_sp : _GEN_85; // @[Transfer.scala 14:13 24:20]
  wire  _execResult_T_26 = 8'he8 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_27 = 8'hc8 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_28 = 8'hca == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_29 = 8'h88 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_30 = 8'h1a == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_31 = 8'h3a == opcode; // @[CPU6502Core.scala 222:20]
  wire [7:0] execResult_result_res = regs_x + 8'h1; // @[Arithmetic.scala 55:26]
  wire [7:0] execResult_result_res_1 = regs_y + 8'h1; // @[Arithmetic.scala 61:26]
  wire [7:0] execResult_result_res_2 = regs_x - 8'h1; // @[Arithmetic.scala 67:26]
  wire [7:0] execResult_result_res_3 = regs_y - 8'h1; // @[Arithmetic.scala 73:26]
  wire [7:0] execResult_result_res_4 = regs_a + 8'h1; // @[Arithmetic.scala 79:26]
  wire [7:0] execResult_result_res_5 = regs_a - 8'h1; // @[Arithmetic.scala 85:26]
  wire [7:0] _GEN_92 = _execResult_T_31 ? execResult_result_res_5 : regs_a; // @[Arithmetic.scala 43:13 53:20 86:19]
  wire  _GEN_93 = _execResult_T_31 ? execResult_result_res_5[7] : regs_flagN; // @[Arithmetic.scala 43:13 53:20 87:23]
  wire  _GEN_94 = _execResult_T_31 ? execResult_result_res_5 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 43:13 53:20 88:23]
  wire [7:0] _GEN_95 = _execResult_T_30 ? execResult_result_res_4 : _GEN_92; // @[Arithmetic.scala 53:20 80:19]
  wire  _GEN_96 = _execResult_T_30 ? execResult_result_res_4[7] : _GEN_93; // @[Arithmetic.scala 53:20 81:23]
  wire  _GEN_97 = _execResult_T_30 ? execResult_result_res_4 == 8'h0 : _GEN_94; // @[Arithmetic.scala 53:20 82:23]
  wire [7:0] _GEN_98 = _execResult_T_29 ? execResult_result_res_3 : regs_y; // @[Arithmetic.scala 43:13 53:20 74:19]
  wire  _GEN_99 = _execResult_T_29 ? execResult_result_res_3[7] : _GEN_96; // @[Arithmetic.scala 53:20 75:23]
  wire  _GEN_100 = _execResult_T_29 ? execResult_result_res_3 == 8'h0 : _GEN_97; // @[Arithmetic.scala 53:20 76:23]
  wire [7:0] _GEN_101 = _execResult_T_29 ? regs_a : _GEN_95; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] _GEN_102 = _execResult_T_28 ? execResult_result_res_2 : regs_x; // @[Arithmetic.scala 43:13 53:20 68:19]
  wire  _GEN_103 = _execResult_T_28 ? execResult_result_res_2[7] : _GEN_99; // @[Arithmetic.scala 53:20 69:23]
  wire  _GEN_104 = _execResult_T_28 ? execResult_result_res_2 == 8'h0 : _GEN_100; // @[Arithmetic.scala 53:20 70:23]
  wire [7:0] _GEN_105 = _execResult_T_28 ? regs_y : _GEN_98; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] _GEN_106 = _execResult_T_28 ? regs_a : _GEN_101; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] _GEN_107 = _execResult_T_27 ? execResult_result_res_1 : _GEN_105; // @[Arithmetic.scala 53:20 62:19]
  wire  _GEN_108 = _execResult_T_27 ? execResult_result_res_1[7] : _GEN_103; // @[Arithmetic.scala 53:20 63:23]
  wire  _GEN_109 = _execResult_T_27 ? execResult_result_res_1 == 8'h0 : _GEN_104; // @[Arithmetic.scala 53:20 64:23]
  wire [7:0] _GEN_110 = _execResult_T_27 ? regs_x : _GEN_102; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] _GEN_111 = _execResult_T_27 ? regs_a : _GEN_106; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] execResult_result_newRegs_2_x = _execResult_T_26 ? execResult_result_res : _GEN_110; // @[Arithmetic.scala 53:20 56:19]
  wire  execResult_result_newRegs_2_flagN = _execResult_T_26 ? execResult_result_res[7] : _GEN_108; // @[Arithmetic.scala 53:20 57:23]
  wire  execResult_result_newRegs_2_flagZ = _execResult_T_26 ? execResult_result_res == 8'h0 : _GEN_109; // @[Arithmetic.scala 53:20 58:23]
  wire [7:0] execResult_result_newRegs_2_y = _execResult_T_26 ? regs_y : _GEN_107; // @[Arithmetic.scala 43:13 53:20]
  wire [7:0] execResult_result_newRegs_2_a = _execResult_T_26 ? regs_a : _GEN_111; // @[Arithmetic.scala 43:13 53:20]
  wire [8:0] _execResult_result_sum_T = regs_a + io_memDataIn; // @[Arithmetic.scala 102:22]
  wire [8:0] _GEN_4184 = {{8'd0}, regs_flagC}; // @[Arithmetic.scala 102:35]
  wire [9:0] execResult_result_sum = _execResult_result_sum_T + _GEN_4184; // @[Arithmetic.scala 102:35]
  wire [7:0] execResult_result_newRegs_3_a = execResult_result_sum[7:0]; // @[Arithmetic.scala 103:21]
  wire  execResult_result_newRegs_3_flagC = execResult_result_sum[8]; // @[Arithmetic.scala 104:25]
  wire  execResult_result_newRegs_3_flagN = execResult_result_sum[7]; // @[Arithmetic.scala 105:25]
  wire  execResult_result_newRegs_3_flagZ = execResult_result_newRegs_3_a == 8'h0; // @[Arithmetic.scala 106:32]
  wire  execResult_result_newRegs_3_flagV = regs_a[7] == io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_3_flagN; // @[Arithmetic.scala 107:51]
  wire [8:0] _execResult_result_diff_T = regs_a - io_memDataIn; // @[Arithmetic.scala 127:23]
  wire  _execResult_result_diff_T_2 = ~regs_flagC; // @[Arithmetic.scala 127:40]
  wire [8:0] _GEN_4185 = {{8'd0}, _execResult_result_diff_T_2}; // @[Arithmetic.scala 127:36]
  wire [9:0] execResult_result_diff = _execResult_result_diff_T - _GEN_4185; // @[Arithmetic.scala 127:36]
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
  wire [15:0] _GEN_121 = 3'h1 == cycle ? operand : 16'h0; // @[Arithmetic.scala 379:19 373:20 388:24]
  wire [7:0] _GEN_123 = 3'h1 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 368:13 379:19 391:19]
  wire  _GEN_124 = 3'h1 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 368:13 379:19 392:23]
  wire  _GEN_125 = 3'h1 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 368:13 379:19 393:23]
  wire  _GEN_126 = 3'h1 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 368:13 379:19 394:23]
  wire  _GEN_127 = 3'h1 == cycle ? execResult_result_res_6 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 368:13 379:19 395:23]
  wire [7:0] execResult_result_newRegs_5_a = 3'h0 == cycle ? regs_a : _GEN_123; // @[Arithmetic.scala 368:13 379:19]
  wire [15:0] execResult_result_newRegs_5_pc = 3'h0 == cycle ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 368:13 379:19 384:20]
  wire  execResult_result_newRegs_5_flagC = 3'h0 == cycle ? regs_flagC : _GEN_124; // @[Arithmetic.scala 368:13 379:19]
  wire  execResult_result_newRegs_5_flagZ = 3'h0 == cycle ? regs_flagZ : _GEN_127; // @[Arithmetic.scala 368:13 379:19]
  wire  execResult_result_newRegs_5_flagV = 3'h0 == cycle ? regs_flagV : _GEN_125; // @[Arithmetic.scala 368:13 379:19]
  wire  execResult_result_newRegs_5_flagN = 3'h0 == cycle ? regs_flagN : _GEN_126; // @[Arithmetic.scala 368:13 379:19]
  wire [15:0] execResult_result_result_6_memAddr = 3'h0 == cycle ? regs_pc : _GEN_121; // @[Arithmetic.scala 379:19 381:24]
  wire  execResult_result_result_6_memRead = 3'h0 == cycle | 3'h1 == cycle; // @[Arithmetic.scala 379:19 382:24]
  wire [15:0] execResult_result_result_6_operand = 3'h0 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Arithmetic.scala 379:19 377:20 383:24]
  wire  execResult_result_result_6_done = 3'h0 == cycle ? 1'h0 : 3'h1 == cycle; // @[Arithmetic.scala 370:17 379:19]
  wire [7:0] _execResult_result_result_operand_T_1 = io_memDataIn + regs_x; // @[Arithmetic.scala 423:38]
  wire [15:0] execResult_result_result_7_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : operand; // @[Arithmetic.scala 419:19 417:20 423:24]
  wire  _execResult_result_T_26 = 3'h2 == cycle; // @[Arithmetic.scala 459:19]
  wire [15:0] _GEN_211 = 3'h2 == cycle ? operand : 16'h0; // @[Arithmetic.scala 459:19 453:20 475:24]
  wire [7:0] _GEN_213 = 3'h2 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 448:13 459:19 478:19]
  wire  _GEN_214 = 3'h2 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 448:13 459:19 479:23]
  wire  _GEN_215 = 3'h2 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 448:13 459:19 480:23]
  wire  _GEN_216 = 3'h2 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 448:13 459:19 481:23]
  wire  _GEN_217 = 3'h2 == cycle ? _execResult_result_newRegs_flagZ_T_15 : regs_flagZ; // @[Arithmetic.scala 448:13 459:19 482:23]
  wire [7:0] _GEN_246 = _execResult_result_T_21 ? regs_a : _GEN_213; // @[Arithmetic.scala 448:13 459:19]
  wire [7:0] execResult_result_newRegs_7_a = _execResult_result_T_20 ? regs_a : _GEN_246; // @[Arithmetic.scala 448:13 459:19]
  wire [15:0] _GEN_233 = _execResult_result_T_21 ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 448:13 459:19 471:20]
  wire [15:0] execResult_result_newRegs_7_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_233; // @[Arithmetic.scala 459:19 464:20]
  wire  _GEN_247 = _execResult_result_T_21 ? regs_flagC : _GEN_214; // @[Arithmetic.scala 448:13 459:19]
  wire  execResult_result_newRegs_7_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_247; // @[Arithmetic.scala 448:13 459:19]
  wire  _GEN_250 = _execResult_result_T_21 ? regs_flagZ : _GEN_217; // @[Arithmetic.scala 448:13 459:19]
  wire  execResult_result_newRegs_7_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_250; // @[Arithmetic.scala 448:13 459:19]
  wire  _GEN_248 = _execResult_result_T_21 ? regs_flagV : _GEN_215; // @[Arithmetic.scala 448:13 459:19]
  wire  execResult_result_newRegs_7_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_248; // @[Arithmetic.scala 448:13 459:19]
  wire  _GEN_249 = _execResult_result_T_21 ? regs_flagN : _GEN_216; // @[Arithmetic.scala 448:13 459:19]
  wire  execResult_result_newRegs_7_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_249; // @[Arithmetic.scala 448:13 459:19]
  wire [15:0] _GEN_230 = _execResult_result_T_21 ? regs_pc : _GEN_211; // @[Arithmetic.scala 459:19 468:24]
  wire  _GEN_231 = _execResult_result_T_21 | 3'h2 == cycle; // @[Arithmetic.scala 459:19 469:24]
  wire [15:0] _GEN_232 = _execResult_result_T_21 ? resetVector : operand; // @[Arithmetic.scala 459:19 457:20 470:24]
  wire  _GEN_251 = _execResult_result_T_21 ? 1'h0 : 3'h2 == cycle; // @[Arithmetic.scala 450:17 459:19]
  wire [15:0] execResult_result_result_8_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_230; // @[Arithmetic.scala 459:19 461:24]
  wire  execResult_result_result_8_memRead = _execResult_result_T_20 | _GEN_231; // @[Arithmetic.scala 459:19 462:24]
  wire [15:0] execResult_result_result_8_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_232; // @[Arithmetic.scala 459:19 463:24]
  wire  execResult_result_result_8_done = _execResult_result_T_20 ? 1'h0 : _GEN_251; // @[Arithmetic.scala 450:17 459:19]
  wire [15:0] _execResult_result_result_operand_T_9 = {operand[15:8],io_memDataIn}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_result_memAddr_T_3 = operand[7:0] + 8'h1; // @[Arithmetic.scala 520:42]
  wire  _execResult_result_T_30 = 3'h3 == cycle; // @[Arithmetic.scala 506:19]
  wire [15:0] _GEN_278 = 3'h3 == cycle ? operand : 16'h0; // @[Arithmetic.scala 506:19 500:20 525:24]
  wire [7:0] _GEN_280 = 3'h3 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 495:13 506:19 528:19]
  wire  _GEN_281 = 3'h3 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 495:13 506:19 529:23]
  wire  _GEN_282 = 3'h3 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 495:13 506:19 530:23]
  wire  _GEN_283 = 3'h3 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 495:13 506:19 531:23]
  wire  _GEN_284 = 3'h3 == cycle ? _execResult_result_newRegs_flagZ_T_15 : regs_flagZ; // @[Arithmetic.scala 495:13 506:19 532:23]
  wire [7:0] _GEN_300 = _execResult_result_T_26 ? regs_a : _GEN_280; // @[Arithmetic.scala 495:13 506:19]
  wire [7:0] _GEN_321 = _execResult_result_T_21 ? regs_a : _GEN_300; // @[Arithmetic.scala 495:13 506:19]
  wire [7:0] execResult_result_newRegs_8_a = _execResult_result_T_20 ? regs_a : _GEN_321; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_301 = _execResult_result_T_26 ? regs_flagC : _GEN_281; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_322 = _execResult_result_T_21 ? regs_flagC : _GEN_301; // @[Arithmetic.scala 495:13 506:19]
  wire  execResult_result_newRegs_8_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_322; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_304 = _execResult_result_T_26 ? regs_flagZ : _GEN_284; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_325 = _execResult_result_T_21 ? regs_flagZ : _GEN_304; // @[Arithmetic.scala 495:13 506:19]
  wire  execResult_result_newRegs_8_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_325; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_302 = _execResult_result_T_26 ? regs_flagV : _GEN_282; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_323 = _execResult_result_T_21 ? regs_flagV : _GEN_302; // @[Arithmetic.scala 495:13 506:19]
  wire  execResult_result_newRegs_8_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_323; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_303 = _execResult_result_T_26 ? regs_flagN : _GEN_283; // @[Arithmetic.scala 495:13 506:19]
  wire  _GEN_324 = _execResult_result_T_21 ? regs_flagN : _GEN_303; // @[Arithmetic.scala 495:13 506:19]
  wire  execResult_result_newRegs_8_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_324; // @[Arithmetic.scala 495:13 506:19]
  wire [15:0] _GEN_297 = _execResult_result_T_26 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_278; // @[Arithmetic.scala 506:19 520:24]
  wire  _GEN_298 = _execResult_result_T_26 | 3'h3 == cycle; // @[Arithmetic.scala 506:19 521:24]
  wire [15:0] _GEN_299 = _execResult_result_T_26 ? resetVector : operand; // @[Arithmetic.scala 506:19 504:20 522:24]
  wire  _GEN_317 = _execResult_result_T_26 ? 1'h0 : 3'h3 == cycle; // @[Arithmetic.scala 497:17 506:19]
  wire [15:0] _GEN_318 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_297; // @[Arithmetic.scala 506:19 515:24]
  wire  _GEN_319 = _execResult_result_T_21 | _GEN_298; // @[Arithmetic.scala 506:19 516:24]
  wire [15:0] _GEN_320 = _execResult_result_T_21 ? _execResult_result_result_operand_T_9 : _GEN_299; // @[Arithmetic.scala 506:19 517:24]
  wire  _GEN_338 = _execResult_result_T_21 ? 1'h0 : _GEN_317; // @[Arithmetic.scala 497:17 506:19]
  wire [15:0] execResult_result_result_9_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_318; // @[Arithmetic.scala 506:19 508:24]
  wire  execResult_result_result_9_memRead = _execResult_result_T_20 | _GEN_319; // @[Arithmetic.scala 506:19 509:24]
  wire [15:0] execResult_result_result_9_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : _GEN_320; // @[Arithmetic.scala 506:19 510:24]
  wire  execResult_result_result_9_done = _execResult_result_T_20 ? 1'h0 : _GEN_338; // @[Arithmetic.scala 497:17 506:19]
  wire [15:0] _GEN_4194 = {{8'd0}, regs_y}; // @[Arithmetic.scala 572:57]
  wire [15:0] _execResult_result_result_operand_T_17 = resetVector + _GEN_4194; // @[Arithmetic.scala 572:57]
  wire [15:0] _GEN_386 = _execResult_result_T_26 ? _execResult_result_result_operand_T_17 : operand; // @[Arithmetic.scala 556:19 554:20 572:24]
  wire [15:0] _GEN_407 = _execResult_result_T_21 ? _execResult_result_result_operand_T_9 : _GEN_386; // @[Arithmetic.scala 556:19 567:24]
  wire [15:0] execResult_result_result_10_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_407; // @[Arithmetic.scala 556:19 560:24]
  wire [7:0] _execResult_result_res_T_8 = io_memDataIn + 8'h1; // @[Arithmetic.scala 177:52]
  wire [7:0] _execResult_result_res_T_10 = io_memDataIn - 8'h1; // @[Arithmetic.scala 177:69]
  wire [7:0] execResult_result_res_11 = opcode == 8'he6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 177:22]
  wire [7:0] _GEN_449 = _execResult_result_T_26 ? execResult_result_res_11 : 8'h0; // @[Arithmetic.scala 161:19 156:20 178:24]
  wire  _GEN_451 = _execResult_result_T_26 ? execResult_result_res_11[7] : regs_flagN; // @[Arithmetic.scala 150:13 161:19 180:23]
  wire  _GEN_452 = _execResult_result_T_26 ? execResult_result_res_11 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 150:13 161:19 181:23]
  wire  _GEN_471 = _execResult_result_T_21 ? regs_flagZ : _GEN_452; // @[Arithmetic.scala 150:13 161:19]
  wire  execResult_result_newRegs_10_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_471; // @[Arithmetic.scala 150:13 161:19]
  wire  _GEN_470 = _execResult_result_T_21 ? regs_flagN : _GEN_451; // @[Arithmetic.scala 150:13 161:19]
  wire  execResult_result_newRegs_10_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_470; // @[Arithmetic.scala 150:13 161:19]
  wire [15:0] _GEN_465 = _execResult_result_T_21 ? operand : _GEN_211; // @[Arithmetic.scala 161:19 171:24]
  wire [2:0] _GEN_467 = _execResult_result_T_21 ? 3'h2 : execResult_result_result_6_nextCycle; // @[Arithmetic.scala 161:19 153:22 173:26]
  wire [7:0] _GEN_468 = _execResult_result_T_21 ? 8'h0 : _GEN_449; // @[Arithmetic.scala 161:19 156:20]
  wire [15:0] execResult_result_result_11_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_465; // @[Arithmetic.scala 161:19 163:24]
  wire [2:0] execResult_result_result_11_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_467; // @[Arithmetic.scala 161:19 168:26]
  wire [7:0] execResult_result_result_11_memData = _execResult_result_T_20 ? 8'h0 : _GEN_468; // @[Arithmetic.scala 161:19 156:20]
  wire [7:0] execResult_result_res_12 = opcode == 8'hf6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 219:22]
  wire [7:0] _GEN_506 = _execResult_result_T_26 ? execResult_result_res_12 : 8'h0; // @[Arithmetic.scala 205:19 200:20 220:24]
  wire  _GEN_508 = _execResult_result_T_26 ? execResult_result_res_12[7] : regs_flagN; // @[Arithmetic.scala 194:13 205:19 222:23]
  wire  _GEN_509 = _execResult_result_T_26 ? execResult_result_res_12 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 194:13 205:19 223:23]
  wire  _GEN_527 = _execResult_result_T_21 ? regs_flagZ : _GEN_509; // @[Arithmetic.scala 194:13 205:19]
  wire  execResult_result_newRegs_11_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_527; // @[Arithmetic.scala 194:13 205:19]
  wire  _GEN_526 = _execResult_result_T_21 ? regs_flagN : _GEN_508; // @[Arithmetic.scala 194:13 205:19]
  wire  execResult_result_newRegs_11_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_526; // @[Arithmetic.scala 194:13 205:19]
  wire [7:0] _GEN_524 = _execResult_result_T_21 ? 8'h0 : _GEN_506; // @[Arithmetic.scala 205:19 200:20]
  wire [7:0] execResult_result_result_12_memData = _execResult_result_T_20 ? 8'h0 : _GEN_524; // @[Arithmetic.scala 205:19 200:20]
  wire [7:0] execResult_result_res_13 = opcode == 8'hee ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 272:22]
  wire [7:0] _GEN_561 = _execResult_result_T_30 ? execResult_result_res_13 : 8'h0; // @[Arithmetic.scala 247:19 242:20 273:24]
  wire  _GEN_563 = _execResult_result_T_30 ? execResult_result_res_13[7] : regs_flagN; // @[Arithmetic.scala 236:13 247:19 275:23]
  wire  _GEN_564 = _execResult_result_T_30 ? execResult_result_res_13 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 236:13 247:19 276:23]
  wire  _GEN_582 = _execResult_result_T_26 ? regs_flagZ : _GEN_564; // @[Arithmetic.scala 236:13 247:19]
  wire  _GEN_614 = _execResult_result_T_21 ? regs_flagZ : _GEN_582; // @[Arithmetic.scala 236:13 247:19]
  wire  execResult_result_newRegs_12_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_614; // @[Arithmetic.scala 236:13 247:19]
  wire  _GEN_581 = _execResult_result_T_26 ? regs_flagN : _GEN_563; // @[Arithmetic.scala 236:13 247:19]
  wire  _GEN_613 = _execResult_result_T_21 ? regs_flagN : _GEN_581; // @[Arithmetic.scala 236:13 247:19]
  wire  execResult_result_newRegs_12_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_613; // @[Arithmetic.scala 236:13 247:19]
  wire [15:0] _GEN_577 = _execResult_result_T_26 ? operand : _GEN_278; // @[Arithmetic.scala 247:19 266:24]
  wire [7:0] _GEN_579 = _execResult_result_T_26 ? 8'h0 : _GEN_561; // @[Arithmetic.scala 247:19 242:20]
  wire [15:0] _GEN_595 = _execResult_result_T_21 ? regs_pc : _GEN_577; // @[Arithmetic.scala 247:19 258:24]
  wire [7:0] _GEN_611 = _execResult_result_T_21 ? 8'h0 : _GEN_579; // @[Arithmetic.scala 247:19 242:20]
  wire [15:0] execResult_result_result_13_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_595; // @[Arithmetic.scala 247:19 250:24]
  wire [7:0] execResult_result_result_13_memData = _execResult_result_T_20 ? 8'h0 : _GEN_611; // @[Arithmetic.scala 247:19 242:20]
  wire [15:0] _GEN_4197 = {{8'd0}, regs_x}; // @[Arithmetic.scala 311:57]
  wire [15:0] _execResult_result_result_operand_T_26 = resetVector + _GEN_4197; // @[Arithmetic.scala 311:57]
  wire [7:0] execResult_result_res_14 = opcode == 8'hfe ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 321:22]
  wire [7:0] _GEN_636 = _execResult_result_T_30 ? execResult_result_res_14 : 8'h0; // @[Arithmetic.scala 300:19 295:20 322:24]
  wire  _GEN_638 = _execResult_result_T_30 ? execResult_result_res_14[7] : regs_flagN; // @[Arithmetic.scala 289:13 300:19 324:23]
  wire  _GEN_639 = _execResult_result_T_30 ? execResult_result_res_14 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 289:13 300:19 325:23]
  wire  _GEN_657 = _execResult_result_T_26 ? regs_flagZ : _GEN_639; // @[Arithmetic.scala 289:13 300:19]
  wire  _GEN_689 = _execResult_result_T_21 ? regs_flagZ : _GEN_657; // @[Arithmetic.scala 289:13 300:19]
  wire  execResult_result_newRegs_13_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_689; // @[Arithmetic.scala 289:13 300:19]
  wire  _GEN_656 = _execResult_result_T_26 ? regs_flagN : _GEN_638; // @[Arithmetic.scala 289:13 300:19]
  wire  _GEN_688 = _execResult_result_T_21 ? regs_flagN : _GEN_656; // @[Arithmetic.scala 289:13 300:19]
  wire  execResult_result_newRegs_13_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_688; // @[Arithmetic.scala 289:13 300:19]
  wire [7:0] _GEN_654 = _execResult_result_T_26 ? 8'h0 : _GEN_636; // @[Arithmetic.scala 300:19 295:20]
  wire [15:0] _GEN_672 = _execResult_result_T_21 ? _execResult_result_result_operand_T_26 : operand; // @[Arithmetic.scala 300:19 298:20 311:24]
  wire [7:0] _GEN_686 = _execResult_result_T_21 ? 8'h0 : _GEN_654; // @[Arithmetic.scala 300:19 295:20]
  wire [15:0] execResult_result_result_14_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_672; // @[Arithmetic.scala 300:19 304:24]
  wire [7:0] execResult_result_result_14_memData = _execResult_result_T_20 ? 8'h0 : _GEN_686; // @[Arithmetic.scala 300:19 295:20]
  wire  execResult_result_useY = _execResult_result_isADC_T_9 | opcode == 8'hf9; // @[Arithmetic.scala 607:36]
  wire [7:0] execResult_result_index = execResult_result_useY ? regs_y : regs_x; // @[Arithmetic.scala 608:20]
  wire [15:0] _GEN_4198 = {{8'd0}, execResult_result_index}; // @[Arithmetic.scala 629:28]
  wire [15:0] execResult_result_addr = operand + _GEN_4198; // @[Arithmetic.scala 629:28]
  wire  execResult_result_isADC_5 = _execResult_result_isADC_T_9 | _execResult_result_isADC_T_7; // @[Arithmetic.scala 635:41]
  wire [7:0] _GEN_710 = execResult_result_isADC_5 ? execResult_result_newRegs_3_a : execResult_result_newRegs_4_a; // @[Arithmetic.scala 637:21 640:21 648:21]
  wire  _GEN_711 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagC : execResult_result_newRegs_4_flagC; // @[Arithmetic.scala 637:21 641:25 649:25]
  wire  _GEN_712 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagN : execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 637:21 642:25 650:25]
  wire  _GEN_713 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagZ : execResult_result_newRegs_4_flagZ; // @[Arithmetic.scala 637:21 643:25 651:25]
  wire  _GEN_714 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagV : execResult_result_newRegs_4_flagV; // @[Arithmetic.scala 637:21 644:25 652:25]
  wire [7:0] _GEN_715 = _execResult_result_T_30 ? _GEN_710 : regs_a; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_716 = _execResult_result_T_30 ? _GEN_711 : regs_flagC; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_717 = _execResult_result_T_30 ? _GEN_712 : regs_flagN; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_718 = _execResult_result_T_30 ? _GEN_713 : regs_flagZ; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_719 = _execResult_result_T_30 ? _GEN_714 : regs_flagV; // @[Arithmetic.scala 595:13 610:19]
  wire [7:0] _GEN_735 = _execResult_result_T_26 ? regs_a : _GEN_715; // @[Arithmetic.scala 595:13 610:19]
  wire [7:0] _GEN_769 = _execResult_result_T_21 ? regs_a : _GEN_735; // @[Arithmetic.scala 595:13 610:19]
  wire [7:0] execResult_result_newRegs_14_a = _execResult_result_T_20 ? regs_a : _GEN_769; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_736 = _execResult_result_T_26 ? regs_flagC : _GEN_716; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_770 = _execResult_result_T_21 ? regs_flagC : _GEN_736; // @[Arithmetic.scala 595:13 610:19]
  wire  execResult_result_newRegs_14_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_770; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_738 = _execResult_result_T_26 ? regs_flagZ : _GEN_718; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_772 = _execResult_result_T_21 ? regs_flagZ : _GEN_738; // @[Arithmetic.scala 595:13 610:19]
  wire  execResult_result_newRegs_14_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_772; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_739 = _execResult_result_T_26 ? regs_flagV : _GEN_719; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_773 = _execResult_result_T_21 ? regs_flagV : _GEN_739; // @[Arithmetic.scala 595:13 610:19]
  wire  execResult_result_newRegs_14_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_773; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_737 = _execResult_result_T_26 ? regs_flagN : _GEN_717; // @[Arithmetic.scala 595:13 610:19]
  wire  _GEN_771 = _execResult_result_T_21 ? regs_flagN : _GEN_737; // @[Arithmetic.scala 595:13 610:19]
  wire  execResult_result_newRegs_14_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_771; // @[Arithmetic.scala 595:13 610:19]
  wire [15:0] _GEN_733 = _execResult_result_T_26 ? execResult_result_addr : 16'h0; // @[Arithmetic.scala 610:19 600:20 630:24]
  wire [15:0] _GEN_753 = _execResult_result_T_21 ? regs_pc : _GEN_733; // @[Arithmetic.scala 610:19 621:24]
  wire [15:0] execResult_result_result_15_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_753; // @[Arithmetic.scala 610:19 613:24]
  wire  _execResult_T_73 = 8'h29 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_74 = 8'h9 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_75 = 8'h49 == opcode; // @[CPU6502Core.scala 222:20]
  wire [7:0] _execResult_result_res_T_26 = regs_a & io_memDataIn; // @[Logic.scala 32:34]
  wire [7:0] _execResult_result_res_T_27 = regs_a | io_memDataIn; // @[Logic.scala 33:34]
  wire [7:0] _execResult_result_res_T_28 = regs_a ^ io_memDataIn; // @[Logic.scala 34:34]
  wire [7:0] _GEN_797 = _execResult_T_75 ? _execResult_result_res_T_28 : 8'h0; // @[Logic.scala 31:20 34:24 29:9]
  wire [7:0] _GEN_798 = _execResult_T_74 ? _execResult_result_res_T_27 : _GEN_797; // @[Logic.scala 31:20 33:24]
  wire [7:0] execResult_result_res_15 = _execResult_T_73 ? _execResult_result_res_T_26 : _GEN_798; // @[Logic.scala 31:20 32:24]
  wire  execResult_result_newRegs_15_flagN = execResult_result_res_15[7]; // @[Logic.scala 38:25]
  wire  execResult_result_newRegs_15_flagZ = execResult_result_res_15 == 8'h0; // @[Logic.scala 39:26]
  wire  _GEN_802 = _execResult_result_T_21 ? _execResult_result_res_T_26 == 8'h0 : regs_flagZ; // @[Logic.scala 57:13 68:19 80:23]
  wire  _GEN_803 = _execResult_result_T_21 ? io_memDataIn[7] : regs_flagN; // @[Logic.scala 57:13 68:19 81:23]
  wire  _GEN_804 = _execResult_result_T_21 ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 57:13 68:19 82:23]
  wire  execResult_result_newRegs_16_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_802; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_16_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_804; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_16_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_803; // @[Logic.scala 57:13 68:19]
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
  wire [7:0] _GEN_840 = _execResult_result_T_21 ? execResult_result_res_16 : regs_a; // @[Logic.scala 107:13 118:19 130:19]
  wire  _GEN_841 = _execResult_result_T_21 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 107:13 118:19 131:23]
  wire  _GEN_842 = _execResult_result_T_21 ? execResult_result_res_16 == 8'h0 : regs_flagZ; // @[Logic.scala 107:13 118:19 132:23]
  wire [7:0] execResult_result_newRegs_17_a = _execResult_result_T_20 ? regs_a : _GEN_840; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_17_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_842; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_17_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_841; // @[Logic.scala 107:13 118:19]
  wire [7:0] _GEN_914 = _execResult_result_T_26 ? execResult_result_res_16 : regs_a; // @[Logic.scala 183:13 194:19 213:19]
  wire  _GEN_915 = _execResult_result_T_26 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 183:13 194:19 214:23]
  wire  _GEN_916 = _execResult_result_T_26 ? _execResult_result_newRegs_flagZ_T_31 : regs_flagZ; // @[Logic.scala 183:13 194:19 215:23]
  wire [7:0] _GEN_945 = _execResult_result_T_21 ? regs_a : _GEN_914; // @[Logic.scala 183:13 194:19]
  wire [7:0] execResult_result_newRegs_19_a = _execResult_result_T_20 ? regs_a : _GEN_945; // @[Logic.scala 183:13 194:19]
  wire  _GEN_947 = _execResult_result_T_21 ? regs_flagZ : _GEN_916; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_947; // @[Logic.scala 183:13 194:19]
  wire  _GEN_946 = _execResult_result_T_21 ? regs_flagN : _GEN_915; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_946; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_useY_1 = _execResult_result_res_T_38 | _execResult_result_res_T_54 |
    _execResult_result_res_T_70; // @[Logic.scala 240:59]
  wire [7:0] execResult_result_index_1 = execResult_result_useY_1 ? regs_y : regs_x; // @[Logic.scala 241:20]
  wire [15:0] _GEN_4201 = {{8'd0}, execResult_result_index_1}; // @[Logic.scala 254:57]
  wire [15:0] _execResult_result_result_operand_T_37 = resetVector + _GEN_4201; // @[Logic.scala 254:57]
  wire [15:0] _GEN_988 = _execResult_result_T_21 ? _execResult_result_result_operand_T_37 : operand; // @[Logic.scala 243:19 237:20 254:24]
  wire [15:0] execResult_result_result_21_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_988; // @[Logic.scala 243:19 247:24]
  wire [7:0] _GEN_1028 = _execResult_result_T_30 ? execResult_result_res_16 : regs_a; // @[Logic.scala 277:13 288:19 314:19]
  wire  _GEN_1029 = _execResult_result_T_30 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 277:13 288:19 315:23]
  wire  _GEN_1030 = _execResult_result_T_30 ? _execResult_result_newRegs_flagZ_T_31 : regs_flagZ; // @[Logic.scala 277:13 288:19 316:23]
  wire [7:0] _GEN_1046 = _execResult_result_T_26 ? regs_a : _GEN_1028; // @[Logic.scala 277:13 288:19]
  wire [7:0] _GEN_1065 = _execResult_result_T_21 ? regs_a : _GEN_1046; // @[Logic.scala 277:13 288:19]
  wire [7:0] execResult_result_newRegs_21_a = _execResult_result_T_20 ? regs_a : _GEN_1065; // @[Logic.scala 277:13 288:19]
  wire  _GEN_1048 = _execResult_result_T_26 ? regs_flagZ : _GEN_1030; // @[Logic.scala 277:13 288:19]
  wire  _GEN_1067 = _execResult_result_T_21 ? regs_flagZ : _GEN_1048; // @[Logic.scala 277:13 288:19]
  wire  execResult_result_newRegs_21_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1067; // @[Logic.scala 277:13 288:19]
  wire  _GEN_1047 = _execResult_result_T_26 ? regs_flagN : _GEN_1029; // @[Logic.scala 277:13 288:19]
  wire  _GEN_1066 = _execResult_result_T_21 ? regs_flagN : _GEN_1047; // @[Logic.scala 277:13 288:19]
  wire  execResult_result_newRegs_21_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1066; // @[Logic.scala 277:13 288:19]
  wire  _execResult_T_117 = 8'ha == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_118 = 8'h4a == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_119 = 8'h2a == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_120 = 8'h6a == opcode; // @[CPU6502Core.scala 222:20]
  wire [8:0] _execResult_result_res_T_329 = {regs_a, 1'h0}; // @[Shift.scala 39:24]
  wire [7:0] _execResult_result_res_T_333 = {regs_a[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_335 = {regs_flagC,regs_a[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_1176 = _execResult_T_120 ? regs_a[0] : regs_flagC; // @[Shift.scala 22:13 36:20 50:23]
  wire [7:0] _GEN_1177 = _execResult_T_120 ? _execResult_result_res_T_335 : regs_a; // @[Shift.scala 36:20 51:13 33:9]
  wire  _GEN_1178 = _execResult_T_119 ? regs_a[7] : _GEN_1176; // @[Shift.scala 36:20 46:23]
  wire [7:0] _GEN_1179 = _execResult_T_119 ? _execResult_result_res_T_333 : _GEN_1177; // @[Shift.scala 36:20 47:13]
  wire  _GEN_1180 = _execResult_T_118 ? regs_a[0] : _GEN_1178; // @[Shift.scala 36:20 42:23]
  wire [7:0] _GEN_1181 = _execResult_T_118 ? {{1'd0}, regs_a[7:1]} : _GEN_1179; // @[Shift.scala 36:20 43:13]
  wire  execResult_result_newRegs_23_flagC = _execResult_T_117 ? regs_a[7] : _GEN_1180; // @[Shift.scala 36:20 38:23]
  wire [7:0] execResult_result_res_22 = _execResult_T_117 ? _execResult_result_res_T_329[7:0] : _GEN_1181; // @[Shift.scala 36:20 39:13]
  wire  execResult_result_newRegs_23_flagN = execResult_result_res_22[7]; // @[Shift.scala 56:25]
  wire  execResult_result_newRegs_23_flagZ = execResult_result_res_22 == 8'h0; // @[Shift.scala 57:26]
  wire  _execResult_T_124 = 8'h6 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_125 = 8'h46 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_126 = 8'h26 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_127 = 8'h66 == opcode; // @[CPU6502Core.scala 222:20]
  wire [8:0] _execResult_result_res_T_336 = {io_memDataIn, 1'h0}; // @[Shift.scala 99:31]
  wire [7:0] _execResult_result_res_T_340 = {io_memDataIn[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_342 = {regs_flagC,io_memDataIn[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_1184 = _execResult_T_127 ? io_memDataIn[0] : regs_flagC; // @[Shift.scala 96:24 112:27 66:13]
  wire [7:0] _GEN_1185 = _execResult_T_127 ? _execResult_result_res_T_342 : 8'h0; // @[Shift.scala 113:17 94:13 96:24]
  wire  _GEN_1186 = _execResult_T_126 ? io_memDataIn[7] : _GEN_1184; // @[Shift.scala 96:24 107:27]
  wire [7:0] _GEN_1187 = _execResult_T_126 ? _execResult_result_res_T_340 : _GEN_1185; // @[Shift.scala 108:17 96:24]
  wire  _GEN_1188 = _execResult_T_125 ? io_memDataIn[0] : _GEN_1186; // @[Shift.scala 96:24 102:27]
  wire [7:0] _GEN_1189 = _execResult_T_125 ? {{1'd0}, io_memDataIn[7:1]} : _GEN_1187; // @[Shift.scala 103:17 96:24]
  wire  _GEN_1190 = _execResult_T_124 ? io_memDataIn[7] : _GEN_1188; // @[Shift.scala 96:24 98:27]
  wire [7:0] execResult_result_res_23 = _execResult_T_124 ? _execResult_result_res_T_336[7:0] : _GEN_1189; // @[Shift.scala 96:24 99:17]
  wire  _GEN_1193 = _execResult_result_T_26 ? _GEN_1190 : regs_flagC; // @[Shift.scala 66:13 77:19]
  wire [7:0] _GEN_1194 = _execResult_result_T_26 ? execResult_result_res_23 : 8'h0; // @[Shift.scala 77:19 117:24 72:20]
  wire  _GEN_1196 = _execResult_result_T_26 ? execResult_result_res_23[7] : regs_flagN; // @[Shift.scala 77:19 119:23 66:13]
  wire  _GEN_1197 = _execResult_result_T_26 ? execResult_result_res_23 == 8'h0 : regs_flagZ; // @[Shift.scala 77:19 120:23 66:13]
  wire  _GEN_1213 = _execResult_result_T_21 ? regs_flagC : _GEN_1193; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1213; // @[Shift.scala 66:13 77:19]
  wire  _GEN_1217 = _execResult_result_T_21 ? regs_flagZ : _GEN_1197; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1217; // @[Shift.scala 66:13 77:19]
  wire  _GEN_1216 = _execResult_result_T_21 ? regs_flagN : _GEN_1196; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1216; // @[Shift.scala 66:13 77:19]
  wire [7:0] _GEN_1214 = _execResult_result_T_21 ? 8'h0 : _GEN_1194; // @[Shift.scala 77:19 72:20]
  wire [7:0] execResult_result_result_25_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1214; // @[Shift.scala 77:19 72:20]
  wire  _execResult_T_131 = 8'h16 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_132 = 8'h56 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_133 = 8'h36 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_134 = 8'h76 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_result_T_92 = 8'he == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_93 = 8'h1e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_99 = 8'h4e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_100 = 8'h5e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_106 = 8'h2e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_107 = 8'h3e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_113 = 8'h6e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_114 = 8'h7e == opcode; // @[Shift.scala 138:20]
  wire  _GEN_1252 = (_execResult_T_127 | _execResult_T_134 | 8'h6e == opcode | 8'h7e == opcode) & io_memDataIn[0]; // @[Shift.scala 136:14 138:20 152:18]
  wire [7:0] _GEN_1253 = _execResult_T_127 | _execResult_T_134 | 8'h6e == opcode | 8'h7e == opcode ?
    _execResult_result_res_T_342 : io_memDataIn; // @[Shift.scala 135:12 138:20 153:16]
  wire  _GEN_1254 = _execResult_T_126 | _execResult_T_133 | 8'h2e == opcode | 8'h3e == opcode ? io_memDataIn[7] :
    _GEN_1252; // @[Shift.scala 138:20 148:18]
  wire [7:0] _GEN_1255 = _execResult_T_126 | _execResult_T_133 | 8'h2e == opcode | 8'h3e == opcode ?
    _execResult_result_res_T_340 : _GEN_1253; // @[Shift.scala 138:20 149:16]
  wire  _GEN_1256 = _execResult_T_125 | _execResult_T_132 | 8'h4e == opcode | 8'h5e == opcode ? io_memDataIn[0] :
    _GEN_1254; // @[Shift.scala 138:20 144:18]
  wire [7:0] _GEN_1257 = _execResult_T_125 | _execResult_T_132 | 8'h4e == opcode | 8'h5e == opcode ? {{1'd0},
    io_memDataIn[7:1]} : _GEN_1255; // @[Shift.scala 138:20 145:16]
  wire  execResult_result_newCarry = _execResult_T_124 | _execResult_T_131 | 8'he == opcode | 8'h1e == opcode ?
    io_memDataIn[7] : _GEN_1256; // @[Shift.scala 138:20 140:18]
  wire [7:0] execResult_result_res_24 = _execResult_T_124 | _execResult_T_131 | 8'he == opcode | 8'h1e == opcode ?
    _execResult_result_res_T_336[7:0] : _GEN_1257; // @[Shift.scala 138:20 141:16]
  wire  _execResult_result_newRegs_flagZ_T_39 = execResult_result_res_24 == 8'h0; // @[Shift.scala 194:30]
  wire [7:0] _GEN_1261 = _execResult_result_T_26 ? execResult_result_res_24 : 8'h0; // @[Shift.scala 175:19 170:20 190:24]
  wire  _GEN_1263 = _execResult_result_T_26 ? execResult_result_newCarry : regs_flagC; // @[Shift.scala 164:13 175:19 192:23]
  wire  _GEN_1264 = _execResult_result_T_26 ? execResult_result_res_24[7] : regs_flagN; // @[Shift.scala 164:13 175:19 193:23]
  wire  _GEN_1265 = _execResult_result_T_26 ? execResult_result_res_24 == 8'h0 : regs_flagZ; // @[Shift.scala 164:13 175:19 194:23]
  wire  _GEN_1282 = _execResult_result_T_21 ? regs_flagC : _GEN_1263; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1282; // @[Shift.scala 164:13 175:19]
  wire  _GEN_1284 = _execResult_result_T_21 ? regs_flagZ : _GEN_1265; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1284; // @[Shift.scala 164:13 175:19]
  wire  _GEN_1283 = _execResult_result_T_21 ? regs_flagN : _GEN_1264; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1283; // @[Shift.scala 164:13 175:19]
  wire [7:0] _GEN_1280 = _execResult_result_T_21 ? 8'h0 : _GEN_1261; // @[Shift.scala 175:19 170:20]
  wire [7:0] execResult_result_result_26_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1280; // @[Shift.scala 175:19 170:20]
  wire [7:0] _GEN_1327 = _execResult_result_T_30 ? execResult_result_res_24 : 8'h0; // @[Shift.scala 218:19 213:20 240:24]
  wire  _GEN_1329 = _execResult_result_T_30 ? execResult_result_newCarry : regs_flagC; // @[Shift.scala 207:13 218:19 242:23]
  wire  _GEN_1330 = _execResult_result_T_30 ? execResult_result_res_24[7] : regs_flagN; // @[Shift.scala 207:13 218:19 243:23]
  wire  _GEN_1331 = _execResult_result_T_30 ? _execResult_result_newRegs_flagZ_T_39 : regs_flagZ; // @[Shift.scala 207:13 218:19 244:23]
  wire  _GEN_1348 = _execResult_result_T_26 ? regs_flagC : _GEN_1329; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1381 = _execResult_result_T_21 ? regs_flagC : _GEN_1348; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1381; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1350 = _execResult_result_T_26 ? regs_flagZ : _GEN_1331; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1383 = _execResult_result_T_21 ? regs_flagZ : _GEN_1350; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1383; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1349 = _execResult_result_T_26 ? regs_flagN : _GEN_1330; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1382 = _execResult_result_T_21 ? regs_flagN : _GEN_1349; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1382; // @[Shift.scala 207:13 218:19]
  wire [7:0] _GEN_1346 = _execResult_result_T_26 ? 8'h0 : _GEN_1327; // @[Shift.scala 218:19 213:20]
  wire [7:0] _GEN_1379 = _execResult_result_T_21 ? 8'h0 : _GEN_1346; // @[Shift.scala 218:19 213:20]
  wire [7:0] execResult_result_result_27_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1379; // @[Shift.scala 218:19 213:20]
  wire  _execResult_T_152 = 8'hc9 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_153 = 8'he0 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_154 = 8'hc0 == opcode; // @[CPU6502Core.scala 222:20]
  wire [7:0] _GEN_1492 = _execResult_T_154 ? regs_y : regs_a; // @[Compare.scala 30:14 32:20 35:29]
  wire [7:0] _GEN_1493 = _execResult_T_153 ? regs_x : _GEN_1492; // @[Compare.scala 32:20 34:29]
  wire [7:0] execResult_result_regValue = _execResult_T_152 ? regs_a : _GEN_1493; // @[Compare.scala 32:20 33:29]
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
  wire  _GEN_1497 = _execResult_result_T_21 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 111:13 122:19 134:23]
  wire  _GEN_1498 = _execResult_result_T_21 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 111:13 122:19 135:23]
  wire  _GEN_1499 = _execResult_result_T_21 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 111:13 122:19 136:23]
  wire  execResult_result_newRegs_29_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1497; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_29_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1498; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_29_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1499; // @[Compare.scala 111:13 122:19]
  wire  _GEN_1571 = _execResult_result_T_26 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 187:13 198:19 217:23]
  wire  _GEN_1572 = _execResult_result_T_26 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 187:13 198:19 218:23]
  wire  _GEN_1573 = _execResult_result_T_26 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 187:13 198:19 219:23]
  wire  _GEN_1602 = _execResult_result_T_21 ? regs_flagC : _GEN_1571; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1602; // @[Compare.scala 187:13 198:19]
  wire  _GEN_1603 = _execResult_result_T_21 ? regs_flagZ : _GEN_1572; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1603; // @[Compare.scala 187:13 198:19]
  wire  _GEN_1604 = _execResult_result_T_21 ? regs_flagN : _GEN_1573; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1604; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_useY_2 = opcode == 8'hd9; // @[Compare.scala 243:23]
  wire [7:0] execResult_result_index_2 = execResult_result_useY_2 ? regs_y : regs_x; // @[Compare.scala 244:20]
  wire [15:0] _GEN_4204 = {{8'd0}, execResult_result_index_2}; // @[Compare.scala 257:57]
  wire [15:0] _execResult_result_result_operand_T_68 = resetVector + _GEN_4204; // @[Compare.scala 257:57]
  wire [15:0] _GEN_1645 = _execResult_result_T_21 ? _execResult_result_result_operand_T_68 : operand; // @[Compare.scala 246:19 241:20 257:24]
  wire [15:0] execResult_result_result_33_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_1645; // @[Compare.scala 246:19 250:24]
  wire  _GEN_1685 = _execResult_result_T_30 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 280:13 291:19 313:23]
  wire  _GEN_1686 = _execResult_result_T_30 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 280:13 291:19 314:23]
  wire  _GEN_1687 = _execResult_result_T_30 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 280:13 291:19 315:23]
  wire  _GEN_1703 = _execResult_result_T_26 ? regs_flagC : _GEN_1685; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1722 = _execResult_result_T_21 ? regs_flagC : _GEN_1703; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1722; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1704 = _execResult_result_T_26 ? regs_flagZ : _GEN_1686; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1723 = _execResult_result_T_21 ? regs_flagZ : _GEN_1704; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1723; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1705 = _execResult_result_T_26 ? regs_flagN : _GEN_1687; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1724 = _execResult_result_T_21 ? regs_flagN : _GEN_1705; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1724; // @[Compare.scala 280:13 291:19]
  wire [15:0] execResult_result_result_36_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_320; // @[Compare.scala 387:19 391:24]
  wire  _execResult_T_174 = 8'hf0 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_175 = 8'hd0 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_176 = 8'hb0 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_177 = 8'h90 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_178 = 8'h30 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_179 = 8'h10 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_180 = 8'h50 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_181 = 8'h70 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _GEN_1908 = _execResult_T_180 & ~regs_flagV; // @[Branch.scala 18:16 20:20 28:31]
  wire  _GEN_1909 = _execResult_T_181 ? regs_flagV : _GEN_1908; // @[Branch.scala 20:20 27:31]
  wire  _GEN_1910 = _execResult_T_179 ? ~regs_flagN : _GEN_1909; // @[Branch.scala 20:20 26:31]
  wire  _GEN_1911 = _execResult_T_178 ? regs_flagN : _GEN_1910; // @[Branch.scala 20:20 25:31]
  wire  _GEN_1912 = _execResult_T_177 ? _execResult_result_diff_T_2 : _GEN_1911; // @[Branch.scala 20:20 24:31]
  wire  _GEN_1913 = _execResult_T_176 ? regs_flagC : _GEN_1912; // @[Branch.scala 20:20 23:31]
  wire  _GEN_1914 = _execResult_T_175 ? ~regs_flagZ : _GEN_1913; // @[Branch.scala 20:20 22:31]
  wire  execResult_result_takeBranch = _execResult_T_174 ? regs_flagZ : _GEN_1914; // @[Branch.scala 20:20 21:31]
  wire [7:0] execResult_result_offset = io_memDataIn; // @[Branch.scala 32:28]
  wire [15:0] _execResult_result_newRegs_pc_T_84 = regs_pc + 16'h1; // @[Branch.scala 36:43]
  wire [15:0] _GEN_4206 = {{8{execResult_result_offset[7]}},execResult_result_offset}; // @[Branch.scala 36:50]
  wire [15:0] _execResult_result_newRegs_pc_T_88 = $signed(_execResult_result_newRegs_pc_T_84) + $signed(_GEN_4206); // @[Branch.scala 36:60]
  wire [15:0] execResult_result_newRegs_36_pc = execResult_result_takeBranch ? _execResult_result_newRegs_pc_T_88 :
    _regs_pc_T_1; // @[Branch.scala 36:22]
  wire  _execResult_T_189 = 8'ha9 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_190 = 8'ha2 == opcode; // @[CPU6502Core.scala 222:20]
  wire  _execResult_T_191 = 8'ha0 == opcode; // @[CPU6502Core.scala 222:20]
  wire [7:0] _GEN_1916 = _execResult_T_191 ? io_memDataIn : regs_y; // @[LoadStore.scala 27:13 29:20 32:30]
  wire [7:0] _GEN_1917 = _execResult_T_190 ? io_memDataIn : regs_x; // @[LoadStore.scala 27:13 29:20 31:30]
  wire [7:0] _GEN_1918 = _execResult_T_190 ? regs_y : _GEN_1916; // @[LoadStore.scala 27:13 29:20]
  wire [7:0] execResult_result_newRegs_37_a = _execResult_T_189 ? io_memDataIn : regs_a; // @[LoadStore.scala 27:13 29:20 30:30]
  wire [7:0] execResult_result_newRegs_37_x = _execResult_T_189 ? regs_x : _GEN_1917; // @[LoadStore.scala 27:13 29:20]
  wire [7:0] execResult_result_newRegs_37_y = _execResult_T_189 ? regs_y : _GEN_1918; // @[LoadStore.scala 27:13 29:20]
  wire  execResult_result_newRegs_37_flagZ = io_memDataIn == 8'h0; // @[LoadStore.scala 36:32]
  wire  execResult_result_isLoadA = opcode == 8'ha5; // @[LoadStore.scala 65:26]
  wire  execResult_result_isLoadX = opcode == 8'ha6; // @[LoadStore.scala 66:26]
  wire  execResult_result_isLoadY = opcode == 8'ha4; // @[LoadStore.scala 67:26]
  wire  execResult_result_isStoreA = opcode == 8'h85; // @[LoadStore.scala 68:27]
  wire  execResult_result_isStoreX = opcode == 8'h86; // @[LoadStore.scala 69:27]
  wire  _execResult_result_T_221 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY; // @[LoadStore.scala 83:33]
  wire [7:0] _GEN_1922 = execResult_result_isLoadX ? io_memDataIn : regs_x; // @[LoadStore.scala 54:13 87:31 88:23]
  wire [7:0] _GEN_1923 = execResult_result_isLoadX ? regs_y : io_memDataIn; // @[LoadStore.scala 54:13 87:31 90:23]
  wire [7:0] _GEN_1924 = execResult_result_isLoadA ? io_memDataIn : regs_a; // @[LoadStore.scala 54:13 85:25 86:23]
  wire [7:0] _GEN_1925 = execResult_result_isLoadA ? regs_x : _GEN_1922; // @[LoadStore.scala 54:13 85:25]
  wire [7:0] _GEN_1926 = execResult_result_isLoadA ? regs_y : _GEN_1923; // @[LoadStore.scala 54:13 85:25]
  wire [7:0] _execResult_result_result_memData_T = execResult_result_isStoreX ? regs_x : regs_y; // @[LoadStore.scala 96:54]
  wire [7:0] _execResult_result_result_memData_T_1 = execResult_result_isStoreA ? regs_a :
    _execResult_result_result_memData_T; // @[LoadStore.scala 96:32]
  wire [7:0] _GEN_1928 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1924
     : regs_a; // @[LoadStore.scala 54:13 83:45]
  wire [7:0] _GEN_1929 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1925
     : regs_x; // @[LoadStore.scala 54:13 83:45]
  wire [7:0] _GEN_1930 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1926
     : regs_y; // @[LoadStore.scala 54:13 83:45]
  wire  _GEN_1931 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? io_memDataIn[7]
     : regs_flagN; // @[LoadStore.scala 54:13 83:45 92:25]
  wire  _GEN_1932 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ?
    execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 54:13 83:45 93:25]
  wire  _GEN_1933 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 1'h0 : 1'h1; // @[LoadStore.scala 61:21 83:45 95:27]
  wire [7:0] _GEN_1934 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 8'h0 :
    _execResult_result_result_memData_T_1; // @[LoadStore.scala 60:20 83:45 96:26]
  wire  _GEN_1936 = _execResult_result_T_21 & _execResult_result_T_221; // @[LoadStore.scala 72:19 62:20]
  wire [7:0] _GEN_1937 = _execResult_result_T_21 ? _GEN_1928 : regs_a; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1938 = _execResult_result_T_21 ? _GEN_1929 : regs_x; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1939 = _execResult_result_T_21 ? _GEN_1930 : regs_y; // @[LoadStore.scala 54:13 72:19]
  wire  _GEN_1940 = _execResult_result_T_21 ? _GEN_1931 : regs_flagN; // @[LoadStore.scala 54:13 72:19]
  wire  _GEN_1941 = _execResult_result_T_21 ? _GEN_1932 : regs_flagZ; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1943 = _execResult_result_T_21 ? _GEN_1934 : 8'h0; // @[LoadStore.scala 72:19 60:20]
  wire [7:0] execResult_result_newRegs_38_a = _execResult_result_T_20 ? regs_a : _GEN_1937; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] execResult_result_newRegs_38_x = _execResult_result_T_20 ? regs_x : _GEN_1938; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] execResult_result_newRegs_38_y = _execResult_result_T_20 ? regs_y : _GEN_1939; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_newRegs_38_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1941; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_newRegs_38_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1940; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_result_39_memRead = _execResult_result_T_20 | _GEN_1936; // @[LoadStore.scala 72:19 75:24]
  wire  execResult_result_result_39_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1933; // @[LoadStore.scala 72:19 61:21]
  wire [7:0] execResult_result_result_39_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1943; // @[LoadStore.scala 72:19 60:20]
  wire  execResult_result_isLoadA_1 = opcode == 8'hb5; // @[LoadStore.scala 121:26]
  wire  execResult_result_isLoadY_1 = opcode == 8'hb4; // @[LoadStore.scala 122:26]
  wire  _execResult_result_T_224 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1; // @[LoadStore.scala 136:22]
  wire [7:0] _GEN_1982 = execResult_result_isLoadA_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 110:13 138:25 139:23]
  wire [7:0] _GEN_1983 = execResult_result_isLoadA_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 110:13 138:25 141:23]
  wire [7:0] _execResult_result_result_memData_T_3 = opcode == 8'h95 ? regs_a : regs_y; // @[LoadStore.scala 147:32]
  wire [7:0] _GEN_1985 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_1982 : regs_a; // @[LoadStore.scala 110:13 136:34]
  wire [7:0] _GEN_1986 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_1983 : regs_y; // @[LoadStore.scala 110:13 136:34]
  wire  _GEN_1987 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 110:13 136:34 143:25]
  wire  _GEN_1988 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? execResult_result_newRegs_37_flagZ :
    regs_flagZ; // @[LoadStore.scala 110:13 136:34 144:25]
  wire  _GEN_1989 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 117:21 136:34 146:27]
  wire [7:0] _GEN_1990 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 8'h0 :
    _execResult_result_result_memData_T_3; // @[LoadStore.scala 116:20 136:34 147:26]
  wire  _GEN_1992 = _execResult_result_T_21 & _execResult_result_T_224; // @[LoadStore.scala 125:19 118:20]
  wire [7:0] _GEN_1993 = _execResult_result_T_21 ? _GEN_1985 : regs_a; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] _GEN_1994 = _execResult_result_T_21 ? _GEN_1986 : regs_y; // @[LoadStore.scala 110:13 125:19]
  wire  _GEN_1995 = _execResult_result_T_21 ? _GEN_1987 : regs_flagN; // @[LoadStore.scala 110:13 125:19]
  wire  _GEN_1996 = _execResult_result_T_21 ? _GEN_1988 : regs_flagZ; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] _GEN_1998 = _execResult_result_T_21 ? _GEN_1990 : 8'h0; // @[LoadStore.scala 125:19 116:20]
  wire [7:0] execResult_result_newRegs_39_a = _execResult_result_T_20 ? regs_a : _GEN_1993; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] execResult_result_newRegs_39_y = _execResult_result_T_20 ? regs_y : _GEN_1994; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_newRegs_39_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1996; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_newRegs_39_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1995; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_result_40_memRead = _execResult_result_T_20 | _GEN_1992; // @[LoadStore.scala 125:19 128:24]
  wire  execResult_result_result_40_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1989; // @[LoadStore.scala 125:19 117:21]
  wire [7:0] execResult_result_result_40_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1998; // @[LoadStore.scala 125:19 116:20]
  wire  execResult_result_isLoad = opcode == 8'hb6; // @[LoadStore.scala 172:25]
  wire [7:0] _execResult_result_result_operand_T_90 = io_memDataIn + regs_y; // @[LoadStore.scala 178:38]
  wire [7:0] _GEN_2037 = execResult_result_isLoad ? io_memDataIn : regs_x; // @[LoadStore.scala 161:13 184:22 186:21]
  wire  _GEN_2038 = execResult_result_isLoad ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 161:13 184:22 187:25]
  wire  _GEN_2039 = execResult_result_isLoad ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 161:13 184:22 188:25]
  wire  _GEN_2040 = execResult_result_isLoad ? 1'h0 : 1'h1; // @[LoadStore.scala 168:21 184:22 190:27]
  wire [7:0] _GEN_2041 = execResult_result_isLoad ? 8'h0 : regs_x; // @[LoadStore.scala 167:20 184:22 191:26]
  wire  _GEN_2043 = _execResult_result_T_21 & execResult_result_isLoad; // @[LoadStore.scala 174:19 169:20]
  wire [7:0] _GEN_2044 = _execResult_result_T_21 ? _GEN_2037 : regs_x; // @[LoadStore.scala 161:13 174:19]
  wire  _GEN_2045 = _execResult_result_T_21 ? _GEN_2038 : regs_flagN; // @[LoadStore.scala 161:13 174:19]
  wire  _GEN_2046 = _execResult_result_T_21 ? _GEN_2039 : regs_flagZ; // @[LoadStore.scala 161:13 174:19]
  wire [7:0] _GEN_2048 = _execResult_result_T_21 ? _GEN_2041 : 8'h0; // @[LoadStore.scala 174:19 167:20]
  wire [7:0] execResult_result_newRegs_40_x = _execResult_result_T_20 ? regs_x : _GEN_2044; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_newRegs_40_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2046; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_newRegs_40_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2045; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_result_41_memRead = _execResult_result_T_20 | _GEN_2043; // @[LoadStore.scala 174:19 177:24]
  wire [15:0] execResult_result_result_41_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_90} : operand; // @[LoadStore.scala 174:19 170:20 178:24]
  wire  execResult_result_result_41_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_2040; // @[LoadStore.scala 174:19 168:21]
  wire [7:0] execResult_result_result_41_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2048; // @[LoadStore.scala 174:19 167:20]
  wire  execResult_result_isLoadA_2 = opcode == 8'had; // @[LoadStore.scala 216:26]
  wire  execResult_result_isLoadX_1 = opcode == 8'hae; // @[LoadStore.scala 217:26]
  wire  execResult_result_isLoadY_2 = opcode == 8'hac; // @[LoadStore.scala 218:26]
  wire  _execResult_result_T_231 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 |
    execResult_result_isLoadY_2; // @[LoadStore.scala 239:33]
  wire [7:0] _GEN_2084 = execResult_result_isLoadX_1 ? io_memDataIn : regs_x; // @[LoadStore.scala 205:13 243:31 244:23]
  wire [7:0] _GEN_2085 = execResult_result_isLoadX_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 205:13 243:31 246:23]
  wire [7:0] _GEN_2086 = execResult_result_isLoadA_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 205:13 241:25 242:23]
  wire [7:0] _GEN_2087 = execResult_result_isLoadA_2 ? regs_x : _GEN_2084; // @[LoadStore.scala 205:13 241:25]
  wire [7:0] _GEN_2088 = execResult_result_isLoadA_2 ? regs_y : _GEN_2085; // @[LoadStore.scala 205:13 241:25]
  wire  _execResult_result_result_memData_T_4 = opcode == 8'h8e; // @[LoadStore.scala 254:21]
  wire  _execResult_result_result_memData_T_5 = opcode == 8'h8c; // @[LoadStore.scala 255:21]
  wire [7:0] _execResult_result_result_memData_T_6 = _execResult_result_result_memData_T_5 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] _execResult_result_result_memData_T_7 = _execResult_result_result_memData_T_4 ? regs_x :
    _execResult_result_result_memData_T_6; // @[Mux.scala 101:16]
  wire [7:0] _GEN_2090 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2086 : regs_a; // @[LoadStore.scala 205:13 239:45]
  wire [7:0] _GEN_2091 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2087 : regs_x; // @[LoadStore.scala 205:13 239:45]
  wire [7:0] _GEN_2092 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2088 : regs_y; // @[LoadStore.scala 205:13 239:45]
  wire  _GEN_2093 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 205:13 239:45 248:25]
  wire  _GEN_2094 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 205:13 239:45 249:25]
  wire  _GEN_2095 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 1'h0 : 1'h1
    ; // @[LoadStore.scala 212:21 239:45 251:27]
  wire [7:0] _GEN_2096 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 8'h0
     : _execResult_result_result_memData_T_7; // @[LoadStore.scala 211:20 239:45 253:26]
  wire  _GEN_2098 = _execResult_result_T_26 & _execResult_result_T_231; // @[LoadStore.scala 220:19 213:20]
  wire [7:0] _GEN_2099 = _execResult_result_T_26 ? _GEN_2090 : regs_a; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2100 = _execResult_result_T_26 ? _GEN_2091 : regs_x; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2101 = _execResult_result_T_26 ? _GEN_2092 : regs_y; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2102 = _execResult_result_T_26 ? _GEN_2093 : regs_flagN; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2103 = _execResult_result_T_26 ? _GEN_2094 : regs_flagZ; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2105 = _execResult_result_T_26 ? _GEN_2096 : 8'h0; // @[LoadStore.scala 220:19 211:20]
  wire [7:0] _GEN_2136 = _execResult_result_T_21 ? regs_a : _GEN_2099; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_41_a = _execResult_result_T_20 ? regs_a : _GEN_2136; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2137 = _execResult_result_T_21 ? regs_x : _GEN_2100; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_41_x = _execResult_result_T_20 ? regs_x : _GEN_2137; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_2138 = _execResult_result_T_21 ? regs_y : _GEN_2101; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_41_y = _execResult_result_T_20 ? regs_y : _GEN_2138; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2140 = _execResult_result_T_21 ? regs_flagZ : _GEN_2103; // @[LoadStore.scala 205:13 220:19]
  wire  execResult_result_newRegs_41_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2140; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2139 = _execResult_result_T_21 ? regs_flagN : _GEN_2102; // @[LoadStore.scala 205:13 220:19]
  wire  execResult_result_newRegs_41_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2139; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_2120 = _execResult_result_T_21 | _GEN_2098; // @[LoadStore.scala 220:19 231:24]
  wire  _GEN_2141 = _execResult_result_T_21 ? 1'h0 : _execResult_result_T_26 & _GEN_2095; // @[LoadStore.scala 220:19 212:21]
  wire [7:0] _GEN_2142 = _execResult_result_T_21 ? 8'h0 : _GEN_2105; // @[LoadStore.scala 220:19 211:20]
  wire  execResult_result_result_42_memRead = _execResult_result_T_20 | _GEN_2120; // @[LoadStore.scala 220:19 223:24]
  wire  execResult_result_result_42_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2141; // @[LoadStore.scala 220:19 212:21]
  wire [7:0] execResult_result_result_42_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2142; // @[LoadStore.scala 220:19 211:20]
  wire  execResult_result_useY_3 = opcode == 8'hb9 | opcode == 8'hbe | opcode == 8'h99; // @[LoadStore.scala 282:59]
  wire [7:0] execResult_result_indexReg = execResult_result_useY_3 ? regs_y : regs_x; // @[LoadStore.scala 283:23]
  wire [15:0] _GEN_4207 = {{8'd0}, execResult_result_indexReg}; // @[LoadStore.scala 302:57]
  wire [15:0] _execResult_result_result_operand_T_97 = resetVector + _GEN_4207; // @[LoadStore.scala 302:57]
  wire [7:0] _GEN_2171 = _execResult_result_T_26 ? io_memDataIn : regs_a; // @[LoadStore.scala 270:13 290:19 310:19]
  wire  _GEN_2172 = _execResult_result_T_26 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 270:13 290:19 311:23]
  wire  _GEN_2173 = _execResult_result_T_26 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 270:13 290:19 312:23]
  wire [7:0] _GEN_2203 = _execResult_result_T_21 ? regs_a : _GEN_2171; // @[LoadStore.scala 270:13 290:19]
  wire [7:0] execResult_result_newRegs_42_a = _execResult_result_T_20 ? regs_a : _GEN_2203; // @[LoadStore.scala 270:13 290:19]
  wire  _GEN_2205 = _execResult_result_T_21 ? regs_flagZ : _GEN_2173; // @[LoadStore.scala 270:13 290:19]
  wire  execResult_result_newRegs_42_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2205; // @[LoadStore.scala 270:13 290:19]
  wire  _GEN_2204 = _execResult_result_T_21 ? regs_flagN : _GEN_2172; // @[LoadStore.scala 270:13 290:19]
  wire  execResult_result_newRegs_42_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2204; // @[LoadStore.scala 270:13 290:19]
  wire [15:0] _GEN_2188 = _execResult_result_T_21 ? _execResult_result_result_operand_T_97 : operand; // @[LoadStore.scala 290:19 279:20 302:24]
  wire [15:0] execResult_result_result_43_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_2188; // @[LoadStore.scala 290:19 294:24]
  wire  execResult_result_isLoad_1 = opcode == 8'ha1; // @[LoadStore.scala 336:25]
  wire  _GEN_2229 = execResult_result_isLoad_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 332:21 362:22 365:27]
  wire [7:0] _GEN_2230 = execResult_result_isLoad_1 ? 8'h0 : regs_a; // @[LoadStore.scala 331:20 362:22 366:26]
  wire  _execResult_result_T_239 = 3'h4 == cycle; // @[LoadStore.scala 338:19]
  wire [7:0] _GEN_2231 = execResult_result_isLoad_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 325:13 371:22 372:21]
  wire  _GEN_2232 = execResult_result_isLoad_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 325:13 371:22 373:25]
  wire  _GEN_2233 = execResult_result_isLoad_1 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 325:13 371:22 374:25]
  wire [7:0] _GEN_2246 = 3'h4 == cycle ? _GEN_2231 : regs_a; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_2266 = _execResult_result_T_30 ? regs_a : _GEN_2246; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_2287 = _execResult_result_T_26 ? regs_a : _GEN_2266; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_2308 = _execResult_result_T_21 ? regs_a : _GEN_2287; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] execResult_result_newRegs_43_a = _execResult_result_T_20 ? regs_a : _GEN_2308; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2248 = 3'h4 == cycle ? _GEN_2233 : regs_flagZ; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2268 = _execResult_result_T_30 ? regs_flagZ : _GEN_2248; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2289 = _execResult_result_T_26 ? regs_flagZ : _GEN_2268; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2310 = _execResult_result_T_21 ? regs_flagZ : _GEN_2289; // @[LoadStore.scala 325:13 338:19]
  wire  execResult_result_newRegs_43_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2310; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2247 = 3'h4 == cycle ? _GEN_2232 : regs_flagN; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2267 = _execResult_result_T_30 ? regs_flagN : _GEN_2247; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2288 = _execResult_result_T_26 ? regs_flagN : _GEN_2267; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2309 = _execResult_result_T_21 ? regs_flagN : _GEN_2288; // @[LoadStore.scala 325:13 338:19]
  wire  execResult_result_newRegs_43_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2309; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_2263 = _execResult_result_T_30 & execResult_result_isLoad_1; // @[LoadStore.scala 338:19 333:20]
  wire [7:0] _GEN_2265 = _execResult_result_T_30 ? _GEN_2230 : 8'h0; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_2281 = _execResult_result_T_30 ? 1'h0 : 3'h4 == cycle; // @[LoadStore.scala 327:17 338:19]
  wire  _GEN_2283 = _execResult_result_T_26 | _GEN_2263; // @[LoadStore.scala 338:19 356:24]
  wire  _GEN_2285 = _execResult_result_T_26 ? 1'h0 : _execResult_result_T_30 & _GEN_2229; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] _GEN_2286 = _execResult_result_T_26 ? 8'h0 : _GEN_2265; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_2302 = _execResult_result_T_26 ? 1'h0 : _GEN_2281; // @[LoadStore.scala 327:17 338:19]
  wire  _GEN_2304 = _execResult_result_T_21 | _GEN_2283; // @[LoadStore.scala 338:19 350:24]
  wire  _GEN_2306 = _execResult_result_T_21 ? 1'h0 : _GEN_2285; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] _GEN_2307 = _execResult_result_T_21 ? 8'h0 : _GEN_2286; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_2323 = _execResult_result_T_21 ? 1'h0 : _GEN_2302; // @[LoadStore.scala 327:17 338:19]
  wire  execResult_result_result_44_memRead = _execResult_result_T_20 | _GEN_2304; // @[LoadStore.scala 338:19 342:24]
  wire  execResult_result_result_44_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2306; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] execResult_result_result_44_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2307; // @[LoadStore.scala 338:19 331:20]
  wire  execResult_result_result_44_done = _execResult_result_T_20 ? 1'h0 : _GEN_2323; // @[LoadStore.scala 327:17 338:19]
  wire  execResult_result_isLoad_2 = opcode == 8'hb1; // @[LoadStore.scala 399:25]
  wire [15:0] execResult_result_finalAddr = operand + _GEN_4194; // @[LoadStore.scala 424:33]
  wire  _GEN_2347 = execResult_result_isLoad_2 ? 1'h0 : 1'h1; // @[LoadStore.scala 395:21 426:22 429:27]
  wire [7:0] _GEN_2348 = execResult_result_isLoad_2 ? 8'h0 : regs_a; // @[LoadStore.scala 394:20 426:22 430:26]
  wire [7:0] _GEN_2349 = execResult_result_isLoad_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 388:13 435:22 436:21]
  wire  _GEN_2350 = execResult_result_isLoad_2 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 388:13 435:22 437:25]
  wire  _GEN_2351 = execResult_result_isLoad_2 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 388:13 435:22 438:25]
  wire [7:0] _GEN_2364 = _execResult_result_T_239 ? _GEN_2349 : regs_a; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_2384 = _execResult_result_T_30 ? regs_a : _GEN_2364; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_2405 = _execResult_result_T_26 ? regs_a : _GEN_2384; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_2426 = _execResult_result_T_21 ? regs_a : _GEN_2405; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] execResult_result_newRegs_44_a = _execResult_result_T_20 ? regs_a : _GEN_2426; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2366 = _execResult_result_T_239 ? _GEN_2351 : regs_flagZ; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2386 = _execResult_result_T_30 ? regs_flagZ : _GEN_2366; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2407 = _execResult_result_T_26 ? regs_flagZ : _GEN_2386; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2428 = _execResult_result_T_21 ? regs_flagZ : _GEN_2407; // @[LoadStore.scala 388:13 401:19]
  wire  execResult_result_newRegs_44_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2428; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2365 = _execResult_result_T_239 ? _GEN_2350 : regs_flagN; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2385 = _execResult_result_T_30 ? regs_flagN : _GEN_2365; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2406 = _execResult_result_T_26 ? regs_flagN : _GEN_2385; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_2427 = _execResult_result_T_21 ? regs_flagN : _GEN_2406; // @[LoadStore.scala 388:13 401:19]
  wire  execResult_result_newRegs_44_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2427; // @[LoadStore.scala 388:13 401:19]
  wire [15:0] _GEN_2380 = _execResult_result_T_30 ? execResult_result_finalAddr : 16'h0; // @[LoadStore.scala 401:19 393:20 425:24]
  wire  _GEN_2381 = _execResult_result_T_30 & execResult_result_isLoad_2; // @[LoadStore.scala 401:19 396:20]
  wire [7:0] _GEN_2383 = _execResult_result_T_30 ? _GEN_2348 : 8'h0; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] _GEN_2400 = _execResult_result_T_26 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_2380; // @[LoadStore.scala 401:19 418:24]
  wire  _GEN_2401 = _execResult_result_T_26 | _GEN_2381; // @[LoadStore.scala 401:19 419:24]
  wire  _GEN_2403 = _execResult_result_T_26 ? 1'h0 : _execResult_result_T_30 & _GEN_2347; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] _GEN_2404 = _execResult_result_T_26 ? 8'h0 : _GEN_2383; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] _GEN_2421 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_2400; // @[LoadStore.scala 401:19 412:24]
  wire  _GEN_2422 = _execResult_result_T_21 | _GEN_2401; // @[LoadStore.scala 401:19 413:24]
  wire  _GEN_2424 = _execResult_result_T_21 ? 1'h0 : _GEN_2403; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] _GEN_2425 = _execResult_result_T_21 ? 8'h0 : _GEN_2404; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] execResult_result_result_45_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2421; // @[LoadStore.scala 401:19 404:24]
  wire  execResult_result_result_45_memRead = _execResult_result_T_20 | _GEN_2422; // @[LoadStore.scala 401:19 405:24]
  wire  execResult_result_result_45_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2424; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] execResult_result_result_45_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2425; // @[LoadStore.scala 401:19 394:20]
  wire [7:0] _execResult_result_pushData_T = {regs_flagN,regs_flagV,2'h3,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] execResult_result_pushData = opcode == 8'h8 ? _execResult_result_pushData_T : regs_a; // @[Stack.scala 21:14 23:29 24:16]
  wire [7:0] execResult_result_newRegs_45_sp = regs_sp - 8'h1; // @[Stack.scala 27:27]
  wire [15:0] execResult_result_result_46_memAddr = {8'h1,regs_sp}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_newRegs_sp_T_3 = regs_sp + 8'h1; // @[Stack.scala 57:31]
  wire [7:0] _GEN_2465 = opcode == 8'h68 ? io_memDataIn : regs_a; // @[Stack.scala 44:13 65:33 66:21]
  wire  _GEN_2466 = opcode == 8'h68 ? io_memDataIn[7] : io_memDataIn[7]; // @[Stack.scala 65:33 67:25 75:25]
  wire  _GEN_2467 = opcode == 8'h68 ? execResult_result_newRegs_37_flagZ : io_memDataIn[1]; // @[Stack.scala 65:33 68:25 71:25]
  wire  _GEN_2468 = opcode == 8'h68 ? regs_flagC : io_memDataIn[0]; // @[Stack.scala 44:13 65:33 70:25]
  wire  _GEN_2469 = opcode == 8'h68 ? regs_flagI : io_memDataIn[2]; // @[Stack.scala 44:13 65:33 72:25]
  wire  _GEN_2470 = opcode == 8'h68 ? regs_flagD : io_memDataIn[3]; // @[Stack.scala 44:13 65:33 73:25]
  wire  _GEN_2471 = opcode == 8'h68 ? regs_flagV : io_memDataIn[6]; // @[Stack.scala 44:13 65:33 74:25]
  wire [15:0] _GEN_2472 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : 16'h0; // @[Stack.scala 55:19 49:20 62:24]
  wire [7:0] _GEN_2474 = _execResult_result_T_21 ? _GEN_2465 : regs_a; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2475 = _execResult_result_T_21 ? _GEN_2466 : regs_flagN; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2476 = _execResult_result_T_21 ? _GEN_2467 : regs_flagZ; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2477 = _execResult_result_T_21 ? _GEN_2468 : regs_flagC; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2478 = _execResult_result_T_21 ? _GEN_2469 : regs_flagI; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2479 = _execResult_result_T_21 ? _GEN_2470 : regs_flagD; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2480 = _execResult_result_T_21 ? _GEN_2471 : regs_flagV; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_46_a = _execResult_result_T_20 ? regs_a : _GEN_2474; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_46_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Stack.scala 44:13 55:19 57:20]
  wire  execResult_result_newRegs_46_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_2477; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2476; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2478; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_2479; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_2480; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2475; // @[Stack.scala 44:13 55:19]
  wire [15:0] execResult_result_result_47_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2472; // @[Stack.scala 55:19 49:20]
  wire [15:0] _GEN_2516 = _execResult_result_T_21 ? regs_pc : 16'h0; // @[Jump.scala 26:19 20:20 36:24]
  wire [15:0] _GEN_2518 = _execResult_result_T_21 ? resetVector : regs_pc; // @[Jump.scala 15:13 26:19 38:20]
  wire [15:0] execResult_result_newRegs_47_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2518; // @[Jump.scala 26:19 31:20]
  wire [15:0] execResult_result_result_48_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2516; // @[Jump.scala 26:19 28:24]
  wire [15:0] _execResult_result_indirectAddrHigh_T_3 = {operand[15:8],8'h0}; // @[Cat.scala 33:92]
  wire [15:0] _execResult_result_indirectAddrHigh_T_5 = operand + 16'h1; // @[Jump.scala 89:19]
  wire [15:0] execResult_result_indirectAddrHigh = operand[7:0] == 8'hff ? _execResult_result_indirectAddrHigh_T_3 :
    _execResult_result_indirectAddrHigh_T_5; // @[Jump.scala 87:35]
  wire [15:0] _GEN_2549 = _execResult_result_T_30 ? execResult_result_indirectAddrHigh : 16'h0; // @[Jump.scala 62:19 56:20 90:24]
  wire [15:0] _GEN_2551 = _execResult_result_T_30 ? resetVector : regs_pc; // @[Jump.scala 51:13 62:19 92:20]
  wire [15:0] _GEN_2567 = _execResult_result_T_26 ? regs_pc : _GEN_2551; // @[Jump.scala 51:13 62:19]
  wire [15:0] _GEN_2584 = _execResult_result_T_21 ? _regs_pc_T_1 : _GEN_2567; // @[Jump.scala 62:19 76:20]
  wire [15:0] execResult_result_newRegs_48_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2584; // @[Jump.scala 62:19 68:20]
  wire [15:0] _GEN_2564 = _execResult_result_T_26 ? operand : _GEN_2549; // @[Jump.scala 62:19 81:24]
  wire [15:0] _GEN_2566 = _execResult_result_T_26 ? _execResult_result_result_operand_T_9 : operand; // @[Jump.scala 62:19 60:20 83:24]
  wire [15:0] _GEN_2581 = _execResult_result_T_21 ? regs_pc : _GEN_2564; // @[Jump.scala 62:19 73:24]
  wire [15:0] _GEN_2583 = _execResult_result_T_21 ? resetVector : _GEN_2566; // @[Jump.scala 62:19 75:24]
  wire [15:0] execResult_result_result_49_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2581; // @[Jump.scala 62:19 65:24]
  wire [15:0] execResult_result_result_49_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_2583; // @[Jump.scala 62:19 67:24]
  wire [15:0] _GEN_2615 = _execResult_result_T_30 ? execResult_result_result_46_memAddr : 16'h0; // @[Jump.scala 116:19 110:20 140:24]
  wire [7:0] _GEN_2616 = _execResult_result_T_30 ? regs_pc[7:0] : 8'h0; // @[Jump.scala 116:19 111:20 141:24]
  wire [7:0] _GEN_2618 = _execResult_result_T_30 ? execResult_result_newRegs_45_sp : regs_sp; // @[Jump.scala 105:13 116:19 143:20]
  wire [15:0] _GEN_2619 = _execResult_result_T_30 ? operand : regs_pc; // @[Jump.scala 105:13 116:19 144:20]
  wire [7:0] _GEN_2635 = _execResult_result_T_26 ? execResult_result_newRegs_45_sp : _GEN_2618; // @[Jump.scala 116:19 135:20]
  wire [7:0] _GEN_2657 = _execResult_result_T_21 ? regs_sp : _GEN_2635; // @[Jump.scala 105:13 116:19]
  wire [7:0] execResult_result_newRegs_49_sp = _execResult_result_T_20 ? regs_sp : _GEN_2657; // @[Jump.scala 105:13 116:19]
  wire [15:0] _GEN_2649 = _execResult_result_T_26 ? regs_pc : _GEN_2619; // @[Jump.scala 105:13 116:19]
  wire [15:0] _GEN_2670 = _execResult_result_T_21 ? regs_pc : _GEN_2649; // @[Jump.scala 105:13 116:19]
  wire [15:0] execResult_result_newRegs_49_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2670; // @[Jump.scala 116:19 121:20]
  wire [15:0] _GEN_2632 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : _GEN_2615; // @[Jump.scala 116:19 132:24]
  wire [7:0] _GEN_2633 = _execResult_result_T_26 ? regs_pc[15:8] : _GEN_2616; // @[Jump.scala 116:19 133:24]
  wire [2:0] _GEN_2648 = _execResult_result_T_26 ? 3'h3 : execResult_result_result_6_nextCycle; // @[Jump.scala 116:19 108:22 137:26]
  wire [15:0] _GEN_2651 = _execResult_result_T_21 ? regs_pc : _GEN_2632; // @[Jump.scala 116:19 126:24]
  wire [2:0] _GEN_2654 = _execResult_result_T_21 ? 3'h2 : _GEN_2648; // @[Jump.scala 116:19 129:26]
  wire [7:0] _GEN_2655 = _execResult_result_T_21 ? 8'h0 : _GEN_2633; // @[Jump.scala 116:19 111:20]
  wire  _GEN_2656 = _execResult_result_T_21 ? 1'h0 : _GEN_298; // @[Jump.scala 116:19 112:21]
  wire [15:0] execResult_result_result_50_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2651; // @[Jump.scala 116:19 118:24]
  wire [2:0] execResult_result_result_50_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_2654; // @[Jump.scala 116:19 123:26]
  wire [7:0] execResult_result_result_50_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2655; // @[Jump.scala 116:19 111:20]
  wire  execResult_result_result_50_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2656; // @[Jump.scala 116:19 112:21]
  wire [15:0] _execResult_result_newRegs_pc_T_125 = resetVector + 16'h1; // @[Jump.scala 185:53]
  wire [15:0] _GEN_2693 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : 16'h0; // @[Jump.scala 168:19 162:20 183:24]
  wire [15:0] _GEN_2695 = _execResult_result_T_26 ? _execResult_result_newRegs_pc_T_125 : regs_pc; // @[Jump.scala 157:13 168:19 185:20]
  wire [7:0] _GEN_2711 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 157:13 168:19 178:20]
  wire [7:0] execResult_result_newRegs_50_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_2711; // @[Jump.scala 168:19 170:20]
  wire [15:0] _GEN_2725 = _execResult_result_T_21 ? regs_pc : _GEN_2695; // @[Jump.scala 157:13 168:19]
  wire [15:0] execResult_result_newRegs_50_pc = _execResult_result_T_20 ? regs_pc : _GEN_2725; // @[Jump.scala 157:13 168:19]
  wire [15:0] _GEN_2708 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2693; // @[Jump.scala 168:19 175:24]
  wire [15:0] _GEN_2710 = _execResult_result_T_21 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 168:19 166:20 177:24]
  wire [15:0] execResult_result_result_51_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2708; // @[Jump.scala 168:19 162:20]
  wire  execResult_result_result_51_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_231; // @[Jump.scala 168:19 165:20]
  wire [15:0] execResult_result_result_51_operand = _execResult_result_T_20 ? operand : _GEN_2710; // @[Jump.scala 168:19 166:20]
  wire [15:0] _GEN_2746 = 3'h5 == cycle ? 16'hffff : 16'h0; // @[Jump.scala 209:19 203:20 249:24]
  wire [15:0] _GEN_2748 = 3'h5 == cycle ? resetVector : regs_pc; // @[Jump.scala 198:13 209:19 251:20]
  wire [7:0] _GEN_2828 = _execResult_result_T_21 ? execResult_result_newRegs_45_sp : _GEN_2635; // @[Jump.scala 209:19 219:20]
  wire [7:0] execResult_result_newRegs_51_sp = _execResult_result_T_20 ? regs_sp : _GEN_2828; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2765 = _execResult_result_T_239 ? regs_pc : _GEN_2748; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2800 = _execResult_result_T_30 ? regs_pc : _GEN_2765; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2823 = _execResult_result_T_26 ? regs_pc : _GEN_2800; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2846 = _execResult_result_T_21 ? regs_pc : _GEN_2823; // @[Jump.scala 198:13 209:19]
  wire [15:0] execResult_result_newRegs_51_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2846; // @[Jump.scala 209:19 211:20]
  wire  _GEN_2783 = _execResult_result_T_30 | regs_flagI; // @[Jump.scala 198:13 209:19 237:23]
  wire  _GEN_2819 = _execResult_result_T_26 ? regs_flagI : _GEN_2783; // @[Jump.scala 198:13 209:19]
  wire  _GEN_2842 = _execResult_result_T_21 ? regs_flagI : _GEN_2819; // @[Jump.scala 198:13 209:19]
  wire  execResult_result_newRegs_51_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2842; // @[Jump.scala 198:13 209:19]
  wire [15:0] _GEN_2761 = _execResult_result_T_239 ? 16'hfffe : _GEN_2746; // @[Jump.scala 209:19 243:24]
  wire  _GEN_2762 = _execResult_result_T_239 | 3'h5 == cycle; // @[Jump.scala 209:19 244:24]
  wire [15:0] _GEN_2763 = _execResult_result_T_239 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 209:19 207:20 245:24]
  wire [2:0] _GEN_2764 = _execResult_result_T_239 ? 3'h5 : execResult_result_result_6_nextCycle; // @[Jump.scala 209:19 201:22 246:26]
  wire  _GEN_2778 = _execResult_result_T_239 ? 1'h0 : 3'h5 == cycle; // @[Jump.scala 200:17 209:19]
  wire [15:0] _GEN_2779 = _execResult_result_T_30 ? execResult_result_result_46_memAddr : _GEN_2761; // @[Jump.scala 209:19 233:24]
  wire [7:0] _GEN_2780 = _execResult_result_T_30 ? _execResult_result_pushData_T : 8'h0; // @[Jump.scala 209:19 204:20 234:24]
  wire [2:0] _GEN_2797 = _execResult_result_T_30 ? 3'h4 : _GEN_2764; // @[Jump.scala 209:19 240:26]
  wire  _GEN_2798 = _execResult_result_T_30 ? 1'h0 : _GEN_2762; // @[Jump.scala 209:19 206:20]
  wire [15:0] _GEN_2799 = _execResult_result_T_30 ? operand : _GEN_2763; // @[Jump.scala 209:19 207:20]
  wire  _GEN_2801 = _execResult_result_T_30 ? 1'h0 : _GEN_2778; // @[Jump.scala 200:17 209:19]
  wire [15:0] _GEN_2802 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : _GEN_2779; // @[Jump.scala 209:19 224:24]
  wire [7:0] _GEN_2803 = _execResult_result_T_26 ? regs_pc[7:0] : _GEN_2780; // @[Jump.scala 209:19 225:24]
  wire [2:0] _GEN_2818 = _execResult_result_T_26 ? 3'h3 : _GEN_2797; // @[Jump.scala 209:19 229:26]
  wire  _GEN_2821 = _execResult_result_T_26 ? 1'h0 : _GEN_2798; // @[Jump.scala 209:19 206:20]
  wire [15:0] _GEN_2822 = _execResult_result_T_26 ? operand : _GEN_2799; // @[Jump.scala 209:19 207:20]
  wire  _GEN_2824 = _execResult_result_T_26 ? 1'h0 : _GEN_2801; // @[Jump.scala 200:17 209:19]
  wire [15:0] _GEN_2825 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2802; // @[Jump.scala 209:19 216:24]
  wire [7:0] _GEN_2826 = _execResult_result_T_21 ? regs_pc[15:8] : _GEN_2803; // @[Jump.scala 209:19 217:24]
  wire [2:0] _GEN_2841 = _execResult_result_T_21 ? 3'h2 : _GEN_2818; // @[Jump.scala 209:19 221:26]
  wire  _GEN_2844 = _execResult_result_T_21 ? 1'h0 : _GEN_2821; // @[Jump.scala 209:19 206:20]
  wire [15:0] _GEN_2845 = _execResult_result_T_21 ? operand : _GEN_2822; // @[Jump.scala 209:19 207:20]
  wire  _GEN_2847 = _execResult_result_T_21 ? 1'h0 : _GEN_2824; // @[Jump.scala 200:17 209:19]
  wire [2:0] execResult_result_result_52_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_2841; // @[Jump.scala 209:19 213:26]
  wire [15:0] execResult_result_result_52_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2825; // @[Jump.scala 209:19 203:20]
  wire [7:0] execResult_result_result_52_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2826; // @[Jump.scala 209:19 204:20]
  wire  execResult_result_result_52_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_319; // @[Jump.scala 209:19 205:21]
  wire  execResult_result_result_52_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_2844; // @[Jump.scala 209:19 206:20]
  wire [15:0] execResult_result_result_52_operand = _execResult_result_T_20 ? operand : _GEN_2845; // @[Jump.scala 209:19 207:20]
  wire  execResult_result_result_52_done = _execResult_result_T_20 ? 1'h0 : _GEN_2847; // @[Jump.scala 200:17 209:19]
  wire [7:0] _GEN_2889 = _execResult_result_T_26 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 264:13 275:19 298:20]
  wire [7:0] _GEN_2913 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : _GEN_2889; // @[Jump.scala 275:19 290:20]
  wire [7:0] execResult_result_newRegs_52_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_2913; // @[Jump.scala 275:19 277:20]
  wire [15:0] _GEN_2928 = _execResult_result_T_21 ? regs_pc : _GEN_2567; // @[Jump.scala 264:13 275:19]
  wire [15:0] execResult_result_newRegs_52_pc = _execResult_result_T_20 ? regs_pc : _GEN_2928; // @[Jump.scala 264:13 275:19]
  wire  _GEN_2907 = _execResult_result_T_21 ? io_memDataIn[0] : regs_flagC; // @[Jump.scala 264:13 275:19 284:23]
  wire  execResult_result_newRegs_52_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_2907; // @[Jump.scala 264:13 275:19]
  wire  _GEN_2908 = _execResult_result_T_21 ? io_memDataIn[1] : regs_flagZ; // @[Jump.scala 264:13 275:19 285:23]
  wire  execResult_result_newRegs_52_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2908; // @[Jump.scala 264:13 275:19]
  wire  _GEN_2909 = _execResult_result_T_21 ? io_memDataIn[2] : regs_flagI; // @[Jump.scala 264:13 275:19 286:23]
  wire  execResult_result_newRegs_52_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2909; // @[Jump.scala 264:13 275:19]
  wire  _GEN_2910 = _execResult_result_T_21 ? io_memDataIn[3] : regs_flagD; // @[Jump.scala 264:13 275:19 287:23]
  wire  execResult_result_newRegs_52_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_2910; // @[Jump.scala 264:13 275:19]
  wire [15:0] _GEN_2888 = _execResult_result_T_26 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 275:19 273:20 297:24]
  wire [15:0] _GEN_2905 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2632; // @[Jump.scala 275:19 282:24]
  wire [15:0] _GEN_2927 = _execResult_result_T_21 ? operand : _GEN_2888; // @[Jump.scala 275:19 273:20]
  wire [15:0] execResult_result_result_53_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2905; // @[Jump.scala 275:19 269:20]
  wire [15:0] execResult_result_result_53_operand = _execResult_result_T_20 ? operand : _GEN_2927; // @[Jump.scala 275:19 273:20]
  wire  _GEN_2955 = 8'h40 == opcode & execResult_result_result_9_done; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire [2:0] _GEN_2956 = 8'h40 == opcode ? execResult_result_result_50_nextCycle : 3'h0; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire [7:0] _GEN_2960 = 8'h40 == opcode ? execResult_result_newRegs_52_sp : regs_sp; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire [15:0] _GEN_2961 = 8'h40 == opcode ? execResult_result_newRegs_52_pc : regs_pc; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire  _GEN_2962 = 8'h40 == opcode ? execResult_result_newRegs_52_flagC : regs_flagC; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire  _GEN_2963 = 8'h40 == opcode ? execResult_result_newRegs_52_flagZ : regs_flagZ; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire  _GEN_2964 = 8'h40 == opcode ? execResult_result_newRegs_52_flagI : regs_flagI; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire  _GEN_2965 = 8'h40 == opcode ? execResult_result_newRegs_52_flagD : regs_flagD; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire  _GEN_2967 = 8'h40 == opcode ? execResult_result_newRegs_16_flagV : regs_flagV; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire  _GEN_2968 = 8'h40 == opcode ? execResult_result_newRegs_16_flagN : regs_flagN; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire [15:0] _GEN_2969 = 8'h40 == opcode ? execResult_result_result_53_memAddr : 16'h0; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire  _GEN_2972 = 8'h40 == opcode & execResult_result_result_52_memWrite; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire [15:0] _GEN_2973 = 8'h40 == opcode ? execResult_result_result_53_operand : operand; // @[CPU6502Core.scala 220:12 222:20 456:27]
  wire  _GEN_2974 = 8'h0 == opcode ? execResult_result_result_52_done : _GEN_2955; // @[CPU6502Core.scala 222:20 455:27]
  wire [2:0] _GEN_2975 = 8'h0 == opcode ? execResult_result_result_52_nextCycle : _GEN_2956; // @[CPU6502Core.scala 222:20 455:27]
  wire [7:0] _GEN_2979 = 8'h0 == opcode ? execResult_result_newRegs_51_sp : _GEN_2960; // @[CPU6502Core.scala 222:20 455:27]
  wire [15:0] _GEN_2980 = 8'h0 == opcode ? execResult_result_newRegs_51_pc : _GEN_2961; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2981 = 8'h0 == opcode ? regs_flagC : _GEN_2962; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2982 = 8'h0 == opcode ? regs_flagZ : _GEN_2963; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2983 = 8'h0 == opcode ? execResult_result_newRegs_51_flagI : _GEN_2964; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2984 = 8'h0 == opcode ? regs_flagD : _GEN_2965; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2986 = 8'h0 == opcode ? regs_flagV : _GEN_2967; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2987 = 8'h0 == opcode ? regs_flagN : _GEN_2968; // @[CPU6502Core.scala 222:20 455:27]
  wire [15:0] _GEN_2988 = 8'h0 == opcode ? execResult_result_result_52_memAddr : _GEN_2969; // @[CPU6502Core.scala 222:20 455:27]
  wire [7:0] _GEN_2989 = 8'h0 == opcode ? execResult_result_result_52_memData : 8'h0; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2990 = 8'h0 == opcode & execResult_result_result_52_memWrite; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2991 = 8'h0 == opcode ? execResult_result_result_52_memRead : _GEN_2972; // @[CPU6502Core.scala 222:20 455:27]
  wire [15:0] _GEN_2992 = 8'h0 == opcode ? execResult_result_result_52_operand : _GEN_2973; // @[CPU6502Core.scala 222:20 455:27]
  wire  _GEN_2993 = 8'h60 == opcode ? execResult_result_result_8_done : _GEN_2974; // @[CPU6502Core.scala 222:20 454:27]
  wire [2:0] _GEN_2994 = 8'h60 == opcode ? execResult_result_result_11_nextCycle : _GEN_2975; // @[CPU6502Core.scala 222:20 454:27]
  wire [7:0] _GEN_2998 = 8'h60 == opcode ? execResult_result_newRegs_50_sp : _GEN_2979; // @[CPU6502Core.scala 222:20 454:27]
  wire [15:0] _GEN_2999 = 8'h60 == opcode ? execResult_result_newRegs_50_pc : _GEN_2980; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3000 = 8'h60 == opcode ? regs_flagC : _GEN_2981; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3001 = 8'h60 == opcode ? regs_flagZ : _GEN_2982; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3002 = 8'h60 == opcode ? regs_flagI : _GEN_2983; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3003 = 8'h60 == opcode ? regs_flagD : _GEN_2984; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3005 = 8'h60 == opcode ? regs_flagV : _GEN_2986; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3006 = 8'h60 == opcode ? regs_flagN : _GEN_2987; // @[CPU6502Core.scala 222:20 454:27]
  wire [15:0] _GEN_3007 = 8'h60 == opcode ? execResult_result_result_51_memAddr : _GEN_2988; // @[CPU6502Core.scala 222:20 454:27]
  wire [7:0] _GEN_3008 = 8'h60 == opcode ? 8'h0 : _GEN_2989; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3009 = 8'h60 == opcode ? 1'h0 : _GEN_2990; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3010 = 8'h60 == opcode ? execResult_result_result_51_memRead : _GEN_2991; // @[CPU6502Core.scala 222:20 454:27]
  wire [15:0] _GEN_3011 = 8'h60 == opcode ? execResult_result_result_51_operand : _GEN_2992; // @[CPU6502Core.scala 222:20 454:27]
  wire  _GEN_3012 = 8'h20 == opcode ? execResult_result_result_9_done : _GEN_2993; // @[CPU6502Core.scala 222:20 453:27]
  wire [2:0] _GEN_3013 = 8'h20 == opcode ? execResult_result_result_50_nextCycle : _GEN_2994; // @[CPU6502Core.scala 222:20 453:27]
  wire [7:0] _GEN_3017 = 8'h20 == opcode ? execResult_result_newRegs_49_sp : _GEN_2998; // @[CPU6502Core.scala 222:20 453:27]
  wire [15:0] _GEN_3018 = 8'h20 == opcode ? execResult_result_newRegs_49_pc : _GEN_2999; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3019 = 8'h20 == opcode ? regs_flagC : _GEN_3000; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3020 = 8'h20 == opcode ? regs_flagZ : _GEN_3001; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3021 = 8'h20 == opcode ? regs_flagI : _GEN_3002; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3022 = 8'h20 == opcode ? regs_flagD : _GEN_3003; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3024 = 8'h20 == opcode ? regs_flagV : _GEN_3005; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3025 = 8'h20 == opcode ? regs_flagN : _GEN_3006; // @[CPU6502Core.scala 222:20 453:27]
  wire [15:0] _GEN_3026 = 8'h20 == opcode ? execResult_result_result_50_memAddr : _GEN_3007; // @[CPU6502Core.scala 222:20 453:27]
  wire [7:0] _GEN_3027 = 8'h20 == opcode ? execResult_result_result_50_memData : _GEN_3008; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3028 = 8'h20 == opcode ? execResult_result_result_50_memWrite : _GEN_3009; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3029 = 8'h20 == opcode ? execResult_result_result_6_memRead : _GEN_3010; // @[CPU6502Core.scala 222:20 453:27]
  wire [15:0] _GEN_3030 = 8'h20 == opcode ? execResult_result_result_8_operand : _GEN_3011; // @[CPU6502Core.scala 222:20 453:27]
  wire  _GEN_3031 = 8'h6c == opcode ? execResult_result_result_9_done : _GEN_3012; // @[CPU6502Core.scala 222:20 452:27]
  wire [2:0] _GEN_3032 = 8'h6c == opcode ? execResult_result_result_6_nextCycle : _GEN_3013; // @[CPU6502Core.scala 222:20 452:27]
  wire [7:0] _GEN_3036 = 8'h6c == opcode ? regs_sp : _GEN_3017; // @[CPU6502Core.scala 222:20 452:27]
  wire [15:0] _GEN_3037 = 8'h6c == opcode ? execResult_result_newRegs_48_pc : _GEN_3018; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3038 = 8'h6c == opcode ? regs_flagC : _GEN_3019; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3039 = 8'h6c == opcode ? regs_flagZ : _GEN_3020; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3040 = 8'h6c == opcode ? regs_flagI : _GEN_3021; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3041 = 8'h6c == opcode ? regs_flagD : _GEN_3022; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3043 = 8'h6c == opcode ? regs_flagV : _GEN_3024; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3044 = 8'h6c == opcode ? regs_flagN : _GEN_3025; // @[CPU6502Core.scala 222:20 452:27]
  wire [15:0] _GEN_3045 = 8'h6c == opcode ? execResult_result_result_49_memAddr : _GEN_3026; // @[CPU6502Core.scala 222:20 452:27]
  wire [7:0] _GEN_3046 = 8'h6c == opcode ? 8'h0 : _GEN_3027; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3047 = 8'h6c == opcode ? 1'h0 : _GEN_3028; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3048 = 8'h6c == opcode ? execResult_result_result_9_memRead : _GEN_3029; // @[CPU6502Core.scala 222:20 452:27]
  wire [15:0] _GEN_3049 = 8'h6c == opcode ? execResult_result_result_49_operand : _GEN_3030; // @[CPU6502Core.scala 222:20 452:27]
  wire  _GEN_3050 = 8'h4c == opcode ? execResult_result_result_6_done : _GEN_3031; // @[CPU6502Core.scala 222:20 451:27]
  wire [2:0] _GEN_3051 = 8'h4c == opcode ? execResult_result_result_17_nextCycle : _GEN_3032; // @[CPU6502Core.scala 222:20 451:27]
  wire [7:0] _GEN_3055 = 8'h4c == opcode ? regs_sp : _GEN_3036; // @[CPU6502Core.scala 222:20 451:27]
  wire [15:0] _GEN_3056 = 8'h4c == opcode ? execResult_result_newRegs_47_pc : _GEN_3037; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3057 = 8'h4c == opcode ? regs_flagC : _GEN_3038; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3058 = 8'h4c == opcode ? regs_flagZ : _GEN_3039; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3059 = 8'h4c == opcode ? regs_flagI : _GEN_3040; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3060 = 8'h4c == opcode ? regs_flagD : _GEN_3041; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3062 = 8'h4c == opcode ? regs_flagV : _GEN_3043; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3063 = 8'h4c == opcode ? regs_flagN : _GEN_3044; // @[CPU6502Core.scala 222:20 451:27]
  wire [15:0] _GEN_3064 = 8'h4c == opcode ? execResult_result_result_48_memAddr : _GEN_3045; // @[CPU6502Core.scala 222:20 451:27]
  wire [7:0] _GEN_3065 = 8'h4c == opcode ? 8'h0 : _GEN_3046; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3066 = 8'h4c == opcode ? 1'h0 : _GEN_3047; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3067 = 8'h4c == opcode ? execResult_result_result_6_memRead : _GEN_3048; // @[CPU6502Core.scala 222:20 451:27]
  wire [15:0] _GEN_3068 = 8'h4c == opcode ? execResult_result_result_6_operand : _GEN_3049; // @[CPU6502Core.scala 222:20 451:27]
  wire  _GEN_3069 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_6_done : _GEN_3050; // @[CPU6502Core.scala 222:20 447:16]
  wire [2:0] _GEN_3070 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_17_nextCycle : _GEN_3051; // @[CPU6502Core.scala 222:20 447:16]
  wire [7:0] _GEN_3071 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_a : regs_a; // @[CPU6502Core.scala 222:20 447:16]
  wire [7:0] _GEN_3074 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_sp : _GEN_3055; // @[CPU6502Core.scala 222:20 447:16]
  wire [15:0] _GEN_3075 = 8'h68 == opcode | 8'h28 == opcode ? regs_pc : _GEN_3056; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3076 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagC : _GEN_3057; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3077 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagZ : _GEN_3058; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3078 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagI : _GEN_3059; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3079 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagD : _GEN_3060; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3081 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagV : _GEN_3062; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3082 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagN : _GEN_3063; // @[CPU6502Core.scala 222:20 447:16]
  wire [15:0] _GEN_3083 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_47_memAddr : _GEN_3064; // @[CPU6502Core.scala 222:20 447:16]
  wire [7:0] _GEN_3084 = 8'h68 == opcode | 8'h28 == opcode ? 8'h0 : _GEN_3065; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3085 = 8'h68 == opcode | 8'h28 == opcode ? 1'h0 : _GEN_3066; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3086 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_6_done : _GEN_3067; // @[CPU6502Core.scala 222:20 447:16]
  wire [15:0] _GEN_3087 = 8'h68 == opcode | 8'h28 == opcode ? 16'h0 : _GEN_3068; // @[CPU6502Core.scala 222:20 447:16]
  wire  _GEN_3088 = 8'h48 == opcode | 8'h8 == opcode | _GEN_3069; // @[CPU6502Core.scala 222:20 442:16]
  wire [2:0] _GEN_3089 = 8'h48 == opcode | 8'h8 == opcode ? 3'h0 : _GEN_3070; // @[CPU6502Core.scala 222:20 442:16]
  wire [7:0] _GEN_3090 = 8'h48 == opcode | 8'h8 == opcode ? regs_a : _GEN_3071; // @[CPU6502Core.scala 222:20 442:16]
  wire [7:0] _GEN_3093 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_newRegs_45_sp : _GEN_3074; // @[CPU6502Core.scala 222:20 442:16]
  wire [15:0] _GEN_3094 = 8'h48 == opcode | 8'h8 == opcode ? regs_pc : _GEN_3075; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3095 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagC : _GEN_3076; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3096 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagZ : _GEN_3077; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3097 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagI : _GEN_3078; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3098 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagD : _GEN_3079; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3100 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagV : _GEN_3081; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3101 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagN : _GEN_3082; // @[CPU6502Core.scala 222:20 442:16]
  wire [15:0] _GEN_3102 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_result_46_memAddr : _GEN_3083; // @[CPU6502Core.scala 222:20 442:16]
  wire [7:0] _GEN_3103 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_pushData : _GEN_3084; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3104 = 8'h48 == opcode | 8'h8 == opcode | _GEN_3085; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3105 = 8'h48 == opcode | 8'h8 == opcode ? 1'h0 : _GEN_3086; // @[CPU6502Core.scala 222:20 442:16]
  wire [15:0] _GEN_3106 = 8'h48 == opcode | 8'h8 == opcode ? 16'h0 : _GEN_3087; // @[CPU6502Core.scala 222:20 442:16]
  wire  _GEN_3107 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_44_done : _GEN_3088; // @[CPU6502Core.scala 222:20 437:16]
  wire [2:0] _GEN_3108 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3089; // @[CPU6502Core.scala 222:20 437:16]
  wire [7:0] _GEN_3109 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_a : _GEN_3090; // @[CPU6502Core.scala 222:20 437:16]
  wire [7:0] _GEN_3112 = 8'h91 == opcode | 8'hb1 == opcode ? regs_sp : _GEN_3093; // @[CPU6502Core.scala 222:20 437:16]
  wire [15:0] _GEN_3113 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3094; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3114 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagC : _GEN_3095; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3115 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_flagZ : _GEN_3096; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3116 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagI : _GEN_3097; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3117 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagD : _GEN_3098; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3119 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagV : _GEN_3100; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3120 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_flagN : _GEN_3101; // @[CPU6502Core.scala 222:20 437:16]
  wire [15:0] _GEN_3121 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memAddr : _GEN_3102; // @[CPU6502Core.scala 222:20 437:16]
  wire [7:0] _GEN_3122 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memData : _GEN_3103; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3123 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memWrite : _GEN_3104; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3124 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memRead : _GEN_3105; // @[CPU6502Core.scala 222:20 437:16]
  wire [15:0] _GEN_3125 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_36_operand : _GEN_3106; // @[CPU6502Core.scala 222:20 437:16]
  wire  _GEN_3126 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_done : _GEN_3107; // @[CPU6502Core.scala 222:20 432:16]
  wire [2:0] _GEN_3127 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_6_nextCycle : _GEN_3108; // @[CPU6502Core.scala 222:20 432:16]
  wire [7:0] _GEN_3128 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_a : _GEN_3109; // @[CPU6502Core.scala 222:20 432:16]
  wire [7:0] _GEN_3131 = 8'ha1 == opcode | 8'h81 == opcode ? regs_sp : _GEN_3112; // @[CPU6502Core.scala 222:20 432:16]
  wire [15:0] _GEN_3132 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_5_pc : _GEN_3113; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3133 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagC : _GEN_3114; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3134 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_flagZ : _GEN_3115; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3135 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagI : _GEN_3116; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3136 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagD : _GEN_3117; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3138 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagV : _GEN_3119; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3139 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_flagN : _GEN_3120; // @[CPU6502Core.scala 222:20 432:16]
  wire [15:0] _GEN_3140 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_9_memAddr : _GEN_3121; // @[CPU6502Core.scala 222:20 432:16]
  wire [7:0] _GEN_3141 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memData : _GEN_3122; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3142 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memWrite : _GEN_3123; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3143 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memRead : _GEN_3124; // @[CPU6502Core.scala 222:20 432:16]
  wire [15:0] _GEN_3144 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_9_operand : _GEN_3125; // @[CPU6502Core.scala 222:20 432:16]
  wire  _GEN_3145 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_8_done : _GEN_3126; // @[CPU6502Core.scala 222:20 427:16]
  wire [2:0] _GEN_3146 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_11_nextCycle : _GEN_3127; // @[CPU6502Core.scala 222:20 427:16]
  wire [7:0] _GEN_3147 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_42_a : _GEN_3128; // @[CPU6502Core.scala 222:20 427:16]
  wire [7:0] _GEN_3150 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? regs_sp : _GEN_3131; // @[CPU6502Core.scala 222:20 427:16]
  wire [15:0] _GEN_3151 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3132; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3152 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagC : _GEN_3133; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3153 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_42_flagZ : _GEN_3134; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3154 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagI : _GEN_3135; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3155 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagD : _GEN_3136; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3157 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagV : _GEN_3138; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3158 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_42_flagN : _GEN_3139; // @[CPU6502Core.scala 222:20 427:16]
  wire [15:0] _GEN_3159 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_8_memAddr : _GEN_3140; // @[CPU6502Core.scala 222:20 427:16]
  wire [7:0] _GEN_3160 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? 8'h0 : _GEN_3141; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3161 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? 1'h0 : _GEN_3142; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3162 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_8_memRead : _GEN_3143; // @[CPU6502Core.scala 222:20 427:16]
  wire [15:0] _GEN_3163 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_43_operand : _GEN_3144; // @[CPU6502Core.scala 222:20 427:16]
  wire  _GEN_3164 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_8_done : _GEN_3145; // @[CPU6502Core.scala 222:20 422:16]
  wire [2:0] _GEN_3165 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_11_nextCycle : _GEN_3146; // @[CPU6502Core.scala 222:20 422:16]
  wire [7:0] _GEN_3166 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_a : _GEN_3147; // @[CPU6502Core.scala 222:20 422:16]
  wire [7:0] _GEN_3167 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_x : regs_x; // @[CPU6502Core.scala 222:20 422:16]
  wire [7:0] _GEN_3168 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_y : regs_y; // @[CPU6502Core.scala 222:20 422:16]
  wire [7:0] _GEN_3169 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? regs_sp : _GEN_3150; // @[CPU6502Core.scala 222:20 422:16]
  wire [15:0] _GEN_3170 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3151; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3171 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagC : _GEN_3152; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3172 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_41_flagZ : _GEN_3153; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3173 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagI : _GEN_3154; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3174 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagD : _GEN_3155; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3176 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagV : _GEN_3157; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3177 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_41_flagN : _GEN_3158; // @[CPU6502Core.scala 222:20 422:16]
  wire [15:0] _GEN_3178 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_8_memAddr : _GEN_3159; // @[CPU6502Core.scala 222:20 422:16]
  wire [7:0] _GEN_3179 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_42_memData : _GEN_3160; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3180 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_memWrite : _GEN_3161; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3181 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_memRead : _GEN_3162; // @[CPU6502Core.scala 222:20 422:16]
  wire [15:0] _GEN_3182 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_8_operand : _GEN_3163; // @[CPU6502Core.scala 222:20 422:16]
  wire  _GEN_3183 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_done : _GEN_3164; // @[CPU6502Core.scala 222:20 417:16]
  wire [2:0] _GEN_3184 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_nextCycle : _GEN_3165; // @[CPU6502Core.scala 222:20 417:16]
  wire [7:0] _GEN_3185 = 8'hb6 == opcode | 8'h96 == opcode ? regs_a : _GEN_3166; // @[CPU6502Core.scala 222:20 417:16]
  wire [7:0] _GEN_3186 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_x : _GEN_3167; // @[CPU6502Core.scala 222:20 417:16]
  wire [7:0] _GEN_3187 = 8'hb6 == opcode | 8'h96 == opcode ? regs_y : _GEN_3168; // @[CPU6502Core.scala 222:20 417:16]
  wire [7:0] _GEN_3188 = 8'hb6 == opcode | 8'h96 == opcode ? regs_sp : _GEN_3169; // @[CPU6502Core.scala 222:20 417:16]
  wire [15:0] _GEN_3189 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_5_pc : _GEN_3170; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3190 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagC : _GEN_3171; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3191 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_flagZ : _GEN_3172; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3192 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagI : _GEN_3173; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3193 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagD : _GEN_3174; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3195 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagV : _GEN_3176; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3196 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_flagN : _GEN_3177; // @[CPU6502Core.scala 222:20 417:16]
  wire [15:0] _GEN_3197 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_memAddr : _GEN_3178; // @[CPU6502Core.scala 222:20 417:16]
  wire [7:0] _GEN_3198 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memData : _GEN_3179; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3199 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memWrite : _GEN_3180; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3200 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memRead : _GEN_3181; // @[CPU6502Core.scala 222:20 417:16]
  wire [15:0] _GEN_3201 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_operand : _GEN_3182; // @[CPU6502Core.scala 222:20 417:16]
  wire  _GEN_3202 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_6_done : _GEN_3183; // @[CPU6502Core.scala 222:20 412:16]
  wire [2:0] _GEN_3203 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_17_nextCycle : _GEN_3184; // @[CPU6502Core.scala 222:20 412:16]
  wire [7:0] _GEN_3204 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_a : _GEN_3185; // @[CPU6502Core.scala 222:20 412:16]
  wire [7:0] _GEN_3205 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_x : _GEN_3186; // @[CPU6502Core.scala 222:20 412:16]
  wire [7:0] _GEN_3206 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_y : _GEN_3187; // @[CPU6502Core.scala 222:20 412:16]
  wire [7:0] _GEN_3207 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_sp : _GEN_3188; // @[CPU6502Core.scala 222:20 412:16]
  wire [15:0] _GEN_3208 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3189; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3209 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagC : _GEN_3190; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3210 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_flagZ : _GEN_3191; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3211 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagI : _GEN_3192; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3212 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagD : _GEN_3193; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3214 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagV : _GEN_3195; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3215 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_flagN : _GEN_3196; // @[CPU6502Core.scala 222:20 412:16]
  wire [15:0] _GEN_3216 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_6_memAddr : _GEN_3197; // @[CPU6502Core.scala 222:20 412:16]
  wire [7:0] _GEN_3217 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memData : _GEN_3198; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3218 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memWrite : _GEN_3199; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3219 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memRead : _GEN_3200; // @[CPU6502Core.scala 222:20 412:16]
  wire [15:0] _GEN_3220 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_7_operand : _GEN_3201; // @[CPU6502Core.scala 222:20 412:16]
  wire  _GEN_3221 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_6_done : _GEN_3202; // @[CPU6502Core.scala 222:20 407:16]
  wire [2:0] _GEN_3222 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_17_nextCycle : _GEN_3203; // @[CPU6502Core.scala 222:20 407:16]
  wire [7:0] _GEN_3223 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_a : _GEN_3204; // @[CPU6502Core.scala 222:20 407:16]
  wire [7:0] _GEN_3224 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_x : _GEN_3205; // @[CPU6502Core.scala 222:20 407:16]
  wire [7:0] _GEN_3225 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_y : _GEN_3206; // @[CPU6502Core.scala 222:20 407:16]
  wire [7:0] _GEN_3226 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? regs_sp : _GEN_3207; // @[CPU6502Core.scala 222:20 407:16]
  wire [15:0] _GEN_3227 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_5_pc : _GEN_3208; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3228 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagC : _GEN_3209; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3229 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_38_flagZ : _GEN_3210; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3230 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagI : _GEN_3211; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3231 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagD : _GEN_3212; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3233 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagV : _GEN_3214; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3234 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_38_flagN : _GEN_3215; // @[CPU6502Core.scala 222:20 407:16]
  wire [15:0] _GEN_3235 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_memAddr : _GEN_3216; // @[CPU6502Core.scala 222:20 407:16]
  wire [7:0] _GEN_3236 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_39_memData : _GEN_3217; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3237 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_39_memWrite : _GEN_3218; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3238 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_39_memRead : _GEN_3219; // @[CPU6502Core.scala 222:20 407:16]
  wire [15:0] _GEN_3239 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_operand : _GEN_3220; // @[CPU6502Core.scala 222:20 407:16]
  wire  _GEN_3240 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_3221; // @[CPU6502Core.scala 222:20 402:16]
  wire [2:0] _GEN_3241 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 3'h0 : _GEN_3222; // @[CPU6502Core.scala 222:20 402:16]
  wire [7:0] _GEN_3242 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_a :
    _GEN_3223; // @[CPU6502Core.scala 222:20 402:16]
  wire [7:0] _GEN_3243 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_x :
    _GEN_3224; // @[CPU6502Core.scala 222:20 402:16]
  wire [7:0] _GEN_3244 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_y :
    _GEN_3225; // @[CPU6502Core.scala 222:20 402:16]
  wire [7:0] _GEN_3245 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_sp : _GEN_3226; // @[CPU6502Core.scala 222:20 402:16]
  wire [15:0] _GEN_3246 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? _regs_pc_T_1 : _GEN_3227; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3247 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagC : _GEN_3228; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3248 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_flagZ : _GEN_3229
    ; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3249 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagI : _GEN_3230; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3250 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagD : _GEN_3231; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3252 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagV : _GEN_3233; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3253 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? io_memDataIn[7] : _GEN_3234; // @[CPU6502Core.scala 222:20 402:16]
  wire [15:0] _GEN_3254 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_pc : _GEN_3235; // @[CPU6502Core.scala 222:20 402:16]
  wire [7:0] _GEN_3255 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 8'h0 : _GEN_3236; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3256 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 1'h0 : _GEN_3237; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3257 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_3238; // @[CPU6502Core.scala 222:20 402:16]
  wire [15:0] _GEN_3258 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 16'h0 : _GEN_3239; // @[CPU6502Core.scala 222:20 402:16]
  wire  _GEN_3259 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_3240; // @[CPU6502Core.scala 222:20 397:16]
  wire [2:0] _GEN_3260 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 3'h0 : _GEN_3241; // @[CPU6502Core.scala 222:20 397:16]
  wire [7:0] _GEN_3261 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_a : _GEN_3242; // @[CPU6502Core.scala 222:20 397:16]
  wire [7:0] _GEN_3262 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_x : _GEN_3243; // @[CPU6502Core.scala 222:20 397:16]
  wire [7:0] _GEN_3263 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_y : _GEN_3244; // @[CPU6502Core.scala 222:20 397:16]
  wire [7:0] _GEN_3264 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_sp : _GEN_3245; // @[CPU6502Core.scala 222:20 397:16]
  wire [15:0] _GEN_3265 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? execResult_result_newRegs_36_pc : _GEN_3246; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3266 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagC : _GEN_3247; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3267 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagZ : _GEN_3248; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3268 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagI : _GEN_3249; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3269 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagD : _GEN_3250; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3271 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagV : _GEN_3252; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3272 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagN : _GEN_3253; // @[CPU6502Core.scala 222:20 397:16]
  wire [15:0] _GEN_3273 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_pc : _GEN_3254; // @[CPU6502Core.scala 222:20 397:16]
  wire [7:0] _GEN_3274 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 8'h0 : _GEN_3255; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3275 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? 1'h0 : _GEN_3256; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3276 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_3257; // @[CPU6502Core.scala 222:20 397:16]
  wire [15:0] _GEN_3277 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 16'h0 : _GEN_3258; // @[CPU6502Core.scala 222:20 397:16]
  wire  _GEN_3278 = 8'hd2 == opcode ? execResult_result_result_9_done : _GEN_3259; // @[CPU6502Core.scala 222:20 392:16]
  wire [2:0] _GEN_3279 = 8'hd2 == opcode ? execResult_result_result_6_nextCycle : _GEN_3260; // @[CPU6502Core.scala 222:20 392:16]
  wire [7:0] _GEN_3280 = 8'hd2 == opcode ? regs_a : _GEN_3261; // @[CPU6502Core.scala 222:20 392:16]
  wire [7:0] _GEN_3281 = 8'hd2 == opcode ? regs_x : _GEN_3262; // @[CPU6502Core.scala 222:20 392:16]
  wire [7:0] _GEN_3282 = 8'hd2 == opcode ? regs_y : _GEN_3263; // @[CPU6502Core.scala 222:20 392:16]
  wire [7:0] _GEN_3283 = 8'hd2 == opcode ? regs_sp : _GEN_3264; // @[CPU6502Core.scala 222:20 392:16]
  wire [15:0] _GEN_3284 = 8'hd2 == opcode ? execResult_result_newRegs_5_pc : _GEN_3265; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3285 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3266; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3286 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3267; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3287 = 8'hd2 == opcode ? regs_flagI : _GEN_3268; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3288 = 8'hd2 == opcode ? regs_flagD : _GEN_3269; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3290 = 8'hd2 == opcode ? regs_flagV : _GEN_3271; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3291 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3272; // @[CPU6502Core.scala 222:20 392:16]
  wire [15:0] _GEN_3292 = 8'hd2 == opcode ? execResult_result_result_9_memAddr : _GEN_3273; // @[CPU6502Core.scala 222:20 392:16]
  wire [7:0] _GEN_3293 = 8'hd2 == opcode ? 8'h0 : _GEN_3274; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3294 = 8'hd2 == opcode ? 1'h0 : _GEN_3275; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3295 = 8'hd2 == opcode ? execResult_result_result_9_memRead : _GEN_3276; // @[CPU6502Core.scala 222:20 392:16]
  wire [15:0] _GEN_3296 = 8'hd2 == opcode ? execResult_result_result_36_operand : _GEN_3277; // @[CPU6502Core.scala 222:20 392:16]
  wire  _GEN_3297 = 8'hd1 == opcode ? execResult_result_result_9_done : _GEN_3278; // @[CPU6502Core.scala 222:20 387:16]
  wire [2:0] _GEN_3298 = 8'hd1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3279; // @[CPU6502Core.scala 222:20 387:16]
  wire [7:0] _GEN_3299 = 8'hd1 == opcode ? regs_a : _GEN_3280; // @[CPU6502Core.scala 222:20 387:16]
  wire [7:0] _GEN_3300 = 8'hd1 == opcode ? regs_x : _GEN_3281; // @[CPU6502Core.scala 222:20 387:16]
  wire [7:0] _GEN_3301 = 8'hd1 == opcode ? regs_y : _GEN_3282; // @[CPU6502Core.scala 222:20 387:16]
  wire [7:0] _GEN_3302 = 8'hd1 == opcode ? regs_sp : _GEN_3283; // @[CPU6502Core.scala 222:20 387:16]
  wire [15:0] _GEN_3303 = 8'hd1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3284; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3304 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3285; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3305 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3286; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3306 = 8'hd1 == opcode ? regs_flagI : _GEN_3287; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3307 = 8'hd1 == opcode ? regs_flagD : _GEN_3288; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3309 = 8'hd1 == opcode ? regs_flagV : _GEN_3290; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3310 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3291; // @[CPU6502Core.scala 222:20 387:16]
  wire [15:0] _GEN_3311 = 8'hd1 == opcode ? execResult_result_result_9_memAddr : _GEN_3292; // @[CPU6502Core.scala 222:20 387:16]
  wire [7:0] _GEN_3312 = 8'hd1 == opcode ? 8'h0 : _GEN_3293; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3313 = 8'hd1 == opcode ? 1'h0 : _GEN_3294; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3314 = 8'hd1 == opcode ? execResult_result_result_9_memRead : _GEN_3295; // @[CPU6502Core.scala 222:20 387:16]
  wire [15:0] _GEN_3315 = 8'hd1 == opcode ? execResult_result_result_10_operand : _GEN_3296; // @[CPU6502Core.scala 222:20 387:16]
  wire  _GEN_3316 = 8'hc1 == opcode ? execResult_result_result_9_done : _GEN_3297; // @[CPU6502Core.scala 222:20 382:16]
  wire [2:0] _GEN_3317 = 8'hc1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3298; // @[CPU6502Core.scala 222:20 382:16]
  wire [7:0] _GEN_3318 = 8'hc1 == opcode ? regs_a : _GEN_3299; // @[CPU6502Core.scala 222:20 382:16]
  wire [7:0] _GEN_3319 = 8'hc1 == opcode ? regs_x : _GEN_3300; // @[CPU6502Core.scala 222:20 382:16]
  wire [7:0] _GEN_3320 = 8'hc1 == opcode ? regs_y : _GEN_3301; // @[CPU6502Core.scala 222:20 382:16]
  wire [7:0] _GEN_3321 = 8'hc1 == opcode ? regs_sp : _GEN_3302; // @[CPU6502Core.scala 222:20 382:16]
  wire [15:0] _GEN_3322 = 8'hc1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3303; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3323 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3304; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3324 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3305; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3325 = 8'hc1 == opcode ? regs_flagI : _GEN_3306; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3326 = 8'hc1 == opcode ? regs_flagD : _GEN_3307; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3328 = 8'hc1 == opcode ? regs_flagV : _GEN_3309; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3329 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3310; // @[CPU6502Core.scala 222:20 382:16]
  wire [15:0] _GEN_3330 = 8'hc1 == opcode ? execResult_result_result_9_memAddr : _GEN_3311; // @[CPU6502Core.scala 222:20 382:16]
  wire [7:0] _GEN_3331 = 8'hc1 == opcode ? 8'h0 : _GEN_3312; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3332 = 8'hc1 == opcode ? 1'h0 : _GEN_3313; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3333 = 8'hc1 == opcode ? execResult_result_result_9_memRead : _GEN_3314; // @[CPU6502Core.scala 222:20 382:16]
  wire [15:0] _GEN_3334 = 8'hc1 == opcode ? execResult_result_result_9_operand : _GEN_3315; // @[CPU6502Core.scala 222:20 382:16]
  wire  _GEN_3335 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_done : _GEN_3316; // @[CPU6502Core.scala 222:20 377:16]
  wire [2:0] _GEN_3336 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_6_nextCycle : _GEN_3317; // @[CPU6502Core.scala 222:20 377:16]
  wire [7:0] _GEN_3337 = 8'hdd == opcode | 8'hd9 == opcode ? regs_a : _GEN_3318; // @[CPU6502Core.scala 222:20 377:16]
  wire [7:0] _GEN_3338 = 8'hdd == opcode | 8'hd9 == opcode ? regs_x : _GEN_3319; // @[CPU6502Core.scala 222:20 377:16]
  wire [7:0] _GEN_3339 = 8'hdd == opcode | 8'hd9 == opcode ? regs_y : _GEN_3320; // @[CPU6502Core.scala 222:20 377:16]
  wire [7:0] _GEN_3340 = 8'hdd == opcode | 8'hd9 == opcode ? regs_sp : _GEN_3321; // @[CPU6502Core.scala 222:20 377:16]
  wire [15:0] _GEN_3341 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_7_pc : _GEN_3322; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3342 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagC : _GEN_3323; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3343 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagZ : _GEN_3324; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3344 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagI : _GEN_3325; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3345 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagD : _GEN_3326; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3347 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagV : _GEN_3328; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3348 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagN : _GEN_3329; // @[CPU6502Core.scala 222:20 377:16]
  wire [15:0] _GEN_3349 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_memAddr : _GEN_3330; // @[CPU6502Core.scala 222:20 377:16]
  wire [7:0] _GEN_3350 = 8'hdd == opcode | 8'hd9 == opcode ? 8'h0 : _GEN_3331; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3351 = 8'hdd == opcode | 8'hd9 == opcode ? 1'h0 : _GEN_3332; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3352 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_memRead : _GEN_3333; // @[CPU6502Core.scala 222:20 377:16]
  wire [15:0] _GEN_3353 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_33_operand : _GEN_3334; // @[CPU6502Core.scala 222:20 377:16]
  wire  _GEN_3354 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_done : _GEN_3335; // @[CPU6502Core.scala 222:20 372:16]
  wire [2:0] _GEN_3355 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3336; // @[CPU6502Core.scala 222:20 372:16]
  wire [7:0] _GEN_3356 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_a : _GEN_3337; // @[CPU6502Core.scala 222:20 372:16]
  wire [7:0] _GEN_3357 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_x : _GEN_3338; // @[CPU6502Core.scala 222:20 372:16]
  wire [7:0] _GEN_3358 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_y : _GEN_3339; // @[CPU6502Core.scala 222:20 372:16]
  wire [7:0] _GEN_3359 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_sp : _GEN_3340; // @[CPU6502Core.scala 222:20 372:16]
  wire [15:0] _GEN_3360 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_7_pc :
    _GEN_3341; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3361 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagC : _GEN_3342
    ; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3362 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagZ : _GEN_3343
    ; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3363 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagI : _GEN_3344; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3364 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagD : _GEN_3345; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3366 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagV : _GEN_3347; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3367 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagN : _GEN_3348
    ; // @[CPU6502Core.scala 222:20 372:16]
  wire [15:0] _GEN_3368 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_memAddr :
    _GEN_3349; // @[CPU6502Core.scala 222:20 372:16]
  wire [7:0] _GEN_3369 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 8'h0 : _GEN_3350; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3370 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 1'h0 : _GEN_3351; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3371 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_memRead : _GEN_3352
    ; // @[CPU6502Core.scala 222:20 372:16]
  wire [15:0] _GEN_3372 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_operand :
    _GEN_3353; // @[CPU6502Core.scala 222:20 372:16]
  wire  _GEN_3373 = 8'hd5 == opcode ? execResult_result_result_6_done : _GEN_3354; // @[CPU6502Core.scala 222:20 367:16]
  wire [2:0] _GEN_3374 = 8'hd5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3355; // @[CPU6502Core.scala 222:20 367:16]
  wire [7:0] _GEN_3375 = 8'hd5 == opcode ? regs_a : _GEN_3356; // @[CPU6502Core.scala 222:20 367:16]
  wire [7:0] _GEN_3376 = 8'hd5 == opcode ? regs_x : _GEN_3357; // @[CPU6502Core.scala 222:20 367:16]
  wire [7:0] _GEN_3377 = 8'hd5 == opcode ? regs_y : _GEN_3358; // @[CPU6502Core.scala 222:20 367:16]
  wire [7:0] _GEN_3378 = 8'hd5 == opcode ? regs_sp : _GEN_3359; // @[CPU6502Core.scala 222:20 367:16]
  wire [15:0] _GEN_3379 = 8'hd5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3360; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3380 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagC : _GEN_3361; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3381 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagZ : _GEN_3362; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3382 = 8'hd5 == opcode ? regs_flagI : _GEN_3363; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3383 = 8'hd5 == opcode ? regs_flagD : _GEN_3364; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3385 = 8'hd5 == opcode ? regs_flagV : _GEN_3366; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3386 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagN : _GEN_3367; // @[CPU6502Core.scala 222:20 367:16]
  wire [15:0] _GEN_3387 = 8'hd5 == opcode ? execResult_result_result_6_memAddr : _GEN_3368; // @[CPU6502Core.scala 222:20 367:16]
  wire [7:0] _GEN_3388 = 8'hd5 == opcode ? 8'h0 : _GEN_3369; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3389 = 8'hd5 == opcode ? 1'h0 : _GEN_3370; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3390 = 8'hd5 == opcode ? execResult_result_result_6_memRead : _GEN_3371; // @[CPU6502Core.scala 222:20 367:16]
  wire [15:0] _GEN_3391 = 8'hd5 == opcode ? execResult_result_result_7_operand : _GEN_3372; // @[CPU6502Core.scala 222:20 367:16]
  wire  _GEN_3392 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_done : _GEN_3373; // @[CPU6502Core.scala 222:20 362:16]
  wire [2:0] _GEN_3393 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3374; // @[CPU6502Core.scala 222:20 362:16]
  wire [7:0] _GEN_3394 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_a : _GEN_3375; // @[CPU6502Core.scala 222:20 362:16]
  wire [7:0] _GEN_3395 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_x : _GEN_3376; // @[CPU6502Core.scala 222:20 362:16]
  wire [7:0] _GEN_3396 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_y : _GEN_3377; // @[CPU6502Core.scala 222:20 362:16]
  wire [7:0] _GEN_3397 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_sp : _GEN_3378; // @[CPU6502Core.scala 222:20 362:16]
  wire [15:0] _GEN_3398 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3379; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3399 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagC : _GEN_3380
    ; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3400 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagZ : _GEN_3381
    ; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3401 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagI : _GEN_3382; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3402 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagD : _GEN_3383; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3404 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagV : _GEN_3385; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3405 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagN : _GEN_3386
    ; // @[CPU6502Core.scala 222:20 362:16]
  wire [15:0] _GEN_3406 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3387; // @[CPU6502Core.scala 222:20 362:16]
  wire [7:0] _GEN_3407 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 8'h0 : _GEN_3388; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3408 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 1'h0 : _GEN_3389; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3409 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memRead : _GEN_3390
    ; // @[CPU6502Core.scala 222:20 362:16]
  wire [15:0] _GEN_3410 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_operand :
    _GEN_3391; // @[CPU6502Core.scala 222:20 362:16]
  wire  _GEN_3411 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_3392; // @[CPU6502Core.scala 222:20 357:16]
  wire [2:0] _GEN_3412 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 3'h0 : _GEN_3393; // @[CPU6502Core.scala 222:20 357:16]
  wire [7:0] _GEN_3413 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_a : _GEN_3394; // @[CPU6502Core.scala 222:20 357:16]
  wire [7:0] _GEN_3414 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_x : _GEN_3395; // @[CPU6502Core.scala 222:20 357:16]
  wire [7:0] _GEN_3415 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_y : _GEN_3396; // @[CPU6502Core.scala 222:20 357:16]
  wire [7:0] _GEN_3416 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_sp : _GEN_3397; // @[CPU6502Core.scala 222:20 357:16]
  wire [15:0] _GEN_3417 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? _regs_pc_T_1 : _GEN_3398; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3418 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagC : _GEN_3399
    ; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3419 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagZ : _GEN_3400
    ; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3420 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagI : _GEN_3401; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3421 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagD : _GEN_3402; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3423 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagV : _GEN_3404; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3424 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagN : _GEN_3405
    ; // @[CPU6502Core.scala 222:20 357:16]
  wire [15:0] _GEN_3425 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_pc : _GEN_3406; // @[CPU6502Core.scala 222:20 357:16]
  wire [7:0] _GEN_3426 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 8'h0 : _GEN_3407; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3427 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 1'h0 : _GEN_3408; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3428 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_3409; // @[CPU6502Core.scala 222:20 357:16]
  wire [15:0] _GEN_3429 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 16'h0 : _GEN_3410; // @[CPU6502Core.scala 222:20 357:16]
  wire  _GEN_3430 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_9_done : _GEN_3411; // @[CPU6502Core.scala 222:20 352:16]
  wire [2:0] _GEN_3431 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_6_nextCycle : _GEN_3412; // @[CPU6502Core.scala 222:20 352:16]
  wire [7:0] _GEN_3432 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_a : _GEN_3413; // @[CPU6502Core.scala 222:20 352:16]
  wire [7:0] _GEN_3433 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_x : _GEN_3414; // @[CPU6502Core.scala 222:20 352:16]
  wire [7:0] _GEN_3434 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_y : _GEN_3415; // @[CPU6502Core.scala 222:20 352:16]
  wire [7:0] _GEN_3435 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_sp : _GEN_3416; // @[CPU6502Core.scala 222:20 352:16]
  wire [15:0] _GEN_3436 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_7_pc : _GEN_3417; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3437 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagC : _GEN_3418; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3438 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagZ : _GEN_3419; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3439 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagI : _GEN_3420; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3440 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagD : _GEN_3421; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3442 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagV : _GEN_3423; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3443 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagN : _GEN_3424; // @[CPU6502Core.scala 222:20 352:16]
  wire [15:0] _GEN_3444 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_13_memAddr : _GEN_3425; // @[CPU6502Core.scala 222:20 352:16]
  wire [7:0] _GEN_3445 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_27_memData : _GEN_3426; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3446 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_9_done : _GEN_3427; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3447 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_8_memRead : _GEN_3428; // @[CPU6502Core.scala 222:20 352:16]
  wire [15:0] _GEN_3448 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_14_operand : _GEN_3429; // @[CPU6502Core.scala 222:20 352:16]
  wire  _GEN_3449 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_9_done : _GEN_3430; // @[CPU6502Core.scala 222:20 347:16]
  wire [2:0] _GEN_3450 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_6_nextCycle : _GEN_3431; // @[CPU6502Core.scala 222:20 347:16]
  wire [7:0] _GEN_3451 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_a : _GEN_3432; // @[CPU6502Core.scala 222:20 347:16]
  wire [7:0] _GEN_3452 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_x : _GEN_3433; // @[CPU6502Core.scala 222:20 347:16]
  wire [7:0] _GEN_3453 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_y : _GEN_3434; // @[CPU6502Core.scala 222:20 347:16]
  wire [7:0] _GEN_3454 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_sp : _GEN_3435; // @[CPU6502Core.scala 222:20 347:16]
  wire [15:0] _GEN_3455 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_newRegs_7_pc : _GEN_3436; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3456 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_newRegs_26_flagC : _GEN_3437; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3457 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_newRegs_26_flagZ : _GEN_3438; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3458 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_flagI : _GEN_3439; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3459 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_flagD : _GEN_3440; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3461 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? regs_flagV : _GEN_3442; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3462 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_newRegs_26_flagN : _GEN_3443; // @[CPU6502Core.scala 222:20 347:16]
  wire [15:0] _GEN_3463 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_13_memAddr : _GEN_3444; // @[CPU6502Core.scala 222:20 347:16]
  wire [7:0] _GEN_3464 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_27_memData : _GEN_3445; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3465 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_9_done : _GEN_3446; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3466 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_8_memRead : _GEN_3447; // @[CPU6502Core.scala 222:20 347:16]
  wire [15:0] _GEN_3467 = _execResult_result_T_92 | _execResult_result_T_99 | _execResult_result_T_106 |
    _execResult_result_T_113 ? execResult_result_result_8_operand : _GEN_3448; // @[CPU6502Core.scala 222:20 347:16]
  wire  _GEN_3468 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_8_done : _GEN_3449; // @[CPU6502Core.scala 222:20 342:16]
  wire [2:0] _GEN_3469 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3450; // @[CPU6502Core.scala 222:20 342:16]
  wire [7:0] _GEN_3470 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_a : _GEN_3451; // @[CPU6502Core.scala 222:20 342:16]
  wire [7:0] _GEN_3471 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_x : _GEN_3452; // @[CPU6502Core.scala 222:20 342:16]
  wire [7:0] _GEN_3472 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_y : _GEN_3453; // @[CPU6502Core.scala 222:20 342:16]
  wire [7:0] _GEN_3473 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_sp : _GEN_3454; // @[CPU6502Core.scala 222:20 342:16]
  wire [15:0] _GEN_3474 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3455; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3475 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagC : _GEN_3456; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3476 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagZ : _GEN_3457; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3477 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagI : _GEN_3458; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3478 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagD : _GEN_3459; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3480 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagV : _GEN_3461; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3481 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagN : _GEN_3462; // @[CPU6502Core.scala 222:20 342:16]
  wire [15:0] _GEN_3482 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_11_memAddr : _GEN_3463; // @[CPU6502Core.scala 222:20 342:16]
  wire [7:0] _GEN_3483 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_26_memData : _GEN_3464; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3484 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_8_done : _GEN_3465; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3485 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_6_memRead : _GEN_3466; // @[CPU6502Core.scala 222:20 342:16]
  wire [15:0] _GEN_3486 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_7_operand : _GEN_3467; // @[CPU6502Core.scala 222:20 342:16]
  wire  _GEN_3487 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_8_done : _GEN_3468; // @[CPU6502Core.scala 222:20 337:16]
  wire [2:0] _GEN_3488 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_11_nextCycle : _GEN_3469; // @[CPU6502Core.scala 222:20 337:16]
  wire [7:0] _GEN_3489 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_a : _GEN_3470; // @[CPU6502Core.scala 222:20 337:16]
  wire [7:0] _GEN_3490 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_x : _GEN_3471; // @[CPU6502Core.scala 222:20 337:16]
  wire [7:0] _GEN_3491 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_y : _GEN_3472; // @[CPU6502Core.scala 222:20 337:16]
  wire [7:0] _GEN_3492 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_sp : _GEN_3473; // @[CPU6502Core.scala 222:20 337:16]
  wire [15:0] _GEN_3493 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3474; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3494 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagC : _GEN_3475; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3495 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagZ : _GEN_3476; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3496 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagI : _GEN_3477; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3497 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagD : _GEN_3478; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3499 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagV : _GEN_3480; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3500 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagN : _GEN_3481; // @[CPU6502Core.scala 222:20 337:16]
  wire [15:0] _GEN_3501 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_11_memAddr : _GEN_3482; // @[CPU6502Core.scala 222:20 337:16]
  wire [7:0] _GEN_3502 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_25_memData : _GEN_3483; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3503 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_8_done : _GEN_3484; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3504 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memRead : _GEN_3485; // @[CPU6502Core.scala 222:20 337:16]
  wire [15:0] _GEN_3505 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_operand : _GEN_3486; // @[CPU6502Core.scala 222:20 337:16]
  wire  _GEN_3506 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode | _GEN_3487; // @[CPU6502Core.scala 222:20 332:16]
  wire [2:0] _GEN_3507 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 3'h0 : _GEN_3488; // @[CPU6502Core.scala 222:20 332:16]
  wire [7:0] _GEN_3508 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? execResult_result_res_22
     : _GEN_3489; // @[CPU6502Core.scala 222:20 332:16]
  wire [7:0] _GEN_3509 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_x : _GEN_3490; // @[CPU6502Core.scala 222:20 332:16]
  wire [7:0] _GEN_3510 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_y : _GEN_3491; // @[CPU6502Core.scala 222:20 332:16]
  wire [7:0] _GEN_3511 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_sp : _GEN_3492; // @[CPU6502Core.scala 222:20 332:16]
  wire [15:0] _GEN_3512 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_pc : _GEN_3493; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3513 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagC : _GEN_3494; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3514 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagZ : _GEN_3495; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3515 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagI : _GEN_3496; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3516 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagD : _GEN_3497; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3518 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagV : _GEN_3499; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3519 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagN : _GEN_3500; // @[CPU6502Core.scala 222:20 332:16]
  wire [15:0] _GEN_3520 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_3501; // @[CPU6502Core.scala 222:20 332:16]
  wire [7:0] _GEN_3521 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 8'h0 : _GEN_3502; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3522 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_3503; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3523 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_3504; // @[CPU6502Core.scala 222:20 332:16]
  wire [15:0] _GEN_3524 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_3505; // @[CPU6502Core.scala 222:20 332:16]
  wire  _GEN_3525 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_done : _GEN_3506; // @[CPU6502Core.scala 222:20 327:16]
  wire [2:0] _GEN_3526 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3507; // @[CPU6502Core.scala 222:20 327:16]
  wire [7:0] _GEN_3527 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_a :
    _GEN_3508; // @[CPU6502Core.scala 222:20 327:16]
  wire [7:0] _GEN_3528 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_x : _GEN_3509; // @[CPU6502Core.scala 222:20 327:16]
  wire [7:0] _GEN_3529 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_y : _GEN_3510; // @[CPU6502Core.scala 222:20 327:16]
  wire [7:0] _GEN_3530 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_sp : _GEN_3511; // @[CPU6502Core.scala 222:20 327:16]
  wire [15:0] _GEN_3531 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3512; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3532 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagC : _GEN_3513; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3533 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_3514
    ; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3534 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagI : _GEN_3515; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3535 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagD : _GEN_3516; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3537 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagV : _GEN_3518; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3538 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_flagN : _GEN_3519
    ; // @[CPU6502Core.scala 222:20 327:16]
  wire [15:0] _GEN_3539 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_memAddr :
    _GEN_3520; // @[CPU6502Core.scala 222:20 327:16]
  wire [7:0] _GEN_3540 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 8'h0 : _GEN_3521; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3541 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 1'h0 : _GEN_3522; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3542 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_memRead : _GEN_3523
    ; // @[CPU6502Core.scala 222:20 327:16]
  wire [15:0] _GEN_3543 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_10_operand :
    _GEN_3524; // @[CPU6502Core.scala 222:20 327:16]
  wire  _GEN_3544 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_done : _GEN_3525; // @[CPU6502Core.scala 222:20 322:16]
  wire [2:0] _GEN_3545 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3526; // @[CPU6502Core.scala 222:20 322:16]
  wire [7:0] _GEN_3546 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_a : _GEN_3527
    ; // @[CPU6502Core.scala 222:20 322:16]
  wire [7:0] _GEN_3547 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_x : _GEN_3528; // @[CPU6502Core.scala 222:20 322:16]
  wire [7:0] _GEN_3548 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_y : _GEN_3529; // @[CPU6502Core.scala 222:20 322:16]
  wire [7:0] _GEN_3549 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_sp : _GEN_3530; // @[CPU6502Core.scala 222:20 322:16]
  wire [15:0] _GEN_3550 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3531; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3551 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagC : _GEN_3532; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3552 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_3533; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3553 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagI : _GEN_3534; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3554 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagD : _GEN_3535; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3556 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagV : _GEN_3537; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3557 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_flagN : _GEN_3538; // @[CPU6502Core.scala 222:20 322:16]
  wire [15:0] _GEN_3558 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_memAddr :
    _GEN_3539; // @[CPU6502Core.scala 222:20 322:16]
  wire [7:0] _GEN_3559 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 8'h0 : _GEN_3540; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3560 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 1'h0 : _GEN_3541; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3561 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_memRead : _GEN_3542; // @[CPU6502Core.scala 222:20 322:16]
  wire [15:0] _GEN_3562 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_operand :
    _GEN_3543; // @[CPU6502Core.scala 222:20 322:16]
  wire  _GEN_3563 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_8_done : _GEN_3544; // @[CPU6502Core.scala 222:20 317:16]
  wire [2:0] _GEN_3564 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_6_nextCycle : _GEN_3545; // @[CPU6502Core.scala 222:20 317:16]
  wire [7:0] _GEN_3565 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_19_a : _GEN_3546; // @[CPU6502Core.scala 222:20 317:16]
  wire [7:0] _GEN_3566 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_x : _GEN_3547; // @[CPU6502Core.scala 222:20 317:16]
  wire [7:0] _GEN_3567 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_y : _GEN_3548; // @[CPU6502Core.scala 222:20 317:16]
  wire [7:0] _GEN_3568 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_sp : _GEN_3549; // @[CPU6502Core.scala 222:20 317:16]
  wire [15:0] _GEN_3569 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3550; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3570 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagC : _GEN_3551; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3571 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_19_flagZ : _GEN_3552; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3572 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagI : _GEN_3553; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3573 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagD : _GEN_3554; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3575 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagV : _GEN_3556; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3576 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_19_flagN : _GEN_3557; // @[CPU6502Core.scala 222:20 317:16]
  wire [15:0] _GEN_3577 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_8_memAddr : _GEN_3558; // @[CPU6502Core.scala 222:20 317:16]
  wire [7:0] _GEN_3578 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? 8'h0 : _GEN_3559; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3579 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? 1'h0 : _GEN_3560; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3580 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_8_memRead : _GEN_3561; // @[CPU6502Core.scala 222:20 317:16]
  wire [15:0] _GEN_3581 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_21_operand : _GEN_3562; // @[CPU6502Core.scala 222:20 317:16]
  wire  _GEN_3582 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_done : _GEN_3563; // @[CPU6502Core.scala 222:20 312:16]
  wire [2:0] _GEN_3583 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3564; // @[CPU6502Core.scala 222:20 312:16]
  wire [7:0] _GEN_3584 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_a : _GEN_3565; // @[CPU6502Core.scala 222:20 312:16]
  wire [7:0] _GEN_3585 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_x : _GEN_3566; // @[CPU6502Core.scala 222:20 312:16]
  wire [7:0] _GEN_3586 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_y : _GEN_3567; // @[CPU6502Core.scala 222:20 312:16]
  wire [7:0] _GEN_3587 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_sp : _GEN_3568; // @[CPU6502Core.scala 222:20 312:16]
  wire [15:0] _GEN_3588 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_7_pc : _GEN_3569; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3589 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagC : _GEN_3570; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3590 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagZ : _GEN_3571; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3591 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagI : _GEN_3572; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3592 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagD : _GEN_3573; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3594 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagV : _GEN_3575; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3595 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagN : _GEN_3576; // @[CPU6502Core.scala 222:20 312:16]
  wire [15:0] _GEN_3596 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_memAddr : _GEN_3577; // @[CPU6502Core.scala 222:20 312:16]
  wire [7:0] _GEN_3597 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 8'h0 : _GEN_3578; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3598 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 1'h0 : _GEN_3579; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3599 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_memRead : _GEN_3580; // @[CPU6502Core.scala 222:20 312:16]
  wire [15:0] _GEN_3600 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_operand : _GEN_3581; // @[CPU6502Core.scala 222:20 312:16]
  wire  _GEN_3601 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_done : _GEN_3582; // @[CPU6502Core.scala 222:20 307:16]
  wire [2:0] _GEN_3602 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3583; // @[CPU6502Core.scala 222:20 307:16]
  wire [7:0] _GEN_3603 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_a :
    _GEN_3584; // @[CPU6502Core.scala 222:20 307:16]
  wire [7:0] _GEN_3604 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_x : _GEN_3585; // @[CPU6502Core.scala 222:20 307:16]
  wire [7:0] _GEN_3605 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_y : _GEN_3586; // @[CPU6502Core.scala 222:20 307:16]
  wire [7:0] _GEN_3606 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_sp : _GEN_3587; // @[CPU6502Core.scala 222:20 307:16]
  wire [15:0] _GEN_3607 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3588; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3608 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagC : _GEN_3589; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3609 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_3590
    ; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3610 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagI : _GEN_3591; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3611 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagD : _GEN_3592; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3613 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagV : _GEN_3594; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3614 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_flagN : _GEN_3595
    ; // @[CPU6502Core.scala 222:20 307:16]
  wire [15:0] _GEN_3615 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3596; // @[CPU6502Core.scala 222:20 307:16]
  wire [7:0] _GEN_3616 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 8'h0 : _GEN_3597; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3617 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 1'h0 : _GEN_3598; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3618 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memRead : _GEN_3599
    ; // @[CPU6502Core.scala 222:20 307:16]
  wire [15:0] _GEN_3619 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_7_operand :
    _GEN_3600; // @[CPU6502Core.scala 222:20 307:16]
  wire  _GEN_3620 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_done : _GEN_3601; // @[CPU6502Core.scala 222:20 302:16]
  wire [2:0] _GEN_3621 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3602; // @[CPU6502Core.scala 222:20 302:16]
  wire [7:0] _GEN_3622 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_a : _GEN_3603
    ; // @[CPU6502Core.scala 222:20 302:16]
  wire [7:0] _GEN_3623 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_x : _GEN_3604; // @[CPU6502Core.scala 222:20 302:16]
  wire [7:0] _GEN_3624 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_y : _GEN_3605; // @[CPU6502Core.scala 222:20 302:16]
  wire [7:0] _GEN_3625 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_sp : _GEN_3606; // @[CPU6502Core.scala 222:20 302:16]
  wire [15:0] _GEN_3626 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3607; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3627 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagC : _GEN_3608; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3628 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_3609; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3629 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagI : _GEN_3610; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3630 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagD : _GEN_3611; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3632 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagV : _GEN_3613; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3633 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_flagN : _GEN_3614; // @[CPU6502Core.scala 222:20 302:16]
  wire [15:0] _GEN_3634 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3615; // @[CPU6502Core.scala 222:20 302:16]
  wire [7:0] _GEN_3635 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 8'h0 : _GEN_3616; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3636 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 1'h0 : _GEN_3617; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3637 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memRead : _GEN_3618; // @[CPU6502Core.scala 222:20 302:16]
  wire [15:0] _GEN_3638 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_operand :
    _GEN_3619; // @[CPU6502Core.scala 222:20 302:16]
  wire  _GEN_3639 = 8'h24 == opcode ? execResult_result_result_6_done : _GEN_3620; // @[CPU6502Core.scala 222:20 299:16]
  wire [2:0] _GEN_3640 = 8'h24 == opcode ? execResult_result_result_17_nextCycle : _GEN_3621; // @[CPU6502Core.scala 222:20 299:16]
  wire [7:0] _GEN_3641 = 8'h24 == opcode ? regs_a : _GEN_3622; // @[CPU6502Core.scala 222:20 299:16]
  wire [7:0] _GEN_3642 = 8'h24 == opcode ? regs_x : _GEN_3623; // @[CPU6502Core.scala 222:20 299:16]
  wire [7:0] _GEN_3643 = 8'h24 == opcode ? regs_y : _GEN_3624; // @[CPU6502Core.scala 222:20 299:16]
  wire [7:0] _GEN_3644 = 8'h24 == opcode ? regs_sp : _GEN_3625; // @[CPU6502Core.scala 222:20 299:16]
  wire [15:0] _GEN_3645 = 8'h24 == opcode ? execResult_result_newRegs_5_pc : _GEN_3626; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3646 = 8'h24 == opcode ? regs_flagC : _GEN_3627; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3647 = 8'h24 == opcode ? execResult_result_newRegs_16_flagZ : _GEN_3628; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3648 = 8'h24 == opcode ? regs_flagI : _GEN_3629; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3649 = 8'h24 == opcode ? regs_flagD : _GEN_3630; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3651 = 8'h24 == opcode ? execResult_result_newRegs_16_flagV : _GEN_3632; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3652 = 8'h24 == opcode ? execResult_result_newRegs_16_flagN : _GEN_3633; // @[CPU6502Core.scala 222:20 299:16]
  wire [15:0] _GEN_3653 = 8'h24 == opcode ? execResult_result_result_6_memAddr : _GEN_3634; // @[CPU6502Core.scala 222:20 299:16]
  wire [7:0] _GEN_3654 = 8'h24 == opcode ? 8'h0 : _GEN_3635; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3655 = 8'h24 == opcode ? 1'h0 : _GEN_3636; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3656 = 8'h24 == opcode ? execResult_result_result_6_memRead : _GEN_3637; // @[CPU6502Core.scala 222:20 299:16]
  wire [15:0] _GEN_3657 = 8'h24 == opcode ? execResult_result_result_6_operand : _GEN_3638; // @[CPU6502Core.scala 222:20 299:16]
  wire  _GEN_3658 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_3639; // @[CPU6502Core.scala 222:20 294:16]
  wire [2:0] _GEN_3659 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 3'h0 : _GEN_3640; // @[CPU6502Core.scala 222:20 294:16]
  wire [7:0] _GEN_3660 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_res_15 : _GEN_3641; // @[CPU6502Core.scala 222:20 294:16]
  wire [7:0] _GEN_3661 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_x : _GEN_3642; // @[CPU6502Core.scala 222:20 294:16]
  wire [7:0] _GEN_3662 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_y : _GEN_3643; // @[CPU6502Core.scala 222:20 294:16]
  wire [7:0] _GEN_3663 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_sp : _GEN_3644; // @[CPU6502Core.scala 222:20 294:16]
  wire [15:0] _GEN_3664 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? _regs_pc_T_1 : _GEN_3645; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3665 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagC : _GEN_3646; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3666 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_15_flagZ : _GEN_3647; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3667 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagI : _GEN_3648; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3668 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagD : _GEN_3649; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3670 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagV : _GEN_3651; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3671 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_15_flagN : _GEN_3652; // @[CPU6502Core.scala 222:20 294:16]
  wire [15:0] _GEN_3672 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_pc : _GEN_3653; // @[CPU6502Core.scala 222:20 294:16]
  wire [7:0] _GEN_3673 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 8'h0 : _GEN_3654; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3674 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 1'h0 : _GEN_3655; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3675 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_3656; // @[CPU6502Core.scala 222:20 294:16]
  wire [15:0] _GEN_3676 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 16'h0 : _GEN_3657; // @[CPU6502Core.scala 222:20 294:16]
  wire  _GEN_3677 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_9_done : _GEN_3658; // @[CPU6502Core.scala 222:20 289:16]
  wire [2:0] _GEN_3678 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3659; // @[CPU6502Core.scala 222:20 289:16]
  wire [7:0] _GEN_3679 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_a : _GEN_3660; // @[CPU6502Core.scala 222:20 289:16]
  wire [7:0] _GEN_3680 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_x : _GEN_3661; // @[CPU6502Core.scala 222:20 289:16]
  wire [7:0] _GEN_3681 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_y : _GEN_3662; // @[CPU6502Core.scala 222:20 289:16]
  wire [7:0] _GEN_3682 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_sp : _GEN_3663; // @[CPU6502Core.scala 222:20 289:16]
  wire [15:0] _GEN_3683 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_pc : _GEN_3664; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3684 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagC : _GEN_3665; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3685 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagZ : _GEN_3666; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3686 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagI : _GEN_3667; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3687 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagD : _GEN_3668; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3689 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagV : _GEN_3670; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3690 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagN : _GEN_3671; // @[CPU6502Core.scala 222:20 289:16]
  wire [15:0] _GEN_3691 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_15_memAddr : _GEN_3672; // @[CPU6502Core.scala 222:20 289:16]
  wire [7:0] _GEN_3692 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 8'h0 : _GEN_3673; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3693 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 1'h0 : _GEN_3674; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3694 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_memRead : _GEN_3675; // @[CPU6502Core.scala 222:20 289:16]
  wire [15:0] _GEN_3695 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_operand : _GEN_3676; // @[CPU6502Core.scala 222:20 289:16]
  wire  _GEN_3696 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_9_done : _GEN_3677; // @[CPU6502Core.scala 222:20 284:16]
  wire [2:0] _GEN_3697 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_6_nextCycle : _GEN_3678; // @[CPU6502Core.scala 222:20 284:16]
  wire [7:0] _GEN_3698 = 8'hfe == opcode | 8'hde == opcode ? regs_a : _GEN_3679; // @[CPU6502Core.scala 222:20 284:16]
  wire [7:0] _GEN_3699 = 8'hfe == opcode | 8'hde == opcode ? regs_x : _GEN_3680; // @[CPU6502Core.scala 222:20 284:16]
  wire [7:0] _GEN_3700 = 8'hfe == opcode | 8'hde == opcode ? regs_y : _GEN_3681; // @[CPU6502Core.scala 222:20 284:16]
  wire [7:0] _GEN_3701 = 8'hfe == opcode | 8'hde == opcode ? regs_sp : _GEN_3682; // @[CPU6502Core.scala 222:20 284:16]
  wire [15:0] _GEN_3702 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_7_pc : _GEN_3683; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3703 = 8'hfe == opcode | 8'hde == opcode ? regs_flagC : _GEN_3684; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3704 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_13_flagZ : _GEN_3685; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3705 = 8'hfe == opcode | 8'hde == opcode ? regs_flagI : _GEN_3686; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3706 = 8'hfe == opcode | 8'hde == opcode ? regs_flagD : _GEN_3687; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3708 = 8'hfe == opcode | 8'hde == opcode ? regs_flagV : _GEN_3689; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3709 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_13_flagN : _GEN_3690; // @[CPU6502Core.scala 222:20 284:16]
  wire [15:0] _GEN_3710 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_13_memAddr : _GEN_3691; // @[CPU6502Core.scala 222:20 284:16]
  wire [7:0] _GEN_3711 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_14_memData : _GEN_3692; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3712 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_9_done : _GEN_3693; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3713 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_8_memRead : _GEN_3694; // @[CPU6502Core.scala 222:20 284:16]
  wire [15:0] _GEN_3714 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_14_operand : _GEN_3695; // @[CPU6502Core.scala 222:20 284:16]
  wire  _GEN_3715 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_9_done : _GEN_3696; // @[CPU6502Core.scala 222:20 279:16]
  wire [2:0] _GEN_3716 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_6_nextCycle : _GEN_3697; // @[CPU6502Core.scala 222:20 279:16]
  wire [7:0] _GEN_3717 = 8'hee == opcode | 8'hce == opcode ? regs_a : _GEN_3698; // @[CPU6502Core.scala 222:20 279:16]
  wire [7:0] _GEN_3718 = 8'hee == opcode | 8'hce == opcode ? regs_x : _GEN_3699; // @[CPU6502Core.scala 222:20 279:16]
  wire [7:0] _GEN_3719 = 8'hee == opcode | 8'hce == opcode ? regs_y : _GEN_3700; // @[CPU6502Core.scala 222:20 279:16]
  wire [7:0] _GEN_3720 = 8'hee == opcode | 8'hce == opcode ? regs_sp : _GEN_3701; // @[CPU6502Core.scala 222:20 279:16]
  wire [15:0] _GEN_3721 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_7_pc : _GEN_3702; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3722 = 8'hee == opcode | 8'hce == opcode ? regs_flagC : _GEN_3703; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3723 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_12_flagZ : _GEN_3704; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3724 = 8'hee == opcode | 8'hce == opcode ? regs_flagI : _GEN_3705; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3725 = 8'hee == opcode | 8'hce == opcode ? regs_flagD : _GEN_3706; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3727 = 8'hee == opcode | 8'hce == opcode ? regs_flagV : _GEN_3708; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3728 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_12_flagN : _GEN_3709; // @[CPU6502Core.scala 222:20 279:16]
  wire [15:0] _GEN_3729 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_13_memAddr : _GEN_3710; // @[CPU6502Core.scala 222:20 279:16]
  wire [7:0] _GEN_3730 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_13_memData : _GEN_3711; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3731 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_9_done : _GEN_3712; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3732 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_8_memRead : _GEN_3713; // @[CPU6502Core.scala 222:20 279:16]
  wire [15:0] _GEN_3733 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_8_operand : _GEN_3714; // @[CPU6502Core.scala 222:20 279:16]
  wire  _GEN_3734 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_8_done : _GEN_3715; // @[CPU6502Core.scala 222:20 274:16]
  wire [2:0] _GEN_3735 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_6_nextCycle : _GEN_3716; // @[CPU6502Core.scala 222:20 274:16]
  wire [7:0] _GEN_3736 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_a : _GEN_3717; // @[CPU6502Core.scala 222:20 274:16]
  wire [7:0] _GEN_3737 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_x : _GEN_3718; // @[CPU6502Core.scala 222:20 274:16]
  wire [7:0] _GEN_3738 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_y : _GEN_3719; // @[CPU6502Core.scala 222:20 274:16]
  wire [7:0] _GEN_3739 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_sp : _GEN_3720; // @[CPU6502Core.scala 222:20 274:16]
  wire [15:0] _GEN_3740 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_5_pc : _GEN_3721; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3741 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagC : _GEN_3722; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3742 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_11_flagZ : _GEN_3723; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3743 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagI : _GEN_3724; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3744 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagD : _GEN_3725; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3746 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagV : _GEN_3727; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3747 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_11_flagN : _GEN_3728; // @[CPU6502Core.scala 222:20 274:16]
  wire [15:0] _GEN_3748 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_11_memAddr : _GEN_3729; // @[CPU6502Core.scala 222:20 274:16]
  wire [7:0] _GEN_3749 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_12_memData : _GEN_3730; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3750 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_8_done : _GEN_3731; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3751 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_6_memRead : _GEN_3732; // @[CPU6502Core.scala 222:20 274:16]
  wire [15:0] _GEN_3752 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_7_operand : _GEN_3733; // @[CPU6502Core.scala 222:20 274:16]
  wire  _GEN_3753 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_8_done : _GEN_3734; // @[CPU6502Core.scala 222:20 269:16]
  wire [2:0] _GEN_3754 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_nextCycle : _GEN_3735; // @[CPU6502Core.scala 222:20 269:16]
  wire [7:0] _GEN_3755 = 8'he6 == opcode | 8'hc6 == opcode ? regs_a : _GEN_3736; // @[CPU6502Core.scala 222:20 269:16]
  wire [7:0] _GEN_3756 = 8'he6 == opcode | 8'hc6 == opcode ? regs_x : _GEN_3737; // @[CPU6502Core.scala 222:20 269:16]
  wire [7:0] _GEN_3757 = 8'he6 == opcode | 8'hc6 == opcode ? regs_y : _GEN_3738; // @[CPU6502Core.scala 222:20 269:16]
  wire [7:0] _GEN_3758 = 8'he6 == opcode | 8'hc6 == opcode ? regs_sp : _GEN_3739; // @[CPU6502Core.scala 222:20 269:16]
  wire [15:0] _GEN_3759 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_pc : _GEN_3740; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3760 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagC : _GEN_3741; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3761 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_10_flagZ : _GEN_3742; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3762 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagI : _GEN_3743; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3763 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagD : _GEN_3744; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3765 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagV : _GEN_3746; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3766 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_10_flagN : _GEN_3747; // @[CPU6502Core.scala 222:20 269:16]
  wire [15:0] _GEN_3767 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_memAddr : _GEN_3748; // @[CPU6502Core.scala 222:20 269:16]
  wire [7:0] _GEN_3768 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_memData : _GEN_3749; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3769 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_8_done : _GEN_3750; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3770 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memRead : _GEN_3751; // @[CPU6502Core.scala 222:20 269:16]
  wire [15:0] _GEN_3771 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_operand : _GEN_3752; // @[CPU6502Core.scala 222:20 269:16]
  wire  _GEN_3772 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_done : _GEN_3753; // @[CPU6502Core.scala 222:20 264:16]
  wire [2:0] _GEN_3773 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3754; // @[CPU6502Core.scala 222:20 264:16]
  wire [7:0] _GEN_3774 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_a : _GEN_3755; // @[CPU6502Core.scala 222:20 264:16]
  wire [7:0] _GEN_3775 = 8'h71 == opcode | 8'hf1 == opcode ? regs_x : _GEN_3756; // @[CPU6502Core.scala 222:20 264:16]
  wire [7:0] _GEN_3776 = 8'h71 == opcode | 8'hf1 == opcode ? regs_y : _GEN_3757; // @[CPU6502Core.scala 222:20 264:16]
  wire [7:0] _GEN_3777 = 8'h71 == opcode | 8'hf1 == opcode ? regs_sp : _GEN_3758; // @[CPU6502Core.scala 222:20 264:16]
  wire [15:0] _GEN_3778 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3759; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3779 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagC : _GEN_3760; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3780 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_3761; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3781 = 8'h71 == opcode | 8'hf1 == opcode ? regs_flagI : _GEN_3762; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3782 = 8'h71 == opcode | 8'hf1 == opcode ? regs_flagD : _GEN_3763; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3784 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagV : _GEN_3765; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3785 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagN : _GEN_3766; // @[CPU6502Core.scala 222:20 264:16]
  wire [15:0] _GEN_3786 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_memAddr : _GEN_3767; // @[CPU6502Core.scala 222:20 264:16]
  wire [7:0] _GEN_3787 = 8'h71 == opcode | 8'hf1 == opcode ? 8'h0 : _GEN_3768; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3788 = 8'h71 == opcode | 8'hf1 == opcode ? 1'h0 : _GEN_3769; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3789 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_memRead : _GEN_3770; // @[CPU6502Core.scala 222:20 264:16]
  wire [15:0] _GEN_3790 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_10_operand : _GEN_3771; // @[CPU6502Core.scala 222:20 264:16]
  wire  _GEN_3791 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_done : _GEN_3772; // @[CPU6502Core.scala 222:20 259:16]
  wire [2:0] _GEN_3792 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3773; // @[CPU6502Core.scala 222:20 259:16]
  wire [7:0] _GEN_3793 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_a : _GEN_3774; // @[CPU6502Core.scala 222:20 259:16]
  wire [7:0] _GEN_3794 = 8'h61 == opcode | 8'he1 == opcode ? regs_x : _GEN_3775; // @[CPU6502Core.scala 222:20 259:16]
  wire [7:0] _GEN_3795 = 8'h61 == opcode | 8'he1 == opcode ? regs_y : _GEN_3776; // @[CPU6502Core.scala 222:20 259:16]
  wire [7:0] _GEN_3796 = 8'h61 == opcode | 8'he1 == opcode ? regs_sp : _GEN_3777; // @[CPU6502Core.scala 222:20 259:16]
  wire [15:0] _GEN_3797 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3778; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3798 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagC : _GEN_3779; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3799 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_3780; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3800 = 8'h61 == opcode | 8'he1 == opcode ? regs_flagI : _GEN_3781; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3801 = 8'h61 == opcode | 8'he1 == opcode ? regs_flagD : _GEN_3782; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3803 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagV : _GEN_3784; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3804 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagN : _GEN_3785; // @[CPU6502Core.scala 222:20 259:16]
  wire [15:0] _GEN_3805 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_memAddr : _GEN_3786; // @[CPU6502Core.scala 222:20 259:16]
  wire [7:0] _GEN_3806 = 8'h61 == opcode | 8'he1 == opcode ? 8'h0 : _GEN_3787; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3807 = 8'h61 == opcode | 8'he1 == opcode ? 1'h0 : _GEN_3788; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3808 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_memRead : _GEN_3789; // @[CPU6502Core.scala 222:20 259:16]
  wire [15:0] _GEN_3809 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_operand : _GEN_3790; // @[CPU6502Core.scala 222:20 259:16]
  wire  _GEN_3810 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_done : _GEN_3791; // @[CPU6502Core.scala 222:20 254:16]
  wire [2:0] _GEN_3811 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_6_nextCycle : _GEN_3792; // @[CPU6502Core.scala 222:20 254:16]
  wire [7:0] _GEN_3812 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_a : _GEN_3793; // @[CPU6502Core.scala 222:20 254:16]
  wire [7:0] _GEN_3813 = 8'h6d == opcode | 8'hed == opcode ? regs_x : _GEN_3794; // @[CPU6502Core.scala 222:20 254:16]
  wire [7:0] _GEN_3814 = 8'h6d == opcode | 8'hed == opcode ? regs_y : _GEN_3795; // @[CPU6502Core.scala 222:20 254:16]
  wire [7:0] _GEN_3815 = 8'h6d == opcode | 8'hed == opcode ? regs_sp : _GEN_3796; // @[CPU6502Core.scala 222:20 254:16]
  wire [15:0] _GEN_3816 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_pc : _GEN_3797; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3817 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagC : _GEN_3798; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3818 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagZ : _GEN_3799; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3819 = 8'h6d == opcode | 8'hed == opcode ? regs_flagI : _GEN_3800; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3820 = 8'h6d == opcode | 8'hed == opcode ? regs_flagD : _GEN_3801; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3822 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagV : _GEN_3803; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3823 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagN : _GEN_3804; // @[CPU6502Core.scala 222:20 254:16]
  wire [15:0] _GEN_3824 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_memAddr : _GEN_3805; // @[CPU6502Core.scala 222:20 254:16]
  wire [7:0] _GEN_3825 = 8'h6d == opcode | 8'hed == opcode ? 8'h0 : _GEN_3806; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3826 = 8'h6d == opcode | 8'hed == opcode ? 1'h0 : _GEN_3807; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3827 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_memRead : _GEN_3808; // @[CPU6502Core.scala 222:20 254:16]
  wire [15:0] _GEN_3828 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_operand : _GEN_3809; // @[CPU6502Core.scala 222:20 254:16]
  wire  _GEN_3829 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_done : _GEN_3810; // @[CPU6502Core.scala 222:20 249:16]
  wire [2:0] _GEN_3830 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3811; // @[CPU6502Core.scala 222:20 249:16]
  wire [7:0] _GEN_3831 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_a : _GEN_3812; // @[CPU6502Core.scala 222:20 249:16]
  wire [7:0] _GEN_3832 = 8'h75 == opcode | 8'hf5 == opcode ? regs_x : _GEN_3813; // @[CPU6502Core.scala 222:20 249:16]
  wire [7:0] _GEN_3833 = 8'h75 == opcode | 8'hf5 == opcode ? regs_y : _GEN_3814; // @[CPU6502Core.scala 222:20 249:16]
  wire [7:0] _GEN_3834 = 8'h75 == opcode | 8'hf5 == opcode ? regs_sp : _GEN_3815; // @[CPU6502Core.scala 222:20 249:16]
  wire [15:0] _GEN_3835 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3816; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3836 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagC : _GEN_3817; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3837 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_3818; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3838 = 8'h75 == opcode | 8'hf5 == opcode ? regs_flagI : _GEN_3819; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3839 = 8'h75 == opcode | 8'hf5 == opcode ? regs_flagD : _GEN_3820; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3841 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagV : _GEN_3822; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3842 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagN : _GEN_3823; // @[CPU6502Core.scala 222:20 249:16]
  wire [15:0] _GEN_3843 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_memAddr : _GEN_3824; // @[CPU6502Core.scala 222:20 249:16]
  wire [7:0] _GEN_3844 = 8'h75 == opcode | 8'hf5 == opcode ? 8'h0 : _GEN_3825; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3845 = 8'h75 == opcode | 8'hf5 == opcode ? 1'h0 : _GEN_3826; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3846 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_memRead : _GEN_3827; // @[CPU6502Core.scala 222:20 249:16]
  wire [15:0] _GEN_3847 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_7_operand : _GEN_3828; // @[CPU6502Core.scala 222:20 249:16]
  wire  _GEN_3848 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_done : _GEN_3829; // @[CPU6502Core.scala 222:20 244:16]
  wire [2:0] _GEN_3849 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3830; // @[CPU6502Core.scala 222:20 244:16]
  wire [7:0] _GEN_3850 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_a : _GEN_3831; // @[CPU6502Core.scala 222:20 244:16]
  wire [7:0] _GEN_3851 = 8'h65 == opcode | 8'he5 == opcode ? regs_x : _GEN_3832; // @[CPU6502Core.scala 222:20 244:16]
  wire [7:0] _GEN_3852 = 8'h65 == opcode | 8'he5 == opcode ? regs_y : _GEN_3833; // @[CPU6502Core.scala 222:20 244:16]
  wire [7:0] _GEN_3853 = 8'h65 == opcode | 8'he5 == opcode ? regs_sp : _GEN_3834; // @[CPU6502Core.scala 222:20 244:16]
  wire [15:0] _GEN_3854 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3835; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3855 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagC : _GEN_3836; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3856 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_3837; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3857 = 8'h65 == opcode | 8'he5 == opcode ? regs_flagI : _GEN_3838; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3858 = 8'h65 == opcode | 8'he5 == opcode ? regs_flagD : _GEN_3839; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3860 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagV : _GEN_3841; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3861 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagN : _GEN_3842; // @[CPU6502Core.scala 222:20 244:16]
  wire [15:0] _GEN_3862 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_memAddr : _GEN_3843; // @[CPU6502Core.scala 222:20 244:16]
  wire [7:0] _GEN_3863 = 8'h65 == opcode | 8'he5 == opcode ? 8'h0 : _GEN_3844; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3864 = 8'h65 == opcode | 8'he5 == opcode ? 1'h0 : _GEN_3845; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3865 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_memRead : _GEN_3846; // @[CPU6502Core.scala 222:20 244:16]
  wire [15:0] _GEN_3866 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_operand : _GEN_3847; // @[CPU6502Core.scala 222:20 244:16]
  wire  _GEN_3867 = 8'he9 == opcode | _GEN_3848; // @[CPU6502Core.scala 222:20 240:27]
  wire [2:0] _GEN_3868 = 8'he9 == opcode ? 3'h0 : _GEN_3849; // @[CPU6502Core.scala 222:20 240:27]
  wire [7:0] _GEN_3869 = 8'he9 == opcode ? execResult_result_newRegs_4_a : _GEN_3850; // @[CPU6502Core.scala 222:20 240:27]
  wire [7:0] _GEN_3870 = 8'he9 == opcode ? regs_x : _GEN_3851; // @[CPU6502Core.scala 222:20 240:27]
  wire [7:0] _GEN_3871 = 8'he9 == opcode ? regs_y : _GEN_3852; // @[CPU6502Core.scala 222:20 240:27]
  wire [7:0] _GEN_3872 = 8'he9 == opcode ? regs_sp : _GEN_3853; // @[CPU6502Core.scala 222:20 240:27]
  wire [15:0] _GEN_3873 = 8'he9 == opcode ? _regs_pc_T_1 : _GEN_3854; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3874 = 8'he9 == opcode ? execResult_result_newRegs_4_flagC : _GEN_3855; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3875 = 8'he9 == opcode ? execResult_result_newRegs_4_flagZ : _GEN_3856; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3876 = 8'he9 == opcode ? regs_flagI : _GEN_3857; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3877 = 8'he9 == opcode ? regs_flagD : _GEN_3858; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3879 = 8'he9 == opcode ? execResult_result_newRegs_4_flagV : _GEN_3860; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3880 = 8'he9 == opcode ? execResult_result_newRegs_4_flagN : _GEN_3861; // @[CPU6502Core.scala 222:20 240:27]
  wire [15:0] _GEN_3881 = 8'he9 == opcode ? regs_pc : _GEN_3862; // @[CPU6502Core.scala 222:20 240:27]
  wire [7:0] _GEN_3882 = 8'he9 == opcode ? 8'h0 : _GEN_3863; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3883 = 8'he9 == opcode ? 1'h0 : _GEN_3864; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3884 = 8'he9 == opcode | _GEN_3865; // @[CPU6502Core.scala 222:20 240:27]
  wire [15:0] _GEN_3885 = 8'he9 == opcode ? 16'h0 : _GEN_3866; // @[CPU6502Core.scala 222:20 240:27]
  wire  _GEN_3886 = 8'h69 == opcode | _GEN_3867; // @[CPU6502Core.scala 222:20 239:27]
  wire [2:0] _GEN_3887 = 8'h69 == opcode ? 3'h0 : _GEN_3868; // @[CPU6502Core.scala 222:20 239:27]
  wire [7:0] _GEN_3888 = 8'h69 == opcode ? execResult_result_newRegs_3_a : _GEN_3869; // @[CPU6502Core.scala 222:20 239:27]
  wire [7:0] _GEN_3889 = 8'h69 == opcode ? regs_x : _GEN_3870; // @[CPU6502Core.scala 222:20 239:27]
  wire [7:0] _GEN_3890 = 8'h69 == opcode ? regs_y : _GEN_3871; // @[CPU6502Core.scala 222:20 239:27]
  wire [7:0] _GEN_3891 = 8'h69 == opcode ? regs_sp : _GEN_3872; // @[CPU6502Core.scala 222:20 239:27]
  wire [15:0] _GEN_3892 = 8'h69 == opcode ? _regs_pc_T_1 : _GEN_3873; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3893 = 8'h69 == opcode ? execResult_result_newRegs_3_flagC : _GEN_3874; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3894 = 8'h69 == opcode ? execResult_result_newRegs_3_flagZ : _GEN_3875; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3895 = 8'h69 == opcode ? regs_flagI : _GEN_3876; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3896 = 8'h69 == opcode ? regs_flagD : _GEN_3877; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3898 = 8'h69 == opcode ? execResult_result_newRegs_3_flagV : _GEN_3879; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3899 = 8'h69 == opcode ? execResult_result_newRegs_3_flagN : _GEN_3880; // @[CPU6502Core.scala 222:20 239:27]
  wire [15:0] _GEN_3900 = 8'h69 == opcode ? regs_pc : _GEN_3881; // @[CPU6502Core.scala 222:20 239:27]
  wire [7:0] _GEN_3901 = 8'h69 == opcode ? 8'h0 : _GEN_3882; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3902 = 8'h69 == opcode ? 1'h0 : _GEN_3883; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3903 = 8'h69 == opcode | _GEN_3884; // @[CPU6502Core.scala 222:20 239:27]
  wire [15:0] _GEN_3904 = 8'h69 == opcode ? 16'h0 : _GEN_3885; // @[CPU6502Core.scala 222:20 239:27]
  wire  _GEN_3905 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode | _GEN_3886; // @[CPU6502Core.scala 222:20 235:16]
  wire [2:0] _GEN_3906 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 3'h0 : _GEN_3887; // @[CPU6502Core.scala 222:20 235:16]
  wire [7:0] _GEN_3907 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_a : _GEN_3888; // @[CPU6502Core.scala 222:20 235:16]
  wire [7:0] _GEN_3908 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_x : _GEN_3889; // @[CPU6502Core.scala 222:20 235:16]
  wire [7:0] _GEN_3909 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_y : _GEN_3890; // @[CPU6502Core.scala 222:20 235:16]
  wire [7:0] _GEN_3910 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_sp : _GEN_3891; // @[CPU6502Core.scala 222:20 235:16]
  wire [15:0] _GEN_3911 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_pc : _GEN_3892; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3912 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagC : _GEN_3893; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3913 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagZ : _GEN_3894; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3914 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagI : _GEN_3895; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3915 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagD : _GEN_3896; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3917 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagV : _GEN_3898; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3918 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagN : _GEN_3899; // @[CPU6502Core.scala 222:20 235:16]
  wire [15:0] _GEN_3919 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_3900; // @[CPU6502Core.scala 222:20 235:16]
  wire [7:0] _GEN_3920 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 8'h0 : _GEN_3901; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3921 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_3902; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3922 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_3903; // @[CPU6502Core.scala 222:20 235:16]
  wire [15:0] _GEN_3923 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_3904; // @[CPU6502Core.scala 222:20 235:16]
  wire  _GEN_3924 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode | _GEN_3905; // @[CPU6502Core.scala 222:20 230:16]
  wire [2:0] _GEN_3925 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 3'h0 : _GEN_3906; // @[CPU6502Core.scala 222:20 230:16]
  wire [7:0] _GEN_3926 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_a : _GEN_3907; // @[CPU6502Core.scala 222:20 230:16]
  wire [7:0] _GEN_3927 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_x : _GEN_3908; // @[CPU6502Core.scala 222:20 230:16]
  wire [7:0] _GEN_3928 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_y : _GEN_3909; // @[CPU6502Core.scala 222:20 230:16]
  wire [7:0] _GEN_3929 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_sp : _GEN_3910; // @[CPU6502Core.scala 222:20 230:16]
  wire [15:0] _GEN_3930 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? regs_pc : _GEN_3911; // @[CPU6502Core.scala 222:20 230:16]
  wire  _GEN_3931 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagC : _GEN_3912; // @[CPU6502Core.scala 222:20 230:16]
  wire  _GEN_3932 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagZ : _GEN_3913; // @[CPU6502Core.scala 222:20 230:16]
  wire  _GEN_3933 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagI : _GEN_3914; // @[CPU6502Core.scala 222:20 230:16]
  wire  _GEN_3934 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagD : _GEN_3915; // @[CPU6502Core.scala 222:20 230:16]
  wire  _GEN_3936 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagV : _GEN_3917; // @[CPU6502Core.scala 222:20 230:16]
  wire  _GEN_3937 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagN : _GEN_3918; // @[CPU6502Core.scala 222:20 230:16]
  wire [15:0] _GEN_3938 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_3919; // @[CPU6502Core.scala 222:20 230:16]
  wire [7:0] _GEN_3939 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 8'h0 : _GEN_3920; // @[CPU6502Core.scala 222:20 230:16]
  wire  _GEN_3940 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_3921; // @[CPU6502Core.scala 222:20 230:16]
  wire  _GEN_3941 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_3922; // @[CPU6502Core.scala 222:20 230:16]
  wire [15:0] _GEN_3942 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_3923; // @[CPU6502Core.scala 222:20 230:16]
  wire  execResult_result_1_done = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode | _GEN_3924; // @[CPU6502Core.scala 222:20 225:16]
  wire [2:0] execResult_result_1_nextCycle = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 3'h0 : _GEN_3925; // @[CPU6502Core.scala 222:20 225:16]
  wire [7:0] execResult_result_1_regs_a = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_a : _GEN_3926; // @[CPU6502Core.scala 222:20 225:16]
  wire [7:0] execResult_result_1_regs_x = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_x : _GEN_3927; // @[CPU6502Core.scala 222:20 225:16]
  wire [7:0] execResult_result_1_regs_y = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_y : _GEN_3928; // @[CPU6502Core.scala 222:20 225:16]
  wire [7:0] execResult_result_1_regs_sp = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_sp : _GEN_3929; // @[CPU6502Core.scala 222:20 225:16]
  wire [15:0] execResult_result_1_regs_pc = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_pc : _GEN_3930; // @[CPU6502Core.scala 222:20 225:16]
  wire  execResult_result_1_regs_flagC = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagC : _GEN_3931; // @[CPU6502Core.scala 222:20 225:16]
  wire  execResult_result_1_regs_flagZ = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagZ : _GEN_3932; // @[CPU6502Core.scala 222:20 225:16]
  wire  execResult_result_1_regs_flagI = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagI : _GEN_3933; // @[CPU6502Core.scala 222:20 225:16]
  wire  execResult_result_1_regs_flagD = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagD : _GEN_3934; // @[CPU6502Core.scala 222:20 225:16]
  wire  execResult_result_1_regs_flagV = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagV : _GEN_3936; // @[CPU6502Core.scala 222:20 225:16]
  wire  execResult_result_1_regs_flagN = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagN : _GEN_3937; // @[CPU6502Core.scala 222:20 225:16]
  wire [15:0] execResult_result_1_memAddr = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_3938; // @[CPU6502Core.scala 222:20 225:16]
  wire [7:0] execResult_result_1_memData = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 8'h0 : _GEN_3939; // @[CPU6502Core.scala 222:20 225:16]
  wire  execResult_result_1_memWrite = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_3940; // @[CPU6502Core.scala 222:20 225:16]
  wire  execResult_result_1_memRead = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_3941; // @[CPU6502Core.scala 222:20 225:16]
  wire [15:0] execResult_result_1_operand = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_3942; // @[CPU6502Core.scala 222:20 225:16]
  wire  _GEN_4027 = 3'h2 == state & execResult_result_1_done; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4071 = 3'h1 == state ? 1'h0 : _GEN_4027; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4113 = 3'h0 == state ? 1'h0 : _GEN_4071; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_done = io_reset ? 1'h0 : _GEN_4113; // @[CPU6502Core.scala 56:14 59:18]
  wire [2:0] _GEN_4028 = 3'h2 == state ? execResult_result_1_nextCycle : 3'h0; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [2:0] _GEN_4072 = 3'h1 == state ? 3'h0 : _GEN_4028; // @[CPU6502Core.scala 56:14 69:19]
  wire [2:0] _GEN_4114 = 3'h0 == state ? 3'h0 : _GEN_4072; // @[CPU6502Core.scala 56:14 69:19]
  wire [2:0] execResult_nextCycle = io_reset ? 3'h0 : _GEN_4114; // @[CPU6502Core.scala 56:14 59:18]
  wire [2:0] _GEN_3962 = execResult_done ? 3'h0 : execResult_nextCycle; // @[CPU6502Core.scala 143:19 145:33 146:19]
  wire [2:0] _GEN_3963 = execResult_done ? 3'h1 : state; // @[CPU6502Core.scala 145:33 147:19 25:22]
  wire [7:0] status = {regs_flagN,regs_flagV,2'h2,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_3966 = cycle == 3'h5 ? 3'h6 : 3'h0; // @[CPU6502Core.scala 185:37 189:19 197:19]
  wire [15:0] _GEN_3967 = cycle == 3'h5 ? regs_pc : resetVector; // @[CPU6502Core.scala 185:37 195:21 21:21]
  wire  _GEN_3968 = cycle == 3'h5 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 185:37 21:21 196:24]
  wire [2:0] _GEN_3969 = cycle == 3'h5 ? state : 3'h1; // @[CPU6502Core.scala 185:37 198:19 25:22]
  wire [15:0] _GEN_3970 = _T_9 ? 16'hfffa : 16'hfffb; // @[CPU6502Core.scala 179:37 181:24]
  wire [15:0] _GEN_3972 = _T_9 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 179:37 183:21 28:24]
  wire [2:0] _GEN_3973 = _T_9 ? 3'h5 : _GEN_3966; // @[CPU6502Core.scala 179:37 184:19]
  wire [15:0] _GEN_3974 = _T_9 ? regs_pc : _GEN_3967; // @[CPU6502Core.scala 179:37 21:21]
  wire  _GEN_3975 = _T_9 ? regs_flagI : _GEN_3968; // @[CPU6502Core.scala 179:37 21:21]
  wire [2:0] _GEN_3976 = _T_9 ? state : _GEN_3969; // @[CPU6502Core.scala 179:37 25:22]
  wire [15:0] _GEN_3977 = _T_8 ? execResult_result_result_46_memAddr : _GEN_3970; // @[CPU6502Core.scala 170:37 174:24]
  wire [7:0] _GEN_3978 = _T_8 ? status : 8'h0; // @[CPU6502Core.scala 170:37 175:27 50:17]
  wire [7:0] _GEN_3980 = _T_8 ? execResult_result_newRegs_45_sp : regs_sp; // @[CPU6502Core.scala 170:37 177:21 21:21]
  wire [2:0] _GEN_3981 = _T_8 ? 3'h4 : _GEN_3973; // @[CPU6502Core.scala 170:37 178:19]
  wire  _GEN_3982 = _T_8 ? 1'h0 : 1'h1; // @[CPU6502Core.scala 170:37 52:17]
  wire [15:0] _GEN_3983 = _T_8 ? operand : _GEN_3972; // @[CPU6502Core.scala 170:37 28:24]
  wire [15:0] _GEN_3984 = _T_8 ? regs_pc : _GEN_3974; // @[CPU6502Core.scala 170:37 21:21]
  wire  _GEN_3985 = _T_8 ? regs_flagI : _GEN_3975; // @[CPU6502Core.scala 170:37 21:21]
  wire [2:0] _GEN_3986 = _T_8 ? state : _GEN_3976; // @[CPU6502Core.scala 170:37 25:22]
  wire [15:0] _GEN_3987 = _T_7 ? execResult_result_result_46_memAddr : _GEN_3977; // @[CPU6502Core.scala 163:37 165:24]
  wire [7:0] _GEN_3988 = _T_7 ? regs_pc[7:0] : _GEN_3978; // @[CPU6502Core.scala 163:37 166:27]
  wire  _GEN_3989 = _T_7 | _T_8; // @[CPU6502Core.scala 163:37 167:25]
  wire [7:0] _GEN_3990 = _T_7 ? execResult_result_newRegs_45_sp : _GEN_3980; // @[CPU6502Core.scala 163:37 168:21]
  wire [2:0] _GEN_3991 = _T_7 ? 3'h3 : _GEN_3981; // @[CPU6502Core.scala 163:37 169:19]
  wire  _GEN_3992 = _T_7 ? 1'h0 : _GEN_3982; // @[CPU6502Core.scala 163:37 52:17]
  wire [15:0] _GEN_3993 = _T_7 ? operand : _GEN_3983; // @[CPU6502Core.scala 163:37 28:24]
  wire [15:0] _GEN_3994 = _T_7 ? regs_pc : _GEN_3984; // @[CPU6502Core.scala 163:37 21:21]
  wire  _GEN_3995 = _T_7 ? regs_flagI : _GEN_3985; // @[CPU6502Core.scala 163:37 21:21]
  wire [2:0] _GEN_3996 = _T_7 ? state : _GEN_3986; // @[CPU6502Core.scala 163:37 25:22]
  wire [15:0] _GEN_3997 = _T_6 ? execResult_result_result_46_memAddr : _GEN_3987; // @[CPU6502Core.scala 156:37 158:24]
  wire [7:0] _GEN_3998 = _T_6 ? regs_pc[15:8] : _GEN_3988; // @[CPU6502Core.scala 156:37 159:27]
  wire  _GEN_3999 = _T_6 | _GEN_3989; // @[CPU6502Core.scala 156:37 160:25]
  wire [7:0] _GEN_4000 = _T_6 ? execResult_result_newRegs_45_sp : _GEN_3990; // @[CPU6502Core.scala 156:37 161:21]
  wire [2:0] _GEN_4001 = _T_6 ? 3'h2 : _GEN_3991; // @[CPU6502Core.scala 156:37 162:19]
  wire  _GEN_4002 = _T_6 ? 1'h0 : _GEN_3992; // @[CPU6502Core.scala 156:37 52:17]
  wire [15:0] _GEN_4003 = _T_6 ? operand : _GEN_3993; // @[CPU6502Core.scala 156:37 28:24]
  wire [15:0] _GEN_4004 = _T_6 ? regs_pc : _GEN_3994; // @[CPU6502Core.scala 156:37 21:21]
  wire  _GEN_4005 = _T_6 ? regs_flagI : _GEN_3995; // @[CPU6502Core.scala 156:37 21:21]
  wire [2:0] _GEN_4006 = _T_6 ? state : _GEN_3996; // @[CPU6502Core.scala 156:37 25:22]
  wire [2:0] _GEN_4007 = _T_5 ? 3'h1 : _GEN_4001; // @[CPU6502Core.scala 153:31 155:19]
  wire [15:0] _GEN_4008 = _T_5 ? regs_pc : _GEN_3997; // @[CPU6502Core.scala 153:31 49:17]
  wire [7:0] _GEN_4009 = _T_5 ? 8'h0 : _GEN_3998; // @[CPU6502Core.scala 153:31 50:17]
  wire  _GEN_4010 = _T_5 ? 1'h0 : _GEN_3999; // @[CPU6502Core.scala 153:31 51:17]
  wire [7:0] _GEN_4011 = _T_5 ? regs_sp : _GEN_4000; // @[CPU6502Core.scala 153:31 21:21]
  wire  _GEN_4012 = _T_5 ? 1'h0 : _GEN_4002; // @[CPU6502Core.scala 153:31 52:17]
  wire [15:0] _GEN_4013 = _T_5 ? operand : _GEN_4003; // @[CPU6502Core.scala 153:31 28:24]
  wire [15:0] _GEN_4014 = _T_5 ? regs_pc : _GEN_4004; // @[CPU6502Core.scala 153:31 21:21]
  wire  _GEN_4015 = _T_5 ? regs_flagI : _GEN_4005; // @[CPU6502Core.scala 153:31 21:21]
  wire [2:0] _GEN_4016 = _T_5 ? state : _GEN_4006; // @[CPU6502Core.scala 153:31 25:22]
  wire [2:0] _GEN_4017 = 3'h3 == state ? _GEN_4007 : cycle; // @[CPU6502Core.scala 69:19 29:24]
  wire [15:0] _GEN_4018 = 3'h3 == state ? _GEN_4008 : regs_pc; // @[CPU6502Core.scala 49:17 69:19]
  wire [7:0] _GEN_4019 = 3'h3 == state ? _GEN_4009 : 8'h0; // @[CPU6502Core.scala 50:17 69:19]
  wire  _GEN_4020 = 3'h3 == state & _GEN_4010; // @[CPU6502Core.scala 51:17 69:19]
  wire [7:0] _GEN_4021 = 3'h3 == state ? _GEN_4011 : regs_sp; // @[CPU6502Core.scala 69:19 21:21]
  wire  _GEN_4022 = 3'h3 == state & _GEN_4012; // @[CPU6502Core.scala 52:17 69:19]
  wire [15:0] _GEN_4023 = 3'h3 == state ? _GEN_4013 : operand; // @[CPU6502Core.scala 69:19 28:24]
  wire [15:0] _GEN_4024 = 3'h3 == state ? _GEN_4014 : regs_pc; // @[CPU6502Core.scala 69:19 21:21]
  wire  _GEN_4025 = 3'h3 == state ? _GEN_4015 : regs_flagI; // @[CPU6502Core.scala 69:19 21:21]
  wire [2:0] _GEN_4026 = 3'h3 == state ? _GEN_4016 : state; // @[CPU6502Core.scala 69:19 25:22]
  wire [7:0] _GEN_4029 = 3'h2 == state ? execResult_result_1_regs_a : regs_a; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [7:0] _GEN_4030 = 3'h2 == state ? execResult_result_1_regs_x : regs_x; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [7:0] _GEN_4031 = 3'h2 == state ? execResult_result_1_regs_y : regs_y; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [7:0] _GEN_4032 = 3'h2 == state ? execResult_result_1_regs_sp : regs_sp; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [15:0] _GEN_4033 = 3'h2 == state ? execResult_result_1_regs_pc : regs_pc; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4034 = 3'h2 == state ? execResult_result_1_regs_flagC : regs_flagC; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4035 = 3'h2 == state ? execResult_result_1_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4036 = 3'h2 == state ? execResult_result_1_regs_flagI : regs_flagI; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4037 = 3'h2 == state ? execResult_result_1_regs_flagD : regs_flagD; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4039 = 3'h2 == state ? execResult_result_1_regs_flagV : regs_flagV; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4040 = 3'h2 == state ? execResult_result_1_regs_flagN : regs_flagN; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [15:0] _GEN_4041 = 3'h2 == state ? execResult_result_1_memAddr : 16'h0; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [7:0] _GEN_4042 = 3'h2 == state ? execResult_result_1_memData : 8'h0; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4043 = 3'h2 == state & execResult_result_1_memWrite; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire  _GEN_4044 = 3'h2 == state & execResult_result_1_memRead; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [15:0] _GEN_4045 = 3'h2 == state ? execResult_result_1_operand : operand; // @[CPU6502Core.scala 69:19 133:22 56:14]
  wire [15:0] _GEN_4085 = 3'h1 == state ? 16'h0 : _GEN_4041; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] _GEN_4127 = 3'h0 == state ? 16'h0 : _GEN_4085; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] execResult_memAddr = io_reset ? 16'h0 : _GEN_4127; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4046 = 3'h2 == state ? execResult_memAddr : _GEN_4018; // @[CPU6502Core.scala 69:19 136:25]
  wire [7:0] _GEN_4086 = 3'h1 == state ? 8'h0 : _GEN_4042; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4128 = 3'h0 == state ? 8'h0 : _GEN_4086; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_memData = io_reset ? 8'h0 : _GEN_4128; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4047 = 3'h2 == state ? execResult_memData : _GEN_4019; // @[CPU6502Core.scala 69:19 137:25]
  wire  _GEN_4087 = 3'h1 == state ? 1'h0 : _GEN_4043; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4129 = 3'h0 == state ? 1'h0 : _GEN_4087; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_memWrite = io_reset ? 1'h0 : _GEN_4129; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4048 = 3'h2 == state ? execResult_memWrite : _GEN_4020; // @[CPU6502Core.scala 69:19 138:25]
  wire  _GEN_4088 = 3'h1 == state ? 1'h0 : _GEN_4044; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4130 = 3'h0 == state ? 1'h0 : _GEN_4088; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_memRead = io_reset ? 1'h0 : _GEN_4130; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4049 = 3'h2 == state ? execResult_memRead : _GEN_4022; // @[CPU6502Core.scala 69:19 139:25]
  wire [7:0] _GEN_4073 = 3'h1 == state ? regs_a : _GEN_4029; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4115 = 3'h0 == state ? regs_a : _GEN_4073; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_regs_a = io_reset ? regs_a : _GEN_4115; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4050 = 3'h2 == state ? execResult_regs_a : regs_a; // @[CPU6502Core.scala 141:19 69:19 21:21]
  wire [7:0] _GEN_4074 = 3'h1 == state ? regs_x : _GEN_4030; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4116 = 3'h0 == state ? regs_x : _GEN_4074; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_regs_x = io_reset ? regs_x : _GEN_4116; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4051 = 3'h2 == state ? execResult_regs_x : regs_x; // @[CPU6502Core.scala 141:19 69:19 21:21]
  wire [7:0] _GEN_4075 = 3'h1 == state ? regs_y : _GEN_4031; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4117 = 3'h0 == state ? regs_y : _GEN_4075; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_regs_y = io_reset ? regs_y : _GEN_4117; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4052 = 3'h2 == state ? execResult_regs_y : regs_y; // @[CPU6502Core.scala 141:19 69:19 21:21]
  wire [7:0] _GEN_4076 = 3'h1 == state ? regs_sp : _GEN_4032; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4118 = 3'h0 == state ? regs_sp : _GEN_4076; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_regs_sp = io_reset ? regs_sp : _GEN_4118; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4053 = 3'h2 == state ? execResult_regs_sp : _GEN_4021; // @[CPU6502Core.scala 141:19 69:19]
  wire [15:0] _GEN_4077 = 3'h1 == state ? regs_pc : _GEN_4033; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] _GEN_4119 = 3'h0 == state ? regs_pc : _GEN_4077; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] execResult_regs_pc = io_reset ? regs_pc : _GEN_4119; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4054 = 3'h2 == state ? execResult_regs_pc : _GEN_4024; // @[CPU6502Core.scala 141:19 69:19]
  wire  _GEN_4078 = 3'h1 == state ? regs_flagC : _GEN_4034; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4120 = 3'h0 == state ? regs_flagC : _GEN_4078; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagC = io_reset ? regs_flagC : _GEN_4120; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4055 = 3'h2 == state ? execResult_regs_flagC : regs_flagC; // @[CPU6502Core.scala 141:19 69:19 21:21]
  wire  _GEN_4079 = 3'h1 == state ? regs_flagZ : _GEN_4035; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4121 = 3'h0 == state ? regs_flagZ : _GEN_4079; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagZ = io_reset ? regs_flagZ : _GEN_4121; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4056 = 3'h2 == state ? execResult_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 141:19 69:19 21:21]
  wire  _GEN_4080 = 3'h1 == state ? regs_flagI : _GEN_4036; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4122 = 3'h0 == state ? regs_flagI : _GEN_4080; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagI = io_reset ? regs_flagI : _GEN_4122; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4057 = 3'h2 == state ? execResult_regs_flagI : _GEN_4025; // @[CPU6502Core.scala 141:19 69:19]
  wire  _GEN_4081 = 3'h1 == state ? regs_flagD : _GEN_4037; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4123 = 3'h0 == state ? regs_flagD : _GEN_4081; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagD = io_reset ? regs_flagD : _GEN_4123; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4058 = 3'h2 == state ? execResult_regs_flagD : regs_flagD; // @[CPU6502Core.scala 141:19 69:19 21:21]
  wire  _GEN_4083 = 3'h1 == state ? regs_flagV : _GEN_4039; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4125 = 3'h0 == state ? regs_flagV : _GEN_4083; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagV = io_reset ? regs_flagV : _GEN_4125; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4060 = 3'h2 == state ? execResult_regs_flagV : regs_flagV; // @[CPU6502Core.scala 141:19 69:19 21:21]
  wire  _GEN_4084 = 3'h1 == state ? regs_flagN : _GEN_4040; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4126 = 3'h0 == state ? regs_flagN : _GEN_4084; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagN = io_reset ? regs_flagN : _GEN_4126; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4061 = 3'h2 == state ? execResult_regs_flagN : regs_flagN; // @[CPU6502Core.scala 141:19 69:19 21:21]
  wire [15:0] _GEN_4089 = 3'h1 == state ? operand : _GEN_4045; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] _GEN_4131 = 3'h0 == state ? operand : _GEN_4089; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] execResult_operand = io_reset ? operand : _GEN_4131; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4062 = 3'h2 == state ? execResult_operand : _GEN_4023; // @[CPU6502Core.scala 142:19 69:19]
  wire [2:0] _GEN_4063 = 3'h2 == state ? _GEN_3962 : _GEN_4017; // @[CPU6502Core.scala 69:19]
  wire [2:0] _GEN_4064 = 3'h2 == state ? _GEN_3963 : _GEN_4026; // @[CPU6502Core.scala 69:19]
  wire [15:0] _GEN_4067 = 3'h1 == state ? regs_pc : _GEN_4046; // @[CPU6502Core.scala 69:19]
  wire  _GEN_4068 = 3'h1 == state ? _GEN_43 : _GEN_4049; // @[CPU6502Core.scala 69:19]
  wire [7:0] _GEN_4090 = 3'h1 == state ? 8'h0 : _GEN_4047; // @[CPU6502Core.scala 50:17 69:19]
  wire  _GEN_4091 = 3'h1 == state ? 1'h0 : _GEN_4048; // @[CPU6502Core.scala 51:17 69:19]
  wire [15:0] _GEN_4104 = 3'h0 == state ? _GEN_32 : _GEN_4067; // @[CPU6502Core.scala 69:19]
  wire  _GEN_4105 = 3'h0 == state | _GEN_4068; // @[CPU6502Core.scala 69:19]
  wire [7:0] _GEN_4132 = 3'h0 == state ? 8'h0 : _GEN_4090; // @[CPU6502Core.scala 50:17 69:19]
  wire  _GEN_4133 = 3'h0 == state ? 1'h0 : _GEN_4091; // @[CPU6502Core.scala 51:17 69:19]
  assign io_memAddr = io_reset ? regs_pc : _GEN_4104; // @[CPU6502Core.scala 49:17 59:18]
  assign io_memDataOut = io_reset ? 8'h0 : _GEN_4132; // @[CPU6502Core.scala 50:17 59:18]
  assign io_memWrite = io_reset ? 1'h0 : _GEN_4133; // @[CPU6502Core.scala 51:17 59:18]
  assign io_memRead = io_reset ? 1'h0 : _GEN_4105; // @[CPU6502Core.scala 52:17 59:18]
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
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_a <= _GEN_4050;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_x <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_x <= _GEN_4051;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_y <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_y <= _GEN_4052;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_sp <= 8'hff; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 69:19]
        if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 72:31]
          regs_sp <= _GEN_29;
        end
      end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
        regs_sp <= _GEN_4053;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 69:19]
        if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 72:31]
          regs_pc <= _GEN_28;
        end
      end else if (3'h1 == state) begin // @[CPU6502Core.scala 69:19]
        regs_pc <= _GEN_45;
      end else begin
        regs_pc <= _GEN_4054;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagC <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagC <= _GEN_4055;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagZ <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagZ <= _GEN_4056;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagI <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 69:19]
        if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 72:31]
          regs_flagI <= _GEN_30;
        end
      end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
        regs_flagI <= _GEN_4057;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagD <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagD <= _GEN_4058;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagV <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagV <= _GEN_4060;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagN <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagN <= _GEN_4061;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 25:22]
      state <= 3'h0; // @[CPU6502Core.scala 25:22]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      state <= 3'h0; // @[CPU6502Core.scala 61:11]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 69:19]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 72:31]
        state <= _GEN_31;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 69:19]
      state <= _GEN_41;
    end else begin
      state <= _GEN_4064;
    end
    if (reset) begin // @[CPU6502Core.scala 27:24]
      opcode <= 8'h0; // @[CPU6502Core.scala 27:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      opcode <= 8'h0; // @[CPU6502Core.scala 63:12]
    end else if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
      if (3'h1 == state) begin // @[CPU6502Core.scala 69:19]
        opcode <= _GEN_44;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 28:24]
      operand <= 16'h0; // @[CPU6502Core.scala 28:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      operand <= 16'h0; // @[CPU6502Core.scala 64:13]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 69:19]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 72:31]
        operand <= _GEN_27;
      end
    end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
      operand <= _GEN_4062;
    end
    if (reset) begin // @[CPU6502Core.scala 29:24]
      cycle <= 3'h0; // @[CPU6502Core.scala 29:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      cycle <= 3'h0; // @[CPU6502Core.scala 62:11]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 69:19]
      if (cycle == 3'h0) begin // @[CPU6502Core.scala 72:31]
        cycle <= 3'h1; // @[CPU6502Core.scala 76:19]
      end else begin
        cycle <= _GEN_26;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 69:19]
      cycle <= 3'h0;
    end else begin
      cycle <= _GEN_4063;
    end
    if (reset) begin // @[CPU6502Core.scala 32:24]
      nmiLast <= 1'h0; // @[CPU6502Core.scala 32:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      nmiLast <= 1'h0; // @[CPU6502Core.scala 66:13]
    end else begin
      nmiLast <= io_nmi; // @[CPU6502Core.scala 36:11]
    end
    if (reset) begin // @[CPU6502Core.scala 33:27]
      nmiPending <= 1'h0; // @[CPU6502Core.scala 33:27]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      nmiPending <= 1'h0; // @[CPU6502Core.scala 65:16]
    end else if (state == 3'h1 & nmiPending) begin // @[CPU6502Core.scala 44:40]
      nmiPending <= 1'h0; // @[CPU6502Core.scala 45:16]
    end else begin
      nmiPending <= _GEN_0;
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
module PPUSimplified(
  input         clock,
  input         reset,
  input  [2:0]  io_cpuAddr,
  input  [7:0]  io_cpuDataIn,
  output [7:0]  io_cpuDataOut,
  input         io_cpuWrite,
  input         io_cpuRead,
  input  [7:0]  io_oamDmaAddr,
  input  [7:0]  io_oamDmaData,
  input         io_oamDmaWrite,
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
  reg [7:0] vram [0:2047]; // @[PPUSimplified.scala 53:17]
  wire  vram_io_cpuDataOut_MPORT_2_en; // @[PPUSimplified.scala 53:17]
  wire [10:0] vram_io_cpuDataOut_MPORT_2_addr; // @[PPUSimplified.scala 53:17]
  wire [7:0] vram_io_cpuDataOut_MPORT_2_data; // @[PPUSimplified.scala 53:17]
  wire  vram_tileIndex_en; // @[PPUSimplified.scala 53:17]
  wire [10:0] vram_tileIndex_addr; // @[PPUSimplified.scala 53:17]
  wire [7:0] vram_tileIndex_data; // @[PPUSimplified.scala 53:17]
  wire  vram_attrByte_en; // @[PPUSimplified.scala 53:17]
  wire [10:0] vram_attrByte_addr; // @[PPUSimplified.scala 53:17]
  wire [7:0] vram_attrByte_data; // @[PPUSimplified.scala 53:17]
  wire [7:0] vram_MPORT_4_data; // @[PPUSimplified.scala 53:17]
  wire [10:0] vram_MPORT_4_addr; // @[PPUSimplified.scala 53:17]
  wire  vram_MPORT_4_mask; // @[PPUSimplified.scala 53:17]
  wire  vram_MPORT_4_en; // @[PPUSimplified.scala 53:17]
  reg [7:0] oam [0:255]; // @[PPUSimplified.scala 54:16]
  wire  oam_io_cpuDataOut_MPORT_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_io_cpuDataOut_MPORT_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_io_cpuDataOut_MPORT_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprY_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprTile_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprAttr_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprX_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprY_1_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_1_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_1_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprTile_1_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_1_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_1_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprAttr_1_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_1_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_1_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprX_1_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_1_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_1_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprY_2_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_2_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_2_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprTile_2_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_2_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_2_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprAttr_2_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_2_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_2_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprX_2_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_2_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_2_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprY_3_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_3_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_3_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprTile_3_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_3_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_3_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprAttr_3_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_3_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_3_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprX_3_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_3_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_3_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprY_4_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_4_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_4_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprTile_4_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_4_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_4_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprAttr_4_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_4_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_4_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprX_4_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_4_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_4_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprY_5_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_5_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_5_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprTile_5_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_5_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_5_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprAttr_5_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_5_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_5_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprX_5_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_5_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_5_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprY_6_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_6_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_6_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprTile_6_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_6_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_6_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprAttr_6_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_6_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_6_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprX_6_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_6_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_6_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprY_7_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_7_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprY_7_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprTile_7_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_7_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprTile_7_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprAttr_7_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_7_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprAttr_7_data; // @[PPUSimplified.scala 54:16]
  wire  oam_sprX_7_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_7_addr; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_sprX_7_data; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_MPORT_1_data; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_MPORT_1_addr; // @[PPUSimplified.scala 54:16]
  wire  oam_MPORT_1_mask; // @[PPUSimplified.scala 54:16]
  wire  oam_MPORT_1_en; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_MPORT_2_data; // @[PPUSimplified.scala 54:16]
  wire [7:0] oam_MPORT_2_addr; // @[PPUSimplified.scala 54:16]
  wire  oam_MPORT_2_mask; // @[PPUSimplified.scala 54:16]
  wire  oam_MPORT_2_en; // @[PPUSimplified.scala 54:16]
  reg [7:0] palette [0:31]; // @[PPUSimplified.scala 55:20]
  wire  palette_io_cpuDataOut_MPORT_3_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_io_cpuDataOut_MPORT_3_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_io_cpuDataOut_MPORT_3_data; // @[PPUSimplified.scala 55:20]
  wire  palette_paletteColor_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_paletteColor_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_paletteColor_data; // @[PPUSimplified.scala 55:20]
  wire  palette_sprPaletteColor_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_sprPaletteColor_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_sprPaletteColor_data; // @[PPUSimplified.scala 55:20]
  wire  palette_sprPaletteColor_1_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_sprPaletteColor_1_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_sprPaletteColor_1_data; // @[PPUSimplified.scala 55:20]
  wire  palette_sprPaletteColor_2_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_sprPaletteColor_2_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_sprPaletteColor_2_data; // @[PPUSimplified.scala 55:20]
  wire  palette_sprPaletteColor_3_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_sprPaletteColor_3_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_sprPaletteColor_3_data; // @[PPUSimplified.scala 55:20]
  wire  palette_sprPaletteColor_4_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_sprPaletteColor_4_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_sprPaletteColor_4_data; // @[PPUSimplified.scala 55:20]
  wire  palette_sprPaletteColor_5_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_sprPaletteColor_5_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_sprPaletteColor_5_data; // @[PPUSimplified.scala 55:20]
  wire  palette_sprPaletteColor_6_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_sprPaletteColor_6_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_sprPaletteColor_6_data; // @[PPUSimplified.scala 55:20]
  wire  palette_sprPaletteColor_7_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_sprPaletteColor_7_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_sprPaletteColor_7_data; // @[PPUSimplified.scala 55:20]
  wire  palette_pixelColor_MPORT_en; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_pixelColor_MPORT_addr; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_pixelColor_MPORT_data; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_MPORT_data; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_MPORT_addr; // @[PPUSimplified.scala 55:20]
  wire  palette_MPORT_mask; // @[PPUSimplified.scala 55:20]
  wire  palette_MPORT_en; // @[PPUSimplified.scala 55:20]
  wire [7:0] palette_MPORT_5_data; // @[PPUSimplified.scala 55:20]
  wire [4:0] palette_MPORT_5_addr; // @[PPUSimplified.scala 55:20]
  wire  palette_MPORT_5_mask; // @[PPUSimplified.scala 55:20]
  wire  palette_MPORT_5_en; // @[PPUSimplified.scala 55:20]
  reg [7:0] chrROM [0:8191]; // @[PPUSimplified.scala 56:19]
  wire  chrROM_io_cpuDataOut_MPORT_1_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_io_cpuDataOut_MPORT_1_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_io_cpuDataOut_MPORT_1_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_patternLow_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_patternLow_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_patternLow_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_patternHigh_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_patternHigh_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_patternHigh_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternLow_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternLow_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternLow_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternHigh_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternHigh_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternHigh_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternLow_1_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternLow_1_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternLow_1_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternHigh_1_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternHigh_1_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternHigh_1_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternLow_2_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternLow_2_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternLow_2_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternHigh_2_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternHigh_2_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternHigh_2_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternLow_3_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternLow_3_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternLow_3_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternHigh_3_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternHigh_3_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternHigh_3_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternLow_4_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternLow_4_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternLow_4_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternHigh_4_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternHigh_4_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternHigh_4_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternLow_5_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternLow_5_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternLow_5_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternHigh_5_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternHigh_5_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternHigh_5_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternLow_6_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternLow_6_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternLow_6_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternHigh_6_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternHigh_6_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternHigh_6_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternLow_7_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternLow_7_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternLow_7_data; // @[PPUSimplified.scala 56:19]
  wire  chrROM_sprPatternHigh_7_en; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_sprPatternHigh_7_addr; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_sprPatternHigh_7_data; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_MPORT_3_data; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_MPORT_3_addr; // @[PPUSimplified.scala 56:19]
  wire  chrROM_MPORT_3_mask; // @[PPUSimplified.scala 56:19]
  wire  chrROM_MPORT_3_en; // @[PPUSimplified.scala 56:19]
  wire [7:0] chrROM_MPORT_6_data; // @[PPUSimplified.scala 56:19]
  wire [12:0] chrROM_MPORT_6_addr; // @[PPUSimplified.scala 56:19]
  wire  chrROM_MPORT_6_mask; // @[PPUSimplified.scala 56:19]
  wire  chrROM_MPORT_6_en; // @[PPUSimplified.scala 56:19]
  reg [7:0] ppuCtrl; // @[PPUSimplified.scala 44:24]
  reg [7:0] ppuMask; // @[PPUSimplified.scala 45:24]
  reg [7:0] oamAddr; // @[PPUSimplified.scala 46:24]
  reg  ppuAddrLatch; // @[PPUSimplified.scala 49:29]
  reg [15:0] ppuAddrReg; // @[PPUSimplified.scala 50:27]
  reg  paletteInitDone; // @[PPUSimplified.scala 59:32]
  reg [4:0] paletteInitAddr; // @[PPUSimplified.scala 60:32]
  wire  _T = ~paletteInitDone; // @[PPUSimplified.scala 62:8]
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
  wire [4:0] _paletteInitAddr_T_1 = paletteInitAddr + 5'h1; // @[PPUSimplified.scala 75:40]
  wire  _GEN_32 = paletteInitAddr == 5'h1f | paletteInitDone; // @[PPUSimplified.scala 77:36 78:23 59:32]
  reg [8:0] scanlineX; // @[PPUSimplified.scala 83:26]
  reg [8:0] scanlineY; // @[PPUSimplified.scala 84:26]
  wire [8:0] _scanlineX_T_1 = scanlineX + 9'h1; // @[PPUSimplified.scala 86:26]
  wire [8:0] _scanlineY_T_1 = scanlineY + 9'h1; // @[PPUSimplified.scala 89:28]
  wire  _T_3 = scanlineY == 9'h105; // @[PPUSimplified.scala 90:20]
  reg  vblankFlag; // @[PPUSimplified.scala 96:27]
  reg  nmiOccurred; // @[PPUSimplified.scala 97:28]
  wire  _T_5 = scanlineX == 9'h1; // @[PPUSimplified.scala 100:41]
  wire  _GEN_43 = ppuCtrl[7] | nmiOccurred; // @[PPUSimplified.scala 102:22 103:19 97:28]
  wire  _GEN_44 = scanlineY == 9'hf1 & scanlineX == 9'h1 | vblankFlag; // @[PPUSimplified.scala 100:50 101:16 96:27]
  reg  vblankClearNext; // @[PPUSimplified.scala 116:32]
  wire  _GEN_51 = vblankClearNext ? 1'h0 : vblankClearNext; // @[PPUSimplified.scala 117:25 120:21 116:32]
  wire [1:0] io_cpuDataOut_hi = {vblankFlag,1'h0}; // @[Cat.scala 33:92]
  wire [7:0] _io_cpuDataOut_T = {vblankFlag,1'h0,6'h0}; // @[Cat.scala 33:92]
  wire  _T_12 = 3'h4 == io_cpuAddr; // @[PPUSimplified.scala 124:24]
  wire  _T_13 = 3'h7 == io_cpuAddr; // @[PPUSimplified.scala 124:24]
  wire  _T_14 = ppuAddrReg < 16'h2000; // @[PPUSimplified.scala 134:25]
  wire  _T_15 = ppuAddrReg < 16'h3f00; // @[PPUSimplified.scala 136:31]
  wire [7:0] _GEN_55 = ppuAddrReg < 16'h3f00 ? vram_io_cpuDataOut_MPORT_2_data : palette_io_cpuDataOut_MPORT_3_data; // @[PPUSimplified.scala 136:43 137:25 139:25]
  wire  _GEN_58 = ppuAddrReg < 16'h3f00 ? 1'h0 : 1'h1; // @[PPUSimplified.scala 136:43 55:20 139:40]
  wire [7:0] _GEN_62 = ppuAddrReg < 16'h2000 ? chrROM_io_cpuDataOut_MPORT_1_data : _GEN_55; // @[PPUSimplified.scala 134:37 135:25]
  wire  _GEN_65 = ppuAddrReg < 16'h2000 ? 1'h0 : _T_15; // @[PPUSimplified.scala 134:37 53:17]
  wire  _GEN_68 = ppuAddrReg < 16'h2000 ? 1'h0 : _GEN_58; // @[PPUSimplified.scala 134:37 55:20]
  wire [15:0] _ppuAddrReg_T_1 = ppuAddrReg + 16'h1; // @[PPUSimplified.scala 141:34]
  wire  _GEN_71 = 3'h7 == io_cpuAddr & _T_14; // @[PPUSimplified.scala 124:24 56:19]
  wire [7:0] _GEN_72 = 3'h7 == io_cpuAddr ? _GEN_62 : 8'h0; // @[PPUSimplified.scala 114:17 124:24]
  wire  _GEN_75 = 3'h7 == io_cpuAddr & _GEN_65; // @[PPUSimplified.scala 124:24 53:17]
  wire  _GEN_78 = 3'h7 == io_cpuAddr & _GEN_68; // @[PPUSimplified.scala 124:24 55:20]
  wire [15:0] _GEN_79 = 3'h7 == io_cpuAddr ? _ppuAddrReg_T_1 : ppuAddrReg; // @[PPUSimplified.scala 124:24 141:20 50:27]
  wire [7:0] _GEN_83 = 3'h4 == io_cpuAddr ? oam_io_cpuDataOut_MPORT_data : _GEN_72; // @[PPUSimplified.scala 124:24 131:23]
  wire  _GEN_86 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _T_14; // @[PPUSimplified.scala 124:24 56:19]
  wire  _GEN_89 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _GEN_65; // @[PPUSimplified.scala 124:24 53:17]
  wire  _GEN_92 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _GEN_68; // @[PPUSimplified.scala 124:24 55:20]
  wire [15:0] _GEN_93 = 3'h4 == io_cpuAddr ? ppuAddrReg : _GEN_79; // @[PPUSimplified.scala 124:24 50:27]
  wire [7:0] _GEN_94 = 3'h2 == io_cpuAddr ? _io_cpuDataOut_T : _GEN_83; // @[PPUSimplified.scala 124:24 126:23]
  wire  _GEN_95 = 3'h2 == io_cpuAddr | _GEN_51; // @[PPUSimplified.scala 124:24 127:25]
  wire  _GEN_96 = 3'h2 == io_cpuAddr ? 1'h0 : ppuAddrLatch; // @[PPUSimplified.scala 124:24 128:22 49:29]
  wire  _GEN_99 = 3'h2 == io_cpuAddr ? 1'h0 : 3'h4 == io_cpuAddr; // @[PPUSimplified.scala 124:24 54:16]
  wire  _GEN_102 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_86; // @[PPUSimplified.scala 124:24 56:19]
  wire  _GEN_105 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_89; // @[PPUSimplified.scala 124:24 53:17]
  wire  _GEN_108 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_92; // @[PPUSimplified.scala 124:24 55:20]
  wire [15:0] _GEN_109 = 3'h2 == io_cpuAddr ? ppuAddrReg : _GEN_93; // @[PPUSimplified.scala 124:24 50:27]
  wire  _GEN_112 = io_cpuRead ? _GEN_96 : ppuAddrLatch; // @[PPUSimplified.scala 123:20 49:29]
  wire [15:0] _GEN_125 = io_cpuRead ? _GEN_109 : ppuAddrReg; // @[PPUSimplified.scala 123:20 50:27]
  wire [7:0] _oamAddr_T_1 = oamAddr + 8'h1; // @[PPUSimplified.scala 158:28]
  wire  _T_21 = ~ppuAddrLatch; // @[PPUSimplified.scala 161:14]
  wire [13:0] _ppuAddrReg_T_3 = {io_cpuDataIn[5:0],8'h0}; // @[Cat.scala 33:92]
  wire [15:0] _ppuAddrReg_T_5 = {ppuAddrReg[15:8],io_cpuDataIn}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_133 = _T_21 ? {{2'd0}, _ppuAddrReg_T_3} : _ppuAddrReg_T_5; // @[PPUSimplified.scala 169:29 170:22 172:22]
  wire [15:0] _GEN_174 = _T_13 ? _ppuAddrReg_T_1 : _GEN_125; // @[PPUSimplified.scala 152:24 184:20]
  wire [15:0] _GEN_175 = 3'h6 == io_cpuAddr ? _GEN_133 : _GEN_174; // @[PPUSimplified.scala 152:24]
  wire  _GEN_176 = 3'h6 == io_cpuAddr ? _T_21 : _GEN_112; // @[PPUSimplified.scala 152:24 174:22]
  wire  _GEN_179 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_71; // @[PPUSimplified.scala 152:24 56:19]
  wire  _GEN_184 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_75; // @[PPUSimplified.scala 152:24 53:17]
  wire  _GEN_189 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_78; // @[PPUSimplified.scala 152:24 55:20]
  wire  _GEN_194 = 3'h5 == io_cpuAddr ? _T_21 : _GEN_176; // @[PPUSimplified.scala 152:24 166:22]
  wire [15:0] _GEN_195 = 3'h5 == io_cpuAddr ? _GEN_125 : _GEN_175; // @[PPUSimplified.scala 152:24]
  wire  _GEN_198 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_179; // @[PPUSimplified.scala 152:24 56:19]
  wire  _GEN_203 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_184; // @[PPUSimplified.scala 152:24 53:17]
  wire  _GEN_208 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_189; // @[PPUSimplified.scala 152:24 55:20]
  wire [7:0] _GEN_216 = _T_12 ? _oamAddr_T_1 : oamAddr; // @[PPUSimplified.scala 152:24 158:17 46:24]
  wire  _GEN_219 = _T_12 ? _GEN_112 : _GEN_194; // @[PPUSimplified.scala 152:24]
  wire [15:0] _GEN_220 = _T_12 ? _GEN_125 : _GEN_195; // @[PPUSimplified.scala 152:24]
  wire  _GEN_223 = _T_12 ? 1'h0 : _GEN_198; // @[PPUSimplified.scala 152:24 56:19]
  wire  _GEN_228 = _T_12 ? 1'h0 : _GEN_203; // @[PPUSimplified.scala 152:24 53:17]
  wire  _GEN_233 = _T_12 ? 1'h0 : _GEN_208; // @[PPUSimplified.scala 152:24 55:20]
  wire [7:0] _GEN_236 = 3'h3 == io_cpuAddr ? io_cpuDataIn : _GEN_216; // @[PPUSimplified.scala 152:24 155:27]
  wire  _GEN_239 = 3'h3 == io_cpuAddr ? 1'h0 : _T_12; // @[PPUSimplified.scala 152:24 54:16]
  wire  _GEN_244 = 3'h3 == io_cpuAddr ? _GEN_112 : _GEN_219; // @[PPUSimplified.scala 152:24]
  wire [15:0] _GEN_245 = 3'h3 == io_cpuAddr ? _GEN_125 : _GEN_220; // @[PPUSimplified.scala 152:24]
  wire  _GEN_248 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_223; // @[PPUSimplified.scala 152:24 56:19]
  wire  _GEN_253 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_228; // @[PPUSimplified.scala 152:24 53:17]
  wire  _GEN_258 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_233; // @[PPUSimplified.scala 152:24 55:20]
  wire  _GEN_265 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_239; // @[PPUSimplified.scala 152:24 54:16]
  wire  _GEN_274 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_248; // @[PPUSimplified.scala 152:24 56:19]
  wire  _GEN_279 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_253; // @[PPUSimplified.scala 152:24 53:17]
  wire  _GEN_284 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_258; // @[PPUSimplified.scala 152:24 55:20]
  wire  _GEN_292 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_265; // @[PPUSimplified.scala 152:24 54:16]
  wire  _GEN_301 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_274; // @[PPUSimplified.scala 152:24 56:19]
  wire  _GEN_306 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_279; // @[PPUSimplified.scala 152:24 53:17]
  wire  _GEN_311 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_284; // @[PPUSimplified.scala 152:24 55:20]
  wire  _T_30 = scanlineX < 9'h100; // @[PPUSimplified.scala 201:18]
  wire  _T_31 = scanlineY < 9'hf0; // @[PPUSimplified.scala 201:39]
  wire  _T_32 = scanlineX < 9'h100 & scanlineY < 9'hf0; // @[PPUSimplified.scala 201:26]
  wire [5:0] tileX = scanlineX[8:3]; // @[PPUSimplified.scala 203:27]
  wire [5:0] tileY = scanlineY[8:3]; // @[PPUSimplified.scala 204:27]
  wire [2:0] pixelInTileX = scanlineX[2:0]; // @[PPUSimplified.scala 205:33]
  wire [2:0] pixelInTileY = scanlineY[2:0]; // @[PPUSimplified.scala 206:33]
  wire [10:0] _nametableAddr_T = {tileY, 5'h0}; // @[PPUSimplified.scala 208:32]
  wire [10:0] _GEN_595 = {{5'd0}, tileX}; // @[PPUSimplified.scala 208:38]
  wire [3:0] attrX = tileX[5:2]; // @[PPUSimplified.scala 211:23]
  wire [3:0] attrY = tileY[5:2]; // @[PPUSimplified.scala 212:23]
  wire [6:0] _attrAddr_T = {attrY, 3'h0}; // @[PPUSimplified.scala 213:37]
  wire [9:0] _GEN_596 = {{3'd0}, _attrAddr_T}; // @[PPUSimplified.scala 213:28]
  wire [9:0] _attrAddr_T_2 = 10'h3c0 + _GEN_596; // @[PPUSimplified.scala 213:28]
  wire [9:0] _GEN_597 = {{6'd0}, attrX}; // @[PPUSimplified.scala 213:43]
  wire [9:0] attrAddr = _attrAddr_T_2 + _GEN_597; // @[PPUSimplified.scala 213:43]
  wire [2:0] _attrShift_T_1 = {tileY[1], 2'h0}; // @[PPUSimplified.scala 215:32]
  wire [1:0] _attrShift_T_3 = {tileX[1], 1'h0}; // @[PPUSimplified.scala 215:50]
  wire [2:0] _GEN_598 = {{1'd0}, _attrShift_T_3}; // @[PPUSimplified.scala 215:38]
  wire [2:0] attrShift = _attrShift_T_1 | _GEN_598; // @[PPUSimplified.scala 215:38]
  wire [7:0] _paletteHigh_T = vram_attrByte_data >> attrShift; // @[PPUSimplified.scala 216:33]
  wire [7:0] paletteHigh = _paletteHigh_T & 8'h3; // @[PPUSimplified.scala 216:47]
  wire [12:0] patternTableBase = ppuCtrl[4] ? 13'h1000 : 13'h0; // @[PPUSimplified.scala 218:31]
  wire [11:0] _patternAddr_T = {vram_tileIndex_data, 4'h0}; // @[PPUSimplified.scala 219:53]
  wire [12:0] _GEN_599 = {{1'd0}, _patternAddr_T}; // @[PPUSimplified.scala 219:40]
  wire [12:0] _patternAddr_T_2 = patternTableBase + _GEN_599; // @[PPUSimplified.scala 219:40]
  wire [12:0] _GEN_600 = {{10'd0}, pixelInTileY}; // @[PPUSimplified.scala 219:59]
  wire [12:0] patternAddr = _patternAddr_T_2 + _GEN_600; // @[PPUSimplified.scala 219:59]
  wire [2:0] bitPos = 3'h7 - pixelInTileX; // @[PPUSimplified.scala 224:22]
  wire [7:0] _colorLow_T = chrROM_patternLow_data >> bitPos; // @[PPUSimplified.scala 225:32]
  wire [7:0] colorLow = _colorLow_T & 8'h1; // @[PPUSimplified.scala 225:43]
  wire [7:0] _colorHigh_T = chrROM_patternHigh_data >> bitPos; // @[PPUSimplified.scala 226:34]
  wire [7:0] colorHigh = _colorHigh_T & 8'h1; // @[PPUSimplified.scala 226:45]
  wire [8:0] _paletteLow_T = {colorHigh, 1'h0}; // @[PPUSimplified.scala 227:33]
  wire [8:0] _GEN_601 = {{1'd0}, colorLow}; // @[PPUSimplified.scala 227:39]
  wire [8:0] paletteLow = _paletteLow_T | _GEN_601; // @[PPUSimplified.scala 227:39]
  wire [9:0] _fullPaletteIndex_T = {paletteHigh, 2'h0}; // @[PPUSimplified.scala 229:41]
  wire [9:0] _GEN_602 = {{1'd0}, paletteLow}; // @[PPUSimplified.scala 229:47]
  wire [9:0] fullPaletteIndex = _fullPaletteIndex_T | _GEN_602; // @[PPUSimplified.scala 229:47]
  wire  _paletteAddr_T = paletteLow == 9'h0; // @[PPUSimplified.scala 230:38]
  wire [9:0] paletteAddr = paletteLow == 9'h0 ? 10'h0 : fullPaletteIndex; // @[PPUSimplified.scala 230:26]
  wire [8:0] _GEN_603 = {{1'd0}, oam_sprY_data}; // @[PPUSimplified.scala 251:36]
  wire [7:0] _sprInYRange_T_2 = oam_sprY_data + 8'h8; // @[PPUSimplified.scala 251:67]
  wire [8:0] _GEN_604 = {{1'd0}, _sprInYRange_T_2}; // @[PPUSimplified.scala 251:59]
  wire  sprInYRange = scanlineY >= _GEN_603 & scanlineY < _GEN_604; // @[PPUSimplified.scala 251:45]
  wire [8:0] _GEN_605 = {{1'd0}, oam_sprX_data}; // @[PPUSimplified.scala 252:36]
  wire [7:0] _sprInXRange_T_2 = oam_sprX_data + 8'h8; // @[PPUSimplified.scala 252:67]
  wire [8:0] _GEN_606 = {{1'd0}, _sprInXRange_T_2}; // @[PPUSimplified.scala 252:59]
  wire  sprInXRange = scanlineX >= _GEN_605 & scanlineX < _GEN_606; // @[PPUSimplified.scala 252:45]
  wire  _T_33 = sprInYRange & sprInXRange; // @[PPUSimplified.scala 254:24]
  wire [8:0] pixY = scanlineY - _GEN_603; // @[PPUSimplified.scala 255:30]
  wire [8:0] pixX = scanlineX - _GEN_605; // @[PPUSimplified.scala 256:30]
  wire  flipH = oam_sprAttr_data[6]; // @[PPUSimplified.scala 258:28]
  wire  flipV = oam_sprAttr_data[7]; // @[PPUSimplified.scala 259:28]
  wire [8:0] _actualPixelX_T_1 = 9'h7 - pixX; // @[PPUSimplified.scala 260:43]
  wire [8:0] actualPixelX = flipH ? _actualPixelX_T_1 : pixX; // @[PPUSimplified.scala 260:31]
  wire [8:0] _actualPixelY_T_1 = 9'h7 - pixY; // @[PPUSimplified.scala 261:43]
  wire [8:0] actualPixelY = flipV ? _actualPixelY_T_1 : pixY; // @[PPUSimplified.scala 261:31]
  wire [12:0] sprPatternTableBase = ppuCtrl[3] ? 13'h1000 : 13'h0; // @[PPUSimplified.scala 263:38]
  wire [11:0] _sprPatternAddr_T = {oam_sprTile_data, 4'h0}; // @[PPUSimplified.scala 264:61]
  wire [12:0] _GEN_609 = {{1'd0}, _sprPatternAddr_T}; // @[PPUSimplified.scala 264:50]
  wire [12:0] _sprPatternAddr_T_2 = sprPatternTableBase + _GEN_609; // @[PPUSimplified.scala 264:50]
  wire [12:0] _GEN_610 = {{4'd0}, actualPixelY}; // @[PPUSimplified.scala 264:67]
  wire [12:0] sprPatternAddr = _sprPatternAddr_T_2 + _GEN_610; // @[PPUSimplified.scala 264:67]
  wire [8:0] sprBitPos = 9'h7 - actualPixelX; // @[PPUSimplified.scala 269:29]
  wire [7:0] _sprColorLow_T = chrROM_sprPatternLow_data >> sprBitPos; // @[PPUSimplified.scala 270:42]
  wire [7:0] sprColorLow = _sprColorLow_T & 8'h1; // @[PPUSimplified.scala 270:56]
  wire [7:0] _sprColorHigh_T = chrROM_sprPatternHigh_data >> sprBitPos; // @[PPUSimplified.scala 271:44]
  wire [7:0] sprColorHigh = _sprColorHigh_T & 8'h1; // @[PPUSimplified.scala 271:58]
  wire [8:0] _sprPaletteLow_T = {sprColorHigh, 1'h0}; // @[PPUSimplified.scala 272:43]
  wire [8:0] _GEN_611 = {{1'd0}, sprColorLow}; // @[PPUSimplified.scala 272:49]
  wire [8:0] sprPaletteLow = _sprPaletteLow_T | _GEN_611; // @[PPUSimplified.scala 272:49]
  wire  _T_34 = sprPaletteLow != 9'h0; // @[PPUSimplified.scala 274:28]
  wire [1:0] spritePaletteIdx = oam_sprAttr_data[1:0]; // @[PPUSimplified.scala 275:41]
  wire [3:0] _sprFullPaletteIndex_T = {spritePaletteIdx, 2'h0}; // @[PPUSimplified.scala 276:64]
  wire [4:0] _GEN_612 = {{1'd0}, _sprFullPaletteIndex_T}; // @[PPUSimplified.scala 276:44]
  wire [4:0] _sprFullPaletteIndex_T_2 = 5'h10 + _GEN_612; // @[PPUSimplified.scala 276:44]
  wire [8:0] _GEN_613 = {{4'd0}, _sprFullPaletteIndex_T_2}; // @[PPUSimplified.scala 276:70]
  wire [8:0] sprFullPaletteIndex = _GEN_613 + sprPaletteLow; // @[PPUSimplified.scala 276:70]
  wire [5:0] _GEN_349 = sprPaletteLow != 9'h0 ? palette_sprPaletteColor_data[5:0] : 6'h0; // @[PPUSimplified.scala 274:37 279:27 238:31]
  wire  _GEN_350 = sprPaletteLow != 9'h0 & oam_sprAttr_data[5]; // @[PPUSimplified.scala 274:37 281:31 240:35]
  wire  spriteHits_0 = sprInYRange & sprInXRange & _T_34; // @[PPUSimplified.scala 254:40 55:20]
  wire [5:0] spriteColors_0 = sprInYRange & sprInXRange ? _GEN_349 : 6'h0; // @[PPUSimplified.scala 238:31 254:40]
  wire  spritePriorities_0 = sprInYRange & sprInXRange & _GEN_350; // @[PPUSimplified.scala 240:35 254:40]
  wire [8:0] _GEN_614 = {{1'd0}, oam_sprY_1_data}; // @[PPUSimplified.scala 251:36]
  wire [7:0] _sprInYRange_T_6 = oam_sprY_1_data + 8'h8; // @[PPUSimplified.scala 251:67]
  wire [8:0] _GEN_615 = {{1'd0}, _sprInYRange_T_6}; // @[PPUSimplified.scala 251:59]
  wire  sprInYRange_1 = scanlineY >= _GEN_614 & scanlineY < _GEN_615; // @[PPUSimplified.scala 251:45]
  wire [8:0] _GEN_616 = {{1'd0}, oam_sprX_1_data}; // @[PPUSimplified.scala 252:36]
  wire [7:0] _sprInXRange_T_6 = oam_sprX_1_data + 8'h8; // @[PPUSimplified.scala 252:67]
  wire [8:0] _GEN_617 = {{1'd0}, _sprInXRange_T_6}; // @[PPUSimplified.scala 252:59]
  wire  sprInXRange_1 = scanlineX >= _GEN_616 & scanlineX < _GEN_617; // @[PPUSimplified.scala 252:45]
  wire  _T_35 = sprInYRange_1 & sprInXRange_1; // @[PPUSimplified.scala 254:24]
  wire [8:0] pixY_1 = scanlineY - _GEN_614; // @[PPUSimplified.scala 255:30]
  wire [8:0] pixX_1 = scanlineX - _GEN_616; // @[PPUSimplified.scala 256:30]
  wire  flipH_1 = oam_sprAttr_1_data[6]; // @[PPUSimplified.scala 258:28]
  wire  flipV_1 = oam_sprAttr_1_data[7]; // @[PPUSimplified.scala 259:28]
  wire [8:0] _actualPixelX_T_3 = 9'h7 - pixX_1; // @[PPUSimplified.scala 260:43]
  wire [8:0] actualPixelX_1 = flipH_1 ? _actualPixelX_T_3 : pixX_1; // @[PPUSimplified.scala 260:31]
  wire [8:0] _actualPixelY_T_3 = 9'h7 - pixY_1; // @[PPUSimplified.scala 261:43]
  wire [8:0] actualPixelY_1 = flipV_1 ? _actualPixelY_T_3 : pixY_1; // @[PPUSimplified.scala 261:31]
  wire [11:0] _sprPatternAddr_T_4 = {oam_sprTile_1_data, 4'h0}; // @[PPUSimplified.scala 264:61]
  wire [12:0] _GEN_620 = {{1'd0}, _sprPatternAddr_T_4}; // @[PPUSimplified.scala 264:50]
  wire [12:0] _sprPatternAddr_T_6 = sprPatternTableBase + _GEN_620; // @[PPUSimplified.scala 264:50]
  wire [12:0] _GEN_621 = {{4'd0}, actualPixelY_1}; // @[PPUSimplified.scala 264:67]
  wire [12:0] sprPatternAddr_1 = _sprPatternAddr_T_6 + _GEN_621; // @[PPUSimplified.scala 264:67]
  wire [8:0] sprBitPos_1 = 9'h7 - actualPixelX_1; // @[PPUSimplified.scala 269:29]
  wire [7:0] _sprColorLow_T_1 = chrROM_sprPatternLow_1_data >> sprBitPos_1; // @[PPUSimplified.scala 270:42]
  wire [7:0] sprColorLow_1 = _sprColorLow_T_1 & 8'h1; // @[PPUSimplified.scala 270:56]
  wire [7:0] _sprColorHigh_T_1 = chrROM_sprPatternHigh_1_data >> sprBitPos_1; // @[PPUSimplified.scala 271:44]
  wire [7:0] sprColorHigh_1 = _sprColorHigh_T_1 & 8'h1; // @[PPUSimplified.scala 271:58]
  wire [8:0] _sprPaletteLow_T_1 = {sprColorHigh_1, 1'h0}; // @[PPUSimplified.scala 272:43]
  wire [8:0] _GEN_622 = {{1'd0}, sprColorLow_1}; // @[PPUSimplified.scala 272:49]
  wire [8:0] sprPaletteLow_1 = _sprPaletteLow_T_1 | _GEN_622; // @[PPUSimplified.scala 272:49]
  wire  _T_36 = sprPaletteLow_1 != 9'h0; // @[PPUSimplified.scala 274:28]
  wire [1:0] spritePaletteIdx_1 = oam_sprAttr_1_data[1:0]; // @[PPUSimplified.scala 275:41]
  wire [3:0] _sprFullPaletteIndex_T_4 = {spritePaletteIdx_1, 2'h0}; // @[PPUSimplified.scala 276:64]
  wire [4:0] _GEN_623 = {{1'd0}, _sprFullPaletteIndex_T_4}; // @[PPUSimplified.scala 276:44]
  wire [4:0] _sprFullPaletteIndex_T_6 = 5'h10 + _GEN_623; // @[PPUSimplified.scala 276:44]
  wire [8:0] _GEN_624 = {{4'd0}, _sprFullPaletteIndex_T_6}; // @[PPUSimplified.scala 276:70]
  wire [8:0] sprFullPaletteIndex_1 = _GEN_624 + sprPaletteLow_1; // @[PPUSimplified.scala 276:70]
  wire [5:0] _GEN_363 = sprPaletteLow_1 != 9'h0 ? palette_sprPaletteColor_1_data[5:0] : 6'h0; // @[PPUSimplified.scala 274:37 279:27 238:31]
  wire  _GEN_364 = sprPaletteLow_1 != 9'h0 & oam_sprAttr_1_data[5]; // @[PPUSimplified.scala 274:37 281:31 240:35]
  wire  spriteHits_1 = sprInYRange_1 & sprInXRange_1 & _T_36; // @[PPUSimplified.scala 254:40 55:20]
  wire [5:0] spriteColors_1 = sprInYRange_1 & sprInXRange_1 ? _GEN_363 : 6'h0; // @[PPUSimplified.scala 238:31 254:40]
  wire  spritePriorities_1 = sprInYRange_1 & sprInXRange_1 & _GEN_364; // @[PPUSimplified.scala 240:35 254:40]
  wire [8:0] _GEN_625 = {{1'd0}, oam_sprY_2_data}; // @[PPUSimplified.scala 251:36]
  wire [7:0] _sprInYRange_T_10 = oam_sprY_2_data + 8'h8; // @[PPUSimplified.scala 251:67]
  wire [8:0] _GEN_626 = {{1'd0}, _sprInYRange_T_10}; // @[PPUSimplified.scala 251:59]
  wire  sprInYRange_2 = scanlineY >= _GEN_625 & scanlineY < _GEN_626; // @[PPUSimplified.scala 251:45]
  wire [8:0] _GEN_627 = {{1'd0}, oam_sprX_2_data}; // @[PPUSimplified.scala 252:36]
  wire [7:0] _sprInXRange_T_10 = oam_sprX_2_data + 8'h8; // @[PPUSimplified.scala 252:67]
  wire [8:0] _GEN_628 = {{1'd0}, _sprInXRange_T_10}; // @[PPUSimplified.scala 252:59]
  wire  sprInXRange_2 = scanlineX >= _GEN_627 & scanlineX < _GEN_628; // @[PPUSimplified.scala 252:45]
  wire  _T_37 = sprInYRange_2 & sprInXRange_2; // @[PPUSimplified.scala 254:24]
  wire [8:0] pixY_2 = scanlineY - _GEN_625; // @[PPUSimplified.scala 255:30]
  wire [8:0] pixX_2 = scanlineX - _GEN_627; // @[PPUSimplified.scala 256:30]
  wire  flipH_2 = oam_sprAttr_2_data[6]; // @[PPUSimplified.scala 258:28]
  wire  flipV_2 = oam_sprAttr_2_data[7]; // @[PPUSimplified.scala 259:28]
  wire [8:0] _actualPixelX_T_5 = 9'h7 - pixX_2; // @[PPUSimplified.scala 260:43]
  wire [8:0] actualPixelX_2 = flipH_2 ? _actualPixelX_T_5 : pixX_2; // @[PPUSimplified.scala 260:31]
  wire [8:0] _actualPixelY_T_5 = 9'h7 - pixY_2; // @[PPUSimplified.scala 261:43]
  wire [8:0] actualPixelY_2 = flipV_2 ? _actualPixelY_T_5 : pixY_2; // @[PPUSimplified.scala 261:31]
  wire [11:0] _sprPatternAddr_T_8 = {oam_sprTile_2_data, 4'h0}; // @[PPUSimplified.scala 264:61]
  wire [12:0] _GEN_631 = {{1'd0}, _sprPatternAddr_T_8}; // @[PPUSimplified.scala 264:50]
  wire [12:0] _sprPatternAddr_T_10 = sprPatternTableBase + _GEN_631; // @[PPUSimplified.scala 264:50]
  wire [12:0] _GEN_632 = {{4'd0}, actualPixelY_2}; // @[PPUSimplified.scala 264:67]
  wire [12:0] sprPatternAddr_2 = _sprPatternAddr_T_10 + _GEN_632; // @[PPUSimplified.scala 264:67]
  wire [8:0] sprBitPos_2 = 9'h7 - actualPixelX_2; // @[PPUSimplified.scala 269:29]
  wire [7:0] _sprColorLow_T_2 = chrROM_sprPatternLow_2_data >> sprBitPos_2; // @[PPUSimplified.scala 270:42]
  wire [7:0] sprColorLow_2 = _sprColorLow_T_2 & 8'h1; // @[PPUSimplified.scala 270:56]
  wire [7:0] _sprColorHigh_T_2 = chrROM_sprPatternHigh_2_data >> sprBitPos_2; // @[PPUSimplified.scala 271:44]
  wire [7:0] sprColorHigh_2 = _sprColorHigh_T_2 & 8'h1; // @[PPUSimplified.scala 271:58]
  wire [8:0] _sprPaletteLow_T_2 = {sprColorHigh_2, 1'h0}; // @[PPUSimplified.scala 272:43]
  wire [8:0] _GEN_633 = {{1'd0}, sprColorLow_2}; // @[PPUSimplified.scala 272:49]
  wire [8:0] sprPaletteLow_2 = _sprPaletteLow_T_2 | _GEN_633; // @[PPUSimplified.scala 272:49]
  wire  _T_38 = sprPaletteLow_2 != 9'h0; // @[PPUSimplified.scala 274:28]
  wire [1:0] spritePaletteIdx_2 = oam_sprAttr_2_data[1:0]; // @[PPUSimplified.scala 275:41]
  wire [3:0] _sprFullPaletteIndex_T_8 = {spritePaletteIdx_2, 2'h0}; // @[PPUSimplified.scala 276:64]
  wire [4:0] _GEN_634 = {{1'd0}, _sprFullPaletteIndex_T_8}; // @[PPUSimplified.scala 276:44]
  wire [4:0] _sprFullPaletteIndex_T_10 = 5'h10 + _GEN_634; // @[PPUSimplified.scala 276:44]
  wire [8:0] _GEN_635 = {{4'd0}, _sprFullPaletteIndex_T_10}; // @[PPUSimplified.scala 276:70]
  wire [8:0] sprFullPaletteIndex_2 = _GEN_635 + sprPaletteLow_2; // @[PPUSimplified.scala 276:70]
  wire [5:0] _GEN_377 = sprPaletteLow_2 != 9'h0 ? palette_sprPaletteColor_2_data[5:0] : 6'h0; // @[PPUSimplified.scala 274:37 279:27 238:31]
  wire  _GEN_378 = sprPaletteLow_2 != 9'h0 & oam_sprAttr_2_data[5]; // @[PPUSimplified.scala 274:37 281:31 240:35]
  wire  spriteHits_2 = sprInYRange_2 & sprInXRange_2 & _T_38; // @[PPUSimplified.scala 254:40 55:20]
  wire [5:0] spriteColors_2 = sprInYRange_2 & sprInXRange_2 ? _GEN_377 : 6'h0; // @[PPUSimplified.scala 238:31 254:40]
  wire  spritePriorities_2 = sprInYRange_2 & sprInXRange_2 & _GEN_378; // @[PPUSimplified.scala 240:35 254:40]
  wire [8:0] _GEN_636 = {{1'd0}, oam_sprY_3_data}; // @[PPUSimplified.scala 251:36]
  wire [7:0] _sprInYRange_T_14 = oam_sprY_3_data + 8'h8; // @[PPUSimplified.scala 251:67]
  wire [8:0] _GEN_637 = {{1'd0}, _sprInYRange_T_14}; // @[PPUSimplified.scala 251:59]
  wire  sprInYRange_3 = scanlineY >= _GEN_636 & scanlineY < _GEN_637; // @[PPUSimplified.scala 251:45]
  wire [8:0] _GEN_638 = {{1'd0}, oam_sprX_3_data}; // @[PPUSimplified.scala 252:36]
  wire [7:0] _sprInXRange_T_14 = oam_sprX_3_data + 8'h8; // @[PPUSimplified.scala 252:67]
  wire [8:0] _GEN_639 = {{1'd0}, _sprInXRange_T_14}; // @[PPUSimplified.scala 252:59]
  wire  sprInXRange_3 = scanlineX >= _GEN_638 & scanlineX < _GEN_639; // @[PPUSimplified.scala 252:45]
  wire  _T_39 = sprInYRange_3 & sprInXRange_3; // @[PPUSimplified.scala 254:24]
  wire [8:0] pixY_3 = scanlineY - _GEN_636; // @[PPUSimplified.scala 255:30]
  wire [8:0] pixX_3 = scanlineX - _GEN_638; // @[PPUSimplified.scala 256:30]
  wire  flipH_3 = oam_sprAttr_3_data[6]; // @[PPUSimplified.scala 258:28]
  wire  flipV_3 = oam_sprAttr_3_data[7]; // @[PPUSimplified.scala 259:28]
  wire [8:0] _actualPixelX_T_7 = 9'h7 - pixX_3; // @[PPUSimplified.scala 260:43]
  wire [8:0] actualPixelX_3 = flipH_3 ? _actualPixelX_T_7 : pixX_3; // @[PPUSimplified.scala 260:31]
  wire [8:0] _actualPixelY_T_7 = 9'h7 - pixY_3; // @[PPUSimplified.scala 261:43]
  wire [8:0] actualPixelY_3 = flipV_3 ? _actualPixelY_T_7 : pixY_3; // @[PPUSimplified.scala 261:31]
  wire [11:0] _sprPatternAddr_T_12 = {oam_sprTile_3_data, 4'h0}; // @[PPUSimplified.scala 264:61]
  wire [12:0] _GEN_642 = {{1'd0}, _sprPatternAddr_T_12}; // @[PPUSimplified.scala 264:50]
  wire [12:0] _sprPatternAddr_T_14 = sprPatternTableBase + _GEN_642; // @[PPUSimplified.scala 264:50]
  wire [12:0] _GEN_643 = {{4'd0}, actualPixelY_3}; // @[PPUSimplified.scala 264:67]
  wire [12:0] sprPatternAddr_3 = _sprPatternAddr_T_14 + _GEN_643; // @[PPUSimplified.scala 264:67]
  wire [8:0] sprBitPos_3 = 9'h7 - actualPixelX_3; // @[PPUSimplified.scala 269:29]
  wire [7:0] _sprColorLow_T_3 = chrROM_sprPatternLow_3_data >> sprBitPos_3; // @[PPUSimplified.scala 270:42]
  wire [7:0] sprColorLow_3 = _sprColorLow_T_3 & 8'h1; // @[PPUSimplified.scala 270:56]
  wire [7:0] _sprColorHigh_T_3 = chrROM_sprPatternHigh_3_data >> sprBitPos_3; // @[PPUSimplified.scala 271:44]
  wire [7:0] sprColorHigh_3 = _sprColorHigh_T_3 & 8'h1; // @[PPUSimplified.scala 271:58]
  wire [8:0] _sprPaletteLow_T_3 = {sprColorHigh_3, 1'h0}; // @[PPUSimplified.scala 272:43]
  wire [8:0] _GEN_644 = {{1'd0}, sprColorLow_3}; // @[PPUSimplified.scala 272:49]
  wire [8:0] sprPaletteLow_3 = _sprPaletteLow_T_3 | _GEN_644; // @[PPUSimplified.scala 272:49]
  wire  _T_40 = sprPaletteLow_3 != 9'h0; // @[PPUSimplified.scala 274:28]
  wire [1:0] spritePaletteIdx_3 = oam_sprAttr_3_data[1:0]; // @[PPUSimplified.scala 275:41]
  wire [3:0] _sprFullPaletteIndex_T_12 = {spritePaletteIdx_3, 2'h0}; // @[PPUSimplified.scala 276:64]
  wire [4:0] _GEN_645 = {{1'd0}, _sprFullPaletteIndex_T_12}; // @[PPUSimplified.scala 276:44]
  wire [4:0] _sprFullPaletteIndex_T_14 = 5'h10 + _GEN_645; // @[PPUSimplified.scala 276:44]
  wire [8:0] _GEN_646 = {{4'd0}, _sprFullPaletteIndex_T_14}; // @[PPUSimplified.scala 276:70]
  wire [8:0] sprFullPaletteIndex_3 = _GEN_646 + sprPaletteLow_3; // @[PPUSimplified.scala 276:70]
  wire [5:0] _GEN_391 = sprPaletteLow_3 != 9'h0 ? palette_sprPaletteColor_3_data[5:0] : 6'h0; // @[PPUSimplified.scala 274:37 279:27 238:31]
  wire  _GEN_392 = sprPaletteLow_3 != 9'h0 & oam_sprAttr_3_data[5]; // @[PPUSimplified.scala 274:37 281:31 240:35]
  wire  spriteHits_3 = sprInYRange_3 & sprInXRange_3 & _T_40; // @[PPUSimplified.scala 254:40 55:20]
  wire [5:0] spriteColors_3 = sprInYRange_3 & sprInXRange_3 ? _GEN_391 : 6'h0; // @[PPUSimplified.scala 238:31 254:40]
  wire  spritePriorities_3 = sprInYRange_3 & sprInXRange_3 & _GEN_392; // @[PPUSimplified.scala 240:35 254:40]
  wire [8:0] _GEN_647 = {{1'd0}, oam_sprY_4_data}; // @[PPUSimplified.scala 251:36]
  wire [7:0] _sprInYRange_T_18 = oam_sprY_4_data + 8'h8; // @[PPUSimplified.scala 251:67]
  wire [8:0] _GEN_648 = {{1'd0}, _sprInYRange_T_18}; // @[PPUSimplified.scala 251:59]
  wire  sprInYRange_4 = scanlineY >= _GEN_647 & scanlineY < _GEN_648; // @[PPUSimplified.scala 251:45]
  wire [8:0] _GEN_649 = {{1'd0}, oam_sprX_4_data}; // @[PPUSimplified.scala 252:36]
  wire [7:0] _sprInXRange_T_18 = oam_sprX_4_data + 8'h8; // @[PPUSimplified.scala 252:67]
  wire [8:0] _GEN_650 = {{1'd0}, _sprInXRange_T_18}; // @[PPUSimplified.scala 252:59]
  wire  sprInXRange_4 = scanlineX >= _GEN_649 & scanlineX < _GEN_650; // @[PPUSimplified.scala 252:45]
  wire  _T_41 = sprInYRange_4 & sprInXRange_4; // @[PPUSimplified.scala 254:24]
  wire [8:0] pixY_4 = scanlineY - _GEN_647; // @[PPUSimplified.scala 255:30]
  wire [8:0] pixX_4 = scanlineX - _GEN_649; // @[PPUSimplified.scala 256:30]
  wire  flipH_4 = oam_sprAttr_4_data[6]; // @[PPUSimplified.scala 258:28]
  wire  flipV_4 = oam_sprAttr_4_data[7]; // @[PPUSimplified.scala 259:28]
  wire [8:0] _actualPixelX_T_9 = 9'h7 - pixX_4; // @[PPUSimplified.scala 260:43]
  wire [8:0] actualPixelX_4 = flipH_4 ? _actualPixelX_T_9 : pixX_4; // @[PPUSimplified.scala 260:31]
  wire [8:0] _actualPixelY_T_9 = 9'h7 - pixY_4; // @[PPUSimplified.scala 261:43]
  wire [8:0] actualPixelY_4 = flipV_4 ? _actualPixelY_T_9 : pixY_4; // @[PPUSimplified.scala 261:31]
  wire [11:0] _sprPatternAddr_T_16 = {oam_sprTile_4_data, 4'h0}; // @[PPUSimplified.scala 264:61]
  wire [12:0] _GEN_653 = {{1'd0}, _sprPatternAddr_T_16}; // @[PPUSimplified.scala 264:50]
  wire [12:0] _sprPatternAddr_T_18 = sprPatternTableBase + _GEN_653; // @[PPUSimplified.scala 264:50]
  wire [12:0] _GEN_654 = {{4'd0}, actualPixelY_4}; // @[PPUSimplified.scala 264:67]
  wire [12:0] sprPatternAddr_4 = _sprPatternAddr_T_18 + _GEN_654; // @[PPUSimplified.scala 264:67]
  wire [8:0] sprBitPos_4 = 9'h7 - actualPixelX_4; // @[PPUSimplified.scala 269:29]
  wire [7:0] _sprColorLow_T_4 = chrROM_sprPatternLow_4_data >> sprBitPos_4; // @[PPUSimplified.scala 270:42]
  wire [7:0] sprColorLow_4 = _sprColorLow_T_4 & 8'h1; // @[PPUSimplified.scala 270:56]
  wire [7:0] _sprColorHigh_T_4 = chrROM_sprPatternHigh_4_data >> sprBitPos_4; // @[PPUSimplified.scala 271:44]
  wire [7:0] sprColorHigh_4 = _sprColorHigh_T_4 & 8'h1; // @[PPUSimplified.scala 271:58]
  wire [8:0] _sprPaletteLow_T_4 = {sprColorHigh_4, 1'h0}; // @[PPUSimplified.scala 272:43]
  wire [8:0] _GEN_655 = {{1'd0}, sprColorLow_4}; // @[PPUSimplified.scala 272:49]
  wire [8:0] sprPaletteLow_4 = _sprPaletteLow_T_4 | _GEN_655; // @[PPUSimplified.scala 272:49]
  wire  _T_42 = sprPaletteLow_4 != 9'h0; // @[PPUSimplified.scala 274:28]
  wire [1:0] spritePaletteIdx_4 = oam_sprAttr_4_data[1:0]; // @[PPUSimplified.scala 275:41]
  wire [3:0] _sprFullPaletteIndex_T_16 = {spritePaletteIdx_4, 2'h0}; // @[PPUSimplified.scala 276:64]
  wire [4:0] _GEN_656 = {{1'd0}, _sprFullPaletteIndex_T_16}; // @[PPUSimplified.scala 276:44]
  wire [4:0] _sprFullPaletteIndex_T_18 = 5'h10 + _GEN_656; // @[PPUSimplified.scala 276:44]
  wire [8:0] _GEN_657 = {{4'd0}, _sprFullPaletteIndex_T_18}; // @[PPUSimplified.scala 276:70]
  wire [8:0] sprFullPaletteIndex_4 = _GEN_657 + sprPaletteLow_4; // @[PPUSimplified.scala 276:70]
  wire [5:0] _GEN_405 = sprPaletteLow_4 != 9'h0 ? palette_sprPaletteColor_4_data[5:0] : 6'h0; // @[PPUSimplified.scala 274:37 279:27 238:31]
  wire  _GEN_406 = sprPaletteLow_4 != 9'h0 & oam_sprAttr_4_data[5]; // @[PPUSimplified.scala 274:37 281:31 240:35]
  wire  spriteHits_4 = sprInYRange_4 & sprInXRange_4 & _T_42; // @[PPUSimplified.scala 254:40 55:20]
  wire [5:0] spriteColors_4 = sprInYRange_4 & sprInXRange_4 ? _GEN_405 : 6'h0; // @[PPUSimplified.scala 238:31 254:40]
  wire  spritePriorities_4 = sprInYRange_4 & sprInXRange_4 & _GEN_406; // @[PPUSimplified.scala 240:35 254:40]
  wire [8:0] _GEN_658 = {{1'd0}, oam_sprY_5_data}; // @[PPUSimplified.scala 251:36]
  wire [7:0] _sprInYRange_T_22 = oam_sprY_5_data + 8'h8; // @[PPUSimplified.scala 251:67]
  wire [8:0] _GEN_659 = {{1'd0}, _sprInYRange_T_22}; // @[PPUSimplified.scala 251:59]
  wire  sprInYRange_5 = scanlineY >= _GEN_658 & scanlineY < _GEN_659; // @[PPUSimplified.scala 251:45]
  wire [8:0] _GEN_660 = {{1'd0}, oam_sprX_5_data}; // @[PPUSimplified.scala 252:36]
  wire [7:0] _sprInXRange_T_22 = oam_sprX_5_data + 8'h8; // @[PPUSimplified.scala 252:67]
  wire [8:0] _GEN_661 = {{1'd0}, _sprInXRange_T_22}; // @[PPUSimplified.scala 252:59]
  wire  sprInXRange_5 = scanlineX >= _GEN_660 & scanlineX < _GEN_661; // @[PPUSimplified.scala 252:45]
  wire  _T_43 = sprInYRange_5 & sprInXRange_5; // @[PPUSimplified.scala 254:24]
  wire [8:0] pixY_5 = scanlineY - _GEN_658; // @[PPUSimplified.scala 255:30]
  wire [8:0] pixX_5 = scanlineX - _GEN_660; // @[PPUSimplified.scala 256:30]
  wire  flipH_5 = oam_sprAttr_5_data[6]; // @[PPUSimplified.scala 258:28]
  wire  flipV_5 = oam_sprAttr_5_data[7]; // @[PPUSimplified.scala 259:28]
  wire [8:0] _actualPixelX_T_11 = 9'h7 - pixX_5; // @[PPUSimplified.scala 260:43]
  wire [8:0] actualPixelX_5 = flipH_5 ? _actualPixelX_T_11 : pixX_5; // @[PPUSimplified.scala 260:31]
  wire [8:0] _actualPixelY_T_11 = 9'h7 - pixY_5; // @[PPUSimplified.scala 261:43]
  wire [8:0] actualPixelY_5 = flipV_5 ? _actualPixelY_T_11 : pixY_5; // @[PPUSimplified.scala 261:31]
  wire [11:0] _sprPatternAddr_T_20 = {oam_sprTile_5_data, 4'h0}; // @[PPUSimplified.scala 264:61]
  wire [12:0] _GEN_664 = {{1'd0}, _sprPatternAddr_T_20}; // @[PPUSimplified.scala 264:50]
  wire [12:0] _sprPatternAddr_T_22 = sprPatternTableBase + _GEN_664; // @[PPUSimplified.scala 264:50]
  wire [12:0] _GEN_665 = {{4'd0}, actualPixelY_5}; // @[PPUSimplified.scala 264:67]
  wire [12:0] sprPatternAddr_5 = _sprPatternAddr_T_22 + _GEN_665; // @[PPUSimplified.scala 264:67]
  wire [8:0] sprBitPos_5 = 9'h7 - actualPixelX_5; // @[PPUSimplified.scala 269:29]
  wire [7:0] _sprColorLow_T_5 = chrROM_sprPatternLow_5_data >> sprBitPos_5; // @[PPUSimplified.scala 270:42]
  wire [7:0] sprColorLow_5 = _sprColorLow_T_5 & 8'h1; // @[PPUSimplified.scala 270:56]
  wire [7:0] _sprColorHigh_T_5 = chrROM_sprPatternHigh_5_data >> sprBitPos_5; // @[PPUSimplified.scala 271:44]
  wire [7:0] sprColorHigh_5 = _sprColorHigh_T_5 & 8'h1; // @[PPUSimplified.scala 271:58]
  wire [8:0] _sprPaletteLow_T_5 = {sprColorHigh_5, 1'h0}; // @[PPUSimplified.scala 272:43]
  wire [8:0] _GEN_666 = {{1'd0}, sprColorLow_5}; // @[PPUSimplified.scala 272:49]
  wire [8:0] sprPaletteLow_5 = _sprPaletteLow_T_5 | _GEN_666; // @[PPUSimplified.scala 272:49]
  wire  _T_44 = sprPaletteLow_5 != 9'h0; // @[PPUSimplified.scala 274:28]
  wire [1:0] spritePaletteIdx_5 = oam_sprAttr_5_data[1:0]; // @[PPUSimplified.scala 275:41]
  wire [3:0] _sprFullPaletteIndex_T_20 = {spritePaletteIdx_5, 2'h0}; // @[PPUSimplified.scala 276:64]
  wire [4:0] _GEN_667 = {{1'd0}, _sprFullPaletteIndex_T_20}; // @[PPUSimplified.scala 276:44]
  wire [4:0] _sprFullPaletteIndex_T_22 = 5'h10 + _GEN_667; // @[PPUSimplified.scala 276:44]
  wire [8:0] _GEN_668 = {{4'd0}, _sprFullPaletteIndex_T_22}; // @[PPUSimplified.scala 276:70]
  wire [8:0] sprFullPaletteIndex_5 = _GEN_668 + sprPaletteLow_5; // @[PPUSimplified.scala 276:70]
  wire [5:0] _GEN_419 = sprPaletteLow_5 != 9'h0 ? palette_sprPaletteColor_5_data[5:0] : 6'h0; // @[PPUSimplified.scala 274:37 279:27 238:31]
  wire  _GEN_420 = sprPaletteLow_5 != 9'h0 & oam_sprAttr_5_data[5]; // @[PPUSimplified.scala 274:37 281:31 240:35]
  wire  spriteHits_5 = sprInYRange_5 & sprInXRange_5 & _T_44; // @[PPUSimplified.scala 254:40 55:20]
  wire [5:0] spriteColors_5 = sprInYRange_5 & sprInXRange_5 ? _GEN_419 : 6'h0; // @[PPUSimplified.scala 238:31 254:40]
  wire  spritePriorities_5 = sprInYRange_5 & sprInXRange_5 & _GEN_420; // @[PPUSimplified.scala 240:35 254:40]
  wire [8:0] _GEN_669 = {{1'd0}, oam_sprY_6_data}; // @[PPUSimplified.scala 251:36]
  wire [7:0] _sprInYRange_T_26 = oam_sprY_6_data + 8'h8; // @[PPUSimplified.scala 251:67]
  wire [8:0] _GEN_670 = {{1'd0}, _sprInYRange_T_26}; // @[PPUSimplified.scala 251:59]
  wire  sprInYRange_6 = scanlineY >= _GEN_669 & scanlineY < _GEN_670; // @[PPUSimplified.scala 251:45]
  wire [8:0] _GEN_671 = {{1'd0}, oam_sprX_6_data}; // @[PPUSimplified.scala 252:36]
  wire [7:0] _sprInXRange_T_26 = oam_sprX_6_data + 8'h8; // @[PPUSimplified.scala 252:67]
  wire [8:0] _GEN_672 = {{1'd0}, _sprInXRange_T_26}; // @[PPUSimplified.scala 252:59]
  wire  sprInXRange_6 = scanlineX >= _GEN_671 & scanlineX < _GEN_672; // @[PPUSimplified.scala 252:45]
  wire  _T_45 = sprInYRange_6 & sprInXRange_6; // @[PPUSimplified.scala 254:24]
  wire [8:0] pixY_6 = scanlineY - _GEN_669; // @[PPUSimplified.scala 255:30]
  wire [8:0] pixX_6 = scanlineX - _GEN_671; // @[PPUSimplified.scala 256:30]
  wire  flipH_6 = oam_sprAttr_6_data[6]; // @[PPUSimplified.scala 258:28]
  wire  flipV_6 = oam_sprAttr_6_data[7]; // @[PPUSimplified.scala 259:28]
  wire [8:0] _actualPixelX_T_13 = 9'h7 - pixX_6; // @[PPUSimplified.scala 260:43]
  wire [8:0] actualPixelX_6 = flipH_6 ? _actualPixelX_T_13 : pixX_6; // @[PPUSimplified.scala 260:31]
  wire [8:0] _actualPixelY_T_13 = 9'h7 - pixY_6; // @[PPUSimplified.scala 261:43]
  wire [8:0] actualPixelY_6 = flipV_6 ? _actualPixelY_T_13 : pixY_6; // @[PPUSimplified.scala 261:31]
  wire [11:0] _sprPatternAddr_T_24 = {oam_sprTile_6_data, 4'h0}; // @[PPUSimplified.scala 264:61]
  wire [12:0] _GEN_675 = {{1'd0}, _sprPatternAddr_T_24}; // @[PPUSimplified.scala 264:50]
  wire [12:0] _sprPatternAddr_T_26 = sprPatternTableBase + _GEN_675; // @[PPUSimplified.scala 264:50]
  wire [12:0] _GEN_676 = {{4'd0}, actualPixelY_6}; // @[PPUSimplified.scala 264:67]
  wire [12:0] sprPatternAddr_6 = _sprPatternAddr_T_26 + _GEN_676; // @[PPUSimplified.scala 264:67]
  wire [8:0] sprBitPos_6 = 9'h7 - actualPixelX_6; // @[PPUSimplified.scala 269:29]
  wire [7:0] _sprColorLow_T_6 = chrROM_sprPatternLow_6_data >> sprBitPos_6; // @[PPUSimplified.scala 270:42]
  wire [7:0] sprColorLow_6 = _sprColorLow_T_6 & 8'h1; // @[PPUSimplified.scala 270:56]
  wire [7:0] _sprColorHigh_T_6 = chrROM_sprPatternHigh_6_data >> sprBitPos_6; // @[PPUSimplified.scala 271:44]
  wire [7:0] sprColorHigh_6 = _sprColorHigh_T_6 & 8'h1; // @[PPUSimplified.scala 271:58]
  wire [8:0] _sprPaletteLow_T_6 = {sprColorHigh_6, 1'h0}; // @[PPUSimplified.scala 272:43]
  wire [8:0] _GEN_677 = {{1'd0}, sprColorLow_6}; // @[PPUSimplified.scala 272:49]
  wire [8:0] sprPaletteLow_6 = _sprPaletteLow_T_6 | _GEN_677; // @[PPUSimplified.scala 272:49]
  wire  _T_46 = sprPaletteLow_6 != 9'h0; // @[PPUSimplified.scala 274:28]
  wire [1:0] spritePaletteIdx_6 = oam_sprAttr_6_data[1:0]; // @[PPUSimplified.scala 275:41]
  wire [3:0] _sprFullPaletteIndex_T_24 = {spritePaletteIdx_6, 2'h0}; // @[PPUSimplified.scala 276:64]
  wire [4:0] _GEN_678 = {{1'd0}, _sprFullPaletteIndex_T_24}; // @[PPUSimplified.scala 276:44]
  wire [4:0] _sprFullPaletteIndex_T_26 = 5'h10 + _GEN_678; // @[PPUSimplified.scala 276:44]
  wire [8:0] _GEN_679 = {{4'd0}, _sprFullPaletteIndex_T_26}; // @[PPUSimplified.scala 276:70]
  wire [8:0] sprFullPaletteIndex_6 = _GEN_679 + sprPaletteLow_6; // @[PPUSimplified.scala 276:70]
  wire [5:0] _GEN_433 = sprPaletteLow_6 != 9'h0 ? palette_sprPaletteColor_6_data[5:0] : 6'h0; // @[PPUSimplified.scala 274:37 279:27 238:31]
  wire  _GEN_434 = sprPaletteLow_6 != 9'h0 & oam_sprAttr_6_data[5]; // @[PPUSimplified.scala 274:37 281:31 240:35]
  wire  spriteHits_6 = sprInYRange_6 & sprInXRange_6 & _T_46; // @[PPUSimplified.scala 254:40 55:20]
  wire [5:0] spriteColors_6 = sprInYRange_6 & sprInXRange_6 ? _GEN_433 : 6'h0; // @[PPUSimplified.scala 238:31 254:40]
  wire  spritePriorities_6 = sprInYRange_6 & sprInXRange_6 & _GEN_434; // @[PPUSimplified.scala 240:35 254:40]
  wire [8:0] _GEN_680 = {{1'd0}, oam_sprY_7_data}; // @[PPUSimplified.scala 251:36]
  wire [7:0] _sprInYRange_T_30 = oam_sprY_7_data + 8'h8; // @[PPUSimplified.scala 251:67]
  wire [8:0] _GEN_681 = {{1'd0}, _sprInYRange_T_30}; // @[PPUSimplified.scala 251:59]
  wire  sprInYRange_7 = scanlineY >= _GEN_680 & scanlineY < _GEN_681; // @[PPUSimplified.scala 251:45]
  wire [8:0] _GEN_682 = {{1'd0}, oam_sprX_7_data}; // @[PPUSimplified.scala 252:36]
  wire [7:0] _sprInXRange_T_30 = oam_sprX_7_data + 8'h8; // @[PPUSimplified.scala 252:67]
  wire [8:0] _GEN_683 = {{1'd0}, _sprInXRange_T_30}; // @[PPUSimplified.scala 252:59]
  wire  sprInXRange_7 = scanlineX >= _GEN_682 & scanlineX < _GEN_683; // @[PPUSimplified.scala 252:45]
  wire  _T_47 = sprInYRange_7 & sprInXRange_7; // @[PPUSimplified.scala 254:24]
  wire [8:0] pixY_7 = scanlineY - _GEN_680; // @[PPUSimplified.scala 255:30]
  wire [8:0] pixX_7 = scanlineX - _GEN_682; // @[PPUSimplified.scala 256:30]
  wire  flipH_7 = oam_sprAttr_7_data[6]; // @[PPUSimplified.scala 258:28]
  wire  flipV_7 = oam_sprAttr_7_data[7]; // @[PPUSimplified.scala 259:28]
  wire [8:0] _actualPixelX_T_15 = 9'h7 - pixX_7; // @[PPUSimplified.scala 260:43]
  wire [8:0] actualPixelX_7 = flipH_7 ? _actualPixelX_T_15 : pixX_7; // @[PPUSimplified.scala 260:31]
  wire [8:0] _actualPixelY_T_15 = 9'h7 - pixY_7; // @[PPUSimplified.scala 261:43]
  wire [8:0] actualPixelY_7 = flipV_7 ? _actualPixelY_T_15 : pixY_7; // @[PPUSimplified.scala 261:31]
  wire [11:0] _sprPatternAddr_T_28 = {oam_sprTile_7_data, 4'h0}; // @[PPUSimplified.scala 264:61]
  wire [12:0] _GEN_686 = {{1'd0}, _sprPatternAddr_T_28}; // @[PPUSimplified.scala 264:50]
  wire [12:0] _sprPatternAddr_T_30 = sprPatternTableBase + _GEN_686; // @[PPUSimplified.scala 264:50]
  wire [12:0] _GEN_687 = {{4'd0}, actualPixelY_7}; // @[PPUSimplified.scala 264:67]
  wire [12:0] sprPatternAddr_7 = _sprPatternAddr_T_30 + _GEN_687; // @[PPUSimplified.scala 264:67]
  wire [8:0] sprBitPos_7 = 9'h7 - actualPixelX_7; // @[PPUSimplified.scala 269:29]
  wire [7:0] _sprColorLow_T_7 = chrROM_sprPatternLow_7_data >> sprBitPos_7; // @[PPUSimplified.scala 270:42]
  wire [7:0] sprColorLow_7 = _sprColorLow_T_7 & 8'h1; // @[PPUSimplified.scala 270:56]
  wire [7:0] _sprColorHigh_T_7 = chrROM_sprPatternHigh_7_data >> sprBitPos_7; // @[PPUSimplified.scala 271:44]
  wire [7:0] sprColorHigh_7 = _sprColorHigh_T_7 & 8'h1; // @[PPUSimplified.scala 271:58]
  wire [8:0] _sprPaletteLow_T_7 = {sprColorHigh_7, 1'h0}; // @[PPUSimplified.scala 272:43]
  wire [8:0] _GEN_688 = {{1'd0}, sprColorLow_7}; // @[PPUSimplified.scala 272:49]
  wire [8:0] sprPaletteLow_7 = _sprPaletteLow_T_7 | _GEN_688; // @[PPUSimplified.scala 272:49]
  wire  _T_48 = sprPaletteLow_7 != 9'h0; // @[PPUSimplified.scala 274:28]
  wire [1:0] spritePaletteIdx_7 = oam_sprAttr_7_data[1:0]; // @[PPUSimplified.scala 275:41]
  wire [3:0] _sprFullPaletteIndex_T_28 = {spritePaletteIdx_7, 2'h0}; // @[PPUSimplified.scala 276:64]
  wire [4:0] _GEN_689 = {{1'd0}, _sprFullPaletteIndex_T_28}; // @[PPUSimplified.scala 276:44]
  wire [4:0] _sprFullPaletteIndex_T_30 = 5'h10 + _GEN_689; // @[PPUSimplified.scala 276:44]
  wire [8:0] _GEN_690 = {{4'd0}, _sprFullPaletteIndex_T_30}; // @[PPUSimplified.scala 276:70]
  wire [8:0] sprFullPaletteIndex_7 = _GEN_690 + sprPaletteLow_7; // @[PPUSimplified.scala 276:70]
  wire [5:0] _GEN_447 = sprPaletteLow_7 != 9'h0 ? palette_sprPaletteColor_7_data[5:0] : 6'h0; // @[PPUSimplified.scala 274:37 279:27 238:31]
  wire  _GEN_448 = sprPaletteLow_7 != 9'h0 & oam_sprAttr_7_data[5]; // @[PPUSimplified.scala 274:37 281:31 240:35]
  wire  spriteHits_7 = sprInYRange_7 & sprInXRange_7 & _T_48; // @[PPUSimplified.scala 254:40 55:20]
  wire [5:0] spriteColors_7 = sprInYRange_7 & sprInXRange_7 ? _GEN_447 : 6'h0; // @[PPUSimplified.scala 238:31 254:40]
  wire  spritePriorities_7 = sprInYRange_7 & sprInXRange_7 & _GEN_448; // @[PPUSimplified.scala 240:35 254:40]
  wire [5:0] _GEN_458 = spriteHits_7 ? spriteColors_7 : 6'h0; // @[PPUSimplified.scala 319:31 320:19 287:34]
  wire  _GEN_460 = spriteHits_7 & spritePriorities_7; // @[PPUSimplified.scala 319:31 322:22 289:37]
  wire [5:0] _GEN_461 = spriteHits_6 ? spriteColors_6 : _GEN_458; // @[PPUSimplified.scala 315:31 316:19]
  wire  _GEN_462 = spriteHits_6 | spriteHits_7; // @[PPUSimplified.scala 315:31 317:19]
  wire  _GEN_463 = spriteHits_6 ? spritePriorities_6 : _GEN_460; // @[PPUSimplified.scala 315:31 318:22]
  wire [5:0] _GEN_464 = spriteHits_5 ? spriteColors_5 : _GEN_461; // @[PPUSimplified.scala 311:31 312:19]
  wire  _GEN_465 = spriteHits_5 | _GEN_462; // @[PPUSimplified.scala 311:31 313:19]
  wire  _GEN_466 = spriteHits_5 ? spritePriorities_5 : _GEN_463; // @[PPUSimplified.scala 311:31 314:22]
  wire [5:0] _GEN_467 = spriteHits_4 ? spriteColors_4 : _GEN_464; // @[PPUSimplified.scala 307:31 308:19]
  wire  _GEN_468 = spriteHits_4 | _GEN_465; // @[PPUSimplified.scala 307:31 309:19]
  wire  _GEN_469 = spriteHits_4 ? spritePriorities_4 : _GEN_466; // @[PPUSimplified.scala 307:31 310:22]
  wire [5:0] _GEN_470 = spriteHits_3 ? spriteColors_3 : _GEN_467; // @[PPUSimplified.scala 303:31 304:19]
  wire  _GEN_471 = spriteHits_3 | _GEN_468; // @[PPUSimplified.scala 303:31 305:19]
  wire  _GEN_472 = spriteHits_3 ? spritePriorities_3 : _GEN_469; // @[PPUSimplified.scala 303:31 306:22]
  wire [5:0] _GEN_473 = spriteHits_2 ? spriteColors_2 : _GEN_470; // @[PPUSimplified.scala 299:31 300:19]
  wire  _GEN_474 = spriteHits_2 | _GEN_471; // @[PPUSimplified.scala 299:31 301:19]
  wire  _GEN_475 = spriteHits_2 ? spritePriorities_2 : _GEN_472; // @[PPUSimplified.scala 299:31 302:22]
  wire [5:0] _GEN_476 = spriteHits_1 ? spriteColors_1 : _GEN_473; // @[PPUSimplified.scala 295:31 296:19]
  wire  _GEN_477 = spriteHits_1 | _GEN_474; // @[PPUSimplified.scala 295:31 297:19]
  wire  _GEN_478 = spriteHits_1 ? spritePriorities_1 : _GEN_475; // @[PPUSimplified.scala 295:31 298:22]
  wire [5:0] spriteColor = spriteHits_0 ? spriteColors_0 : _GEN_476; // @[PPUSimplified.scala 291:25 292:19]
  wire  spriteFound = spriteHits_0 | _GEN_477; // @[PPUSimplified.scala 291:25 293:19]
  wire  spriteBehindBg = spriteHits_0 ? spritePriorities_0 : _GEN_478; // @[PPUSimplified.scala 291:25 294:22]
  wire [5:0] _pixelColor_T_3 = paletteLow == 9'h2 ? 6'h10 : 6'h30; // @[PPUSimplified.scala 330:24]
  wire [5:0] _pixelColor_T_4 = paletteLow == 9'h1 ? 6'h0 : _pixelColor_T_3; // @[PPUSimplified.scala 329:24]
  wire [5:0] _pixelColor_T_5 = _paletteAddr_T ? 6'hf : _pixelColor_T_4; // @[PPUSimplified.scala 328:24]
  wire  bgTransparent = scanlineX < 9'h100 & scanlineY < 9'hf0 ? _paletteAddr_T : 1'h1; // @[PPUSimplified.scala 201:48 234:19 199:34]
  wire [5:0] bgColor = scanlineX < 9'h100 & scanlineY < 9'hf0 ? palette_paletteColor_data[5:0] : 6'hf; // @[PPUSimplified.scala 201:48 233:13 198:28]
  wire [5:0] _GEN_482 = ~bgTransparent ? bgColor : palette_pixelColor_MPORT_data[5:0]; // @[PPUSimplified.scala 334:32 336:18 339:18]
  wire  _GEN_485 = ~bgTransparent ? 1'h0 : 1'h1; // @[PPUSimplified.scala 334:32 55:20 339:33]
  wire [5:0] _GEN_486 = spriteFound & (~spriteBehindBg | bgTransparent) ? spriteColor : _GEN_482; // @[PPUSimplified.scala 331:67 333:18]
  wire  _GEN_489 = spriteFound & (~spriteBehindBg | bgTransparent) ? 1'h0 : _GEN_485; // @[PPUSimplified.scala 331:67 55:20]
  wire [5:0] _GEN_490 = _T ? _pixelColor_T_5 : _GEN_486; // @[PPUSimplified.scala 326:28 328:18]
  wire  _GEN_493 = _T ? 1'h0 : _GEN_489; // @[PPUSimplified.scala 326:28 55:20]
  assign vram_io_cpuDataOut_MPORT_2_en = io_cpuRead & _GEN_105;
  assign vram_io_cpuDataOut_MPORT_2_addr = ppuAddrReg[10:0];
  assign vram_io_cpuDataOut_MPORT_2_data = vram[vram_io_cpuDataOut_MPORT_2_addr]; // @[PPUSimplified.scala 53:17]
  assign vram_tileIndex_en = _T_30 & _T_31;
  assign vram_tileIndex_addr = _nametableAddr_T + _GEN_595;
  assign vram_tileIndex_data = vram[vram_tileIndex_addr]; // @[PPUSimplified.scala 53:17]
  assign vram_attrByte_en = _T_30 & _T_31;
  assign vram_attrByte_addr = {{1'd0}, attrAddr};
  assign vram_attrByte_data = vram[vram_attrByte_addr]; // @[PPUSimplified.scala 53:17]
  assign vram_MPORT_4_data = io_cpuDataIn;
  assign vram_MPORT_4_addr = ppuAddrReg[10:0];
  assign vram_MPORT_4_mask = 1'h1;
  assign vram_MPORT_4_en = io_cpuWrite & _GEN_306;
  assign oam_io_cpuDataOut_MPORT_en = io_cpuRead & _GEN_99;
  assign oam_io_cpuDataOut_MPORT_addr = oamAddr;
  assign oam_io_cpuDataOut_MPORT_data = oam[oam_io_cpuDataOut_MPORT_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprY_en = _T_30 & _T_31;
  assign oam_sprY_addr = 8'h0;
  assign oam_sprY_data = oam[oam_sprY_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprTile_en = _T_30 & _T_31;
  assign oam_sprTile_addr = 8'h1;
  assign oam_sprTile_data = oam[oam_sprTile_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprAttr_en = _T_30 & _T_31;
  assign oam_sprAttr_addr = 8'h2;
  assign oam_sprAttr_data = oam[oam_sprAttr_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprX_en = _T_30 & _T_31;
  assign oam_sprX_addr = 8'h3;
  assign oam_sprX_data = oam[oam_sprX_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprY_1_en = _T_30 & _T_31;
  assign oam_sprY_1_addr = 8'h4;
  assign oam_sprY_1_data = oam[oam_sprY_1_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprTile_1_en = _T_30 & _T_31;
  assign oam_sprTile_1_addr = 8'h5;
  assign oam_sprTile_1_data = oam[oam_sprTile_1_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprAttr_1_en = _T_30 & _T_31;
  assign oam_sprAttr_1_addr = 8'h6;
  assign oam_sprAttr_1_data = oam[oam_sprAttr_1_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprX_1_en = _T_30 & _T_31;
  assign oam_sprX_1_addr = 8'h7;
  assign oam_sprX_1_data = oam[oam_sprX_1_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprY_2_en = _T_30 & _T_31;
  assign oam_sprY_2_addr = 8'h8;
  assign oam_sprY_2_data = oam[oam_sprY_2_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprTile_2_en = _T_30 & _T_31;
  assign oam_sprTile_2_addr = 8'h9;
  assign oam_sprTile_2_data = oam[oam_sprTile_2_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprAttr_2_en = _T_30 & _T_31;
  assign oam_sprAttr_2_addr = 8'ha;
  assign oam_sprAttr_2_data = oam[oam_sprAttr_2_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprX_2_en = _T_30 & _T_31;
  assign oam_sprX_2_addr = 8'hb;
  assign oam_sprX_2_data = oam[oam_sprX_2_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprY_3_en = _T_30 & _T_31;
  assign oam_sprY_3_addr = 8'hc;
  assign oam_sprY_3_data = oam[oam_sprY_3_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprTile_3_en = _T_30 & _T_31;
  assign oam_sprTile_3_addr = 8'hd;
  assign oam_sprTile_3_data = oam[oam_sprTile_3_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprAttr_3_en = _T_30 & _T_31;
  assign oam_sprAttr_3_addr = 8'he;
  assign oam_sprAttr_3_data = oam[oam_sprAttr_3_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprX_3_en = _T_30 & _T_31;
  assign oam_sprX_3_addr = 8'hf;
  assign oam_sprX_3_data = oam[oam_sprX_3_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprY_4_en = _T_30 & _T_31;
  assign oam_sprY_4_addr = 8'h10;
  assign oam_sprY_4_data = oam[oam_sprY_4_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprTile_4_en = _T_30 & _T_31;
  assign oam_sprTile_4_addr = 8'h11;
  assign oam_sprTile_4_data = oam[oam_sprTile_4_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprAttr_4_en = _T_30 & _T_31;
  assign oam_sprAttr_4_addr = 8'h12;
  assign oam_sprAttr_4_data = oam[oam_sprAttr_4_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprX_4_en = _T_30 & _T_31;
  assign oam_sprX_4_addr = 8'h13;
  assign oam_sprX_4_data = oam[oam_sprX_4_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprY_5_en = _T_30 & _T_31;
  assign oam_sprY_5_addr = 8'h14;
  assign oam_sprY_5_data = oam[oam_sprY_5_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprTile_5_en = _T_30 & _T_31;
  assign oam_sprTile_5_addr = 8'h15;
  assign oam_sprTile_5_data = oam[oam_sprTile_5_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprAttr_5_en = _T_30 & _T_31;
  assign oam_sprAttr_5_addr = 8'h16;
  assign oam_sprAttr_5_data = oam[oam_sprAttr_5_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprX_5_en = _T_30 & _T_31;
  assign oam_sprX_5_addr = 8'h17;
  assign oam_sprX_5_data = oam[oam_sprX_5_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprY_6_en = _T_30 & _T_31;
  assign oam_sprY_6_addr = 8'h18;
  assign oam_sprY_6_data = oam[oam_sprY_6_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprTile_6_en = _T_30 & _T_31;
  assign oam_sprTile_6_addr = 8'h19;
  assign oam_sprTile_6_data = oam[oam_sprTile_6_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprAttr_6_en = _T_30 & _T_31;
  assign oam_sprAttr_6_addr = 8'h1a;
  assign oam_sprAttr_6_data = oam[oam_sprAttr_6_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprX_6_en = _T_30 & _T_31;
  assign oam_sprX_6_addr = 8'h1b;
  assign oam_sprX_6_data = oam[oam_sprX_6_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprY_7_en = _T_30 & _T_31;
  assign oam_sprY_7_addr = 8'h1c;
  assign oam_sprY_7_data = oam[oam_sprY_7_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprTile_7_en = _T_30 & _T_31;
  assign oam_sprTile_7_addr = 8'h1d;
  assign oam_sprTile_7_data = oam[oam_sprTile_7_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprAttr_7_en = _T_30 & _T_31;
  assign oam_sprAttr_7_addr = 8'h1e;
  assign oam_sprAttr_7_data = oam[oam_sprAttr_7_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_sprX_7_en = _T_30 & _T_31;
  assign oam_sprX_7_addr = 8'h1f;
  assign oam_sprX_7_data = oam[oam_sprX_7_addr]; // @[PPUSimplified.scala 54:16]
  assign oam_MPORT_1_data = io_oamDmaData;
  assign oam_MPORT_1_addr = io_oamDmaAddr;
  assign oam_MPORT_1_mask = 1'h1;
  assign oam_MPORT_1_en = io_oamDmaWrite;
  assign oam_MPORT_2_data = io_cpuDataIn;
  assign oam_MPORT_2_addr = oamAddr;
  assign oam_MPORT_2_mask = 1'h1;
  assign oam_MPORT_2_en = io_cpuWrite & _GEN_292;
  assign palette_io_cpuDataOut_MPORT_3_en = io_cpuRead & _GEN_108;
  assign palette_io_cpuDataOut_MPORT_3_addr = ppuAddrReg[4:0];
  assign palette_io_cpuDataOut_MPORT_3_data = palette[palette_io_cpuDataOut_MPORT_3_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_paletteColor_en = _T_30 & _T_31;
  assign palette_paletteColor_addr = paletteAddr[4:0];
  assign palette_paletteColor_data = palette[palette_paletteColor_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_sprPaletteColor_en = _T_32 & spriteHits_0;
  assign palette_sprPaletteColor_addr = sprFullPaletteIndex[4:0];
  assign palette_sprPaletteColor_data = palette[palette_sprPaletteColor_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_sprPaletteColor_1_en = _T_32 & spriteHits_1;
  assign palette_sprPaletteColor_1_addr = sprFullPaletteIndex_1[4:0];
  assign palette_sprPaletteColor_1_data = palette[palette_sprPaletteColor_1_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_sprPaletteColor_2_en = _T_32 & spriteHits_2;
  assign palette_sprPaletteColor_2_addr = sprFullPaletteIndex_2[4:0];
  assign palette_sprPaletteColor_2_data = palette[palette_sprPaletteColor_2_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_sprPaletteColor_3_en = _T_32 & spriteHits_3;
  assign palette_sprPaletteColor_3_addr = sprFullPaletteIndex_3[4:0];
  assign palette_sprPaletteColor_3_data = palette[palette_sprPaletteColor_3_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_sprPaletteColor_4_en = _T_32 & spriteHits_4;
  assign palette_sprPaletteColor_4_addr = sprFullPaletteIndex_4[4:0];
  assign palette_sprPaletteColor_4_data = palette[palette_sprPaletteColor_4_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_sprPaletteColor_5_en = _T_32 & spriteHits_5;
  assign palette_sprPaletteColor_5_addr = sprFullPaletteIndex_5[4:0];
  assign palette_sprPaletteColor_5_data = palette[palette_sprPaletteColor_5_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_sprPaletteColor_6_en = _T_32 & spriteHits_6;
  assign palette_sprPaletteColor_6_addr = sprFullPaletteIndex_6[4:0];
  assign palette_sprPaletteColor_6_data = palette[palette_sprPaletteColor_6_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_sprPaletteColor_7_en = _T_32 & spriteHits_7;
  assign palette_sprPaletteColor_7_addr = sprFullPaletteIndex_7[4:0];
  assign palette_sprPaletteColor_7_data = palette[palette_sprPaletteColor_7_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_pixelColor_MPORT_en = _T_32 & _GEN_493;
  assign palette_pixelColor_MPORT_addr = 5'h0;
  assign palette_pixelColor_MPORT_data = palette[palette_pixelColor_MPORT_addr]; // @[PPUSimplified.scala 55:20]
  assign palette_MPORT_data = {{2'd0}, _GEN_31};
  assign palette_MPORT_addr = paletteInitAddr;
  assign palette_MPORT_mask = 1'h1;
  assign palette_MPORT_en = ~paletteInitDone;
  assign palette_MPORT_5_data = io_cpuDataIn;
  assign palette_MPORT_5_addr = ppuAddrReg[4:0];
  assign palette_MPORT_5_mask = 1'h1;
  assign palette_MPORT_5_en = io_cpuWrite & _GEN_311;
  assign chrROM_io_cpuDataOut_MPORT_1_en = io_cpuRead & _GEN_102;
  assign chrROM_io_cpuDataOut_MPORT_1_addr = ppuAddrReg[12:0];
  assign chrROM_io_cpuDataOut_MPORT_1_data = chrROM[chrROM_io_cpuDataOut_MPORT_1_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_patternLow_en = _T_30 & _T_31;
  assign chrROM_patternLow_addr = _patternAddr_T_2 + _GEN_600;
  assign chrROM_patternLow_data = chrROM[chrROM_patternLow_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_patternHigh_en = _T_30 & _T_31;
  assign chrROM_patternHigh_addr = patternAddr + 13'h8;
  assign chrROM_patternHigh_data = chrROM[chrROM_patternHigh_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternLow_en = _T_32 & _T_33;
  assign chrROM_sprPatternLow_addr = _sprPatternAddr_T_2 + _GEN_610;
  assign chrROM_sprPatternLow_data = chrROM[chrROM_sprPatternLow_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternHigh_en = _T_32 & _T_33;
  assign chrROM_sprPatternHigh_addr = sprPatternAddr + 13'h8;
  assign chrROM_sprPatternHigh_data = chrROM[chrROM_sprPatternHigh_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternLow_1_en = _T_32 & _T_35;
  assign chrROM_sprPatternLow_1_addr = _sprPatternAddr_T_6 + _GEN_621;
  assign chrROM_sprPatternLow_1_data = chrROM[chrROM_sprPatternLow_1_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternHigh_1_en = _T_32 & _T_35;
  assign chrROM_sprPatternHigh_1_addr = sprPatternAddr_1 + 13'h8;
  assign chrROM_sprPatternHigh_1_data = chrROM[chrROM_sprPatternHigh_1_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternLow_2_en = _T_32 & _T_37;
  assign chrROM_sprPatternLow_2_addr = _sprPatternAddr_T_10 + _GEN_632;
  assign chrROM_sprPatternLow_2_data = chrROM[chrROM_sprPatternLow_2_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternHigh_2_en = _T_32 & _T_37;
  assign chrROM_sprPatternHigh_2_addr = sprPatternAddr_2 + 13'h8;
  assign chrROM_sprPatternHigh_2_data = chrROM[chrROM_sprPatternHigh_2_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternLow_3_en = _T_32 & _T_39;
  assign chrROM_sprPatternLow_3_addr = _sprPatternAddr_T_14 + _GEN_643;
  assign chrROM_sprPatternLow_3_data = chrROM[chrROM_sprPatternLow_3_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternHigh_3_en = _T_32 & _T_39;
  assign chrROM_sprPatternHigh_3_addr = sprPatternAddr_3 + 13'h8;
  assign chrROM_sprPatternHigh_3_data = chrROM[chrROM_sprPatternHigh_3_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternLow_4_en = _T_32 & _T_41;
  assign chrROM_sprPatternLow_4_addr = _sprPatternAddr_T_18 + _GEN_654;
  assign chrROM_sprPatternLow_4_data = chrROM[chrROM_sprPatternLow_4_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternHigh_4_en = _T_32 & _T_41;
  assign chrROM_sprPatternHigh_4_addr = sprPatternAddr_4 + 13'h8;
  assign chrROM_sprPatternHigh_4_data = chrROM[chrROM_sprPatternHigh_4_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternLow_5_en = _T_32 & _T_43;
  assign chrROM_sprPatternLow_5_addr = _sprPatternAddr_T_22 + _GEN_665;
  assign chrROM_sprPatternLow_5_data = chrROM[chrROM_sprPatternLow_5_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternHigh_5_en = _T_32 & _T_43;
  assign chrROM_sprPatternHigh_5_addr = sprPatternAddr_5 + 13'h8;
  assign chrROM_sprPatternHigh_5_data = chrROM[chrROM_sprPatternHigh_5_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternLow_6_en = _T_32 & _T_45;
  assign chrROM_sprPatternLow_6_addr = _sprPatternAddr_T_26 + _GEN_676;
  assign chrROM_sprPatternLow_6_data = chrROM[chrROM_sprPatternLow_6_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternHigh_6_en = _T_32 & _T_45;
  assign chrROM_sprPatternHigh_6_addr = sprPatternAddr_6 + 13'h8;
  assign chrROM_sprPatternHigh_6_data = chrROM[chrROM_sprPatternHigh_6_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternLow_7_en = _T_32 & _T_47;
  assign chrROM_sprPatternLow_7_addr = _sprPatternAddr_T_30 + _GEN_687;
  assign chrROM_sprPatternLow_7_data = chrROM[chrROM_sprPatternLow_7_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_sprPatternHigh_7_en = _T_32 & _T_47;
  assign chrROM_sprPatternHigh_7_addr = sprPatternAddr_7 + 13'h8;
  assign chrROM_sprPatternHigh_7_data = chrROM[chrROM_sprPatternHigh_7_addr]; // @[PPUSimplified.scala 56:19]
  assign chrROM_MPORT_3_data = io_cpuDataIn;
  assign chrROM_MPORT_3_addr = ppuAddrReg[12:0];
  assign chrROM_MPORT_3_mask = 1'h1;
  assign chrROM_MPORT_3_en = io_cpuWrite & _GEN_301;
  assign chrROM_MPORT_6_data = io_chrLoadData;
  assign chrROM_MPORT_6_addr = io_chrLoadAddr;
  assign chrROM_MPORT_6_mask = 1'h1;
  assign chrROM_MPORT_6_en = io_chrLoadEn;
  assign io_cpuDataOut = io_cpuRead ? _GEN_94 : 8'h0; // @[PPUSimplified.scala 114:17 123:20]
  assign io_pixelX = scanlineX; // @[PPUSimplified.scala 344:13]
  assign io_pixelY = scanlineY; // @[PPUSimplified.scala 345:13]
  assign io_pixelColor = scanlineX < 9'h100 & scanlineY < 9'hf0 ? _GEN_490 : 6'hf; // @[PPUSimplified.scala 195:31 201:48]
  assign io_vblank = vblankFlag; // @[PPUSimplified.scala 347:13]
  assign io_nmiOut = nmiOccurred; // @[PPUSimplified.scala 348:13]
  assign io_debug_ppuCtrl = ppuCtrl; // @[PPUSimplified.scala 351:20]
  assign io_debug_ppuMask = ppuMask; // @[PPUSimplified.scala 352:20]
  assign io_debug_ppuStatus = {io_cpuDataOut_hi,6'h0}; // @[Cat.scala 33:92]
  assign io_debug_ppuAddrReg = ppuAddrReg; // @[PPUSimplified.scala 354:23]
  assign io_debug_paletteInitDone = paletteInitDone; // @[PPUSimplified.scala 355:28]
  always @(posedge clock) begin
    if (vram_MPORT_4_en & vram_MPORT_4_mask) begin
      vram[vram_MPORT_4_addr] <= vram_MPORT_4_data; // @[PPUSimplified.scala 53:17]
    end
    if (oam_MPORT_1_en & oam_MPORT_1_mask) begin
      oam[oam_MPORT_1_addr] <= oam_MPORT_1_data; // @[PPUSimplified.scala 54:16]
    end
    if (oam_MPORT_2_en & oam_MPORT_2_mask) begin
      oam[oam_MPORT_2_addr] <= oam_MPORT_2_data; // @[PPUSimplified.scala 54:16]
    end
    if (palette_MPORT_en & palette_MPORT_mask) begin
      palette[palette_MPORT_addr] <= palette_MPORT_data; // @[PPUSimplified.scala 55:20]
    end
    if (palette_MPORT_5_en & palette_MPORT_5_mask) begin
      palette[palette_MPORT_5_addr] <= palette_MPORT_5_data; // @[PPUSimplified.scala 55:20]
    end
    if (chrROM_MPORT_3_en & chrROM_MPORT_3_mask) begin
      chrROM[chrROM_MPORT_3_addr] <= chrROM_MPORT_3_data; // @[PPUSimplified.scala 56:19]
    end
    if (chrROM_MPORT_6_en & chrROM_MPORT_6_mask) begin
      chrROM[chrROM_MPORT_6_addr] <= chrROM_MPORT_6_data; // @[PPUSimplified.scala 56:19]
    end
    if (reset) begin // @[PPUSimplified.scala 44:24]
      ppuCtrl <= 8'h0; // @[PPUSimplified.scala 44:24]
    end else if (io_cpuWrite) begin // @[PPUSimplified.scala 151:21]
      if (3'h0 == io_cpuAddr) begin // @[PPUSimplified.scala 152:24]
        ppuCtrl <= io_cpuDataIn; // @[PPUSimplified.scala 153:27]
      end
    end
    if (reset) begin // @[PPUSimplified.scala 45:24]
      ppuMask <= 8'h0; // @[PPUSimplified.scala 45:24]
    end else if (io_cpuWrite) begin // @[PPUSimplified.scala 151:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPUSimplified.scala 152:24]
        if (3'h1 == io_cpuAddr) begin // @[PPUSimplified.scala 152:24]
          ppuMask <= io_cpuDataIn; // @[PPUSimplified.scala 154:27]
        end
      end
    end
    if (reset) begin // @[PPUSimplified.scala 46:24]
      oamAddr <= 8'h0; // @[PPUSimplified.scala 46:24]
    end else if (io_cpuWrite) begin // @[PPUSimplified.scala 151:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPUSimplified.scala 152:24]
        if (!(3'h1 == io_cpuAddr)) begin // @[PPUSimplified.scala 152:24]
          oamAddr <= _GEN_236;
        end
      end
    end
    if (reset) begin // @[PPUSimplified.scala 49:29]
      ppuAddrLatch <= 1'h0; // @[PPUSimplified.scala 49:29]
    end else if (io_cpuWrite) begin // @[PPUSimplified.scala 151:21]
      if (3'h0 == io_cpuAddr) begin // @[PPUSimplified.scala 152:24]
        ppuAddrLatch <= _GEN_112;
      end else if (3'h1 == io_cpuAddr) begin // @[PPUSimplified.scala 152:24]
        ppuAddrLatch <= _GEN_112;
      end else begin
        ppuAddrLatch <= _GEN_244;
      end
    end else begin
      ppuAddrLatch <= _GEN_112;
    end
    if (reset) begin // @[PPUSimplified.scala 50:27]
      ppuAddrReg <= 16'h0; // @[PPUSimplified.scala 50:27]
    end else if (io_cpuWrite) begin // @[PPUSimplified.scala 151:21]
      if (3'h0 == io_cpuAddr) begin // @[PPUSimplified.scala 152:24]
        ppuAddrReg <= _GEN_125;
      end else if (3'h1 == io_cpuAddr) begin // @[PPUSimplified.scala 152:24]
        ppuAddrReg <= _GEN_125;
      end else begin
        ppuAddrReg <= _GEN_245;
      end
    end else begin
      ppuAddrReg <= _GEN_125;
    end
    if (reset) begin // @[PPUSimplified.scala 59:32]
      paletteInitDone <= 1'h0; // @[PPUSimplified.scala 59:32]
    end else if (~paletteInitDone) begin // @[PPUSimplified.scala 62:26]
      paletteInitDone <= _GEN_32;
    end
    if (reset) begin // @[PPUSimplified.scala 60:32]
      paletteInitAddr <= 5'h0; // @[PPUSimplified.scala 60:32]
    end else if (~paletteInitDone) begin // @[PPUSimplified.scala 62:26]
      paletteInitAddr <= _paletteInitAddr_T_1; // @[PPUSimplified.scala 75:21]
    end
    if (reset) begin // @[PPUSimplified.scala 83:26]
      scanlineX <= 9'h0; // @[PPUSimplified.scala 83:26]
    end else if (scanlineX == 9'h154) begin // @[PPUSimplified.scala 87:29]
      scanlineX <= 9'h0; // @[PPUSimplified.scala 88:15]
    end else begin
      scanlineX <= _scanlineX_T_1; // @[PPUSimplified.scala 86:13]
    end
    if (reset) begin // @[PPUSimplified.scala 84:26]
      scanlineY <= 9'h0; // @[PPUSimplified.scala 84:26]
    end else if (scanlineX == 9'h154) begin // @[PPUSimplified.scala 87:29]
      if (scanlineY == 9'h105) begin // @[PPUSimplified.scala 90:31]
        scanlineY <= 9'h0; // @[PPUSimplified.scala 91:17]
      end else begin
        scanlineY <= _scanlineY_T_1; // @[PPUSimplified.scala 89:15]
      end
    end
    if (reset) begin // @[PPUSimplified.scala 96:27]
      vblankFlag <= 1'h0; // @[PPUSimplified.scala 96:27]
    end else if (vblankClearNext) begin // @[PPUSimplified.scala 117:25]
      vblankFlag <= 1'h0; // @[PPUSimplified.scala 118:16]
    end else if (_T_3 & _T_5) begin // @[PPUSimplified.scala 107:50]
      vblankFlag <= 1'h0; // @[PPUSimplified.scala 108:16]
    end else begin
      vblankFlag <= _GEN_44;
    end
    if (reset) begin // @[PPUSimplified.scala 97:28]
      nmiOccurred <= 1'h0; // @[PPUSimplified.scala 97:28]
    end else if (vblankClearNext) begin // @[PPUSimplified.scala 117:25]
      nmiOccurred <= 1'h0; // @[PPUSimplified.scala 119:17]
    end else if (_T_3 & _T_5) begin // @[PPUSimplified.scala 107:50]
      nmiOccurred <= 1'h0; // @[PPUSimplified.scala 109:17]
    end else if (scanlineY == 9'hf1 & scanlineX == 9'h1) begin // @[PPUSimplified.scala 100:50]
      nmiOccurred <= _GEN_43;
    end
    if (reset) begin // @[PPUSimplified.scala 116:32]
      vblankClearNext <= 1'h0; // @[PPUSimplified.scala 116:32]
    end else if (io_cpuRead) begin // @[PPUSimplified.scala 123:20]
      vblankClearNext <= _GEN_95;
    end else if (vblankClearNext) begin // @[PPUSimplified.scala 117:25]
      vblankClearNext <= 1'h0; // @[PPUSimplified.scala 120:21]
    end
  end
endmodule
module MemoryController(
  input         clock,
  input         reset,
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
  output [7:0]  io_oamDmaAddr,
  output [7:0]  io_oamDmaData,
  output        io_oamDmaWrite,
  input  [7:0]  io_controller1,
  input  [7:0]  io_controller2,
  input         io_romLoadEn,
  input  [15:0] io_romLoadAddr,
  input  [7:0]  io_romLoadData,
  input         io_romLoadPRG
);
  reg [7:0] internalRAM [0:2047]; // @[MemoryController.scala 41:32]
  wire  internalRAM_io_cpuDataOut_MPORT_en; // @[MemoryController.scala 41:32]
  wire [10:0] internalRAM_io_cpuDataOut_MPORT_addr; // @[MemoryController.scala 41:32]
  wire [7:0] internalRAM_io_cpuDataOut_MPORT_data; // @[MemoryController.scala 41:32]
  wire  internalRAM_dmaData_MPORT_en; // @[MemoryController.scala 41:32]
  wire [10:0] internalRAM_dmaData_MPORT_addr; // @[MemoryController.scala 41:32]
  wire [7:0] internalRAM_dmaData_MPORT_data; // @[MemoryController.scala 41:32]
  wire [7:0] internalRAM_MPORT_data; // @[MemoryController.scala 41:32]
  wire [10:0] internalRAM_MPORT_addr; // @[MemoryController.scala 41:32]
  wire  internalRAM_MPORT_mask; // @[MemoryController.scala 41:32]
  wire  internalRAM_MPORT_en; // @[MemoryController.scala 41:32]
  reg  internalRAM_io_cpuDataOut_MPORT_en_pipe_0;
  reg [10:0] internalRAM_io_cpuDataOut_MPORT_addr_pipe_0;
  reg  internalRAM_dmaData_MPORT_en_pipe_0;
  reg [10:0] internalRAM_dmaData_MPORT_addr_pipe_0;
  reg [7:0] prgROM [0:32767]; // @[MemoryController.scala 45:19]
  wire  prgROM_io_cpuDataOut_MPORT_1_en; // @[MemoryController.scala 45:19]
  wire [14:0] prgROM_io_cpuDataOut_MPORT_1_addr; // @[MemoryController.scala 45:19]
  wire [7:0] prgROM_io_cpuDataOut_MPORT_1_data; // @[MemoryController.scala 45:19]
  wire  prgROM_dmaData_MPORT_1_en; // @[MemoryController.scala 45:19]
  wire [14:0] prgROM_dmaData_MPORT_1_addr; // @[MemoryController.scala 45:19]
  wire [7:0] prgROM_dmaData_MPORT_1_data; // @[MemoryController.scala 45:19]
  wire [7:0] prgROM_MPORT_1_data; // @[MemoryController.scala 45:19]
  wire [14:0] prgROM_MPORT_1_addr; // @[MemoryController.scala 45:19]
  wire  prgROM_MPORT_1_mask; // @[MemoryController.scala 45:19]
  wire  prgROM_MPORT_1_en; // @[MemoryController.scala 45:19]
  wire [7:0] prgROM_MPORT_2_data; // @[MemoryController.scala 45:19]
  wire [14:0] prgROM_MPORT_2_addr; // @[MemoryController.scala 45:19]
  wire  prgROM_MPORT_2_mask; // @[MemoryController.scala 45:19]
  wire  prgROM_MPORT_2_en; // @[MemoryController.scala 45:19]
  reg  dmaActive; // @[MemoryController.scala 48:26]
  reg [7:0] dmaPage; // @[MemoryController.scala 49:24]
  reg [7:0] dmaOffset; // @[MemoryController.scala 50:26]
  wire  _T = io_cpuAddr < 16'h2000; // @[MemoryController.scala 73:21]
  wire  _T_3 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000; // @[MemoryController.scala 77:39]
  wire  _T_6 = io_cpuAddr >= 16'h8000; // @[MemoryController.scala 88:27]
  wire [15:0] _romAddr_T_1 = io_cpuAddr - 16'h8000; // @[MemoryController.scala 93:33]
  wire [13:0] romAddr = _romAddr_T_1[13:0]; // @[MemoryController.scala 93:44]
  wire [7:0] _GEN_7 = io_cpuAddr >= 16'h8000 ? prgROM_io_cpuDataOut_MPORT_1_data : 8'h0; // @[MemoryController.scala 53:17 88:40 94:21]
  wire [7:0] _GEN_8 = io_cpuAddr == 16'h4017 ? io_controller2 : _GEN_7; // @[MemoryController.scala 85:41 87:21]
  wire  _GEN_11 = io_cpuAddr == 16'h4017 ? 1'h0 : _T_6; // @[MemoryController.scala 45:19 85:41]
  wire [7:0] _GEN_12 = io_cpuAddr == 16'h4016 ? io_controller1 : _GEN_8; // @[MemoryController.scala 82:41 84:21]
  wire  _GEN_15 = io_cpuAddr == 16'h4016 ? 1'h0 : _GEN_11; // @[MemoryController.scala 45:19 82:41]
  wire [2:0] _GEN_16 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? io_cpuAddr[2:0] : 3'h0; // @[MemoryController.scala 54:14 77:65 79:18]
  wire [7:0] _GEN_18 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? io_ppuDataOut : _GEN_12; // @[MemoryController.scala 77:65 81:21]
  wire  _GEN_21 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? 1'h0 : _GEN_15; // @[MemoryController.scala 45:19 77:65]
  wire [7:0] _GEN_25 = io_cpuAddr < 16'h2000 ? internalRAM_io_cpuDataOut_MPORT_data : _GEN_18; // @[MemoryController.scala 73:33 76:21]
  wire [2:0] _GEN_26 = io_cpuAddr < 16'h2000 ? 3'h0 : _GEN_16; // @[MemoryController.scala 54:14 73:33]
  wire  _GEN_27 = io_cpuAddr < 16'h2000 ? 1'h0 : _T_3; // @[MemoryController.scala 57:14 73:33]
  wire  _GEN_30 = io_cpuAddr < 16'h2000 ? 1'h0 : _GEN_21; // @[MemoryController.scala 45:19 73:33]
  wire [2:0] _GEN_35 = io_cpuRead ? _GEN_26 : 3'h0; // @[MemoryController.scala 54:14 72:20]
  wire [15:0] dmaAddr = {dmaPage,dmaOffset}; // @[Cat.scala 33:92]
  wire  _T_7 = dmaAddr < 16'h2000; // @[MemoryController.scala 106:18]
  wire  _T_8 = dmaAddr >= 16'h8000; // @[MemoryController.scala 108:24]
  wire [15:0] _romAddr_T_3 = dmaAddr - 16'h8000; // @[MemoryController.scala 109:30]
  wire [13:0] romAddr_1 = _romAddr_T_3[13:0]; // @[MemoryController.scala 109:41]
  wire [7:0] _GEN_45 = dmaAddr >= 16'h8000 ? prgROM_dmaData_MPORT_1_data : 8'h0; // @[MemoryController.scala 108:37 110:15 103:30]
  wire [7:0] dmaData = dmaAddr < 16'h2000 ? internalRAM_dmaData_MPORT_data : _GEN_45; // @[MemoryController.scala 106:30 107:15]
  wire  _GEN_52 = dmaAddr < 16'h2000 ? 1'h0 : _T_8; // @[MemoryController.scala 106:30 45:19]
  wire [7:0] _dmaOffset_T_1 = dmaOffset + 8'h1; // @[MemoryController.scala 119:28]
  wire  _GEN_53 = dmaOffset == 8'hff ? 1'h0 : dmaActive; // @[MemoryController.scala 122:31 123:17 48:26]
  wire [7:0] _GEN_63 = dmaActive ? _dmaOffset_T_1 : dmaOffset; // @[MemoryController.scala 100:19 119:15 50:26]
  wire  _GEN_64 = dmaActive ? _GEN_53 : dmaActive; // @[MemoryController.scala 100:19 48:26]
  wire  _T_11 = io_cpuWrite & ~dmaActive; // @[MemoryController.scala 127:20]
  wire  _GEN_70 = io_cpuAddr == 16'h4014 | _GEN_64; // @[MemoryController.scala 137:41 139:17]
  wire [7:0] _GEN_71 = io_cpuAddr == 16'h4014 ? io_cpuDataIn : dmaPage; // @[MemoryController.scala 137:41 140:15 49:24]
  wire [7:0] _GEN_72 = io_cpuAddr == 16'h4014 ? 8'h0 : _GEN_63; // @[MemoryController.scala 137:41 141:17]
  wire  _GEN_75 = io_cpuAddr == 16'h4014 ? 1'h0 : _T_6; // @[MemoryController.scala 137:41 45:19]
  wire [2:0] _GEN_78 = _T_3 ? io_cpuAddr[2:0] : _GEN_35; // @[MemoryController.scala 132:65 134:18]
  wire [7:0] _GEN_79 = _T_3 ? io_cpuDataIn : 8'h0; // @[MemoryController.scala 132:65 135:20 55:16]
  wire  _GEN_86 = _T_3 ? 1'h0 : _GEN_75; // @[MemoryController.scala 132:65 45:19]
  wire [2:0] _GEN_94 = _T ? _GEN_35 : _GEN_78; // @[MemoryController.scala 128:33]
  wire [7:0] _GEN_95 = _T ? 8'h0 : _GEN_79; // @[MemoryController.scala 128:33 55:16]
  wire  _GEN_102 = _T ? 1'h0 : _GEN_86; // @[MemoryController.scala 128:33 45:19]
  wire  _T_19 = io_romLoadEn & io_romLoadPRG; // @[MemoryController.scala 150:21]
  wire  _T_20 = io_romLoadAddr < 16'h8000; // @[MemoryController.scala 152:25]
  assign internalRAM_io_cpuDataOut_MPORT_en = internalRAM_io_cpuDataOut_MPORT_en_pipe_0;
  assign internalRAM_io_cpuDataOut_MPORT_addr = internalRAM_io_cpuDataOut_MPORT_addr_pipe_0;
  assign internalRAM_io_cpuDataOut_MPORT_data = internalRAM[internalRAM_io_cpuDataOut_MPORT_addr]; // @[MemoryController.scala 41:32]
  assign internalRAM_dmaData_MPORT_en = internalRAM_dmaData_MPORT_en_pipe_0;
  assign internalRAM_dmaData_MPORT_addr = internalRAM_dmaData_MPORT_addr_pipe_0;
  assign internalRAM_dmaData_MPORT_data = internalRAM[internalRAM_dmaData_MPORT_addr]; // @[MemoryController.scala 41:32]
  assign internalRAM_MPORT_data = io_cpuDataIn;
  assign internalRAM_MPORT_addr = io_cpuAddr[10:0];
  assign internalRAM_MPORT_mask = 1'h1;
  assign internalRAM_MPORT_en = _T_11 & _T;
  assign prgROM_io_cpuDataOut_MPORT_1_en = io_cpuRead & _GEN_30;
  assign prgROM_io_cpuDataOut_MPORT_1_addr = {{1'd0}, romAddr};
  assign prgROM_io_cpuDataOut_MPORT_1_data = prgROM[prgROM_io_cpuDataOut_MPORT_1_addr]; // @[MemoryController.scala 45:19]
  assign prgROM_dmaData_MPORT_1_en = dmaActive & _GEN_52;
  assign prgROM_dmaData_MPORT_1_addr = {{1'd0}, romAddr_1};
  assign prgROM_dmaData_MPORT_1_data = prgROM[prgROM_dmaData_MPORT_1_addr]; // @[MemoryController.scala 45:19]
  assign prgROM_MPORT_1_data = io_cpuDataIn;
  assign prgROM_MPORT_1_addr = _romAddr_T_1[14:0];
  assign prgROM_MPORT_1_mask = 1'h1;
  assign prgROM_MPORT_1_en = _T_11 & _GEN_102;
  assign prgROM_MPORT_2_data = io_romLoadData;
  assign prgROM_MPORT_2_addr = io_romLoadAddr[14:0];
  assign prgROM_MPORT_2_mask = 1'h1;
  assign prgROM_MPORT_2_en = _T_19 & _T_20;
  assign io_cpuDataOut = io_cpuRead ? _GEN_25 : 8'h0; // @[MemoryController.scala 53:17 72:20]
  assign io_ppuAddr = io_cpuWrite & ~dmaActive ? _GEN_94 : _GEN_35; // @[MemoryController.scala 127:35]
  assign io_ppuDataIn = io_cpuWrite & ~dmaActive ? _GEN_95 : 8'h0; // @[MemoryController.scala 127:35 55:16]
  assign io_ppuWrite = io_cpuWrite & ~dmaActive & _GEN_27; // @[MemoryController.scala 127:35 56:15]
  assign io_ppuRead = io_cpuRead & _GEN_27; // @[MemoryController.scala 57:14 72:20]
  assign io_oamDmaAddr = dmaActive ? dmaOffset : 8'h0; // @[MemoryController.scala 100:19 114:19 58:17]
  assign io_oamDmaData = dmaActive ? dmaData : 8'h0; // @[MemoryController.scala 100:19 115:19 59:17]
  assign io_oamDmaWrite = dmaActive; // @[MemoryController.scala 100:19 116:20 60:18]
  always @(posedge clock) begin
    if (internalRAM_MPORT_en & internalRAM_MPORT_mask) begin
      internalRAM[internalRAM_MPORT_addr] <= internalRAM_MPORT_data; // @[MemoryController.scala 41:32]
    end
    internalRAM_io_cpuDataOut_MPORT_en_pipe_0 <= io_cpuRead & _T;
    if (io_cpuRead & _T) begin
      internalRAM_io_cpuDataOut_MPORT_addr_pipe_0 <= io_cpuAddr[10:0];
    end
    internalRAM_dmaData_MPORT_en_pipe_0 <= dmaActive & _T_7;
    if (dmaActive & _T_7) begin
      internalRAM_dmaData_MPORT_addr_pipe_0 <= dmaAddr[10:0];
    end
    if (prgROM_MPORT_1_en & prgROM_MPORT_1_mask) begin
      prgROM[prgROM_MPORT_1_addr] <= prgROM_MPORT_1_data; // @[MemoryController.scala 45:19]
    end
    if (prgROM_MPORT_2_en & prgROM_MPORT_2_mask) begin
      prgROM[prgROM_MPORT_2_addr] <= prgROM_MPORT_2_data; // @[MemoryController.scala 45:19]
    end
    if (reset) begin // @[MemoryController.scala 48:26]
      dmaActive <= 1'h0; // @[MemoryController.scala 48:26]
    end else if (io_cpuWrite & ~dmaActive) begin // @[MemoryController.scala 127:35]
      if (_T) begin // @[MemoryController.scala 128:33]
        dmaActive <= _GEN_64;
      end else if (_T_3) begin // @[MemoryController.scala 132:65]
        dmaActive <= _GEN_64;
      end else begin
        dmaActive <= _GEN_70;
      end
    end else begin
      dmaActive <= _GEN_64;
    end
    if (reset) begin // @[MemoryController.scala 49:24]
      dmaPage <= 8'h0; // @[MemoryController.scala 49:24]
    end else if (io_cpuWrite & ~dmaActive) begin // @[MemoryController.scala 127:35]
      if (!(_T)) begin // @[MemoryController.scala 128:33]
        if (!(_T_3)) begin // @[MemoryController.scala 132:65]
          dmaPage <= _GEN_71;
        end
      end
    end
    if (reset) begin // @[MemoryController.scala 50:26]
      dmaOffset <= 8'h0; // @[MemoryController.scala 50:26]
    end else if (io_cpuWrite & ~dmaActive) begin // @[MemoryController.scala 127:35]
      if (_T) begin // @[MemoryController.scala 128:33]
        dmaOffset <= _GEN_63;
      end else if (_T_3) begin // @[MemoryController.scala 132:65]
        dmaOffset <= _GEN_63;
      end else begin
        dmaOffset <= _GEN_72;
      end
    end else begin
      dmaOffset <= _GEN_63;
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
  wire [7:0] ppu_io_oamDmaAddr; // @[NESSystem.scala 42:19]
  wire [7:0] ppu_io_oamDmaData; // @[NESSystem.scala 42:19]
  wire  ppu_io_oamDmaWrite; // @[NESSystem.scala 42:19]
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
  wire  memory_reset; // @[NESSystem.scala 43:22]
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
  wire [7:0] memory_io_oamDmaAddr; // @[NESSystem.scala 43:22]
  wire [7:0] memory_io_oamDmaData; // @[NESSystem.scala 43:22]
  wire  memory_io_oamDmaWrite; // @[NESSystem.scala 43:22]
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
  PPUSimplified ppu ( // @[NESSystem.scala 42:19]
    .clock(ppu_clock),
    .reset(ppu_reset),
    .io_cpuAddr(ppu_io_cpuAddr),
    .io_cpuDataIn(ppu_io_cpuDataIn),
    .io_cpuDataOut(ppu_io_cpuDataOut),
    .io_cpuWrite(ppu_io_cpuWrite),
    .io_cpuRead(ppu_io_cpuRead),
    .io_oamDmaAddr(ppu_io_oamDmaAddr),
    .io_oamDmaData(ppu_io_oamDmaData),
    .io_oamDmaWrite(ppu_io_oamDmaWrite),
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
    .reset(memory_reset),
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
    .io_oamDmaAddr(memory_io_oamDmaAddr),
    .io_oamDmaData(memory_io_oamDmaData),
    .io_oamDmaWrite(memory_io_oamDmaWrite),
    .io_controller1(memory_io_controller1),
    .io_controller2(memory_io_controller2),
    .io_romLoadEn(memory_io_romLoadEn),
    .io_romLoadAddr(memory_io_romLoadAddr),
    .io_romLoadData(memory_io_romLoadData),
    .io_romLoadPRG(memory_io_romLoadPRG)
  );
  assign io_pixelX = ppu_io_pixelX; // @[NESSystem.scala 73:13]
  assign io_pixelY = ppu_io_pixelY; // @[NESSystem.scala 74:13]
  assign io_pixelColor = ppu_io_pixelColor; // @[NESSystem.scala 75:17]
  assign io_vblank = ppu_io_vblank; // @[NESSystem.scala 76:13]
  assign io_debug_regA = cpu_io_debug_regA; // @[NESSystem.scala 79:12]
  assign io_debug_regX = cpu_io_debug_regX; // @[NESSystem.scala 79:12]
  assign io_debug_regY = cpu_io_debug_regY; // @[NESSystem.scala 79:12]
  assign io_debug_regPC = cpu_io_debug_regPC; // @[NESSystem.scala 79:12]
  assign io_debug_regSP = cpu_io_debug_regSP; // @[NESSystem.scala 79:12]
  assign io_debug_flagC = cpu_io_debug_flagC; // @[NESSystem.scala 79:12]
  assign io_debug_flagZ = cpu_io_debug_flagZ; // @[NESSystem.scala 79:12]
  assign io_debug_flagN = cpu_io_debug_flagN; // @[NESSystem.scala 79:12]
  assign io_debug_flagV = cpu_io_debug_flagV; // @[NESSystem.scala 79:12]
  assign io_debug_opcode = cpu_io_debug_opcode; // @[NESSystem.scala 79:12]
  assign io_debug_state = cpu_io_debug_state; // @[NESSystem.scala 79:12]
  assign io_debug_cycle = cpu_io_debug_cycle; // @[NESSystem.scala 79:12]
  assign io_ppuDebug_ppuCtrl = ppu_io_debug_ppuCtrl; // @[NESSystem.scala 80:15]
  assign io_ppuDebug_ppuMask = ppu_io_debug_ppuMask; // @[NESSystem.scala 80:15]
  assign io_ppuDebug_ppuStatus = ppu_io_debug_ppuStatus; // @[NESSystem.scala 80:15]
  assign io_ppuDebug_ppuAddrReg = ppu_io_debug_ppuAddrReg; // @[NESSystem.scala 80:15]
  assign io_ppuDebug_paletteInitDone = ppu_io_debug_paletteInitDone; // @[NESSystem.scala 80:15]
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
  assign ppu_io_oamDmaAddr = memory_io_oamDmaAddr; // @[NESSystem.scala 64:21]
  assign ppu_io_oamDmaData = memory_io_oamDmaData; // @[NESSystem.scala 65:21]
  assign ppu_io_oamDmaWrite = memory_io_oamDmaWrite; // @[NESSystem.scala 66:22]
  assign ppu_io_chrLoadEn = io_romLoadEn & ~io_romLoadPRG; // @[NESSystem.scala 89:36]
  assign ppu_io_chrLoadAddr = io_romLoadAddr[12:0]; // @[NESSystem.scala 90:39]
  assign ppu_io_chrLoadData = io_romLoadData; // @[NESSystem.scala 91:22]
  assign memory_clock = clock;
  assign memory_reset = reset;
  assign memory_io_cpuAddr = cpu_io_memAddr; // @[NESSystem.scala 50:21]
  assign memory_io_cpuDataIn = cpu_io_memDataOut; // @[NESSystem.scala 51:23]
  assign memory_io_cpuWrite = cpu_io_memWrite; // @[NESSystem.scala 53:22]
  assign memory_io_cpuRead = cpu_io_memRead; // @[NESSystem.scala 54:21]
  assign memory_io_ppuDataOut = ppu_io_cpuDataOut; // @[NESSystem.scala 59:24]
  assign memory_io_controller1 = io_controller1; // @[NESSystem.scala 69:25]
  assign memory_io_controller2 = io_controller2; // @[NESSystem.scala 70:25]
  assign memory_io_romLoadEn = io_romLoadEn; // @[NESSystem.scala 83:23]
  assign memory_io_romLoadAddr = io_romLoadAddr; // @[NESSystem.scala 84:25]
  assign memory_io_romLoadData = io_romLoadData; // @[NESSystem.scala 85:25]
  assign memory_io_romLoadPRG = io_romLoadPRG; // @[NESSystem.scala 86:24]
endmodule
