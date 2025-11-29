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
  output [7:0]  io_debug_opcode,
  output [1:0]  io_debug_state,
  output [2:0]  io_debug_cycle,
  input         io_reset,
  input         io_nmi
);
  reg [7:0] regs_a; // @[CPU6502Core.scala 22:21]
  reg [7:0] regs_x; // @[CPU6502Core.scala 22:21]
  reg [7:0] regs_y; // @[CPU6502Core.scala 22:21]
  reg [7:0] regs_sp; // @[CPU6502Core.scala 22:21]
  reg [15:0] regs_pc; // @[CPU6502Core.scala 22:21]
  reg  regs_flagC; // @[CPU6502Core.scala 22:21]
  reg  regs_flagZ; // @[CPU6502Core.scala 22:21]
  reg  regs_flagI; // @[CPU6502Core.scala 22:21]
  reg  regs_flagD; // @[CPU6502Core.scala 22:21]
  reg  regs_flagV; // @[CPU6502Core.scala 22:21]
  reg  regs_flagN; // @[CPU6502Core.scala 22:21]
  reg [2:0] state; // @[CPU6502Core.scala 26:22]
  reg [7:0] opcode; // @[CPU6502Core.scala 28:24]
  reg [15:0] operand; // @[CPU6502Core.scala 29:24]
  reg [3:0] cycle; // @[CPU6502Core.scala 30:24]
  reg  nmiLast; // @[CPU6502Core.scala 33:24]
  reg  nmiPending; // @[CPU6502Core.scala 34:27]
  wire  _GEN_0 = io_nmi & ~nmiLast | nmiPending; // @[CPU6502Core.scala 40:28 41:16 34:27]
  wire  _T_4 = 3'h0 == state; // @[CPU6502Core.scala 70:19]
  wire  _T_5 = cycle == 4'h0; // @[CPU6502Core.scala 73:22]
  wire  _T_6 = cycle == 4'h1; // @[CPU6502Core.scala 77:28]
  wire  _T_7 = cycle == 4'h2; // @[CPU6502Core.scala 82:28]
  wire  _T_8 = cycle == 4'h3; // @[CPU6502Core.scala 87:28]
  wire  _T_9 = cycle == 4'h4; // @[CPU6502Core.scala 92:28]
  wire  _T_11 = ~reset; // @[CPU6502Core.scala 97:19]
  wire  _T_12 = cycle == 4'h5; // @[CPU6502Core.scala 99:28]
  wire  _T_13 = cycle == 4'h6; // @[CPU6502Core.scala 104:28]
  wire  _T_14 = cycle == 4'h7; // @[CPU6502Core.scala 109:28]
  wire  _T_15 = cycle == 4'h8; // @[CPU6502Core.scala 114:28]
  wire [15:0] resetVector = {io_memDataIn,operand[7:0]}; // @[Cat.scala 33:92]
  wire [3:0] _GEN_4 = cycle == 4'h8 ? 4'h9 : 4'h0; // @[CPU6502Core.scala 114:37 118:19 129:19]
  wire [15:0] _GEN_5 = cycle == 4'h8 ? regs_pc : resetVector; // @[CPU6502Core.scala 114:37 126:21 22:21]
  wire [7:0] _GEN_6 = cycle == 4'h8 ? regs_sp : 8'hfd; // @[CPU6502Core.scala 114:37 127:21 22:21]
  wire  _GEN_7 = cycle == 4'h8 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 114:37 22:21 128:24]
  wire [2:0] _GEN_8 = cycle == 4'h8 ? state : 3'h1; // @[CPU6502Core.scala 114:37 130:19 26:22]
  wire [3:0] _GEN_11 = cycle == 4'h7 ? 4'h8 : _GEN_4; // @[CPU6502Core.scala 109:37 113:19]
  wire [15:0] _GEN_12 = cycle == 4'h7 ? regs_pc : _GEN_5; // @[CPU6502Core.scala 109:37 22:21]
  wire [7:0] _GEN_13 = cycle == 4'h7 ? regs_sp : _GEN_6; // @[CPU6502Core.scala 109:37 22:21]
  wire  _GEN_14 = cycle == 4'h7 ? regs_flagI : _GEN_7; // @[CPU6502Core.scala 109:37 22:21]
  wire [2:0] _GEN_15 = cycle == 4'h7 ? state : _GEN_8; // @[CPU6502Core.scala 109:37 26:22]
  wire [3:0] _GEN_18 = cycle == 4'h6 ? 4'h7 : _GEN_11; // @[CPU6502Core.scala 104:37 108:19]
  wire [15:0] _GEN_19 = cycle == 4'h6 ? regs_pc : _GEN_12; // @[CPU6502Core.scala 104:37 22:21]
  wire [7:0] _GEN_20 = cycle == 4'h6 ? regs_sp : _GEN_13; // @[CPU6502Core.scala 104:37 22:21]
  wire  _GEN_21 = cycle == 4'h6 ? regs_flagI : _GEN_14; // @[CPU6502Core.scala 104:37 22:21]
  wire [2:0] _GEN_22 = cycle == 4'h6 ? state : _GEN_15; // @[CPU6502Core.scala 104:37 26:22]
  wire [3:0] _GEN_25 = cycle == 4'h5 ? 4'h6 : _GEN_18; // @[CPU6502Core.scala 103:19 99:37]
  wire [15:0] _GEN_26 = cycle == 4'h5 ? regs_pc : _GEN_19; // @[CPU6502Core.scala 22:21 99:37]
  wire [7:0] _GEN_27 = cycle == 4'h5 ? regs_sp : _GEN_20; // @[CPU6502Core.scala 22:21 99:37]
  wire  _GEN_28 = cycle == 4'h5 ? regs_flagI : _GEN_21; // @[CPU6502Core.scala 22:21 99:37]
  wire [2:0] _GEN_29 = cycle == 4'h5 ? state : _GEN_22; // @[CPU6502Core.scala 26:22 99:37]
  wire [15:0] _GEN_30 = cycle == 4'h4 ? 16'hfffc : 16'hfffd; // @[CPU6502Core.scala 92:37 94:24]
  wire [15:0] _GEN_32 = cycle == 4'h4 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 92:37 96:21 29:24]
  wire [3:0] _GEN_33 = cycle == 4'h4 ? 4'h5 : _GEN_25; // @[CPU6502Core.scala 92:37 98:19]
  wire [15:0] _GEN_34 = cycle == 4'h4 ? regs_pc : _GEN_26; // @[CPU6502Core.scala 22:21 92:37]
  wire [7:0] _GEN_35 = cycle == 4'h4 ? regs_sp : _GEN_27; // @[CPU6502Core.scala 22:21 92:37]
  wire  _GEN_36 = cycle == 4'h4 ? regs_flagI : _GEN_28; // @[CPU6502Core.scala 22:21 92:37]
  wire [2:0] _GEN_37 = cycle == 4'h4 ? state : _GEN_29; // @[CPU6502Core.scala 26:22 92:37]
  wire [15:0] _GEN_38 = cycle == 4'h3 ? 16'hfffc : _GEN_30; // @[CPU6502Core.scala 87:37 89:24]
  wire [3:0] _GEN_40 = cycle == 4'h3 ? 4'h4 : _GEN_33; // @[CPU6502Core.scala 87:37 91:19]
  wire [15:0] _GEN_41 = cycle == 4'h3 ? operand : _GEN_32; // @[CPU6502Core.scala 29:24 87:37]
  wire [15:0] _GEN_42 = cycle == 4'h3 ? regs_pc : _GEN_34; // @[CPU6502Core.scala 22:21 87:37]
  wire [7:0] _GEN_43 = cycle == 4'h3 ? regs_sp : _GEN_35; // @[CPU6502Core.scala 22:21 87:37]
  wire  _GEN_44 = cycle == 4'h3 ? regs_flagI : _GEN_36; // @[CPU6502Core.scala 22:21 87:37]
  wire [2:0] _GEN_45 = cycle == 4'h3 ? state : _GEN_37; // @[CPU6502Core.scala 26:22 87:37]
  wire [15:0] _GEN_46 = cycle == 4'h2 ? 16'hfffc : _GEN_38; // @[CPU6502Core.scala 82:37 84:24]
  wire [3:0] _GEN_48 = cycle == 4'h2 ? 4'h3 : _GEN_40; // @[CPU6502Core.scala 82:37 86:19]
  wire [15:0] _GEN_49 = cycle == 4'h2 ? operand : _GEN_41; // @[CPU6502Core.scala 29:24 82:37]
  wire [15:0] _GEN_50 = cycle == 4'h2 ? regs_pc : _GEN_42; // @[CPU6502Core.scala 22:21 82:37]
  wire [7:0] _GEN_51 = cycle == 4'h2 ? regs_sp : _GEN_43; // @[CPU6502Core.scala 22:21 82:37]
  wire  _GEN_52 = cycle == 4'h2 ? regs_flagI : _GEN_44; // @[CPU6502Core.scala 22:21 82:37]
  wire [2:0] _GEN_53 = cycle == 4'h2 ? state : _GEN_45; // @[CPU6502Core.scala 26:22 82:37]
  wire [15:0] _GEN_54 = cycle == 4'h1 ? 16'hfffc : _GEN_46; // @[CPU6502Core.scala 77:37 79:24]
  wire [3:0] _GEN_56 = cycle == 4'h1 ? 4'h2 : _GEN_48; // @[CPU6502Core.scala 77:37 81:19]
  wire [15:0] _GEN_57 = cycle == 4'h1 ? operand : _GEN_49; // @[CPU6502Core.scala 29:24 77:37]
  wire [15:0] _GEN_58 = cycle == 4'h1 ? regs_pc : _GEN_50; // @[CPU6502Core.scala 22:21 77:37]
  wire [7:0] _GEN_59 = cycle == 4'h1 ? regs_sp : _GEN_51; // @[CPU6502Core.scala 22:21 77:37]
  wire  _GEN_60 = cycle == 4'h1 ? regs_flagI : _GEN_52; // @[CPU6502Core.scala 22:21 77:37]
  wire [2:0] _GEN_61 = cycle == 4'h1 ? state : _GEN_53; // @[CPU6502Core.scala 26:22 77:37]
  wire [15:0] _GEN_62 = cycle == 4'h0 ? 16'hfffc : _GEN_54; // @[CPU6502Core.scala 73:31 74:24]
  wire  _T_18 = 3'h1 == state; // @[CPU6502Core.scala 70:19]
  wire [15:0] _regs_pc_T_1 = regs_pc + 16'h1; // @[CPU6502Core.scala 166:34]
  wire [2:0] _GEN_72 = _T_8 ? 3'h4 : 3'h0; // @[CPU6502Core.scala 156:39 160:21 167:21]
  wire [7:0] _GEN_73 = _T_8 ? opcode : io_memDataIn; // @[CPU6502Core.scala 156:39 165:22 28:24]
  wire [15:0] _GEN_74 = _T_8 ? regs_pc : _regs_pc_T_1; // @[CPU6502Core.scala 156:39 22:21 166:23]
  wire [2:0] _GEN_75 = _T_8 ? state : 3'h2; // @[CPU6502Core.scala 156:39 168:21 26:22]
  wire [2:0] _GEN_78 = _T_7 ? 3'h3 : _GEN_72; // @[CPU6502Core.scala 151:39 155:21]
  wire [7:0] _GEN_79 = _T_7 ? opcode : _GEN_73; // @[CPU6502Core.scala 151:39 28:24]
  wire [15:0] _GEN_80 = _T_7 ? regs_pc : _GEN_74; // @[CPU6502Core.scala 151:39 22:21]
  wire [2:0] _GEN_81 = _T_7 ? state : _GEN_75; // @[CPU6502Core.scala 151:39 26:22]
  wire [2:0] _GEN_84 = _T_6 ? 3'h2 : _GEN_78; // @[CPU6502Core.scala 146:39 150:21]
  wire [7:0] _GEN_85 = _T_6 ? opcode : _GEN_79; // @[CPU6502Core.scala 146:39 28:24]
  wire [15:0] _GEN_86 = _T_6 ? regs_pc : _GEN_80; // @[CPU6502Core.scala 146:39 22:21]
  wire [2:0] _GEN_87 = _T_6 ? state : _GEN_81; // @[CPU6502Core.scala 146:39 26:22]
  wire [2:0] _GEN_90 = _T_5 ? 3'h1 : _GEN_84; // @[CPU6502Core.scala 141:33 145:21]
  wire [7:0] _GEN_91 = _T_5 ? opcode : _GEN_85; // @[CPU6502Core.scala 141:33 28:24]
  wire [15:0] _GEN_92 = _T_5 ? regs_pc : _GEN_86; // @[CPU6502Core.scala 141:33 22:21]
  wire [2:0] _GEN_93 = _T_5 ? state : _GEN_87; // @[CPU6502Core.scala 141:33 26:22]
  wire [2:0] _GEN_94 = nmiPending ? 3'h0 : _GEN_90; // @[CPU6502Core.scala 136:28 137:19]
  wire [2:0] _GEN_95 = nmiPending ? 3'h3 : _GEN_93; // @[CPU6502Core.scala 136:28 138:19]
  wire  _GEN_97 = nmiPending ? 1'h0 : 1'h1; // @[CPU6502Core.scala 136:28 53:17]
  wire [7:0] _GEN_98 = nmiPending ? opcode : _GEN_91; // @[CPU6502Core.scala 136:28 28:24]
  wire [15:0] _GEN_99 = nmiPending ? regs_pc : _GEN_92; // @[CPU6502Core.scala 136:28 22:21]
  wire  _T_23 = 3'h2 == state; // @[CPU6502Core.scala 70:19]
  wire  _execResult_T = 8'h18 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_1 = 8'h38 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_2 = 8'hd8 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_3 = 8'hf8 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_4 = 8'h58 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_5 = 8'h78 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_6 = 8'hb8 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_14 = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 == opcode | 8'h78
     == opcode | 8'hb8 == opcode | 8'hea == opcode; // @[CPU6502Core.scala 279:20]
  wire  _GEN_100 = _execResult_T_6 ? 1'h0 : regs_flagV; // @[Flag.scala 14:13 25:20 32:34]
  wire  _GEN_101 = _execResult_T_5 | regs_flagI; // @[Flag.scala 14:13 25:20 31:34]
  wire  _GEN_102 = _execResult_T_5 ? regs_flagV : _GEN_100; // @[Flag.scala 14:13 25:20]
  wire  _GEN_103 = _execResult_T_4 ? 1'h0 : _GEN_101; // @[Flag.scala 25:20 30:34]
  wire  _GEN_104 = _execResult_T_4 ? regs_flagV : _GEN_102; // @[Flag.scala 14:13 25:20]
  wire  _GEN_105 = _execResult_T_3 | regs_flagD; // @[Flag.scala 14:13 25:20 29:34]
  wire  _GEN_106 = _execResult_T_3 ? regs_flagI : _GEN_103; // @[Flag.scala 14:13 25:20]
  wire  _GEN_107 = _execResult_T_3 ? regs_flagV : _GEN_104; // @[Flag.scala 14:13 25:20]
  wire  _GEN_108 = _execResult_T_2 ? 1'h0 : _GEN_105; // @[Flag.scala 25:20 28:34]
  wire  _GEN_109 = _execResult_T_2 ? regs_flagI : _GEN_106; // @[Flag.scala 14:13 25:20]
  wire  _GEN_110 = _execResult_T_2 ? regs_flagV : _GEN_107; // @[Flag.scala 14:13 25:20]
  wire  _GEN_111 = _execResult_T_1 | regs_flagC; // @[Flag.scala 14:13 25:20 27:34]
  wire  _GEN_112 = _execResult_T_1 ? regs_flagD : _GEN_108; // @[Flag.scala 14:13 25:20]
  wire  _GEN_113 = _execResult_T_1 ? regs_flagI : _GEN_109; // @[Flag.scala 14:13 25:20]
  wire  _GEN_114 = _execResult_T_1 ? regs_flagV : _GEN_110; // @[Flag.scala 14:13 25:20]
  wire  execResult_result_newRegs_flagC = _execResult_T ? 1'h0 : _GEN_111; // @[Flag.scala 25:20 26:34]
  wire  execResult_result_newRegs_flagD = _execResult_T ? regs_flagD : _GEN_112; // @[Flag.scala 14:13 25:20]
  wire  execResult_result_newRegs_flagI = _execResult_T ? regs_flagI : _GEN_113; // @[Flag.scala 14:13 25:20]
  wire  execResult_result_newRegs_flagV = _execResult_T ? regs_flagV : _GEN_114; // @[Flag.scala 14:13 25:20]
  wire  _execResult_T_15 = 8'haa == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_16 = 8'ha8 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_17 = 8'h8a == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_18 = 8'h98 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_19 = 8'hba == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_20 = 8'h9a == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_25 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_result_newRegs_flagZ_T = regs_a == 8'h0; // @[Transfer.scala 29:33]
  wire [7:0] _GEN_119 = _execResult_T_20 ? regs_x : regs_sp; // @[Transfer.scala 14:13 25:20 52:20]
  wire [7:0] _GEN_120 = _execResult_T_19 ? regs_sp : regs_x; // @[Transfer.scala 14:13 25:20 47:19]
  wire  _GEN_121 = _execResult_T_19 ? regs_sp[7] : regs_flagN; // @[Transfer.scala 14:13 25:20 48:23]
  wire  _GEN_122 = _execResult_T_19 ? regs_sp == 8'h0 : regs_flagZ; // @[Transfer.scala 14:13 25:20 49:23]
  wire [7:0] _GEN_123 = _execResult_T_19 ? regs_sp : _GEN_119; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_124 = _execResult_T_18 ? regs_y : regs_a; // @[Transfer.scala 14:13 25:20 42:19]
  wire  _GEN_125 = _execResult_T_18 ? regs_y[7] : _GEN_121; // @[Transfer.scala 25:20 43:23]
  wire  _GEN_126 = _execResult_T_18 ? regs_y == 8'h0 : _GEN_122; // @[Transfer.scala 25:20 44:23]
  wire [7:0] _GEN_127 = _execResult_T_18 ? regs_x : _GEN_120; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_128 = _execResult_T_18 ? regs_sp : _GEN_123; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_129 = _execResult_T_17 ? regs_x : _GEN_124; // @[Transfer.scala 25:20 37:19]
  wire  _GEN_130 = _execResult_T_17 ? regs_x[7] : _GEN_125; // @[Transfer.scala 25:20 38:23]
  wire  _GEN_131 = _execResult_T_17 ? regs_x == 8'h0 : _GEN_126; // @[Transfer.scala 25:20 39:23]
  wire [7:0] _GEN_132 = _execResult_T_17 ? regs_x : _GEN_127; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_133 = _execResult_T_17 ? regs_sp : _GEN_128; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_134 = _execResult_T_16 ? regs_a : regs_y; // @[Transfer.scala 14:13 25:20 32:19]
  wire  _GEN_135 = _execResult_T_16 ? regs_a[7] : _GEN_130; // @[Transfer.scala 25:20 33:23]
  wire  _GEN_136 = _execResult_T_16 ? _execResult_result_newRegs_flagZ_T : _GEN_131; // @[Transfer.scala 25:20 34:23]
  wire [7:0] _GEN_137 = _execResult_T_16 ? regs_a : _GEN_129; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_138 = _execResult_T_16 ? regs_x : _GEN_132; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_139 = _execResult_T_16 ? regs_sp : _GEN_133; // @[Transfer.scala 14:13 25:20]
  wire [7:0] execResult_result_newRegs_1_x = _execResult_T_15 ? regs_a : _GEN_138; // @[Transfer.scala 25:20 27:19]
  wire  execResult_result_newRegs_1_flagN = _execResult_T_15 ? regs_a[7] : _GEN_135; // @[Transfer.scala 25:20 28:23]
  wire  execResult_result_newRegs_1_flagZ = _execResult_T_15 ? regs_a == 8'h0 : _GEN_136; // @[Transfer.scala 25:20 29:23]
  wire [7:0] execResult_result_newRegs_1_y = _execResult_T_15 ? regs_y : _GEN_134; // @[Transfer.scala 14:13 25:20]
  wire [7:0] execResult_result_newRegs_1_a = _execResult_T_15 ? regs_a : _GEN_137; // @[Transfer.scala 14:13 25:20]
  wire [7:0] execResult_result_newRegs_1_sp = _execResult_T_15 ? regs_sp : _GEN_139; // @[Transfer.scala 14:13 25:20]
  wire  _execResult_T_26 = 8'he8 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_27 = 8'hc8 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_28 = 8'hca == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_29 = 8'h88 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_30 = 8'h1a == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_31 = 8'h3a == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_36 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] execResult_result_res = regs_x + 8'h1; // @[Arithmetic.scala 56:26]
  wire [7:0] execResult_result_res_1 = regs_y + 8'h1; // @[Arithmetic.scala 62:26]
  wire [7:0] execResult_result_res_2 = regs_x - 8'h1; // @[Arithmetic.scala 68:26]
  wire [7:0] execResult_result_res_3 = regs_y - 8'h1; // @[Arithmetic.scala 74:26]
  wire [7:0] execResult_result_res_4 = regs_a + 8'h1; // @[Arithmetic.scala 80:26]
  wire [7:0] execResult_result_res_5 = regs_a - 8'h1; // @[Arithmetic.scala 86:26]
  wire [7:0] _GEN_146 = _execResult_T_31 ? execResult_result_res_5 : regs_a; // @[Arithmetic.scala 43:13 54:20 87:19]
  wire  _GEN_147 = _execResult_T_31 ? execResult_result_res_5[7] : regs_flagN; // @[Arithmetic.scala 43:13 54:20 88:23]
  wire  _GEN_148 = _execResult_T_31 ? execResult_result_res_5 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 43:13 54:20 89:23]
  wire [7:0] _GEN_149 = _execResult_T_30 ? execResult_result_res_4 : _GEN_146; // @[Arithmetic.scala 54:20 81:19]
  wire  _GEN_150 = _execResult_T_30 ? execResult_result_res_4[7] : _GEN_147; // @[Arithmetic.scala 54:20 82:23]
  wire  _GEN_151 = _execResult_T_30 ? execResult_result_res_4 == 8'h0 : _GEN_148; // @[Arithmetic.scala 54:20 83:23]
  wire [7:0] _GEN_152 = _execResult_T_29 ? execResult_result_res_3 : regs_y; // @[Arithmetic.scala 43:13 54:20 75:19]
  wire  _GEN_153 = _execResult_T_29 ? execResult_result_res_3[7] : _GEN_150; // @[Arithmetic.scala 54:20 76:23]
  wire  _GEN_154 = _execResult_T_29 ? execResult_result_res_3 == 8'h0 : _GEN_151; // @[Arithmetic.scala 54:20 77:23]
  wire [7:0] _GEN_155 = _execResult_T_29 ? regs_a : _GEN_149; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] _GEN_156 = _execResult_T_28 ? execResult_result_res_2 : regs_x; // @[Arithmetic.scala 43:13 54:20 69:19]
  wire  _GEN_157 = _execResult_T_28 ? execResult_result_res_2[7] : _GEN_153; // @[Arithmetic.scala 54:20 70:23]
  wire  _GEN_158 = _execResult_T_28 ? execResult_result_res_2 == 8'h0 : _GEN_154; // @[Arithmetic.scala 54:20 71:23]
  wire [7:0] _GEN_159 = _execResult_T_28 ? regs_y : _GEN_152; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] _GEN_160 = _execResult_T_28 ? regs_a : _GEN_155; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] _GEN_161 = _execResult_T_27 ? execResult_result_res_1 : _GEN_159; // @[Arithmetic.scala 54:20 63:19]
  wire  _GEN_162 = _execResult_T_27 ? execResult_result_res_1[7] : _GEN_157; // @[Arithmetic.scala 54:20 64:23]
  wire  _GEN_163 = _execResult_T_27 ? execResult_result_res_1 == 8'h0 : _GEN_158; // @[Arithmetic.scala 54:20 65:23]
  wire [7:0] _GEN_164 = _execResult_T_27 ? regs_x : _GEN_156; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] _GEN_165 = _execResult_T_27 ? regs_a : _GEN_160; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] execResult_result_newRegs_2_x = _execResult_T_26 ? execResult_result_res : _GEN_164; // @[Arithmetic.scala 54:20 57:19]
  wire  execResult_result_newRegs_2_flagN = _execResult_T_26 ? execResult_result_res[7] : _GEN_162; // @[Arithmetic.scala 54:20 58:23]
  wire  execResult_result_newRegs_2_flagZ = _execResult_T_26 ? execResult_result_res == 8'h0 : _GEN_163; // @[Arithmetic.scala 54:20 59:23]
  wire [7:0] execResult_result_newRegs_2_y = _execResult_T_26 ? regs_y : _GEN_161; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] execResult_result_newRegs_2_a = _execResult_T_26 ? regs_a : _GEN_165; // @[Arithmetic.scala 43:13 54:20]
  wire  _execResult_T_37 = 8'h69 == opcode; // @[CPU6502Core.scala 279:20]
  wire [8:0] _execResult_result_sum_T = regs_a + io_memDataIn; // @[Arithmetic.scala 103:22]
  wire [8:0] _GEN_4330 = {{8'd0}, regs_flagC}; // @[Arithmetic.scala 103:35]
  wire [9:0] execResult_result_sum = _execResult_result_sum_T + _GEN_4330; // @[Arithmetic.scala 103:35]
  wire [7:0] execResult_result_newRegs_3_a = execResult_result_sum[7:0]; // @[Arithmetic.scala 104:21]
  wire  execResult_result_newRegs_3_flagC = execResult_result_sum[8]; // @[Arithmetic.scala 105:25]
  wire  execResult_result_newRegs_3_flagN = execResult_result_sum[7]; // @[Arithmetic.scala 106:25]
  wire  execResult_result_newRegs_3_flagZ = execResult_result_newRegs_3_a == 8'h0; // @[Arithmetic.scala 107:32]
  wire  execResult_result_newRegs_3_flagV = regs_a[7] == io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_3_flagN; // @[Arithmetic.scala 108:51]
  wire  _execResult_T_38 = 8'he9 == opcode; // @[CPU6502Core.scala 279:20]
  wire [8:0] _execResult_result_diff_T = regs_a - io_memDataIn; // @[Arithmetic.scala 128:23]
  wire  _execResult_result_diff_T_2 = ~regs_flagC; // @[Arithmetic.scala 128:40]
  wire [8:0] _GEN_4331 = {{8'd0}, _execResult_result_diff_T_2}; // @[Arithmetic.scala 128:36]
  wire [9:0] execResult_result_diff = _execResult_result_diff_T - _GEN_4331; // @[Arithmetic.scala 128:36]
  wire [7:0] execResult_result_newRegs_4_a = execResult_result_diff[7:0]; // @[Arithmetic.scala 129:22]
  wire  execResult_result_newRegs_4_flagC = ~execResult_result_diff[8]; // @[Arithmetic.scala 130:22]
  wire  execResult_result_newRegs_4_flagN = execResult_result_diff[7]; // @[Arithmetic.scala 131:26]
  wire  execResult_result_newRegs_4_flagZ = execResult_result_newRegs_4_a == 8'h0; // @[Arithmetic.scala 132:33]
  wire  execResult_result_newRegs_4_flagV = regs_a[7] != io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 133:51]
  wire  _execResult_T_41 = 8'h65 == opcode | 8'he5 == opcode; // @[CPU6502Core.scala 279:20]
  wire [3:0] _execResult_result_result_nextCycle_T_1 = cycle + 4'h1; // @[Arithmetic.scala 372:31]
  wire  _execResult_result_T_20 = 4'h0 == cycle; // @[Arithmetic.scala 380:19]
  wire  _execResult_result_T_21 = 4'h1 == cycle; // @[Arithmetic.scala 380:19]
  wire  _execResult_result_isADC_T_5 = opcode == 8'h6d; // @[Arithmetic.scala 338:25]
  wire  _execResult_result_isADC_T_6 = opcode == 8'h69 | opcode == 8'h65 | opcode == 8'h75 |
    _execResult_result_isADC_T_5; // @[Arithmetic.scala 337:83]
  wire  _execResult_result_isADC_T_7 = opcode == 8'h7d; // @[Arithmetic.scala 338:48]
  wire  _execResult_result_isADC_T_9 = opcode == 8'h79; // @[Arithmetic.scala 338:71]
  wire  _execResult_result_isADC_T_11 = opcode == 8'h61; // @[Arithmetic.scala 339:25]
  wire  _execResult_result_isADC_T_12 = _execResult_result_isADC_T_6 | opcode == 8'h7d | opcode == 8'h79 |
    _execResult_result_isADC_T_11; // @[Arithmetic.scala 338:83]
  wire  execResult_result_isADC = _execResult_result_isADC_T_12 | opcode == 8'h71; // @[Arithmetic.scala 339:37]
  wire [7:0] execResult_result_res_6 = execResult_result_isADC ? execResult_result_newRegs_3_a :
    execResult_result_newRegs_4_a; // @[Arithmetic.scala 346:17 349:14 356:14]
  wire  execResult_result_flagC = execResult_result_isADC ? execResult_result_newRegs_3_flagC :
    execResult_result_newRegs_4_flagC; // @[Arithmetic.scala 346:17 350:13 357:13]
  wire  execResult_result_flagN = execResult_result_isADC ? execResult_result_newRegs_3_flagN :
    execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 346:17 351:13 358:13]
  wire  execResult_result_flagV = execResult_result_isADC ? execResult_result_newRegs_3_flagV :
    execResult_result_newRegs_4_flagV; // @[Arithmetic.scala 346:17 352:13 359:13]
  wire  _execResult_result_newRegs_flagZ_T_15 = execResult_result_res_6 == 8'h0; // @[Arithmetic.scala 396:30]
  wire [15:0] _GEN_175 = 4'h1 == cycle ? operand : 16'h0; // @[Arithmetic.scala 380:19 374:20 389:24]
  wire [7:0] _GEN_177 = 4'h1 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 369:13 380:19 392:19]
  wire  _GEN_178 = 4'h1 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 369:13 380:19 393:23]
  wire  _GEN_179 = 4'h1 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 369:13 380:19 394:23]
  wire  _GEN_180 = 4'h1 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 369:13 380:19 395:23]
  wire  _GEN_181 = 4'h1 == cycle ? execResult_result_res_6 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 369:13 380:19 396:23]
  wire [7:0] execResult_result_newRegs_5_a = 4'h0 == cycle ? regs_a : _GEN_177; // @[Arithmetic.scala 369:13 380:19]
  wire [15:0] execResult_result_newRegs_5_pc = 4'h0 == cycle ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 369:13 380:19 385:20]
  wire  execResult_result_newRegs_5_flagC = 4'h0 == cycle ? regs_flagC : _GEN_178; // @[Arithmetic.scala 369:13 380:19]
  wire  execResult_result_newRegs_5_flagZ = 4'h0 == cycle ? regs_flagZ : _GEN_181; // @[Arithmetic.scala 369:13 380:19]
  wire  execResult_result_newRegs_5_flagV = 4'h0 == cycle ? regs_flagV : _GEN_179; // @[Arithmetic.scala 369:13 380:19]
  wire  execResult_result_newRegs_5_flagN = 4'h0 == cycle ? regs_flagN : _GEN_180; // @[Arithmetic.scala 369:13 380:19]
  wire [15:0] execResult_result_result_6_memAddr = 4'h0 == cycle ? regs_pc : _GEN_175; // @[Arithmetic.scala 380:19 382:24]
  wire  execResult_result_result_6_memRead = 4'h0 == cycle | 4'h1 == cycle; // @[Arithmetic.scala 380:19 383:24]
  wire [15:0] execResult_result_result_6_operand = 4'h0 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Arithmetic.scala 380:19 378:20 384:24]
  wire  execResult_result_result_6_done = 4'h0 == cycle ? 1'h0 : 4'h1 == cycle; // @[Arithmetic.scala 371:17 380:19]
  wire  _execResult_T_44 = 8'h75 == opcode | 8'hf5 == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] _execResult_result_result_operand_T_1 = io_memDataIn + regs_x; // @[Arithmetic.scala 424:38]
  wire [15:0] execResult_result_result_7_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : operand; // @[Arithmetic.scala 420:19 418:20 424:24]
  wire  _execResult_T_47 = 8'h6d == opcode | 8'hed == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_result_T_26 = 4'h2 == cycle; // @[Arithmetic.scala 460:19]
  wire [15:0] _GEN_265 = 4'h2 == cycle ? operand : 16'h0; // @[Arithmetic.scala 460:19 454:20 476:24]
  wire [7:0] _GEN_267 = 4'h2 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 449:13 460:19 479:19]
  wire  _GEN_268 = 4'h2 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 449:13 460:19 480:23]
  wire  _GEN_269 = 4'h2 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 449:13 460:19 481:23]
  wire  _GEN_270 = 4'h2 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 449:13 460:19 482:23]
  wire  _GEN_271 = 4'h2 == cycle ? _execResult_result_newRegs_flagZ_T_15 : regs_flagZ; // @[Arithmetic.scala 449:13 460:19 483:23]
  wire [7:0] _GEN_300 = _execResult_result_T_21 ? regs_a : _GEN_267; // @[Arithmetic.scala 449:13 460:19]
  wire [7:0] execResult_result_newRegs_7_a = _execResult_result_T_20 ? regs_a : _GEN_300; // @[Arithmetic.scala 449:13 460:19]
  wire [15:0] _GEN_287 = _execResult_result_T_21 ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 449:13 460:19 472:20]
  wire [15:0] execResult_result_newRegs_7_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_287; // @[Arithmetic.scala 460:19 465:20]
  wire  _GEN_301 = _execResult_result_T_21 ? regs_flagC : _GEN_268; // @[Arithmetic.scala 449:13 460:19]
  wire  execResult_result_newRegs_7_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_301; // @[Arithmetic.scala 449:13 460:19]
  wire  _GEN_304 = _execResult_result_T_21 ? regs_flagZ : _GEN_271; // @[Arithmetic.scala 449:13 460:19]
  wire  execResult_result_newRegs_7_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_304; // @[Arithmetic.scala 449:13 460:19]
  wire  _GEN_302 = _execResult_result_T_21 ? regs_flagV : _GEN_269; // @[Arithmetic.scala 449:13 460:19]
  wire  execResult_result_newRegs_7_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_302; // @[Arithmetic.scala 449:13 460:19]
  wire  _GEN_303 = _execResult_result_T_21 ? regs_flagN : _GEN_270; // @[Arithmetic.scala 449:13 460:19]
  wire  execResult_result_newRegs_7_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_303; // @[Arithmetic.scala 449:13 460:19]
  wire [15:0] _GEN_284 = _execResult_result_T_21 ? regs_pc : _GEN_265; // @[Arithmetic.scala 460:19 469:24]
  wire  _GEN_285 = _execResult_result_T_21 | 4'h2 == cycle; // @[Arithmetic.scala 460:19 470:24]
  wire [15:0] _GEN_286 = _execResult_result_T_21 ? resetVector : operand; // @[Arithmetic.scala 460:19 458:20 471:24]
  wire  _GEN_305 = _execResult_result_T_21 ? 1'h0 : 4'h2 == cycle; // @[Arithmetic.scala 451:17 460:19]
  wire [15:0] execResult_result_result_8_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_284; // @[Arithmetic.scala 460:19 462:24]
  wire  execResult_result_result_8_memRead = _execResult_result_T_20 | _GEN_285; // @[Arithmetic.scala 460:19 463:24]
  wire [15:0] execResult_result_result_8_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_286; // @[Arithmetic.scala 460:19 464:24]
  wire  execResult_result_result_8_done = _execResult_result_T_20 ? 1'h0 : _GEN_305; // @[Arithmetic.scala 451:17 460:19]
  wire  _execResult_T_50 = 8'h61 == opcode | 8'he1 == opcode; // @[CPU6502Core.scala 279:20]
  wire [15:0] _execResult_result_result_operand_T_9 = {operand[15:8],io_memDataIn}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_result_memAddr_T_3 = operand[7:0] + 8'h1; // @[Arithmetic.scala 521:42]
  wire  _execResult_result_T_30 = 4'h3 == cycle; // @[Arithmetic.scala 507:19]
  wire [15:0] _GEN_332 = 4'h3 == cycle ? operand : 16'h0; // @[Arithmetic.scala 507:19 501:20 526:24]
  wire [7:0] _GEN_334 = 4'h3 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 496:13 507:19 529:19]
  wire  _GEN_335 = 4'h3 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 496:13 507:19 530:23]
  wire  _GEN_336 = 4'h3 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 496:13 507:19 531:23]
  wire  _GEN_337 = 4'h3 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 496:13 507:19 532:23]
  wire  _GEN_338 = 4'h3 == cycle ? _execResult_result_newRegs_flagZ_T_15 : regs_flagZ; // @[Arithmetic.scala 496:13 507:19 533:23]
  wire [7:0] _GEN_354 = _execResult_result_T_26 ? regs_a : _GEN_334; // @[Arithmetic.scala 496:13 507:19]
  wire [7:0] _GEN_375 = _execResult_result_T_21 ? regs_a : _GEN_354; // @[Arithmetic.scala 496:13 507:19]
  wire [7:0] execResult_result_newRegs_8_a = _execResult_result_T_20 ? regs_a : _GEN_375; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_355 = _execResult_result_T_26 ? regs_flagC : _GEN_335; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_376 = _execResult_result_T_21 ? regs_flagC : _GEN_355; // @[Arithmetic.scala 496:13 507:19]
  wire  execResult_result_newRegs_8_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_376; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_358 = _execResult_result_T_26 ? regs_flagZ : _GEN_338; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_379 = _execResult_result_T_21 ? regs_flagZ : _GEN_358; // @[Arithmetic.scala 496:13 507:19]
  wire  execResult_result_newRegs_8_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_379; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_356 = _execResult_result_T_26 ? regs_flagV : _GEN_336; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_377 = _execResult_result_T_21 ? regs_flagV : _GEN_356; // @[Arithmetic.scala 496:13 507:19]
  wire  execResult_result_newRegs_8_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_377; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_357 = _execResult_result_T_26 ? regs_flagN : _GEN_337; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_378 = _execResult_result_T_21 ? regs_flagN : _GEN_357; // @[Arithmetic.scala 496:13 507:19]
  wire  execResult_result_newRegs_8_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_378; // @[Arithmetic.scala 496:13 507:19]
  wire [15:0] _GEN_351 = _execResult_result_T_26 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_332; // @[Arithmetic.scala 507:19 521:24]
  wire  _GEN_352 = _execResult_result_T_26 | 4'h3 == cycle; // @[Arithmetic.scala 507:19 522:24]
  wire [15:0] _GEN_353 = _execResult_result_T_26 ? resetVector : operand; // @[Arithmetic.scala 507:19 505:20 523:24]
  wire  _GEN_371 = _execResult_result_T_26 ? 1'h0 : 4'h3 == cycle; // @[Arithmetic.scala 498:17 507:19]
  wire [15:0] _GEN_372 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_351; // @[Arithmetic.scala 507:19 516:24]
  wire  _GEN_373 = _execResult_result_T_21 | _GEN_352; // @[Arithmetic.scala 507:19 517:24]
  wire [15:0] _GEN_374 = _execResult_result_T_21 ? _execResult_result_result_operand_T_9 : _GEN_353; // @[Arithmetic.scala 507:19 518:24]
  wire  _GEN_392 = _execResult_result_T_21 ? 1'h0 : _GEN_371; // @[Arithmetic.scala 498:17 507:19]
  wire [15:0] execResult_result_result_9_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_372; // @[Arithmetic.scala 507:19 509:24]
  wire  execResult_result_result_9_memRead = _execResult_result_T_20 | _GEN_373; // @[Arithmetic.scala 507:19 510:24]
  wire [15:0] execResult_result_result_9_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : _GEN_374; // @[Arithmetic.scala 507:19 511:24]
  wire  execResult_result_result_9_done = _execResult_result_T_20 ? 1'h0 : _GEN_392; // @[Arithmetic.scala 498:17 507:19]
  wire  _execResult_T_53 = 8'h71 == opcode | 8'hf1 == opcode; // @[CPU6502Core.scala 279:20]
  wire [15:0] _GEN_4340 = {{8'd0}, regs_y}; // @[Arithmetic.scala 573:57]
  wire [15:0] _execResult_result_result_operand_T_17 = resetVector + _GEN_4340; // @[Arithmetic.scala 573:57]
  wire [15:0] _GEN_440 = _execResult_result_T_26 ? _execResult_result_result_operand_T_17 : operand; // @[Arithmetic.scala 557:19 555:20 573:24]
  wire [15:0] _GEN_461 = _execResult_result_T_21 ? _execResult_result_result_operand_T_9 : _GEN_440; // @[Arithmetic.scala 557:19 568:24]
  wire [15:0] execResult_result_result_10_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_461; // @[Arithmetic.scala 557:19 561:24]
  wire  _execResult_T_56 = 8'he6 == opcode | 8'hc6 == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] _execResult_result_res_T_8 = io_memDataIn + 8'h1; // @[Arithmetic.scala 178:52]
  wire [7:0] _execResult_result_res_T_10 = io_memDataIn - 8'h1; // @[Arithmetic.scala 178:69]
  wire [7:0] execResult_result_res_11 = opcode == 8'he6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 178:22]
  wire [7:0] _GEN_503 = _execResult_result_T_26 ? execResult_result_res_11 : 8'h0; // @[Arithmetic.scala 162:19 157:20 179:24]
  wire  _GEN_505 = _execResult_result_T_26 ? execResult_result_res_11[7] : regs_flagN; // @[Arithmetic.scala 151:13 162:19 181:23]
  wire  _GEN_506 = _execResult_result_T_26 ? execResult_result_res_11 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 151:13 162:19 182:23]
  wire  _GEN_525 = _execResult_result_T_21 ? regs_flagZ : _GEN_506; // @[Arithmetic.scala 151:13 162:19]
  wire  execResult_result_newRegs_10_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_525; // @[Arithmetic.scala 151:13 162:19]
  wire  _GEN_524 = _execResult_result_T_21 ? regs_flagN : _GEN_505; // @[Arithmetic.scala 151:13 162:19]
  wire  execResult_result_newRegs_10_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_524; // @[Arithmetic.scala 151:13 162:19]
  wire [15:0] _GEN_519 = _execResult_result_T_21 ? operand : _GEN_265; // @[Arithmetic.scala 162:19 172:24]
  wire [3:0] _GEN_521 = _execResult_result_T_21 ? 4'h2 : _execResult_result_result_nextCycle_T_1; // @[Arithmetic.scala 162:19 154:22 174:26]
  wire [7:0] _GEN_522 = _execResult_result_T_21 ? 8'h0 : _GEN_503; // @[Arithmetic.scala 162:19 157:20]
  wire [15:0] execResult_result_result_11_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_519; // @[Arithmetic.scala 162:19 164:24]
  wire [3:0] _GEN_554 = _execResult_result_T_20 ? 4'h1 : _GEN_521; // @[Arithmetic.scala 162:19 169:26]
  wire [7:0] execResult_result_result_11_memData = _execResult_result_T_20 ? 8'h0 : _GEN_522; // @[Arithmetic.scala 162:19 157:20]
  wire  _execResult_T_59 = 8'hf6 == opcode | 8'hd6 == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] execResult_result_res_12 = opcode == 8'hf6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 220:22]
  wire [7:0] _GEN_560 = _execResult_result_T_26 ? execResult_result_res_12 : 8'h0; // @[Arithmetic.scala 206:19 201:20 221:24]
  wire  _GEN_562 = _execResult_result_T_26 ? execResult_result_res_12[7] : regs_flagN; // @[Arithmetic.scala 195:13 206:19 223:23]
  wire  _GEN_563 = _execResult_result_T_26 ? execResult_result_res_12 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 195:13 206:19 224:23]
  wire  _GEN_581 = _execResult_result_T_21 ? regs_flagZ : _GEN_563; // @[Arithmetic.scala 195:13 206:19]
  wire  execResult_result_newRegs_11_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_581; // @[Arithmetic.scala 195:13 206:19]
  wire  _GEN_580 = _execResult_result_T_21 ? regs_flagN : _GEN_562; // @[Arithmetic.scala 195:13 206:19]
  wire  execResult_result_newRegs_11_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_580; // @[Arithmetic.scala 195:13 206:19]
  wire [7:0] _GEN_578 = _execResult_result_T_21 ? 8'h0 : _GEN_560; // @[Arithmetic.scala 206:19 201:20]
  wire [7:0] execResult_result_result_12_memData = _execResult_result_T_20 ? 8'h0 : _GEN_578; // @[Arithmetic.scala 206:19 201:20]
  wire  _execResult_T_62 = 8'hee == opcode | 8'hce == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] execResult_result_res_13 = opcode == 8'hee ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 273:22]
  wire [7:0] _GEN_615 = _execResult_result_T_30 ? execResult_result_res_13 : 8'h0; // @[Arithmetic.scala 248:19 243:20 274:24]
  wire  _GEN_617 = _execResult_result_T_30 ? execResult_result_res_13[7] : regs_flagN; // @[Arithmetic.scala 237:13 248:19 276:23]
  wire  _GEN_618 = _execResult_result_T_30 ? execResult_result_res_13 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 237:13 248:19 277:23]
  wire  _GEN_636 = _execResult_result_T_26 ? regs_flagZ : _GEN_618; // @[Arithmetic.scala 237:13 248:19]
  wire  _GEN_668 = _execResult_result_T_21 ? regs_flagZ : _GEN_636; // @[Arithmetic.scala 237:13 248:19]
  wire  execResult_result_newRegs_12_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_668; // @[Arithmetic.scala 237:13 248:19]
  wire  _GEN_635 = _execResult_result_T_26 ? regs_flagN : _GEN_617; // @[Arithmetic.scala 237:13 248:19]
  wire  _GEN_667 = _execResult_result_T_21 ? regs_flagN : _GEN_635; // @[Arithmetic.scala 237:13 248:19]
  wire  execResult_result_newRegs_12_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_667; // @[Arithmetic.scala 237:13 248:19]
  wire [15:0] _GEN_631 = _execResult_result_T_26 ? operand : _GEN_332; // @[Arithmetic.scala 248:19 267:24]
  wire [7:0] _GEN_633 = _execResult_result_T_26 ? 8'h0 : _GEN_615; // @[Arithmetic.scala 248:19 243:20]
  wire [15:0] _GEN_649 = _execResult_result_T_21 ? regs_pc : _GEN_631; // @[Arithmetic.scala 248:19 259:24]
  wire [7:0] _GEN_665 = _execResult_result_T_21 ? 8'h0 : _GEN_633; // @[Arithmetic.scala 248:19 243:20]
  wire [15:0] execResult_result_result_13_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_649; // @[Arithmetic.scala 248:19 251:24]
  wire [7:0] execResult_result_result_13_memData = _execResult_result_T_20 ? 8'h0 : _GEN_665; // @[Arithmetic.scala 248:19 243:20]
  wire  _execResult_T_65 = 8'hfe == opcode | 8'hde == opcode; // @[CPU6502Core.scala 279:20]
  wire [15:0] _GEN_4343 = {{8'd0}, regs_x}; // @[Arithmetic.scala 312:57]
  wire [15:0] _execResult_result_result_operand_T_26 = resetVector + _GEN_4343; // @[Arithmetic.scala 312:57]
  wire [7:0] execResult_result_res_14 = opcode == 8'hfe ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 322:22]
  wire [7:0] _GEN_690 = _execResult_result_T_30 ? execResult_result_res_14 : 8'h0; // @[Arithmetic.scala 301:19 296:20 323:24]
  wire  _GEN_692 = _execResult_result_T_30 ? execResult_result_res_14[7] : regs_flagN; // @[Arithmetic.scala 290:13 301:19 325:23]
  wire  _GEN_693 = _execResult_result_T_30 ? execResult_result_res_14 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 290:13 301:19 326:23]
  wire  _GEN_711 = _execResult_result_T_26 ? regs_flagZ : _GEN_693; // @[Arithmetic.scala 290:13 301:19]
  wire  _GEN_743 = _execResult_result_T_21 ? regs_flagZ : _GEN_711; // @[Arithmetic.scala 290:13 301:19]
  wire  execResult_result_newRegs_13_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_743; // @[Arithmetic.scala 290:13 301:19]
  wire  _GEN_710 = _execResult_result_T_26 ? regs_flagN : _GEN_692; // @[Arithmetic.scala 290:13 301:19]
  wire  _GEN_742 = _execResult_result_T_21 ? regs_flagN : _GEN_710; // @[Arithmetic.scala 290:13 301:19]
  wire  execResult_result_newRegs_13_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_742; // @[Arithmetic.scala 290:13 301:19]
  wire [7:0] _GEN_708 = _execResult_result_T_26 ? 8'h0 : _GEN_690; // @[Arithmetic.scala 301:19 296:20]
  wire [15:0] _GEN_726 = _execResult_result_T_21 ? _execResult_result_result_operand_T_26 : operand; // @[Arithmetic.scala 301:19 299:20 312:24]
  wire [7:0] _GEN_740 = _execResult_result_T_21 ? 8'h0 : _GEN_708; // @[Arithmetic.scala 301:19 296:20]
  wire [15:0] execResult_result_result_14_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_726; // @[Arithmetic.scala 301:19 305:24]
  wire [7:0] execResult_result_result_14_memData = _execResult_result_T_20 ? 8'h0 : _GEN_740; // @[Arithmetic.scala 301:19 296:20]
  wire  _execResult_T_72 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode; // @[CPU6502Core.scala 279:20]
  wire  execResult_result_useY = _execResult_result_isADC_T_9 | opcode == 8'hf9; // @[Arithmetic.scala 608:36]
  wire [7:0] execResult_result_index = execResult_result_useY ? regs_y : regs_x; // @[Arithmetic.scala 609:20]
  wire [15:0] _GEN_4344 = {{8'd0}, execResult_result_index}; // @[Arithmetic.scala 630:28]
  wire [15:0] execResult_result_addr = operand + _GEN_4344; // @[Arithmetic.scala 630:28]
  wire  execResult_result_isADC_5 = _execResult_result_isADC_T_9 | _execResult_result_isADC_T_7; // @[Arithmetic.scala 636:41]
  wire [7:0] _GEN_764 = execResult_result_isADC_5 ? execResult_result_newRegs_3_a : execResult_result_newRegs_4_a; // @[Arithmetic.scala 638:21 641:21 649:21]
  wire  _GEN_765 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagC : execResult_result_newRegs_4_flagC; // @[Arithmetic.scala 638:21 642:25 650:25]
  wire  _GEN_766 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagN : execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 638:21 643:25 651:25]
  wire  _GEN_767 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagZ : execResult_result_newRegs_4_flagZ; // @[Arithmetic.scala 638:21 644:25 652:25]
  wire  _GEN_768 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagV : execResult_result_newRegs_4_flagV; // @[Arithmetic.scala 638:21 645:25 653:25]
  wire [7:0] _GEN_769 = _execResult_result_T_30 ? _GEN_764 : regs_a; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_770 = _execResult_result_T_30 ? _GEN_765 : regs_flagC; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_771 = _execResult_result_T_30 ? _GEN_766 : regs_flagN; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_772 = _execResult_result_T_30 ? _GEN_767 : regs_flagZ; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_773 = _execResult_result_T_30 ? _GEN_768 : regs_flagV; // @[Arithmetic.scala 596:13 611:19]
  wire [7:0] _GEN_789 = _execResult_result_T_26 ? regs_a : _GEN_769; // @[Arithmetic.scala 596:13 611:19]
  wire [7:0] _GEN_823 = _execResult_result_T_21 ? regs_a : _GEN_789; // @[Arithmetic.scala 596:13 611:19]
  wire [7:0] execResult_result_newRegs_14_a = _execResult_result_T_20 ? regs_a : _GEN_823; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_790 = _execResult_result_T_26 ? regs_flagC : _GEN_770; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_824 = _execResult_result_T_21 ? regs_flagC : _GEN_790; // @[Arithmetic.scala 596:13 611:19]
  wire  execResult_result_newRegs_14_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_824; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_792 = _execResult_result_T_26 ? regs_flagZ : _GEN_772; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_826 = _execResult_result_T_21 ? regs_flagZ : _GEN_792; // @[Arithmetic.scala 596:13 611:19]
  wire  execResult_result_newRegs_14_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_826; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_793 = _execResult_result_T_26 ? regs_flagV : _GEN_773; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_827 = _execResult_result_T_21 ? regs_flagV : _GEN_793; // @[Arithmetic.scala 596:13 611:19]
  wire  execResult_result_newRegs_14_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_827; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_791 = _execResult_result_T_26 ? regs_flagN : _GEN_771; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_825 = _execResult_result_T_21 ? regs_flagN : _GEN_791; // @[Arithmetic.scala 596:13 611:19]
  wire  execResult_result_newRegs_14_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_825; // @[Arithmetic.scala 596:13 611:19]
  wire [15:0] _GEN_787 = _execResult_result_T_26 ? execResult_result_addr : 16'h0; // @[Arithmetic.scala 611:19 601:20 631:24]
  wire [15:0] _GEN_807 = _execResult_result_T_21 ? regs_pc : _GEN_787; // @[Arithmetic.scala 611:19 622:24]
  wire [15:0] execResult_result_result_15_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_807; // @[Arithmetic.scala 611:19 614:24]
  wire  _execResult_T_73 = 8'h29 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_74 = 8'h9 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_75 = 8'h49 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_77 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] _execResult_result_res_T_26 = regs_a & io_memDataIn; // @[Logic.scala 32:34]
  wire [7:0] _execResult_result_res_T_27 = regs_a | io_memDataIn; // @[Logic.scala 33:34]
  wire [7:0] _execResult_result_res_T_28 = regs_a ^ io_memDataIn; // @[Logic.scala 34:34]
  wire [7:0] _GEN_851 = _execResult_T_75 ? _execResult_result_res_T_28 : 8'h0; // @[Logic.scala 31:20 34:24 29:9]
  wire [7:0] _GEN_852 = _execResult_T_74 ? _execResult_result_res_T_27 : _GEN_851; // @[Logic.scala 31:20 33:24]
  wire [7:0] execResult_result_res_15 = _execResult_T_73 ? _execResult_result_res_T_26 : _GEN_852; // @[Logic.scala 31:20 32:24]
  wire  execResult_result_newRegs_15_flagN = execResult_result_res_15[7]; // @[Logic.scala 38:25]
  wire  execResult_result_newRegs_15_flagZ = execResult_result_res_15 == 8'h0; // @[Logic.scala 39:26]
  wire  _execResult_T_78 = 8'h24 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_result_newRegs_flagZ_T_30 = _execResult_result_res_T_26 == 8'h0; // @[Logic.scala 80:47]
  wire  _GEN_856 = _execResult_result_T_21 ? _execResult_result_res_T_26 == 8'h0 : regs_flagZ; // @[Logic.scala 57:13 68:19 80:23]
  wire  _GEN_857 = _execResult_result_T_21 ? io_memDataIn[7] : regs_flagN; // @[Logic.scala 57:13 68:19 81:23]
  wire  _GEN_858 = _execResult_result_T_21 ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 57:13 68:19 82:23]
  wire  execResult_result_newRegs_16_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_856; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_16_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_858; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_16_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_857; // @[Logic.scala 57:13 68:19]
  wire [3:0] _GEN_887 = _execResult_result_T_20 ? 4'h1 : _execResult_result_result_nextCycle_T_1; // @[Logic.scala 68:19 60:22 75:26]
  wire  _execResult_T_83 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode; // @[CPU6502Core.scala 279:20]
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
  wire [7:0] _GEN_894 = _execResult_result_T_21 ? execResult_result_res_16 : regs_a; // @[Logic.scala 107:13 118:19 130:19]
  wire  _GEN_895 = _execResult_result_T_21 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 107:13 118:19 131:23]
  wire  _GEN_896 = _execResult_result_T_21 ? execResult_result_res_16 == 8'h0 : regs_flagZ; // @[Logic.scala 107:13 118:19 132:23]
  wire [7:0] execResult_result_newRegs_17_a = _execResult_result_T_20 ? regs_a : _GEN_894; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_17_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_896; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_17_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_895; // @[Logic.scala 107:13 118:19]
  wire  _execResult_T_88 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_95 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode; // @[CPU6502Core.scala 279:20]
  wire  _GEN_966 = opcode == 8'h2c ? _execResult_result_newRegs_flagZ_T_30 : _execResult_result_newRegs_flagZ_T_31; // @[Logic.scala 214:33 215:25 222:25]
  wire  _GEN_967 = opcode == 8'h2c ? io_memDataIn[7] : execResult_result_res_16[7]; // @[Logic.scala 214:33 216:25 221:25]
  wire  _GEN_968 = opcode == 8'h2c ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 183:13 214:33 217:25]
  wire [7:0] _GEN_969 = opcode == 8'h2c ? regs_a : execResult_result_res_16; // @[Logic.scala 183:13 214:33 220:21]
  wire  _GEN_972 = _execResult_result_T_26 ? _GEN_966 : regs_flagZ; // @[Logic.scala 183:13 194:19]
  wire  _GEN_973 = _execResult_result_T_26 ? _GEN_967 : regs_flagN; // @[Logic.scala 183:13 194:19]
  wire  _GEN_974 = _execResult_result_T_26 ? _GEN_968 : regs_flagV; // @[Logic.scala 183:13 194:19]
  wire [7:0] _GEN_975 = _execResult_result_T_26 ? _GEN_969 : regs_a; // @[Logic.scala 183:13 194:19]
  wire [7:0] _GEN_1007 = _execResult_result_T_21 ? regs_a : _GEN_975; // @[Logic.scala 183:13 194:19]
  wire [7:0] execResult_result_newRegs_19_a = _execResult_result_T_20 ? regs_a : _GEN_1007; // @[Logic.scala 183:13 194:19]
  wire  _GEN_1004 = _execResult_result_T_21 ? regs_flagZ : _GEN_972; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1004; // @[Logic.scala 183:13 194:19]
  wire  _GEN_1006 = _execResult_result_T_21 ? regs_flagV : _GEN_974; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_1006; // @[Logic.scala 183:13 194:19]
  wire  _GEN_1005 = _execResult_result_T_21 ? regs_flagN : _GEN_973; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1005; // @[Logic.scala 183:13 194:19]
  wire  _execResult_T_106 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode; // @[CPU6502Core.scala 279:20]
  wire  execResult_result_useY_1 = _execResult_result_res_T_38 | _execResult_result_res_T_54 |
    _execResult_result_res_T_70; // @[Logic.scala 249:59]
  wire [7:0] execResult_result_index_1 = execResult_result_useY_1 ? regs_y : regs_x; // @[Logic.scala 250:20]
  wire [15:0] _GEN_4347 = {{8'd0}, execResult_result_index_1}; // @[Logic.scala 263:57]
  wire [15:0] _execResult_result_result_operand_T_37 = resetVector + _GEN_4347; // @[Logic.scala 263:57]
  wire [7:0] _GEN_1032 = _execResult_result_T_26 ? execResult_result_res_16 : regs_a; // @[Logic.scala 237:13 252:19 271:19]
  wire  _GEN_1033 = _execResult_result_T_26 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 237:13 252:19 272:23]
  wire  _GEN_1034 = _execResult_result_T_26 ? _execResult_result_newRegs_flagZ_T_31 : regs_flagZ; // @[Logic.scala 237:13 252:19 273:23]
  wire [7:0] _GEN_1063 = _execResult_result_T_21 ? regs_a : _GEN_1032; // @[Logic.scala 237:13 252:19]
  wire [7:0] execResult_result_newRegs_20_a = _execResult_result_T_20 ? regs_a : _GEN_1063; // @[Logic.scala 237:13 252:19]
  wire  _GEN_1065 = _execResult_result_T_21 ? regs_flagZ : _GEN_1034; // @[Logic.scala 237:13 252:19]
  wire  execResult_result_newRegs_20_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1065; // @[Logic.scala 237:13 252:19]
  wire  _GEN_1064 = _execResult_result_T_21 ? regs_flagN : _GEN_1033; // @[Logic.scala 237:13 252:19]
  wire  execResult_result_newRegs_20_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1064; // @[Logic.scala 237:13 252:19]
  wire [15:0] _GEN_1049 = _execResult_result_T_21 ? _execResult_result_result_operand_T_37 : operand; // @[Logic.scala 252:19 246:20 263:24]
  wire [15:0] execResult_result_result_21_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_1049; // @[Logic.scala 252:19 256:24]
  wire  _execResult_T_111 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] _GEN_1089 = _execResult_result_T_30 ? execResult_result_res_16 : regs_a; // @[Logic.scala 286:13 297:19 323:19]
  wire  _GEN_1090 = _execResult_result_T_30 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 286:13 297:19 324:23]
  wire  _GEN_1091 = _execResult_result_T_30 ? _execResult_result_newRegs_flagZ_T_31 : regs_flagZ; // @[Logic.scala 286:13 297:19 325:23]
  wire [7:0] _GEN_1107 = _execResult_result_T_26 ? regs_a : _GEN_1089; // @[Logic.scala 286:13 297:19]
  wire [7:0] _GEN_1126 = _execResult_result_T_21 ? regs_a : _GEN_1107; // @[Logic.scala 286:13 297:19]
  wire [7:0] execResult_result_newRegs_21_a = _execResult_result_T_20 ? regs_a : _GEN_1126; // @[Logic.scala 286:13 297:19]
  wire  _GEN_1109 = _execResult_result_T_26 ? regs_flagZ : _GEN_1091; // @[Logic.scala 286:13 297:19]
  wire  _GEN_1128 = _execResult_result_T_21 ? regs_flagZ : _GEN_1109; // @[Logic.scala 286:13 297:19]
  wire  execResult_result_newRegs_21_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1128; // @[Logic.scala 286:13 297:19]
  wire  _GEN_1108 = _execResult_result_T_26 ? regs_flagN : _GEN_1090; // @[Logic.scala 286:13 297:19]
  wire  _GEN_1127 = _execResult_result_T_21 ? regs_flagN : _GEN_1108; // @[Logic.scala 286:13 297:19]
  wire  execResult_result_newRegs_21_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1127; // @[Logic.scala 286:13 297:19]
  wire  _execResult_T_116 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_117 = 8'ha == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_118 = 8'h4a == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_119 = 8'h2a == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_120 = 8'h6a == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_123 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode; // @[CPU6502Core.scala 279:20]
  wire [8:0] _execResult_result_res_T_329 = {regs_a, 1'h0}; // @[Shift.scala 39:24]
  wire [7:0] _execResult_result_res_T_333 = {regs_a[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_335 = {regs_flagC,regs_a[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_1237 = _execResult_T_120 ? regs_a[0] : regs_flagC; // @[Shift.scala 22:13 36:20 50:23]
  wire [7:0] _GEN_1238 = _execResult_T_120 ? _execResult_result_res_T_335 : regs_a; // @[Shift.scala 36:20 51:13 33:9]
  wire  _GEN_1239 = _execResult_T_119 ? regs_a[7] : _GEN_1237; // @[Shift.scala 36:20 46:23]
  wire [7:0] _GEN_1240 = _execResult_T_119 ? _execResult_result_res_T_333 : _GEN_1238; // @[Shift.scala 36:20 47:13]
  wire  _GEN_1241 = _execResult_T_118 ? regs_a[0] : _GEN_1239; // @[Shift.scala 36:20 42:23]
  wire [7:0] _GEN_1242 = _execResult_T_118 ? {{1'd0}, regs_a[7:1]} : _GEN_1240; // @[Shift.scala 36:20 43:13]
  wire  execResult_result_newRegs_23_flagC = _execResult_T_117 ? regs_a[7] : _GEN_1241; // @[Shift.scala 36:20 38:23]
  wire [7:0] execResult_result_res_22 = _execResult_T_117 ? _execResult_result_res_T_329[7:0] : _GEN_1242; // @[Shift.scala 36:20 39:13]
  wire  execResult_result_newRegs_23_flagN = execResult_result_res_22[7]; // @[Shift.scala 56:25]
  wire  execResult_result_newRegs_23_flagZ = execResult_result_res_22 == 8'h0; // @[Shift.scala 57:26]
  wire  _execResult_T_124 = 8'h6 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_125 = 8'h46 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_126 = 8'h26 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_127 = 8'h66 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_130 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode; // @[CPU6502Core.scala 279:20]
  wire [8:0] _execResult_result_res_T_336 = {io_memDataIn, 1'h0}; // @[Shift.scala 99:31]
  wire [7:0] _execResult_result_res_T_340 = {io_memDataIn[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_342 = {regs_flagC,io_memDataIn[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_1245 = _execResult_T_127 ? io_memDataIn[0] : regs_flagC; // @[Shift.scala 96:24 112:27 66:13]
  wire [7:0] _GEN_1246 = _execResult_T_127 ? _execResult_result_res_T_342 : 8'h0; // @[Shift.scala 113:17 94:13 96:24]
  wire  _GEN_1247 = _execResult_T_126 ? io_memDataIn[7] : _GEN_1245; // @[Shift.scala 96:24 107:27]
  wire [7:0] _GEN_1248 = _execResult_T_126 ? _execResult_result_res_T_340 : _GEN_1246; // @[Shift.scala 108:17 96:24]
  wire  _GEN_1249 = _execResult_T_125 ? io_memDataIn[0] : _GEN_1247; // @[Shift.scala 96:24 102:27]
  wire [7:0] _GEN_1250 = _execResult_T_125 ? {{1'd0}, io_memDataIn[7:1]} : _GEN_1248; // @[Shift.scala 103:17 96:24]
  wire  _GEN_1251 = _execResult_T_124 ? io_memDataIn[7] : _GEN_1249; // @[Shift.scala 96:24 98:27]
  wire [7:0] execResult_result_res_23 = _execResult_T_124 ? _execResult_result_res_T_336[7:0] : _GEN_1250; // @[Shift.scala 96:24 99:17]
  wire  _GEN_1254 = _execResult_result_T_26 ? _GEN_1251 : regs_flagC; // @[Shift.scala 66:13 77:19]
  wire [7:0] _GEN_1255 = _execResult_result_T_26 ? execResult_result_res_23 : 8'h0; // @[Shift.scala 77:19 117:24 72:20]
  wire  _GEN_1257 = _execResult_result_T_26 ? execResult_result_res_23[7] : regs_flagN; // @[Shift.scala 77:19 119:23 66:13]
  wire  _GEN_1258 = _execResult_result_T_26 ? execResult_result_res_23 == 8'h0 : regs_flagZ; // @[Shift.scala 77:19 120:23 66:13]
  wire  _GEN_1274 = _execResult_result_T_21 ? regs_flagC : _GEN_1254; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1274; // @[Shift.scala 66:13 77:19]
  wire  _GEN_1278 = _execResult_result_T_21 ? regs_flagZ : _GEN_1258; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1278; // @[Shift.scala 66:13 77:19]
  wire  _GEN_1277 = _execResult_result_T_21 ? regs_flagN : _GEN_1257; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1277; // @[Shift.scala 66:13 77:19]
  wire [7:0] _GEN_1275 = _execResult_result_T_21 ? 8'h0 : _GEN_1255; // @[Shift.scala 77:19 72:20]
  wire [7:0] execResult_result_result_25_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1275; // @[Shift.scala 77:19 72:20]
  wire  _execResult_T_131 = 8'h16 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_132 = 8'h56 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_133 = 8'h36 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_134 = 8'h76 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_137 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_result_T_93 = 8'he == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_94 = 8'h1e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_100 = 8'h4e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_101 = 8'h5e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_107 = 8'h2e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_108 = 8'h3e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_114 = 8'h6e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_115 = 8'h7e == opcode; // @[Shift.scala 138:20]
  wire  _GEN_1313 = (_execResult_T_127 | _execResult_T_134 | 8'h6e == opcode | 8'h7e == opcode) & io_memDataIn[0]; // @[Shift.scala 136:14 138:20 152:18]
  wire [7:0] _GEN_1314 = _execResult_T_127 | _execResult_T_134 | 8'h6e == opcode | 8'h7e == opcode ?
    _execResult_result_res_T_342 : io_memDataIn; // @[Shift.scala 135:12 138:20 153:16]
  wire  _GEN_1315 = _execResult_T_126 | _execResult_T_133 | 8'h2e == opcode | 8'h3e == opcode ? io_memDataIn[7] :
    _GEN_1313; // @[Shift.scala 138:20 148:18]
  wire [7:0] _GEN_1316 = _execResult_T_126 | _execResult_T_133 | 8'h2e == opcode | 8'h3e == opcode ?
    _execResult_result_res_T_340 : _GEN_1314; // @[Shift.scala 138:20 149:16]
  wire  _GEN_1317 = _execResult_T_125 | _execResult_T_132 | 8'h4e == opcode | 8'h5e == opcode ? io_memDataIn[0] :
    _GEN_1315; // @[Shift.scala 138:20 144:18]
  wire [7:0] _GEN_1318 = _execResult_T_125 | _execResult_T_132 | 8'h4e == opcode | 8'h5e == opcode ? {{1'd0},
    io_memDataIn[7:1]} : _GEN_1316; // @[Shift.scala 138:20 145:16]
  wire  execResult_result_newCarry = _execResult_T_124 | _execResult_T_131 | 8'he == opcode | 8'h1e == opcode ?
    io_memDataIn[7] : _GEN_1317; // @[Shift.scala 138:20 140:18]
  wire [7:0] execResult_result_res_24 = _execResult_T_124 | _execResult_T_131 | 8'he == opcode | 8'h1e == opcode ?
    _execResult_result_res_T_336[7:0] : _GEN_1318; // @[Shift.scala 138:20 141:16]
  wire  _execResult_result_newRegs_flagZ_T_41 = execResult_result_res_24 == 8'h0; // @[Shift.scala 194:30]
  wire [7:0] _GEN_1322 = _execResult_result_T_26 ? execResult_result_res_24 : 8'h0; // @[Shift.scala 175:19 170:20 190:24]
  wire  _GEN_1324 = _execResult_result_T_26 ? execResult_result_newCarry : regs_flagC; // @[Shift.scala 164:13 175:19 192:23]
  wire  _GEN_1325 = _execResult_result_T_26 ? execResult_result_res_24[7] : regs_flagN; // @[Shift.scala 164:13 175:19 193:23]
  wire  _GEN_1326 = _execResult_result_T_26 ? execResult_result_res_24 == 8'h0 : regs_flagZ; // @[Shift.scala 164:13 175:19 194:23]
  wire  _GEN_1343 = _execResult_result_T_21 ? regs_flagC : _GEN_1324; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1343; // @[Shift.scala 164:13 175:19]
  wire  _GEN_1345 = _execResult_result_T_21 ? regs_flagZ : _GEN_1326; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1345; // @[Shift.scala 164:13 175:19]
  wire  _GEN_1344 = _execResult_result_T_21 ? regs_flagN : _GEN_1325; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1344; // @[Shift.scala 164:13 175:19]
  wire [7:0] _GEN_1341 = _execResult_result_T_21 ? 8'h0 : _GEN_1322; // @[Shift.scala 175:19 170:20]
  wire [7:0] execResult_result_result_26_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1341; // @[Shift.scala 175:19 170:20]
  wire  _execResult_T_144 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114; // @[CPU6502Core.scala 279:20]
  wire [7:0] _GEN_1388 = _execResult_result_T_30 ? execResult_result_res_24 : 8'h0; // @[Shift.scala 218:19 213:20 240:24]
  wire  _GEN_1390 = _execResult_result_T_30 ? execResult_result_newCarry : regs_flagC; // @[Shift.scala 207:13 218:19 242:23]
  wire  _GEN_1391 = _execResult_result_T_30 ? execResult_result_res_24[7] : regs_flagN; // @[Shift.scala 207:13 218:19 243:23]
  wire  _GEN_1392 = _execResult_result_T_30 ? _execResult_result_newRegs_flagZ_T_41 : regs_flagZ; // @[Shift.scala 207:13 218:19 244:23]
  wire  _GEN_1409 = _execResult_result_T_26 ? regs_flagC : _GEN_1390; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1442 = _execResult_result_T_21 ? regs_flagC : _GEN_1409; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1442; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1411 = _execResult_result_T_26 ? regs_flagZ : _GEN_1392; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1444 = _execResult_result_T_21 ? regs_flagZ : _GEN_1411; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1444; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1410 = _execResult_result_T_26 ? regs_flagN : _GEN_1391; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1443 = _execResult_result_T_21 ? regs_flagN : _GEN_1410; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1443; // @[Shift.scala 207:13 218:19]
  wire [7:0] _GEN_1407 = _execResult_result_T_26 ? 8'h0 : _GEN_1388; // @[Shift.scala 218:19 213:20]
  wire [7:0] _GEN_1440 = _execResult_result_T_21 ? 8'h0 : _GEN_1407; // @[Shift.scala 218:19 213:20]
  wire [7:0] execResult_result_result_27_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1440; // @[Shift.scala 218:19 213:20]
  wire  _execResult_T_151 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_152 = 8'hc9 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_153 = 8'he0 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_154 = 8'hc0 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_156 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] _GEN_1553 = _execResult_T_154 ? regs_y : regs_a; // @[Compare.scala 30:14 32:20 35:29]
  wire [7:0] _GEN_1554 = _execResult_T_153 ? regs_x : _GEN_1553; // @[Compare.scala 32:20 34:29]
  wire [7:0] execResult_result_regValue = _execResult_T_152 ? regs_a : _GEN_1554; // @[Compare.scala 32:20 33:29]
  wire [8:0] execResult_result_diff_7 = execResult_result_regValue - io_memDataIn; // @[Compare.scala 38:25]
  wire  execResult_result_newRegs_28_flagC = execResult_result_regValue >= io_memDataIn; // @[Compare.scala 39:31]
  wire  execResult_result_newRegs_28_flagZ = execResult_result_regValue == io_memDataIn; // @[Compare.scala 40:31]
  wire  execResult_result_newRegs_28_flagN = execResult_result_diff_7[7]; // @[Compare.scala 41:26]
  wire  _execResult_T_161 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_result_regValue_T_4 = opcode == 8'he0 | opcode == 8'he4 | opcode == 8'hec; // @[Compare.scala 97:47]
  wire  _execResult_result_regValue_T_9 = opcode == 8'hc0 | opcode == 8'hc4 | opcode == 8'hcc; // @[Compare.scala 98:47]
  wire [7:0] _execResult_result_regValue_T_10 = _execResult_result_regValue_T_9 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] execResult_result_regValue_1 = _execResult_result_regValue_T_4 ? regs_x : _execResult_result_regValue_T_10; // @[Mux.scala 101:16]
  wire [8:0] execResult_result_diff_8 = execResult_result_regValue_1 - io_memDataIn; // @[Compare.scala 100:25]
  wire  execResult_result_flagC_5 = execResult_result_regValue_1 >= io_memDataIn; // @[Compare.scala 101:26]
  wire  execResult_result_flagZ = execResult_result_regValue_1 == io_memDataIn; // @[Compare.scala 102:26]
  wire  execResult_result_flagN_5 = execResult_result_diff_8[7]; // @[Compare.scala 103:21]
  wire  _GEN_1558 = _execResult_result_T_21 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 111:13 122:19 134:23]
  wire  _GEN_1559 = _execResult_result_T_21 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 111:13 122:19 135:23]
  wire  _GEN_1560 = _execResult_result_T_21 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 111:13 122:19 136:23]
  wire  execResult_result_newRegs_29_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1558; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_29_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1559; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_29_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1560; // @[Compare.scala 111:13 122:19]
  wire  _execResult_T_162 = 8'hd5 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_167 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode; // @[CPU6502Core.scala 279:20]
  wire  _GEN_1632 = _execResult_result_T_26 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 187:13 198:19 217:23]
  wire  _GEN_1633 = _execResult_result_T_26 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 187:13 198:19 218:23]
  wire  _GEN_1634 = _execResult_result_T_26 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 187:13 198:19 219:23]
  wire  _GEN_1663 = _execResult_result_T_21 ? regs_flagC : _GEN_1632; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1663; // @[Compare.scala 187:13 198:19]
  wire  _GEN_1664 = _execResult_result_T_21 ? regs_flagZ : _GEN_1633; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1664; // @[Compare.scala 187:13 198:19]
  wire  _GEN_1665 = _execResult_result_T_21 ? regs_flagN : _GEN_1634; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1665; // @[Compare.scala 187:13 198:19]
  wire  _execResult_T_170 = 8'hdd == opcode | 8'hd9 == opcode; // @[CPU6502Core.scala 279:20]
  wire  execResult_result_useY_2 = opcode == 8'hd9; // @[Compare.scala 243:23]
  wire [7:0] execResult_result_index_2 = execResult_result_useY_2 ? regs_y : regs_x; // @[Compare.scala 244:20]
  wire [15:0] _GEN_4350 = {{8'd0}, execResult_result_index_2}; // @[Compare.scala 257:57]
  wire [15:0] _execResult_result_result_operand_T_68 = resetVector + _GEN_4350; // @[Compare.scala 257:57]
  wire [15:0] _GEN_1706 = _execResult_result_T_21 ? _execResult_result_result_operand_T_68 : operand; // @[Compare.scala 246:19 241:20 257:24]
  wire [15:0] execResult_result_result_33_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_1706; // @[Compare.scala 246:19 250:24]
  wire  _execResult_T_171 = 8'hc1 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _GEN_1746 = _execResult_result_T_30 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 280:13 291:19 313:23]
  wire  _GEN_1747 = _execResult_result_T_30 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 280:13 291:19 314:23]
  wire  _GEN_1748 = _execResult_result_T_30 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 280:13 291:19 315:23]
  wire  _GEN_1764 = _execResult_result_T_26 ? regs_flagC : _GEN_1746; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1783 = _execResult_result_T_21 ? regs_flagC : _GEN_1764; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1783; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1765 = _execResult_result_T_26 ? regs_flagZ : _GEN_1747; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1784 = _execResult_result_T_21 ? regs_flagZ : _GEN_1765; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1784; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1766 = _execResult_result_T_26 ? regs_flagN : _GEN_1748; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1785 = _execResult_result_T_21 ? regs_flagN : _GEN_1766; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1785; // @[Compare.scala 280:13 291:19]
  wire  _execResult_T_172 = 8'hd1 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_173 = 8'hd2 == opcode; // @[CPU6502Core.scala 279:20]
  wire [15:0] execResult_result_result_36_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_374; // @[Compare.scala 387:19 391:24]
  wire  _execResult_T_174 = 8'hf0 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_175 = 8'hd0 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_176 = 8'hb0 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_177 = 8'h90 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_178 = 8'h30 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_179 = 8'h10 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_180 = 8'h50 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_181 = 8'h70 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_188 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _GEN_1969 = _execResult_T_180 & ~regs_flagV; // @[Branch.scala 18:16 20:20 28:31]
  wire  _GEN_1970 = _execResult_T_181 ? regs_flagV : _GEN_1969; // @[Branch.scala 20:20 27:31]
  wire  _GEN_1971 = _execResult_T_179 ? ~regs_flagN : _GEN_1970; // @[Branch.scala 20:20 26:31]
  wire  _GEN_1972 = _execResult_T_178 ? regs_flagN : _GEN_1971; // @[Branch.scala 20:20 25:31]
  wire  _GEN_1973 = _execResult_T_177 ? _execResult_result_diff_T_2 : _GEN_1972; // @[Branch.scala 20:20 24:31]
  wire  _GEN_1974 = _execResult_T_176 ? regs_flagC : _GEN_1973; // @[Branch.scala 20:20 23:31]
  wire  _GEN_1975 = _execResult_T_175 ? ~regs_flagZ : _GEN_1974; // @[Branch.scala 20:20 22:31]
  wire  execResult_result_takeBranch = _execResult_T_174 ? regs_flagZ : _GEN_1975; // @[Branch.scala 20:20 21:31]
  wire [7:0] execResult_result_offset = io_memDataIn; // @[Branch.scala 32:28]
  wire [15:0] _execResult_result_newRegs_pc_T_84 = regs_pc + 16'h1; // @[Branch.scala 36:43]
  wire [15:0] _GEN_4352 = {{8{execResult_result_offset[7]}},execResult_result_offset}; // @[Branch.scala 36:50]
  wire [15:0] _execResult_result_newRegs_pc_T_88 = $signed(_execResult_result_newRegs_pc_T_84) + $signed(_GEN_4352); // @[Branch.scala 36:60]
  wire [15:0] execResult_result_newRegs_36_pc = execResult_result_takeBranch ? _execResult_result_newRegs_pc_T_88 :
    _regs_pc_T_1; // @[Branch.scala 36:22]
  wire  _execResult_T_189 = 8'ha9 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_190 = 8'ha2 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_191 = 8'ha0 == opcode; // @[CPU6502Core.scala 279:20]
  wire  _execResult_T_193 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode; // @[CPU6502Core.scala 279:20]
  wire [7:0] _GEN_1977 = _execResult_T_191 ? io_memDataIn : regs_y; // @[LoadStore.scala 27:13 30:20 33:30]
  wire [7:0] _GEN_1978 = _execResult_T_190 ? io_memDataIn : regs_x; // @[LoadStore.scala 27:13 30:20 32:30]
  wire [7:0] _GEN_1979 = _execResult_T_190 ? regs_y : _GEN_1977; // @[LoadStore.scala 27:13 30:20]
  wire [7:0] execResult_result_newRegs_37_a = _execResult_T_189 ? io_memDataIn : regs_a; // @[LoadStore.scala 27:13 30:20 31:30]
  wire [7:0] execResult_result_newRegs_37_x = _execResult_T_189 ? regs_x : _GEN_1978; // @[LoadStore.scala 27:13 30:20]
  wire [7:0] execResult_result_newRegs_37_y = _execResult_T_189 ? regs_y : _GEN_1979; // @[LoadStore.scala 27:13 30:20]
  wire  execResult_result_newRegs_37_flagZ = io_memDataIn == 8'h0; // @[LoadStore.scala 37:32]
  wire  _execResult_T_204 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode; // @[CPU6502Core.scala 279:20]
  wire  execResult_result_isLoadA = opcode == 8'ha5; // @[LoadStore.scala 66:26]
  wire  execResult_result_isLoadX = opcode == 8'ha6; // @[LoadStore.scala 67:26]
  wire  execResult_result_isLoadY = opcode == 8'ha4; // @[LoadStore.scala 68:26]
  wire  execResult_result_isStoreA = opcode == 8'h85; // @[LoadStore.scala 69:27]
  wire  execResult_result_isStoreX = opcode == 8'h86; // @[LoadStore.scala 70:27]
  wire  _execResult_result_T_222 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY; // @[LoadStore.scala 84:33]
  wire [7:0] _GEN_1983 = execResult_result_isLoadX ? io_memDataIn : regs_x; // @[LoadStore.scala 55:13 88:31 89:23]
  wire [7:0] _GEN_1984 = execResult_result_isLoadX ? regs_y : io_memDataIn; // @[LoadStore.scala 55:13 88:31 91:23]
  wire [7:0] _GEN_1985 = execResult_result_isLoadA ? io_memDataIn : regs_a; // @[LoadStore.scala 55:13 86:25 87:23]
  wire [7:0] _GEN_1986 = execResult_result_isLoadA ? regs_x : _GEN_1983; // @[LoadStore.scala 55:13 86:25]
  wire [7:0] _GEN_1987 = execResult_result_isLoadA ? regs_y : _GEN_1984; // @[LoadStore.scala 55:13 86:25]
  wire [7:0] _execResult_result_result_memData_T = execResult_result_isStoreX ? regs_x : regs_y; // @[LoadStore.scala 97:54]
  wire [7:0] _execResult_result_result_memData_T_1 = execResult_result_isStoreA ? regs_a :
    _execResult_result_result_memData_T; // @[LoadStore.scala 97:32]
  wire [7:0] _GEN_1989 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1985
     : regs_a; // @[LoadStore.scala 55:13 84:45]
  wire [7:0] _GEN_1990 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1986
     : regs_x; // @[LoadStore.scala 55:13 84:45]
  wire [7:0] _GEN_1991 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1987
     : regs_y; // @[LoadStore.scala 55:13 84:45]
  wire  _GEN_1992 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? io_memDataIn[7]
     : regs_flagN; // @[LoadStore.scala 55:13 84:45 93:25]
  wire  _GEN_1993 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ?
    execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 55:13 84:45 94:25]
  wire  _GEN_1994 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 1'h0 : 1'h1; // @[LoadStore.scala 62:21 84:45 96:27]
  wire [7:0] _GEN_1995 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 8'h0 :
    _execResult_result_result_memData_T_1; // @[LoadStore.scala 61:20 84:45 97:26]
  wire  _GEN_1997 = _execResult_result_T_21 & _execResult_result_T_222; // @[LoadStore.scala 73:19 63:20]
  wire [7:0] _GEN_1998 = _execResult_result_T_21 ? _GEN_1989 : regs_a; // @[LoadStore.scala 55:13 73:19]
  wire [7:0] _GEN_1999 = _execResult_result_T_21 ? _GEN_1990 : regs_x; // @[LoadStore.scala 55:13 73:19]
  wire [7:0] _GEN_2000 = _execResult_result_T_21 ? _GEN_1991 : regs_y; // @[LoadStore.scala 55:13 73:19]
  wire  _GEN_2001 = _execResult_result_T_21 ? _GEN_1992 : regs_flagN; // @[LoadStore.scala 55:13 73:19]
  wire  _GEN_2002 = _execResult_result_T_21 ? _GEN_1993 : regs_flagZ; // @[LoadStore.scala 55:13 73:19]
  wire [7:0] _GEN_2004 = _execResult_result_T_21 ? _GEN_1995 : 8'h0; // @[LoadStore.scala 73:19 61:20]
  wire [7:0] execResult_result_newRegs_38_a = _execResult_result_T_20 ? regs_a : _GEN_1998; // @[LoadStore.scala 55:13 73:19]
  wire [7:0] execResult_result_newRegs_38_x = _execResult_result_T_20 ? regs_x : _GEN_1999; // @[LoadStore.scala 55:13 73:19]
  wire [7:0] execResult_result_newRegs_38_y = _execResult_result_T_20 ? regs_y : _GEN_2000; // @[LoadStore.scala 55:13 73:19]
  wire  execResult_result_newRegs_38_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2002; // @[LoadStore.scala 55:13 73:19]
  wire  execResult_result_newRegs_38_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2001; // @[LoadStore.scala 55:13 73:19]
  wire  execResult_result_result_39_memRead = _execResult_result_T_20 | _GEN_1997; // @[LoadStore.scala 73:19 76:24]
  wire  execResult_result_result_39_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1994; // @[LoadStore.scala 73:19 62:21]
  wire [7:0] execResult_result_result_39_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2004; // @[LoadStore.scala 73:19 61:20]
  wire  _execResult_T_211 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode; // @[CPU6502Core.scala 279:20]
  wire  execResult_result_isLoadA_1 = opcode == 8'hb5; // @[LoadStore.scala 122:26]
  wire  execResult_result_isLoadY_1 = opcode == 8'hb4; // @[LoadStore.scala 123:26]
  wire  _execResult_result_T_225 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1; // @[LoadStore.scala 137:22]
  wire [7:0] _GEN_2043 = execResult_result_isLoadA_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 111:13 139:25 140:23]
  wire [7:0] _GEN_2044 = execResult_result_isLoadA_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 111:13 139:25 142:23]
  wire [7:0] _execResult_result_result_memData_T_3 = opcode == 8'h95 ? regs_a : regs_y; // @[LoadStore.scala 148:32]
  wire [7:0] _GEN_2046 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_2043 : regs_a; // @[LoadStore.scala 111:13 137:34]
  wire [7:0] _GEN_2047 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_2044 : regs_y; // @[LoadStore.scala 111:13 137:34]
  wire  _GEN_2048 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 111:13 137:34 144:25]
  wire  _GEN_2049 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? execResult_result_newRegs_37_flagZ :
    regs_flagZ; // @[LoadStore.scala 111:13 137:34 145:25]
  wire  _GEN_2050 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 118:21 137:34 147:27]
  wire [7:0] _GEN_2051 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 8'h0 :
    _execResult_result_result_memData_T_3; // @[LoadStore.scala 117:20 137:34 148:26]
  wire  _GEN_2053 = _execResult_result_T_21 & _execResult_result_T_225; // @[LoadStore.scala 126:19 119:20]
  wire [7:0] _GEN_2054 = _execResult_result_T_21 ? _GEN_2046 : regs_a; // @[LoadStore.scala 111:13 126:19]
  wire [7:0] _GEN_2055 = _execResult_result_T_21 ? _GEN_2047 : regs_y; // @[LoadStore.scala 111:13 126:19]
  wire  _GEN_2056 = _execResult_result_T_21 ? _GEN_2048 : regs_flagN; // @[LoadStore.scala 111:13 126:19]
  wire  _GEN_2057 = _execResult_result_T_21 ? _GEN_2049 : regs_flagZ; // @[LoadStore.scala 111:13 126:19]
  wire [7:0] _GEN_2059 = _execResult_result_T_21 ? _GEN_2051 : 8'h0; // @[LoadStore.scala 126:19 117:20]
  wire [7:0] execResult_result_newRegs_39_a = _execResult_result_T_20 ? regs_a : _GEN_2054; // @[LoadStore.scala 111:13 126:19]
  wire [7:0] execResult_result_newRegs_39_y = _execResult_result_T_20 ? regs_y : _GEN_2055; // @[LoadStore.scala 111:13 126:19]
  wire  execResult_result_newRegs_39_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2057; // @[LoadStore.scala 111:13 126:19]
  wire  execResult_result_newRegs_39_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2056; // @[LoadStore.scala 111:13 126:19]
  wire  execResult_result_result_40_memRead = _execResult_result_T_20 | _GEN_2053; // @[LoadStore.scala 126:19 129:24]
  wire  execResult_result_result_40_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_2050; // @[LoadStore.scala 126:19 118:21]
  wire [7:0] execResult_result_result_40_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2059; // @[LoadStore.scala 126:19 117:20]
  wire  _execResult_T_214 = 8'hb6 == opcode | 8'h96 == opcode; // @[CPU6502Core.scala 279:20]
  wire  execResult_result_isLoad = opcode == 8'hb6; // @[LoadStore.scala 173:25]
  wire [7:0] _execResult_result_result_operand_T_90 = io_memDataIn + regs_y; // @[LoadStore.scala 179:38]
  wire [7:0] _GEN_2098 = execResult_result_isLoad ? io_memDataIn : regs_x; // @[LoadStore.scala 162:13 185:22 187:21]
  wire  _GEN_2099 = execResult_result_isLoad ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 162:13 185:22 188:25]
  wire  _GEN_2100 = execResult_result_isLoad ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 162:13 185:22 189:25]
  wire  _GEN_2101 = execResult_result_isLoad ? 1'h0 : 1'h1; // @[LoadStore.scala 169:21 185:22 191:27]
  wire [7:0] _GEN_2102 = execResult_result_isLoad ? 8'h0 : regs_x; // @[LoadStore.scala 168:20 185:22 192:26]
  wire  _GEN_2104 = _execResult_result_T_21 & execResult_result_isLoad; // @[LoadStore.scala 175:19 170:20]
  wire [7:0] _GEN_2105 = _execResult_result_T_21 ? _GEN_2098 : regs_x; // @[LoadStore.scala 162:13 175:19]
  wire  _GEN_2106 = _execResult_result_T_21 ? _GEN_2099 : regs_flagN; // @[LoadStore.scala 162:13 175:19]
  wire  _GEN_2107 = _execResult_result_T_21 ? _GEN_2100 : regs_flagZ; // @[LoadStore.scala 162:13 175:19]
  wire [7:0] _GEN_2109 = _execResult_result_T_21 ? _GEN_2102 : 8'h0; // @[LoadStore.scala 175:19 168:20]
  wire [7:0] execResult_result_newRegs_40_x = _execResult_result_T_20 ? regs_x : _GEN_2105; // @[LoadStore.scala 162:13 175:19]
  wire  execResult_result_newRegs_40_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2107; // @[LoadStore.scala 162:13 175:19]
  wire  execResult_result_newRegs_40_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2106; // @[LoadStore.scala 162:13 175:19]
  wire  execResult_result_result_41_memRead = _execResult_result_T_20 | _GEN_2104; // @[LoadStore.scala 175:19 178:24]
  wire [15:0] execResult_result_result_41_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_90} : operand; // @[LoadStore.scala 175:19 171:20 179:24]
  wire  execResult_result_result_41_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_2101; // @[LoadStore.scala 175:19 169:21]
  wire [7:0] execResult_result_result_41_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2109; // @[LoadStore.scala 175:19 168:20]
  wire  _execResult_T_225 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode; // @[CPU6502Core.scala 279:20]
  wire  execResult_result_isLoadA_2 = opcode == 8'had; // @[LoadStore.scala 217:26]
  wire  execResult_result_isLoadX_1 = opcode == 8'hae; // @[LoadStore.scala 218:26]
  wire  execResult_result_isLoadY_2 = opcode == 8'hac; // @[LoadStore.scala 219:26]
  wire  _execResult_result_T_232 = 4'h4 == cycle; // @[LoadStore.scala 221:19]
  wire  _execResult_result_T_234 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 |
    execResult_result_isLoadY_2; // @[LoadStore.scala 256:33]
  wire  _execResult_result_result_memData_T_4 = opcode == 8'h8e; // @[LoadStore.scala 261:21]
  wire  _execResult_result_result_memData_T_5 = opcode == 8'h8c; // @[LoadStore.scala 262:21]
  wire [7:0] _execResult_result_result_memData_T_6 = _execResult_result_result_memData_T_5 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] _execResult_result_result_memData_T_7 = _execResult_result_result_memData_T_4 ? regs_x :
    _execResult_result_result_memData_T_6; // @[Mux.scala 101:16]
  wire  _GEN_2146 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 1'h0 : 1'h1
    ; // @[LoadStore.scala 213:21 256:45 259:27]
  wire [7:0] _GEN_2147 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 8'h0
     : _execResult_result_result_memData_T_7; // @[LoadStore.scala 212:20 256:45 260:26]
  wire  _execResult_result_T_235 = 4'h5 == cycle; // @[LoadStore.scala 221:19]
  wire  _execResult_result_T_238 = operand == 16'h2002; // @[LoadStore.scala 273:26]
  wire [7:0] _GEN_2148 = execResult_result_isLoadX_1 ? io_memDataIn : regs_x; // @[LoadStore.scala 206:13 276:31 277:23]
  wire [7:0] _GEN_2149 = execResult_result_isLoadX_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 206:13 276:31 279:23]
  wire [7:0] _GEN_2150 = execResult_result_isLoadA_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 206:13 271:25 272:23]
  wire [7:0] _GEN_2151 = execResult_result_isLoadA_2 ? regs_x : _GEN_2148; // @[LoadStore.scala 206:13 271:25]
  wire [7:0] _GEN_2152 = execResult_result_isLoadA_2 ? regs_y : _GEN_2149; // @[LoadStore.scala 206:13 271:25]
  wire [7:0] _GEN_2153 = _execResult_result_T_234 ? _GEN_2150 : regs_a; // @[LoadStore.scala 206:13 270:45]
  wire [7:0] _GEN_2154 = _execResult_result_T_234 ? _GEN_2151 : regs_x; // @[LoadStore.scala 206:13 270:45]
  wire [7:0] _GEN_2155 = _execResult_result_T_234 ? _GEN_2152 : regs_y; // @[LoadStore.scala 206:13 270:45]
  wire  _GEN_2156 = _execResult_result_T_234 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 206:13 270:45 281:25]
  wire  _GEN_2157 = _execResult_result_T_234 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 206:13 270:45 282:25]
  wire [15:0] _GEN_2158 = 4'h5 == cycle ? operand : 16'h0; // @[LoadStore.scala 221:19 211:20 269:24]
  wire [7:0] _GEN_2159 = 4'h5 == cycle ? _GEN_2153 : regs_a; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2160 = 4'h5 == cycle ? _GEN_2154 : regs_x; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2161 = 4'h5 == cycle ? _GEN_2155 : regs_y; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2162 = 4'h5 == cycle ? _GEN_2156 : regs_flagN; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2163 = 4'h5 == cycle ? _GEN_2157 : regs_flagZ; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2182 = 4'h4 == cycle ? regs_a : _GEN_2159; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2206 = _execResult_result_T_30 ? regs_a : _GEN_2182; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2243 = _execResult_result_T_26 ? regs_a : _GEN_2206; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2268 = _execResult_result_T_21 ? regs_a : _GEN_2243; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] execResult_result_newRegs_41_a = _execResult_result_T_20 ? regs_a : _GEN_2268; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2183 = 4'h4 == cycle ? regs_x : _GEN_2160; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2207 = _execResult_result_T_30 ? regs_x : _GEN_2183; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2244 = _execResult_result_T_26 ? regs_x : _GEN_2207; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2269 = _execResult_result_T_21 ? regs_x : _GEN_2244; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] execResult_result_newRegs_41_x = _execResult_result_T_20 ? regs_x : _GEN_2269; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2184 = 4'h4 == cycle ? regs_y : _GEN_2161; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2208 = _execResult_result_T_30 ? regs_y : _GEN_2184; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2245 = _execResult_result_T_26 ? regs_y : _GEN_2208; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] _GEN_2270 = _execResult_result_T_21 ? regs_y : _GEN_2245; // @[LoadStore.scala 206:13 221:19]
  wire [7:0] execResult_result_newRegs_41_y = _execResult_result_T_20 ? regs_y : _GEN_2270; // @[LoadStore.scala 206:13 221:19]
  wire [15:0] _GEN_2227 = _execResult_result_T_26 ? _regs_pc_T_1 : regs_pc; // @[LoadStore.scala 206:13 221:19 242:20]
  wire [15:0] _GEN_2253 = _execResult_result_T_21 ? regs_pc : _GEN_2227; // @[LoadStore.scala 206:13 221:19]
  wire [15:0] execResult_result_newRegs_41_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2253; // @[LoadStore.scala 221:19 226:20]
  wire  _GEN_2186 = 4'h4 == cycle ? regs_flagZ : _GEN_2163; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2210 = _execResult_result_T_30 ? regs_flagZ : _GEN_2186; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2247 = _execResult_result_T_26 ? regs_flagZ : _GEN_2210; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2272 = _execResult_result_T_21 ? regs_flagZ : _GEN_2247; // @[LoadStore.scala 206:13 221:19]
  wire  execResult_result_newRegs_41_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2272; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2185 = 4'h4 == cycle ? regs_flagN : _GEN_2162; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2209 = _execResult_result_T_30 ? regs_flagN : _GEN_2185; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2246 = _execResult_result_T_26 ? regs_flagN : _GEN_2209; // @[LoadStore.scala 206:13 221:19]
  wire  _GEN_2271 = _execResult_result_T_21 ? regs_flagN : _GEN_2246; // @[LoadStore.scala 206:13 221:19]
  wire  execResult_result_newRegs_41_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2271; // @[LoadStore.scala 206:13 221:19]
  wire [15:0] _GEN_2177 = 4'h4 == cycle ? operand : _GEN_2158; // @[LoadStore.scala 221:19 255:24]
  wire  _GEN_2178 = 4'h4 == cycle & _execResult_result_T_234; // @[LoadStore.scala 221:19 214:20]
  wire [7:0] _GEN_2180 = 4'h4 == cycle ? _GEN_2147 : 8'h0; // @[LoadStore.scala 221:19 212:20]
  wire [3:0] _GEN_2181 = 4'h4 == cycle ? 4'h5 : _execResult_result_result_nextCycle_T_1; // @[LoadStore.scala 221:19 209:22 265:26]
  wire  _GEN_2199 = 4'h4 == cycle ? 1'h0 : 4'h5 == cycle; // @[LoadStore.scala 208:17 221:19]
  wire [15:0] _GEN_2200 = _execResult_result_T_30 ? regs_pc : _GEN_2177; // @[LoadStore.scala 221:19 248:24]
  wire  _GEN_2201 = _execResult_result_T_30 ? 1'h0 : _GEN_2178; // @[LoadStore.scala 221:19 249:24]
  wire [15:0] _GEN_2202 = _execResult_result_T_30 ? resetVector : operand; // @[LoadStore.scala 221:19 215:20 250:24]
  wire [3:0] _GEN_2203 = _execResult_result_T_30 ? 4'h4 : _GEN_2181; // @[LoadStore.scala 221:19 251:26]
  wire  _GEN_2204 = _execResult_result_T_30 ? 1'h0 : 4'h4 == cycle & _GEN_2146; // @[LoadStore.scala 221:19 213:21]
  wire [7:0] _GEN_2205 = _execResult_result_T_30 ? 8'h0 : _GEN_2180; // @[LoadStore.scala 221:19 212:20]
  wire  _GEN_2223 = _execResult_result_T_30 ? 1'h0 : _GEN_2199; // @[LoadStore.scala 208:17 221:19]
  wire [15:0] _GEN_2224 = _execResult_result_T_26 ? regs_pc : _GEN_2200; // @[LoadStore.scala 221:19 239:24]
  wire  _GEN_2225 = _execResult_result_T_26 | _GEN_2201; // @[LoadStore.scala 221:19 240:24]
  wire [15:0] _GEN_2226 = _execResult_result_T_26 ? operand : _GEN_2202; // @[LoadStore.scala 221:19 241:24]
  wire [3:0] _GEN_2240 = _execResult_result_T_26 ? 4'h3 : _GEN_2203; // @[LoadStore.scala 221:19 244:26]
  wire  _GEN_2241 = _execResult_result_T_26 ? 1'h0 : _GEN_2204; // @[LoadStore.scala 221:19 213:21]
  wire [7:0] _GEN_2242 = _execResult_result_T_26 ? 8'h0 : _GEN_2205; // @[LoadStore.scala 221:19 212:20]
  wire  _GEN_2248 = _execResult_result_T_26 ? 1'h0 : _GEN_2223; // @[LoadStore.scala 208:17 221:19]
  wire [15:0] _GEN_2249 = _execResult_result_T_21 ? regs_pc : _GEN_2224; // @[LoadStore.scala 221:19 232:24]
  wire  _GEN_2250 = _execResult_result_T_21 | _GEN_2225; // @[LoadStore.scala 221:19 233:24]
  wire [15:0] _GEN_2251 = _execResult_result_T_21 ? {{8'd0}, io_memDataIn} : _GEN_2226; // @[LoadStore.scala 221:19 234:24]
  wire [3:0] _GEN_2252 = _execResult_result_T_21 ? 4'h2 : _GEN_2240; // @[LoadStore.scala 221:19 235:26]
  wire  _GEN_2266 = _execResult_result_T_21 ? 1'h0 : _GEN_2241; // @[LoadStore.scala 221:19 213:21]
  wire [7:0] _GEN_2267 = _execResult_result_T_21 ? 8'h0 : _GEN_2242; // @[LoadStore.scala 221:19 212:20]
  wire  _GEN_2273 = _execResult_result_T_21 ? 1'h0 : _GEN_2248; // @[LoadStore.scala 208:17 221:19]
  wire [15:0] execResult_result_result_42_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2249; // @[LoadStore.scala 221:19 224:24]
  wire  execResult_result_result_42_memRead = _execResult_result_T_20 | _GEN_2250; // @[LoadStore.scala 221:19 225:24]
  wire [3:0] _GEN_2289 = _execResult_result_T_20 ? 4'h1 : _GEN_2252; // @[LoadStore.scala 221:19 228:26]
  wire [15:0] execResult_result_result_42_operand = _execResult_result_T_20 ? operand : _GEN_2251; // @[LoadStore.scala 221:19 215:20]
  wire  execResult_result_result_42_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2266; // @[LoadStore.scala 221:19 213:21]
  wire [7:0] execResult_result_result_42_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2267; // @[LoadStore.scala 221:19 212:20]
  wire  execResult_result_result_42_done = _execResult_result_T_20 ? 1'h0 : _GEN_2273; // @[LoadStore.scala 208:17 221:19]
  wire  execResult_result_useY_3 = opcode == 8'hb9 | opcode == 8'hbe | opcode == 8'h99; // @[LoadStore.scala 308:59]
  wire [7:0] execResult_result_indexReg = execResult_result_useY_3 ? regs_y : regs_x; // @[LoadStore.scala 309:23]
  wire [15:0] _GEN_4353 = {{8'd0}, execResult_result_indexReg}; // @[LoadStore.scala 328:57]
  wire [15:0] _execResult_result_result_operand_T_97 = resetVector + _GEN_4353; // @[LoadStore.scala 328:57]
  wire [7:0] _GEN_2301 = _execResult_result_T_26 ? io_memDataIn : regs_a; // @[LoadStore.scala 296:13 316:19 336:19]
  wire  _GEN_2302 = _execResult_result_T_26 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 296:13 316:19 337:23]
  wire  _GEN_2303 = _execResult_result_T_26 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 296:13 316:19 338:23]
  wire [7:0] _GEN_2333 = _execResult_result_T_21 ? regs_a : _GEN_2301; // @[LoadStore.scala 296:13 316:19]
  wire [7:0] execResult_result_newRegs_42_a = _execResult_result_T_20 ? regs_a : _GEN_2333; // @[LoadStore.scala 296:13 316:19]
  wire  _GEN_2335 = _execResult_result_T_21 ? regs_flagZ : _GEN_2303; // @[LoadStore.scala 296:13 316:19]
  wire  execResult_result_newRegs_42_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2335; // @[LoadStore.scala 296:13 316:19]
  wire  _GEN_2334 = _execResult_result_T_21 ? regs_flagN : _GEN_2302; // @[LoadStore.scala 296:13 316:19]
  wire  execResult_result_newRegs_42_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2334; // @[LoadStore.scala 296:13 316:19]
  wire [15:0] _GEN_2318 = _execResult_result_T_21 ? _execResult_result_result_operand_T_97 : operand; // @[LoadStore.scala 316:19 305:20 328:24]
  wire [15:0] execResult_result_result_43_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_2318; // @[LoadStore.scala 316:19 320:24]
  wire  execResult_result_isLoad_1 = opcode == 8'ha1; // @[LoadStore.scala 362:25]
  wire  _GEN_2359 = execResult_result_isLoad_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 358:21 388:22 391:27]
  wire [7:0] _GEN_2360 = execResult_result_isLoad_1 ? 8'h0 : regs_a; // @[LoadStore.scala 357:20 388:22 392:26]
  wire [7:0] _GEN_2361 = execResult_result_isLoad_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 351:13 397:22 398:21]
  wire  _GEN_2362 = execResult_result_isLoad_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 351:13 397:22 399:25]
  wire  _GEN_2363 = execResult_result_isLoad_1 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 351:13 397:22 400:25]
  wire [7:0] _GEN_2376 = _execResult_result_T_232 ? _GEN_2361 : regs_a; // @[LoadStore.scala 351:13 364:19]
  wire [7:0] _GEN_2396 = _execResult_result_T_30 ? regs_a : _GEN_2376; // @[LoadStore.scala 351:13 364:19]
  wire [7:0] _GEN_2417 = _execResult_result_T_26 ? regs_a : _GEN_2396; // @[LoadStore.scala 351:13 364:19]
  wire [7:0] _GEN_2438 = _execResult_result_T_21 ? regs_a : _GEN_2417; // @[LoadStore.scala 351:13 364:19]
  wire [7:0] execResult_result_newRegs_43_a = _execResult_result_T_20 ? regs_a : _GEN_2438; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2378 = _execResult_result_T_232 ? _GEN_2363 : regs_flagZ; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2398 = _execResult_result_T_30 ? regs_flagZ : _GEN_2378; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2419 = _execResult_result_T_26 ? regs_flagZ : _GEN_2398; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2440 = _execResult_result_T_21 ? regs_flagZ : _GEN_2419; // @[LoadStore.scala 351:13 364:19]
  wire  execResult_result_newRegs_43_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2440; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2377 = _execResult_result_T_232 ? _GEN_2362 : regs_flagN; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2397 = _execResult_result_T_30 ? regs_flagN : _GEN_2377; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2418 = _execResult_result_T_26 ? regs_flagN : _GEN_2397; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2439 = _execResult_result_T_21 ? regs_flagN : _GEN_2418; // @[LoadStore.scala 351:13 364:19]
  wire  execResult_result_newRegs_43_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2439; // @[LoadStore.scala 351:13 364:19]
  wire  _GEN_2393 = _execResult_result_T_30 & execResult_result_isLoad_1; // @[LoadStore.scala 364:19 359:20]
  wire [7:0] _GEN_2395 = _execResult_result_T_30 ? _GEN_2360 : 8'h0; // @[LoadStore.scala 364:19 357:20]
  wire  _GEN_2411 = _execResult_result_T_30 ? 1'h0 : _execResult_result_T_232; // @[LoadStore.scala 353:17 364:19]
  wire  _GEN_2413 = _execResult_result_T_26 | _GEN_2393; // @[LoadStore.scala 364:19 382:24]
  wire  _GEN_2415 = _execResult_result_T_26 ? 1'h0 : _execResult_result_T_30 & _GEN_2359; // @[LoadStore.scala 364:19 358:21]
  wire [7:0] _GEN_2416 = _execResult_result_T_26 ? 8'h0 : _GEN_2395; // @[LoadStore.scala 364:19 357:20]
  wire  _GEN_2432 = _execResult_result_T_26 ? 1'h0 : _GEN_2411; // @[LoadStore.scala 353:17 364:19]
  wire  _GEN_2434 = _execResult_result_T_21 | _GEN_2413; // @[LoadStore.scala 364:19 376:24]
  wire  _GEN_2436 = _execResult_result_T_21 ? 1'h0 : _GEN_2415; // @[LoadStore.scala 364:19 358:21]
  wire [7:0] _GEN_2437 = _execResult_result_T_21 ? 8'h0 : _GEN_2416; // @[LoadStore.scala 364:19 357:20]
  wire  _GEN_2453 = _execResult_result_T_21 ? 1'h0 : _GEN_2432; // @[LoadStore.scala 353:17 364:19]
  wire  execResult_result_result_44_memRead = _execResult_result_T_20 | _GEN_2434; // @[LoadStore.scala 364:19 368:24]
  wire  execResult_result_result_44_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2436; // @[LoadStore.scala 364:19 358:21]
  wire [7:0] execResult_result_result_44_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2437; // @[LoadStore.scala 364:19 357:20]
  wire  execResult_result_result_44_done = _execResult_result_T_20 ? 1'h0 : _GEN_2453; // @[LoadStore.scala 353:17 364:19]
  wire  execResult_result_isLoad_2 = opcode == 8'hb1; // @[LoadStore.scala 425:25]
  wire [15:0] execResult_result_finalAddr = operand + _GEN_4340; // @[LoadStore.scala 450:33]
  wire  _GEN_2477 = execResult_result_isLoad_2 ? 1'h0 : 1'h1; // @[LoadStore.scala 421:21 452:22 455:27]
  wire [7:0] _GEN_2478 = execResult_result_isLoad_2 ? 8'h0 : regs_a; // @[LoadStore.scala 420:20 452:22 456:26]
  wire [7:0] _GEN_2479 = execResult_result_isLoad_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 414:13 461:22 462:21]
  wire  _GEN_2480 = execResult_result_isLoad_2 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 414:13 461:22 463:25]
  wire  _GEN_2481 = execResult_result_isLoad_2 ? execResult_result_newRegs_37_flagZ : regs_flagZ; // @[LoadStore.scala 414:13 461:22 464:25]
  wire [7:0] _GEN_2494 = _execResult_result_T_232 ? _GEN_2479 : regs_a; // @[LoadStore.scala 414:13 427:19]
  wire [7:0] _GEN_2514 = _execResult_result_T_30 ? regs_a : _GEN_2494; // @[LoadStore.scala 414:13 427:19]
  wire [7:0] _GEN_2535 = _execResult_result_T_26 ? regs_a : _GEN_2514; // @[LoadStore.scala 414:13 427:19]
  wire [7:0] _GEN_2556 = _execResult_result_T_21 ? regs_a : _GEN_2535; // @[LoadStore.scala 414:13 427:19]
  wire [7:0] execResult_result_newRegs_44_a = _execResult_result_T_20 ? regs_a : _GEN_2556; // @[LoadStore.scala 414:13 427:19]
  wire  _GEN_2496 = _execResult_result_T_232 ? _GEN_2481 : regs_flagZ; // @[LoadStore.scala 414:13 427:19]
  wire  _GEN_2516 = _execResult_result_T_30 ? regs_flagZ : _GEN_2496; // @[LoadStore.scala 414:13 427:19]
  wire  _GEN_2537 = _execResult_result_T_26 ? regs_flagZ : _GEN_2516; // @[LoadStore.scala 414:13 427:19]
  wire  _GEN_2558 = _execResult_result_T_21 ? regs_flagZ : _GEN_2537; // @[LoadStore.scala 414:13 427:19]
  wire  execResult_result_newRegs_44_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2558; // @[LoadStore.scala 414:13 427:19]
  wire  _GEN_2495 = _execResult_result_T_232 ? _GEN_2480 : regs_flagN; // @[LoadStore.scala 414:13 427:19]
  wire  _GEN_2515 = _execResult_result_T_30 ? regs_flagN : _GEN_2495; // @[LoadStore.scala 414:13 427:19]
  wire  _GEN_2536 = _execResult_result_T_26 ? regs_flagN : _GEN_2515; // @[LoadStore.scala 414:13 427:19]
  wire  _GEN_2557 = _execResult_result_T_21 ? regs_flagN : _GEN_2536; // @[LoadStore.scala 414:13 427:19]
  wire  execResult_result_newRegs_44_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2557; // @[LoadStore.scala 414:13 427:19]
  wire [15:0] _GEN_2510 = _execResult_result_T_30 ? execResult_result_finalAddr : 16'h0; // @[LoadStore.scala 427:19 419:20 451:24]
  wire  _GEN_2511 = _execResult_result_T_30 & execResult_result_isLoad_2; // @[LoadStore.scala 427:19 422:20]
  wire [7:0] _GEN_2513 = _execResult_result_T_30 ? _GEN_2478 : 8'h0; // @[LoadStore.scala 427:19 420:20]
  wire [15:0] _GEN_2530 = _execResult_result_T_26 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_2510; // @[LoadStore.scala 427:19 444:24]
  wire  _GEN_2531 = _execResult_result_T_26 | _GEN_2511; // @[LoadStore.scala 427:19 445:24]
  wire  _GEN_2533 = _execResult_result_T_26 ? 1'h0 : _execResult_result_T_30 & _GEN_2477; // @[LoadStore.scala 427:19 421:21]
  wire [7:0] _GEN_2534 = _execResult_result_T_26 ? 8'h0 : _GEN_2513; // @[LoadStore.scala 427:19 420:20]
  wire [15:0] _GEN_2551 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_2530; // @[LoadStore.scala 427:19 438:24]
  wire  _GEN_2552 = _execResult_result_T_21 | _GEN_2531; // @[LoadStore.scala 427:19 439:24]
  wire  _GEN_2554 = _execResult_result_T_21 ? 1'h0 : _GEN_2533; // @[LoadStore.scala 427:19 421:21]
  wire [7:0] _GEN_2555 = _execResult_result_T_21 ? 8'h0 : _GEN_2534; // @[LoadStore.scala 427:19 420:20]
  wire [15:0] execResult_result_result_45_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2551; // @[LoadStore.scala 427:19 430:24]
  wire  execResult_result_result_45_memRead = _execResult_result_T_20 | _GEN_2552; // @[LoadStore.scala 427:19 431:24]
  wire  execResult_result_result_45_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2554; // @[LoadStore.scala 427:19 421:21]
  wire [7:0] execResult_result_result_45_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2555; // @[LoadStore.scala 427:19 420:20]
  wire [7:0] _execResult_result_pushData_T = {regs_flagN,regs_flagV,2'h3,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] execResult_result_pushData = opcode == 8'h8 ? _execResult_result_pushData_T : regs_a; // @[Stack.scala 21:14 23:29 24:16]
  wire [7:0] execResult_result_newRegs_45_sp = regs_sp - 8'h1; // @[Stack.scala 27:27]
  wire [15:0] execResult_result_result_46_memAddr = {8'h1,regs_sp}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_newRegs_sp_T_3 = regs_sp + 8'h1; // @[Stack.scala 57:31]
  wire [7:0] _GEN_2595 = opcode == 8'h68 ? io_memDataIn : regs_a; // @[Stack.scala 44:13 65:33 66:21]
  wire  _GEN_2596 = opcode == 8'h68 ? io_memDataIn[7] : io_memDataIn[7]; // @[Stack.scala 65:33 67:25 75:25]
  wire  _GEN_2597 = opcode == 8'h68 ? execResult_result_newRegs_37_flagZ : io_memDataIn[1]; // @[Stack.scala 65:33 68:25 71:25]
  wire  _GEN_2598 = opcode == 8'h68 ? regs_flagC : io_memDataIn[0]; // @[Stack.scala 44:13 65:33 70:25]
  wire  _GEN_2599 = opcode == 8'h68 ? regs_flagI : io_memDataIn[2]; // @[Stack.scala 44:13 65:33 72:25]
  wire  _GEN_2600 = opcode == 8'h68 ? regs_flagD : io_memDataIn[3]; // @[Stack.scala 44:13 65:33 73:25]
  wire  _GEN_2601 = opcode == 8'h68 ? regs_flagV : io_memDataIn[6]; // @[Stack.scala 44:13 65:33 74:25]
  wire [15:0] _GEN_2602 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : 16'h0; // @[Stack.scala 55:19 49:20 62:24]
  wire [7:0] _GEN_2604 = _execResult_result_T_21 ? _GEN_2595 : regs_a; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2605 = _execResult_result_T_21 ? _GEN_2596 : regs_flagN; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2606 = _execResult_result_T_21 ? _GEN_2597 : regs_flagZ; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2607 = _execResult_result_T_21 ? _GEN_2598 : regs_flagC; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2608 = _execResult_result_T_21 ? _GEN_2599 : regs_flagI; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2609 = _execResult_result_T_21 ? _GEN_2600 : regs_flagD; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2610 = _execResult_result_T_21 ? _GEN_2601 : regs_flagV; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_46_a = _execResult_result_T_20 ? regs_a : _GEN_2604; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_46_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Stack.scala 44:13 55:19 57:20]
  wire  execResult_result_newRegs_46_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_2607; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2606; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2608; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_2609; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_2610; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2605; // @[Stack.scala 44:13 55:19]
  wire [15:0] execResult_result_result_47_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2602; // @[Stack.scala 55:19 49:20]
  wire [15:0] _GEN_2646 = _execResult_result_T_21 ? regs_pc : 16'h0; // @[Jump.scala 26:19 20:20 36:24]
  wire [15:0] _GEN_2649 = _execResult_result_T_21 ? resetVector : regs_pc; // @[Jump.scala 15:13 26:19 39:20]
  wire [15:0] execResult_result_newRegs_47_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2649; // @[Jump.scala 26:19 31:20]
  wire [15:0] execResult_result_result_48_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2646; // @[Jump.scala 26:19 28:24]
  wire [15:0] _execResult_result_indirectAddrHigh_T_3 = {operand[15:8],8'h0}; // @[Cat.scala 33:92]
  wire [15:0] _execResult_result_indirectAddrHigh_T_5 = operand + 16'h1; // @[Jump.scala 90:19]
  wire [15:0] execResult_result_indirectAddrHigh = operand[7:0] == 8'hff ? _execResult_result_indirectAddrHigh_T_3 :
    _execResult_result_indirectAddrHigh_T_5; // @[Jump.scala 88:35]
  wire [15:0] _GEN_2680 = _execResult_result_T_30 ? execResult_result_indirectAddrHigh : 16'h0; // @[Jump.scala 63:19 57:20 91:24]
  wire [15:0] _GEN_2682 = _execResult_result_T_30 ? resetVector : regs_pc; // @[Jump.scala 52:13 63:19 93:20]
  wire [15:0] _GEN_2698 = _execResult_result_T_26 ? regs_pc : _GEN_2682; // @[Jump.scala 52:13 63:19]
  wire [15:0] _GEN_2715 = _execResult_result_T_21 ? _regs_pc_T_1 : _GEN_2698; // @[Jump.scala 63:19 77:20]
  wire [15:0] execResult_result_newRegs_48_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2715; // @[Jump.scala 63:19 69:20]
  wire [15:0] _GEN_2695 = _execResult_result_T_26 ? operand : _GEN_2680; // @[Jump.scala 63:19 82:24]
  wire [15:0] _GEN_2697 = _execResult_result_T_26 ? _execResult_result_result_operand_T_9 : operand; // @[Jump.scala 63:19 61:20 84:24]
  wire [15:0] _GEN_2712 = _execResult_result_T_21 ? regs_pc : _GEN_2695; // @[Jump.scala 63:19 74:24]
  wire [15:0] _GEN_2714 = _execResult_result_T_21 ? resetVector : _GEN_2697; // @[Jump.scala 63:19 76:24]
  wire [15:0] execResult_result_result_49_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2712; // @[Jump.scala 63:19 66:24]
  wire [15:0] execResult_result_result_49_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_2714; // @[Jump.scala 63:19 68:24]
  wire [15:0] execResult_result_returnAddr = regs_pc - 16'h1; // @[Jump.scala 136:34]
  wire [15:0] _GEN_2746 = _execResult_result_T_30 ? execResult_result_result_46_memAddr : 16'h0; // @[Jump.scala 117:19 111:20 147:24]
  wire [7:0] _GEN_2747 = _execResult_result_T_30 ? execResult_result_returnAddr[7:0] : 8'h0; // @[Jump.scala 117:19 112:20 148:24]
  wire [7:0] _GEN_2749 = _execResult_result_T_30 ? execResult_result_newRegs_45_sp : regs_sp; // @[Jump.scala 106:13 117:19 150:20]
  wire [15:0] _GEN_2750 = _execResult_result_T_30 ? operand : regs_pc; // @[Jump.scala 106:13 117:19 151:20]
  wire [7:0] _GEN_2766 = _execResult_result_T_26 ? execResult_result_newRegs_45_sp : _GEN_2749; // @[Jump.scala 117:19 140:20]
  wire [7:0] _GEN_2801 = _execResult_result_T_21 ? regs_sp : _GEN_2766; // @[Jump.scala 106:13 117:19]
  wire [7:0] execResult_result_newRegs_49_sp = _execResult_result_T_20 ? regs_sp : _GEN_2801; // @[Jump.scala 106:13 117:19]
  wire [15:0] _GEN_2780 = _execResult_result_T_26 ? regs_pc : _GEN_2750; // @[Jump.scala 106:13 117:19]
  wire [15:0] _GEN_2785 = _execResult_result_T_21 ? _regs_pc_T_1 : _GEN_2780; // @[Jump.scala 117:19 130:20]
  wire [15:0] execResult_result_newRegs_49_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2785; // @[Jump.scala 117:19 122:20]
  wire [15:0] _GEN_2763 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : _GEN_2746; // @[Jump.scala 117:19 137:24]
  wire [7:0] _GEN_2764 = _execResult_result_T_26 ? execResult_result_returnAddr[15:8] : _GEN_2747; // @[Jump.scala 117:19 138:24]
  wire [3:0] _GEN_2779 = _execResult_result_T_26 ? 4'h3 : _execResult_result_result_nextCycle_T_1; // @[Jump.scala 117:19 109:22 142:26]
  wire [15:0] _GEN_2782 = _execResult_result_T_21 ? regs_pc : _GEN_2763; // @[Jump.scala 117:19 127:24]
  wire [3:0] _GEN_2798 = _execResult_result_T_21 ? 4'h2 : _GEN_2779; // @[Jump.scala 117:19 132:26]
  wire [7:0] _GEN_2799 = _execResult_result_T_21 ? 8'h0 : _GEN_2764; // @[Jump.scala 117:19 112:20]
  wire  _GEN_2800 = _execResult_result_T_21 ? 1'h0 : _GEN_352; // @[Jump.scala 117:19 113:21]
  wire [15:0] execResult_result_result_50_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2782; // @[Jump.scala 117:19 119:24]
  wire [3:0] _GEN_2819 = _execResult_result_T_20 ? 4'h1 : _GEN_2798; // @[Jump.scala 117:19 124:26]
  wire [7:0] execResult_result_result_50_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2799; // @[Jump.scala 117:19 112:20]
  wire  execResult_result_result_50_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2800; // @[Jump.scala 117:19 113:21]
  wire [15:0] _execResult_result_newRegs_pc_T_127 = resetVector + 16'h1; // @[Jump.scala 193:53]
  wire [15:0] _GEN_2824 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : 16'h0; // @[Jump.scala 175:19 169:20 190:24]
  wire [15:0] _GEN_2827 = _execResult_result_T_26 ? _execResult_result_newRegs_pc_T_127 : regs_pc; // @[Jump.scala 164:13 175:19 193:20]
  wire [7:0] _GEN_2843 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 164:13 175:19 185:20]
  wire [7:0] execResult_result_newRegs_50_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_2843; // @[Jump.scala 175:19 177:20]
  wire [15:0] _GEN_2857 = _execResult_result_T_21 ? regs_pc : _GEN_2827; // @[Jump.scala 164:13 175:19]
  wire [15:0] execResult_result_newRegs_50_pc = _execResult_result_T_20 ? regs_pc : _GEN_2857; // @[Jump.scala 164:13 175:19]
  wire [15:0] _GEN_2840 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2824; // @[Jump.scala 175:19 182:24]
  wire [15:0] _GEN_2842 = _execResult_result_T_21 ? {{8'd0}, io_memDataIn} : _GEN_353; // @[Jump.scala 175:19 184:24]
  wire [15:0] execResult_result_result_51_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2840; // @[Jump.scala 175:19 169:20]
  wire  execResult_result_result_51_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_285; // @[Jump.scala 175:19 172:20]
  wire [15:0] execResult_result_result_51_operand = _execResult_result_T_20 ? operand : _GEN_2842; // @[Jump.scala 175:19 173:20]
  wire [15:0] _GEN_2878 = _execResult_result_T_235 ? 16'hffff : 16'h0; // @[Jump.scala 217:19 211:20 257:24]
  wire [15:0] _GEN_2880 = _execResult_result_T_235 ? resetVector : regs_pc; // @[Jump.scala 206:13 217:19 259:20]
  wire [7:0] _GEN_2960 = _execResult_result_T_21 ? execResult_result_newRegs_45_sp : _GEN_2766; // @[Jump.scala 217:19 227:20]
  wire [7:0] execResult_result_newRegs_51_sp = _execResult_result_T_20 ? regs_sp : _GEN_2960; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2897 = _execResult_result_T_232 ? regs_pc : _GEN_2880; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2932 = _execResult_result_T_30 ? regs_pc : _GEN_2897; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2955 = _execResult_result_T_26 ? regs_pc : _GEN_2932; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2978 = _execResult_result_T_21 ? regs_pc : _GEN_2955; // @[Jump.scala 206:13 217:19]
  wire [15:0] execResult_result_newRegs_51_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2978; // @[Jump.scala 217:19 219:20]
  wire  _GEN_2915 = _execResult_result_T_30 | regs_flagI; // @[Jump.scala 206:13 217:19 245:23]
  wire  _GEN_2951 = _execResult_result_T_26 ? regs_flagI : _GEN_2915; // @[Jump.scala 206:13 217:19]
  wire  _GEN_2974 = _execResult_result_T_21 ? regs_flagI : _GEN_2951; // @[Jump.scala 206:13 217:19]
  wire  execResult_result_newRegs_51_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2974; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2893 = _execResult_result_T_232 ? 16'hfffe : _GEN_2878; // @[Jump.scala 217:19 251:24]
  wire  _GEN_2894 = _execResult_result_T_232 | _execResult_result_T_235; // @[Jump.scala 217:19 252:24]
  wire [15:0] _GEN_2895 = _execResult_result_T_232 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 217:19 215:20 253:24]
  wire [15:0] _GEN_2911 = _execResult_result_T_30 ? execResult_result_result_46_memAddr : _GEN_2893; // @[Jump.scala 217:19 241:24]
  wire [7:0] _GEN_2912 = _execResult_result_T_30 ? _execResult_result_pushData_T : 8'h0; // @[Jump.scala 217:19 212:20 242:24]
  wire  _GEN_2930 = _execResult_result_T_30 ? 1'h0 : _GEN_2894; // @[Jump.scala 217:19 214:20]
  wire [15:0] _GEN_2931 = _execResult_result_T_30 ? operand : _GEN_2895; // @[Jump.scala 217:19 215:20]
  wire [15:0] _GEN_2934 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : _GEN_2911; // @[Jump.scala 217:19 232:24]
  wire [7:0] _GEN_2935 = _execResult_result_T_26 ? regs_pc[7:0] : _GEN_2912; // @[Jump.scala 217:19 233:24]
  wire  _GEN_2953 = _execResult_result_T_26 ? 1'h0 : _GEN_2930; // @[Jump.scala 217:19 214:20]
  wire [15:0] _GEN_2954 = _execResult_result_T_26 ? operand : _GEN_2931; // @[Jump.scala 217:19 215:20]
  wire [15:0] _GEN_2957 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2934; // @[Jump.scala 217:19 224:24]
  wire [7:0] _GEN_2958 = _execResult_result_T_21 ? regs_pc[15:8] : _GEN_2935; // @[Jump.scala 217:19 225:24]
  wire  _GEN_2976 = _execResult_result_T_21 ? 1'h0 : _GEN_2953; // @[Jump.scala 217:19 214:20]
  wire [15:0] _GEN_2977 = _execResult_result_T_21 ? operand : _GEN_2954; // @[Jump.scala 217:19 215:20]
  wire [15:0] execResult_result_result_52_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2957; // @[Jump.scala 217:19 211:20]
  wire [7:0] execResult_result_result_52_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2958; // @[Jump.scala 217:19 212:20]
  wire  execResult_result_result_52_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_373; // @[Jump.scala 217:19 213:21]
  wire  execResult_result_result_52_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_2976; // @[Jump.scala 217:19 214:20]
  wire [15:0] execResult_result_result_52_operand = _execResult_result_T_20 ? operand : _GEN_2977; // @[Jump.scala 217:19 215:20]
  wire [7:0] _GEN_3021 = _execResult_result_T_26 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 272:13 283:19 306:20]
  wire [7:0] _GEN_3045 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : _GEN_3021; // @[Jump.scala 283:19 298:20]
  wire [7:0] execResult_result_newRegs_52_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_3045; // @[Jump.scala 283:19 285:20]
  wire [15:0] _GEN_3060 = _execResult_result_T_21 ? regs_pc : _GEN_2698; // @[Jump.scala 272:13 283:19]
  wire [15:0] execResult_result_newRegs_52_pc = _execResult_result_T_20 ? regs_pc : _GEN_3060; // @[Jump.scala 272:13 283:19]
  wire  _GEN_3039 = _execResult_result_T_21 ? io_memDataIn[0] : regs_flagC; // @[Jump.scala 272:13 283:19 292:23]
  wire  execResult_result_newRegs_52_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_3039; // @[Jump.scala 272:13 283:19]
  wire  _GEN_3040 = _execResult_result_T_21 ? io_memDataIn[1] : regs_flagZ; // @[Jump.scala 272:13 283:19 293:23]
  wire  execResult_result_newRegs_52_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_3040; // @[Jump.scala 272:13 283:19]
  wire  _GEN_3041 = _execResult_result_T_21 ? io_memDataIn[2] : regs_flagI; // @[Jump.scala 272:13 283:19 294:23]
  wire  execResult_result_newRegs_52_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_3041; // @[Jump.scala 272:13 283:19]
  wire  _GEN_3042 = _execResult_result_T_21 ? io_memDataIn[3] : regs_flagD; // @[Jump.scala 272:13 283:19 295:23]
  wire  execResult_result_newRegs_52_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_3042; // @[Jump.scala 272:13 283:19]
  wire [15:0] _GEN_3020 = _execResult_result_T_26 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 283:19 281:20 305:24]
  wire [15:0] _GEN_3037 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2763; // @[Jump.scala 283:19 290:24]
  wire [15:0] _GEN_3059 = _execResult_result_T_21 ? operand : _GEN_3020; // @[Jump.scala 283:19 281:20]
  wire [15:0] execResult_result_result_53_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_3037; // @[Jump.scala 283:19 277:20]
  wire [15:0] execResult_result_result_53_operand = _execResult_result_T_20 ? operand : _GEN_3059; // @[Jump.scala 283:19 281:20]
  wire  _GEN_3087 = 8'h40 == opcode & execResult_result_result_9_done; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire [2:0] execResult_result_result_53_nextCycle = _GEN_2819[2:0]; // @[Jump.scala 270:22]
  wire [2:0] _GEN_3088 = 8'h40 == opcode ? execResult_result_result_53_nextCycle : 3'h0; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire [7:0] _GEN_3092 = 8'h40 == opcode ? execResult_result_newRegs_52_sp : regs_sp; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire [15:0] _GEN_3093 = 8'h40 == opcode ? execResult_result_newRegs_52_pc : regs_pc; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire  _GEN_3094 = 8'h40 == opcode ? execResult_result_newRegs_52_flagC : regs_flagC; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire  _GEN_3095 = 8'h40 == opcode ? execResult_result_newRegs_52_flagZ : regs_flagZ; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire  _GEN_3096 = 8'h40 == opcode ? execResult_result_newRegs_52_flagI : regs_flagI; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire  _GEN_3097 = 8'h40 == opcode ? execResult_result_newRegs_52_flagD : regs_flagD; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire  _GEN_3099 = 8'h40 == opcode ? execResult_result_newRegs_16_flagV : regs_flagV; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire  _GEN_3100 = 8'h40 == opcode ? execResult_result_newRegs_16_flagN : regs_flagN; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire [15:0] _GEN_3101 = 8'h40 == opcode ? execResult_result_result_53_memAddr : 16'h0; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire  _GEN_3104 = 8'h40 == opcode & execResult_result_result_52_memWrite; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire [15:0] _GEN_3105 = 8'h40 == opcode ? execResult_result_result_53_operand : operand; // @[CPU6502Core.scala 277:12 279:20 513:27]
  wire  _GEN_3106 = 8'h0 == opcode ? execResult_result_result_42_done : _GEN_3087; // @[CPU6502Core.scala 279:20 512:27]
  wire [2:0] execResult_result_result_52_nextCycle = _GEN_2289[2:0]; // @[Jump.scala 204:22]
  wire [2:0] _GEN_3107 = 8'h0 == opcode ? execResult_result_result_52_nextCycle : _GEN_3088; // @[CPU6502Core.scala 279:20 512:27]
  wire [7:0] _GEN_3111 = 8'h0 == opcode ? execResult_result_newRegs_51_sp : _GEN_3092; // @[CPU6502Core.scala 279:20 512:27]
  wire [15:0] _GEN_3112 = 8'h0 == opcode ? execResult_result_newRegs_51_pc : _GEN_3093; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3113 = 8'h0 == opcode ? regs_flagC : _GEN_3094; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3114 = 8'h0 == opcode ? regs_flagZ : _GEN_3095; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3115 = 8'h0 == opcode ? execResult_result_newRegs_51_flagI : _GEN_3096; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3116 = 8'h0 == opcode ? regs_flagD : _GEN_3097; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3118 = 8'h0 == opcode ? regs_flagV : _GEN_3099; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3119 = 8'h0 == opcode ? regs_flagN : _GEN_3100; // @[CPU6502Core.scala 279:20 512:27]
  wire [15:0] _GEN_3120 = 8'h0 == opcode ? execResult_result_result_52_memAddr : _GEN_3101; // @[CPU6502Core.scala 279:20 512:27]
  wire [7:0] _GEN_3121 = 8'h0 == opcode ? execResult_result_result_52_memData : 8'h0; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3122 = 8'h0 == opcode & execResult_result_result_52_memWrite; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3123 = 8'h0 == opcode ? execResult_result_result_52_memRead : _GEN_3104; // @[CPU6502Core.scala 279:20 512:27]
  wire [15:0] _GEN_3124 = 8'h0 == opcode ? execResult_result_result_52_operand : _GEN_3105; // @[CPU6502Core.scala 279:20 512:27]
  wire  _GEN_3125 = 8'h60 == opcode ? execResult_result_result_8_done : _GEN_3106; // @[CPU6502Core.scala 279:20 511:27]
  wire [2:0] execResult_result_result_51_nextCycle = _GEN_554[2:0]; // @[Jump.scala 162:22]
  wire [2:0] _GEN_3126 = 8'h60 == opcode ? execResult_result_result_51_nextCycle : _GEN_3107; // @[CPU6502Core.scala 279:20 511:27]
  wire [7:0] _GEN_3130 = 8'h60 == opcode ? execResult_result_newRegs_50_sp : _GEN_3111; // @[CPU6502Core.scala 279:20 511:27]
  wire [15:0] _GEN_3131 = 8'h60 == opcode ? execResult_result_newRegs_50_pc : _GEN_3112; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3132 = 8'h60 == opcode ? regs_flagC : _GEN_3113; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3133 = 8'h60 == opcode ? regs_flagZ : _GEN_3114; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3134 = 8'h60 == opcode ? regs_flagI : _GEN_3115; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3135 = 8'h60 == opcode ? regs_flagD : _GEN_3116; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3137 = 8'h60 == opcode ? regs_flagV : _GEN_3118; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3138 = 8'h60 == opcode ? regs_flagN : _GEN_3119; // @[CPU6502Core.scala 279:20 511:27]
  wire [15:0] _GEN_3139 = 8'h60 == opcode ? execResult_result_result_51_memAddr : _GEN_3120; // @[CPU6502Core.scala 279:20 511:27]
  wire [7:0] _GEN_3140 = 8'h60 == opcode ? 8'h0 : _GEN_3121; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3141 = 8'h60 == opcode ? 1'h0 : _GEN_3122; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3142 = 8'h60 == opcode ? execResult_result_result_51_memRead : _GEN_3123; // @[CPU6502Core.scala 279:20 511:27]
  wire [15:0] _GEN_3143 = 8'h60 == opcode ? execResult_result_result_51_operand : _GEN_3124; // @[CPU6502Core.scala 279:20 511:27]
  wire  _GEN_3144 = 8'h20 == opcode ? execResult_result_result_9_done : _GEN_3125; // @[CPU6502Core.scala 279:20 510:27]
  wire [2:0] _GEN_3145 = 8'h20 == opcode ? execResult_result_result_53_nextCycle : _GEN_3126; // @[CPU6502Core.scala 279:20 510:27]
  wire [7:0] _GEN_3149 = 8'h20 == opcode ? execResult_result_newRegs_49_sp : _GEN_3130; // @[CPU6502Core.scala 279:20 510:27]
  wire [15:0] _GEN_3150 = 8'h20 == opcode ? execResult_result_newRegs_49_pc : _GEN_3131; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3151 = 8'h20 == opcode ? regs_flagC : _GEN_3132; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3152 = 8'h20 == opcode ? regs_flagZ : _GEN_3133; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3153 = 8'h20 == opcode ? regs_flagI : _GEN_3134; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3154 = 8'h20 == opcode ? regs_flagD : _GEN_3135; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3156 = 8'h20 == opcode ? regs_flagV : _GEN_3137; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3157 = 8'h20 == opcode ? regs_flagN : _GEN_3138; // @[CPU6502Core.scala 279:20 510:27]
  wire [15:0] _GEN_3158 = 8'h20 == opcode ? execResult_result_result_50_memAddr : _GEN_3139; // @[CPU6502Core.scala 279:20 510:27]
  wire [7:0] _GEN_3159 = 8'h20 == opcode ? execResult_result_result_50_memData : _GEN_3140; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3160 = 8'h20 == opcode ? execResult_result_result_50_memWrite : _GEN_3141; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3161 = 8'h20 == opcode ? execResult_result_result_6_memRead : _GEN_3142; // @[CPU6502Core.scala 279:20 510:27]
  wire [15:0] _GEN_3162 = 8'h20 == opcode ? execResult_result_result_8_operand : _GEN_3143; // @[CPU6502Core.scala 279:20 510:27]
  wire  _GEN_3163 = 8'h6c == opcode ? execResult_result_result_9_done : _GEN_3144; // @[CPU6502Core.scala 279:20 509:27]
  wire [2:0] execResult_result_result_49_nextCycle = _execResult_result_result_nextCycle_T_1[2:0]; // @[Jump.scala 50:22 55:22]
  wire [2:0] _GEN_3164 = 8'h6c == opcode ? execResult_result_result_49_nextCycle : _GEN_3145; // @[CPU6502Core.scala 279:20 509:27]
  wire [7:0] _GEN_3168 = 8'h6c == opcode ? regs_sp : _GEN_3149; // @[CPU6502Core.scala 279:20 509:27]
  wire [15:0] _GEN_3169 = 8'h6c == opcode ? execResult_result_newRegs_48_pc : _GEN_3150; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3170 = 8'h6c == opcode ? regs_flagC : _GEN_3151; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3171 = 8'h6c == opcode ? regs_flagZ : _GEN_3152; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3172 = 8'h6c == opcode ? regs_flagI : _GEN_3153; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3173 = 8'h6c == opcode ? regs_flagD : _GEN_3154; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3175 = 8'h6c == opcode ? regs_flagV : _GEN_3156; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3176 = 8'h6c == opcode ? regs_flagN : _GEN_3157; // @[CPU6502Core.scala 279:20 509:27]
  wire [15:0] _GEN_3177 = 8'h6c == opcode ? execResult_result_result_49_memAddr : _GEN_3158; // @[CPU6502Core.scala 279:20 509:27]
  wire [7:0] _GEN_3178 = 8'h6c == opcode ? 8'h0 : _GEN_3159; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3179 = 8'h6c == opcode ? 1'h0 : _GEN_3160; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3180 = 8'h6c == opcode ? execResult_result_result_9_memRead : _GEN_3161; // @[CPU6502Core.scala 279:20 509:27]
  wire [15:0] _GEN_3181 = 8'h6c == opcode ? execResult_result_result_49_operand : _GEN_3162; // @[CPU6502Core.scala 279:20 509:27]
  wire  _GEN_3182 = 8'h4c == opcode ? execResult_result_result_6_done : _GEN_3163; // @[CPU6502Core.scala 279:20 508:27]
  wire [2:0] execResult_result_result_48_nextCycle = _GEN_887[2:0]; // @[Jump.scala 13:22]
  wire [2:0] _GEN_3183 = 8'h4c == opcode ? execResult_result_result_48_nextCycle : _GEN_3164; // @[CPU6502Core.scala 279:20 508:27]
  wire [7:0] _GEN_3187 = 8'h4c == opcode ? regs_sp : _GEN_3168; // @[CPU6502Core.scala 279:20 508:27]
  wire [15:0] _GEN_3188 = 8'h4c == opcode ? execResult_result_newRegs_47_pc : _GEN_3169; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3189 = 8'h4c == opcode ? regs_flagC : _GEN_3170; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3190 = 8'h4c == opcode ? regs_flagZ : _GEN_3171; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3191 = 8'h4c == opcode ? regs_flagI : _GEN_3172; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3192 = 8'h4c == opcode ? regs_flagD : _GEN_3173; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3194 = 8'h4c == opcode ? regs_flagV : _GEN_3175; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3195 = 8'h4c == opcode ? regs_flagN : _GEN_3176; // @[CPU6502Core.scala 279:20 508:27]
  wire [15:0] _GEN_3196 = 8'h4c == opcode ? execResult_result_result_48_memAddr : _GEN_3177; // @[CPU6502Core.scala 279:20 508:27]
  wire [7:0] _GEN_3197 = 8'h4c == opcode ? 8'h0 : _GEN_3178; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3198 = 8'h4c == opcode ? 1'h0 : _GEN_3179; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3199 = 8'h4c == opcode ? execResult_result_result_6_memRead : _GEN_3180; // @[CPU6502Core.scala 279:20 508:27]
  wire [15:0] _GEN_3200 = 8'h4c == opcode ? execResult_result_result_8_operand : _GEN_3181; // @[CPU6502Core.scala 279:20 508:27]
  wire  _GEN_3201 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_6_done : _GEN_3182; // @[CPU6502Core.scala 279:20 504:16]
  wire [2:0] _GEN_3202 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_48_nextCycle : _GEN_3183; // @[CPU6502Core.scala 279:20 504:16]
  wire [7:0] _GEN_3203 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_a : regs_a; // @[CPU6502Core.scala 279:20 504:16]
  wire [7:0] _GEN_3206 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_sp : _GEN_3187; // @[CPU6502Core.scala 279:20 504:16]
  wire [15:0] _GEN_3207 = 8'h68 == opcode | 8'h28 == opcode ? regs_pc : _GEN_3188; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3208 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagC : _GEN_3189; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3209 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagZ : _GEN_3190; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3210 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagI : _GEN_3191; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3211 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagD : _GEN_3192; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3213 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagV : _GEN_3194; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3214 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagN : _GEN_3195; // @[CPU6502Core.scala 279:20 504:16]
  wire [15:0] _GEN_3215 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_47_memAddr : _GEN_3196; // @[CPU6502Core.scala 279:20 504:16]
  wire [7:0] _GEN_3216 = 8'h68 == opcode | 8'h28 == opcode ? 8'h0 : _GEN_3197; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3217 = 8'h68 == opcode | 8'h28 == opcode ? 1'h0 : _GEN_3198; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3218 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_6_done : _GEN_3199; // @[CPU6502Core.scala 279:20 504:16]
  wire [15:0] _GEN_3219 = 8'h68 == opcode | 8'h28 == opcode ? 16'h0 : _GEN_3200; // @[CPU6502Core.scala 279:20 504:16]
  wire  _GEN_3220 = 8'h48 == opcode | 8'h8 == opcode | _GEN_3201; // @[CPU6502Core.scala 279:20 499:16]
  wire [2:0] _GEN_3221 = 8'h48 == opcode | 8'h8 == opcode ? 3'h0 : _GEN_3202; // @[CPU6502Core.scala 279:20 499:16]
  wire [7:0] _GEN_3222 = 8'h48 == opcode | 8'h8 == opcode ? regs_a : _GEN_3203; // @[CPU6502Core.scala 279:20 499:16]
  wire [7:0] _GEN_3225 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_newRegs_45_sp : _GEN_3206; // @[CPU6502Core.scala 279:20 499:16]
  wire [15:0] _GEN_3226 = 8'h48 == opcode | 8'h8 == opcode ? regs_pc : _GEN_3207; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3227 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagC : _GEN_3208; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3228 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagZ : _GEN_3209; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3229 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagI : _GEN_3210; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3230 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagD : _GEN_3211; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3232 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagV : _GEN_3213; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3233 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagN : _GEN_3214; // @[CPU6502Core.scala 279:20 499:16]
  wire [15:0] _GEN_3234 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_result_46_memAddr : _GEN_3215; // @[CPU6502Core.scala 279:20 499:16]
  wire [7:0] _GEN_3235 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_pushData : _GEN_3216; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3236 = 8'h48 == opcode | 8'h8 == opcode | _GEN_3217; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3237 = 8'h48 == opcode | 8'h8 == opcode ? 1'h0 : _GEN_3218; // @[CPU6502Core.scala 279:20 499:16]
  wire [15:0] _GEN_3238 = 8'h48 == opcode | 8'h8 == opcode ? 16'h0 : _GEN_3219; // @[CPU6502Core.scala 279:20 499:16]
  wire  _GEN_3239 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_44_done : _GEN_3220; // @[CPU6502Core.scala 279:20 494:16]
  wire [2:0] _GEN_3240 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_49_nextCycle : _GEN_3221; // @[CPU6502Core.scala 279:20 494:16]
  wire [7:0] _GEN_3241 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_a : _GEN_3222; // @[CPU6502Core.scala 279:20 494:16]
  wire [7:0] _GEN_3244 = 8'h91 == opcode | 8'hb1 == opcode ? regs_sp : _GEN_3225; // @[CPU6502Core.scala 279:20 494:16]
  wire [15:0] _GEN_3245 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3226; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3246 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagC : _GEN_3227; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3247 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_flagZ : _GEN_3228; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3248 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagI : _GEN_3229; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3249 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagD : _GEN_3230; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3251 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagV : _GEN_3232; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3252 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_flagN : _GEN_3233; // @[CPU6502Core.scala 279:20 494:16]
  wire [15:0] _GEN_3253 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memAddr : _GEN_3234; // @[CPU6502Core.scala 279:20 494:16]
  wire [7:0] _GEN_3254 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memData : _GEN_3235; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3255 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memWrite : _GEN_3236; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3256 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memRead : _GEN_3237; // @[CPU6502Core.scala 279:20 494:16]
  wire [15:0] _GEN_3257 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_36_operand : _GEN_3238; // @[CPU6502Core.scala 279:20 494:16]
  wire  _GEN_3258 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_done : _GEN_3239; // @[CPU6502Core.scala 279:20 489:16]
  wire [2:0] _GEN_3259 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_49_nextCycle : _GEN_3240; // @[CPU6502Core.scala 279:20 489:16]
  wire [7:0] _GEN_3260 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_a : _GEN_3241; // @[CPU6502Core.scala 279:20 489:16]
  wire [7:0] _GEN_3263 = 8'ha1 == opcode | 8'h81 == opcode ? regs_sp : _GEN_3244; // @[CPU6502Core.scala 279:20 489:16]
  wire [15:0] _GEN_3264 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_5_pc : _GEN_3245; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3265 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagC : _GEN_3246; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3266 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_flagZ : _GEN_3247; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3267 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagI : _GEN_3248; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3268 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagD : _GEN_3249; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3270 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagV : _GEN_3251; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3271 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_flagN : _GEN_3252; // @[CPU6502Core.scala 279:20 489:16]
  wire [15:0] _GEN_3272 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_9_memAddr : _GEN_3253; // @[CPU6502Core.scala 279:20 489:16]
  wire [7:0] _GEN_3273 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memData : _GEN_3254; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3274 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memWrite : _GEN_3255; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3275 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memRead : _GEN_3256; // @[CPU6502Core.scala 279:20 489:16]
  wire [15:0] _GEN_3276 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_9_operand : _GEN_3257; // @[CPU6502Core.scala 279:20 489:16]
  wire  _GEN_3277 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_8_done : _GEN_3258; // @[CPU6502Core.scala 279:20 484:16]
  wire [2:0] _GEN_3278 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_51_nextCycle : _GEN_3259; // @[CPU6502Core.scala 279:20 484:16]
  wire [7:0] _GEN_3279 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_42_a : _GEN_3260; // @[CPU6502Core.scala 279:20 484:16]
  wire [7:0] _GEN_3282 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? regs_sp : _GEN_3263; // @[CPU6502Core.scala 279:20 484:16]
  wire [15:0] _GEN_3283 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3264; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3284 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagC : _GEN_3265; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3285 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_42_flagZ : _GEN_3266; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3286 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagI : _GEN_3267; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3287 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagD : _GEN_3268; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3289 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagV : _GEN_3270; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3290 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_42_flagN : _GEN_3271; // @[CPU6502Core.scala 279:20 484:16]
  wire [15:0] _GEN_3291 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_8_memAddr : _GEN_3272; // @[CPU6502Core.scala 279:20 484:16]
  wire [7:0] _GEN_3292 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? 8'h0 : _GEN_3273; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3293 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? 1'h0 : _GEN_3274; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3294 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_8_memRead : _GEN_3275; // @[CPU6502Core.scala 279:20 484:16]
  wire [15:0] _GEN_3295 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_43_operand : _GEN_3276; // @[CPU6502Core.scala 279:20 484:16]
  wire  _GEN_3296 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_done : _GEN_3277; // @[CPU6502Core.scala 279:20 479:16]
  wire [2:0] _GEN_3297 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_52_nextCycle : _GEN_3278; // @[CPU6502Core.scala 279:20 479:16]
  wire [7:0] _GEN_3298 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_a : _GEN_3279; // @[CPU6502Core.scala 279:20 479:16]
  wire [7:0] _GEN_3299 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_x : regs_x; // @[CPU6502Core.scala 279:20 479:16]
  wire [7:0] _GEN_3300 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_y : regs_y; // @[CPU6502Core.scala 279:20 479:16]
  wire [7:0] _GEN_3301 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? regs_sp : _GEN_3282; // @[CPU6502Core.scala 279:20 479:16]
  wire [15:0] _GEN_3302 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_pc : _GEN_3283; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3303 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagC : _GEN_3284; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3304 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_41_flagZ : _GEN_3285; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3305 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagI : _GEN_3286; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3306 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagD : _GEN_3287; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3308 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagV : _GEN_3289; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3309 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_41_flagN : _GEN_3290; // @[CPU6502Core.scala 279:20 479:16]
  wire [15:0] _GEN_3310 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_42_memAddr : _GEN_3291; // @[CPU6502Core.scala 279:20 479:16]
  wire [7:0] _GEN_3311 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_42_memData : _GEN_3292; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3312 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_memWrite : _GEN_3293; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3313 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_memRead : _GEN_3294; // @[CPU6502Core.scala 279:20 479:16]
  wire [15:0] _GEN_3314 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_42_operand : _GEN_3295; // @[CPU6502Core.scala 279:20 479:16]
  wire  _GEN_3315 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_done : _GEN_3296; // @[CPU6502Core.scala 279:20 474:16]
  wire [2:0] _GEN_3316 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_49_nextCycle : _GEN_3297; // @[CPU6502Core.scala 279:20 474:16]
  wire [7:0] _GEN_3317 = 8'hb6 == opcode | 8'h96 == opcode ? regs_a : _GEN_3298; // @[CPU6502Core.scala 279:20 474:16]
  wire [7:0] _GEN_3318 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_x : _GEN_3299; // @[CPU6502Core.scala 279:20 474:16]
  wire [7:0] _GEN_3319 = 8'hb6 == opcode | 8'h96 == opcode ? regs_y : _GEN_3300; // @[CPU6502Core.scala 279:20 474:16]
  wire [7:0] _GEN_3320 = 8'hb6 == opcode | 8'h96 == opcode ? regs_sp : _GEN_3301; // @[CPU6502Core.scala 279:20 474:16]
  wire [15:0] _GEN_3321 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_5_pc : _GEN_3302; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3322 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagC : _GEN_3303; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3323 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_flagZ : _GEN_3304; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3324 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagI : _GEN_3305; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3325 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagD : _GEN_3306; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3327 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagV : _GEN_3308; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3328 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_flagN : _GEN_3309; // @[CPU6502Core.scala 279:20 474:16]
  wire [15:0] _GEN_3329 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_memAddr : _GEN_3310; // @[CPU6502Core.scala 279:20 474:16]
  wire [7:0] _GEN_3330 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memData : _GEN_3311; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3331 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memWrite : _GEN_3312; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3332 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memRead : _GEN_3313; // @[CPU6502Core.scala 279:20 474:16]
  wire [15:0] _GEN_3333 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_operand : _GEN_3314; // @[CPU6502Core.scala 279:20 474:16]
  wire  _GEN_3334 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_6_done : _GEN_3315; // @[CPU6502Core.scala 279:20 469:16]
  wire [2:0] _GEN_3335 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_48_nextCycle : _GEN_3316; // @[CPU6502Core.scala 279:20 469:16]
  wire [7:0] _GEN_3336 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_a : _GEN_3317; // @[CPU6502Core.scala 279:20 469:16]
  wire [7:0] _GEN_3337 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_x : _GEN_3318; // @[CPU6502Core.scala 279:20 469:16]
  wire [7:0] _GEN_3338 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_y : _GEN_3319; // @[CPU6502Core.scala 279:20 469:16]
  wire [7:0] _GEN_3339 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_sp : _GEN_3320; // @[CPU6502Core.scala 279:20 469:16]
  wire [15:0] _GEN_3340 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3321; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3341 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagC : _GEN_3322; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3342 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_flagZ : _GEN_3323; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3343 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagI : _GEN_3324; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3344 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagD : _GEN_3325; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3346 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagV : _GEN_3327; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3347 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_flagN : _GEN_3328; // @[CPU6502Core.scala 279:20 469:16]
  wire [15:0] _GEN_3348 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_6_memAddr : _GEN_3329; // @[CPU6502Core.scala 279:20 469:16]
  wire [7:0] _GEN_3349 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memData : _GEN_3330; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3350 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memWrite : _GEN_3331; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3351 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memRead : _GEN_3332; // @[CPU6502Core.scala 279:20 469:16]
  wire [15:0] _GEN_3352 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_7_operand : _GEN_3333; // @[CPU6502Core.scala 279:20 469:16]
  wire  _GEN_3353 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_6_done : _GEN_3334; // @[CPU6502Core.scala 279:20 464:16]
  wire [2:0] _GEN_3354 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_48_nextCycle : _GEN_3335; // @[CPU6502Core.scala 279:20 464:16]
  wire [7:0] _GEN_3355 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_a : _GEN_3336; // @[CPU6502Core.scala 279:20 464:16]
  wire [7:0] _GEN_3356 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_x : _GEN_3337; // @[CPU6502Core.scala 279:20 464:16]
  wire [7:0] _GEN_3357 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_y : _GEN_3338; // @[CPU6502Core.scala 279:20 464:16]
  wire [7:0] _GEN_3358 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? regs_sp : _GEN_3339; // @[CPU6502Core.scala 279:20 464:16]
  wire [15:0] _GEN_3359 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_5_pc : _GEN_3340; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3360 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagC : _GEN_3341; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3361 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_38_flagZ : _GEN_3342; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3362 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagI : _GEN_3343; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3363 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagD : _GEN_3344; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3365 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagV : _GEN_3346; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3366 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_38_flagN : _GEN_3347; // @[CPU6502Core.scala 279:20 464:16]
  wire [15:0] _GEN_3367 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_memAddr : _GEN_3348; // @[CPU6502Core.scala 279:20 464:16]
  wire [7:0] _GEN_3368 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_39_memData : _GEN_3349; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3369 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_39_memWrite : _GEN_3350; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3370 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_39_memRead : _GEN_3351; // @[CPU6502Core.scala 279:20 464:16]
  wire [15:0] _GEN_3371 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_operand : _GEN_3352; // @[CPU6502Core.scala 279:20 464:16]
  wire  _GEN_3372 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_3353; // @[CPU6502Core.scala 279:20 459:16]
  wire [2:0] _GEN_3373 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 3'h0 : _GEN_3354; // @[CPU6502Core.scala 279:20 459:16]
  wire [7:0] _GEN_3374 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_a :
    _GEN_3355; // @[CPU6502Core.scala 279:20 459:16]
  wire [7:0] _GEN_3375 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_x :
    _GEN_3356; // @[CPU6502Core.scala 279:20 459:16]
  wire [7:0] _GEN_3376 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_y :
    _GEN_3357; // @[CPU6502Core.scala 279:20 459:16]
  wire [7:0] _GEN_3377 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_sp : _GEN_3358; // @[CPU6502Core.scala 279:20 459:16]
  wire [15:0] _GEN_3378 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? _regs_pc_T_1 : _GEN_3359; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3379 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagC : _GEN_3360; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3380 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_37_flagZ : _GEN_3361
    ; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3381 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagI : _GEN_3362; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3382 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagD : _GEN_3363; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3384 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagV : _GEN_3365; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3385 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? io_memDataIn[7] : _GEN_3366; // @[CPU6502Core.scala 279:20 459:16]
  wire [15:0] _GEN_3386 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_pc : _GEN_3367; // @[CPU6502Core.scala 279:20 459:16]
  wire [7:0] _GEN_3387 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 8'h0 : _GEN_3368; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3388 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 1'h0 : _GEN_3369; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3389 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 1'h0 : _GEN_3370; // @[CPU6502Core.scala 279:20 459:16]
  wire [15:0] _GEN_3390 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 16'h0 : _GEN_3371; // @[CPU6502Core.scala 279:20 459:16]
  wire  _GEN_3391 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_3372; // @[CPU6502Core.scala 279:20 454:16]
  wire [2:0] _GEN_3392 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 3'h0 : _GEN_3373; // @[CPU6502Core.scala 279:20 454:16]
  wire [7:0] _GEN_3393 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_a : _GEN_3374; // @[CPU6502Core.scala 279:20 454:16]
  wire [7:0] _GEN_3394 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_x : _GEN_3375; // @[CPU6502Core.scala 279:20 454:16]
  wire [7:0] _GEN_3395 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_y : _GEN_3376; // @[CPU6502Core.scala 279:20 454:16]
  wire [7:0] _GEN_3396 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_sp : _GEN_3377; // @[CPU6502Core.scala 279:20 454:16]
  wire [15:0] _GEN_3397 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? execResult_result_newRegs_36_pc : _GEN_3378; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3398 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagC : _GEN_3379; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3399 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagZ : _GEN_3380; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3400 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagI : _GEN_3381; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3401 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagD : _GEN_3382; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3403 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagV : _GEN_3384; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3404 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagN : _GEN_3385; // @[CPU6502Core.scala 279:20 454:16]
  wire [15:0] _GEN_3405 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_pc : _GEN_3386; // @[CPU6502Core.scala 279:20 454:16]
  wire [7:0] _GEN_3406 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 8'h0 : _GEN_3387; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3407 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? 1'h0 : _GEN_3388; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3408 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_3389; // @[CPU6502Core.scala 279:20 454:16]
  wire [15:0] _GEN_3409 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 16'h0 : _GEN_3390; // @[CPU6502Core.scala 279:20 454:16]
  wire  _GEN_3410 = 8'hd2 == opcode ? execResult_result_result_9_done : _GEN_3391; // @[CPU6502Core.scala 279:20 449:16]
  wire [2:0] _GEN_3411 = 8'hd2 == opcode ? execResult_result_result_49_nextCycle : _GEN_3392; // @[CPU6502Core.scala 279:20 449:16]
  wire [7:0] _GEN_3412 = 8'hd2 == opcode ? regs_a : _GEN_3393; // @[CPU6502Core.scala 279:20 449:16]
  wire [7:0] _GEN_3413 = 8'hd2 == opcode ? regs_x : _GEN_3394; // @[CPU6502Core.scala 279:20 449:16]
  wire [7:0] _GEN_3414 = 8'hd2 == opcode ? regs_y : _GEN_3395; // @[CPU6502Core.scala 279:20 449:16]
  wire [7:0] _GEN_3415 = 8'hd2 == opcode ? regs_sp : _GEN_3396; // @[CPU6502Core.scala 279:20 449:16]
  wire [15:0] _GEN_3416 = 8'hd2 == opcode ? execResult_result_newRegs_5_pc : _GEN_3397; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3417 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3398; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3418 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3399; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3419 = 8'hd2 == opcode ? regs_flagI : _GEN_3400; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3420 = 8'hd2 == opcode ? regs_flagD : _GEN_3401; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3422 = 8'hd2 == opcode ? regs_flagV : _GEN_3403; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3423 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3404; // @[CPU6502Core.scala 279:20 449:16]
  wire [15:0] _GEN_3424 = 8'hd2 == opcode ? execResult_result_result_9_memAddr : _GEN_3405; // @[CPU6502Core.scala 279:20 449:16]
  wire [7:0] _GEN_3425 = 8'hd2 == opcode ? 8'h0 : _GEN_3406; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3426 = 8'hd2 == opcode ? 1'h0 : _GEN_3407; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3427 = 8'hd2 == opcode ? execResult_result_result_9_memRead : _GEN_3408; // @[CPU6502Core.scala 279:20 449:16]
  wire [15:0] _GEN_3428 = 8'hd2 == opcode ? execResult_result_result_36_operand : _GEN_3409; // @[CPU6502Core.scala 279:20 449:16]
  wire  _GEN_3429 = 8'hd1 == opcode ? execResult_result_result_9_done : _GEN_3410; // @[CPU6502Core.scala 279:20 444:16]
  wire [2:0] _GEN_3430 = 8'hd1 == opcode ? execResult_result_result_49_nextCycle : _GEN_3411; // @[CPU6502Core.scala 279:20 444:16]
  wire [7:0] _GEN_3431 = 8'hd1 == opcode ? regs_a : _GEN_3412; // @[CPU6502Core.scala 279:20 444:16]
  wire [7:0] _GEN_3432 = 8'hd1 == opcode ? regs_x : _GEN_3413; // @[CPU6502Core.scala 279:20 444:16]
  wire [7:0] _GEN_3433 = 8'hd1 == opcode ? regs_y : _GEN_3414; // @[CPU6502Core.scala 279:20 444:16]
  wire [7:0] _GEN_3434 = 8'hd1 == opcode ? regs_sp : _GEN_3415; // @[CPU6502Core.scala 279:20 444:16]
  wire [15:0] _GEN_3435 = 8'hd1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3416; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3436 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3417; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3437 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3418; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3438 = 8'hd1 == opcode ? regs_flagI : _GEN_3419; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3439 = 8'hd1 == opcode ? regs_flagD : _GEN_3420; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3441 = 8'hd1 == opcode ? regs_flagV : _GEN_3422; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3442 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3423; // @[CPU6502Core.scala 279:20 444:16]
  wire [15:0] _GEN_3443 = 8'hd1 == opcode ? execResult_result_result_9_memAddr : _GEN_3424; // @[CPU6502Core.scala 279:20 444:16]
  wire [7:0] _GEN_3444 = 8'hd1 == opcode ? 8'h0 : _GEN_3425; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3445 = 8'hd1 == opcode ? 1'h0 : _GEN_3426; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3446 = 8'hd1 == opcode ? execResult_result_result_9_memRead : _GEN_3427; // @[CPU6502Core.scala 279:20 444:16]
  wire [15:0] _GEN_3447 = 8'hd1 == opcode ? execResult_result_result_10_operand : _GEN_3428; // @[CPU6502Core.scala 279:20 444:16]
  wire  _GEN_3448 = 8'hc1 == opcode ? execResult_result_result_9_done : _GEN_3429; // @[CPU6502Core.scala 279:20 439:16]
  wire [2:0] _GEN_3449 = 8'hc1 == opcode ? execResult_result_result_49_nextCycle : _GEN_3430; // @[CPU6502Core.scala 279:20 439:16]
  wire [7:0] _GEN_3450 = 8'hc1 == opcode ? regs_a : _GEN_3431; // @[CPU6502Core.scala 279:20 439:16]
  wire [7:0] _GEN_3451 = 8'hc1 == opcode ? regs_x : _GEN_3432; // @[CPU6502Core.scala 279:20 439:16]
  wire [7:0] _GEN_3452 = 8'hc1 == opcode ? regs_y : _GEN_3433; // @[CPU6502Core.scala 279:20 439:16]
  wire [7:0] _GEN_3453 = 8'hc1 == opcode ? regs_sp : _GEN_3434; // @[CPU6502Core.scala 279:20 439:16]
  wire [15:0] _GEN_3454 = 8'hc1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3435; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3455 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3436; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3456 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3437; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3457 = 8'hc1 == opcode ? regs_flagI : _GEN_3438; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3458 = 8'hc1 == opcode ? regs_flagD : _GEN_3439; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3460 = 8'hc1 == opcode ? regs_flagV : _GEN_3441; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3461 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3442; // @[CPU6502Core.scala 279:20 439:16]
  wire [15:0] _GEN_3462 = 8'hc1 == opcode ? execResult_result_result_9_memAddr : _GEN_3443; // @[CPU6502Core.scala 279:20 439:16]
  wire [7:0] _GEN_3463 = 8'hc1 == opcode ? 8'h0 : _GEN_3444; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3464 = 8'hc1 == opcode ? 1'h0 : _GEN_3445; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3465 = 8'hc1 == opcode ? execResult_result_result_9_memRead : _GEN_3446; // @[CPU6502Core.scala 279:20 439:16]
  wire [15:0] _GEN_3466 = 8'hc1 == opcode ? execResult_result_result_9_operand : _GEN_3447; // @[CPU6502Core.scala 279:20 439:16]
  wire  _GEN_3467 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_done : _GEN_3448; // @[CPU6502Core.scala 279:20 434:16]
  wire [2:0] _GEN_3468 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_49_nextCycle : _GEN_3449; // @[CPU6502Core.scala 279:20 434:16]
  wire [7:0] _GEN_3469 = 8'hdd == opcode | 8'hd9 == opcode ? regs_a : _GEN_3450; // @[CPU6502Core.scala 279:20 434:16]
  wire [7:0] _GEN_3470 = 8'hdd == opcode | 8'hd9 == opcode ? regs_x : _GEN_3451; // @[CPU6502Core.scala 279:20 434:16]
  wire [7:0] _GEN_3471 = 8'hdd == opcode | 8'hd9 == opcode ? regs_y : _GEN_3452; // @[CPU6502Core.scala 279:20 434:16]
  wire [7:0] _GEN_3472 = 8'hdd == opcode | 8'hd9 == opcode ? regs_sp : _GEN_3453; // @[CPU6502Core.scala 279:20 434:16]
  wire [15:0] _GEN_3473 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_7_pc : _GEN_3454; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3474 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagC : _GEN_3455; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3475 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagZ : _GEN_3456; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3476 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagI : _GEN_3457; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3477 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagD : _GEN_3458; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3479 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagV : _GEN_3460; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3480 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagN : _GEN_3461; // @[CPU6502Core.scala 279:20 434:16]
  wire [15:0] _GEN_3481 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_memAddr : _GEN_3462; // @[CPU6502Core.scala 279:20 434:16]
  wire [7:0] _GEN_3482 = 8'hdd == opcode | 8'hd9 == opcode ? 8'h0 : _GEN_3463; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3483 = 8'hdd == opcode | 8'hd9 == opcode ? 1'h0 : _GEN_3464; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3484 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_memRead : _GEN_3465; // @[CPU6502Core.scala 279:20 434:16]
  wire [15:0] _GEN_3485 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_33_operand : _GEN_3466; // @[CPU6502Core.scala 279:20 434:16]
  wire  _GEN_3486 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_done : _GEN_3467; // @[CPU6502Core.scala 279:20 429:16]
  wire [2:0] _GEN_3487 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_49_nextCycle :
    _GEN_3468; // @[CPU6502Core.scala 279:20 429:16]
  wire [7:0] _GEN_3488 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_a : _GEN_3469; // @[CPU6502Core.scala 279:20 429:16]
  wire [7:0] _GEN_3489 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_x : _GEN_3470; // @[CPU6502Core.scala 279:20 429:16]
  wire [7:0] _GEN_3490 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_y : _GEN_3471; // @[CPU6502Core.scala 279:20 429:16]
  wire [7:0] _GEN_3491 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_sp : _GEN_3472; // @[CPU6502Core.scala 279:20 429:16]
  wire [15:0] _GEN_3492 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_7_pc :
    _GEN_3473; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3493 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagC : _GEN_3474
    ; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3494 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagZ : _GEN_3475
    ; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3495 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagI : _GEN_3476; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3496 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagD : _GEN_3477; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3498 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagV : _GEN_3479; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3499 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagN : _GEN_3480
    ; // @[CPU6502Core.scala 279:20 429:16]
  wire [15:0] _GEN_3500 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_memAddr :
    _GEN_3481; // @[CPU6502Core.scala 279:20 429:16]
  wire [7:0] _GEN_3501 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 8'h0 : _GEN_3482; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3502 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 1'h0 : _GEN_3483; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3503 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_memRead : _GEN_3484
    ; // @[CPU6502Core.scala 279:20 429:16]
  wire [15:0] _GEN_3504 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_operand :
    _GEN_3485; // @[CPU6502Core.scala 279:20 429:16]
  wire  _GEN_3505 = 8'hd5 == opcode ? execResult_result_result_6_done : _GEN_3486; // @[CPU6502Core.scala 279:20 424:16]
  wire [2:0] _GEN_3506 = 8'hd5 == opcode ? execResult_result_result_49_nextCycle : _GEN_3487; // @[CPU6502Core.scala 279:20 424:16]
  wire [7:0] _GEN_3507 = 8'hd5 == opcode ? regs_a : _GEN_3488; // @[CPU6502Core.scala 279:20 424:16]
  wire [7:0] _GEN_3508 = 8'hd5 == opcode ? regs_x : _GEN_3489; // @[CPU6502Core.scala 279:20 424:16]
  wire [7:0] _GEN_3509 = 8'hd5 == opcode ? regs_y : _GEN_3490; // @[CPU6502Core.scala 279:20 424:16]
  wire [7:0] _GEN_3510 = 8'hd5 == opcode ? regs_sp : _GEN_3491; // @[CPU6502Core.scala 279:20 424:16]
  wire [15:0] _GEN_3511 = 8'hd5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3492; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3512 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagC : _GEN_3493; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3513 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagZ : _GEN_3494; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3514 = 8'hd5 == opcode ? regs_flagI : _GEN_3495; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3515 = 8'hd5 == opcode ? regs_flagD : _GEN_3496; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3517 = 8'hd5 == opcode ? regs_flagV : _GEN_3498; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3518 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagN : _GEN_3499; // @[CPU6502Core.scala 279:20 424:16]
  wire [15:0] _GEN_3519 = 8'hd5 == opcode ? execResult_result_result_6_memAddr : _GEN_3500; // @[CPU6502Core.scala 279:20 424:16]
  wire [7:0] _GEN_3520 = 8'hd5 == opcode ? 8'h0 : _GEN_3501; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3521 = 8'hd5 == opcode ? 1'h0 : _GEN_3502; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3522 = 8'hd5 == opcode ? execResult_result_result_6_memRead : _GEN_3503; // @[CPU6502Core.scala 279:20 424:16]
  wire [15:0] _GEN_3523 = 8'hd5 == opcode ? execResult_result_result_7_operand : _GEN_3504; // @[CPU6502Core.scala 279:20 424:16]
  wire  _GEN_3524 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_done : _GEN_3505; // @[CPU6502Core.scala 279:20 419:16]
  wire [2:0] _GEN_3525 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_49_nextCycle :
    _GEN_3506; // @[CPU6502Core.scala 279:20 419:16]
  wire [7:0] _GEN_3526 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_a : _GEN_3507; // @[CPU6502Core.scala 279:20 419:16]
  wire [7:0] _GEN_3527 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_x : _GEN_3508; // @[CPU6502Core.scala 279:20 419:16]
  wire [7:0] _GEN_3528 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_y : _GEN_3509; // @[CPU6502Core.scala 279:20 419:16]
  wire [7:0] _GEN_3529 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_sp : _GEN_3510; // @[CPU6502Core.scala 279:20 419:16]
  wire [15:0] _GEN_3530 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3511; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3531 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagC : _GEN_3512
    ; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3532 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagZ : _GEN_3513
    ; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3533 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagI : _GEN_3514; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3534 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagD : _GEN_3515; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3536 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagV : _GEN_3517; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3537 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagN : _GEN_3518
    ; // @[CPU6502Core.scala 279:20 419:16]
  wire [15:0] _GEN_3538 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3519; // @[CPU6502Core.scala 279:20 419:16]
  wire [7:0] _GEN_3539 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 8'h0 : _GEN_3520; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3540 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 1'h0 : _GEN_3521; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3541 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memRead : _GEN_3522
    ; // @[CPU6502Core.scala 279:20 419:16]
  wire [15:0] _GEN_3542 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_operand :
    _GEN_3523; // @[CPU6502Core.scala 279:20 419:16]
  wire  _GEN_3543 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_3524; // @[CPU6502Core.scala 279:20 414:16]
  wire [2:0] _GEN_3544 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 3'h0 : _GEN_3525; // @[CPU6502Core.scala 279:20 414:16]
  wire [7:0] _GEN_3545 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_a : _GEN_3526; // @[CPU6502Core.scala 279:20 414:16]
  wire [7:0] _GEN_3546 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_x : _GEN_3527; // @[CPU6502Core.scala 279:20 414:16]
  wire [7:0] _GEN_3547 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_y : _GEN_3528; // @[CPU6502Core.scala 279:20 414:16]
  wire [7:0] _GEN_3548 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_sp : _GEN_3529; // @[CPU6502Core.scala 279:20 414:16]
  wire [15:0] _GEN_3549 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? _regs_pc_T_1 : _GEN_3530; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3550 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagC : _GEN_3531
    ; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3551 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagZ : _GEN_3532
    ; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3552 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagI : _GEN_3533; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3553 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagD : _GEN_3534; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3555 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagV : _GEN_3536; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3556 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagN : _GEN_3537
    ; // @[CPU6502Core.scala 279:20 414:16]
  wire [15:0] _GEN_3557 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_pc : _GEN_3538; // @[CPU6502Core.scala 279:20 414:16]
  wire [7:0] _GEN_3558 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 8'h0 : _GEN_3539; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3559 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 1'h0 : _GEN_3540; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3560 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_3541; // @[CPU6502Core.scala 279:20 414:16]
  wire [15:0] _GEN_3561 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 16'h0 : _GEN_3542; // @[CPU6502Core.scala 279:20 414:16]
  wire  _GEN_3562 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_9_done : _GEN_3543; // @[CPU6502Core.scala 279:20 409:16]
  wire [2:0] _GEN_3563 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_49_nextCycle : _GEN_3544; // @[CPU6502Core.scala 279:20 409:16]
  wire [7:0] _GEN_3564 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_a : _GEN_3545; // @[CPU6502Core.scala 279:20 409:16]
  wire [7:0] _GEN_3565 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_x : _GEN_3546; // @[CPU6502Core.scala 279:20 409:16]
  wire [7:0] _GEN_3566 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_y : _GEN_3547; // @[CPU6502Core.scala 279:20 409:16]
  wire [7:0] _GEN_3567 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_sp : _GEN_3548; // @[CPU6502Core.scala 279:20 409:16]
  wire [15:0] _GEN_3568 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_newRegs_7_pc : _GEN_3549; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3569 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_newRegs_26_flagC : _GEN_3550; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3570 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_newRegs_26_flagZ : _GEN_3551; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3571 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_flagI : _GEN_3552; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3572 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_flagD : _GEN_3553; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3574 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_flagV : _GEN_3555; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3575 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_newRegs_26_flagN : _GEN_3556; // @[CPU6502Core.scala 279:20 409:16]
  wire [15:0] _GEN_3576 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_13_memAddr : _GEN_3557; // @[CPU6502Core.scala 279:20 409:16]
  wire [7:0] _GEN_3577 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_27_memData : _GEN_3558; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3578 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_9_done : _GEN_3559; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3579 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_8_memRead : _GEN_3560; // @[CPU6502Core.scala 279:20 409:16]
  wire [15:0] _GEN_3580 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_14_operand : _GEN_3561; // @[CPU6502Core.scala 279:20 409:16]
  wire  _GEN_3581 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_9_done : _GEN_3562; // @[CPU6502Core.scala 279:20 404:16]
  wire [2:0] _GEN_3582 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_49_nextCycle : _GEN_3563; // @[CPU6502Core.scala 279:20 404:16]
  wire [7:0] _GEN_3583 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_a : _GEN_3564; // @[CPU6502Core.scala 279:20 404:16]
  wire [7:0] _GEN_3584 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_x : _GEN_3565; // @[CPU6502Core.scala 279:20 404:16]
  wire [7:0] _GEN_3585 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_y : _GEN_3566; // @[CPU6502Core.scala 279:20 404:16]
  wire [7:0] _GEN_3586 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_sp : _GEN_3567; // @[CPU6502Core.scala 279:20 404:16]
  wire [15:0] _GEN_3587 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_7_pc : _GEN_3568; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3588 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagC : _GEN_3569; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3589 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagZ : _GEN_3570; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3590 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagI : _GEN_3571; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3591 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagD : _GEN_3572; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3593 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagV : _GEN_3574; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3594 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagN : _GEN_3575; // @[CPU6502Core.scala 279:20 404:16]
  wire [15:0] _GEN_3595 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_13_memAddr : _GEN_3576; // @[CPU6502Core.scala 279:20 404:16]
  wire [7:0] _GEN_3596 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_27_memData : _GEN_3577; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3597 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_9_done : _GEN_3578; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3598 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_8_memRead : _GEN_3579; // @[CPU6502Core.scala 279:20 404:16]
  wire [15:0] _GEN_3599 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_8_operand : _GEN_3580; // @[CPU6502Core.scala 279:20 404:16]
  wire  _GEN_3600 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_8_done : _GEN_3581; // @[CPU6502Core.scala 279:20 399:16]
  wire [2:0] _GEN_3601 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_49_nextCycle : _GEN_3582; // @[CPU6502Core.scala 279:20 399:16]
  wire [7:0] _GEN_3602 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_a : _GEN_3583; // @[CPU6502Core.scala 279:20 399:16]
  wire [7:0] _GEN_3603 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_x : _GEN_3584; // @[CPU6502Core.scala 279:20 399:16]
  wire [7:0] _GEN_3604 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_y : _GEN_3585; // @[CPU6502Core.scala 279:20 399:16]
  wire [7:0] _GEN_3605 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_sp : _GEN_3586; // @[CPU6502Core.scala 279:20 399:16]
  wire [15:0] _GEN_3606 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3587; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3607 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagC : _GEN_3588; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3608 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagZ : _GEN_3589; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3609 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagI : _GEN_3590; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3610 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagD : _GEN_3591; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3612 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagV : _GEN_3593; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3613 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagN : _GEN_3594; // @[CPU6502Core.scala 279:20 399:16]
  wire [15:0] _GEN_3614 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_11_memAddr : _GEN_3595; // @[CPU6502Core.scala 279:20 399:16]
  wire [7:0] _GEN_3615 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_26_memData : _GEN_3596; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3616 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_8_done : _GEN_3597; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3617 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_6_memRead : _GEN_3598; // @[CPU6502Core.scala 279:20 399:16]
  wire [15:0] _GEN_3618 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_7_operand : _GEN_3599; // @[CPU6502Core.scala 279:20 399:16]
  wire  _GEN_3619 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_8_done : _GEN_3600; // @[CPU6502Core.scala 279:20 394:16]
  wire [2:0] _GEN_3620 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_51_nextCycle : _GEN_3601; // @[CPU6502Core.scala 279:20 394:16]
  wire [7:0] _GEN_3621 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_a : _GEN_3602; // @[CPU6502Core.scala 279:20 394:16]
  wire [7:0] _GEN_3622 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_x : _GEN_3603; // @[CPU6502Core.scala 279:20 394:16]
  wire [7:0] _GEN_3623 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_y : _GEN_3604; // @[CPU6502Core.scala 279:20 394:16]
  wire [7:0] _GEN_3624 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_sp : _GEN_3605; // @[CPU6502Core.scala 279:20 394:16]
  wire [15:0] _GEN_3625 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3606; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3626 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagC : _GEN_3607; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3627 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagZ : _GEN_3608; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3628 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagI : _GEN_3609; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3629 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagD : _GEN_3610; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3631 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagV : _GEN_3612; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3632 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagN : _GEN_3613; // @[CPU6502Core.scala 279:20 394:16]
  wire [15:0] _GEN_3633 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_11_memAddr : _GEN_3614; // @[CPU6502Core.scala 279:20 394:16]
  wire [7:0] _GEN_3634 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_25_memData : _GEN_3615; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3635 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_8_done : _GEN_3616; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3636 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memRead : _GEN_3617; // @[CPU6502Core.scala 279:20 394:16]
  wire [15:0] _GEN_3637 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_operand : _GEN_3618; // @[CPU6502Core.scala 279:20 394:16]
  wire  _GEN_3638 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode | _GEN_3619; // @[CPU6502Core.scala 279:20 389:16]
  wire [2:0] _GEN_3639 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 3'h0 : _GEN_3620; // @[CPU6502Core.scala 279:20 389:16]
  wire [7:0] _GEN_3640 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? execResult_result_res_22
     : _GEN_3621; // @[CPU6502Core.scala 279:20 389:16]
  wire [7:0] _GEN_3641 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_x : _GEN_3622; // @[CPU6502Core.scala 279:20 389:16]
  wire [7:0] _GEN_3642 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_y : _GEN_3623; // @[CPU6502Core.scala 279:20 389:16]
  wire [7:0] _GEN_3643 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_sp : _GEN_3624; // @[CPU6502Core.scala 279:20 389:16]
  wire [15:0] _GEN_3644 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_pc : _GEN_3625; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3645 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagC : _GEN_3626; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3646 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagZ : _GEN_3627; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3647 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagI : _GEN_3628; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3648 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagD : _GEN_3629; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3650 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagV : _GEN_3631; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3651 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagN : _GEN_3632; // @[CPU6502Core.scala 279:20 389:16]
  wire [15:0] _GEN_3652 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_3633; // @[CPU6502Core.scala 279:20 389:16]
  wire [7:0] _GEN_3653 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 8'h0 : _GEN_3634; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3654 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_3635; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3655 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_3636; // @[CPU6502Core.scala 279:20 389:16]
  wire [15:0] _GEN_3656 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_3637; // @[CPU6502Core.scala 279:20 389:16]
  wire  _GEN_3657 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_done : _GEN_3638; // @[CPU6502Core.scala 279:20 384:16]
  wire [2:0] _GEN_3658 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_49_nextCycle :
    _GEN_3639; // @[CPU6502Core.scala 279:20 384:16]
  wire [7:0] _GEN_3659 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_a :
    _GEN_3640; // @[CPU6502Core.scala 279:20 384:16]
  wire [7:0] _GEN_3660 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_x : _GEN_3641; // @[CPU6502Core.scala 279:20 384:16]
  wire [7:0] _GEN_3661 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_y : _GEN_3642; // @[CPU6502Core.scala 279:20 384:16]
  wire [7:0] _GEN_3662 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_sp : _GEN_3643; // @[CPU6502Core.scala 279:20 384:16]
  wire [15:0] _GEN_3663 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3644; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3664 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagC : _GEN_3645; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3665 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_3646
    ; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3666 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagI : _GEN_3647; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3667 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagD : _GEN_3648; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3669 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagV : _GEN_3650; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3670 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_flagN : _GEN_3651
    ; // @[CPU6502Core.scala 279:20 384:16]
  wire [15:0] _GEN_3671 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_memAddr :
    _GEN_3652; // @[CPU6502Core.scala 279:20 384:16]
  wire [7:0] _GEN_3672 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 8'h0 : _GEN_3653; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3673 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 1'h0 : _GEN_3654; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3674 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_memRead : _GEN_3655
    ; // @[CPU6502Core.scala 279:20 384:16]
  wire [15:0] _GEN_3675 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_10_operand :
    _GEN_3656; // @[CPU6502Core.scala 279:20 384:16]
  wire  _GEN_3676 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_done : _GEN_3657; // @[CPU6502Core.scala 279:20 379:16]
  wire [2:0] _GEN_3677 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_49_nextCycle :
    _GEN_3658; // @[CPU6502Core.scala 279:20 379:16]
  wire [7:0] _GEN_3678 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_a : _GEN_3659
    ; // @[CPU6502Core.scala 279:20 379:16]
  wire [7:0] _GEN_3679 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_x : _GEN_3660; // @[CPU6502Core.scala 279:20 379:16]
  wire [7:0] _GEN_3680 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_y : _GEN_3661; // @[CPU6502Core.scala 279:20 379:16]
  wire [7:0] _GEN_3681 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_sp : _GEN_3662; // @[CPU6502Core.scala 279:20 379:16]
  wire [15:0] _GEN_3682 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3663; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3683 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagC : _GEN_3664; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3684 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_3665; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3685 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagI : _GEN_3666; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3686 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagD : _GEN_3667; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3688 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagV : _GEN_3669; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3689 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_flagN : _GEN_3670; // @[CPU6502Core.scala 279:20 379:16]
  wire [15:0] _GEN_3690 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_memAddr :
    _GEN_3671; // @[CPU6502Core.scala 279:20 379:16]
  wire [7:0] _GEN_3691 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 8'h0 : _GEN_3672; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3692 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 1'h0 : _GEN_3673; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3693 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_memRead : _GEN_3674; // @[CPU6502Core.scala 279:20 379:16]
  wire [15:0] _GEN_3694 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_operand :
    _GEN_3675; // @[CPU6502Core.scala 279:20 379:16]
  wire  _GEN_3695 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_8_done : _GEN_3676; // @[CPU6502Core.scala 279:20 374:16]
  wire [2:0] _GEN_3696 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_49_nextCycle : _GEN_3677; // @[CPU6502Core.scala 279:20 374:16]
  wire [7:0] _GEN_3697 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_20_a : _GEN_3678; // @[CPU6502Core.scala 279:20 374:16]
  wire [7:0] _GEN_3698 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_x : _GEN_3679; // @[CPU6502Core.scala 279:20 374:16]
  wire [7:0] _GEN_3699 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_y : _GEN_3680; // @[CPU6502Core.scala 279:20 374:16]
  wire [7:0] _GEN_3700 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_sp : _GEN_3681; // @[CPU6502Core.scala 279:20 374:16]
  wire [15:0] _GEN_3701 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3682; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3702 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagC : _GEN_3683; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3703 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_20_flagZ : _GEN_3684; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3704 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagI : _GEN_3685; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3705 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagD : _GEN_3686; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3707 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagV : _GEN_3688; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3708 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_20_flagN : _GEN_3689; // @[CPU6502Core.scala 279:20 374:16]
  wire [15:0] _GEN_3709 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_8_memAddr : _GEN_3690; // @[CPU6502Core.scala 279:20 374:16]
  wire [7:0] _GEN_3710 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? 8'h0 : _GEN_3691; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3711 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? 1'h0 : _GEN_3692; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3712 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_8_memRead : _GEN_3693; // @[CPU6502Core.scala 279:20 374:16]
  wire [15:0] _GEN_3713 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_21_operand : _GEN_3694; // @[CPU6502Core.scala 279:20 374:16]
  wire  _GEN_3714 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_done : _GEN_3695; // @[CPU6502Core.scala 279:20 369:16]
  wire [2:0] _GEN_3715 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_49_nextCycle : _GEN_3696; // @[CPU6502Core.scala 279:20 369:16]
  wire [7:0] _GEN_3716 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_a : _GEN_3697; // @[CPU6502Core.scala 279:20 369:16]
  wire [7:0] _GEN_3717 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_x : _GEN_3698; // @[CPU6502Core.scala 279:20 369:16]
  wire [7:0] _GEN_3718 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_y : _GEN_3699; // @[CPU6502Core.scala 279:20 369:16]
  wire [7:0] _GEN_3719 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_sp : _GEN_3700; // @[CPU6502Core.scala 279:20 369:16]
  wire [15:0] _GEN_3720 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_7_pc : _GEN_3701; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3721 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagC : _GEN_3702; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3722 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagZ : _GEN_3703; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3723 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagI : _GEN_3704; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3724 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagD : _GEN_3705; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3726 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagV : _GEN_3707; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3727 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagN : _GEN_3708; // @[CPU6502Core.scala 279:20 369:16]
  wire [15:0] _GEN_3728 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_memAddr : _GEN_3709; // @[CPU6502Core.scala 279:20 369:16]
  wire [7:0] _GEN_3729 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 8'h0 : _GEN_3710; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3730 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 1'h0 : _GEN_3711; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3731 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_memRead : _GEN_3712; // @[CPU6502Core.scala 279:20 369:16]
  wire [15:0] _GEN_3732 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_operand : _GEN_3713; // @[CPU6502Core.scala 279:20 369:16]
  wire  _GEN_3733 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_done : _GEN_3714; // @[CPU6502Core.scala 279:20 364:16]
  wire [2:0] _GEN_3734 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_49_nextCycle :
    _GEN_3715; // @[CPU6502Core.scala 279:20 364:16]
  wire [7:0] _GEN_3735 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_a :
    _GEN_3716; // @[CPU6502Core.scala 279:20 364:16]
  wire [7:0] _GEN_3736 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_x : _GEN_3717; // @[CPU6502Core.scala 279:20 364:16]
  wire [7:0] _GEN_3737 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_y : _GEN_3718; // @[CPU6502Core.scala 279:20 364:16]
  wire [7:0] _GEN_3738 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_sp : _GEN_3719; // @[CPU6502Core.scala 279:20 364:16]
  wire [15:0] _GEN_3739 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3720; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3740 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagC : _GEN_3721; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3741 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_3722
    ; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3742 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagI : _GEN_3723; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3743 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagD : _GEN_3724; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3745 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagV : _GEN_3726; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3746 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_flagN : _GEN_3727
    ; // @[CPU6502Core.scala 279:20 364:16]
  wire [15:0] _GEN_3747 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3728; // @[CPU6502Core.scala 279:20 364:16]
  wire [7:0] _GEN_3748 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 8'h0 : _GEN_3729; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3749 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 1'h0 : _GEN_3730; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3750 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memRead : _GEN_3731
    ; // @[CPU6502Core.scala 279:20 364:16]
  wire [15:0] _GEN_3751 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_7_operand :
    _GEN_3732; // @[CPU6502Core.scala 279:20 364:16]
  wire  _GEN_3752 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_done : _GEN_3733; // @[CPU6502Core.scala 279:20 359:16]
  wire [2:0] _GEN_3753 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_49_nextCycle :
    _GEN_3734; // @[CPU6502Core.scala 279:20 359:16]
  wire [7:0] _GEN_3754 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_a : _GEN_3735
    ; // @[CPU6502Core.scala 279:20 359:16]
  wire [7:0] _GEN_3755 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_x : _GEN_3736; // @[CPU6502Core.scala 279:20 359:16]
  wire [7:0] _GEN_3756 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_y : _GEN_3737; // @[CPU6502Core.scala 279:20 359:16]
  wire [7:0] _GEN_3757 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_sp : _GEN_3738; // @[CPU6502Core.scala 279:20 359:16]
  wire [15:0] _GEN_3758 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3739; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3759 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagC : _GEN_3740; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3760 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_3741; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3761 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagI : _GEN_3742; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3762 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagD : _GEN_3743; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3764 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagV : _GEN_3745; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3765 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_flagN : _GEN_3746; // @[CPU6502Core.scala 279:20 359:16]
  wire [15:0] _GEN_3766 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3747; // @[CPU6502Core.scala 279:20 359:16]
  wire [7:0] _GEN_3767 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 8'h0 : _GEN_3748; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3768 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 1'h0 : _GEN_3749; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3769 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memRead : _GEN_3750; // @[CPU6502Core.scala 279:20 359:16]
  wire [15:0] _GEN_3770 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_operand :
    _GEN_3751; // @[CPU6502Core.scala 279:20 359:16]
  wire  _GEN_3771 = 8'h24 == opcode ? execResult_result_result_6_done : _GEN_3752; // @[CPU6502Core.scala 279:20 356:16]
  wire [2:0] _GEN_3772 = 8'h24 == opcode ? execResult_result_result_48_nextCycle : _GEN_3753; // @[CPU6502Core.scala 279:20 356:16]
  wire [7:0] _GEN_3773 = 8'h24 == opcode ? regs_a : _GEN_3754; // @[CPU6502Core.scala 279:20 356:16]
  wire [7:0] _GEN_3774 = 8'h24 == opcode ? regs_x : _GEN_3755; // @[CPU6502Core.scala 279:20 356:16]
  wire [7:0] _GEN_3775 = 8'h24 == opcode ? regs_y : _GEN_3756; // @[CPU6502Core.scala 279:20 356:16]
  wire [7:0] _GEN_3776 = 8'h24 == opcode ? regs_sp : _GEN_3757; // @[CPU6502Core.scala 279:20 356:16]
  wire [15:0] _GEN_3777 = 8'h24 == opcode ? execResult_result_newRegs_5_pc : _GEN_3758; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3778 = 8'h24 == opcode ? regs_flagC : _GEN_3759; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3779 = 8'h24 == opcode ? execResult_result_newRegs_16_flagZ : _GEN_3760; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3780 = 8'h24 == opcode ? regs_flagI : _GEN_3761; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3781 = 8'h24 == opcode ? regs_flagD : _GEN_3762; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3783 = 8'h24 == opcode ? execResult_result_newRegs_16_flagV : _GEN_3764; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3784 = 8'h24 == opcode ? execResult_result_newRegs_16_flagN : _GEN_3765; // @[CPU6502Core.scala 279:20 356:16]
  wire [15:0] _GEN_3785 = 8'h24 == opcode ? execResult_result_result_6_memAddr : _GEN_3766; // @[CPU6502Core.scala 279:20 356:16]
  wire [7:0] _GEN_3786 = 8'h24 == opcode ? 8'h0 : _GEN_3767; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3787 = 8'h24 == opcode ? 1'h0 : _GEN_3768; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3788 = 8'h24 == opcode ? execResult_result_result_6_memRead : _GEN_3769; // @[CPU6502Core.scala 279:20 356:16]
  wire [15:0] _GEN_3789 = 8'h24 == opcode ? execResult_result_result_6_operand : _GEN_3770; // @[CPU6502Core.scala 279:20 356:16]
  wire  _GEN_3790 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_3771; // @[CPU6502Core.scala 279:20 351:16]
  wire [2:0] _GEN_3791 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 3'h0 : _GEN_3772; // @[CPU6502Core.scala 279:20 351:16]
  wire [7:0] _GEN_3792 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_res_15 : _GEN_3773; // @[CPU6502Core.scala 279:20 351:16]
  wire [7:0] _GEN_3793 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_x : _GEN_3774; // @[CPU6502Core.scala 279:20 351:16]
  wire [7:0] _GEN_3794 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_y : _GEN_3775; // @[CPU6502Core.scala 279:20 351:16]
  wire [7:0] _GEN_3795 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_sp : _GEN_3776; // @[CPU6502Core.scala 279:20 351:16]
  wire [15:0] _GEN_3796 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? _regs_pc_T_1 : _GEN_3777; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3797 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagC : _GEN_3778; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3798 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_15_flagZ : _GEN_3779; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3799 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagI : _GEN_3780; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3800 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagD : _GEN_3781; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3802 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagV : _GEN_3783; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3803 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_15_flagN : _GEN_3784; // @[CPU6502Core.scala 279:20 351:16]
  wire [15:0] _GEN_3804 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_pc : _GEN_3785; // @[CPU6502Core.scala 279:20 351:16]
  wire [7:0] _GEN_3805 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 8'h0 : _GEN_3786; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3806 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 1'h0 : _GEN_3787; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3807 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_3788; // @[CPU6502Core.scala 279:20 351:16]
  wire [15:0] _GEN_3808 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 16'h0 : _GEN_3789; // @[CPU6502Core.scala 279:20 351:16]
  wire  _GEN_3809 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_9_done : _GEN_3790; // @[CPU6502Core.scala 279:20 346:16]
  wire [2:0] _GEN_3810 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_49_nextCycle : _GEN_3791; // @[CPU6502Core.scala 279:20 346:16]
  wire [7:0] _GEN_3811 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_a : _GEN_3792; // @[CPU6502Core.scala 279:20 346:16]
  wire [7:0] _GEN_3812 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_x : _GEN_3793; // @[CPU6502Core.scala 279:20 346:16]
  wire [7:0] _GEN_3813 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_y : _GEN_3794; // @[CPU6502Core.scala 279:20 346:16]
  wire [7:0] _GEN_3814 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_sp : _GEN_3795; // @[CPU6502Core.scala 279:20 346:16]
  wire [15:0] _GEN_3815 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_pc : _GEN_3796; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3816 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagC : _GEN_3797; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3817 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagZ : _GEN_3798; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3818 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagI : _GEN_3799; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3819 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagD : _GEN_3800; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3821 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagV : _GEN_3802; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3822 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagN : _GEN_3803; // @[CPU6502Core.scala 279:20 346:16]
  wire [15:0] _GEN_3823 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_15_memAddr : _GEN_3804; // @[CPU6502Core.scala 279:20 346:16]
  wire [7:0] _GEN_3824 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 8'h0 : _GEN_3805; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3825 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 1'h0 : _GEN_3806; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3826 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_memRead : _GEN_3807; // @[CPU6502Core.scala 279:20 346:16]
  wire [15:0] _GEN_3827 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_operand : _GEN_3808; // @[CPU6502Core.scala 279:20 346:16]
  wire  _GEN_3828 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_9_done : _GEN_3809; // @[CPU6502Core.scala 279:20 341:16]
  wire [2:0] _GEN_3829 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_49_nextCycle : _GEN_3810; // @[CPU6502Core.scala 279:20 341:16]
  wire [7:0] _GEN_3830 = 8'hfe == opcode | 8'hde == opcode ? regs_a : _GEN_3811; // @[CPU6502Core.scala 279:20 341:16]
  wire [7:0] _GEN_3831 = 8'hfe == opcode | 8'hde == opcode ? regs_x : _GEN_3812; // @[CPU6502Core.scala 279:20 341:16]
  wire [7:0] _GEN_3832 = 8'hfe == opcode | 8'hde == opcode ? regs_y : _GEN_3813; // @[CPU6502Core.scala 279:20 341:16]
  wire [7:0] _GEN_3833 = 8'hfe == opcode | 8'hde == opcode ? regs_sp : _GEN_3814; // @[CPU6502Core.scala 279:20 341:16]
  wire [15:0] _GEN_3834 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_7_pc : _GEN_3815; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3835 = 8'hfe == opcode | 8'hde == opcode ? regs_flagC : _GEN_3816; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3836 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_13_flagZ : _GEN_3817; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3837 = 8'hfe == opcode | 8'hde == opcode ? regs_flagI : _GEN_3818; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3838 = 8'hfe == opcode | 8'hde == opcode ? regs_flagD : _GEN_3819; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3840 = 8'hfe == opcode | 8'hde == opcode ? regs_flagV : _GEN_3821; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3841 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_13_flagN : _GEN_3822; // @[CPU6502Core.scala 279:20 341:16]
  wire [15:0] _GEN_3842 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_13_memAddr : _GEN_3823; // @[CPU6502Core.scala 279:20 341:16]
  wire [7:0] _GEN_3843 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_14_memData : _GEN_3824; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3844 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_9_done : _GEN_3825; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3845 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_8_memRead : _GEN_3826; // @[CPU6502Core.scala 279:20 341:16]
  wire [15:0] _GEN_3846 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_14_operand : _GEN_3827; // @[CPU6502Core.scala 279:20 341:16]
  wire  _GEN_3847 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_9_done : _GEN_3828; // @[CPU6502Core.scala 279:20 336:16]
  wire [2:0] _GEN_3848 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_49_nextCycle : _GEN_3829; // @[CPU6502Core.scala 279:20 336:16]
  wire [7:0] _GEN_3849 = 8'hee == opcode | 8'hce == opcode ? regs_a : _GEN_3830; // @[CPU6502Core.scala 279:20 336:16]
  wire [7:0] _GEN_3850 = 8'hee == opcode | 8'hce == opcode ? regs_x : _GEN_3831; // @[CPU6502Core.scala 279:20 336:16]
  wire [7:0] _GEN_3851 = 8'hee == opcode | 8'hce == opcode ? regs_y : _GEN_3832; // @[CPU6502Core.scala 279:20 336:16]
  wire [7:0] _GEN_3852 = 8'hee == opcode | 8'hce == opcode ? regs_sp : _GEN_3833; // @[CPU6502Core.scala 279:20 336:16]
  wire [15:0] _GEN_3853 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_7_pc : _GEN_3834; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3854 = 8'hee == opcode | 8'hce == opcode ? regs_flagC : _GEN_3835; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3855 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_12_flagZ : _GEN_3836; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3856 = 8'hee == opcode | 8'hce == opcode ? regs_flagI : _GEN_3837; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3857 = 8'hee == opcode | 8'hce == opcode ? regs_flagD : _GEN_3838; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3859 = 8'hee == opcode | 8'hce == opcode ? regs_flagV : _GEN_3840; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3860 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_12_flagN : _GEN_3841; // @[CPU6502Core.scala 279:20 336:16]
  wire [15:0] _GEN_3861 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_13_memAddr : _GEN_3842; // @[CPU6502Core.scala 279:20 336:16]
  wire [7:0] _GEN_3862 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_13_memData : _GEN_3843; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3863 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_9_done : _GEN_3844; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3864 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_8_memRead : _GEN_3845; // @[CPU6502Core.scala 279:20 336:16]
  wire [15:0] _GEN_3865 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_8_operand : _GEN_3846; // @[CPU6502Core.scala 279:20 336:16]
  wire  _GEN_3866 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_8_done : _GEN_3847; // @[CPU6502Core.scala 279:20 331:16]
  wire [2:0] _GEN_3867 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_49_nextCycle : _GEN_3848; // @[CPU6502Core.scala 279:20 331:16]
  wire [7:0] _GEN_3868 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_a : _GEN_3849; // @[CPU6502Core.scala 279:20 331:16]
  wire [7:0] _GEN_3869 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_x : _GEN_3850; // @[CPU6502Core.scala 279:20 331:16]
  wire [7:0] _GEN_3870 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_y : _GEN_3851; // @[CPU6502Core.scala 279:20 331:16]
  wire [7:0] _GEN_3871 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_sp : _GEN_3852; // @[CPU6502Core.scala 279:20 331:16]
  wire [15:0] _GEN_3872 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_5_pc : _GEN_3853; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3873 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagC : _GEN_3854; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3874 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_11_flagZ : _GEN_3855; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3875 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagI : _GEN_3856; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3876 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagD : _GEN_3857; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3878 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagV : _GEN_3859; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3879 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_11_flagN : _GEN_3860; // @[CPU6502Core.scala 279:20 331:16]
  wire [15:0] _GEN_3880 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_11_memAddr : _GEN_3861; // @[CPU6502Core.scala 279:20 331:16]
  wire [7:0] _GEN_3881 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_12_memData : _GEN_3862; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3882 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_8_done : _GEN_3863; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3883 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_6_memRead : _GEN_3864; // @[CPU6502Core.scala 279:20 331:16]
  wire [15:0] _GEN_3884 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_7_operand : _GEN_3865; // @[CPU6502Core.scala 279:20 331:16]
  wire  _GEN_3885 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_8_done : _GEN_3866; // @[CPU6502Core.scala 279:20 326:16]
  wire [2:0] _GEN_3886 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_51_nextCycle : _GEN_3867; // @[CPU6502Core.scala 279:20 326:16]
  wire [7:0] _GEN_3887 = 8'he6 == opcode | 8'hc6 == opcode ? regs_a : _GEN_3868; // @[CPU6502Core.scala 279:20 326:16]
  wire [7:0] _GEN_3888 = 8'he6 == opcode | 8'hc6 == opcode ? regs_x : _GEN_3869; // @[CPU6502Core.scala 279:20 326:16]
  wire [7:0] _GEN_3889 = 8'he6 == opcode | 8'hc6 == opcode ? regs_y : _GEN_3870; // @[CPU6502Core.scala 279:20 326:16]
  wire [7:0] _GEN_3890 = 8'he6 == opcode | 8'hc6 == opcode ? regs_sp : _GEN_3871; // @[CPU6502Core.scala 279:20 326:16]
  wire [15:0] _GEN_3891 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_pc : _GEN_3872; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3892 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagC : _GEN_3873; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3893 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_10_flagZ : _GEN_3874; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3894 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagI : _GEN_3875; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3895 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagD : _GEN_3876; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3897 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagV : _GEN_3878; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3898 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_10_flagN : _GEN_3879; // @[CPU6502Core.scala 279:20 326:16]
  wire [15:0] _GEN_3899 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_memAddr : _GEN_3880; // @[CPU6502Core.scala 279:20 326:16]
  wire [7:0] _GEN_3900 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_memData : _GEN_3881; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3901 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_8_done : _GEN_3882; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3902 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memRead : _GEN_3883; // @[CPU6502Core.scala 279:20 326:16]
  wire [15:0] _GEN_3903 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_operand : _GEN_3884; // @[CPU6502Core.scala 279:20 326:16]
  wire  _GEN_3904 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_done : _GEN_3885; // @[CPU6502Core.scala 279:20 321:16]
  wire [2:0] _GEN_3905 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_49_nextCycle : _GEN_3886; // @[CPU6502Core.scala 279:20 321:16]
  wire [7:0] _GEN_3906 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_a : _GEN_3887; // @[CPU6502Core.scala 279:20 321:16]
  wire [7:0] _GEN_3907 = 8'h71 == opcode | 8'hf1 == opcode ? regs_x : _GEN_3888; // @[CPU6502Core.scala 279:20 321:16]
  wire [7:0] _GEN_3908 = 8'h71 == opcode | 8'hf1 == opcode ? regs_y : _GEN_3889; // @[CPU6502Core.scala 279:20 321:16]
  wire [7:0] _GEN_3909 = 8'h71 == opcode | 8'hf1 == opcode ? regs_sp : _GEN_3890; // @[CPU6502Core.scala 279:20 321:16]
  wire [15:0] _GEN_3910 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3891; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3911 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagC : _GEN_3892; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3912 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_3893; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3913 = 8'h71 == opcode | 8'hf1 == opcode ? regs_flagI : _GEN_3894; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3914 = 8'h71 == opcode | 8'hf1 == opcode ? regs_flagD : _GEN_3895; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3916 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagV : _GEN_3897; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3917 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagN : _GEN_3898; // @[CPU6502Core.scala 279:20 321:16]
  wire [15:0] _GEN_3918 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_memAddr : _GEN_3899; // @[CPU6502Core.scala 279:20 321:16]
  wire [7:0] _GEN_3919 = 8'h71 == opcode | 8'hf1 == opcode ? 8'h0 : _GEN_3900; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3920 = 8'h71 == opcode | 8'hf1 == opcode ? 1'h0 : _GEN_3901; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3921 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_memRead : _GEN_3902; // @[CPU6502Core.scala 279:20 321:16]
  wire [15:0] _GEN_3922 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_10_operand : _GEN_3903; // @[CPU6502Core.scala 279:20 321:16]
  wire  _GEN_3923 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_done : _GEN_3904; // @[CPU6502Core.scala 279:20 316:16]
  wire [2:0] _GEN_3924 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_49_nextCycle : _GEN_3905; // @[CPU6502Core.scala 279:20 316:16]
  wire [7:0] _GEN_3925 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_a : _GEN_3906; // @[CPU6502Core.scala 279:20 316:16]
  wire [7:0] _GEN_3926 = 8'h61 == opcode | 8'he1 == opcode ? regs_x : _GEN_3907; // @[CPU6502Core.scala 279:20 316:16]
  wire [7:0] _GEN_3927 = 8'h61 == opcode | 8'he1 == opcode ? regs_y : _GEN_3908; // @[CPU6502Core.scala 279:20 316:16]
  wire [7:0] _GEN_3928 = 8'h61 == opcode | 8'he1 == opcode ? regs_sp : _GEN_3909; // @[CPU6502Core.scala 279:20 316:16]
  wire [15:0] _GEN_3929 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3910; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3930 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagC : _GEN_3911; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3931 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_3912; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3932 = 8'h61 == opcode | 8'he1 == opcode ? regs_flagI : _GEN_3913; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3933 = 8'h61 == opcode | 8'he1 == opcode ? regs_flagD : _GEN_3914; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3935 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagV : _GEN_3916; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3936 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagN : _GEN_3917; // @[CPU6502Core.scala 279:20 316:16]
  wire [15:0] _GEN_3937 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_memAddr : _GEN_3918; // @[CPU6502Core.scala 279:20 316:16]
  wire [7:0] _GEN_3938 = 8'h61 == opcode | 8'he1 == opcode ? 8'h0 : _GEN_3919; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3939 = 8'h61 == opcode | 8'he1 == opcode ? 1'h0 : _GEN_3920; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3940 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_memRead : _GEN_3921; // @[CPU6502Core.scala 279:20 316:16]
  wire [15:0] _GEN_3941 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_operand : _GEN_3922; // @[CPU6502Core.scala 279:20 316:16]
  wire  _GEN_3942 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_done : _GEN_3923; // @[CPU6502Core.scala 279:20 311:16]
  wire [2:0] _GEN_3943 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_49_nextCycle : _GEN_3924; // @[CPU6502Core.scala 279:20 311:16]
  wire [7:0] _GEN_3944 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_a : _GEN_3925; // @[CPU6502Core.scala 279:20 311:16]
  wire [7:0] _GEN_3945 = 8'h6d == opcode | 8'hed == opcode ? regs_x : _GEN_3926; // @[CPU6502Core.scala 279:20 311:16]
  wire [7:0] _GEN_3946 = 8'h6d == opcode | 8'hed == opcode ? regs_y : _GEN_3927; // @[CPU6502Core.scala 279:20 311:16]
  wire [7:0] _GEN_3947 = 8'h6d == opcode | 8'hed == opcode ? regs_sp : _GEN_3928; // @[CPU6502Core.scala 279:20 311:16]
  wire [15:0] _GEN_3948 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_pc : _GEN_3929; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3949 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagC : _GEN_3930; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3950 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagZ : _GEN_3931; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3951 = 8'h6d == opcode | 8'hed == opcode ? regs_flagI : _GEN_3932; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3952 = 8'h6d == opcode | 8'hed == opcode ? regs_flagD : _GEN_3933; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3954 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagV : _GEN_3935; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3955 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagN : _GEN_3936; // @[CPU6502Core.scala 279:20 311:16]
  wire [15:0] _GEN_3956 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_memAddr : _GEN_3937; // @[CPU6502Core.scala 279:20 311:16]
  wire [7:0] _GEN_3957 = 8'h6d == opcode | 8'hed == opcode ? 8'h0 : _GEN_3938; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3958 = 8'h6d == opcode | 8'hed == opcode ? 1'h0 : _GEN_3939; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3959 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_memRead : _GEN_3940; // @[CPU6502Core.scala 279:20 311:16]
  wire [15:0] _GEN_3960 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_operand : _GEN_3941; // @[CPU6502Core.scala 279:20 311:16]
  wire  _GEN_3961 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_done : _GEN_3942; // @[CPU6502Core.scala 279:20 306:16]
  wire [2:0] _GEN_3962 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_49_nextCycle : _GEN_3943; // @[CPU6502Core.scala 279:20 306:16]
  wire [7:0] _GEN_3963 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_a : _GEN_3944; // @[CPU6502Core.scala 279:20 306:16]
  wire [7:0] _GEN_3964 = 8'h75 == opcode | 8'hf5 == opcode ? regs_x : _GEN_3945; // @[CPU6502Core.scala 279:20 306:16]
  wire [7:0] _GEN_3965 = 8'h75 == opcode | 8'hf5 == opcode ? regs_y : _GEN_3946; // @[CPU6502Core.scala 279:20 306:16]
  wire [7:0] _GEN_3966 = 8'h75 == opcode | 8'hf5 == opcode ? regs_sp : _GEN_3947; // @[CPU6502Core.scala 279:20 306:16]
  wire [15:0] _GEN_3967 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3948; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3968 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagC : _GEN_3949; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3969 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_3950; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3970 = 8'h75 == opcode | 8'hf5 == opcode ? regs_flagI : _GEN_3951; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3971 = 8'h75 == opcode | 8'hf5 == opcode ? regs_flagD : _GEN_3952; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3973 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagV : _GEN_3954; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3974 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagN : _GEN_3955; // @[CPU6502Core.scala 279:20 306:16]
  wire [15:0] _GEN_3975 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_memAddr : _GEN_3956; // @[CPU6502Core.scala 279:20 306:16]
  wire [7:0] _GEN_3976 = 8'h75 == opcode | 8'hf5 == opcode ? 8'h0 : _GEN_3957; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3977 = 8'h75 == opcode | 8'hf5 == opcode ? 1'h0 : _GEN_3958; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3978 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_memRead : _GEN_3959; // @[CPU6502Core.scala 279:20 306:16]
  wire [15:0] _GEN_3979 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_7_operand : _GEN_3960; // @[CPU6502Core.scala 279:20 306:16]
  wire  _GEN_3980 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_done : _GEN_3961; // @[CPU6502Core.scala 279:20 301:16]
  wire [2:0] _GEN_3981 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_49_nextCycle : _GEN_3962; // @[CPU6502Core.scala 279:20 301:16]
  wire [7:0] _GEN_3982 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_a : _GEN_3963; // @[CPU6502Core.scala 279:20 301:16]
  wire [7:0] _GEN_3983 = 8'h65 == opcode | 8'he5 == opcode ? regs_x : _GEN_3964; // @[CPU6502Core.scala 279:20 301:16]
  wire [7:0] _GEN_3984 = 8'h65 == opcode | 8'he5 == opcode ? regs_y : _GEN_3965; // @[CPU6502Core.scala 279:20 301:16]
  wire [7:0] _GEN_3985 = 8'h65 == opcode | 8'he5 == opcode ? regs_sp : _GEN_3966; // @[CPU6502Core.scala 279:20 301:16]
  wire [15:0] _GEN_3986 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3967; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3987 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagC : _GEN_3968; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3988 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_3969; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3989 = 8'h65 == opcode | 8'he5 == opcode ? regs_flagI : _GEN_3970; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3990 = 8'h65 == opcode | 8'he5 == opcode ? regs_flagD : _GEN_3971; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3992 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagV : _GEN_3973; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3993 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagN : _GEN_3974; // @[CPU6502Core.scala 279:20 301:16]
  wire [15:0] _GEN_3994 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_memAddr : _GEN_3975; // @[CPU6502Core.scala 279:20 301:16]
  wire [7:0] _GEN_3995 = 8'h65 == opcode | 8'he5 == opcode ? 8'h0 : _GEN_3976; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3996 = 8'h65 == opcode | 8'he5 == opcode ? 1'h0 : _GEN_3977; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3997 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_memRead : _GEN_3978; // @[CPU6502Core.scala 279:20 301:16]
  wire [15:0] _GEN_3998 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_operand : _GEN_3979; // @[CPU6502Core.scala 279:20 301:16]
  wire  _GEN_3999 = 8'he9 == opcode | _GEN_3980; // @[CPU6502Core.scala 279:20 297:27]
  wire [2:0] _GEN_4000 = 8'he9 == opcode ? 3'h0 : _GEN_3981; // @[CPU6502Core.scala 279:20 297:27]
  wire [7:0] _GEN_4001 = 8'he9 == opcode ? execResult_result_newRegs_4_a : _GEN_3982; // @[CPU6502Core.scala 279:20 297:27]
  wire [7:0] _GEN_4002 = 8'he9 == opcode ? regs_x : _GEN_3983; // @[CPU6502Core.scala 279:20 297:27]
  wire [7:0] _GEN_4003 = 8'he9 == opcode ? regs_y : _GEN_3984; // @[CPU6502Core.scala 279:20 297:27]
  wire [7:0] _GEN_4004 = 8'he9 == opcode ? regs_sp : _GEN_3985; // @[CPU6502Core.scala 279:20 297:27]
  wire [15:0] _GEN_4005 = 8'he9 == opcode ? _regs_pc_T_1 : _GEN_3986; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4006 = 8'he9 == opcode ? execResult_result_newRegs_4_flagC : _GEN_3987; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4007 = 8'he9 == opcode ? execResult_result_newRegs_4_flagZ : _GEN_3988; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4008 = 8'he9 == opcode ? regs_flagI : _GEN_3989; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4009 = 8'he9 == opcode ? regs_flagD : _GEN_3990; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4011 = 8'he9 == opcode ? execResult_result_newRegs_4_flagV : _GEN_3992; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4012 = 8'he9 == opcode ? execResult_result_newRegs_4_flagN : _GEN_3993; // @[CPU6502Core.scala 279:20 297:27]
  wire [15:0] _GEN_4013 = 8'he9 == opcode ? regs_pc : _GEN_3994; // @[CPU6502Core.scala 279:20 297:27]
  wire [7:0] _GEN_4014 = 8'he9 == opcode ? 8'h0 : _GEN_3995; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4015 = 8'he9 == opcode ? 1'h0 : _GEN_3996; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4016 = 8'he9 == opcode | _GEN_3997; // @[CPU6502Core.scala 279:20 297:27]
  wire [15:0] _GEN_4017 = 8'he9 == opcode ? 16'h0 : _GEN_3998; // @[CPU6502Core.scala 279:20 297:27]
  wire  _GEN_4018 = 8'h69 == opcode | _GEN_3999; // @[CPU6502Core.scala 279:20 296:27]
  wire [2:0] _GEN_4019 = 8'h69 == opcode ? 3'h0 : _GEN_4000; // @[CPU6502Core.scala 279:20 296:27]
  wire [7:0] _GEN_4020 = 8'h69 == opcode ? execResult_result_newRegs_3_a : _GEN_4001; // @[CPU6502Core.scala 279:20 296:27]
  wire [7:0] _GEN_4021 = 8'h69 == opcode ? regs_x : _GEN_4002; // @[CPU6502Core.scala 279:20 296:27]
  wire [7:0] _GEN_4022 = 8'h69 == opcode ? regs_y : _GEN_4003; // @[CPU6502Core.scala 279:20 296:27]
  wire [7:0] _GEN_4023 = 8'h69 == opcode ? regs_sp : _GEN_4004; // @[CPU6502Core.scala 279:20 296:27]
  wire [15:0] _GEN_4024 = 8'h69 == opcode ? _regs_pc_T_1 : _GEN_4005; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4025 = 8'h69 == opcode ? execResult_result_newRegs_3_flagC : _GEN_4006; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4026 = 8'h69 == opcode ? execResult_result_newRegs_3_flagZ : _GEN_4007; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4027 = 8'h69 == opcode ? regs_flagI : _GEN_4008; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4028 = 8'h69 == opcode ? regs_flagD : _GEN_4009; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4030 = 8'h69 == opcode ? execResult_result_newRegs_3_flagV : _GEN_4011; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4031 = 8'h69 == opcode ? execResult_result_newRegs_3_flagN : _GEN_4012; // @[CPU6502Core.scala 279:20 296:27]
  wire [15:0] _GEN_4032 = 8'h69 == opcode ? regs_pc : _GEN_4013; // @[CPU6502Core.scala 279:20 296:27]
  wire [7:0] _GEN_4033 = 8'h69 == opcode ? 8'h0 : _GEN_4014; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4034 = 8'h69 == opcode ? 1'h0 : _GEN_4015; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4035 = 8'h69 == opcode | _GEN_4016; // @[CPU6502Core.scala 279:20 296:27]
  wire [15:0] _GEN_4036 = 8'h69 == opcode ? 16'h0 : _GEN_4017; // @[CPU6502Core.scala 279:20 296:27]
  wire  _GEN_4037 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode | _GEN_4018; // @[CPU6502Core.scala 279:20 292:16]
  wire [2:0] _GEN_4038 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 3'h0 : _GEN_4019; // @[CPU6502Core.scala 279:20 292:16]
  wire [7:0] _GEN_4039 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_a : _GEN_4020; // @[CPU6502Core.scala 279:20 292:16]
  wire [7:0] _GEN_4040 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_x : _GEN_4021; // @[CPU6502Core.scala 279:20 292:16]
  wire [7:0] _GEN_4041 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_y : _GEN_4022; // @[CPU6502Core.scala 279:20 292:16]
  wire [7:0] _GEN_4042 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_sp : _GEN_4023; // @[CPU6502Core.scala 279:20 292:16]
  wire [15:0] _GEN_4043 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_pc : _GEN_4024; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4044 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagC : _GEN_4025; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4045 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagZ : _GEN_4026; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4046 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagI : _GEN_4027; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4047 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagD : _GEN_4028; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4049 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagV : _GEN_4030; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4050 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagN : _GEN_4031; // @[CPU6502Core.scala 279:20 292:16]
  wire [15:0] _GEN_4051 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_4032; // @[CPU6502Core.scala 279:20 292:16]
  wire [7:0] _GEN_4052 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 8'h0 : _GEN_4033; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4053 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_4034; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4054 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_4035; // @[CPU6502Core.scala 279:20 292:16]
  wire [15:0] _GEN_4055 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_4036; // @[CPU6502Core.scala 279:20 292:16]
  wire  _GEN_4056 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode | _GEN_4037; // @[CPU6502Core.scala 279:20 287:16]
  wire [2:0] _GEN_4057 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 3'h0 : _GEN_4038; // @[CPU6502Core.scala 279:20 287:16]
  wire [7:0] _GEN_4058 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_a : _GEN_4039; // @[CPU6502Core.scala 279:20 287:16]
  wire [7:0] _GEN_4059 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_x : _GEN_4040; // @[CPU6502Core.scala 279:20 287:16]
  wire [7:0] _GEN_4060 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_y : _GEN_4041; // @[CPU6502Core.scala 279:20 287:16]
  wire [7:0] _GEN_4061 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_sp : _GEN_4042; // @[CPU6502Core.scala 279:20 287:16]
  wire [15:0] _GEN_4062 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? regs_pc : _GEN_4043; // @[CPU6502Core.scala 279:20 287:16]
  wire  _GEN_4063 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagC : _GEN_4044; // @[CPU6502Core.scala 279:20 287:16]
  wire  _GEN_4064 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagZ : _GEN_4045; // @[CPU6502Core.scala 279:20 287:16]
  wire  _GEN_4065 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagI : _GEN_4046; // @[CPU6502Core.scala 279:20 287:16]
  wire  _GEN_4066 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagD : _GEN_4047; // @[CPU6502Core.scala 279:20 287:16]
  wire  _GEN_4068 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagV : _GEN_4049; // @[CPU6502Core.scala 279:20 287:16]
  wire  _GEN_4069 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagN : _GEN_4050; // @[CPU6502Core.scala 279:20 287:16]
  wire [15:0] _GEN_4070 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_4051; // @[CPU6502Core.scala 279:20 287:16]
  wire [7:0] _GEN_4071 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 8'h0 : _GEN_4052; // @[CPU6502Core.scala 279:20 287:16]
  wire  _GEN_4072 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_4053; // @[CPU6502Core.scala 279:20 287:16]
  wire  _GEN_4073 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_4054; // @[CPU6502Core.scala 279:20 287:16]
  wire [15:0] _GEN_4074 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_4055; // @[CPU6502Core.scala 279:20 287:16]
  wire  execResult_result_1_done = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode | _GEN_4056; // @[CPU6502Core.scala 279:20 282:16]
  wire [2:0] execResult_result_1_nextCycle = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 3'h0 : _GEN_4057; // @[CPU6502Core.scala 279:20 282:16]
  wire [7:0] execResult_result_1_regs_a = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_a : _GEN_4058; // @[CPU6502Core.scala 279:20 282:16]
  wire [7:0] execResult_result_1_regs_x = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_x : _GEN_4059; // @[CPU6502Core.scala 279:20 282:16]
  wire [7:0] execResult_result_1_regs_y = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_y : _GEN_4060; // @[CPU6502Core.scala 279:20 282:16]
  wire [7:0] execResult_result_1_regs_sp = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_sp : _GEN_4061; // @[CPU6502Core.scala 279:20 282:16]
  wire [15:0] execResult_result_1_regs_pc = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_pc : _GEN_4062; // @[CPU6502Core.scala 279:20 282:16]
  wire  execResult_result_1_regs_flagC = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagC : _GEN_4063; // @[CPU6502Core.scala 279:20 282:16]
  wire  execResult_result_1_regs_flagZ = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagZ : _GEN_4064; // @[CPU6502Core.scala 279:20 282:16]
  wire  execResult_result_1_regs_flagI = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagI : _GEN_4065; // @[CPU6502Core.scala 279:20 282:16]
  wire  execResult_result_1_regs_flagD = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagD : _GEN_4066; // @[CPU6502Core.scala 279:20 282:16]
  wire  execResult_result_1_regs_flagV = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagV : _GEN_4068; // @[CPU6502Core.scala 279:20 282:16]
  wire  execResult_result_1_regs_flagN = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagN : _GEN_4069; // @[CPU6502Core.scala 279:20 282:16]
  wire [15:0] execResult_result_1_memAddr = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_4070; // @[CPU6502Core.scala 279:20 282:16]
  wire [7:0] execResult_result_1_memData = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 8'h0 : _GEN_4071; // @[CPU6502Core.scala 279:20 282:16]
  wire  execResult_result_1_memWrite = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_4072; // @[CPU6502Core.scala 279:20 282:16]
  wire  execResult_result_1_memRead = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_4073; // @[CPU6502Core.scala 279:20 282:16]
  wire [15:0] execResult_result_1_operand = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_4074; // @[CPU6502Core.scala 279:20 282:16]
  wire  _GEN_4173 = 3'h2 == state & execResult_result_1_done; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4217 = 3'h1 == state ? 1'h0 : _GEN_4173; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4259 = 3'h0 == state ? 1'h0 : _GEN_4217; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_done = io_reset ? 1'h0 : _GEN_4259; // @[CPU6502Core.scala 57:14 60:18]
  wire [2:0] _GEN_4174 = 3'h2 == state ? execResult_result_1_nextCycle : 3'h0; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [2:0] _GEN_4218 = 3'h1 == state ? 3'h0 : _GEN_4174; // @[CPU6502Core.scala 57:14 70:19]
  wire [2:0] _GEN_4260 = 3'h0 == state ? 3'h0 : _GEN_4218; // @[CPU6502Core.scala 57:14 70:19]
  wire [2:0] execResult_nextCycle = io_reset ? 3'h0 : _GEN_4260; // @[CPU6502Core.scala 57:14 60:18]
  wire [2:0] _GEN_4094 = execResult_done ? 3'h0 : execResult_nextCycle; // @[CPU6502Core.scala 186:33 188:19 191:19]
  wire [2:0] _GEN_4095 = execResult_done ? 3'h1 : state; // @[CPU6502Core.scala 186:33 189:19 26:22]
  wire  _T_26 = 3'h3 == state; // @[CPU6502Core.scala 70:19]
  wire [7:0] status = {regs_flagN,regs_flagV,2'h2,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_4096 = _T_14 ? 16'hfffb : regs_pc; // @[CPU6502Core.scala 240:37 242:24 50:17]
  wire [3:0] _GEN_4098 = _T_14 ? 4'h8 : 4'h0; // @[CPU6502Core.scala 240:37 244:19 252:19]
  wire [15:0] _GEN_4099 = _T_14 ? regs_pc : resetVector; // @[CPU6502Core.scala 22:21 240:37 250:21]
  wire  _GEN_4100 = _T_14 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 22:21 240:37 251:24]
  wire [2:0] _GEN_4101 = _T_14 ? state : 3'h1; // @[CPU6502Core.scala 240:37 253:19 26:22]
  wire [15:0] _GEN_4102 = _T_13 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 234:37 236:21 29:24]
  wire [15:0] _GEN_4103 = _T_13 ? 16'hfffb : _GEN_4096; // @[CPU6502Core.scala 234:37 237:24]
  wire  _GEN_4104 = _T_13 | _T_14; // @[CPU6502Core.scala 234:37 238:24]
  wire [3:0] _GEN_4105 = _T_13 ? 4'h7 : _GEN_4098; // @[CPU6502Core.scala 234:37 239:19]
  wire [15:0] _GEN_4106 = _T_13 ? regs_pc : _GEN_4099; // @[CPU6502Core.scala 22:21 234:37]
  wire  _GEN_4107 = _T_13 ? regs_flagI : _GEN_4100; // @[CPU6502Core.scala 22:21 234:37]
  wire [2:0] _GEN_4108 = _T_13 ? state : _GEN_4101; // @[CPU6502Core.scala 234:37 26:22]
  wire [15:0] _GEN_4109 = _T_12 ? 16'hfffa : _GEN_4103; // @[CPU6502Core.scala 229:37 231:24]
  wire  _GEN_4110 = _T_12 | _GEN_4104; // @[CPU6502Core.scala 229:37 232:24]
  wire [3:0] _GEN_4111 = _T_12 ? 4'h6 : _GEN_4105; // @[CPU6502Core.scala 229:37 233:19]
  wire [15:0] _GEN_4112 = _T_12 ? operand : _GEN_4102; // @[CPU6502Core.scala 229:37 29:24]
  wire [15:0] _GEN_4113 = _T_12 ? regs_pc : _GEN_4106; // @[CPU6502Core.scala 22:21 229:37]
  wire  _GEN_4114 = _T_12 ? regs_flagI : _GEN_4107; // @[CPU6502Core.scala 22:21 229:37]
  wire [2:0] _GEN_4115 = _T_12 ? state : _GEN_4108; // @[CPU6502Core.scala 229:37 26:22]
  wire [15:0] _GEN_4116 = _T_9 ? 16'hfffa : _GEN_4109; // @[CPU6502Core.scala 224:37 226:24]
  wire  _GEN_4117 = _T_9 | _GEN_4110; // @[CPU6502Core.scala 224:37 227:24]
  wire [3:0] _GEN_4118 = _T_9 ? 4'h5 : _GEN_4111; // @[CPU6502Core.scala 224:37 228:19]
  wire [15:0] _GEN_4119 = _T_9 ? operand : _GEN_4112; // @[CPU6502Core.scala 224:37 29:24]
  wire [15:0] _GEN_4120 = _T_9 ? regs_pc : _GEN_4113; // @[CPU6502Core.scala 22:21 224:37]
  wire  _GEN_4121 = _T_9 ? regs_flagI : _GEN_4114; // @[CPU6502Core.scala 22:21 224:37]
  wire [2:0] _GEN_4122 = _T_9 ? state : _GEN_4115; // @[CPU6502Core.scala 224:37 26:22]
  wire [15:0] _GEN_4123 = _T_8 ? execResult_result_result_46_memAddr : _GEN_4116; // @[CPU6502Core.scala 215:37 219:24]
  wire [7:0] _GEN_4124 = _T_8 ? status : 8'h0; // @[CPU6502Core.scala 215:37 220:27 51:17]
  wire [7:0] _GEN_4126 = _T_8 ? execResult_result_newRegs_45_sp : regs_sp; // @[CPU6502Core.scala 215:37 22:21 222:21]
  wire [3:0] _GEN_4127 = _T_8 ? 4'h4 : _GEN_4118; // @[CPU6502Core.scala 215:37 223:19]
  wire  _GEN_4128 = _T_8 ? 1'h0 : _GEN_4117; // @[CPU6502Core.scala 215:37 53:17]
  wire [15:0] _GEN_4129 = _T_8 ? operand : _GEN_4119; // @[CPU6502Core.scala 215:37 29:24]
  wire [15:0] _GEN_4130 = _T_8 ? regs_pc : _GEN_4120; // @[CPU6502Core.scala 215:37 22:21]
  wire  _GEN_4131 = _T_8 ? regs_flagI : _GEN_4121; // @[CPU6502Core.scala 215:37 22:21]
  wire [2:0] _GEN_4132 = _T_8 ? state : _GEN_4122; // @[CPU6502Core.scala 215:37 26:22]
  wire [15:0] _GEN_4133 = _T_7 ? execResult_result_result_46_memAddr : _GEN_4123; // @[CPU6502Core.scala 208:37 210:24]
  wire [7:0] _GEN_4134 = _T_7 ? regs_pc[7:0] : _GEN_4124; // @[CPU6502Core.scala 208:37 211:27]
  wire  _GEN_4135 = _T_7 | _T_8; // @[CPU6502Core.scala 208:37 212:25]
  wire [7:0] _GEN_4136 = _T_7 ? execResult_result_newRegs_45_sp : _GEN_4126; // @[CPU6502Core.scala 208:37 213:21]
  wire [3:0] _GEN_4137 = _T_7 ? 4'h3 : _GEN_4127; // @[CPU6502Core.scala 208:37 214:19]
  wire  _GEN_4138 = _T_7 ? 1'h0 : _GEN_4128; // @[CPU6502Core.scala 208:37 53:17]
  wire [15:0] _GEN_4139 = _T_7 ? operand : _GEN_4129; // @[CPU6502Core.scala 208:37 29:24]
  wire [15:0] _GEN_4140 = _T_7 ? regs_pc : _GEN_4130; // @[CPU6502Core.scala 208:37 22:21]
  wire  _GEN_4141 = _T_7 ? regs_flagI : _GEN_4131; // @[CPU6502Core.scala 208:37 22:21]
  wire [2:0] _GEN_4142 = _T_7 ? state : _GEN_4132; // @[CPU6502Core.scala 208:37 26:22]
  wire [15:0] _GEN_4143 = _T_6 ? execResult_result_result_46_memAddr : _GEN_4133; // @[CPU6502Core.scala 201:37 203:24]
  wire [7:0] _GEN_4144 = _T_6 ? regs_pc[15:8] : _GEN_4134; // @[CPU6502Core.scala 201:37 204:27]
  wire  _GEN_4145 = _T_6 | _GEN_4135; // @[CPU6502Core.scala 201:37 205:25]
  wire [7:0] _GEN_4146 = _T_6 ? execResult_result_newRegs_45_sp : _GEN_4136; // @[CPU6502Core.scala 201:37 206:21]
  wire [3:0] _GEN_4147 = _T_6 ? 4'h2 : _GEN_4137; // @[CPU6502Core.scala 201:37 207:19]
  wire  _GEN_4148 = _T_6 ? 1'h0 : _GEN_4138; // @[CPU6502Core.scala 201:37 53:17]
  wire [15:0] _GEN_4149 = _T_6 ? operand : _GEN_4139; // @[CPU6502Core.scala 201:37 29:24]
  wire [15:0] _GEN_4150 = _T_6 ? regs_pc : _GEN_4140; // @[CPU6502Core.scala 201:37 22:21]
  wire  _GEN_4151 = _T_6 ? regs_flagI : _GEN_4141; // @[CPU6502Core.scala 201:37 22:21]
  wire [2:0] _GEN_4152 = _T_6 ? state : _GEN_4142; // @[CPU6502Core.scala 201:37 26:22]
  wire [3:0] _GEN_4153 = _T_5 ? 4'h1 : _GEN_4147; // @[CPU6502Core.scala 198:31 200:19]
  wire [15:0] _GEN_4154 = _T_5 ? regs_pc : _GEN_4143; // @[CPU6502Core.scala 198:31 50:17]
  wire [7:0] _GEN_4155 = _T_5 ? 8'h0 : _GEN_4144; // @[CPU6502Core.scala 198:31 51:17]
  wire  _GEN_4156 = _T_5 ? 1'h0 : _GEN_4145; // @[CPU6502Core.scala 198:31 52:17]
  wire [7:0] _GEN_4157 = _T_5 ? regs_sp : _GEN_4146; // @[CPU6502Core.scala 198:31 22:21]
  wire  _GEN_4158 = _T_5 ? 1'h0 : _GEN_4148; // @[CPU6502Core.scala 198:31 53:17]
  wire [15:0] _GEN_4159 = _T_5 ? operand : _GEN_4149; // @[CPU6502Core.scala 198:31 29:24]
  wire [15:0] _GEN_4160 = _T_5 ? regs_pc : _GEN_4150; // @[CPU6502Core.scala 198:31 22:21]
  wire  _GEN_4161 = _T_5 ? regs_flagI : _GEN_4151; // @[CPU6502Core.scala 198:31 22:21]
  wire [2:0] _GEN_4162 = _T_5 ? state : _GEN_4152; // @[CPU6502Core.scala 198:31 26:22]
  wire [3:0] _GEN_4163 = 3'h3 == state ? _GEN_4153 : cycle; // @[CPU6502Core.scala 70:19 30:24]
  wire [15:0] _GEN_4164 = 3'h3 == state ? _GEN_4154 : regs_pc; // @[CPU6502Core.scala 50:17 70:19]
  wire [7:0] _GEN_4165 = 3'h3 == state ? _GEN_4155 : 8'h0; // @[CPU6502Core.scala 51:17 70:19]
  wire  _GEN_4166 = 3'h3 == state & _GEN_4156; // @[CPU6502Core.scala 52:17 70:19]
  wire [7:0] _GEN_4167 = 3'h3 == state ? _GEN_4157 : regs_sp; // @[CPU6502Core.scala 70:19 22:21]
  wire  _GEN_4168 = 3'h3 == state & _GEN_4158; // @[CPU6502Core.scala 53:17 70:19]
  wire [15:0] _GEN_4169 = 3'h3 == state ? _GEN_4159 : operand; // @[CPU6502Core.scala 70:19 29:24]
  wire [15:0] _GEN_4170 = 3'h3 == state ? _GEN_4160 : regs_pc; // @[CPU6502Core.scala 70:19 22:21]
  wire  _GEN_4171 = 3'h3 == state ? _GEN_4161 : regs_flagI; // @[CPU6502Core.scala 70:19 22:21]
  wire [2:0] _GEN_4172 = 3'h3 == state ? _GEN_4162 : state; // @[CPU6502Core.scala 70:19 26:22]
  wire [7:0] _GEN_4175 = 3'h2 == state ? execResult_result_1_regs_a : regs_a; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [7:0] _GEN_4176 = 3'h2 == state ? execResult_result_1_regs_x : regs_x; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [7:0] _GEN_4177 = 3'h2 == state ? execResult_result_1_regs_y : regs_y; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [7:0] _GEN_4178 = 3'h2 == state ? execResult_result_1_regs_sp : regs_sp; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [15:0] _GEN_4179 = 3'h2 == state ? execResult_result_1_regs_pc : regs_pc; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4180 = 3'h2 == state ? execResult_result_1_regs_flagC : regs_flagC; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4181 = 3'h2 == state ? execResult_result_1_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4182 = 3'h2 == state ? execResult_result_1_regs_flagI : regs_flagI; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4183 = 3'h2 == state ? execResult_result_1_regs_flagD : regs_flagD; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4185 = 3'h2 == state ? execResult_result_1_regs_flagV : regs_flagV; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4186 = 3'h2 == state ? execResult_result_1_regs_flagN : regs_flagN; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [15:0] _GEN_4187 = 3'h2 == state ? execResult_result_1_memAddr : 16'h0; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [7:0] _GEN_4188 = 3'h2 == state ? execResult_result_1_memData : 8'h0; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4189 = 3'h2 == state & execResult_result_1_memWrite; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire  _GEN_4190 = 3'h2 == state & execResult_result_1_memRead; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [15:0] _GEN_4191 = 3'h2 == state ? execResult_result_1_operand : operand; // @[CPU6502Core.scala 70:19 175:22 57:14]
  wire [15:0] _GEN_4231 = 3'h1 == state ? 16'h0 : _GEN_4187; // @[CPU6502Core.scala 57:14 70:19]
  wire [15:0] _GEN_4273 = 3'h0 == state ? 16'h0 : _GEN_4231; // @[CPU6502Core.scala 57:14 70:19]
  wire [15:0] execResult_memAddr = io_reset ? 16'h0 : _GEN_4273; // @[CPU6502Core.scala 57:14 60:18]
  wire [15:0] _GEN_4192 = 3'h2 == state ? execResult_memAddr : _GEN_4164; // @[CPU6502Core.scala 70:19 178:25]
  wire [7:0] _GEN_4232 = 3'h1 == state ? 8'h0 : _GEN_4188; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] _GEN_4274 = 3'h0 == state ? 8'h0 : _GEN_4232; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] execResult_memData = io_reset ? 8'h0 : _GEN_4274; // @[CPU6502Core.scala 57:14 60:18]
  wire [7:0] _GEN_4193 = 3'h2 == state ? execResult_memData : _GEN_4165; // @[CPU6502Core.scala 70:19 179:25]
  wire  _GEN_4233 = 3'h1 == state ? 1'h0 : _GEN_4189; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4275 = 3'h0 == state ? 1'h0 : _GEN_4233; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_memWrite = io_reset ? 1'h0 : _GEN_4275; // @[CPU6502Core.scala 57:14 60:18]
  wire  _GEN_4194 = 3'h2 == state ? execResult_memWrite : _GEN_4166; // @[CPU6502Core.scala 70:19 180:25]
  wire  _GEN_4234 = 3'h1 == state ? 1'h0 : _GEN_4190; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4276 = 3'h0 == state ? 1'h0 : _GEN_4234; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_memRead = io_reset ? 1'h0 : _GEN_4276; // @[CPU6502Core.scala 57:14 60:18]
  wire  _GEN_4195 = 3'h2 == state ? execResult_memRead : _GEN_4168; // @[CPU6502Core.scala 70:19 181:25]
  wire [7:0] _GEN_4219 = 3'h1 == state ? regs_a : _GEN_4175; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] _GEN_4261 = 3'h0 == state ? regs_a : _GEN_4219; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] execResult_regs_a = io_reset ? regs_a : _GEN_4261; // @[CPU6502Core.scala 57:14 60:18]
  wire [7:0] _GEN_4196 = 3'h2 == state ? execResult_regs_a : regs_a; // @[CPU6502Core.scala 183:19 70:19 22:21]
  wire [7:0] _GEN_4220 = 3'h1 == state ? regs_x : _GEN_4176; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] _GEN_4262 = 3'h0 == state ? regs_x : _GEN_4220; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] execResult_regs_x = io_reset ? regs_x : _GEN_4262; // @[CPU6502Core.scala 57:14 60:18]
  wire [7:0] _GEN_4197 = 3'h2 == state ? execResult_regs_x : regs_x; // @[CPU6502Core.scala 183:19 70:19 22:21]
  wire [7:0] _GEN_4221 = 3'h1 == state ? regs_y : _GEN_4177; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] _GEN_4263 = 3'h0 == state ? regs_y : _GEN_4221; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] execResult_regs_y = io_reset ? regs_y : _GEN_4263; // @[CPU6502Core.scala 57:14 60:18]
  wire [7:0] _GEN_4198 = 3'h2 == state ? execResult_regs_y : regs_y; // @[CPU6502Core.scala 183:19 70:19 22:21]
  wire [7:0] _GEN_4222 = 3'h1 == state ? regs_sp : _GEN_4178; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] _GEN_4264 = 3'h0 == state ? regs_sp : _GEN_4222; // @[CPU6502Core.scala 57:14 70:19]
  wire [7:0] execResult_regs_sp = io_reset ? regs_sp : _GEN_4264; // @[CPU6502Core.scala 57:14 60:18]
  wire [7:0] _GEN_4199 = 3'h2 == state ? execResult_regs_sp : _GEN_4167; // @[CPU6502Core.scala 183:19 70:19]
  wire [15:0] _GEN_4223 = 3'h1 == state ? regs_pc : _GEN_4179; // @[CPU6502Core.scala 57:14 70:19]
  wire [15:0] _GEN_4265 = 3'h0 == state ? regs_pc : _GEN_4223; // @[CPU6502Core.scala 57:14 70:19]
  wire [15:0] execResult_regs_pc = io_reset ? regs_pc : _GEN_4265; // @[CPU6502Core.scala 57:14 60:18]
  wire [15:0] _GEN_4200 = 3'h2 == state ? execResult_regs_pc : _GEN_4170; // @[CPU6502Core.scala 183:19 70:19]
  wire  _GEN_4224 = 3'h1 == state ? regs_flagC : _GEN_4180; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4266 = 3'h0 == state ? regs_flagC : _GEN_4224; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_regs_flagC = io_reset ? regs_flagC : _GEN_4266; // @[CPU6502Core.scala 57:14 60:18]
  wire  _GEN_4201 = 3'h2 == state ? execResult_regs_flagC : regs_flagC; // @[CPU6502Core.scala 183:19 70:19 22:21]
  wire  _GEN_4225 = 3'h1 == state ? regs_flagZ : _GEN_4181; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4267 = 3'h0 == state ? regs_flagZ : _GEN_4225; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_regs_flagZ = io_reset ? regs_flagZ : _GEN_4267; // @[CPU6502Core.scala 57:14 60:18]
  wire  _GEN_4202 = 3'h2 == state ? execResult_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 183:19 70:19 22:21]
  wire  _GEN_4226 = 3'h1 == state ? regs_flagI : _GEN_4182; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4268 = 3'h0 == state ? regs_flagI : _GEN_4226; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_regs_flagI = io_reset ? regs_flagI : _GEN_4268; // @[CPU6502Core.scala 57:14 60:18]
  wire  _GEN_4203 = 3'h2 == state ? execResult_regs_flagI : _GEN_4171; // @[CPU6502Core.scala 183:19 70:19]
  wire  _GEN_4227 = 3'h1 == state ? regs_flagD : _GEN_4183; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4269 = 3'h0 == state ? regs_flagD : _GEN_4227; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_regs_flagD = io_reset ? regs_flagD : _GEN_4269; // @[CPU6502Core.scala 57:14 60:18]
  wire  _GEN_4204 = 3'h2 == state ? execResult_regs_flagD : regs_flagD; // @[CPU6502Core.scala 183:19 70:19 22:21]
  wire  _GEN_4229 = 3'h1 == state ? regs_flagV : _GEN_4185; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4271 = 3'h0 == state ? regs_flagV : _GEN_4229; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_regs_flagV = io_reset ? regs_flagV : _GEN_4271; // @[CPU6502Core.scala 57:14 60:18]
  wire  _GEN_4206 = 3'h2 == state ? execResult_regs_flagV : regs_flagV; // @[CPU6502Core.scala 183:19 70:19 22:21]
  wire  _GEN_4230 = 3'h1 == state ? regs_flagN : _GEN_4186; // @[CPU6502Core.scala 57:14 70:19]
  wire  _GEN_4272 = 3'h0 == state ? regs_flagN : _GEN_4230; // @[CPU6502Core.scala 57:14 70:19]
  wire  execResult_regs_flagN = io_reset ? regs_flagN : _GEN_4272; // @[CPU6502Core.scala 57:14 60:18]
  wire  _GEN_4207 = 3'h2 == state ? execResult_regs_flagN : regs_flagN; // @[CPU6502Core.scala 183:19 70:19 22:21]
  wire [15:0] _GEN_4235 = 3'h1 == state ? operand : _GEN_4191; // @[CPU6502Core.scala 57:14 70:19]
  wire [15:0] _GEN_4277 = 3'h0 == state ? operand : _GEN_4235; // @[CPU6502Core.scala 57:14 70:19]
  wire [15:0] execResult_operand = io_reset ? operand : _GEN_4277; // @[CPU6502Core.scala 57:14 60:18]
  wire [15:0] _GEN_4208 = 3'h2 == state ? execResult_operand : _GEN_4169; // @[CPU6502Core.scala 184:19 70:19]
  wire [3:0] _GEN_4209 = 3'h2 == state ? {{1'd0}, _GEN_4094} : _GEN_4163; // @[CPU6502Core.scala 70:19]
  wire [2:0] _GEN_4210 = 3'h2 == state ? _GEN_4095 : _GEN_4172; // @[CPU6502Core.scala 70:19]
  wire [15:0] _GEN_4213 = 3'h1 == state ? regs_pc : _GEN_4192; // @[CPU6502Core.scala 70:19]
  wire  _GEN_4214 = 3'h1 == state ? _GEN_97 : _GEN_4195; // @[CPU6502Core.scala 70:19]
  wire [7:0] _GEN_4236 = 3'h1 == state ? 8'h0 : _GEN_4193; // @[CPU6502Core.scala 51:17 70:19]
  wire  _GEN_4237 = 3'h1 == state ? 1'h0 : _GEN_4194; // @[CPU6502Core.scala 52:17 70:19]
  wire [15:0] _GEN_4250 = 3'h0 == state ? _GEN_62 : _GEN_4213; // @[CPU6502Core.scala 70:19]
  wire  _GEN_4251 = 3'h0 == state | _GEN_4214; // @[CPU6502Core.scala 70:19]
  wire [7:0] _GEN_4278 = 3'h0 == state ? 8'h0 : _GEN_4236; // @[CPU6502Core.scala 51:17 70:19]
  wire  _GEN_4279 = 3'h0 == state ? 1'h0 : _GEN_4237; // @[CPU6502Core.scala 52:17 70:19]
  wire  _GEN_4355 = ~io_reset; // @[CPU6502Core.scala 97:19]
  wire  _GEN_4357 = ~_T_5; // @[CPU6502Core.scala 97:19]
  wire  _GEN_4359 = ~_T_6; // @[CPU6502Core.scala 97:19]
  wire  _GEN_4361 = ~_T_7; // @[CPU6502Core.scala 97:19]
  wire  _GEN_4363 = ~_T_8; // @[CPU6502Core.scala 97:19]
  wire  _GEN_4364 = ~io_reset & _T_4 & ~_T_5 & ~_T_6 & ~_T_7 & ~_T_8; // @[CPU6502Core.scala 97:19]
  wire  _GEN_4376 = ~_T_9; // @[CPU6502Core.scala 124:19]
  wire  _GEN_4378 = ~_T_12; // @[CPU6502Core.scala 124:19]
  wire  _GEN_4380 = ~_T_13; // @[CPU6502Core.scala 124:19]
  wire  _GEN_4382 = ~_T_14; // @[CPU6502Core.scala 124:19]
  wire  _GEN_4390 = _GEN_4355 & ~_T_4 & ~_T_18; // @[LoadStore.scala 274:21]
  wire  _GEN_4391 = _GEN_4355 & ~_T_4 & ~_T_18 & _T_23; // @[LoadStore.scala 274:21]
  wire  _GEN_4416 = ~_execResult_T_62; // @[LoadStore.scala 274:21]
  wire  _GEN_4417 = _GEN_4355 & ~_T_4 & ~_T_18 & _T_23 & ~_execResult_T_14 & ~_execResult_T_25 & ~_execResult_T_36 & ~
    _execResult_T_37 & ~_execResult_T_38 & ~_execResult_T_41 & ~_execResult_T_44 & ~_execResult_T_47 & ~_execResult_T_50
     & ~_execResult_T_53 & ~_execResult_T_56 & ~_execResult_T_59 & _GEN_4416; // @[LoadStore.scala 274:21]
  wire  _GEN_4447 = _GEN_4417 & ~_execResult_T_65 & ~_execResult_T_72 & ~_execResult_T_77 & ~_execResult_T_78 & ~
    _execResult_T_83 & ~_execResult_T_88 & ~_execResult_T_95 & ~_execResult_T_106 & ~_execResult_T_111 & ~
    _execResult_T_116 & ~_execResult_T_123 & ~_execResult_T_130 & ~_execResult_T_137 & ~_execResult_T_144 & ~
    _execResult_T_151; // @[LoadStore.scala 274:21]
  wire  _GEN_4477 = ~_execResult_result_T_21; // @[LoadStore.scala 274:21]
  wire  _GEN_4478 = _GEN_4447 & ~_execResult_T_156 & ~_execResult_T_161 & ~_execResult_T_162 & ~_execResult_T_167 & ~
    _execResult_T_170 & ~_execResult_T_171 & ~_execResult_T_172 & ~_execResult_T_173 & ~_execResult_T_188 & ~
    _execResult_T_193 & ~_execResult_T_204 & ~_execResult_T_211 & ~_execResult_T_214 & _execResult_T_225 & ~
    _execResult_result_T_20 & _GEN_4477; // @[LoadStore.scala 274:21]
  wire  _GEN_4503 = _GEN_4390 & ~_T_23 & _T_26; // @[CPU6502Core.scala 197:17]
  wire  _GEN_4525 = _GEN_4503 & _GEN_4357 & _GEN_4359 & _GEN_4361 & _GEN_4363 & _GEN_4376 & _GEN_4378 & _GEN_4380; // @[CPU6502Core.scala 245:19]
  assign io_memAddr = io_reset ? regs_pc : _GEN_4250; // @[CPU6502Core.scala 50:17 60:18]
  assign io_memDataOut = io_reset ? 8'h0 : _GEN_4278; // @[CPU6502Core.scala 51:17 60:18]
  assign io_memWrite = io_reset ? 1'h0 : _GEN_4279; // @[CPU6502Core.scala 52:17 60:18]
  assign io_memRead = io_reset ? 1'h0 : _GEN_4251; // @[CPU6502Core.scala 53:17 60:18]
  assign io_debug_regA = regs_a; // @[DebugBundle.scala 23:21 24:16]
  assign io_debug_regX = regs_x; // @[DebugBundle.scala 23:21 25:16]
  assign io_debug_regY = regs_y; // @[DebugBundle.scala 23:21 26:16]
  assign io_debug_regPC = regs_pc; // @[DebugBundle.scala 23:21 27:17]
  assign io_debug_opcode = opcode; // @[DebugBundle.scala 23:21 33:18]
  assign io_debug_state = state[1:0]; // @[DebugBundle.scala 23:21 34:17]
  assign io_debug_cycle = cycle[2:0]; // @[DebugBundle.scala 23:21 35:17]
  always @(posedge clock) begin
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_a <= 8'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
          regs_a <= _GEN_4196;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_x <= 8'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
          regs_x <= _GEN_4197;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_y <= 8'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
          regs_y <= _GEN_4198;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_sp <= 8'hff; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 70:19]
        if (!(cycle == 4'h0)) begin // @[CPU6502Core.scala 73:31]
          regs_sp <= _GEN_59;
        end
      end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
        regs_sp <= _GEN_4199;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 70:19]
        if (!(cycle == 4'h0)) begin // @[CPU6502Core.scala 73:31]
          regs_pc <= _GEN_58;
        end
      end else if (3'h1 == state) begin // @[CPU6502Core.scala 70:19]
        regs_pc <= _GEN_99;
      end else begin
        regs_pc <= _GEN_4200;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_flagC <= 1'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
          regs_flagC <= _GEN_4201;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_flagZ <= 1'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
          regs_flagZ <= _GEN_4202;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_flagI <= 1'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 70:19]
        if (!(cycle == 4'h0)) begin // @[CPU6502Core.scala 73:31]
          regs_flagI <= _GEN_60;
        end
      end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
        regs_flagI <= _GEN_4203;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_flagD <= 1'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
          regs_flagD <= _GEN_4204;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_flagV <= 1'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
          regs_flagV <= _GEN_4206;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 22:21]
      regs_flagN <= 1'h0; // @[CPU6502Core.scala 22:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 60:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
          regs_flagN <= _GEN_4207;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 26:22]
      state <= 3'h0; // @[CPU6502Core.scala 26:22]
    end else if (io_reset) begin // @[CPU6502Core.scala 60:18]
      state <= 3'h0; // @[CPU6502Core.scala 62:11]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 70:19]
      if (!(cycle == 4'h0)) begin // @[CPU6502Core.scala 73:31]
        state <= _GEN_61;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 70:19]
      state <= _GEN_95;
    end else begin
      state <= _GEN_4210;
    end
    if (reset) begin // @[CPU6502Core.scala 28:24]
      opcode <= 8'h0; // @[CPU6502Core.scala 28:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 60:18]
      opcode <= 8'h0; // @[CPU6502Core.scala 64:12]
    end else if (!(3'h0 == state)) begin // @[CPU6502Core.scala 70:19]
      if (3'h1 == state) begin // @[CPU6502Core.scala 70:19]
        opcode <= _GEN_98;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 29:24]
      operand <= 16'h0; // @[CPU6502Core.scala 29:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 60:18]
      operand <= 16'h0; // @[CPU6502Core.scala 65:13]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 70:19]
      if (!(cycle == 4'h0)) begin // @[CPU6502Core.scala 73:31]
        operand <= _GEN_57;
      end
    end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 70:19]
      operand <= _GEN_4208;
    end
    if (reset) begin // @[CPU6502Core.scala 30:24]
      cycle <= 4'h0; // @[CPU6502Core.scala 30:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 60:18]
      cycle <= 4'h0; // @[CPU6502Core.scala 63:11]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 70:19]
      if (cycle == 4'h0) begin // @[CPU6502Core.scala 73:31]
        cycle <= 4'h1; // @[CPU6502Core.scala 76:19]
      end else begin
        cycle <= _GEN_56;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 70:19]
      cycle <= {{1'd0}, _GEN_94};
    end else begin
      cycle <= _GEN_4209;
    end
    if (reset) begin // @[CPU6502Core.scala 33:24]
      nmiLast <= 1'h0; // @[CPU6502Core.scala 33:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 60:18]
      nmiLast <= 1'h0; // @[CPU6502Core.scala 67:13]
    end else begin
      nmiLast <= io_nmi; // @[CPU6502Core.scala 37:11]
    end
    if (reset) begin // @[CPU6502Core.scala 34:27]
      nmiPending <= 1'h0; // @[CPU6502Core.scala 34:27]
    end else if (io_reset) begin // @[CPU6502Core.scala 60:18]
      nmiPending <= 1'h0; // @[CPU6502Core.scala 66:16]
    end else if (state == 3'h1 & nmiPending) begin // @[CPU6502Core.scala 45:40]
      nmiPending <= 1'h0; // @[CPU6502Core.scala 46:16]
    end else begin
      nmiPending <= _GEN_0;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~io_reset & _T_4 & ~_T_5 & ~_T_6 & ~_T_7 & ~_T_8 & _T_9 & ~reset) begin
          $fwrite(32'h80000002,"[CPU Reset] Read $FFFC = 0x%x (low byte)\n",io_memDataIn); // @[CPU6502Core.scala 97:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4364 & ~_T_9 & ~_T_12 & ~_T_13 & ~_T_14 & ~_T_15 & _T_11) begin
          $fwrite(32'h80000002,"[CPU Reset] Read $FFFD = 0x%x (high byte), Reset Vector = 0x%x\n",io_memDataIn,
            resetVector); // @[CPU6502Core.scala 124:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4478 & ~_execResult_result_T_26 & ~_execResult_result_T_30 & ~_execResult_result_T_232 &
          _execResult_result_T_235 & _execResult_result_T_234 & execResult_result_isLoadA_2 & _execResult_result_T_238
           & _T_11) begin
          $fwrite(32'h80000002,"[LDA $2002] data=0x%x\n",io_memDataIn); // @[LoadStore.scala 274:21]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4391 & execResult_done & _T_11) begin
          $fwrite(32'h80000002,"[Execute] Done! opcode=0x%x cycle=%d -> Fetch\n",opcode,cycle); // @[CPU6502Core.scala 187:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4390 & ~_T_23 & _T_26 & _T_11) begin
          $fwrite(32'h80000002,"[NMI State] cycle=%d\n",cycle); // @[CPU6502Core.scala 197:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4503 & _GEN_4357 & _GEN_4359 & _GEN_4361 & _GEN_4363 & _GEN_4376 & _GEN_4378 & _GEN_4380 & _T_14 &
          _T_11) begin
          $fwrite(32'h80000002,"[NMI] Setting cycle to 8\n"); // @[CPU6502Core.scala 245:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4525 & _GEN_4382 & _T_11) begin
          $fwrite(32'h80000002,"[NMI] Cycle 8: completing, vector=0x%x\n",resetVector); // @[CPU6502Core.scala 248:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
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
  output [7:0]  io_debug_opcode,
  output [1:0]  io_debug_state,
  output [2:0]  io_debug_cycle,
  input         io_reset,
  input         io_nmi
);
  wire  core_clock; // @[CPU6502Refactored.scala 21:20]
  wire  core_reset; // @[CPU6502Refactored.scala 21:20]
  wire [15:0] core_io_memAddr; // @[CPU6502Refactored.scala 21:20]
  wire [7:0] core_io_memDataOut; // @[CPU6502Refactored.scala 21:20]
  wire [7:0] core_io_memDataIn; // @[CPU6502Refactored.scala 21:20]
  wire  core_io_memWrite; // @[CPU6502Refactored.scala 21:20]
  wire  core_io_memRead; // @[CPU6502Refactored.scala 21:20]
  wire [7:0] core_io_debug_regA; // @[CPU6502Refactored.scala 21:20]
  wire [7:0] core_io_debug_regX; // @[CPU6502Refactored.scala 21:20]
  wire [7:0] core_io_debug_regY; // @[CPU6502Refactored.scala 21:20]
  wire [15:0] core_io_debug_regPC; // @[CPU6502Refactored.scala 21:20]
  wire [7:0] core_io_debug_opcode; // @[CPU6502Refactored.scala 21:20]
  wire [1:0] core_io_debug_state; // @[CPU6502Refactored.scala 21:20]
  wire [2:0] core_io_debug_cycle; // @[CPU6502Refactored.scala 21:20]
  wire  core_io_reset; // @[CPU6502Refactored.scala 21:20]
  wire  core_io_nmi; // @[CPU6502Refactored.scala 21:20]
  CPU6502Core core ( // @[CPU6502Refactored.scala 21:20]
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
    .io_debug_opcode(core_io_debug_opcode),
    .io_debug_state(core_io_debug_state),
    .io_debug_cycle(core_io_debug_cycle),
    .io_reset(core_io_reset),
    .io_nmi(core_io_nmi)
  );
  assign io_memAddr = core_io_memAddr; // @[CPU6502Refactored.scala 23:17]
  assign io_memDataOut = core_io_memDataOut; // @[CPU6502Refactored.scala 24:17]
  assign io_memWrite = core_io_memWrite; // @[CPU6502Refactored.scala 26:17]
  assign io_memRead = core_io_memRead; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_regA = core_io_debug_regA; // @[CPU6502Refactored.scala 29:17]
  assign io_debug_regX = core_io_debug_regX; // @[CPU6502Refactored.scala 29:17]
  assign io_debug_regY = core_io_debug_regY; // @[CPU6502Refactored.scala 29:17]
  assign io_debug_regPC = core_io_debug_regPC; // @[CPU6502Refactored.scala 29:17]
  assign io_debug_opcode = core_io_debug_opcode; // @[CPU6502Refactored.scala 29:17]
  assign io_debug_state = core_io_debug_state; // @[CPU6502Refactored.scala 29:17]
  assign io_debug_cycle = core_io_debug_cycle; // @[CPU6502Refactored.scala 29:17]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_memDataIn = io_memDataIn; // @[CPU6502Refactored.scala 25:21]
  assign core_io_reset = io_reset; // @[CPU6502Refactored.scala 30:17]
  assign core_io_nmi = io_nmi; // @[CPU6502Refactored.scala 31:17]
endmodule
module PPURegisterControl(
  input         clock,
  input         reset,
  input  [2:0]  io_cpuAddr,
  input  [7:0]  io_cpuDataIn,
  output [7:0]  io_cpuDataOut,
  input         io_cpuWrite,
  input         io_cpuRead,
  output [7:0]  io_regs_ppuCtrl,
  output [7:0]  io_regs_ppuMask,
  output [15:0] io_regs_ppuAddr,
  output        io_regs_vblank,
  input         io_setVBlank,
  input         io_clearVBlank
);
  reg [7:0] regs_ppuCtrl; // @[PPURegisters.scala 63:21]
  reg [7:0] regs_ppuMask; // @[PPURegisters.scala 63:21]
  reg [15:0] regs_ppuAddr; // @[PPURegisters.scala 63:21]
  reg [7:0] regs_ppuData; // @[PPURegisters.scala 63:21]
  reg  regs_addrLatch; // @[PPURegisters.scala 63:21]
  reg  regs_vblank; // @[PPURegisters.scala 63:21]
  reg  clearVBlankNext; // @[PPURegisters.scala 66:32]
  reg  clearAddrLatchNext; // @[PPURegisters.scala 67:35]
  wire [7:0] _io_cpuDataOut_T = {regs_vblank,1'h0,6'h0}; // @[Cat.scala 33:92]
  wire [7:0] _io_cpuDataOut_T_2 = 3'h2 == io_cpuAddr ? _io_cpuDataOut_T : 8'h0; // @[Mux.scala 81:58]
  wire  _io_cpuDataOut_T_3 = 3'h4 == io_cpuAddr; // @[Mux.scala 81:61]
  wire [7:0] _io_cpuDataOut_T_4 = 3'h4 == io_cpuAddr ? 8'h0 : _io_cpuDataOut_T_2; // @[Mux.scala 81:58]
  wire  _io_cpuDataOut_T_5 = 3'h7 == io_cpuAddr; // @[Mux.scala 81:61]
  wire  _T_1 = io_cpuRead & io_cpuAddr == 3'h2; // @[PPURegisters.scala 77:19]
  wire  _T_4 = ~reset; // @[PPURegisters.scala 78:11]
  wire  _T_12 = ~regs_addrLatch; // @[PPURegisters.scala 107:14]
  wire [15:0] _regs_ppuAddr_T_1 = {io_cpuDataIn,regs_ppuAddr[7:0]}; // @[Cat.scala 33:92]
  wire [15:0] _regs_ppuAddr_T_3 = {regs_ppuAddr[15:8],io_cpuDataIn}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_1 = ~regs_addrLatch ? _regs_ppuAddr_T_1 : _regs_ppuAddr_T_3; // @[PPURegisters.scala 107:31 108:24 110:24]
  wire [7:0] _GEN_2 = _io_cpuDataOut_T_5 ? io_cpuDataIn : regs_ppuData; // @[PPURegisters.scala 115:22 63:21 83:24]
  wire [15:0] _GEN_3 = 3'h6 == io_cpuAddr ? _GEN_1 : regs_ppuAddr; // @[PPURegisters.scala 63:21 83:24]
  wire  _GEN_4 = 3'h6 == io_cpuAddr ? _T_12 : regs_addrLatch; // @[PPURegisters.scala 112:24 63:21 83:24]
  wire [7:0] _GEN_5 = 3'h6 == io_cpuAddr ? regs_ppuData : _GEN_2; // @[PPURegisters.scala 63:21 83:24]
  wire [15:0] _GEN_8 = 3'h5 == io_cpuAddr ? regs_ppuAddr : _GEN_3; // @[PPURegisters.scala 63:21 83:24]
  wire  _GEN_9 = 3'h5 == io_cpuAddr ? regs_addrLatch : _GEN_4; // @[PPURegisters.scala 63:21 83:24]
  wire [7:0] _GEN_10 = 3'h5 == io_cpuAddr ? regs_ppuData : _GEN_5; // @[PPURegisters.scala 63:21 83:24]
  wire [15:0] _GEN_13 = _io_cpuDataOut_T_3 ? regs_ppuAddr : _GEN_8; // @[PPURegisters.scala 63:21 83:24]
  wire  _GEN_14 = _io_cpuDataOut_T_3 ? regs_addrLatch : _GEN_9; // @[PPURegisters.scala 63:21 83:24]
  wire [7:0] _GEN_15 = _io_cpuDataOut_T_3 ? regs_ppuData : _GEN_10; // @[PPURegisters.scala 63:21 83:24]
  wire [15:0] _GEN_19 = 3'h3 == io_cpuAddr ? regs_ppuAddr : _GEN_13; // @[PPURegisters.scala 63:21 83:24]
  wire  _GEN_20 = 3'h3 == io_cpuAddr ? regs_addrLatch : _GEN_14; // @[PPURegisters.scala 63:21 83:24]
  wire [7:0] _GEN_21 = 3'h3 == io_cpuAddr ? regs_ppuData : _GEN_15; // @[PPURegisters.scala 63:21 83:24]
  wire  _GEN_27 = 3'h1 == io_cpuAddr ? regs_addrLatch : _GEN_20; // @[PPURegisters.scala 63:21 83:24]
  wire  _GEN_35 = 3'h0 == io_cpuAddr ? regs_addrLatch : _GEN_27; // @[PPURegisters.scala 63:21 83:24]
  wire  _GEN_45 = _T_1 | clearVBlankNext; // @[PPURegisters.scala 122:42 126:21 66:32]
  wire  _GEN_46 = _T_1 | clearAddrLatchNext; // @[PPURegisters.scala 122:42 127:24 67:35]
  wire  _GEN_48 = io_clearVBlank ? 1'h0 : regs_vblank; // @[PPURegisters.scala 143:30 144:17 63:21]
  wire  _GEN_49 = clearVBlankNext ? 1'h0 : _GEN_48; // @[PPURegisters.scala 138:31 139:17]
  wire  _GEN_50 = io_setVBlank | _GEN_49; // @[PPURegisters.scala 132:22 133:17]
  wire  _GEN_59 = ~io_setVBlank; // @[PPURegisters.scala 141:13]
  assign io_cpuDataOut = 3'h7 == io_cpuAddr ? regs_ppuData : _io_cpuDataOut_T_4; // @[Mux.scala 81:58]
  assign io_regs_ppuCtrl = regs_ppuCtrl; // @[PPURegisters.scala 173:11]
  assign io_regs_ppuMask = regs_ppuMask; // @[PPURegisters.scala 173:11]
  assign io_regs_ppuAddr = regs_ppuAddr; // @[PPURegisters.scala 173:11]
  assign io_regs_vblank = regs_vblank; // @[PPURegisters.scala 173:11]
  always @(posedge clock) begin
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuCtrl <= 8'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 82:21]
      if (3'h0 == io_cpuAddr) begin // @[PPURegisters.scala 83:24]
        regs_ppuCtrl <= io_cpuDataIn; // @[PPURegisters.scala 85:22]
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuMask <= 8'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 82:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPURegisters.scala 83:24]
        if (3'h1 == io_cpuAddr) begin // @[PPURegisters.scala 83:24]
          regs_ppuMask <= io_cpuDataIn; // @[PPURegisters.scala 90:22]
        end
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuAddr <= 16'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 82:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPURegisters.scala 83:24]
        if (!(3'h1 == io_cpuAddr)) begin // @[PPURegisters.scala 83:24]
          regs_ppuAddr <= _GEN_19;
        end
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuData <= 8'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 82:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPURegisters.scala 83:24]
        if (!(3'h1 == io_cpuAddr)) begin // @[PPURegisters.scala 83:24]
          regs_ppuData <= _GEN_21;
        end
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_addrLatch <= 1'h0; // @[PPURegisters.scala 63:21]
    end else if (clearAddrLatchNext) begin // @[PPURegisters.scala 166:28]
      regs_addrLatch <= 1'h0; // @[PPURegisters.scala 167:20]
    end else if (clearAddrLatchNext) begin // @[PPURegisters.scala 156:28]
      regs_addrLatch <= 1'h0; // @[PPURegisters.scala 157:20]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 82:21]
      regs_addrLatch <= _GEN_35;
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_vblank <= 1'h0; // @[PPURegisters.scala 63:21]
    end else begin
      regs_vblank <= _GEN_50;
    end
    if (reset) begin // @[PPURegisters.scala 66:32]
      clearVBlankNext <= 1'h0; // @[PPURegisters.scala 66:32]
    end else if (clearVBlankNext) begin // @[PPURegisters.scala 151:25]
      clearVBlankNext <= 1'h0; // @[PPURegisters.scala 152:21]
    end else if (io_setVBlank) begin // @[PPURegisters.scala 132:22]
      clearVBlankNext <= 1'h0; // @[PPURegisters.scala 134:21]
    end else begin
      clearVBlankNext <= _GEN_45;
    end
    if (reset) begin // @[PPURegisters.scala 67:35]
      clearAddrLatchNext <= 1'h0; // @[PPURegisters.scala 67:35]
    end else if (clearAddrLatchNext) begin // @[PPURegisters.scala 156:28]
      clearAddrLatchNext <= 1'h0; // @[PPURegisters.scala 158:24]
    end else begin
      clearAddrLatchNext <= _GEN_46;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1 & ~reset) begin
          $fwrite(32'h80000002,"[PPU Regs] Output PPUSTATUS: vblank=%d output=0x%x\n",regs_vblank,_io_cpuDataOut_T); // @[PPURegisters.scala 78:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1 & _T_4) begin
          $fwrite(32'h80000002,"[PPU Regs] Read PPUSTATUS: vblank=%d, status=0x%x, will clear next cycle\n",regs_vblank,
            _io_cpuDataOut_T); // @[PPURegisters.scala 124:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_setVBlank & _T_4) begin
          $fwrite(32'h80000002,"[PPU Regs] setVBlank triggered, vblank=%d\n",1'h1); // @[PPURegisters.scala 136:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~io_setVBlank & clearVBlankNext & _T_4) begin
          $fwrite(32'h80000002,"[PPU Regs] clearVBlankNext executed, vblank cleared\n"); // @[PPURegisters.scala 141:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_59 & ~clearVBlankNext & io_clearVBlank & _T_4) begin
          $fwrite(32'h80000002,"[PPU Regs] clearVBlank triggered, vblank=%d\n",1'h0); // @[PPURegisters.scala 146:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module PPURefactored(
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
  output [7:0]  io_debug_ppuMask
);
  wire  regControl_clock; // @[PPURefactored.scala 50:26]
  wire  regControl_reset; // @[PPURefactored.scala 50:26]
  wire [2:0] regControl_io_cpuAddr; // @[PPURefactored.scala 50:26]
  wire [7:0] regControl_io_cpuDataIn; // @[PPURefactored.scala 50:26]
  wire [7:0] regControl_io_cpuDataOut; // @[PPURefactored.scala 50:26]
  wire  regControl_io_cpuWrite; // @[PPURefactored.scala 50:26]
  wire  regControl_io_cpuRead; // @[PPURefactored.scala 50:26]
  wire [7:0] regControl_io_regs_ppuCtrl; // @[PPURefactored.scala 50:26]
  wire [7:0] regControl_io_regs_ppuMask; // @[PPURefactored.scala 50:26]
  wire [15:0] regControl_io_regs_ppuAddr; // @[PPURefactored.scala 50:26]
  wire  regControl_io_regs_vblank; // @[PPURefactored.scala 50:26]
  wire  regControl_io_setVBlank; // @[PPURefactored.scala 50:26]
  wire  regControl_io_clearVBlank; // @[PPURefactored.scala 50:26]
  reg [7:0] chrRom [0:8191]; // @[PPURefactored.scala 127:19]
  wire  chrRom_patternLow_MPORT_en; // @[PPURefactored.scala 127:19]
  wire [12:0] chrRom_patternLow_MPORT_addr; // @[PPURefactored.scala 127:19]
  wire [7:0] chrRom_patternLow_MPORT_data; // @[PPURefactored.scala 127:19]
  wire  chrRom_patternHigh_MPORT_en; // @[PPURefactored.scala 127:19]
  wire [12:0] chrRom_patternHigh_MPORT_addr; // @[PPURefactored.scala 127:19]
  wire [7:0] chrRom_patternHigh_MPORT_data; // @[PPURefactored.scala 127:19]
  wire  chrRom_spritePatternLow_MPORT_en; // @[PPURefactored.scala 127:19]
  wire [12:0] chrRom_spritePatternLow_MPORT_addr; // @[PPURefactored.scala 127:19]
  wire [7:0] chrRom_spritePatternLow_MPORT_data; // @[PPURefactored.scala 127:19]
  wire  chrRom_spritePatternHigh_MPORT_en; // @[PPURefactored.scala 127:19]
  wire [12:0] chrRom_spritePatternHigh_MPORT_addr; // @[PPURefactored.scala 127:19]
  wire [7:0] chrRom_spritePatternHigh_MPORT_data; // @[PPURefactored.scala 127:19]
  wire [7:0] chrRom_MPORT_data; // @[PPURefactored.scala 127:19]
  wire [12:0] chrRom_MPORT_addr; // @[PPURefactored.scala 127:19]
  wire  chrRom_MPORT_mask; // @[PPURefactored.scala 127:19]
  wire  chrRom_MPORT_en; // @[PPURefactored.scala 127:19]
  reg [7:0] nametableRam [0:2047]; // @[PPURefactored.scala 141:25]
  wire  nametableRam_tileIndex_MPORT_en; // @[PPURefactored.scala 141:25]
  wire [10:0] nametableRam_tileIndex_MPORT_addr; // @[PPURefactored.scala 141:25]
  wire [7:0] nametableRam_tileIndex_MPORT_data; // @[PPURefactored.scala 141:25]
  wire  nametableRam_attrByte_MPORT_en; // @[PPURefactored.scala 141:25]
  wire [10:0] nametableRam_attrByte_MPORT_addr; // @[PPURefactored.scala 141:25]
  wire [7:0] nametableRam_attrByte_MPORT_data; // @[PPURefactored.scala 141:25]
  wire [7:0] nametableRam_MPORT_1_data; // @[PPURefactored.scala 141:25]
  wire [10:0] nametableRam_MPORT_1_addr; // @[PPURefactored.scala 141:25]
  wire  nametableRam_MPORT_1_mask; // @[PPURefactored.scala 141:25]
  wire  nametableRam_MPORT_1_en; // @[PPURefactored.scala 141:25]
  reg [8:0] scanline; // @[PPURefactored.scala 60:25]
  reg [8:0] pixel; // @[PPURefactored.scala 61:22]
  reg [31:0] debugCounter; // @[PPURefactored.scala 64:29]
  wire [31:0] _debugCounter_T_1 = debugCounter + 32'h1; // @[PPURefactored.scala 65:32]
  wire  _T = debugCounter == 32'h2710; // @[PPURefactored.scala 66:21]
  wire  _T_2 = ~reset; // @[PPURefactored.scala 67:11]
  wire  _T_3 = ~io_chrLoadEn; // @[PPURefactored.scala 72:8]
  wire  _T_4 = pixel == 9'h154; // @[PPURefactored.scala 74:16]
  wire  _T_5 = scanline == 9'h105; // @[PPURefactored.scala 76:21]
  wire [8:0] _scanline_T_1 = scanline + 9'h1; // @[PPURefactored.scala 80:30]
  wire  _T_8 = scanline == 9'hf0; // @[PPURefactored.scala 81:23]
  wire [8:0] _pixel_T_1 = pixel + 9'h1; // @[PPURefactored.scala 86:22]
  wire  _T_11 = scanline == 9'hf1; // @[PPURefactored.scala 96:17]
  wire  _T_12 = pixel == 9'h0; // @[PPURefactored.scala 96:36]
  wire  _T_13 = scanline == 9'hf1 & pixel == 9'h0; // @[PPURefactored.scala 96:27]
  wire  _T_18 = _T_5 & _T_12; // @[PPURefactored.scala 99:33]
  wire  _T_31 = _T_12 & (scanline == 9'h0 | scanline == 9'h3c | scanline == 9'h78 | scanline == 9'hb4 | _T_8); // @[PPURefactored.scala 105:22]
  wire  nmiEnable = regControl_io_regs_ppuCtrl[7]; // @[PPURefactored.scala 110:31]
  reg  nmiTrigger; // @[PPURefactored.scala 111:27]
  wire  _T_35 = pixel == 9'h1; // @[PPURefactored.scala 114:36]
  wire  _T_37 = _T_11 & pixel == 9'h1 & nmiEnable; // @[PPURefactored.scala 114:44]
  wire  _T_42 = _T_5 & _T_35; // @[PPURefactored.scala 119:32]
  wire  _GEN_9 = _T_5 & _T_35 ? 1'h0 : nmiTrigger; // @[PPURefactored.scala 119:50 120:16 111:27]
  wire  _GEN_10 = _T_11 & pixel == 9'h1 & nmiEnable | _GEN_9; // @[PPURefactored.scala 114:58 115:16]
  reg [5:0] paletteRam_0; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_1; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_2; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_3; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_4; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_5; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_6; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_7; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_8; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_9; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_10; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_11; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_12; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_13; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_14; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_15; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_16; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_17; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_18; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_19; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_20; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_21; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_22; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_23; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_24; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_25; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_26; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_27; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_28; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_29; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_30; // @[PPURefactored.scala 133:27]
  reg [5:0] paletteRam_31; // @[PPURefactored.scala 133:27]
  wire  _T_46 = io_cpuWrite & io_cpuAddr == 3'h7; // @[PPURefactored.scala 144:20]
  wire [4:0] paletteAddr = regControl_io_regs_ppuAddr[4:0]; // @[PPURefactored.scala 148:32]
  wire  _T_52 = regControl_io_regs_ppuAddr >= 16'h2000 & regControl_io_regs_ppuAddr < 16'h3f00; // @[PPURefactored.scala 150:36]
  wire  _GEN_87 = regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff ? 1'h0 : _T_52; // @[PPURefactored.scala 141:25 146:54]
  wire  isRendering = scanline < 9'hf0 & pixel < 9'h100; // @[PPURefactored.scala 164:38]
  wire [11:0] nametableBase = {regControl_io_regs_ppuCtrl[1:0],10'h0}; // @[Cat.scala 33:92]
  wire [9:0] _tileX_T = {{1'd0}, pixel}; // @[PPURefactored.scala 176:30]
  reg [5:0] tileX; // @[PPURefactored.scala 176:22]
  wire [9:0] _tileY_T = {{1'd0}, scanline}; // @[PPURefactored.scala 177:33]
  reg [5:0] tileY; // @[PPURefactored.scala 177:22]
  wire [10:0] _tileAddr_T = {tileY, 5'h0}; // @[PPURefactored.scala 178:49]
  wire [11:0] _GEN_739 = {{1'd0}, _tileAddr_T}; // @[PPURefactored.scala 178:40]
  wire [11:0] _tileAddr_T_2 = nametableBase + _GEN_739; // @[PPURefactored.scala 178:40]
  wire [11:0] _GEN_740 = {{6'd0}, tileX}; // @[PPURefactored.scala 178:55]
  reg [11:0] tileAddr; // @[PPURefactored.scala 178:25]
  reg [7:0] tileIndex; // @[PPURefactored.scala 179:26]
  wire [12:0] patternBase = regControl_io_regs_ppuCtrl[4] ? 13'h1000 : 13'h0; // @[PPURefactored.scala 181:24]
  reg [2:0] fineY; // @[PPURefactored.scala 182:22]
  wire [11:0] _patternAddr_T = {tileIndex, 4'h0}; // @[PPURefactored.scala 183:54]
  wire [12:0] _GEN_741 = {{1'd0}, _patternAddr_T}; // @[PPURefactored.scala 183:41]
  wire [12:0] _patternAddr_T_2 = patternBase + _GEN_741; // @[PPURefactored.scala 183:41]
  wire [12:0] _GEN_742 = {{10'd0}, fineY}; // @[PPURefactored.scala 183:60]
  reg [12:0] patternAddr; // @[PPURefactored.scala 183:28]
  reg [7:0] patternLow; // @[PPURefactored.scala 184:27]
  reg [7:0] patternHigh; // @[PPURefactored.scala 185:28]
  reg [2:0] fineX; // @[PPURefactored.scala 187:22]
  wire [11:0] _attrAddr_T_1 = nametableBase + 12'h3c0; // @[PPURefactored.scala 191:40]
  wire [6:0] _attrAddr_T_3 = {tileY[5:2], 3'h0}; // @[PPURefactored.scala 191:66]
  wire [11:0] _GEN_744 = {{5'd0}, _attrAddr_T_3}; // @[PPURefactored.scala 191:50]
  wire [11:0] _attrAddr_T_5 = _attrAddr_T_1 + _GEN_744; // @[PPURefactored.scala 191:50]
  wire [11:0] _GEN_745 = {{8'd0}, tileX[5:2]}; // @[PPURefactored.scala 191:72]
  reg [11:0] attrAddr; // @[PPURefactored.scala 191:25]
  reg [7:0] attrByte; // @[PPURefactored.scala 192:25]
  reg [8:0] spriteFineY; // @[PPURefactored.scala 211:28]
  wire [12:0] spritePatternBase = regControl_io_regs_ppuCtrl[3] ? 13'h1000 : 13'h0; // @[PPURefactored.scala 212:30]
  wire [13:0] _spritePatternAddr_T_1 = {{1'd0}, spritePatternBase}; // @[PPURefactored.scala 213:53]
  wire [12:0] _GEN_750 = {{4'd0}, spriteFineY}; // @[PPURefactored.scala 213:73]
  reg [12:0] spritePatternAddr; // @[PPURefactored.scala 213:34]
  reg [7:0] finalColor; // @[PPURefactored.scala 234:27]
  reg [7:0] patternLowReg; // @[PPURefactored.scala 238:30]
  reg [7:0] patternHighReg; // @[PPURefactored.scala 239:31]
  reg [7:0] attrByteReg; // @[PPURefactored.scala 240:28]
  reg [2:0] fineXReg; // @[PPURefactored.scala 243:25]
  wire [2:0] bitPosReg = 3'h7 - fineXReg; // @[PPURefactored.scala 244:23]
  wire [7:0] _pixelBitReg_T = patternHighReg >> bitPosReg; // @[PPURefactored.scala 245:38]
  wire [1:0] _pixelBitReg_T_2 = {_pixelBitReg_T[0], 1'h0}; // @[PPURefactored.scala 245:55]
  wire [7:0] _pixelBitReg_T_3 = patternLowReg >> bitPosReg; // @[PPURefactored.scala 245:79]
  wire [1:0] _GEN_753 = {{1'd0}, _pixelBitReg_T_3[0]}; // @[PPURefactored.scala 245:61]
  wire [1:0] pixelBitReg = _pixelBitReg_T_2 | _GEN_753; // @[PPURefactored.scala 245:61]
  reg [5:0] tileXReg; // @[PPURefactored.scala 247:25]
  reg [5:0] tileYReg; // @[PPURefactored.scala 248:25]
  wire [2:0] _attrShiftReg_T_1 = {tileYReg[1], 2'h0}; // @[PPURefactored.scala 249:36]
  wire [1:0] _attrShiftReg_T_3 = {tileXReg[1], 1'h0}; // @[PPURefactored.scala 249:57]
  wire [2:0] _GEN_754 = {{1'd0}, _attrShiftReg_T_3}; // @[PPURefactored.scala 249:42]
  wire [2:0] attrShiftReg = _attrShiftReg_T_1 | _GEN_754; // @[PPURefactored.scala 249:42]
  wire [7:0] _paletteIdxReg_T = attrByteReg >> attrShiftReg; // @[PPURefactored.scala 250:36]
  wire [1:0] paletteIdxReg = _paletteIdxReg_T[1:0]; // @[PPURefactored.scala 250:52]
  wire [3:0] _bgPaletteAddrReg_T = {paletteIdxReg, 2'h0}; // @[PPURefactored.scala 252:41]
  wire [3:0] _GEN_755 = {{2'd0}, pixelBitReg}; // @[PPURefactored.scala 252:47]
  wire [3:0] bgPaletteAddrReg = _bgPaletteAddrReg_T | _GEN_755; // @[PPURefactored.scala 252:47]
  wire [5:0] _GEN_705 = 4'h1 == bgPaletteAddrReg ? paletteRam_1 : paletteRam_0; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_706 = 4'h2 == bgPaletteAddrReg ? paletteRam_2 : _GEN_705; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_707 = 4'h3 == bgPaletteAddrReg ? paletteRam_3 : _GEN_706; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_708 = 4'h4 == bgPaletteAddrReg ? paletteRam_4 : _GEN_707; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_709 = 4'h5 == bgPaletteAddrReg ? paletteRam_5 : _GEN_708; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_710 = 4'h6 == bgPaletteAddrReg ? paletteRam_6 : _GEN_709; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_711 = 4'h7 == bgPaletteAddrReg ? paletteRam_7 : _GEN_710; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_712 = 4'h8 == bgPaletteAddrReg ? paletteRam_8 : _GEN_711; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_713 = 4'h9 == bgPaletteAddrReg ? paletteRam_9 : _GEN_712; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_714 = 4'ha == bgPaletteAddrReg ? paletteRam_10 : _GEN_713; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_715 = 4'hb == bgPaletteAddrReg ? paletteRam_11 : _GEN_714; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_716 = 4'hc == bgPaletteAddrReg ? paletteRam_12 : _GEN_715; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_717 = 4'hd == bgPaletteAddrReg ? paletteRam_13 : _GEN_716; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_718 = 4'he == bgPaletteAddrReg ? paletteRam_14 : _GEN_717; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_719 = 4'hf == bgPaletteAddrReg ? paletteRam_15 : _GEN_718; // @[PPURefactored.scala 253:{23,23}]
  wire [4:0] _GEN_756 = {{1'd0}, bgPaletteAddrReg}; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_720 = 5'h10 == _GEN_756 ? paletteRam_16 : _GEN_719; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_721 = 5'h11 == _GEN_756 ? paletteRam_17 : _GEN_720; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_722 = 5'h12 == _GEN_756 ? paletteRam_18 : _GEN_721; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_723 = 5'h13 == _GEN_756 ? paletteRam_19 : _GEN_722; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_724 = 5'h14 == _GEN_756 ? paletteRam_20 : _GEN_723; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_725 = 5'h15 == _GEN_756 ? paletteRam_21 : _GEN_724; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_726 = 5'h16 == _GEN_756 ? paletteRam_22 : _GEN_725; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_727 = 5'h17 == _GEN_756 ? paletteRam_23 : _GEN_726; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_728 = 5'h18 == _GEN_756 ? paletteRam_24 : _GEN_727; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_729 = 5'h19 == _GEN_756 ? paletteRam_25 : _GEN_728; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_730 = 5'h1a == _GEN_756 ? paletteRam_26 : _GEN_729; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_731 = 5'h1b == _GEN_756 ? paletteRam_27 : _GEN_730; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_732 = 5'h1c == _GEN_756 ? paletteRam_28 : _GEN_731; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_733 = 5'h1d == _GEN_756 ? paletteRam_29 : _GEN_732; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_734 = 5'h1e == _GEN_756 ? paletteRam_30 : _GEN_733; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] _GEN_735 = 5'h1f == _GEN_756 ? paletteRam_31 : _GEN_734; // @[PPURefactored.scala 253:{23,23}]
  wire [5:0] bgColorReg = pixelBitReg == 2'h0 ? paletteRam_0 : _GEN_735; // @[PPURefactored.scala 253:23]
  wire [5:0] _GEN_736 = pixelBitReg != 2'h0 ? bgColorReg : paletteRam_0; // @[PPURefactored.scala 259:16 260:31 262:18]
  wire [5:0] _GEN_737 = isRendering ? _GEN_736 : paletteRam_0; // @[PPURefactored.scala 258:27 265:16]
  wire [5:0] _GEN_738 = reset ? 6'h0 : _GEN_737; // @[PPURefactored.scala 255:22 257:16]
  wire  _GEN_778 = _T_3 & _T_4; // @[PPURefactored.scala 78:15]
  PPURegisterControl regControl ( // @[PPURefactored.scala 50:26]
    .clock(regControl_clock),
    .reset(regControl_reset),
    .io_cpuAddr(regControl_io_cpuAddr),
    .io_cpuDataIn(regControl_io_cpuDataIn),
    .io_cpuDataOut(regControl_io_cpuDataOut),
    .io_cpuWrite(regControl_io_cpuWrite),
    .io_cpuRead(regControl_io_cpuRead),
    .io_regs_ppuCtrl(regControl_io_regs_ppuCtrl),
    .io_regs_ppuMask(regControl_io_regs_ppuMask),
    .io_regs_ppuAddr(regControl_io_regs_ppuAddr),
    .io_regs_vblank(regControl_io_regs_vblank),
    .io_setVBlank(regControl_io_setVBlank),
    .io_clearVBlank(regControl_io_clearVBlank)
  );
  assign chrRom_patternLow_MPORT_en = 1'h1;
  assign chrRom_patternLow_MPORT_addr = patternAddr;
  assign chrRom_patternLow_MPORT_data = chrRom[chrRom_patternLow_MPORT_addr]; // @[PPURefactored.scala 127:19]
  assign chrRom_patternHigh_MPORT_en = 1'h1;
  assign chrRom_patternHigh_MPORT_addr = patternAddr + 13'h8;
  assign chrRom_patternHigh_MPORT_data = chrRom[chrRom_patternHigh_MPORT_addr]; // @[PPURefactored.scala 127:19]
  assign chrRom_spritePatternLow_MPORT_en = 1'h1;
  assign chrRom_spritePatternLow_MPORT_addr = spritePatternAddr;
  assign chrRom_spritePatternLow_MPORT_data = chrRom[chrRom_spritePatternLow_MPORT_addr]; // @[PPURefactored.scala 127:19]
  assign chrRom_spritePatternHigh_MPORT_en = 1'h1;
  assign chrRom_spritePatternHigh_MPORT_addr = spritePatternAddr + 13'h8;
  assign chrRom_spritePatternHigh_MPORT_data = chrRom[chrRom_spritePatternHigh_MPORT_addr]; // @[PPURefactored.scala 127:19]
  assign chrRom_MPORT_data = io_chrLoadData;
  assign chrRom_MPORT_addr = io_chrLoadAddr;
  assign chrRom_MPORT_mask = 1'h1;
  assign chrRom_MPORT_en = io_chrLoadEn;
  assign nametableRam_tileIndex_MPORT_en = 1'h1;
  assign nametableRam_tileIndex_MPORT_addr = tileAddr[10:0];
  assign nametableRam_tileIndex_MPORT_data = nametableRam[nametableRam_tileIndex_MPORT_addr]; // @[PPURefactored.scala 141:25]
  assign nametableRam_attrByte_MPORT_en = 1'h1;
  assign nametableRam_attrByte_MPORT_addr = attrAddr[10:0];
  assign nametableRam_attrByte_MPORT_data = nametableRam[nametableRam_attrByte_MPORT_addr]; // @[PPURefactored.scala 141:25]
  assign nametableRam_MPORT_1_data = io_cpuDataIn;
  assign nametableRam_MPORT_1_addr = regControl_io_regs_ppuAddr[10:0];
  assign nametableRam_MPORT_1_mask = 1'h1;
  assign nametableRam_MPORT_1_en = _T_46 & _GEN_87;
  assign io_cpuDataOut = regControl_io_cpuDataOut; // @[PPURefactored.scala 55:17]
  assign io_pixelX = pixel; // @[PPURefactored.scala 269:13]
  assign io_pixelY = scanline; // @[PPURefactored.scala 270:13]
  assign io_pixelColor = finalColor[5:0]; // @[PPURefactored.scala 271:30]
  assign io_vblank = regControl_io_regs_vblank; // @[PPURefactored.scala 272:13]
  assign io_nmiOut = nmiTrigger; // @[PPURefactored.scala 124:13]
  assign io_debug_ppuCtrl = regControl_io_regs_ppuCtrl; // @[PPURefactored.scala 278:20]
  assign io_debug_ppuMask = regControl_io_regs_ppuMask; // @[PPURefactored.scala 279:20]
  assign regControl_clock = clock;
  assign regControl_reset = reset;
  assign regControl_io_cpuAddr = io_cpuAddr; // @[PPURefactored.scala 51:25]
  assign regControl_io_cpuDataIn = io_cpuDataIn; // @[PPURefactored.scala 52:27]
  assign regControl_io_cpuWrite = io_cpuWrite; // @[PPURefactored.scala 53:26]
  assign regControl_io_cpuRead = io_cpuRead; // @[PPURefactored.scala 54:25]
  assign regControl_io_setVBlank = scanline == 9'hf1 & pixel == 9'h0; // @[PPURefactored.scala 96:27]
  assign regControl_io_clearVBlank = scanline == 9'hf1 & pixel == 9'h0 ? 1'h0 : _T_18; // @[PPURefactored.scala 92:29 96:45]
  always @(posedge clock) begin
    if (chrRom_MPORT_en & chrRom_MPORT_mask) begin
      chrRom[chrRom_MPORT_addr] <= chrRom_MPORT_data; // @[PPURefactored.scala 127:19]
    end
    if (nametableRam_MPORT_1_en & nametableRam_MPORT_1_mask) begin
      nametableRam[nametableRam_MPORT_1_addr] <= nametableRam_MPORT_1_data; // @[PPURefactored.scala 141:25]
    end
    if (reset) begin // @[PPURefactored.scala 60:25]
      scanline <= 9'h0; // @[PPURefactored.scala 60:25]
    end else if (~io_chrLoadEn) begin // @[PPURefactored.scala 72:23]
      if (pixel == 9'h154) begin // @[PPURefactored.scala 74:27]
        if (scanline == 9'h105) begin // @[PPURefactored.scala 76:32]
          scanline <= 9'h0; // @[PPURefactored.scala 77:18]
        end else begin
          scanline <= _scanline_T_1; // @[PPURefactored.scala 80:18]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 61:22]
      pixel <= 9'h0; // @[PPURefactored.scala 61:22]
    end else if (~io_chrLoadEn) begin // @[PPURefactored.scala 72:23]
      if (pixel == 9'h154) begin // @[PPURefactored.scala 74:27]
        pixel <= 9'h0; // @[PPURefactored.scala 75:13]
      end else begin
        pixel <= _pixel_T_1; // @[PPURefactored.scala 86:13]
      end
    end
    if (reset) begin // @[PPURefactored.scala 64:29]
      debugCounter <= 32'h0; // @[PPURefactored.scala 64:29]
    end else if (debugCounter == 32'h2710) begin // @[PPURefactored.scala 66:34]
      debugCounter <= 32'h0; // @[PPURefactored.scala 68:18]
    end else begin
      debugCounter <= _debugCounter_T_1; // @[PPURefactored.scala 65:16]
    end
    if (reset) begin // @[PPURefactored.scala 111:27]
      nmiTrigger <= 1'h0; // @[PPURefactored.scala 111:27]
    end else begin
      nmiTrigger <= _GEN_10;
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_0 <= 6'h9; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h0 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_0 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_1 <= 6'h1; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h1 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_1 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_2 <= 6'h0; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h2 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_2 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_3 <= 6'h1; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h3 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_3 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_4 <= 6'h0; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h4 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_4 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_5 <= 6'h2; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h5 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_5 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_6 <= 6'h2; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h6 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_6 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_7 <= 6'hd; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h7 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_7 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_8 <= 6'h8; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h8 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_8 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_9 <= 6'h10; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h9 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_9 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_10 <= 6'h8; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'ha == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_10 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_11 <= 6'h24; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'hb == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_11 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_12 <= 6'h0; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'hc == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_12 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_13 <= 6'h0; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'hd == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_13 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_14 <= 6'h4; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'he == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_14 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_15 <= 6'h2c; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'hf == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_15 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_16 <= 6'h9; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h10 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_16 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_17 <= 6'h1; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h11 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_17 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_18 <= 6'h34; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h12 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_18 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_19 <= 6'h3; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h13 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_19 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_20 <= 6'h0; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h14 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_20 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_21 <= 6'h4; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h15 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_21 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_22 <= 6'h0; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h16 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_22 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_23 <= 6'h14; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h17 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_23 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_24 <= 6'h8; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h18 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_24 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_25 <= 6'h3a; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h19 == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_25 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_26 <= 6'h0; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h1a == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_26 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_27 <= 6'h2; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h1b == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_27 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_28 <= 6'h0; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h1c == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_28 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_29 <= 6'h20; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h1d == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_29 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_30 <= 6'h2c; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h1e == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_30 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 133:27]
      paletteRam_31 <= 6'h8; // @[PPURefactored.scala 133:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 144:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 146:54]
        if (5'h1f == paletteAddr) begin // @[PPURefactored.scala 149:31]
          paletteRam_31 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 149:31]
        end
      end
    end
    tileX <= _tileX_T[8:3]; // @[PPURefactored.scala 176:41]
    tileY <= _tileY_T[8:3]; // @[PPURefactored.scala 177:44]
    tileAddr <= _tileAddr_T_2 + _GEN_740; // @[PPURefactored.scala 178:55]
    tileIndex <= nametableRam_tileIndex_MPORT_data; // @[PPURefactored.scala 179:26]
    fineY <= _tileY_T[2:0]; // @[PPURefactored.scala 182:43]
    patternAddr <= _patternAddr_T_2 + _GEN_742; // @[PPURefactored.scala 183:60]
    patternLow <= chrRom_patternLow_MPORT_data; // @[PPURefactored.scala 184:27]
    patternHigh <= chrRom_patternHigh_MPORT_data; // @[PPURefactored.scala 185:28]
    fineX <= _tileX_T[2:0]; // @[PPURefactored.scala 187:40]
    attrAddr <= _attrAddr_T_5 + _GEN_745; // @[PPURefactored.scala 191:72]
    attrByte <= nametableRam_attrByte_MPORT_data; // @[PPURefactored.scala 192:25]
    spriteFineY <= scanline - 9'h0; // @[PPURefactored.scala 211:38]
    spritePatternAddr <= _spritePatternAddr_T_1[12:0] + _GEN_750; // @[PPURefactored.scala 213:73]
    if (reset) begin // @[PPURefactored.scala 234:27]
      finalColor <= 8'h0; // @[PPURefactored.scala 234:27]
    end else begin
      finalColor <= {{2'd0}, _GEN_738};
    end
    patternLowReg <= patternLow; // @[PPURefactored.scala 238:30]
    patternHighReg <= patternHigh; // @[PPURefactored.scala 239:31]
    attrByteReg <= attrByte; // @[PPURefactored.scala 240:28]
    fineXReg <= fineX; // @[PPURefactored.scala 243:25]
    tileXReg <= tileX; // @[PPURefactored.scala 247:25]
    tileYReg <= tileY; // @[PPURefactored.scala 248:25]
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T & ~reset) begin
          $fwrite(32'h80000002,"[PPU Debug] scanline=%d pixel=%d\n",scanline,pixel); // @[PPURefactored.scala 67:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_3 & _T_4 & _T_5 & _T_2) begin
          $fwrite(32'h80000002,"[PPU] Frame complete, reset to scanline 0\n"); // @[PPURefactored.scala 78:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_778 & ~_T_5 & _T_8 & _T_2) begin
          $fwrite(32'h80000002,"[PPU] Entering VBlank region, next scanline=241\n"); // @[PPURefactored.scala 82:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_13 & _T_2) begin
          $fwrite(32'h80000002,"[PPU] VBlank START at scanline=241 pixel=0\n"); // @[PPURefactored.scala 98:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~_T_13 & _T_18 & _T_2) begin
          $fwrite(32'h80000002,"[PPU] VBlank END at scanline=261 pixel=0\n"); // @[PPURefactored.scala 101:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_31 & _T_2) begin
          $fwrite(32'h80000002,"[PPU] scanline=%d\n",scanline); // @[PPURefactored.scala 106:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_37 & _T_2) begin
          $fwrite(32'h80000002,"[PPU] NMI Triggered at scanline=241 pixel=1\n"); // @[PPURefactored.scala 116:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~_T_37 & _T_42 & _T_2) begin
          $fwrite(32'h80000002,"[PPU] NMI Cleared at scanline=261 pixel=1\n"); // @[PPURefactored.scala 121:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module MMC3Mapper(
  input         clock,
  input         reset,
  input  [15:0] io_cpuAddr,
  input  [7:0]  io_cpuDataIn,
  output [7:0]  io_cpuDataOut,
  input         io_cpuWrite,
  output [18:0] io_prgAddr,
  input  [7:0]  io_prgData
);
  reg [2:0] bankSelect; // @[MMC3Mapper.scala 36:27]
  reg  prgRomBankMode; // @[MMC3Mapper.scala 37:31]
  reg [7:0] r6; // @[MMC3Mapper.scala 47:19]
  reg [7:0] r7; // @[MMC3Mapper.scala 48:19]
  wire [7:0] _GEN_0 = 3'h7 == bankSelect ? io_cpuDataIn : r7; // @[MMC3Mapper.scala 48:19 72:30 80:26]
  wire [7:0] _GEN_1 = 3'h6 == bankSelect ? io_cpuDataIn : r6; // @[MMC3Mapper.scala 47:19 72:30 79:26]
  wire [7:0] _GEN_2 = 3'h6 == bankSelect ? r7 : _GEN_0; // @[MMC3Mapper.scala 48:19 72:30]
  wire [7:0] _GEN_4 = 3'h5 == bankSelect ? r6 : _GEN_1; // @[MMC3Mapper.scala 47:19 72:30]
  wire [7:0] _GEN_5 = 3'h5 == bankSelect ? r7 : _GEN_2; // @[MMC3Mapper.scala 48:19 72:30]
  wire [7:0] _GEN_8 = 3'h4 == bankSelect ? r6 : _GEN_4; // @[MMC3Mapper.scala 47:19 72:30]
  wire [7:0] _GEN_9 = 3'h4 == bankSelect ? r7 : _GEN_5; // @[MMC3Mapper.scala 48:19 72:30]
  wire [7:0] _GEN_13 = 3'h3 == bankSelect ? r6 : _GEN_8; // @[MMC3Mapper.scala 47:19 72:30]
  wire [7:0] _GEN_14 = 3'h3 == bankSelect ? r7 : _GEN_9; // @[MMC3Mapper.scala 48:19 72:30]
  wire [7:0] _GEN_19 = 3'h2 == bankSelect ? r6 : _GEN_13; // @[MMC3Mapper.scala 47:19 72:30]
  wire [7:0] _GEN_20 = 3'h2 == bankSelect ? r7 : _GEN_14; // @[MMC3Mapper.scala 48:19 72:30]
  wire [7:0] _GEN_26 = 3'h1 == bankSelect ? r6 : _GEN_19; // @[MMC3Mapper.scala 47:19 72:30]
  wire [7:0] _GEN_27 = 3'h1 == bankSelect ? r7 : _GEN_20; // @[MMC3Mapper.scala 48:19 72:30]
  wire [7:0] _GEN_34 = 3'h0 == bankSelect ? r6 : _GEN_26; // @[MMC3Mapper.scala 47:19 72:30]
  wire [7:0] _GEN_35 = 3'h0 == bankSelect ? r7 : _GEN_27; // @[MMC3Mapper.scala 48:19 72:30]
  wire [7:0] prgBank0 = prgRomBankMode ? 8'hfe : r6; // @[MMC3Mapper.scala 121:24 123:14 129:14]
  wire [7:0] prgBank2 = prgRomBankMode ? r6 : 8'hfe; // @[MMC3Mapper.scala 121:24 125:14 131:14]
  wire [7:0] _GEN_99 = 2'h3 == io_cpuAddr[14:13] ? 8'hff : 8'h0; // @[MMC3Mapper.scala 137:30 141:26 136:31]
  wire [7:0] _GEN_100 = 2'h2 == io_cpuAddr[14:13] ? prgBank2 : _GEN_99; // @[MMC3Mapper.scala 137:30 140:26]
  wire [7:0] _GEN_101 = 2'h1 == io_cpuAddr[14:13] ? r7 : _GEN_100; // @[MMC3Mapper.scala 137:30 139:26]
  wire [7:0] prgBankNum = 2'h0 == io_cpuAddr[14:13] ? prgBank0 : _GEN_101; // @[MMC3Mapper.scala 137:30 138:26]
  reg [20:0] io_prgAddr_REG; // @[MMC3Mapper.scala 145:24]
  reg [7:0] io_cpuDataOut_REG; // @[MMC3Mapper.scala 146:27]
  assign io_cpuDataOut = io_cpuDataOut_REG; // @[MMC3Mapper.scala 146:17]
  assign io_prgAddr = io_prgAddr_REG[18:0]; // @[MMC3Mapper.scala 145:14]
  always @(posedge clock) begin
    if (reset) begin // @[MMC3Mapper.scala 36:27]
      bankSelect <= 3'h0; // @[MMC3Mapper.scala 36:27]
    end else if (io_cpuWrite) begin // @[MMC3Mapper.scala 62:21]
      if (3'h4 == io_cpuAddr[15:13]) begin // @[MMC3Mapper.scala 63:32]
        if (~io_cpuAddr[0]) begin // @[MMC3Mapper.scala 65:37]
          bankSelect <= io_cpuDataIn[2:0]; // @[MMC3Mapper.scala 67:22]
        end
      end
    end
    if (reset) begin // @[MMC3Mapper.scala 37:31]
      prgRomBankMode <= 1'h0; // @[MMC3Mapper.scala 37:31]
    end else if (io_cpuWrite) begin // @[MMC3Mapper.scala 62:21]
      if (3'h4 == io_cpuAddr[15:13]) begin // @[MMC3Mapper.scala 63:32]
        if (~io_cpuAddr[0]) begin // @[MMC3Mapper.scala 65:37]
          prgRomBankMode <= io_cpuDataIn[6]; // @[MMC3Mapper.scala 68:26]
        end
      end
    end
    if (reset) begin // @[MMC3Mapper.scala 47:19]
      r6 <= 8'h0; // @[MMC3Mapper.scala 47:19]
    end else if (io_cpuWrite) begin // @[MMC3Mapper.scala 62:21]
      if (3'h4 == io_cpuAddr[15:13]) begin // @[MMC3Mapper.scala 63:32]
        if (!(~io_cpuAddr[0])) begin // @[MMC3Mapper.scala 65:37]
          r6 <= _GEN_34;
        end
      end
    end
    if (reset) begin // @[MMC3Mapper.scala 48:19]
      r7 <= 8'h0; // @[MMC3Mapper.scala 48:19]
    end else if (io_cpuWrite) begin // @[MMC3Mapper.scala 62:21]
      if (3'h4 == io_cpuAddr[15:13]) begin // @[MMC3Mapper.scala 63:32]
        if (!(~io_cpuAddr[0])) begin // @[MMC3Mapper.scala 65:37]
          r7 <= _GEN_35;
        end
      end
    end
    io_prgAddr_REG <= {prgBankNum,io_cpuAddr[12:0]}; // @[Cat.scala 33:92]
    io_cpuDataOut_REG <= io_prgData; // @[MMC3Mapper.scala 146:27]
  end
endmodule
module NESSystemRefactored(
  input         clock,
  input         reset,
  output [8:0]  io_pixelX,
  output [8:0]  io_pixelY,
  output [5:0]  io_pixelColor,
  output        io_vblank,
  output [15:0] io_audioOut,
  input         io_prgLoadEn,
  input  [18:0] io_prgLoadAddr,
  input  [7:0]  io_prgLoadData,
  input         io_chrLoadEn,
  input  [12:0] io_chrLoadAddr,
  input  [7:0]  io_chrLoadData,
  input  [7:0]  io_mapperNum,
  input  [7:0]  io_controller1,
  input  [7:0]  io_controller2,
  output [15:0] io_debug_cpuPC,
  output [7:0]  io_debug_cpuA,
  output [7:0]  io_debug_cpuX,
  output [7:0]  io_debug_cpuY,
  output [7:0]  io_debug_ppuCtrl,
  output [7:0]  io_debug_ppuMask,
  output        io_debug_vblank,
  output        io_debug_nmi,
  output        io_debug_apuPulse1Active,
  output        io_debug_apuPulse2Active,
  output [2:0]  io_debug_cpuState,
  output [2:0]  io_debug_cpuCycle,
  output [7:0]  io_debug_cpuOpcode,
  output [15:0] io_debug_cpuMemAddr,
  output [7:0]  io_debug_cpuMemDataIn,
  output        io_debug_cpuMemRead
);
  wire  cpu_clock; // @[NESSystemRefactored.scala 61:19]
  wire  cpu_reset; // @[NESSystemRefactored.scala 61:19]
  wire [15:0] cpu_io_memAddr; // @[NESSystemRefactored.scala 61:19]
  wire [7:0] cpu_io_memDataOut; // @[NESSystemRefactored.scala 61:19]
  wire [7:0] cpu_io_memDataIn; // @[NESSystemRefactored.scala 61:19]
  wire  cpu_io_memWrite; // @[NESSystemRefactored.scala 61:19]
  wire  cpu_io_memRead; // @[NESSystemRefactored.scala 61:19]
  wire [7:0] cpu_io_debug_regA; // @[NESSystemRefactored.scala 61:19]
  wire [7:0] cpu_io_debug_regX; // @[NESSystemRefactored.scala 61:19]
  wire [7:0] cpu_io_debug_regY; // @[NESSystemRefactored.scala 61:19]
  wire [15:0] cpu_io_debug_regPC; // @[NESSystemRefactored.scala 61:19]
  wire [7:0] cpu_io_debug_opcode; // @[NESSystemRefactored.scala 61:19]
  wire [1:0] cpu_io_debug_state; // @[NESSystemRefactored.scala 61:19]
  wire [2:0] cpu_io_debug_cycle; // @[NESSystemRefactored.scala 61:19]
  wire  cpu_io_reset; // @[NESSystemRefactored.scala 61:19]
  wire  cpu_io_nmi; // @[NESSystemRefactored.scala 61:19]
  wire  ppu_clock; // @[NESSystemRefactored.scala 64:19]
  wire  ppu_reset; // @[NESSystemRefactored.scala 64:19]
  wire [2:0] ppu_io_cpuAddr; // @[NESSystemRefactored.scala 64:19]
  wire [7:0] ppu_io_cpuDataIn; // @[NESSystemRefactored.scala 64:19]
  wire [7:0] ppu_io_cpuDataOut; // @[NESSystemRefactored.scala 64:19]
  wire  ppu_io_cpuWrite; // @[NESSystemRefactored.scala 64:19]
  wire  ppu_io_cpuRead; // @[NESSystemRefactored.scala 64:19]
  wire [8:0] ppu_io_pixelX; // @[NESSystemRefactored.scala 64:19]
  wire [8:0] ppu_io_pixelY; // @[NESSystemRefactored.scala 64:19]
  wire [5:0] ppu_io_pixelColor; // @[NESSystemRefactored.scala 64:19]
  wire  ppu_io_vblank; // @[NESSystemRefactored.scala 64:19]
  wire  ppu_io_nmiOut; // @[NESSystemRefactored.scala 64:19]
  wire  ppu_io_chrLoadEn; // @[NESSystemRefactored.scala 64:19]
  wire [12:0] ppu_io_chrLoadAddr; // @[NESSystemRefactored.scala 64:19]
  wire [7:0] ppu_io_chrLoadData; // @[NESSystemRefactored.scala 64:19]
  wire [7:0] ppu_io_debug_ppuCtrl; // @[NESSystemRefactored.scala 64:19]
  wire [7:0] ppu_io_debug_ppuMask; // @[NESSystemRefactored.scala 64:19]
  reg [7:0] prgRom [0:524287]; // @[NESSystemRefactored.scala 71:27]
  wire  prgRom_prgData_MPORT_en; // @[NESSystemRefactored.scala 71:27]
  wire [18:0] prgRom_prgData_MPORT_addr; // @[NESSystemRefactored.scala 71:27]
  wire [7:0] prgRom_prgData_MPORT_data; // @[NESSystemRefactored.scala 71:27]
  wire [7:0] prgRom_MPORT_data; // @[NESSystemRefactored.scala 71:27]
  wire [18:0] prgRom_MPORT_addr; // @[NESSystemRefactored.scala 71:27]
  wire  prgRom_MPORT_mask; // @[NESSystemRefactored.scala 71:27]
  wire  prgRom_MPORT_en; // @[NESSystemRefactored.scala 71:27]
  reg  prgRom_prgData_MPORT_en_pipe_0;
  reg [18:0] prgRom_prgData_MPORT_addr_pipe_0;
  wire  mmc3_clock; // @[NESSystemRefactored.scala 78:20]
  wire  mmc3_reset; // @[NESSystemRefactored.scala 78:20]
  wire [15:0] mmc3_io_cpuAddr; // @[NESSystemRefactored.scala 78:20]
  wire [7:0] mmc3_io_cpuDataIn; // @[NESSystemRefactored.scala 78:20]
  wire [7:0] mmc3_io_cpuDataOut; // @[NESSystemRefactored.scala 78:20]
  wire  mmc3_io_cpuWrite; // @[NESSystemRefactored.scala 78:20]
  wire [18:0] mmc3_io_prgAddr; // @[NESSystemRefactored.scala 78:20]
  wire [7:0] mmc3_io_prgData; // @[NESSystemRefactored.scala 78:20]
  reg [7:0] ram [0:2047]; // @[NESSystemRefactored.scala 81:16]
  wire  ram_ramData_en; // @[NESSystemRefactored.scala 81:16]
  wire [10:0] ram_ramData_addr; // @[NESSystemRefactored.scala 81:16]
  wire [7:0] ram_ramData_data; // @[NESSystemRefactored.scala 81:16]
  wire [7:0] ram_MPORT_1_data; // @[NESSystemRefactored.scala 81:16]
  wire [10:0] ram_MPORT_1_addr; // @[NESSystemRefactored.scala 81:16]
  wire  ram_MPORT_1_mask; // @[NESSystemRefactored.scala 81:16]
  wire  ram_MPORT_1_en; // @[NESSystemRefactored.scala 81:16]
  wire  _T = cpu_io_memAddr >= 16'h2000; // @[NESSystemRefactored.scala 85:16]
  wire  _T_2 = cpu_io_memAddr >= 16'h2000 & cpu_io_memAddr <= 16'h2010; // @[NESSystemRefactored.scala 85:28]
  wire  _T_4 = ~reset; // @[NESSystemRefactored.scala 86:11]
  wire  isRam = cpu_io_memAddr < 16'h2000; // @[NESSystemRefactored.scala 89:23]
  wire  isPpuReg = _T & cpu_io_memAddr < 16'h4000; // @[NESSystemRefactored.scala 90:38]
  wire  _isController_T = cpu_io_memAddr == 16'h4016; // @[NESSystemRefactored.scala 92:30]
  wire  isController = cpu_io_memAddr == 16'h4016 | cpu_io_memAddr == 16'h4017; // @[NESSystemRefactored.scala 92:43]
  wire  isPrgRom = cpu_io_memAddr >= 16'h8000; // @[NESSystemRefactored.scala 93:26]
  reg [7:0] prgData; // @[NESSystemRefactored.scala 103:24]
  reg [7:0] controller1Shift; // @[NESSystemRefactored.scala 110:33]
  reg [7:0] controller2Shift; // @[NESSystemRefactored.scala 111:33]
  reg  controllerStrobe; // @[NESSystemRefactored.scala 112:33]
  wire [7:0] _GEN_9 = cpu_io_memDataOut[0] ? io_controller1 : controller1Shift; // @[NESSystemRefactored.scala 116:32 118:24 110:33]
  wire [7:0] _GEN_10 = cpu_io_memDataOut[0] ? io_controller2 : controller2Shift; // @[NESSystemRefactored.scala 116:32 119:24 111:33]
  wire [7:0] _GEN_12 = cpu_io_memWrite & _isController_T ? _GEN_9 : controller1Shift; // @[NESSystemRefactored.scala 110:33 114:49]
  wire [7:0] _GEN_13 = cpu_io_memWrite & _isController_T ? _GEN_10 : controller2Shift; // @[NESSystemRefactored.scala 111:33 114:49]
  wire  controller1Data = controller1Shift[0]; // @[NESSystemRefactored.scala 124:41]
  wire  controller2Data = controller2Shift[0]; // @[NESSystemRefactored.scala 125:41]
  wire  controllerData = cpu_io_memAddr[0] ? controller2Data : controller1Data; // @[NESSystemRefactored.scala 135:27]
  wire [7:0] _cpu_io_memDataIn_T = isPrgRom ? mmc3_io_cpuDataOut : 8'h0; // @[Mux.scala 101:16]
  wire [7:0] _cpu_io_memDataIn_T_1 = isController ? {{7'd0}, controllerData} : _cpu_io_memDataIn_T; // @[Mux.scala 101:16]
  wire [7:0] _cpu_io_memDataIn_T_2 = isPpuReg ? ppu_io_cpuDataOut : _cpu_io_memDataIn_T_1; // @[Mux.scala 101:16]
  wire  _T_23 = cpu_io_memAddr >= 16'h200 & cpu_io_memAddr < 16'h210; // @[NESSystemRefactored.scala 167:32]
  wire  _GEN_25 = cpu_io_memWrite & isRam; // @[NESSystemRefactored.scala 162:25 81:16]
  wire  _ppu_io_cpuWrite_T = cpu_io_memWrite & isPpuReg; // @[NESSystemRefactored.scala 177:38]
  wire  _ppu_io_cpuRead_T = cpu_io_memRead & isPpuReg; // @[NESSystemRefactored.scala 178:36]
  CPU6502Refactored cpu ( // @[NESSystemRefactored.scala 61:19]
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
    .io_debug_opcode(cpu_io_debug_opcode),
    .io_debug_state(cpu_io_debug_state),
    .io_debug_cycle(cpu_io_debug_cycle),
    .io_reset(cpu_io_reset),
    .io_nmi(cpu_io_nmi)
  );
  PPURefactored ppu ( // @[NESSystemRefactored.scala 64:19]
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
    .io_debug_ppuMask(ppu_io_debug_ppuMask)
  );
  MMC3Mapper mmc3 ( // @[NESSystemRefactored.scala 78:20]
    .clock(mmc3_clock),
    .reset(mmc3_reset),
    .io_cpuAddr(mmc3_io_cpuAddr),
    .io_cpuDataIn(mmc3_io_cpuDataIn),
    .io_cpuDataOut(mmc3_io_cpuDataOut),
    .io_cpuWrite(mmc3_io_cpuWrite),
    .io_prgAddr(mmc3_io_prgAddr),
    .io_prgData(mmc3_io_prgData)
  );
  assign prgRom_prgData_MPORT_en = prgRom_prgData_MPORT_en_pipe_0;
  assign prgRom_prgData_MPORT_addr = prgRom_prgData_MPORT_addr_pipe_0;
  assign prgRom_prgData_MPORT_data = prgRom[prgRom_prgData_MPORT_addr]; // @[NESSystemRefactored.scala 71:27]
  assign prgRom_MPORT_data = io_prgLoadData;
  assign prgRom_MPORT_addr = io_prgLoadAddr;
  assign prgRom_MPORT_mask = 1'h1;
  assign prgRom_MPORT_en = io_prgLoadEn;
  assign ram_ramData_en = 1'h1;
  assign ram_ramData_addr = cpu_io_memAddr[10:0];
  assign ram_ramData_data = ram[ram_ramData_addr]; // @[NESSystemRefactored.scala 81:16]
  assign ram_MPORT_1_data = cpu_io_memDataOut;
  assign ram_MPORT_1_addr = cpu_io_memAddr[10:0];
  assign ram_MPORT_1_mask = 1'h1;
  assign ram_MPORT_1_en = cpu_io_memWrite & isRam;
  assign io_pixelX = ppu_io_pixelX; // @[NESSystemRefactored.scala 210:13]
  assign io_pixelY = ppu_io_pixelY; // @[NESSystemRefactored.scala 211:13]
  assign io_pixelColor = ppu_io_pixelColor; // @[NESSystemRefactored.scala 212:17]
  assign io_vblank = ppu_io_vblank; // @[NESSystemRefactored.scala 213:13]
  assign io_audioOut = 16'h0; // @[NESSystemRefactored.scala 214:15]
  assign io_debug_cpuPC = cpu_io_debug_regPC; // @[NESSystemRefactored.scala 217:18]
  assign io_debug_cpuA = cpu_io_debug_regA; // @[NESSystemRefactored.scala 218:17]
  assign io_debug_cpuX = cpu_io_debug_regX; // @[NESSystemRefactored.scala 219:17]
  assign io_debug_cpuY = cpu_io_debug_regY; // @[NESSystemRefactored.scala 220:17]
  assign io_debug_ppuCtrl = ppu_io_debug_ppuCtrl; // @[NESSystemRefactored.scala 227:20]
  assign io_debug_ppuMask = ppu_io_debug_ppuMask; // @[NESSystemRefactored.scala 228:20]
  assign io_debug_vblank = ppu_io_vblank; // @[NESSystemRefactored.scala 229:19]
  assign io_debug_nmi = ppu_io_nmiOut; // @[NESSystemRefactored.scala 230:16]
  assign io_debug_apuPulse1Active = 1'h0; // @[NESSystemRefactored.scala 231:28]
  assign io_debug_apuPulse2Active = 1'h0; // @[NESSystemRefactored.scala 232:28]
  assign io_debug_cpuState = {{1'd0}, cpu_io_debug_state}; // @[NESSystemRefactored.scala 221:21]
  assign io_debug_cpuCycle = cpu_io_debug_cycle; // @[NESSystemRefactored.scala 222:21]
  assign io_debug_cpuOpcode = cpu_io_debug_opcode; // @[NESSystemRefactored.scala 223:22]
  assign io_debug_cpuMemAddr = cpu_io_memAddr; // @[NESSystemRefactored.scala 224:23]
  assign io_debug_cpuMemDataIn = cpu_io_memDataIn; // @[NESSystemRefactored.scala 225:25]
  assign io_debug_cpuMemRead = cpu_io_memRead; // @[NESSystemRefactored.scala 226:23]
  assign cpu_clock = clock;
  assign cpu_reset = reset;
  assign cpu_io_memDataIn = isRam ? ram_ramData_data : _cpu_io_memDataIn_T_2; // @[Mux.scala 101:16]
  assign cpu_io_reset = reset; // @[NESSystemRefactored.scala 206:25]
  assign cpu_io_nmi = ppu_io_nmiOut; // @[NESSystemRefactored.scala 207:14]
  assign ppu_clock = clock;
  assign ppu_reset = reset;
  assign ppu_io_cpuAddr = cpu_io_memAddr[2:0]; // @[NESSystemRefactored.scala 175:28]
  assign ppu_io_cpuDataIn = cpu_io_memDataOut; // @[NESSystemRefactored.scala 176:20]
  assign ppu_io_cpuWrite = cpu_io_memWrite & isPpuReg; // @[NESSystemRefactored.scala 177:38]
  assign ppu_io_cpuRead = cpu_io_memRead & isPpuReg; // @[NESSystemRefactored.scala 178:36]
  assign ppu_io_chrLoadEn = io_chrLoadEn; // @[NESSystemRefactored.scala 192:20]
  assign ppu_io_chrLoadAddr = io_chrLoadAddr; // @[NESSystemRefactored.scala 193:22]
  assign ppu_io_chrLoadData = io_chrLoadData; // @[NESSystemRefactored.scala 194:22]
  assign mmc3_clock = clock;
  assign mmc3_reset = reset;
  assign mmc3_io_cpuAddr = cpu_io_memAddr; // @[NESSystemRefactored.scala 96:19]
  assign mmc3_io_cpuDataIn = cpu_io_memDataOut; // @[NESSystemRefactored.scala 97:21]
  assign mmc3_io_cpuWrite = cpu_io_memWrite & isPrgRom; // @[NESSystemRefactored.scala 98:39]
  assign mmc3_io_prgData = prgData; // @[NESSystemRefactored.scala 104:19]
  always @(posedge clock) begin
    if (prgRom_MPORT_en & prgRom_MPORT_mask) begin
      prgRom[prgRom_MPORT_addr] <= prgRom_MPORT_data; // @[NESSystemRefactored.scala 71:27]
    end
    prgRom_prgData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      prgRom_prgData_MPORT_addr_pipe_0 <= mmc3_io_prgAddr;
    end
    if (ram_MPORT_1_en & ram_MPORT_1_mask) begin
      ram[ram_MPORT_1_addr] <= ram_MPORT_1_data; // @[NESSystemRefactored.scala 81:16]
    end
    prgData <= prgRom_prgData_MPORT_data; // @[NESSystemRefactored.scala 103:24]
    if (reset) begin // @[NESSystemRefactored.scala 110:33]
      controller1Shift <= 8'h0; // @[NESSystemRefactored.scala 110:33]
    end else if (cpu_io_memRead & isController & ~controllerStrobe) begin // @[NESSystemRefactored.scala 127:61]
      if (_isController_T) begin // @[NESSystemRefactored.scala 128:32]
        controller1Shift <= {{1'd0}, controller1Shift[7:1]}; // @[NESSystemRefactored.scala 129:24]
      end else begin
        controller1Shift <= _GEN_12;
      end
    end else begin
      controller1Shift <= _GEN_12;
    end
    if (reset) begin // @[NESSystemRefactored.scala 111:33]
      controller2Shift <= 8'h0; // @[NESSystemRefactored.scala 111:33]
    end else if (cpu_io_memRead & isController & ~controllerStrobe) begin // @[NESSystemRefactored.scala 127:61]
      if (_isController_T) begin // @[NESSystemRefactored.scala 128:32]
        controller2Shift <= _GEN_13;
      end else begin
        controller2Shift <= {{1'd0}, controller2Shift[7:1]}; // @[NESSystemRefactored.scala 131:24]
      end
    end else begin
      controller2Shift <= _GEN_13;
    end
    if (reset) begin // @[NESSystemRefactored.scala 112:33]
      controllerStrobe <= 1'h0; // @[NESSystemRefactored.scala 112:33]
    end else if (cpu_io_memWrite & _isController_T) begin // @[NESSystemRefactored.scala 114:49]
      controllerStrobe <= cpu_io_memDataOut[0]; // @[NESSystemRefactored.scala 115:22]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2 & ~reset) begin
          $fwrite(32'h80000002,"[NES] cpuAddr=$%x memRead=%d\n",cpu_io_memAddr,cpu_io_memRead); // @[NESSystemRefactored.scala 86:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (isPpuReg & _T_4) begin
          $fwrite(32'h80000002,"[NES] isPpuReg=true: addr=$%x data=0x%x\n",cpu_io_memAddr,ppu_io_cpuDataOut); // @[NESSystemRefactored.scala 156:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (isPpuReg & _T_4) begin
          $fwrite(32'h80000002,"[NES] PPU addr range: addr=$%x isPpuReg=%d\n",cpu_io_memAddr,isPpuReg); // @[NESSystemRefactored.scala 159:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (cpu_io_memWrite & _T_4) begin
          $fwrite(32'h80000002,"[CPU Write] Addr=$%x Data=0x%x isRam=%d isPpuReg=%d\n",cpu_io_memAddr,cpu_io_memDataOut,
            isRam,isPpuReg); // @[NESSystemRefactored.scala 163:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_25 & _T_23 & _T_4) begin
          $fwrite(32'h80000002,"[RAM Write] Addr=$%x Data=0x%x PC=0x%x\n",cpu_io_memAddr,cpu_io_memDataOut,
            cpu_io_debug_regPC); // @[NESSystemRefactored.scala 168:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_ppu_io_cpuWrite_T & _T_4) begin
          $fwrite(32'h80000002,"[PPU Write] Addr=$%x RegAddr=%d Data=0x%x cpuWrite=%d isPpuReg=%d\n",cpu_io_memAddr,
            cpu_io_memAddr[2:0],cpu_io_memDataOut,cpu_io_memWrite,isPpuReg); // @[NESSystemRefactored.scala 182:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_ppu_io_cpuRead_T & _T_4) begin
          $fwrite(32'h80000002,"[PPU Read] Addr=$%x RegAddr=%d cpuRead=%d ppuData=0x%x\n",cpu_io_memAddr,cpu_io_memAddr[
            2:0],cpu_io_memRead,ppu_io_cpuDataOut); // @[NESSystemRefactored.scala 186:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
