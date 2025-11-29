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
  wire  _T_4 = 3'h0 == state; // @[CPU6502Core.scala 69:19]
  wire  _T_5 = cycle == 3'h0; // @[CPU6502Core.scala 72:22]
  wire  _T_6 = cycle == 3'h1; // @[CPU6502Core.scala 76:28]
  wire  _T_7 = cycle == 3'h2; // @[CPU6502Core.scala 81:28]
  wire  _T_8 = cycle == 3'h3; // @[CPU6502Core.scala 87:28]
  wire  _T_9 = cycle == 3'h4; // @[CPU6502Core.scala 92:28]
  wire [15:0] resetVector = {io_memDataIn,operand[7:0]}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_4 = cycle == 3'h4 ? 3'h5 : 3'h0; // @[CPU6502Core.scala 105:19 92:37 96:19]
  wire [15:0] _GEN_5 = cycle == 3'h4 ? regs_pc : resetVector; // @[CPU6502Core.scala 102:21 21:21 92:37]
  wire [7:0] _GEN_6 = cycle == 3'h4 ? regs_sp : 8'hfd; // @[CPU6502Core.scala 103:21 21:21 92:37]
  wire  _GEN_7 = cycle == 3'h4 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 21:21 104:24 92:37]
  wire [2:0] _GEN_8 = cycle == 3'h4 ? state : 3'h1; // @[CPU6502Core.scala 106:19 25:22 92:37]
  wire [2:0] _GEN_11 = cycle == 3'h3 ? 3'h4 : _GEN_4; // @[CPU6502Core.scala 87:37 91:19]
  wire [15:0] _GEN_12 = cycle == 3'h3 ? regs_pc : _GEN_5; // @[CPU6502Core.scala 21:21 87:37]
  wire [7:0] _GEN_13 = cycle == 3'h3 ? regs_sp : _GEN_6; // @[CPU6502Core.scala 21:21 87:37]
  wire  _GEN_14 = cycle == 3'h3 ? regs_flagI : _GEN_7; // @[CPU6502Core.scala 21:21 87:37]
  wire [2:0] _GEN_15 = cycle == 3'h3 ? state : _GEN_8; // @[CPU6502Core.scala 25:22 87:37]
  wire [15:0] _GEN_16 = cycle == 3'h2 ? 16'hfffc : 16'hfffd; // @[CPU6502Core.scala 81:37 83:24]
  wire [15:0] _GEN_18 = cycle == 3'h2 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 81:37 85:21 28:24]
  wire [2:0] _GEN_19 = cycle == 3'h2 ? 3'h3 : _GEN_11; // @[CPU6502Core.scala 81:37 86:19]
  wire [15:0] _GEN_20 = cycle == 3'h2 ? regs_pc : _GEN_12; // @[CPU6502Core.scala 21:21 81:37]
  wire [7:0] _GEN_21 = cycle == 3'h2 ? regs_sp : _GEN_13; // @[CPU6502Core.scala 21:21 81:37]
  wire  _GEN_22 = cycle == 3'h2 ? regs_flagI : _GEN_14; // @[CPU6502Core.scala 21:21 81:37]
  wire [2:0] _GEN_23 = cycle == 3'h2 ? state : _GEN_15; // @[CPU6502Core.scala 25:22 81:37]
  wire [15:0] _GEN_24 = cycle == 3'h1 ? 16'hfffc : _GEN_16; // @[CPU6502Core.scala 76:37 78:24]
  wire [2:0] _GEN_26 = cycle == 3'h1 ? 3'h2 : _GEN_19; // @[CPU6502Core.scala 76:37 80:19]
  wire [15:0] _GEN_27 = cycle == 3'h1 ? operand : _GEN_18; // @[CPU6502Core.scala 28:24 76:37]
  wire [15:0] _GEN_28 = cycle == 3'h1 ? regs_pc : _GEN_20; // @[CPU6502Core.scala 21:21 76:37]
  wire [7:0] _GEN_29 = cycle == 3'h1 ? regs_sp : _GEN_21; // @[CPU6502Core.scala 21:21 76:37]
  wire  _GEN_30 = cycle == 3'h1 ? regs_flagI : _GEN_22; // @[CPU6502Core.scala 21:21 76:37]
  wire [2:0] _GEN_31 = cycle == 3'h1 ? state : _GEN_23; // @[CPU6502Core.scala 25:22 76:37]
  wire [15:0] _GEN_32 = cycle == 3'h0 ? 16'hfffc : _GEN_24; // @[CPU6502Core.scala 72:31 73:24]
  wire [2:0] _GEN_34 = cycle == 3'h0 ? 3'h1 : _GEN_26; // @[CPU6502Core.scala 72:31 75:19]
  wire  _T_10 = 3'h1 == state; // @[CPU6502Core.scala 69:19]
  wire [15:0] _regs_pc_T_1 = regs_pc + 16'h1; // @[CPU6502Core.scala 127:34]
  wire  _T_13 = ~reset; // @[CPU6502Core.scala 129:21]
  wire [7:0] _GEN_43 = _T_5 ? opcode : io_memDataIn; // @[CPU6502Core.scala 117:33 126:22 27:24]
  wire [15:0] _GEN_44 = _T_5 ? regs_pc : _regs_pc_T_1; // @[CPU6502Core.scala 117:33 21:21 127:23]
  wire [2:0] _GEN_45 = _T_5 ? state : 3'h2; // @[CPU6502Core.scala 117:33 130:21 25:22]
  wire  _GEN_46 = nmiPending ? 1'h0 : _T_5; // @[CPU6502Core.scala 112:28 113:19]
  wire [2:0] _GEN_47 = nmiPending ? 3'h3 : _GEN_45; // @[CPU6502Core.scala 112:28 114:19]
  wire  _GEN_49 = nmiPending ? 1'h0 : 1'h1; // @[CPU6502Core.scala 112:28 52:17]
  wire [7:0] _GEN_50 = nmiPending ? opcode : _GEN_43; // @[CPU6502Core.scala 112:28 27:24]
  wire [15:0] _GEN_51 = nmiPending ? regs_pc : _GEN_44; // @[CPU6502Core.scala 112:28 21:21]
  wire  _T_14 = 3'h2 == state; // @[CPU6502Core.scala 69:19]
  wire  _execResult_T = 8'h18 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_1 = 8'h38 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_2 = 8'hd8 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_3 = 8'hf8 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_4 = 8'h58 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_5 = 8'h78 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_6 = 8'hb8 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_14 = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 == opcode | 8'h78
     == opcode | 8'hb8 == opcode | 8'hea == opcode; // @[CPU6502Core.scala 237:20]
  wire  _GEN_52 = _execResult_T_6 ? 1'h0 : regs_flagV; // @[Flag.scala 14:13 25:20 32:34]
  wire  _GEN_53 = _execResult_T_5 | regs_flagI; // @[Flag.scala 14:13 25:20 31:34]
  wire  _GEN_54 = _execResult_T_5 ? regs_flagV : _GEN_52; // @[Flag.scala 14:13 25:20]
  wire  _GEN_55 = _execResult_T_4 ? 1'h0 : _GEN_53; // @[Flag.scala 25:20 30:34]
  wire  _GEN_56 = _execResult_T_4 ? regs_flagV : _GEN_54; // @[Flag.scala 14:13 25:20]
  wire  _GEN_57 = _execResult_T_3 | regs_flagD; // @[Flag.scala 14:13 25:20 29:34]
  wire  _GEN_58 = _execResult_T_3 ? regs_flagI : _GEN_55; // @[Flag.scala 14:13 25:20]
  wire  _GEN_59 = _execResult_T_3 ? regs_flagV : _GEN_56; // @[Flag.scala 14:13 25:20]
  wire  _GEN_60 = _execResult_T_2 ? 1'h0 : _GEN_57; // @[Flag.scala 25:20 28:34]
  wire  _GEN_61 = _execResult_T_2 ? regs_flagI : _GEN_58; // @[Flag.scala 14:13 25:20]
  wire  _GEN_62 = _execResult_T_2 ? regs_flagV : _GEN_59; // @[Flag.scala 14:13 25:20]
  wire  _GEN_63 = _execResult_T_1 | regs_flagC; // @[Flag.scala 14:13 25:20 27:34]
  wire  _GEN_64 = _execResult_T_1 ? regs_flagD : _GEN_60; // @[Flag.scala 14:13 25:20]
  wire  _GEN_65 = _execResult_T_1 ? regs_flagI : _GEN_61; // @[Flag.scala 14:13 25:20]
  wire  _GEN_66 = _execResult_T_1 ? regs_flagV : _GEN_62; // @[Flag.scala 14:13 25:20]
  wire  execResult_result_newRegs_flagC = _execResult_T ? 1'h0 : _GEN_63; // @[Flag.scala 25:20 26:34]
  wire  execResult_result_newRegs_flagD = _execResult_T ? regs_flagD : _GEN_64; // @[Flag.scala 14:13 25:20]
  wire  execResult_result_newRegs_flagI = _execResult_T ? regs_flagI : _GEN_65; // @[Flag.scala 14:13 25:20]
  wire  execResult_result_newRegs_flagV = _execResult_T ? regs_flagV : _GEN_66; // @[Flag.scala 14:13 25:20]
  wire  _execResult_T_15 = 8'haa == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_16 = 8'ha8 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_17 = 8'h8a == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_18 = 8'h98 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_19 = 8'hba == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_20 = 8'h9a == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_25 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_result_newRegs_flagZ_T = regs_a == 8'h0; // @[Transfer.scala 29:33]
  wire [7:0] _GEN_71 = _execResult_T_20 ? regs_x : regs_sp; // @[Transfer.scala 14:13 25:20 52:20]
  wire [7:0] _GEN_72 = _execResult_T_19 ? regs_sp : regs_x; // @[Transfer.scala 14:13 25:20 47:19]
  wire  _GEN_73 = _execResult_T_19 ? regs_sp[7] : regs_flagN; // @[Transfer.scala 14:13 25:20 48:23]
  wire  _GEN_74 = _execResult_T_19 ? regs_sp == 8'h0 : regs_flagZ; // @[Transfer.scala 14:13 25:20 49:23]
  wire [7:0] _GEN_75 = _execResult_T_19 ? regs_sp : _GEN_71; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_76 = _execResult_T_18 ? regs_y : regs_a; // @[Transfer.scala 14:13 25:20 42:19]
  wire  _GEN_77 = _execResult_T_18 ? regs_y[7] : _GEN_73; // @[Transfer.scala 25:20 43:23]
  wire  _GEN_78 = _execResult_T_18 ? regs_y == 8'h0 : _GEN_74; // @[Transfer.scala 25:20 44:23]
  wire [7:0] _GEN_79 = _execResult_T_18 ? regs_x : _GEN_72; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_80 = _execResult_T_18 ? regs_sp : _GEN_75; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_81 = _execResult_T_17 ? regs_x : _GEN_76; // @[Transfer.scala 25:20 37:19]
  wire  _GEN_82 = _execResult_T_17 ? regs_x[7] : _GEN_77; // @[Transfer.scala 25:20 38:23]
  wire  _GEN_83 = _execResult_T_17 ? regs_x == 8'h0 : _GEN_78; // @[Transfer.scala 25:20 39:23]
  wire [7:0] _GEN_84 = _execResult_T_17 ? regs_x : _GEN_79; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_85 = _execResult_T_17 ? regs_sp : _GEN_80; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_86 = _execResult_T_16 ? regs_a : regs_y; // @[Transfer.scala 14:13 25:20 32:19]
  wire  _GEN_87 = _execResult_T_16 ? regs_a[7] : _GEN_82; // @[Transfer.scala 25:20 33:23]
  wire  _GEN_88 = _execResult_T_16 ? _execResult_result_newRegs_flagZ_T : _GEN_83; // @[Transfer.scala 25:20 34:23]
  wire [7:0] _GEN_89 = _execResult_T_16 ? regs_a : _GEN_81; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_90 = _execResult_T_16 ? regs_x : _GEN_84; // @[Transfer.scala 14:13 25:20]
  wire [7:0] _GEN_91 = _execResult_T_16 ? regs_sp : _GEN_85; // @[Transfer.scala 14:13 25:20]
  wire [7:0] execResult_result_newRegs_1_x = _execResult_T_15 ? regs_a : _GEN_90; // @[Transfer.scala 25:20 27:19]
  wire  execResult_result_newRegs_1_flagN = _execResult_T_15 ? regs_a[7] : _GEN_87; // @[Transfer.scala 25:20 28:23]
  wire  execResult_result_newRegs_1_flagZ = _execResult_T_15 ? regs_a == 8'h0 : _GEN_88; // @[Transfer.scala 25:20 29:23]
  wire [7:0] execResult_result_newRegs_1_y = _execResult_T_15 ? regs_y : _GEN_86; // @[Transfer.scala 14:13 25:20]
  wire [7:0] execResult_result_newRegs_1_a = _execResult_T_15 ? regs_a : _GEN_89; // @[Transfer.scala 14:13 25:20]
  wire [7:0] execResult_result_newRegs_1_sp = _execResult_T_15 ? regs_sp : _GEN_91; // @[Transfer.scala 14:13 25:20]
  wire  _execResult_T_26 = 8'he8 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_27 = 8'hc8 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_28 = 8'hca == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_29 = 8'h88 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_30 = 8'h1a == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_31 = 8'h3a == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_36 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] execResult_result_res = regs_x + 8'h1; // @[Arithmetic.scala 56:26]
  wire [7:0] execResult_result_res_1 = regs_y + 8'h1; // @[Arithmetic.scala 62:26]
  wire [7:0] execResult_result_res_2 = regs_x - 8'h1; // @[Arithmetic.scala 68:26]
  wire [7:0] execResult_result_res_3 = regs_y - 8'h1; // @[Arithmetic.scala 74:26]
  wire [7:0] execResult_result_res_4 = regs_a + 8'h1; // @[Arithmetic.scala 80:26]
  wire [7:0] execResult_result_res_5 = regs_a - 8'h1; // @[Arithmetic.scala 86:26]
  wire [7:0] _GEN_98 = _execResult_T_31 ? execResult_result_res_5 : regs_a; // @[Arithmetic.scala 43:13 54:20 87:19]
  wire  _GEN_99 = _execResult_T_31 ? execResult_result_res_5[7] : regs_flagN; // @[Arithmetic.scala 43:13 54:20 88:23]
  wire  _GEN_100 = _execResult_T_31 ? execResult_result_res_5 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 43:13 54:20 89:23]
  wire [7:0] _GEN_101 = _execResult_T_30 ? execResult_result_res_4 : _GEN_98; // @[Arithmetic.scala 54:20 81:19]
  wire  _GEN_102 = _execResult_T_30 ? execResult_result_res_4[7] : _GEN_99; // @[Arithmetic.scala 54:20 82:23]
  wire  _GEN_103 = _execResult_T_30 ? execResult_result_res_4 == 8'h0 : _GEN_100; // @[Arithmetic.scala 54:20 83:23]
  wire [7:0] _GEN_104 = _execResult_T_29 ? execResult_result_res_3 : regs_y; // @[Arithmetic.scala 43:13 54:20 75:19]
  wire  _GEN_105 = _execResult_T_29 ? execResult_result_res_3[7] : _GEN_102; // @[Arithmetic.scala 54:20 76:23]
  wire  _GEN_106 = _execResult_T_29 ? execResult_result_res_3 == 8'h0 : _GEN_103; // @[Arithmetic.scala 54:20 77:23]
  wire [7:0] _GEN_107 = _execResult_T_29 ? regs_a : _GEN_101; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] _GEN_108 = _execResult_T_28 ? execResult_result_res_2 : regs_x; // @[Arithmetic.scala 43:13 54:20 69:19]
  wire  _GEN_109 = _execResult_T_28 ? execResult_result_res_2[7] : _GEN_105; // @[Arithmetic.scala 54:20 70:23]
  wire  _GEN_110 = _execResult_T_28 ? execResult_result_res_2 == 8'h0 : _GEN_106; // @[Arithmetic.scala 54:20 71:23]
  wire [7:0] _GEN_111 = _execResult_T_28 ? regs_y : _GEN_104; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] _GEN_112 = _execResult_T_28 ? regs_a : _GEN_107; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] _GEN_113 = _execResult_T_27 ? execResult_result_res_1 : _GEN_111; // @[Arithmetic.scala 54:20 63:19]
  wire  _GEN_114 = _execResult_T_27 ? execResult_result_res_1[7] : _GEN_109; // @[Arithmetic.scala 54:20 64:23]
  wire  _GEN_115 = _execResult_T_27 ? execResult_result_res_1 == 8'h0 : _GEN_110; // @[Arithmetic.scala 54:20 65:23]
  wire [7:0] _GEN_116 = _execResult_T_27 ? regs_x : _GEN_108; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] _GEN_117 = _execResult_T_27 ? regs_a : _GEN_112; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] execResult_result_newRegs_2_x = _execResult_T_26 ? execResult_result_res : _GEN_116; // @[Arithmetic.scala 54:20 57:19]
  wire  execResult_result_newRegs_2_flagN = _execResult_T_26 ? execResult_result_res[7] : _GEN_114; // @[Arithmetic.scala 54:20 58:23]
  wire  execResult_result_newRegs_2_flagZ = _execResult_T_26 ? execResult_result_res == 8'h0 : _GEN_115; // @[Arithmetic.scala 54:20 59:23]
  wire [7:0] execResult_result_newRegs_2_y = _execResult_T_26 ? regs_y : _GEN_113; // @[Arithmetic.scala 43:13 54:20]
  wire [7:0] execResult_result_newRegs_2_a = _execResult_T_26 ? regs_a : _GEN_117; // @[Arithmetic.scala 43:13 54:20]
  wire  _execResult_T_37 = 8'h69 == opcode; // @[CPU6502Core.scala 237:20]
  wire [8:0] _execResult_result_sum_T = regs_a + io_memDataIn; // @[Arithmetic.scala 103:22]
  wire [8:0] _GEN_4234 = {{8'd0}, regs_flagC}; // @[Arithmetic.scala 103:35]
  wire [9:0] execResult_result_sum = _execResult_result_sum_T + _GEN_4234; // @[Arithmetic.scala 103:35]
  wire [7:0] execResult_result_newRegs_3_a = execResult_result_sum[7:0]; // @[Arithmetic.scala 104:21]
  wire  execResult_result_newRegs_3_flagC = execResult_result_sum[8]; // @[Arithmetic.scala 105:25]
  wire  execResult_result_newRegs_3_flagN = execResult_result_sum[7]; // @[Arithmetic.scala 106:25]
  wire  execResult_result_newRegs_3_flagZ = execResult_result_newRegs_3_a == 8'h0; // @[Arithmetic.scala 107:32]
  wire  execResult_result_newRegs_3_flagV = regs_a[7] == io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_3_flagN; // @[Arithmetic.scala 108:51]
  wire  _execResult_T_38 = 8'he9 == opcode; // @[CPU6502Core.scala 237:20]
  wire [8:0] _execResult_result_diff_T = regs_a - io_memDataIn; // @[Arithmetic.scala 128:23]
  wire  _execResult_result_diff_T_2 = ~regs_flagC; // @[Arithmetic.scala 128:40]
  wire [8:0] _GEN_4235 = {{8'd0}, _execResult_result_diff_T_2}; // @[Arithmetic.scala 128:36]
  wire [9:0] execResult_result_diff = _execResult_result_diff_T - _GEN_4235; // @[Arithmetic.scala 128:36]
  wire [7:0] execResult_result_newRegs_4_a = execResult_result_diff[7:0]; // @[Arithmetic.scala 129:22]
  wire  execResult_result_newRegs_4_flagC = ~execResult_result_diff[8]; // @[Arithmetic.scala 130:22]
  wire  execResult_result_newRegs_4_flagN = execResult_result_diff[7]; // @[Arithmetic.scala 131:26]
  wire  execResult_result_newRegs_4_flagZ = execResult_result_newRegs_4_a == 8'h0; // @[Arithmetic.scala 132:33]
  wire  execResult_result_newRegs_4_flagV = regs_a[7] != io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 133:51]
  wire  _execResult_T_41 = 8'h65 == opcode | 8'he5 == opcode; // @[CPU6502Core.scala 237:20]
  wire [2:0] execResult_result_result_6_nextCycle = cycle + 3'h1; // @[Arithmetic.scala 372:31]
  wire  _execResult_result_T_20 = 3'h0 == cycle; // @[Arithmetic.scala 380:19]
  wire  _execResult_result_T_21 = 3'h1 == cycle; // @[Arithmetic.scala 380:19]
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
  wire [15:0] _GEN_127 = 3'h1 == cycle ? operand : 16'h0; // @[Arithmetic.scala 380:19 374:20 389:24]
  wire [7:0] _GEN_129 = 3'h1 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 369:13 380:19 392:19]
  wire  _GEN_130 = 3'h1 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 369:13 380:19 393:23]
  wire  _GEN_131 = 3'h1 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 369:13 380:19 394:23]
  wire  _GEN_132 = 3'h1 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 369:13 380:19 395:23]
  wire  _GEN_133 = 3'h1 == cycle ? execResult_result_res_6 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 369:13 380:19 396:23]
  wire [7:0] execResult_result_newRegs_5_a = 3'h0 == cycle ? regs_a : _GEN_129; // @[Arithmetic.scala 369:13 380:19]
  wire [15:0] execResult_result_newRegs_5_pc = 3'h0 == cycle ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 369:13 380:19 385:20]
  wire  execResult_result_newRegs_5_flagC = 3'h0 == cycle ? regs_flagC : _GEN_130; // @[Arithmetic.scala 369:13 380:19]
  wire  execResult_result_newRegs_5_flagZ = 3'h0 == cycle ? regs_flagZ : _GEN_133; // @[Arithmetic.scala 369:13 380:19]
  wire  execResult_result_newRegs_5_flagV = 3'h0 == cycle ? regs_flagV : _GEN_131; // @[Arithmetic.scala 369:13 380:19]
  wire  execResult_result_newRegs_5_flagN = 3'h0 == cycle ? regs_flagN : _GEN_132; // @[Arithmetic.scala 369:13 380:19]
  wire [15:0] execResult_result_result_6_memAddr = 3'h0 == cycle ? regs_pc : _GEN_127; // @[Arithmetic.scala 380:19 382:24]
  wire  execResult_result_result_6_memRead = 3'h0 == cycle | 3'h1 == cycle; // @[Arithmetic.scala 380:19 383:24]
  wire [15:0] execResult_result_result_6_operand = 3'h0 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Arithmetic.scala 380:19 378:20 384:24]
  wire  execResult_result_result_6_done = 3'h0 == cycle ? 1'h0 : 3'h1 == cycle; // @[Arithmetic.scala 371:17 380:19]
  wire  _execResult_T_44 = 8'h75 == opcode | 8'hf5 == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] _execResult_result_result_operand_T_1 = io_memDataIn + regs_x; // @[Arithmetic.scala 424:38]
  wire [15:0] execResult_result_result_7_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : operand; // @[Arithmetic.scala 420:19 418:20 424:24]
  wire  _execResult_T_47 = 8'h6d == opcode | 8'hed == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_result_T_26 = 3'h2 == cycle; // @[Arithmetic.scala 460:19]
  wire [15:0] _GEN_217 = 3'h2 == cycle ? operand : 16'h0; // @[Arithmetic.scala 460:19 454:20 476:24]
  wire [7:0] _GEN_219 = 3'h2 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 449:13 460:19 479:19]
  wire  _GEN_220 = 3'h2 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 449:13 460:19 480:23]
  wire  _GEN_221 = 3'h2 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 449:13 460:19 481:23]
  wire  _GEN_222 = 3'h2 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 449:13 460:19 482:23]
  wire  _GEN_223 = 3'h2 == cycle ? _execResult_result_newRegs_flagZ_T_15 : regs_flagZ; // @[Arithmetic.scala 449:13 460:19 483:23]
  wire [7:0] _GEN_252 = _execResult_result_T_21 ? regs_a : _GEN_219; // @[Arithmetic.scala 449:13 460:19]
  wire [7:0] execResult_result_newRegs_7_a = _execResult_result_T_20 ? regs_a : _GEN_252; // @[Arithmetic.scala 449:13 460:19]
  wire [15:0] _GEN_239 = _execResult_result_T_21 ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 449:13 460:19 472:20]
  wire [15:0] execResult_result_newRegs_7_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_239; // @[Arithmetic.scala 460:19 465:20]
  wire  _GEN_253 = _execResult_result_T_21 ? regs_flagC : _GEN_220; // @[Arithmetic.scala 449:13 460:19]
  wire  execResult_result_newRegs_7_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_253; // @[Arithmetic.scala 449:13 460:19]
  wire  _GEN_256 = _execResult_result_T_21 ? regs_flagZ : _GEN_223; // @[Arithmetic.scala 449:13 460:19]
  wire  execResult_result_newRegs_7_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_256; // @[Arithmetic.scala 449:13 460:19]
  wire  _GEN_254 = _execResult_result_T_21 ? regs_flagV : _GEN_221; // @[Arithmetic.scala 449:13 460:19]
  wire  execResult_result_newRegs_7_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_254; // @[Arithmetic.scala 449:13 460:19]
  wire  _GEN_255 = _execResult_result_T_21 ? regs_flagN : _GEN_222; // @[Arithmetic.scala 449:13 460:19]
  wire  execResult_result_newRegs_7_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_255; // @[Arithmetic.scala 449:13 460:19]
  wire [15:0] _GEN_236 = _execResult_result_T_21 ? regs_pc : _GEN_217; // @[Arithmetic.scala 460:19 469:24]
  wire  _GEN_237 = _execResult_result_T_21 | 3'h2 == cycle; // @[Arithmetic.scala 460:19 470:24]
  wire [15:0] _GEN_238 = _execResult_result_T_21 ? resetVector : operand; // @[Arithmetic.scala 460:19 458:20 471:24]
  wire  _GEN_257 = _execResult_result_T_21 ? 1'h0 : 3'h2 == cycle; // @[Arithmetic.scala 451:17 460:19]
  wire [15:0] execResult_result_result_8_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_236; // @[Arithmetic.scala 460:19 462:24]
  wire  execResult_result_result_8_memRead = _execResult_result_T_20 | _GEN_237; // @[Arithmetic.scala 460:19 463:24]
  wire [15:0] execResult_result_result_8_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_238; // @[Arithmetic.scala 460:19 464:24]
  wire  execResult_result_result_8_done = _execResult_result_T_20 ? 1'h0 : _GEN_257; // @[Arithmetic.scala 451:17 460:19]
  wire  _execResult_T_50 = 8'h61 == opcode | 8'he1 == opcode; // @[CPU6502Core.scala 237:20]
  wire [15:0] _execResult_result_result_operand_T_9 = {operand[15:8],io_memDataIn}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_result_memAddr_T_3 = operand[7:0] + 8'h1; // @[Arithmetic.scala 521:42]
  wire  _execResult_result_T_30 = 3'h3 == cycle; // @[Arithmetic.scala 507:19]
  wire [15:0] _GEN_284 = 3'h3 == cycle ? operand : 16'h0; // @[Arithmetic.scala 507:19 501:20 526:24]
  wire [7:0] _GEN_286 = 3'h3 == cycle ? execResult_result_res_6 : regs_a; // @[Arithmetic.scala 496:13 507:19 529:19]
  wire  _GEN_287 = 3'h3 == cycle ? execResult_result_flagC : regs_flagC; // @[Arithmetic.scala 496:13 507:19 530:23]
  wire  _GEN_288 = 3'h3 == cycle ? execResult_result_flagV : regs_flagV; // @[Arithmetic.scala 496:13 507:19 531:23]
  wire  _GEN_289 = 3'h3 == cycle ? execResult_result_flagN : regs_flagN; // @[Arithmetic.scala 496:13 507:19 532:23]
  wire  _GEN_290 = 3'h3 == cycle ? _execResult_result_newRegs_flagZ_T_15 : regs_flagZ; // @[Arithmetic.scala 496:13 507:19 533:23]
  wire [7:0] _GEN_306 = _execResult_result_T_26 ? regs_a : _GEN_286; // @[Arithmetic.scala 496:13 507:19]
  wire [7:0] _GEN_327 = _execResult_result_T_21 ? regs_a : _GEN_306; // @[Arithmetic.scala 496:13 507:19]
  wire [7:0] execResult_result_newRegs_8_a = _execResult_result_T_20 ? regs_a : _GEN_327; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_307 = _execResult_result_T_26 ? regs_flagC : _GEN_287; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_328 = _execResult_result_T_21 ? regs_flagC : _GEN_307; // @[Arithmetic.scala 496:13 507:19]
  wire  execResult_result_newRegs_8_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_328; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_310 = _execResult_result_T_26 ? regs_flagZ : _GEN_290; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_331 = _execResult_result_T_21 ? regs_flagZ : _GEN_310; // @[Arithmetic.scala 496:13 507:19]
  wire  execResult_result_newRegs_8_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_331; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_308 = _execResult_result_T_26 ? regs_flagV : _GEN_288; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_329 = _execResult_result_T_21 ? regs_flagV : _GEN_308; // @[Arithmetic.scala 496:13 507:19]
  wire  execResult_result_newRegs_8_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_329; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_309 = _execResult_result_T_26 ? regs_flagN : _GEN_289; // @[Arithmetic.scala 496:13 507:19]
  wire  _GEN_330 = _execResult_result_T_21 ? regs_flagN : _GEN_309; // @[Arithmetic.scala 496:13 507:19]
  wire  execResult_result_newRegs_8_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_330; // @[Arithmetic.scala 496:13 507:19]
  wire [15:0] _GEN_303 = _execResult_result_T_26 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_284; // @[Arithmetic.scala 507:19 521:24]
  wire  _GEN_304 = _execResult_result_T_26 | 3'h3 == cycle; // @[Arithmetic.scala 507:19 522:24]
  wire [15:0] _GEN_305 = _execResult_result_T_26 ? resetVector : operand; // @[Arithmetic.scala 507:19 505:20 523:24]
  wire  _GEN_323 = _execResult_result_T_26 ? 1'h0 : 3'h3 == cycle; // @[Arithmetic.scala 498:17 507:19]
  wire [15:0] _GEN_324 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_303; // @[Arithmetic.scala 507:19 516:24]
  wire  _GEN_325 = _execResult_result_T_21 | _GEN_304; // @[Arithmetic.scala 507:19 517:24]
  wire [15:0] _GEN_326 = _execResult_result_T_21 ? _execResult_result_result_operand_T_9 : _GEN_305; // @[Arithmetic.scala 507:19 518:24]
  wire  _GEN_344 = _execResult_result_T_21 ? 1'h0 : _GEN_323; // @[Arithmetic.scala 498:17 507:19]
  wire [15:0] execResult_result_result_9_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_324; // @[Arithmetic.scala 507:19 509:24]
  wire  execResult_result_result_9_memRead = _execResult_result_T_20 | _GEN_325; // @[Arithmetic.scala 507:19 510:24]
  wire [15:0] execResult_result_result_9_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : _GEN_326; // @[Arithmetic.scala 507:19 511:24]
  wire  execResult_result_result_9_done = _execResult_result_T_20 ? 1'h0 : _GEN_344; // @[Arithmetic.scala 498:17 507:19]
  wire  _execResult_T_53 = 8'h71 == opcode | 8'hf1 == opcode; // @[CPU6502Core.scala 237:20]
  wire [15:0] _GEN_4244 = {{8'd0}, regs_y}; // @[Arithmetic.scala 573:57]
  wire [15:0] _execResult_result_result_operand_T_17 = resetVector + _GEN_4244; // @[Arithmetic.scala 573:57]
  wire [15:0] _GEN_392 = _execResult_result_T_26 ? _execResult_result_result_operand_T_17 : operand; // @[Arithmetic.scala 557:19 555:20 573:24]
  wire [15:0] _GEN_413 = _execResult_result_T_21 ? _execResult_result_result_operand_T_9 : _GEN_392; // @[Arithmetic.scala 557:19 568:24]
  wire [15:0] execResult_result_result_10_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_413; // @[Arithmetic.scala 557:19 561:24]
  wire  _execResult_T_56 = 8'he6 == opcode | 8'hc6 == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] _execResult_result_res_T_8 = io_memDataIn + 8'h1; // @[Arithmetic.scala 178:52]
  wire [7:0] _execResult_result_res_T_10 = io_memDataIn - 8'h1; // @[Arithmetic.scala 178:69]
  wire [7:0] execResult_result_res_11 = opcode == 8'he6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 178:22]
  wire [7:0] _GEN_455 = _execResult_result_T_26 ? execResult_result_res_11 : 8'h0; // @[Arithmetic.scala 162:19 157:20 179:24]
  wire  _GEN_457 = _execResult_result_T_26 ? execResult_result_res_11[7] : regs_flagN; // @[Arithmetic.scala 151:13 162:19 181:23]
  wire  _GEN_458 = _execResult_result_T_26 ? execResult_result_res_11 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 151:13 162:19 182:23]
  wire  _GEN_477 = _execResult_result_T_21 ? regs_flagZ : _GEN_458; // @[Arithmetic.scala 151:13 162:19]
  wire  execResult_result_newRegs_10_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_477; // @[Arithmetic.scala 151:13 162:19]
  wire  _GEN_476 = _execResult_result_T_21 ? regs_flagN : _GEN_457; // @[Arithmetic.scala 151:13 162:19]
  wire  execResult_result_newRegs_10_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_476; // @[Arithmetic.scala 151:13 162:19]
  wire [15:0] _GEN_471 = _execResult_result_T_21 ? operand : _GEN_217; // @[Arithmetic.scala 162:19 172:24]
  wire [2:0] _GEN_473 = _execResult_result_T_21 ? 3'h2 : execResult_result_result_6_nextCycle; // @[Arithmetic.scala 162:19 154:22 174:26]
  wire [7:0] _GEN_474 = _execResult_result_T_21 ? 8'h0 : _GEN_455; // @[Arithmetic.scala 162:19 157:20]
  wire [15:0] execResult_result_result_11_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_471; // @[Arithmetic.scala 162:19 164:24]
  wire [2:0] execResult_result_result_11_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_473; // @[Arithmetic.scala 162:19 169:26]
  wire [7:0] execResult_result_result_11_memData = _execResult_result_T_20 ? 8'h0 : _GEN_474; // @[Arithmetic.scala 162:19 157:20]
  wire  _execResult_T_59 = 8'hf6 == opcode | 8'hd6 == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] execResult_result_res_12 = opcode == 8'hf6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 220:22]
  wire [7:0] _GEN_512 = _execResult_result_T_26 ? execResult_result_res_12 : 8'h0; // @[Arithmetic.scala 206:19 201:20 221:24]
  wire  _GEN_514 = _execResult_result_T_26 ? execResult_result_res_12[7] : regs_flagN; // @[Arithmetic.scala 195:13 206:19 223:23]
  wire  _GEN_515 = _execResult_result_T_26 ? execResult_result_res_12 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 195:13 206:19 224:23]
  wire  _GEN_533 = _execResult_result_T_21 ? regs_flagZ : _GEN_515; // @[Arithmetic.scala 195:13 206:19]
  wire  execResult_result_newRegs_11_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_533; // @[Arithmetic.scala 195:13 206:19]
  wire  _GEN_532 = _execResult_result_T_21 ? regs_flagN : _GEN_514; // @[Arithmetic.scala 195:13 206:19]
  wire  execResult_result_newRegs_11_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_532; // @[Arithmetic.scala 195:13 206:19]
  wire [7:0] _GEN_530 = _execResult_result_T_21 ? 8'h0 : _GEN_512; // @[Arithmetic.scala 206:19 201:20]
  wire [7:0] execResult_result_result_12_memData = _execResult_result_T_20 ? 8'h0 : _GEN_530; // @[Arithmetic.scala 206:19 201:20]
  wire  _execResult_T_62 = 8'hee == opcode | 8'hce == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] execResult_result_res_13 = opcode == 8'hee ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 273:22]
  wire [7:0] _GEN_567 = _execResult_result_T_30 ? execResult_result_res_13 : 8'h0; // @[Arithmetic.scala 248:19 243:20 274:24]
  wire  _GEN_569 = _execResult_result_T_30 ? execResult_result_res_13[7] : regs_flagN; // @[Arithmetic.scala 237:13 248:19 276:23]
  wire  _GEN_570 = _execResult_result_T_30 ? execResult_result_res_13 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 237:13 248:19 277:23]
  wire  _GEN_588 = _execResult_result_T_26 ? regs_flagZ : _GEN_570; // @[Arithmetic.scala 237:13 248:19]
  wire  _GEN_620 = _execResult_result_T_21 ? regs_flagZ : _GEN_588; // @[Arithmetic.scala 237:13 248:19]
  wire  execResult_result_newRegs_12_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_620; // @[Arithmetic.scala 237:13 248:19]
  wire  _GEN_587 = _execResult_result_T_26 ? regs_flagN : _GEN_569; // @[Arithmetic.scala 237:13 248:19]
  wire  _GEN_619 = _execResult_result_T_21 ? regs_flagN : _GEN_587; // @[Arithmetic.scala 237:13 248:19]
  wire  execResult_result_newRegs_12_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_619; // @[Arithmetic.scala 237:13 248:19]
  wire [15:0] _GEN_583 = _execResult_result_T_26 ? operand : _GEN_284; // @[Arithmetic.scala 248:19 267:24]
  wire [7:0] _GEN_585 = _execResult_result_T_26 ? 8'h0 : _GEN_567; // @[Arithmetic.scala 248:19 243:20]
  wire [15:0] _GEN_601 = _execResult_result_T_21 ? regs_pc : _GEN_583; // @[Arithmetic.scala 248:19 259:24]
  wire [7:0] _GEN_617 = _execResult_result_T_21 ? 8'h0 : _GEN_585; // @[Arithmetic.scala 248:19 243:20]
  wire [15:0] execResult_result_result_13_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_601; // @[Arithmetic.scala 248:19 251:24]
  wire [7:0] execResult_result_result_13_memData = _execResult_result_T_20 ? 8'h0 : _GEN_617; // @[Arithmetic.scala 248:19 243:20]
  wire  _execResult_T_65 = 8'hfe == opcode | 8'hde == opcode; // @[CPU6502Core.scala 237:20]
  wire [15:0] _GEN_4247 = {{8'd0}, regs_x}; // @[Arithmetic.scala 312:57]
  wire [15:0] _execResult_result_result_operand_T_26 = resetVector + _GEN_4247; // @[Arithmetic.scala 312:57]
  wire [7:0] execResult_result_res_14 = opcode == 8'hfe ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 322:22]
  wire [7:0] _GEN_642 = _execResult_result_T_30 ? execResult_result_res_14 : 8'h0; // @[Arithmetic.scala 301:19 296:20 323:24]
  wire  _GEN_644 = _execResult_result_T_30 ? execResult_result_res_14[7] : regs_flagN; // @[Arithmetic.scala 290:13 301:19 325:23]
  wire  _GEN_645 = _execResult_result_T_30 ? execResult_result_res_14 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 290:13 301:19 326:23]
  wire  _GEN_663 = _execResult_result_T_26 ? regs_flagZ : _GEN_645; // @[Arithmetic.scala 290:13 301:19]
  wire  _GEN_695 = _execResult_result_T_21 ? regs_flagZ : _GEN_663; // @[Arithmetic.scala 290:13 301:19]
  wire  execResult_result_newRegs_13_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_695; // @[Arithmetic.scala 290:13 301:19]
  wire  _GEN_662 = _execResult_result_T_26 ? regs_flagN : _GEN_644; // @[Arithmetic.scala 290:13 301:19]
  wire  _GEN_694 = _execResult_result_T_21 ? regs_flagN : _GEN_662; // @[Arithmetic.scala 290:13 301:19]
  wire  execResult_result_newRegs_13_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_694; // @[Arithmetic.scala 290:13 301:19]
  wire [7:0] _GEN_660 = _execResult_result_T_26 ? 8'h0 : _GEN_642; // @[Arithmetic.scala 301:19 296:20]
  wire [15:0] _GEN_678 = _execResult_result_T_21 ? _execResult_result_result_operand_T_26 : operand; // @[Arithmetic.scala 301:19 299:20 312:24]
  wire [7:0] _GEN_692 = _execResult_result_T_21 ? 8'h0 : _GEN_660; // @[Arithmetic.scala 301:19 296:20]
  wire [15:0] execResult_result_result_14_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_678; // @[Arithmetic.scala 301:19 305:24]
  wire [7:0] execResult_result_result_14_memData = _execResult_result_T_20 ? 8'h0 : _GEN_692; // @[Arithmetic.scala 301:19 296:20]
  wire  _execResult_T_72 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode; // @[CPU6502Core.scala 237:20]
  wire  execResult_result_useY = _execResult_result_isADC_T_9 | opcode == 8'hf9; // @[Arithmetic.scala 608:36]
  wire [7:0] execResult_result_index = execResult_result_useY ? regs_y : regs_x; // @[Arithmetic.scala 609:20]
  wire [15:0] _GEN_4248 = {{8'd0}, execResult_result_index}; // @[Arithmetic.scala 630:28]
  wire [15:0] execResult_result_addr = operand + _GEN_4248; // @[Arithmetic.scala 630:28]
  wire  execResult_result_isADC_5 = _execResult_result_isADC_T_9 | _execResult_result_isADC_T_7; // @[Arithmetic.scala 636:41]
  wire [7:0] _GEN_716 = execResult_result_isADC_5 ? execResult_result_newRegs_3_a : execResult_result_newRegs_4_a; // @[Arithmetic.scala 638:21 641:21 649:21]
  wire  _GEN_717 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagC : execResult_result_newRegs_4_flagC; // @[Arithmetic.scala 638:21 642:25 650:25]
  wire  _GEN_718 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagN : execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 638:21 643:25 651:25]
  wire  _GEN_719 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagZ : execResult_result_newRegs_4_flagZ; // @[Arithmetic.scala 638:21 644:25 652:25]
  wire  _GEN_720 = execResult_result_isADC_5 ? execResult_result_newRegs_3_flagV : execResult_result_newRegs_4_flagV; // @[Arithmetic.scala 638:21 645:25 653:25]
  wire [7:0] _GEN_721 = _execResult_result_T_30 ? _GEN_716 : regs_a; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_722 = _execResult_result_T_30 ? _GEN_717 : regs_flagC; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_723 = _execResult_result_T_30 ? _GEN_718 : regs_flagN; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_724 = _execResult_result_T_30 ? _GEN_719 : regs_flagZ; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_725 = _execResult_result_T_30 ? _GEN_720 : regs_flagV; // @[Arithmetic.scala 596:13 611:19]
  wire [7:0] _GEN_741 = _execResult_result_T_26 ? regs_a : _GEN_721; // @[Arithmetic.scala 596:13 611:19]
  wire [7:0] _GEN_775 = _execResult_result_T_21 ? regs_a : _GEN_741; // @[Arithmetic.scala 596:13 611:19]
  wire [7:0] execResult_result_newRegs_14_a = _execResult_result_T_20 ? regs_a : _GEN_775; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_742 = _execResult_result_T_26 ? regs_flagC : _GEN_722; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_776 = _execResult_result_T_21 ? regs_flagC : _GEN_742; // @[Arithmetic.scala 596:13 611:19]
  wire  execResult_result_newRegs_14_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_776; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_744 = _execResult_result_T_26 ? regs_flagZ : _GEN_724; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_778 = _execResult_result_T_21 ? regs_flagZ : _GEN_744; // @[Arithmetic.scala 596:13 611:19]
  wire  execResult_result_newRegs_14_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_778; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_745 = _execResult_result_T_26 ? regs_flagV : _GEN_725; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_779 = _execResult_result_T_21 ? regs_flagV : _GEN_745; // @[Arithmetic.scala 596:13 611:19]
  wire  execResult_result_newRegs_14_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_779; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_743 = _execResult_result_T_26 ? regs_flagN : _GEN_723; // @[Arithmetic.scala 596:13 611:19]
  wire  _GEN_777 = _execResult_result_T_21 ? regs_flagN : _GEN_743; // @[Arithmetic.scala 596:13 611:19]
  wire  execResult_result_newRegs_14_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_777; // @[Arithmetic.scala 596:13 611:19]
  wire [15:0] _GEN_739 = _execResult_result_T_26 ? execResult_result_addr : 16'h0; // @[Arithmetic.scala 611:19 601:20 631:24]
  wire [15:0] _GEN_759 = _execResult_result_T_21 ? regs_pc : _GEN_739; // @[Arithmetic.scala 611:19 622:24]
  wire [15:0] execResult_result_result_15_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_759; // @[Arithmetic.scala 611:19 614:24]
  wire  _execResult_T_73 = 8'h29 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_74 = 8'h9 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_75 = 8'h49 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_77 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] _execResult_result_res_T_26 = regs_a & io_memDataIn; // @[Logic.scala 32:34]
  wire [7:0] _execResult_result_res_T_27 = regs_a | io_memDataIn; // @[Logic.scala 33:34]
  wire [7:0] _execResult_result_res_T_28 = regs_a ^ io_memDataIn; // @[Logic.scala 34:34]
  wire [7:0] _GEN_803 = _execResult_T_75 ? _execResult_result_res_T_28 : 8'h0; // @[Logic.scala 31:20 34:24 29:9]
  wire [7:0] _GEN_804 = _execResult_T_74 ? _execResult_result_res_T_27 : _GEN_803; // @[Logic.scala 31:20 33:24]
  wire [7:0] execResult_result_res_15 = _execResult_T_73 ? _execResult_result_res_T_26 : _GEN_804; // @[Logic.scala 31:20 32:24]
  wire  execResult_result_newRegs_15_flagN = execResult_result_res_15[7]; // @[Logic.scala 38:25]
  wire  execResult_result_newRegs_15_flagZ = execResult_result_res_15 == 8'h0; // @[Logic.scala 39:26]
  wire  _execResult_T_78 = 8'h24 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_result_newRegs_flagZ_T_30 = _execResult_result_res_T_26 == 8'h0; // @[Logic.scala 80:47]
  wire  _GEN_808 = _execResult_result_T_21 ? _execResult_result_res_T_26 == 8'h0 : regs_flagZ; // @[Logic.scala 57:13 68:19 80:23]
  wire  _GEN_809 = _execResult_result_T_21 ? io_memDataIn[7] : regs_flagN; // @[Logic.scala 57:13 68:19 81:23]
  wire  _GEN_810 = _execResult_result_T_21 ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 57:13 68:19 82:23]
  wire  execResult_result_newRegs_16_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_808; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_16_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_810; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_16_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_809; // @[Logic.scala 57:13 68:19]
  wire [2:0] execResult_result_result_17_nextCycle = _execResult_result_T_20 ? 3'h1 :
    execResult_result_result_6_nextCycle; // @[Logic.scala 68:19 60:22 75:26]
  wire  _execResult_T_83 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode; // @[CPU6502Core.scala 237:20]
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
  wire [7:0] _GEN_846 = _execResult_result_T_21 ? execResult_result_res_16 : regs_a; // @[Logic.scala 107:13 118:19 130:19]
  wire  _GEN_847 = _execResult_result_T_21 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 107:13 118:19 131:23]
  wire  _GEN_848 = _execResult_result_T_21 ? execResult_result_res_16 == 8'h0 : regs_flagZ; // @[Logic.scala 107:13 118:19 132:23]
  wire [7:0] execResult_result_newRegs_17_a = _execResult_result_T_20 ? regs_a : _GEN_846; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_17_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_848; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_17_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_847; // @[Logic.scala 107:13 118:19]
  wire  _execResult_T_88 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_95 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode; // @[CPU6502Core.scala 237:20]
  wire  _GEN_918 = opcode == 8'h2c ? _execResult_result_newRegs_flagZ_T_30 : _execResult_result_newRegs_flagZ_T_31; // @[Logic.scala 214:33 215:25 222:25]
  wire  _GEN_919 = opcode == 8'h2c ? io_memDataIn[7] : execResult_result_res_16[7]; // @[Logic.scala 214:33 216:25 221:25]
  wire  _GEN_920 = opcode == 8'h2c ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 183:13 214:33 217:25]
  wire [7:0] _GEN_921 = opcode == 8'h2c ? regs_a : execResult_result_res_16; // @[Logic.scala 183:13 214:33 220:21]
  wire  _GEN_924 = _execResult_result_T_26 ? _GEN_918 : regs_flagZ; // @[Logic.scala 183:13 194:19]
  wire  _GEN_925 = _execResult_result_T_26 ? _GEN_919 : regs_flagN; // @[Logic.scala 183:13 194:19]
  wire  _GEN_926 = _execResult_result_T_26 ? _GEN_920 : regs_flagV; // @[Logic.scala 183:13 194:19]
  wire [7:0] _GEN_927 = _execResult_result_T_26 ? _GEN_921 : regs_a; // @[Logic.scala 183:13 194:19]
  wire [7:0] _GEN_959 = _execResult_result_T_21 ? regs_a : _GEN_927; // @[Logic.scala 183:13 194:19]
  wire [7:0] execResult_result_newRegs_19_a = _execResult_result_T_20 ? regs_a : _GEN_959; // @[Logic.scala 183:13 194:19]
  wire  _GEN_956 = _execResult_result_T_21 ? regs_flagZ : _GEN_924; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_956; // @[Logic.scala 183:13 194:19]
  wire  _GEN_958 = _execResult_result_T_21 ? regs_flagV : _GEN_926; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_958; // @[Logic.scala 183:13 194:19]
  wire  _GEN_957 = _execResult_result_T_21 ? regs_flagN : _GEN_925; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_19_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_957; // @[Logic.scala 183:13 194:19]
  wire  _execResult_T_106 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode; // @[CPU6502Core.scala 237:20]
  wire  execResult_result_useY_1 = _execResult_result_res_T_38 | _execResult_result_res_T_54 |
    _execResult_result_res_T_70; // @[Logic.scala 249:59]
  wire [7:0] execResult_result_index_1 = execResult_result_useY_1 ? regs_y : regs_x; // @[Logic.scala 250:20]
  wire [15:0] _GEN_4251 = {{8'd0}, execResult_result_index_1}; // @[Logic.scala 263:57]
  wire [15:0] _execResult_result_result_operand_T_37 = resetVector + _GEN_4251; // @[Logic.scala 263:57]
  wire [7:0] _GEN_984 = _execResult_result_T_26 ? execResult_result_res_16 : regs_a; // @[Logic.scala 237:13 252:19 271:19]
  wire  _GEN_985 = _execResult_result_T_26 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 237:13 252:19 272:23]
  wire  _GEN_986 = _execResult_result_T_26 ? _execResult_result_newRegs_flagZ_T_31 : regs_flagZ; // @[Logic.scala 237:13 252:19 273:23]
  wire [7:0] _GEN_1015 = _execResult_result_T_21 ? regs_a : _GEN_984; // @[Logic.scala 237:13 252:19]
  wire [7:0] execResult_result_newRegs_20_a = _execResult_result_T_20 ? regs_a : _GEN_1015; // @[Logic.scala 237:13 252:19]
  wire  _GEN_1017 = _execResult_result_T_21 ? regs_flagZ : _GEN_986; // @[Logic.scala 237:13 252:19]
  wire  execResult_result_newRegs_20_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1017; // @[Logic.scala 237:13 252:19]
  wire  _GEN_1016 = _execResult_result_T_21 ? regs_flagN : _GEN_985; // @[Logic.scala 237:13 252:19]
  wire  execResult_result_newRegs_20_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1016; // @[Logic.scala 237:13 252:19]
  wire [15:0] _GEN_1001 = _execResult_result_T_21 ? _execResult_result_result_operand_T_37 : operand; // @[Logic.scala 252:19 246:20 263:24]
  wire [15:0] execResult_result_result_21_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_1001; // @[Logic.scala 252:19 256:24]
  wire  _execResult_T_111 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] _GEN_1041 = _execResult_result_T_30 ? execResult_result_res_16 : regs_a; // @[Logic.scala 286:13 297:19 323:19]
  wire  _GEN_1042 = _execResult_result_T_30 ? execResult_result_res_16[7] : regs_flagN; // @[Logic.scala 286:13 297:19 324:23]
  wire  _GEN_1043 = _execResult_result_T_30 ? _execResult_result_newRegs_flagZ_T_31 : regs_flagZ; // @[Logic.scala 286:13 297:19 325:23]
  wire [7:0] _GEN_1059 = _execResult_result_T_26 ? regs_a : _GEN_1041; // @[Logic.scala 286:13 297:19]
  wire [7:0] _GEN_1078 = _execResult_result_T_21 ? regs_a : _GEN_1059; // @[Logic.scala 286:13 297:19]
  wire [7:0] execResult_result_newRegs_21_a = _execResult_result_T_20 ? regs_a : _GEN_1078; // @[Logic.scala 286:13 297:19]
  wire  _GEN_1061 = _execResult_result_T_26 ? regs_flagZ : _GEN_1043; // @[Logic.scala 286:13 297:19]
  wire  _GEN_1080 = _execResult_result_T_21 ? regs_flagZ : _GEN_1061; // @[Logic.scala 286:13 297:19]
  wire  execResult_result_newRegs_21_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1080; // @[Logic.scala 286:13 297:19]
  wire  _GEN_1060 = _execResult_result_T_26 ? regs_flagN : _GEN_1042; // @[Logic.scala 286:13 297:19]
  wire  _GEN_1079 = _execResult_result_T_21 ? regs_flagN : _GEN_1060; // @[Logic.scala 286:13 297:19]
  wire  execResult_result_newRegs_21_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1079; // @[Logic.scala 286:13 297:19]
  wire  _execResult_T_116 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_117 = 8'ha == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_118 = 8'h4a == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_119 = 8'h2a == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_120 = 8'h6a == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_123 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode; // @[CPU6502Core.scala 237:20]
  wire [8:0] _execResult_result_res_T_329 = {regs_a, 1'h0}; // @[Shift.scala 39:24]
  wire [7:0] _execResult_result_res_T_333 = {regs_a[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_335 = {regs_flagC,regs_a[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_1189 = _execResult_T_120 ? regs_a[0] : regs_flagC; // @[Shift.scala 22:13 36:20 50:23]
  wire [7:0] _GEN_1190 = _execResult_T_120 ? _execResult_result_res_T_335 : regs_a; // @[Shift.scala 36:20 51:13 33:9]
  wire  _GEN_1191 = _execResult_T_119 ? regs_a[7] : _GEN_1189; // @[Shift.scala 36:20 46:23]
  wire [7:0] _GEN_1192 = _execResult_T_119 ? _execResult_result_res_T_333 : _GEN_1190; // @[Shift.scala 36:20 47:13]
  wire  _GEN_1193 = _execResult_T_118 ? regs_a[0] : _GEN_1191; // @[Shift.scala 36:20 42:23]
  wire [7:0] _GEN_1194 = _execResult_T_118 ? {{1'd0}, regs_a[7:1]} : _GEN_1192; // @[Shift.scala 36:20 43:13]
  wire  execResult_result_newRegs_23_flagC = _execResult_T_117 ? regs_a[7] : _GEN_1193; // @[Shift.scala 36:20 38:23]
  wire [7:0] execResult_result_res_22 = _execResult_T_117 ? _execResult_result_res_T_329[7:0] : _GEN_1194; // @[Shift.scala 36:20 39:13]
  wire  execResult_result_newRegs_23_flagN = execResult_result_res_22[7]; // @[Shift.scala 56:25]
  wire  execResult_result_newRegs_23_flagZ = execResult_result_res_22 == 8'h0; // @[Shift.scala 57:26]
  wire  _execResult_T_124 = 8'h6 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_125 = 8'h46 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_126 = 8'h26 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_127 = 8'h66 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_130 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode; // @[CPU6502Core.scala 237:20]
  wire [8:0] _execResult_result_res_T_336 = {io_memDataIn, 1'h0}; // @[Shift.scala 99:31]
  wire [7:0] _execResult_result_res_T_340 = {io_memDataIn[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_342 = {regs_flagC,io_memDataIn[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_1197 = _execResult_T_127 ? io_memDataIn[0] : regs_flagC; // @[Shift.scala 96:24 112:27 66:13]
  wire [7:0] _GEN_1198 = _execResult_T_127 ? _execResult_result_res_T_342 : 8'h0; // @[Shift.scala 113:17 94:13 96:24]
  wire  _GEN_1199 = _execResult_T_126 ? io_memDataIn[7] : _GEN_1197; // @[Shift.scala 96:24 107:27]
  wire [7:0] _GEN_1200 = _execResult_T_126 ? _execResult_result_res_T_340 : _GEN_1198; // @[Shift.scala 108:17 96:24]
  wire  _GEN_1201 = _execResult_T_125 ? io_memDataIn[0] : _GEN_1199; // @[Shift.scala 96:24 102:27]
  wire [7:0] _GEN_1202 = _execResult_T_125 ? {{1'd0}, io_memDataIn[7:1]} : _GEN_1200; // @[Shift.scala 103:17 96:24]
  wire  _GEN_1203 = _execResult_T_124 ? io_memDataIn[7] : _GEN_1201; // @[Shift.scala 96:24 98:27]
  wire [7:0] execResult_result_res_23 = _execResult_T_124 ? _execResult_result_res_T_336[7:0] : _GEN_1202; // @[Shift.scala 96:24 99:17]
  wire  _GEN_1206 = _execResult_result_T_26 ? _GEN_1203 : regs_flagC; // @[Shift.scala 66:13 77:19]
  wire [7:0] _GEN_1207 = _execResult_result_T_26 ? execResult_result_res_23 : 8'h0; // @[Shift.scala 77:19 117:24 72:20]
  wire  _GEN_1209 = _execResult_result_T_26 ? execResult_result_res_23[7] : regs_flagN; // @[Shift.scala 77:19 119:23 66:13]
  wire  _GEN_1210 = _execResult_result_T_26 ? execResult_result_res_23 == 8'h0 : regs_flagZ; // @[Shift.scala 77:19 120:23 66:13]
  wire  _GEN_1226 = _execResult_result_T_21 ? regs_flagC : _GEN_1206; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1226; // @[Shift.scala 66:13 77:19]
  wire  _GEN_1230 = _execResult_result_T_21 ? regs_flagZ : _GEN_1210; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1230; // @[Shift.scala 66:13 77:19]
  wire  _GEN_1229 = _execResult_result_T_21 ? regs_flagN : _GEN_1209; // @[Shift.scala 66:13 77:19]
  wire  execResult_result_newRegs_24_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1229; // @[Shift.scala 66:13 77:19]
  wire [7:0] _GEN_1227 = _execResult_result_T_21 ? 8'h0 : _GEN_1207; // @[Shift.scala 77:19 72:20]
  wire [7:0] execResult_result_result_25_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1227; // @[Shift.scala 77:19 72:20]
  wire  _execResult_T_131 = 8'h16 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_132 = 8'h56 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_133 = 8'h36 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_134 = 8'h76 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_137 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_result_T_93 = 8'he == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_94 = 8'h1e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_100 = 8'h4e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_101 = 8'h5e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_107 = 8'h2e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_108 = 8'h3e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_114 = 8'h6e == opcode; // @[Shift.scala 138:20]
  wire  _execResult_result_T_115 = 8'h7e == opcode; // @[Shift.scala 138:20]
  wire  _GEN_1265 = (_execResult_T_127 | _execResult_T_134 | 8'h6e == opcode | 8'h7e == opcode) & io_memDataIn[0]; // @[Shift.scala 136:14 138:20 152:18]
  wire [7:0] _GEN_1266 = _execResult_T_127 | _execResult_T_134 | 8'h6e == opcode | 8'h7e == opcode ?
    _execResult_result_res_T_342 : io_memDataIn; // @[Shift.scala 135:12 138:20 153:16]
  wire  _GEN_1267 = _execResult_T_126 | _execResult_T_133 | 8'h2e == opcode | 8'h3e == opcode ? io_memDataIn[7] :
    _GEN_1265; // @[Shift.scala 138:20 148:18]
  wire [7:0] _GEN_1268 = _execResult_T_126 | _execResult_T_133 | 8'h2e == opcode | 8'h3e == opcode ?
    _execResult_result_res_T_340 : _GEN_1266; // @[Shift.scala 138:20 149:16]
  wire  _GEN_1269 = _execResult_T_125 | _execResult_T_132 | 8'h4e == opcode | 8'h5e == opcode ? io_memDataIn[0] :
    _GEN_1267; // @[Shift.scala 138:20 144:18]
  wire [7:0] _GEN_1270 = _execResult_T_125 | _execResult_T_132 | 8'h4e == opcode | 8'h5e == opcode ? {{1'd0},
    io_memDataIn[7:1]} : _GEN_1268; // @[Shift.scala 138:20 145:16]
  wire  execResult_result_newCarry = _execResult_T_124 | _execResult_T_131 | 8'he == opcode | 8'h1e == opcode ?
    io_memDataIn[7] : _GEN_1269; // @[Shift.scala 138:20 140:18]
  wire [7:0] execResult_result_res_24 = _execResult_T_124 | _execResult_T_131 | 8'he == opcode | 8'h1e == opcode ?
    _execResult_result_res_T_336[7:0] : _GEN_1270; // @[Shift.scala 138:20 141:16]
  wire  _execResult_result_newRegs_flagZ_T_41 = execResult_result_res_24 == 8'h0; // @[Shift.scala 194:30]
  wire [7:0] _GEN_1274 = _execResult_result_T_26 ? execResult_result_res_24 : 8'h0; // @[Shift.scala 175:19 170:20 190:24]
  wire  _GEN_1276 = _execResult_result_T_26 ? execResult_result_newCarry : regs_flagC; // @[Shift.scala 164:13 175:19 192:23]
  wire  _GEN_1277 = _execResult_result_T_26 ? execResult_result_res_24[7] : regs_flagN; // @[Shift.scala 164:13 175:19 193:23]
  wire  _GEN_1278 = _execResult_result_T_26 ? execResult_result_res_24 == 8'h0 : regs_flagZ; // @[Shift.scala 164:13 175:19 194:23]
  wire  _GEN_1295 = _execResult_result_T_21 ? regs_flagC : _GEN_1276; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1295; // @[Shift.scala 164:13 175:19]
  wire  _GEN_1297 = _execResult_result_T_21 ? regs_flagZ : _GEN_1278; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1297; // @[Shift.scala 164:13 175:19]
  wire  _GEN_1296 = _execResult_result_T_21 ? regs_flagN : _GEN_1277; // @[Shift.scala 164:13 175:19]
  wire  execResult_result_newRegs_25_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1296; // @[Shift.scala 164:13 175:19]
  wire [7:0] _GEN_1293 = _execResult_result_T_21 ? 8'h0 : _GEN_1274; // @[Shift.scala 175:19 170:20]
  wire [7:0] execResult_result_result_26_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1293; // @[Shift.scala 175:19 170:20]
  wire  _execResult_T_144 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114; // @[CPU6502Core.scala 237:20]
  wire [7:0] _GEN_1340 = _execResult_result_T_30 ? execResult_result_res_24 : 8'h0; // @[Shift.scala 218:19 213:20 240:24]
  wire  _GEN_1342 = _execResult_result_T_30 ? execResult_result_newCarry : regs_flagC; // @[Shift.scala 207:13 218:19 242:23]
  wire  _GEN_1343 = _execResult_result_T_30 ? execResult_result_res_24[7] : regs_flagN; // @[Shift.scala 207:13 218:19 243:23]
  wire  _GEN_1344 = _execResult_result_T_30 ? _execResult_result_newRegs_flagZ_T_41 : regs_flagZ; // @[Shift.scala 207:13 218:19 244:23]
  wire  _GEN_1361 = _execResult_result_T_26 ? regs_flagC : _GEN_1342; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1394 = _execResult_result_T_21 ? regs_flagC : _GEN_1361; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1394; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1363 = _execResult_result_T_26 ? regs_flagZ : _GEN_1344; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1396 = _execResult_result_T_21 ? regs_flagZ : _GEN_1363; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1396; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1362 = _execResult_result_T_26 ? regs_flagN : _GEN_1343; // @[Shift.scala 207:13 218:19]
  wire  _GEN_1395 = _execResult_result_T_21 ? regs_flagN : _GEN_1362; // @[Shift.scala 207:13 218:19]
  wire  execResult_result_newRegs_26_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1395; // @[Shift.scala 207:13 218:19]
  wire [7:0] _GEN_1359 = _execResult_result_T_26 ? 8'h0 : _GEN_1340; // @[Shift.scala 218:19 213:20]
  wire [7:0] _GEN_1392 = _execResult_result_T_21 ? 8'h0 : _GEN_1359; // @[Shift.scala 218:19 213:20]
  wire [7:0] execResult_result_result_27_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1392; // @[Shift.scala 218:19 213:20]
  wire  _execResult_T_151 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_152 = 8'hc9 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_153 = 8'he0 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_154 = 8'hc0 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_156 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] _GEN_1505 = _execResult_T_154 ? regs_y : regs_a; // @[Compare.scala 30:14 32:20 35:29]
  wire [7:0] _GEN_1506 = _execResult_T_153 ? regs_x : _GEN_1505; // @[Compare.scala 32:20 34:29]
  wire [7:0] execResult_result_regValue = _execResult_T_152 ? regs_a : _GEN_1506; // @[Compare.scala 32:20 33:29]
  wire [8:0] execResult_result_diff_7 = execResult_result_regValue - io_memDataIn; // @[Compare.scala 38:25]
  wire  execResult_result_newRegs_28_flagC = execResult_result_regValue >= io_memDataIn; // @[Compare.scala 39:31]
  wire  execResult_result_newRegs_28_flagZ = execResult_result_regValue == io_memDataIn; // @[Compare.scala 40:31]
  wire  execResult_result_newRegs_28_flagN = execResult_result_diff_7[7]; // @[Compare.scala 41:26]
  wire  _execResult_T_161 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_result_regValue_T_4 = opcode == 8'he0 | opcode == 8'he4 | opcode == 8'hec; // @[Compare.scala 97:47]
  wire  _execResult_result_regValue_T_9 = opcode == 8'hc0 | opcode == 8'hc4 | opcode == 8'hcc; // @[Compare.scala 98:47]
  wire [7:0] _execResult_result_regValue_T_10 = _execResult_result_regValue_T_9 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] execResult_result_regValue_1 = _execResult_result_regValue_T_4 ? regs_x : _execResult_result_regValue_T_10; // @[Mux.scala 101:16]
  wire [8:0] execResult_result_diff_8 = execResult_result_regValue_1 - io_memDataIn; // @[Compare.scala 100:25]
  wire  execResult_result_flagC_5 = execResult_result_regValue_1 >= io_memDataIn; // @[Compare.scala 101:26]
  wire  execResult_result_flagZ = execResult_result_regValue_1 == io_memDataIn; // @[Compare.scala 102:26]
  wire  execResult_result_flagN_5 = execResult_result_diff_8[7]; // @[Compare.scala 103:21]
  wire  _GEN_1510 = _execResult_result_T_21 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 111:13 122:19 134:23]
  wire  _GEN_1511 = _execResult_result_T_21 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 111:13 122:19 135:23]
  wire  _GEN_1512 = _execResult_result_T_21 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 111:13 122:19 136:23]
  wire  execResult_result_newRegs_29_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1510; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_29_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1511; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_29_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1512; // @[Compare.scala 111:13 122:19]
  wire  _execResult_T_162 = 8'hd5 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_167 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode; // @[CPU6502Core.scala 237:20]
  wire  _GEN_1584 = _execResult_result_T_26 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 187:13 198:19 217:23]
  wire  _GEN_1585 = _execResult_result_T_26 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 187:13 198:19 218:23]
  wire  _GEN_1586 = _execResult_result_T_26 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 187:13 198:19 219:23]
  wire  _GEN_1615 = _execResult_result_T_21 ? regs_flagC : _GEN_1584; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1615; // @[Compare.scala 187:13 198:19]
  wire  _GEN_1616 = _execResult_result_T_21 ? regs_flagZ : _GEN_1585; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1616; // @[Compare.scala 187:13 198:19]
  wire  _GEN_1617 = _execResult_result_T_21 ? regs_flagN : _GEN_1586; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_31_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1617; // @[Compare.scala 187:13 198:19]
  wire  _execResult_T_170 = 8'hdd == opcode | 8'hd9 == opcode; // @[CPU6502Core.scala 237:20]
  wire  execResult_result_useY_2 = opcode == 8'hd9; // @[Compare.scala 243:23]
  wire [7:0] execResult_result_index_2 = execResult_result_useY_2 ? regs_y : regs_x; // @[Compare.scala 244:20]
  wire [15:0] _GEN_4254 = {{8'd0}, execResult_result_index_2}; // @[Compare.scala 257:57]
  wire [15:0] _execResult_result_result_operand_T_68 = resetVector + _GEN_4254; // @[Compare.scala 257:57]
  wire [15:0] _GEN_1658 = _execResult_result_T_21 ? _execResult_result_result_operand_T_68 : operand; // @[Compare.scala 246:19 241:20 257:24]
  wire [15:0] execResult_result_result_33_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_1658; // @[Compare.scala 246:19 250:24]
  wire  _execResult_T_171 = 8'hc1 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _GEN_1698 = _execResult_result_T_30 ? execResult_result_flagC_5 : regs_flagC; // @[Compare.scala 280:13 291:19 313:23]
  wire  _GEN_1699 = _execResult_result_T_30 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 280:13 291:19 314:23]
  wire  _GEN_1700 = _execResult_result_T_30 ? execResult_result_flagN_5 : regs_flagN; // @[Compare.scala 280:13 291:19 315:23]
  wire  _GEN_1716 = _execResult_result_T_26 ? regs_flagC : _GEN_1698; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1735 = _execResult_result_T_21 ? regs_flagC : _GEN_1716; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1735; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1717 = _execResult_result_T_26 ? regs_flagZ : _GEN_1699; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1736 = _execResult_result_T_21 ? regs_flagZ : _GEN_1717; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1736; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1718 = _execResult_result_T_26 ? regs_flagN : _GEN_1700; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1737 = _execResult_result_T_21 ? regs_flagN : _GEN_1718; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_33_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1737; // @[Compare.scala 280:13 291:19]
  wire  _execResult_T_172 = 8'hd1 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_173 = 8'hd2 == opcode; // @[CPU6502Core.scala 237:20]
  wire [15:0] execResult_result_result_36_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_326; // @[Compare.scala 387:19 391:24]
  wire  _execResult_T_174 = 8'hf0 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_175 = 8'hd0 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_176 = 8'hb0 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_177 = 8'h90 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_178 = 8'h30 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_179 = 8'h10 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_180 = 8'h50 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_181 = 8'h70 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_188 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _GEN_1921 = _execResult_T_180 & ~regs_flagV; // @[Branch.scala 18:16 20:20 28:31]
  wire  _GEN_1922 = _execResult_T_181 ? regs_flagV : _GEN_1921; // @[Branch.scala 20:20 27:31]
  wire  _GEN_1923 = _execResult_T_179 ? ~regs_flagN : _GEN_1922; // @[Branch.scala 20:20 26:31]
  wire  _GEN_1924 = _execResult_T_178 ? regs_flagN : _GEN_1923; // @[Branch.scala 20:20 25:31]
  wire  _GEN_1925 = _execResult_T_177 ? _execResult_result_diff_T_2 : _GEN_1924; // @[Branch.scala 20:20 24:31]
  wire  _GEN_1926 = _execResult_T_176 ? regs_flagC : _GEN_1925; // @[Branch.scala 20:20 23:31]
  wire  _GEN_1927 = _execResult_T_175 ? ~regs_flagZ : _GEN_1926; // @[Branch.scala 20:20 22:31]
  wire  execResult_result_takeBranch = _execResult_T_174 ? regs_flagZ : _GEN_1927; // @[Branch.scala 20:20 21:31]
  wire [7:0] execResult_result_offset = io_memDataIn; // @[Branch.scala 32:28]
  wire [15:0] _execResult_result_newRegs_pc_T_84 = regs_pc + 16'h1; // @[Branch.scala 36:43]
  wire [15:0] _GEN_4256 = {{8{execResult_result_offset[7]}},execResult_result_offset}; // @[Branch.scala 36:50]
  wire [15:0] _execResult_result_newRegs_pc_T_88 = $signed(_execResult_result_newRegs_pc_T_84) + $signed(_GEN_4256); // @[Branch.scala 36:60]
  wire [15:0] execResult_result_newRegs_36_pc = execResult_result_takeBranch ? _execResult_result_newRegs_pc_T_88 :
    _regs_pc_T_1; // @[Branch.scala 36:22]
  wire  _execResult_T_189 = 8'ha9 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_190 = 8'ha2 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_191 = 8'ha0 == opcode; // @[CPU6502Core.scala 237:20]
  wire  _execResult_T_193 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode; // @[CPU6502Core.scala 237:20]
  wire [7:0] _GEN_1929 = _execResult_T_191 ? io_memDataIn : regs_y; // @[LoadStore.scala 27:13 46:22 49:32]
  wire [7:0] _GEN_1930 = _execResult_T_190 ? io_memDataIn : regs_x; // @[LoadStore.scala 27:13 46:22 48:32]
  wire [7:0] _GEN_1931 = _execResult_T_190 ? regs_y : _GEN_1929; // @[LoadStore.scala 27:13 46:22]
  wire [7:0] _GEN_1932 = _execResult_T_189 ? io_memDataIn : regs_a; // @[LoadStore.scala 27:13 46:22 47:32]
  wire [7:0] _GEN_1933 = _execResult_T_189 ? regs_x : _GEN_1930; // @[LoadStore.scala 27:13 46:22]
  wire [7:0] _GEN_1934 = _execResult_T_189 ? regs_y : _GEN_1931; // @[LoadStore.scala 27:13 46:22]
  wire  _execResult_result_newRegs_flagZ_T_45 = io_memDataIn == 8'h0; // @[LoadStore.scala 53:34]
  wire  execResult_result_result_38_done = _T_5 ? 1'h0 : 1'h1; // @[LoadStore.scala 35:25 38:19 56:19]
  wire [7:0] execResult_result_newRegs_37_a = _T_5 ? regs_a : _GEN_1932; // @[LoadStore.scala 27:13 35:25]
  wire [7:0] execResult_result_result_38_regs_a = _T_5 ? regs_a : execResult_result_newRegs_37_a; // @[LoadStore.scala 35:25 40:19 58:19]
  wire [7:0] execResult_result_newRegs_37_x = _T_5 ? regs_x : _GEN_1933; // @[LoadStore.scala 27:13 35:25]
  wire [7:0] execResult_result_result_38_regs_x = _T_5 ? regs_x : execResult_result_newRegs_37_x; // @[LoadStore.scala 35:25 40:19 58:19]
  wire [7:0] execResult_result_newRegs_37_y = _T_5 ? regs_y : _GEN_1934; // @[LoadStore.scala 27:13 35:25]
  wire [7:0] execResult_result_result_38_regs_y = _T_5 ? regs_y : execResult_result_newRegs_37_y; // @[LoadStore.scala 35:25 40:19 58:19]
  wire [15:0] execResult_result_result_38_regs_pc = _T_5 ? regs_pc : _GEN_44; // @[LoadStore.scala 35:25 40:19 58:19]
  wire  execResult_result_newRegs_37_flagZ = _T_5 ? regs_flagZ : io_memDataIn == 8'h0; // @[LoadStore.scala 27:13 35:25 53:21]
  wire  execResult_result_result_38_regs_flagZ = _T_5 ? regs_flagZ : execResult_result_newRegs_37_flagZ; // @[LoadStore.scala 35:25 40:19 58:19]
  wire  execResult_result_newRegs_37_flagN = _T_5 ? regs_flagN : io_memDataIn[7]; // @[LoadStore.scala 27:13 35:25 52:21]
  wire  execResult_result_result_38_regs_flagN = _T_5 ? regs_flagN : execResult_result_newRegs_37_flagN; // @[LoadStore.scala 35:25 40:19 58:19]
  wire  execResult_result_isLoadA = opcode == 8'ha5; // @[LoadStore.scala 80:26]
  wire  execResult_result_isLoadX = opcode == 8'ha6; // @[LoadStore.scala 81:26]
  wire  execResult_result_isLoadY = opcode == 8'ha4; // @[LoadStore.scala 82:26]
  wire  execResult_result_isStoreA = opcode == 8'h85; // @[LoadStore.scala 83:27]
  wire  execResult_result_isStoreX = opcode == 8'h86; // @[LoadStore.scala 84:27]
  wire  _execResult_result_T_227 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY; // @[LoadStore.scala 98:33]
  wire [7:0] _GEN_1956 = execResult_result_isLoadX ? io_memDataIn : regs_x; // @[LoadStore.scala 102:31 103:23 69:13]
  wire [7:0] _GEN_1957 = execResult_result_isLoadX ? regs_y : io_memDataIn; // @[LoadStore.scala 102:31 69:13 105:23]
  wire [7:0] _GEN_1958 = execResult_result_isLoadA ? io_memDataIn : regs_a; // @[LoadStore.scala 100:25 101:23 69:13]
  wire [7:0] _GEN_1959 = execResult_result_isLoadA ? regs_x : _GEN_1956; // @[LoadStore.scala 100:25 69:13]
  wire [7:0] _GEN_1960 = execResult_result_isLoadA ? regs_y : _GEN_1957; // @[LoadStore.scala 100:25 69:13]
  wire [7:0] _execResult_result_result_memData_T = execResult_result_isStoreX ? regs_x : regs_y; // @[LoadStore.scala 111:54]
  wire [7:0] _execResult_result_result_memData_T_1 = execResult_result_isStoreA ? regs_a :
    _execResult_result_result_memData_T; // @[LoadStore.scala 111:32]
  wire [7:0] _GEN_1962 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1958
     : regs_a; // @[LoadStore.scala 69:13 98:45]
  wire [7:0] _GEN_1963 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1959
     : regs_x; // @[LoadStore.scala 69:13 98:45]
  wire [7:0] _GEN_1964 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1960
     : regs_y; // @[LoadStore.scala 69:13 98:45]
  wire  _GEN_1965 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? io_memDataIn[7]
     : regs_flagN; // @[LoadStore.scala 107:25 69:13 98:45]
  wire  _GEN_1966 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ?
    _execResult_result_newRegs_flagZ_T_45 : regs_flagZ; // @[LoadStore.scala 108:25 69:13 98:45]
  wire  _GEN_1967 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 1'h0 : 1'h1; // @[LoadStore.scala 76:21 110:27 98:45]
  wire [7:0] _GEN_1968 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 8'h0 :
    _execResult_result_result_memData_T_1; // @[LoadStore.scala 75:20 111:26 98:45]
  wire  _GEN_1970 = _execResult_result_T_21 & _execResult_result_T_227; // @[LoadStore.scala 87:19 77:20]
  wire [7:0] _GEN_1971 = _execResult_result_T_21 ? _GEN_1962 : regs_a; // @[LoadStore.scala 69:13 87:19]
  wire [7:0] _GEN_1972 = _execResult_result_T_21 ? _GEN_1963 : regs_x; // @[LoadStore.scala 69:13 87:19]
  wire [7:0] _GEN_1973 = _execResult_result_T_21 ? _GEN_1964 : regs_y; // @[LoadStore.scala 69:13 87:19]
  wire  _GEN_1974 = _execResult_result_T_21 ? _GEN_1965 : regs_flagN; // @[LoadStore.scala 69:13 87:19]
  wire  _GEN_1975 = _execResult_result_T_21 ? _GEN_1966 : regs_flagZ; // @[LoadStore.scala 69:13 87:19]
  wire [7:0] _GEN_1977 = _execResult_result_T_21 ? _GEN_1968 : 8'h0; // @[LoadStore.scala 87:19 75:20]
  wire [7:0] execResult_result_newRegs_38_a = _execResult_result_T_20 ? regs_a : _GEN_1971; // @[LoadStore.scala 69:13 87:19]
  wire [7:0] execResult_result_newRegs_38_x = _execResult_result_T_20 ? regs_x : _GEN_1972; // @[LoadStore.scala 69:13 87:19]
  wire [7:0] execResult_result_newRegs_38_y = _execResult_result_T_20 ? regs_y : _GEN_1973; // @[LoadStore.scala 69:13 87:19]
  wire  execResult_result_newRegs_38_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1975; // @[LoadStore.scala 69:13 87:19]
  wire  execResult_result_newRegs_38_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1974; // @[LoadStore.scala 69:13 87:19]
  wire  execResult_result_result_39_memRead = _execResult_result_T_20 | _GEN_1970; // @[LoadStore.scala 87:19 90:24]
  wire  execResult_result_result_39_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1967; // @[LoadStore.scala 87:19 76:21]
  wire [7:0] execResult_result_result_39_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1977; // @[LoadStore.scala 87:19 75:20]
  wire  execResult_result_isLoadA_1 = opcode == 8'hb5; // @[LoadStore.scala 136:26]
  wire  execResult_result_isLoadY_1 = opcode == 8'hb4; // @[LoadStore.scala 137:26]
  wire  _execResult_result_T_230 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1; // @[LoadStore.scala 151:22]
  wire [7:0] _GEN_2016 = execResult_result_isLoadA_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 125:13 153:25 154:23]
  wire [7:0] _GEN_2017 = execResult_result_isLoadA_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 125:13 153:25 156:23]
  wire [7:0] _execResult_result_result_memData_T_3 = opcode == 8'h95 ? regs_a : regs_y; // @[LoadStore.scala 162:32]
  wire [7:0] _GEN_2019 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_2016 : regs_a; // @[LoadStore.scala 125:13 151:34]
  wire [7:0] _GEN_2020 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_2017 : regs_y; // @[LoadStore.scala 125:13 151:34]
  wire  _GEN_2021 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 125:13 151:34 158:25]
  wire  _GEN_2022 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _execResult_result_newRegs_flagZ_T_45 :
    regs_flagZ; // @[LoadStore.scala 125:13 151:34 159:25]
  wire  _GEN_2023 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 132:21 151:34 161:27]
  wire [7:0] _GEN_2024 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 8'h0 :
    _execResult_result_result_memData_T_3; // @[LoadStore.scala 131:20 151:34 162:26]
  wire  _GEN_2026 = _execResult_result_T_21 & _execResult_result_T_230; // @[LoadStore.scala 140:19 133:20]
  wire [7:0] _GEN_2027 = _execResult_result_T_21 ? _GEN_2019 : regs_a; // @[LoadStore.scala 125:13 140:19]
  wire [7:0] _GEN_2028 = _execResult_result_T_21 ? _GEN_2020 : regs_y; // @[LoadStore.scala 125:13 140:19]
  wire  _GEN_2029 = _execResult_result_T_21 ? _GEN_2021 : regs_flagN; // @[LoadStore.scala 125:13 140:19]
  wire  _GEN_2030 = _execResult_result_T_21 ? _GEN_2022 : regs_flagZ; // @[LoadStore.scala 125:13 140:19]
  wire [7:0] _GEN_2032 = _execResult_result_T_21 ? _GEN_2024 : 8'h0; // @[LoadStore.scala 140:19 131:20]
  wire [7:0] execResult_result_newRegs_39_a = _execResult_result_T_20 ? regs_a : _GEN_2027; // @[LoadStore.scala 125:13 140:19]
  wire [7:0] execResult_result_newRegs_39_y = _execResult_result_T_20 ? regs_y : _GEN_2028; // @[LoadStore.scala 125:13 140:19]
  wire  execResult_result_newRegs_39_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2030; // @[LoadStore.scala 125:13 140:19]
  wire  execResult_result_newRegs_39_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2029; // @[LoadStore.scala 125:13 140:19]
  wire  execResult_result_result_40_memRead = _execResult_result_T_20 | _GEN_2026; // @[LoadStore.scala 140:19 143:24]
  wire  execResult_result_result_40_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_2023; // @[LoadStore.scala 140:19 132:21]
  wire [7:0] execResult_result_result_40_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2032; // @[LoadStore.scala 140:19 131:20]
  wire  execResult_result_isLoad = opcode == 8'hb6; // @[LoadStore.scala 187:25]
  wire [7:0] _execResult_result_result_operand_T_90 = io_memDataIn + regs_y; // @[LoadStore.scala 193:38]
  wire [7:0] _GEN_2071 = execResult_result_isLoad ? io_memDataIn : regs_x; // @[LoadStore.scala 176:13 199:22 201:21]
  wire  _GEN_2072 = execResult_result_isLoad ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 176:13 199:22 202:25]
  wire  _GEN_2073 = execResult_result_isLoad ? _execResult_result_newRegs_flagZ_T_45 : regs_flagZ; // @[LoadStore.scala 176:13 199:22 203:25]
  wire  _GEN_2074 = execResult_result_isLoad ? 1'h0 : 1'h1; // @[LoadStore.scala 183:21 199:22 205:27]
  wire [7:0] _GEN_2075 = execResult_result_isLoad ? 8'h0 : regs_x; // @[LoadStore.scala 182:20 199:22 206:26]
  wire  _GEN_2077 = _execResult_result_T_21 & execResult_result_isLoad; // @[LoadStore.scala 189:19 184:20]
  wire [7:0] _GEN_2078 = _execResult_result_T_21 ? _GEN_2071 : regs_x; // @[LoadStore.scala 176:13 189:19]
  wire  _GEN_2079 = _execResult_result_T_21 ? _GEN_2072 : regs_flagN; // @[LoadStore.scala 176:13 189:19]
  wire  _GEN_2080 = _execResult_result_T_21 ? _GEN_2073 : regs_flagZ; // @[LoadStore.scala 176:13 189:19]
  wire [7:0] _GEN_2082 = _execResult_result_T_21 ? _GEN_2075 : 8'h0; // @[LoadStore.scala 189:19 182:20]
  wire [7:0] execResult_result_newRegs_40_x = _execResult_result_T_20 ? regs_x : _GEN_2078; // @[LoadStore.scala 176:13 189:19]
  wire  execResult_result_newRegs_40_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2080; // @[LoadStore.scala 176:13 189:19]
  wire  execResult_result_newRegs_40_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2079; // @[LoadStore.scala 176:13 189:19]
  wire  execResult_result_result_41_memRead = _execResult_result_T_20 | _GEN_2077; // @[LoadStore.scala 189:19 192:24]
  wire [15:0] execResult_result_result_41_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_90} : operand; // @[LoadStore.scala 189:19 185:20 193:24]
  wire  execResult_result_result_41_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_2074; // @[LoadStore.scala 189:19 183:21]
  wire [7:0] execResult_result_result_41_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2082; // @[LoadStore.scala 189:19 182:20]
  wire  execResult_result_isLoadA_2 = opcode == 8'had; // @[LoadStore.scala 231:26]
  wire  execResult_result_isLoadX_1 = opcode == 8'hae; // @[LoadStore.scala 232:26]
  wire  execResult_result_isLoadY_2 = opcode == 8'hac; // @[LoadStore.scala 233:26]
  wire  _execResult_result_T_237 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 |
    execResult_result_isLoadY_2; // @[LoadStore.scala 254:33]
  wire [7:0] _GEN_2118 = execResult_result_isLoadX_1 ? io_memDataIn : regs_x; // @[LoadStore.scala 220:13 258:31 259:23]
  wire [7:0] _GEN_2119 = execResult_result_isLoadX_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 220:13 258:31 261:23]
  wire [7:0] _GEN_2120 = execResult_result_isLoadA_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 220:13 256:25 257:23]
  wire [7:0] _GEN_2121 = execResult_result_isLoadA_2 ? regs_x : _GEN_2118; // @[LoadStore.scala 220:13 256:25]
  wire [7:0] _GEN_2122 = execResult_result_isLoadA_2 ? regs_y : _GEN_2119; // @[LoadStore.scala 220:13 256:25]
  wire  _execResult_result_result_memData_T_4 = opcode == 8'h8e; // @[LoadStore.scala 269:21]
  wire  _execResult_result_result_memData_T_5 = opcode == 8'h8c; // @[LoadStore.scala 270:21]
  wire [7:0] _execResult_result_result_memData_T_6 = _execResult_result_result_memData_T_5 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] _execResult_result_result_memData_T_7 = _execResult_result_result_memData_T_4 ? regs_x :
    _execResult_result_result_memData_T_6; // @[Mux.scala 101:16]
  wire [7:0] _GEN_2124 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2120 : regs_a; // @[LoadStore.scala 220:13 254:45]
  wire [7:0] _GEN_2125 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2121 : regs_x; // @[LoadStore.scala 220:13 254:45]
  wire [7:0] _GEN_2126 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_2122 : regs_y; // @[LoadStore.scala 220:13 254:45]
  wire  _GEN_2127 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 220:13 254:45 263:25]
  wire  _GEN_2128 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _execResult_result_newRegs_flagZ_T_45 : regs_flagZ; // @[LoadStore.scala 220:13 254:45 264:25]
  wire  _GEN_2129 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 1'h0 : 1'h1
    ; // @[LoadStore.scala 227:21 254:45 266:27]
  wire [7:0] _GEN_2130 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 8'h0
     : _execResult_result_result_memData_T_7; // @[LoadStore.scala 226:20 254:45 268:26]
  wire  _GEN_2132 = _execResult_result_T_26 & _execResult_result_T_237; // @[LoadStore.scala 235:19 228:20]
  wire [7:0] _GEN_2133 = _execResult_result_T_26 ? _GEN_2124 : regs_a; // @[LoadStore.scala 220:13 235:19]
  wire [7:0] _GEN_2134 = _execResult_result_T_26 ? _GEN_2125 : regs_x; // @[LoadStore.scala 220:13 235:19]
  wire [7:0] _GEN_2135 = _execResult_result_T_26 ? _GEN_2126 : regs_y; // @[LoadStore.scala 220:13 235:19]
  wire  _GEN_2136 = _execResult_result_T_26 ? _GEN_2127 : regs_flagN; // @[LoadStore.scala 220:13 235:19]
  wire  _GEN_2137 = _execResult_result_T_26 ? _GEN_2128 : regs_flagZ; // @[LoadStore.scala 220:13 235:19]
  wire [7:0] _GEN_2139 = _execResult_result_T_26 ? _GEN_2130 : 8'h0; // @[LoadStore.scala 235:19 226:20]
  wire [7:0] _GEN_2170 = _execResult_result_T_21 ? regs_a : _GEN_2133; // @[LoadStore.scala 220:13 235:19]
  wire [7:0] execResult_result_newRegs_41_a = _execResult_result_T_20 ? regs_a : _GEN_2170; // @[LoadStore.scala 220:13 235:19]
  wire [7:0] _GEN_2171 = _execResult_result_T_21 ? regs_x : _GEN_2134; // @[LoadStore.scala 220:13 235:19]
  wire [7:0] execResult_result_newRegs_41_x = _execResult_result_T_20 ? regs_x : _GEN_2171; // @[LoadStore.scala 220:13 235:19]
  wire [7:0] _GEN_2172 = _execResult_result_T_21 ? regs_y : _GEN_2135; // @[LoadStore.scala 220:13 235:19]
  wire [7:0] execResult_result_newRegs_41_y = _execResult_result_T_20 ? regs_y : _GEN_2172; // @[LoadStore.scala 220:13 235:19]
  wire  _GEN_2174 = _execResult_result_T_21 ? regs_flagZ : _GEN_2137; // @[LoadStore.scala 220:13 235:19]
  wire  execResult_result_newRegs_41_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2174; // @[LoadStore.scala 220:13 235:19]
  wire  _GEN_2173 = _execResult_result_T_21 ? regs_flagN : _GEN_2136; // @[LoadStore.scala 220:13 235:19]
  wire  execResult_result_newRegs_41_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2173; // @[LoadStore.scala 220:13 235:19]
  wire  _GEN_2154 = _execResult_result_T_21 | _GEN_2132; // @[LoadStore.scala 235:19 246:24]
  wire  _GEN_2175 = _execResult_result_T_21 ? 1'h0 : _execResult_result_T_26 & _GEN_2129; // @[LoadStore.scala 235:19 227:21]
  wire [7:0] _GEN_2176 = _execResult_result_T_21 ? 8'h0 : _GEN_2139; // @[LoadStore.scala 235:19 226:20]
  wire  execResult_result_result_42_memRead = _execResult_result_T_20 | _GEN_2154; // @[LoadStore.scala 235:19 238:24]
  wire  execResult_result_result_42_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2175; // @[LoadStore.scala 235:19 227:21]
  wire [7:0] execResult_result_result_42_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2176; // @[LoadStore.scala 235:19 226:20]
  wire  execResult_result_useY_3 = opcode == 8'hb9 | opcode == 8'hbe | opcode == 8'h99; // @[LoadStore.scala 297:59]
  wire [7:0] execResult_result_indexReg = execResult_result_useY_3 ? regs_y : regs_x; // @[LoadStore.scala 298:23]
  wire [15:0] _GEN_4257 = {{8'd0}, execResult_result_indexReg}; // @[LoadStore.scala 317:57]
  wire [15:0] _execResult_result_result_operand_T_97 = resetVector + _GEN_4257; // @[LoadStore.scala 317:57]
  wire [7:0] _GEN_2205 = _execResult_result_T_26 ? io_memDataIn : regs_a; // @[LoadStore.scala 285:13 305:19 325:19]
  wire  _GEN_2206 = _execResult_result_T_26 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 285:13 305:19 326:23]
  wire  _GEN_2207 = _execResult_result_T_26 ? _execResult_result_newRegs_flagZ_T_45 : regs_flagZ; // @[LoadStore.scala 285:13 305:19 327:23]
  wire [7:0] _GEN_2237 = _execResult_result_T_21 ? regs_a : _GEN_2205; // @[LoadStore.scala 285:13 305:19]
  wire [7:0] execResult_result_newRegs_42_a = _execResult_result_T_20 ? regs_a : _GEN_2237; // @[LoadStore.scala 285:13 305:19]
  wire  _GEN_2239 = _execResult_result_T_21 ? regs_flagZ : _GEN_2207; // @[LoadStore.scala 285:13 305:19]
  wire  execResult_result_newRegs_42_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2239; // @[LoadStore.scala 285:13 305:19]
  wire  _GEN_2238 = _execResult_result_T_21 ? regs_flagN : _GEN_2206; // @[LoadStore.scala 285:13 305:19]
  wire  execResult_result_newRegs_42_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2238; // @[LoadStore.scala 285:13 305:19]
  wire [15:0] _GEN_2222 = _execResult_result_T_21 ? _execResult_result_result_operand_T_97 : operand; // @[LoadStore.scala 305:19 294:20 317:24]
  wire [15:0] execResult_result_result_43_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_2222; // @[LoadStore.scala 305:19 309:24]
  wire  execResult_result_isLoad_1 = opcode == 8'ha1; // @[LoadStore.scala 351:25]
  wire  _GEN_2263 = execResult_result_isLoad_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 347:21 377:22 380:27]
  wire [7:0] _GEN_2264 = execResult_result_isLoad_1 ? 8'h0 : regs_a; // @[LoadStore.scala 346:20 377:22 381:26]
  wire  _execResult_result_T_245 = 3'h4 == cycle; // @[LoadStore.scala 353:19]
  wire [7:0] _GEN_2265 = execResult_result_isLoad_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 340:13 386:22 387:21]
  wire  _GEN_2266 = execResult_result_isLoad_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 340:13 386:22 388:25]
  wire  _GEN_2267 = execResult_result_isLoad_1 ? _execResult_result_newRegs_flagZ_T_45 : regs_flagZ; // @[LoadStore.scala 340:13 386:22 389:25]
  wire [7:0] _GEN_2280 = 3'h4 == cycle ? _GEN_2265 : regs_a; // @[LoadStore.scala 340:13 353:19]
  wire [7:0] _GEN_2300 = _execResult_result_T_30 ? regs_a : _GEN_2280; // @[LoadStore.scala 340:13 353:19]
  wire [7:0] _GEN_2321 = _execResult_result_T_26 ? regs_a : _GEN_2300; // @[LoadStore.scala 340:13 353:19]
  wire [7:0] _GEN_2342 = _execResult_result_T_21 ? regs_a : _GEN_2321; // @[LoadStore.scala 340:13 353:19]
  wire [7:0] execResult_result_newRegs_43_a = _execResult_result_T_20 ? regs_a : _GEN_2342; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2282 = 3'h4 == cycle ? _GEN_2267 : regs_flagZ; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2302 = _execResult_result_T_30 ? regs_flagZ : _GEN_2282; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2323 = _execResult_result_T_26 ? regs_flagZ : _GEN_2302; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2344 = _execResult_result_T_21 ? regs_flagZ : _GEN_2323; // @[LoadStore.scala 340:13 353:19]
  wire  execResult_result_newRegs_43_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2344; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2281 = 3'h4 == cycle ? _GEN_2266 : regs_flagN; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2301 = _execResult_result_T_30 ? regs_flagN : _GEN_2281; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2322 = _execResult_result_T_26 ? regs_flagN : _GEN_2301; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2343 = _execResult_result_T_21 ? regs_flagN : _GEN_2322; // @[LoadStore.scala 340:13 353:19]
  wire  execResult_result_newRegs_43_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2343; // @[LoadStore.scala 340:13 353:19]
  wire  _GEN_2297 = _execResult_result_T_30 & execResult_result_isLoad_1; // @[LoadStore.scala 353:19 348:20]
  wire [7:0] _GEN_2299 = _execResult_result_T_30 ? _GEN_2264 : 8'h0; // @[LoadStore.scala 353:19 346:20]
  wire  _GEN_2315 = _execResult_result_T_30 ? 1'h0 : 3'h4 == cycle; // @[LoadStore.scala 342:17 353:19]
  wire  _GEN_2317 = _execResult_result_T_26 | _GEN_2297; // @[LoadStore.scala 353:19 371:24]
  wire  _GEN_2319 = _execResult_result_T_26 ? 1'h0 : _execResult_result_T_30 & _GEN_2263; // @[LoadStore.scala 353:19 347:21]
  wire [7:0] _GEN_2320 = _execResult_result_T_26 ? 8'h0 : _GEN_2299; // @[LoadStore.scala 353:19 346:20]
  wire  _GEN_2336 = _execResult_result_T_26 ? 1'h0 : _GEN_2315; // @[LoadStore.scala 342:17 353:19]
  wire  _GEN_2338 = _execResult_result_T_21 | _GEN_2317; // @[LoadStore.scala 353:19 365:24]
  wire  _GEN_2340 = _execResult_result_T_21 ? 1'h0 : _GEN_2319; // @[LoadStore.scala 353:19 347:21]
  wire [7:0] _GEN_2341 = _execResult_result_T_21 ? 8'h0 : _GEN_2320; // @[LoadStore.scala 353:19 346:20]
  wire  _GEN_2357 = _execResult_result_T_21 ? 1'h0 : _GEN_2336; // @[LoadStore.scala 342:17 353:19]
  wire  execResult_result_result_44_memRead = _execResult_result_T_20 | _GEN_2338; // @[LoadStore.scala 353:19 357:24]
  wire  execResult_result_result_44_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2340; // @[LoadStore.scala 353:19 347:21]
  wire [7:0] execResult_result_result_44_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2341; // @[LoadStore.scala 353:19 346:20]
  wire  execResult_result_result_44_done = _execResult_result_T_20 ? 1'h0 : _GEN_2357; // @[LoadStore.scala 342:17 353:19]
  wire  execResult_result_isLoad_2 = opcode == 8'hb1; // @[LoadStore.scala 414:25]
  wire [15:0] execResult_result_finalAddr = operand + _GEN_4244; // @[LoadStore.scala 439:33]
  wire  _GEN_2381 = execResult_result_isLoad_2 ? 1'h0 : 1'h1; // @[LoadStore.scala 410:21 441:22 444:27]
  wire [7:0] _GEN_2382 = execResult_result_isLoad_2 ? 8'h0 : regs_a; // @[LoadStore.scala 409:20 441:22 445:26]
  wire [7:0] _GEN_2383 = execResult_result_isLoad_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 403:13 450:22 451:21]
  wire  _GEN_2384 = execResult_result_isLoad_2 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 403:13 450:22 452:25]
  wire  _GEN_2385 = execResult_result_isLoad_2 ? _execResult_result_newRegs_flagZ_T_45 : regs_flagZ; // @[LoadStore.scala 403:13 450:22 453:25]
  wire [7:0] _GEN_2398 = _execResult_result_T_245 ? _GEN_2383 : regs_a; // @[LoadStore.scala 403:13 416:19]
  wire [7:0] _GEN_2418 = _execResult_result_T_30 ? regs_a : _GEN_2398; // @[LoadStore.scala 403:13 416:19]
  wire [7:0] _GEN_2439 = _execResult_result_T_26 ? regs_a : _GEN_2418; // @[LoadStore.scala 403:13 416:19]
  wire [7:0] _GEN_2460 = _execResult_result_T_21 ? regs_a : _GEN_2439; // @[LoadStore.scala 403:13 416:19]
  wire [7:0] execResult_result_newRegs_44_a = _execResult_result_T_20 ? regs_a : _GEN_2460; // @[LoadStore.scala 403:13 416:19]
  wire  _GEN_2400 = _execResult_result_T_245 ? _GEN_2385 : regs_flagZ; // @[LoadStore.scala 403:13 416:19]
  wire  _GEN_2420 = _execResult_result_T_30 ? regs_flagZ : _GEN_2400; // @[LoadStore.scala 403:13 416:19]
  wire  _GEN_2441 = _execResult_result_T_26 ? regs_flagZ : _GEN_2420; // @[LoadStore.scala 403:13 416:19]
  wire  _GEN_2462 = _execResult_result_T_21 ? regs_flagZ : _GEN_2441; // @[LoadStore.scala 403:13 416:19]
  wire  execResult_result_newRegs_44_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2462; // @[LoadStore.scala 403:13 416:19]
  wire  _GEN_2399 = _execResult_result_T_245 ? _GEN_2384 : regs_flagN; // @[LoadStore.scala 403:13 416:19]
  wire  _GEN_2419 = _execResult_result_T_30 ? regs_flagN : _GEN_2399; // @[LoadStore.scala 403:13 416:19]
  wire  _GEN_2440 = _execResult_result_T_26 ? regs_flagN : _GEN_2419; // @[LoadStore.scala 403:13 416:19]
  wire  _GEN_2461 = _execResult_result_T_21 ? regs_flagN : _GEN_2440; // @[LoadStore.scala 403:13 416:19]
  wire  execResult_result_newRegs_44_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2461; // @[LoadStore.scala 403:13 416:19]
  wire [15:0] _GEN_2414 = _execResult_result_T_30 ? execResult_result_finalAddr : 16'h0; // @[LoadStore.scala 416:19 408:20 440:24]
  wire  _GEN_2415 = _execResult_result_T_30 & execResult_result_isLoad_2; // @[LoadStore.scala 416:19 411:20]
  wire [7:0] _GEN_2417 = _execResult_result_T_30 ? _GEN_2382 : 8'h0; // @[LoadStore.scala 416:19 409:20]
  wire [15:0] _GEN_2434 = _execResult_result_T_26 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_2414; // @[LoadStore.scala 416:19 433:24]
  wire  _GEN_2435 = _execResult_result_T_26 | _GEN_2415; // @[LoadStore.scala 416:19 434:24]
  wire  _GEN_2437 = _execResult_result_T_26 ? 1'h0 : _execResult_result_T_30 & _GEN_2381; // @[LoadStore.scala 416:19 410:21]
  wire [7:0] _GEN_2438 = _execResult_result_T_26 ? 8'h0 : _GEN_2417; // @[LoadStore.scala 416:19 409:20]
  wire [15:0] _GEN_2455 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_2434; // @[LoadStore.scala 416:19 427:24]
  wire  _GEN_2456 = _execResult_result_T_21 | _GEN_2435; // @[LoadStore.scala 416:19 428:24]
  wire  _GEN_2458 = _execResult_result_T_21 ? 1'h0 : _GEN_2437; // @[LoadStore.scala 416:19 410:21]
  wire [7:0] _GEN_2459 = _execResult_result_T_21 ? 8'h0 : _GEN_2438; // @[LoadStore.scala 416:19 409:20]
  wire [15:0] execResult_result_result_45_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2455; // @[LoadStore.scala 416:19 419:24]
  wire  execResult_result_result_45_memRead = _execResult_result_T_20 | _GEN_2456; // @[LoadStore.scala 416:19 420:24]
  wire  execResult_result_result_45_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2458; // @[LoadStore.scala 416:19 410:21]
  wire [7:0] execResult_result_result_45_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2459; // @[LoadStore.scala 416:19 409:20]
  wire [7:0] _execResult_result_pushData_T = {regs_flagN,regs_flagV,2'h3,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] execResult_result_pushData = opcode == 8'h8 ? _execResult_result_pushData_T : regs_a; // @[Stack.scala 21:14 23:29 24:16]
  wire [7:0] execResult_result_newRegs_45_sp = regs_sp - 8'h1; // @[Stack.scala 27:27]
  wire [15:0] execResult_result_result_46_memAddr = {8'h1,regs_sp}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_newRegs_sp_T_3 = regs_sp + 8'h1; // @[Stack.scala 57:31]
  wire [7:0] _GEN_2499 = opcode == 8'h68 ? io_memDataIn : regs_a; // @[Stack.scala 44:13 65:33 66:21]
  wire  _GEN_2500 = opcode == 8'h68 ? io_memDataIn[7] : io_memDataIn[7]; // @[Stack.scala 65:33 67:25 75:25]
  wire  _GEN_2501 = opcode == 8'h68 ? _execResult_result_newRegs_flagZ_T_45 : io_memDataIn[1]; // @[Stack.scala 65:33 68:25 71:25]
  wire  _GEN_2502 = opcode == 8'h68 ? regs_flagC : io_memDataIn[0]; // @[Stack.scala 44:13 65:33 70:25]
  wire  _GEN_2503 = opcode == 8'h68 ? regs_flagI : io_memDataIn[2]; // @[Stack.scala 44:13 65:33 72:25]
  wire  _GEN_2504 = opcode == 8'h68 ? regs_flagD : io_memDataIn[3]; // @[Stack.scala 44:13 65:33 73:25]
  wire  _GEN_2505 = opcode == 8'h68 ? regs_flagV : io_memDataIn[6]; // @[Stack.scala 44:13 65:33 74:25]
  wire [15:0] _GEN_2506 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : 16'h0; // @[Stack.scala 55:19 49:20 62:24]
  wire [7:0] _GEN_2508 = _execResult_result_T_21 ? _GEN_2499 : regs_a; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2509 = _execResult_result_T_21 ? _GEN_2500 : regs_flagN; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2510 = _execResult_result_T_21 ? _GEN_2501 : regs_flagZ; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2511 = _execResult_result_T_21 ? _GEN_2502 : regs_flagC; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2512 = _execResult_result_T_21 ? _GEN_2503 : regs_flagI; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2513 = _execResult_result_T_21 ? _GEN_2504 : regs_flagD; // @[Stack.scala 44:13 55:19]
  wire  _GEN_2514 = _execResult_result_T_21 ? _GEN_2505 : regs_flagV; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_46_a = _execResult_result_T_20 ? regs_a : _GEN_2508; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_46_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Stack.scala 44:13 55:19 57:20]
  wire  execResult_result_newRegs_46_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_2511; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2510; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2512; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_2513; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_2514; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_46_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_2509; // @[Stack.scala 44:13 55:19]
  wire [15:0] execResult_result_result_47_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2506; // @[Stack.scala 55:19 49:20]
  wire [15:0] _GEN_2550 = _execResult_result_T_21 ? regs_pc : 16'h0; // @[Jump.scala 26:19 20:20 36:24]
  wire [15:0] _GEN_2553 = _execResult_result_T_21 ? resetVector : regs_pc; // @[Jump.scala 15:13 26:19 39:20]
  wire [15:0] execResult_result_newRegs_47_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2553; // @[Jump.scala 26:19 31:20]
  wire [15:0] execResult_result_result_48_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2550; // @[Jump.scala 26:19 28:24]
  wire [15:0] _execResult_result_indirectAddrHigh_T_3 = {operand[15:8],8'h0}; // @[Cat.scala 33:92]
  wire [15:0] _execResult_result_indirectAddrHigh_T_5 = operand + 16'h1; // @[Jump.scala 90:19]
  wire [15:0] execResult_result_indirectAddrHigh = operand[7:0] == 8'hff ? _execResult_result_indirectAddrHigh_T_3 :
    _execResult_result_indirectAddrHigh_T_5; // @[Jump.scala 88:35]
  wire [15:0] _GEN_2584 = _execResult_result_T_30 ? execResult_result_indirectAddrHigh : 16'h0; // @[Jump.scala 63:19 57:20 91:24]
  wire [15:0] _GEN_2586 = _execResult_result_T_30 ? resetVector : regs_pc; // @[Jump.scala 52:13 63:19 93:20]
  wire [15:0] _GEN_2602 = _execResult_result_T_26 ? regs_pc : _GEN_2586; // @[Jump.scala 52:13 63:19]
  wire [15:0] _GEN_2619 = _execResult_result_T_21 ? _regs_pc_T_1 : _GEN_2602; // @[Jump.scala 63:19 77:20]
  wire [15:0] execResult_result_newRegs_48_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2619; // @[Jump.scala 63:19 69:20]
  wire [15:0] _GEN_2599 = _execResult_result_T_26 ? operand : _GEN_2584; // @[Jump.scala 63:19 82:24]
  wire [15:0] _GEN_2601 = _execResult_result_T_26 ? _execResult_result_result_operand_T_9 : operand; // @[Jump.scala 63:19 61:20 84:24]
  wire [15:0] _GEN_2616 = _execResult_result_T_21 ? regs_pc : _GEN_2599; // @[Jump.scala 63:19 74:24]
  wire [15:0] _GEN_2618 = _execResult_result_T_21 ? resetVector : _GEN_2601; // @[Jump.scala 63:19 76:24]
  wire [15:0] execResult_result_result_49_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2616; // @[Jump.scala 63:19 66:24]
  wire [15:0] execResult_result_result_49_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_2618; // @[Jump.scala 63:19 68:24]
  wire [15:0] execResult_result_returnAddr = regs_pc - 16'h1; // @[Jump.scala 136:34]
  wire [15:0] _GEN_2650 = _execResult_result_T_30 ? execResult_result_result_46_memAddr : 16'h0; // @[Jump.scala 117:19 111:20 147:24]
  wire [7:0] _GEN_2651 = _execResult_result_T_30 ? execResult_result_returnAddr[7:0] : 8'h0; // @[Jump.scala 117:19 112:20 148:24]
  wire [7:0] _GEN_2653 = _execResult_result_T_30 ? execResult_result_newRegs_45_sp : regs_sp; // @[Jump.scala 106:13 117:19 150:20]
  wire [15:0] _GEN_2654 = _execResult_result_T_30 ? operand : regs_pc; // @[Jump.scala 106:13 117:19 151:20]
  wire [7:0] _GEN_2670 = _execResult_result_T_26 ? execResult_result_newRegs_45_sp : _GEN_2653; // @[Jump.scala 117:19 140:20]
  wire [7:0] _GEN_2705 = _execResult_result_T_21 ? regs_sp : _GEN_2670; // @[Jump.scala 106:13 117:19]
  wire [7:0] execResult_result_newRegs_49_sp = _execResult_result_T_20 ? regs_sp : _GEN_2705; // @[Jump.scala 106:13 117:19]
  wire [15:0] _GEN_2684 = _execResult_result_T_26 ? regs_pc : _GEN_2654; // @[Jump.scala 106:13 117:19]
  wire [15:0] _GEN_2689 = _execResult_result_T_21 ? _regs_pc_T_1 : _GEN_2684; // @[Jump.scala 117:19 130:20]
  wire [15:0] execResult_result_newRegs_49_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2689; // @[Jump.scala 117:19 122:20]
  wire [15:0] _GEN_2667 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : _GEN_2650; // @[Jump.scala 117:19 137:24]
  wire [7:0] _GEN_2668 = _execResult_result_T_26 ? execResult_result_returnAddr[15:8] : _GEN_2651; // @[Jump.scala 117:19 138:24]
  wire [2:0] _GEN_2683 = _execResult_result_T_26 ? 3'h3 : execResult_result_result_6_nextCycle; // @[Jump.scala 117:19 109:22 142:26]
  wire [15:0] _GEN_2686 = _execResult_result_T_21 ? regs_pc : _GEN_2667; // @[Jump.scala 117:19 127:24]
  wire [2:0] _GEN_2702 = _execResult_result_T_21 ? 3'h2 : _GEN_2683; // @[Jump.scala 117:19 132:26]
  wire [7:0] _GEN_2703 = _execResult_result_T_21 ? 8'h0 : _GEN_2668; // @[Jump.scala 117:19 112:20]
  wire  _GEN_2704 = _execResult_result_T_21 ? 1'h0 : _GEN_304; // @[Jump.scala 117:19 113:21]
  wire [15:0] execResult_result_result_50_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_2686; // @[Jump.scala 117:19 119:24]
  wire [2:0] execResult_result_result_50_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_2702; // @[Jump.scala 117:19 124:26]
  wire [7:0] execResult_result_result_50_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2703; // @[Jump.scala 117:19 112:20]
  wire  execResult_result_result_50_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_2704; // @[Jump.scala 117:19 113:21]
  wire [15:0] _execResult_result_newRegs_pc_T_127 = resetVector + 16'h1; // @[Jump.scala 193:53]
  wire [15:0] _GEN_2728 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : 16'h0; // @[Jump.scala 175:19 169:20 190:24]
  wire [15:0] _GEN_2731 = _execResult_result_T_26 ? _execResult_result_newRegs_pc_T_127 : regs_pc; // @[Jump.scala 164:13 175:19 193:20]
  wire [7:0] _GEN_2747 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 164:13 175:19 185:20]
  wire [7:0] execResult_result_newRegs_50_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_2747; // @[Jump.scala 175:19 177:20]
  wire [15:0] _GEN_2761 = _execResult_result_T_21 ? regs_pc : _GEN_2731; // @[Jump.scala 164:13 175:19]
  wire [15:0] execResult_result_newRegs_50_pc = _execResult_result_T_20 ? regs_pc : _GEN_2761; // @[Jump.scala 164:13 175:19]
  wire [15:0] _GEN_2744 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2728; // @[Jump.scala 175:19 182:24]
  wire [15:0] _GEN_2746 = _execResult_result_T_21 ? {{8'd0}, io_memDataIn} : _GEN_305; // @[Jump.scala 175:19 184:24]
  wire [15:0] execResult_result_result_51_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2744; // @[Jump.scala 175:19 169:20]
  wire  execResult_result_result_51_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_237; // @[Jump.scala 175:19 172:20]
  wire [15:0] execResult_result_result_51_operand = _execResult_result_T_20 ? operand : _GEN_2746; // @[Jump.scala 175:19 173:20]
  wire [15:0] _GEN_2782 = 3'h5 == cycle ? 16'hffff : 16'h0; // @[Jump.scala 217:19 211:20 257:24]
  wire [15:0] _GEN_2784 = 3'h5 == cycle ? resetVector : regs_pc; // @[Jump.scala 206:13 217:19 259:20]
  wire [7:0] _GEN_2864 = _execResult_result_T_21 ? execResult_result_newRegs_45_sp : _GEN_2670; // @[Jump.scala 217:19 227:20]
  wire [7:0] execResult_result_newRegs_51_sp = _execResult_result_T_20 ? regs_sp : _GEN_2864; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2801 = _execResult_result_T_245 ? regs_pc : _GEN_2784; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2836 = _execResult_result_T_30 ? regs_pc : _GEN_2801; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2859 = _execResult_result_T_26 ? regs_pc : _GEN_2836; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2882 = _execResult_result_T_21 ? regs_pc : _GEN_2859; // @[Jump.scala 206:13 217:19]
  wire [15:0] execResult_result_newRegs_51_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2882; // @[Jump.scala 217:19 219:20]
  wire  _GEN_2819 = _execResult_result_T_30 | regs_flagI; // @[Jump.scala 206:13 217:19 245:23]
  wire  _GEN_2855 = _execResult_result_T_26 ? regs_flagI : _GEN_2819; // @[Jump.scala 206:13 217:19]
  wire  _GEN_2878 = _execResult_result_T_21 ? regs_flagI : _GEN_2855; // @[Jump.scala 206:13 217:19]
  wire  execResult_result_newRegs_51_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2878; // @[Jump.scala 206:13 217:19]
  wire [15:0] _GEN_2797 = _execResult_result_T_245 ? 16'hfffe : _GEN_2782; // @[Jump.scala 217:19 251:24]
  wire  _GEN_2798 = _execResult_result_T_245 | 3'h5 == cycle; // @[Jump.scala 217:19 252:24]
  wire [15:0] _GEN_2799 = _execResult_result_T_245 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 217:19 215:20 253:24]
  wire [2:0] _GEN_2800 = _execResult_result_T_245 ? 3'h5 : execResult_result_result_6_nextCycle; // @[Jump.scala 217:19 209:22 254:26]
  wire  _GEN_2814 = _execResult_result_T_245 ? 1'h0 : 3'h5 == cycle; // @[Jump.scala 208:17 217:19]
  wire [15:0] _GEN_2815 = _execResult_result_T_30 ? execResult_result_result_46_memAddr : _GEN_2797; // @[Jump.scala 217:19 241:24]
  wire [7:0] _GEN_2816 = _execResult_result_T_30 ? _execResult_result_pushData_T : 8'h0; // @[Jump.scala 217:19 212:20 242:24]
  wire [2:0] _GEN_2833 = _execResult_result_T_30 ? 3'h4 : _GEN_2800; // @[Jump.scala 217:19 248:26]
  wire  _GEN_2834 = _execResult_result_T_30 ? 1'h0 : _GEN_2798; // @[Jump.scala 217:19 214:20]
  wire [15:0] _GEN_2835 = _execResult_result_T_30 ? operand : _GEN_2799; // @[Jump.scala 217:19 215:20]
  wire  _GEN_2837 = _execResult_result_T_30 ? 1'h0 : _GEN_2814; // @[Jump.scala 208:17 217:19]
  wire [15:0] _GEN_2838 = _execResult_result_T_26 ? execResult_result_result_46_memAddr : _GEN_2815; // @[Jump.scala 217:19 232:24]
  wire [7:0] _GEN_2839 = _execResult_result_T_26 ? regs_pc[7:0] : _GEN_2816; // @[Jump.scala 217:19 233:24]
  wire [2:0] _GEN_2854 = _execResult_result_T_26 ? 3'h3 : _GEN_2833; // @[Jump.scala 217:19 237:26]
  wire  _GEN_2857 = _execResult_result_T_26 ? 1'h0 : _GEN_2834; // @[Jump.scala 217:19 214:20]
  wire [15:0] _GEN_2858 = _execResult_result_T_26 ? operand : _GEN_2835; // @[Jump.scala 217:19 215:20]
  wire  _GEN_2860 = _execResult_result_T_26 ? 1'h0 : _GEN_2837; // @[Jump.scala 208:17 217:19]
  wire [15:0] _GEN_2861 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2838; // @[Jump.scala 217:19 224:24]
  wire [7:0] _GEN_2862 = _execResult_result_T_21 ? regs_pc[15:8] : _GEN_2839; // @[Jump.scala 217:19 225:24]
  wire [2:0] _GEN_2877 = _execResult_result_T_21 ? 3'h2 : _GEN_2854; // @[Jump.scala 217:19 229:26]
  wire  _GEN_2880 = _execResult_result_T_21 ? 1'h0 : _GEN_2857; // @[Jump.scala 217:19 214:20]
  wire [15:0] _GEN_2881 = _execResult_result_T_21 ? operand : _GEN_2858; // @[Jump.scala 217:19 215:20]
  wire  _GEN_2883 = _execResult_result_T_21 ? 1'h0 : _GEN_2860; // @[Jump.scala 208:17 217:19]
  wire [2:0] execResult_result_result_52_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_2877; // @[Jump.scala 217:19 221:26]
  wire [15:0] execResult_result_result_52_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2861; // @[Jump.scala 217:19 211:20]
  wire [7:0] execResult_result_result_52_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2862; // @[Jump.scala 217:19 212:20]
  wire  execResult_result_result_52_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_325; // @[Jump.scala 217:19 213:21]
  wire  execResult_result_result_52_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_2880; // @[Jump.scala 217:19 214:20]
  wire [15:0] execResult_result_result_52_operand = _execResult_result_T_20 ? operand : _GEN_2881; // @[Jump.scala 217:19 215:20]
  wire  execResult_result_result_52_done = _execResult_result_T_20 ? 1'h0 : _GEN_2883; // @[Jump.scala 208:17 217:19]
  wire [7:0] _GEN_2925 = _execResult_result_T_26 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 272:13 283:19 306:20]
  wire [7:0] _GEN_2949 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : _GEN_2925; // @[Jump.scala 283:19 298:20]
  wire [7:0] execResult_result_newRegs_52_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_2949; // @[Jump.scala 283:19 285:20]
  wire [15:0] _GEN_2964 = _execResult_result_T_21 ? regs_pc : _GEN_2602; // @[Jump.scala 272:13 283:19]
  wire [15:0] execResult_result_newRegs_52_pc = _execResult_result_T_20 ? regs_pc : _GEN_2964; // @[Jump.scala 272:13 283:19]
  wire  _GEN_2943 = _execResult_result_T_21 ? io_memDataIn[0] : regs_flagC; // @[Jump.scala 272:13 283:19 292:23]
  wire  execResult_result_newRegs_52_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_2943; // @[Jump.scala 272:13 283:19]
  wire  _GEN_2944 = _execResult_result_T_21 ? io_memDataIn[1] : regs_flagZ; // @[Jump.scala 272:13 283:19 293:23]
  wire  execResult_result_newRegs_52_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2944; // @[Jump.scala 272:13 283:19]
  wire  _GEN_2945 = _execResult_result_T_21 ? io_memDataIn[2] : regs_flagI; // @[Jump.scala 272:13 283:19 294:23]
  wire  execResult_result_newRegs_52_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2945; // @[Jump.scala 272:13 283:19]
  wire  _GEN_2946 = _execResult_result_T_21 ? io_memDataIn[3] : regs_flagD; // @[Jump.scala 272:13 283:19 295:23]
  wire  execResult_result_newRegs_52_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_2946; // @[Jump.scala 272:13 283:19]
  wire [15:0] _GEN_2924 = _execResult_result_T_26 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 283:19 281:20 305:24]
  wire [15:0] _GEN_2941 = _execResult_result_T_21 ? execResult_result_result_46_memAddr : _GEN_2667; // @[Jump.scala 283:19 290:24]
  wire [15:0] _GEN_2963 = _execResult_result_T_21 ? operand : _GEN_2924; // @[Jump.scala 283:19 281:20]
  wire [15:0] execResult_result_result_53_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2941; // @[Jump.scala 283:19 277:20]
  wire [15:0] execResult_result_result_53_operand = _execResult_result_T_20 ? operand : _GEN_2963; // @[Jump.scala 283:19 281:20]
  wire  _GEN_2991 = 8'h40 == opcode & execResult_result_result_9_done; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire [2:0] _GEN_2992 = 8'h40 == opcode ? execResult_result_result_50_nextCycle : 3'h0; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire [7:0] _GEN_2996 = 8'h40 == opcode ? execResult_result_newRegs_52_sp : regs_sp; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire [15:0] _GEN_2997 = 8'h40 == opcode ? execResult_result_newRegs_52_pc : regs_pc; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire  _GEN_2998 = 8'h40 == opcode ? execResult_result_newRegs_52_flagC : regs_flagC; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire  _GEN_2999 = 8'h40 == opcode ? execResult_result_newRegs_52_flagZ : regs_flagZ; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire  _GEN_3000 = 8'h40 == opcode ? execResult_result_newRegs_52_flagI : regs_flagI; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire  _GEN_3001 = 8'h40 == opcode ? execResult_result_newRegs_52_flagD : regs_flagD; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire  _GEN_3003 = 8'h40 == opcode ? execResult_result_newRegs_16_flagV : regs_flagV; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire  _GEN_3004 = 8'h40 == opcode ? execResult_result_newRegs_16_flagN : regs_flagN; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire [15:0] _GEN_3005 = 8'h40 == opcode ? execResult_result_result_53_memAddr : 16'h0; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire  _GEN_3008 = 8'h40 == opcode & execResult_result_result_52_memWrite; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire [15:0] _GEN_3009 = 8'h40 == opcode ? execResult_result_result_53_operand : operand; // @[CPU6502Core.scala 235:12 237:20 472:27]
  wire  _GEN_3010 = 8'h0 == opcode ? execResult_result_result_52_done : _GEN_2991; // @[CPU6502Core.scala 237:20 471:27]
  wire [2:0] _GEN_3011 = 8'h0 == opcode ? execResult_result_result_52_nextCycle : _GEN_2992; // @[CPU6502Core.scala 237:20 471:27]
  wire [7:0] _GEN_3015 = 8'h0 == opcode ? execResult_result_newRegs_51_sp : _GEN_2996; // @[CPU6502Core.scala 237:20 471:27]
  wire [15:0] _GEN_3016 = 8'h0 == opcode ? execResult_result_newRegs_51_pc : _GEN_2997; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3017 = 8'h0 == opcode ? regs_flagC : _GEN_2998; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3018 = 8'h0 == opcode ? regs_flagZ : _GEN_2999; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3019 = 8'h0 == opcode ? execResult_result_newRegs_51_flagI : _GEN_3000; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3020 = 8'h0 == opcode ? regs_flagD : _GEN_3001; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3022 = 8'h0 == opcode ? regs_flagV : _GEN_3003; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3023 = 8'h0 == opcode ? regs_flagN : _GEN_3004; // @[CPU6502Core.scala 237:20 471:27]
  wire [15:0] _GEN_3024 = 8'h0 == opcode ? execResult_result_result_52_memAddr : _GEN_3005; // @[CPU6502Core.scala 237:20 471:27]
  wire [7:0] _GEN_3025 = 8'h0 == opcode ? execResult_result_result_52_memData : 8'h0; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3026 = 8'h0 == opcode & execResult_result_result_52_memWrite; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3027 = 8'h0 == opcode ? execResult_result_result_52_memRead : _GEN_3008; // @[CPU6502Core.scala 237:20 471:27]
  wire [15:0] _GEN_3028 = 8'h0 == opcode ? execResult_result_result_52_operand : _GEN_3009; // @[CPU6502Core.scala 237:20 471:27]
  wire  _GEN_3029 = 8'h60 == opcode ? execResult_result_result_8_done : _GEN_3010; // @[CPU6502Core.scala 237:20 470:27]
  wire [2:0] _GEN_3030 = 8'h60 == opcode ? execResult_result_result_11_nextCycle : _GEN_3011; // @[CPU6502Core.scala 237:20 470:27]
  wire [7:0] _GEN_3034 = 8'h60 == opcode ? execResult_result_newRegs_50_sp : _GEN_3015; // @[CPU6502Core.scala 237:20 470:27]
  wire [15:0] _GEN_3035 = 8'h60 == opcode ? execResult_result_newRegs_50_pc : _GEN_3016; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3036 = 8'h60 == opcode ? regs_flagC : _GEN_3017; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3037 = 8'h60 == opcode ? regs_flagZ : _GEN_3018; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3038 = 8'h60 == opcode ? regs_flagI : _GEN_3019; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3039 = 8'h60 == opcode ? regs_flagD : _GEN_3020; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3041 = 8'h60 == opcode ? regs_flagV : _GEN_3022; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3042 = 8'h60 == opcode ? regs_flagN : _GEN_3023; // @[CPU6502Core.scala 237:20 470:27]
  wire [15:0] _GEN_3043 = 8'h60 == opcode ? execResult_result_result_51_memAddr : _GEN_3024; // @[CPU6502Core.scala 237:20 470:27]
  wire [7:0] _GEN_3044 = 8'h60 == opcode ? 8'h0 : _GEN_3025; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3045 = 8'h60 == opcode ? 1'h0 : _GEN_3026; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3046 = 8'h60 == opcode ? execResult_result_result_51_memRead : _GEN_3027; // @[CPU6502Core.scala 237:20 470:27]
  wire [15:0] _GEN_3047 = 8'h60 == opcode ? execResult_result_result_51_operand : _GEN_3028; // @[CPU6502Core.scala 237:20 470:27]
  wire  _GEN_3048 = 8'h20 == opcode ? execResult_result_result_9_done : _GEN_3029; // @[CPU6502Core.scala 237:20 469:27]
  wire [2:0] _GEN_3049 = 8'h20 == opcode ? execResult_result_result_50_nextCycle : _GEN_3030; // @[CPU6502Core.scala 237:20 469:27]
  wire [7:0] _GEN_3053 = 8'h20 == opcode ? execResult_result_newRegs_49_sp : _GEN_3034; // @[CPU6502Core.scala 237:20 469:27]
  wire [15:0] _GEN_3054 = 8'h20 == opcode ? execResult_result_newRegs_49_pc : _GEN_3035; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3055 = 8'h20 == opcode ? regs_flagC : _GEN_3036; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3056 = 8'h20 == opcode ? regs_flagZ : _GEN_3037; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3057 = 8'h20 == opcode ? regs_flagI : _GEN_3038; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3058 = 8'h20 == opcode ? regs_flagD : _GEN_3039; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3060 = 8'h20 == opcode ? regs_flagV : _GEN_3041; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3061 = 8'h20 == opcode ? regs_flagN : _GEN_3042; // @[CPU6502Core.scala 237:20 469:27]
  wire [15:0] _GEN_3062 = 8'h20 == opcode ? execResult_result_result_50_memAddr : _GEN_3043; // @[CPU6502Core.scala 237:20 469:27]
  wire [7:0] _GEN_3063 = 8'h20 == opcode ? execResult_result_result_50_memData : _GEN_3044; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3064 = 8'h20 == opcode ? execResult_result_result_50_memWrite : _GEN_3045; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3065 = 8'h20 == opcode ? execResult_result_result_6_memRead : _GEN_3046; // @[CPU6502Core.scala 237:20 469:27]
  wire [15:0] _GEN_3066 = 8'h20 == opcode ? execResult_result_result_8_operand : _GEN_3047; // @[CPU6502Core.scala 237:20 469:27]
  wire  _GEN_3067 = 8'h6c == opcode ? execResult_result_result_9_done : _GEN_3048; // @[CPU6502Core.scala 237:20 468:27]
  wire [2:0] _GEN_3068 = 8'h6c == opcode ? execResult_result_result_6_nextCycle : _GEN_3049; // @[CPU6502Core.scala 237:20 468:27]
  wire [7:0] _GEN_3072 = 8'h6c == opcode ? regs_sp : _GEN_3053; // @[CPU6502Core.scala 237:20 468:27]
  wire [15:0] _GEN_3073 = 8'h6c == opcode ? execResult_result_newRegs_48_pc : _GEN_3054; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3074 = 8'h6c == opcode ? regs_flagC : _GEN_3055; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3075 = 8'h6c == opcode ? regs_flagZ : _GEN_3056; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3076 = 8'h6c == opcode ? regs_flagI : _GEN_3057; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3077 = 8'h6c == opcode ? regs_flagD : _GEN_3058; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3079 = 8'h6c == opcode ? regs_flagV : _GEN_3060; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3080 = 8'h6c == opcode ? regs_flagN : _GEN_3061; // @[CPU6502Core.scala 237:20 468:27]
  wire [15:0] _GEN_3081 = 8'h6c == opcode ? execResult_result_result_49_memAddr : _GEN_3062; // @[CPU6502Core.scala 237:20 468:27]
  wire [7:0] _GEN_3082 = 8'h6c == opcode ? 8'h0 : _GEN_3063; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3083 = 8'h6c == opcode ? 1'h0 : _GEN_3064; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3084 = 8'h6c == opcode ? execResult_result_result_9_memRead : _GEN_3065; // @[CPU6502Core.scala 237:20 468:27]
  wire [15:0] _GEN_3085 = 8'h6c == opcode ? execResult_result_result_49_operand : _GEN_3066; // @[CPU6502Core.scala 237:20 468:27]
  wire  _GEN_3086 = 8'h4c == opcode ? execResult_result_result_6_done : _GEN_3067; // @[CPU6502Core.scala 237:20 467:27]
  wire [2:0] _GEN_3087 = 8'h4c == opcode ? execResult_result_result_17_nextCycle : _GEN_3068; // @[CPU6502Core.scala 237:20 467:27]
  wire [7:0] _GEN_3091 = 8'h4c == opcode ? regs_sp : _GEN_3072; // @[CPU6502Core.scala 237:20 467:27]
  wire [15:0] _GEN_3092 = 8'h4c == opcode ? execResult_result_newRegs_47_pc : _GEN_3073; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3093 = 8'h4c == opcode ? regs_flagC : _GEN_3074; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3094 = 8'h4c == opcode ? regs_flagZ : _GEN_3075; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3095 = 8'h4c == opcode ? regs_flagI : _GEN_3076; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3096 = 8'h4c == opcode ? regs_flagD : _GEN_3077; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3098 = 8'h4c == opcode ? regs_flagV : _GEN_3079; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3099 = 8'h4c == opcode ? regs_flagN : _GEN_3080; // @[CPU6502Core.scala 237:20 467:27]
  wire [15:0] _GEN_3100 = 8'h4c == opcode ? execResult_result_result_48_memAddr : _GEN_3081; // @[CPU6502Core.scala 237:20 467:27]
  wire [7:0] _GEN_3101 = 8'h4c == opcode ? 8'h0 : _GEN_3082; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3102 = 8'h4c == opcode ? 1'h0 : _GEN_3083; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3103 = 8'h4c == opcode ? execResult_result_result_6_memRead : _GEN_3084; // @[CPU6502Core.scala 237:20 467:27]
  wire [15:0] _GEN_3104 = 8'h4c == opcode ? execResult_result_result_8_operand : _GEN_3085; // @[CPU6502Core.scala 237:20 467:27]
  wire  _GEN_3105 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_6_done : _GEN_3086; // @[CPU6502Core.scala 237:20 463:16]
  wire [2:0] _GEN_3106 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_17_nextCycle : _GEN_3087; // @[CPU6502Core.scala 237:20 463:16]
  wire [7:0] _GEN_3107 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_a : regs_a; // @[CPU6502Core.scala 237:20 463:16]
  wire [7:0] _GEN_3110 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_sp : _GEN_3091; // @[CPU6502Core.scala 237:20 463:16]
  wire [15:0] _GEN_3111 = 8'h68 == opcode | 8'h28 == opcode ? regs_pc : _GEN_3092; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3112 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagC : _GEN_3093; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3113 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagZ : _GEN_3094; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3114 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagI : _GEN_3095; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3115 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagD : _GEN_3096; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3117 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagV : _GEN_3098; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3118 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_46_flagN : _GEN_3099; // @[CPU6502Core.scala 237:20 463:16]
  wire [15:0] _GEN_3119 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_47_memAddr : _GEN_3100; // @[CPU6502Core.scala 237:20 463:16]
  wire [7:0] _GEN_3120 = 8'h68 == opcode | 8'h28 == opcode ? 8'h0 : _GEN_3101; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3121 = 8'h68 == opcode | 8'h28 == opcode ? 1'h0 : _GEN_3102; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3122 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_6_done : _GEN_3103; // @[CPU6502Core.scala 237:20 463:16]
  wire [15:0] _GEN_3123 = 8'h68 == opcode | 8'h28 == opcode ? 16'h0 : _GEN_3104; // @[CPU6502Core.scala 237:20 463:16]
  wire  _GEN_3124 = 8'h48 == opcode | 8'h8 == opcode | _GEN_3105; // @[CPU6502Core.scala 237:20 458:16]
  wire [2:0] _GEN_3125 = 8'h48 == opcode | 8'h8 == opcode ? 3'h0 : _GEN_3106; // @[CPU6502Core.scala 237:20 458:16]
  wire [7:0] _GEN_3126 = 8'h48 == opcode | 8'h8 == opcode ? regs_a : _GEN_3107; // @[CPU6502Core.scala 237:20 458:16]
  wire [7:0] _GEN_3129 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_newRegs_45_sp : _GEN_3110; // @[CPU6502Core.scala 237:20 458:16]
  wire [15:0] _GEN_3130 = 8'h48 == opcode | 8'h8 == opcode ? regs_pc : _GEN_3111; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3131 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagC : _GEN_3112; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3132 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagZ : _GEN_3113; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3133 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagI : _GEN_3114; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3134 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagD : _GEN_3115; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3136 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagV : _GEN_3117; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3137 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagN : _GEN_3118; // @[CPU6502Core.scala 237:20 458:16]
  wire [15:0] _GEN_3138 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_result_46_memAddr : _GEN_3119; // @[CPU6502Core.scala 237:20 458:16]
  wire [7:0] _GEN_3139 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_pushData : _GEN_3120; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3140 = 8'h48 == opcode | 8'h8 == opcode | _GEN_3121; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3141 = 8'h48 == opcode | 8'h8 == opcode ? 1'h0 : _GEN_3122; // @[CPU6502Core.scala 237:20 458:16]
  wire [15:0] _GEN_3142 = 8'h48 == opcode | 8'h8 == opcode ? 16'h0 : _GEN_3123; // @[CPU6502Core.scala 237:20 458:16]
  wire  _GEN_3143 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_44_done : _GEN_3124; // @[CPU6502Core.scala 237:20 453:16]
  wire [2:0] _GEN_3144 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3125; // @[CPU6502Core.scala 237:20 453:16]
  wire [7:0] _GEN_3145 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_a : _GEN_3126; // @[CPU6502Core.scala 237:20 453:16]
  wire [7:0] _GEN_3148 = 8'h91 == opcode | 8'hb1 == opcode ? regs_sp : _GEN_3129; // @[CPU6502Core.scala 237:20 453:16]
  wire [15:0] _GEN_3149 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3130; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3150 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagC : _GEN_3131; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3151 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_flagZ : _GEN_3132; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3152 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagI : _GEN_3133; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3153 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagD : _GEN_3134; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3155 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagV : _GEN_3136; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3156 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_44_flagN : _GEN_3137; // @[CPU6502Core.scala 237:20 453:16]
  wire [15:0] _GEN_3157 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memAddr : _GEN_3138; // @[CPU6502Core.scala 237:20 453:16]
  wire [7:0] _GEN_3158 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memData : _GEN_3139; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3159 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memWrite : _GEN_3140; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3160 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_45_memRead : _GEN_3141; // @[CPU6502Core.scala 237:20 453:16]
  wire [15:0] _GEN_3161 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_36_operand : _GEN_3142; // @[CPU6502Core.scala 237:20 453:16]
  wire  _GEN_3162 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_done : _GEN_3143; // @[CPU6502Core.scala 237:20 448:16]
  wire [2:0] _GEN_3163 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_6_nextCycle : _GEN_3144; // @[CPU6502Core.scala 237:20 448:16]
  wire [7:0] _GEN_3164 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_a : _GEN_3145; // @[CPU6502Core.scala 237:20 448:16]
  wire [7:0] _GEN_3167 = 8'ha1 == opcode | 8'h81 == opcode ? regs_sp : _GEN_3148; // @[CPU6502Core.scala 237:20 448:16]
  wire [15:0] _GEN_3168 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_5_pc : _GEN_3149; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3169 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagC : _GEN_3150; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3170 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_flagZ : _GEN_3151; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3171 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagI : _GEN_3152; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3172 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagD : _GEN_3153; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3174 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagV : _GEN_3155; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3175 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_43_flagN : _GEN_3156; // @[CPU6502Core.scala 237:20 448:16]
  wire [15:0] _GEN_3176 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_9_memAddr : _GEN_3157; // @[CPU6502Core.scala 237:20 448:16]
  wire [7:0] _GEN_3177 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memData : _GEN_3158; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3178 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memWrite : _GEN_3159; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3179 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_44_memRead : _GEN_3160; // @[CPU6502Core.scala 237:20 448:16]
  wire [15:0] _GEN_3180 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_9_operand : _GEN_3161; // @[CPU6502Core.scala 237:20 448:16]
  wire  _GEN_3181 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_8_done : _GEN_3162; // @[CPU6502Core.scala 237:20 443:16]
  wire [2:0] _GEN_3182 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_11_nextCycle : _GEN_3163; // @[CPU6502Core.scala 237:20 443:16]
  wire [7:0] _GEN_3183 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_42_a : _GEN_3164; // @[CPU6502Core.scala 237:20 443:16]
  wire [7:0] _GEN_3186 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? regs_sp : _GEN_3167; // @[CPU6502Core.scala 237:20 443:16]
  wire [15:0] _GEN_3187 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3168; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3188 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagC : _GEN_3169; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3189 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_42_flagZ : _GEN_3170; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3190 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagI : _GEN_3171; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3191 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagD : _GEN_3172; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3193 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagV : _GEN_3174; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3194 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_42_flagN : _GEN_3175; // @[CPU6502Core.scala 237:20 443:16]
  wire [15:0] _GEN_3195 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_8_memAddr : _GEN_3176; // @[CPU6502Core.scala 237:20 443:16]
  wire [7:0] _GEN_3196 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? 8'h0 : _GEN_3177; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3197 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? 1'h0 : _GEN_3178; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3198 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_8_memRead : _GEN_3179; // @[CPU6502Core.scala 237:20 443:16]
  wire [15:0] _GEN_3199 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_43_operand : _GEN_3180; // @[CPU6502Core.scala 237:20 443:16]
  wire  _GEN_3200 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_8_done : _GEN_3181; // @[CPU6502Core.scala 237:20 438:16]
  wire [2:0] _GEN_3201 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_11_nextCycle : _GEN_3182; // @[CPU6502Core.scala 237:20 438:16]
  wire [7:0] _GEN_3202 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_a : _GEN_3183; // @[CPU6502Core.scala 237:20 438:16]
  wire [7:0] _GEN_3203 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_x : regs_x; // @[CPU6502Core.scala 237:20 438:16]
  wire [7:0] _GEN_3204 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_41_y : regs_y; // @[CPU6502Core.scala 237:20 438:16]
  wire [7:0] _GEN_3205 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? regs_sp : _GEN_3186; // @[CPU6502Core.scala 237:20 438:16]
  wire [15:0] _GEN_3206 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3187; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3207 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagC : _GEN_3188; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3208 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_41_flagZ : _GEN_3189; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3209 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagI : _GEN_3190; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3210 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagD : _GEN_3191; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3212 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagV : _GEN_3193; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3213 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_41_flagN : _GEN_3194; // @[CPU6502Core.scala 237:20 438:16]
  wire [15:0] _GEN_3214 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_8_memAddr : _GEN_3195; // @[CPU6502Core.scala 237:20 438:16]
  wire [7:0] _GEN_3215 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_42_memData : _GEN_3196; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3216 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_memWrite : _GEN_3197; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3217 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_42_memRead : _GEN_3198; // @[CPU6502Core.scala 237:20 438:16]
  wire [15:0] _GEN_3218 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_8_operand : _GEN_3199; // @[CPU6502Core.scala 237:20 438:16]
  wire  _GEN_3219 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_done : _GEN_3200; // @[CPU6502Core.scala 237:20 433:16]
  wire [2:0] _GEN_3220 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_nextCycle : _GEN_3201; // @[CPU6502Core.scala 237:20 433:16]
  wire [7:0] _GEN_3221 = 8'hb6 == opcode | 8'h96 == opcode ? regs_a : _GEN_3202; // @[CPU6502Core.scala 237:20 433:16]
  wire [7:0] _GEN_3222 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_x : _GEN_3203; // @[CPU6502Core.scala 237:20 433:16]
  wire [7:0] _GEN_3223 = 8'hb6 == opcode | 8'h96 == opcode ? regs_y : _GEN_3204; // @[CPU6502Core.scala 237:20 433:16]
  wire [7:0] _GEN_3224 = 8'hb6 == opcode | 8'h96 == opcode ? regs_sp : _GEN_3205; // @[CPU6502Core.scala 237:20 433:16]
  wire [15:0] _GEN_3225 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_5_pc : _GEN_3206; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3226 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagC : _GEN_3207; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3227 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_flagZ : _GEN_3208; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3228 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagI : _GEN_3209; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3229 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagD : _GEN_3210; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3231 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagV : _GEN_3212; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3232 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_40_flagN : _GEN_3213; // @[CPU6502Core.scala 237:20 433:16]
  wire [15:0] _GEN_3233 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_6_memAddr : _GEN_3214; // @[CPU6502Core.scala 237:20 433:16]
  wire [7:0] _GEN_3234 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memData : _GEN_3215; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3235 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memWrite : _GEN_3216; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3236 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_memRead : _GEN_3217; // @[CPU6502Core.scala 237:20 433:16]
  wire [15:0] _GEN_3237 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_41_operand : _GEN_3218; // @[CPU6502Core.scala 237:20 433:16]
  wire  _GEN_3238 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_6_done : _GEN_3219; // @[CPU6502Core.scala 237:20 428:16]
  wire [2:0] _GEN_3239 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_17_nextCycle : _GEN_3220; // @[CPU6502Core.scala 237:20 428:16]
  wire [7:0] _GEN_3240 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_a : _GEN_3221; // @[CPU6502Core.scala 237:20 428:16]
  wire [7:0] _GEN_3241 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_x : _GEN_3222; // @[CPU6502Core.scala 237:20 428:16]
  wire [7:0] _GEN_3242 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_y : _GEN_3223; // @[CPU6502Core.scala 237:20 428:16]
  wire [7:0] _GEN_3243 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_sp : _GEN_3224; // @[CPU6502Core.scala 237:20 428:16]
  wire [15:0] _GEN_3244 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3225; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3245 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagC : _GEN_3226; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3246 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_flagZ : _GEN_3227; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3247 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagI : _GEN_3228; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3248 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagD : _GEN_3229; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3250 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagV : _GEN_3231; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3251 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_39_flagN : _GEN_3232; // @[CPU6502Core.scala 237:20 428:16]
  wire [15:0] _GEN_3252 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_6_memAddr : _GEN_3233; // @[CPU6502Core.scala 237:20 428:16]
  wire [7:0] _GEN_3253 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memData : _GEN_3234; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3254 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memWrite : _GEN_3235; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3255 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_40_memRead : _GEN_3236; // @[CPU6502Core.scala 237:20 428:16]
  wire [15:0] _GEN_3256 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_7_operand : _GEN_3237; // @[CPU6502Core.scala 237:20 428:16]
  wire  _GEN_3257 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_6_done : _GEN_3238; // @[CPU6502Core.scala 237:20 423:16]
  wire [2:0] _GEN_3258 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_17_nextCycle : _GEN_3239; // @[CPU6502Core.scala 237:20 423:16]
  wire [7:0] _GEN_3259 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_a : _GEN_3240; // @[CPU6502Core.scala 237:20 423:16]
  wire [7:0] _GEN_3260 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_x : _GEN_3241; // @[CPU6502Core.scala 237:20 423:16]
  wire [7:0] _GEN_3261 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_38_y : _GEN_3242; // @[CPU6502Core.scala 237:20 423:16]
  wire [7:0] _GEN_3262 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? regs_sp : _GEN_3243; // @[CPU6502Core.scala 237:20 423:16]
  wire [15:0] _GEN_3263 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_5_pc : _GEN_3244; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3264 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagC : _GEN_3245; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3265 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_38_flagZ : _GEN_3246; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3266 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagI : _GEN_3247; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3267 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagD : _GEN_3248; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3269 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagV : _GEN_3250; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3270 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_38_flagN : _GEN_3251; // @[CPU6502Core.scala 237:20 423:16]
  wire [15:0] _GEN_3271 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_memAddr : _GEN_3252; // @[CPU6502Core.scala 237:20 423:16]
  wire [7:0] _GEN_3272 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_39_memData : _GEN_3253; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3273 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_39_memWrite : _GEN_3254; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3274 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_39_memRead : _GEN_3255; // @[CPU6502Core.scala 237:20 423:16]
  wire [15:0] _GEN_3275 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_operand : _GEN_3256; // @[CPU6502Core.scala 237:20 423:16]
  wire  _GEN_3276 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_result_38_done : _GEN_3257; // @[CPU6502Core.scala 237:20 418:16]
  wire [2:0] execResult_result_result_38_nextCycle = {{2'd0}, _T_5}; // @[LoadStore.scala 25:22]
  wire [2:0] _GEN_3277 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_result_38_nextCycle :
    _GEN_3258; // @[CPU6502Core.scala 237:20 418:16]
  wire [7:0] _GEN_3278 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_result_38_regs_a :
    _GEN_3259; // @[CPU6502Core.scala 237:20 418:16]
  wire [7:0] _GEN_3279 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_result_38_regs_x :
    _GEN_3260; // @[CPU6502Core.scala 237:20 418:16]
  wire [7:0] _GEN_3280 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_result_38_regs_y :
    _GEN_3261; // @[CPU6502Core.scala 237:20 418:16]
  wire [7:0] _GEN_3281 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_sp : _GEN_3262; // @[CPU6502Core.scala 237:20 418:16]
  wire [15:0] _GEN_3282 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_result_38_regs_pc :
    _GEN_3263; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3283 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagC : _GEN_3264; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3284 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_result_38_regs_flagZ :
    _GEN_3265; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3285 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagI : _GEN_3266; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3286 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagD : _GEN_3267; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3288 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagV : _GEN_3269; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3289 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_result_38_regs_flagN :
    _GEN_3270; // @[CPU6502Core.scala 237:20 418:16]
  wire [15:0] _GEN_3290 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_pc : _GEN_3271; // @[CPU6502Core.scala 237:20 418:16]
  wire [7:0] _GEN_3291 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 8'h0 : _GEN_3272; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3292 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 1'h0 : _GEN_3273; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3293 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? _T_5 : _GEN_3274; // @[CPU6502Core.scala 237:20 418:16]
  wire [15:0] _GEN_3294 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 16'h0 : _GEN_3275; // @[CPU6502Core.scala 237:20 418:16]
  wire  _GEN_3295 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_3276; // @[CPU6502Core.scala 237:20 412:16]
  wire [2:0] _GEN_3296 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 3'h0 : _GEN_3277; // @[CPU6502Core.scala 237:20 412:16]
  wire [7:0] _GEN_3297 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_a : _GEN_3278; // @[CPU6502Core.scala 237:20 412:16]
  wire [7:0] _GEN_3298 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_x : _GEN_3279; // @[CPU6502Core.scala 237:20 412:16]
  wire [7:0] _GEN_3299 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_y : _GEN_3280; // @[CPU6502Core.scala 237:20 412:16]
  wire [7:0] _GEN_3300 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_sp : _GEN_3281; // @[CPU6502Core.scala 237:20 412:16]
  wire [15:0] _GEN_3301 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? execResult_result_newRegs_36_pc : _GEN_3282; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3302 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagC : _GEN_3283; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3303 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagZ : _GEN_3284; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3304 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagI : _GEN_3285; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3305 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagD : _GEN_3286; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3307 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagV : _GEN_3288; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3308 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagN : _GEN_3289; // @[CPU6502Core.scala 237:20 412:16]
  wire [15:0] _GEN_3309 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_pc : _GEN_3290; // @[CPU6502Core.scala 237:20 412:16]
  wire [7:0] _GEN_3310 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 8'h0 : _GEN_3291; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3311 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? 1'h0 : _GEN_3292; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3312 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_3293; // @[CPU6502Core.scala 237:20 412:16]
  wire [15:0] _GEN_3313 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 16'h0 : _GEN_3294; // @[CPU6502Core.scala 237:20 412:16]
  wire  _GEN_3314 = 8'hd2 == opcode ? execResult_result_result_9_done : _GEN_3295; // @[CPU6502Core.scala 237:20 407:16]
  wire [2:0] _GEN_3315 = 8'hd2 == opcode ? execResult_result_result_6_nextCycle : _GEN_3296; // @[CPU6502Core.scala 237:20 407:16]
  wire [7:0] _GEN_3316 = 8'hd2 == opcode ? regs_a : _GEN_3297; // @[CPU6502Core.scala 237:20 407:16]
  wire [7:0] _GEN_3317 = 8'hd2 == opcode ? regs_x : _GEN_3298; // @[CPU6502Core.scala 237:20 407:16]
  wire [7:0] _GEN_3318 = 8'hd2 == opcode ? regs_y : _GEN_3299; // @[CPU6502Core.scala 237:20 407:16]
  wire [7:0] _GEN_3319 = 8'hd2 == opcode ? regs_sp : _GEN_3300; // @[CPU6502Core.scala 237:20 407:16]
  wire [15:0] _GEN_3320 = 8'hd2 == opcode ? execResult_result_newRegs_5_pc : _GEN_3301; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3321 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3302; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3322 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3303; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3323 = 8'hd2 == opcode ? regs_flagI : _GEN_3304; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3324 = 8'hd2 == opcode ? regs_flagD : _GEN_3305; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3326 = 8'hd2 == opcode ? regs_flagV : _GEN_3307; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3327 = 8'hd2 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3308; // @[CPU6502Core.scala 237:20 407:16]
  wire [15:0] _GEN_3328 = 8'hd2 == opcode ? execResult_result_result_9_memAddr : _GEN_3309; // @[CPU6502Core.scala 237:20 407:16]
  wire [7:0] _GEN_3329 = 8'hd2 == opcode ? 8'h0 : _GEN_3310; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3330 = 8'hd2 == opcode ? 1'h0 : _GEN_3311; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3331 = 8'hd2 == opcode ? execResult_result_result_9_memRead : _GEN_3312; // @[CPU6502Core.scala 237:20 407:16]
  wire [15:0] _GEN_3332 = 8'hd2 == opcode ? execResult_result_result_36_operand : _GEN_3313; // @[CPU6502Core.scala 237:20 407:16]
  wire  _GEN_3333 = 8'hd1 == opcode ? execResult_result_result_9_done : _GEN_3314; // @[CPU6502Core.scala 237:20 402:16]
  wire [2:0] _GEN_3334 = 8'hd1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3315; // @[CPU6502Core.scala 237:20 402:16]
  wire [7:0] _GEN_3335 = 8'hd1 == opcode ? regs_a : _GEN_3316; // @[CPU6502Core.scala 237:20 402:16]
  wire [7:0] _GEN_3336 = 8'hd1 == opcode ? regs_x : _GEN_3317; // @[CPU6502Core.scala 237:20 402:16]
  wire [7:0] _GEN_3337 = 8'hd1 == opcode ? regs_y : _GEN_3318; // @[CPU6502Core.scala 237:20 402:16]
  wire [7:0] _GEN_3338 = 8'hd1 == opcode ? regs_sp : _GEN_3319; // @[CPU6502Core.scala 237:20 402:16]
  wire [15:0] _GEN_3339 = 8'hd1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3320; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3340 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3321; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3341 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3322; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3342 = 8'hd1 == opcode ? regs_flagI : _GEN_3323; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3343 = 8'hd1 == opcode ? regs_flagD : _GEN_3324; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3345 = 8'hd1 == opcode ? regs_flagV : _GEN_3326; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3346 = 8'hd1 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3327; // @[CPU6502Core.scala 237:20 402:16]
  wire [15:0] _GEN_3347 = 8'hd1 == opcode ? execResult_result_result_9_memAddr : _GEN_3328; // @[CPU6502Core.scala 237:20 402:16]
  wire [7:0] _GEN_3348 = 8'hd1 == opcode ? 8'h0 : _GEN_3329; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3349 = 8'hd1 == opcode ? 1'h0 : _GEN_3330; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3350 = 8'hd1 == opcode ? execResult_result_result_9_memRead : _GEN_3331; // @[CPU6502Core.scala 237:20 402:16]
  wire [15:0] _GEN_3351 = 8'hd1 == opcode ? execResult_result_result_10_operand : _GEN_3332; // @[CPU6502Core.scala 237:20 402:16]
  wire  _GEN_3352 = 8'hc1 == opcode ? execResult_result_result_9_done : _GEN_3333; // @[CPU6502Core.scala 237:20 397:16]
  wire [2:0] _GEN_3353 = 8'hc1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3334; // @[CPU6502Core.scala 237:20 397:16]
  wire [7:0] _GEN_3354 = 8'hc1 == opcode ? regs_a : _GEN_3335; // @[CPU6502Core.scala 237:20 397:16]
  wire [7:0] _GEN_3355 = 8'hc1 == opcode ? regs_x : _GEN_3336; // @[CPU6502Core.scala 237:20 397:16]
  wire [7:0] _GEN_3356 = 8'hc1 == opcode ? regs_y : _GEN_3337; // @[CPU6502Core.scala 237:20 397:16]
  wire [7:0] _GEN_3357 = 8'hc1 == opcode ? regs_sp : _GEN_3338; // @[CPU6502Core.scala 237:20 397:16]
  wire [15:0] _GEN_3358 = 8'hc1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3339; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3359 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagC : _GEN_3340; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3360 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_3341; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3361 = 8'hc1 == opcode ? regs_flagI : _GEN_3342; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3362 = 8'hc1 == opcode ? regs_flagD : _GEN_3343; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3364 = 8'hc1 == opcode ? regs_flagV : _GEN_3345; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3365 = 8'hc1 == opcode ? execResult_result_newRegs_33_flagN : _GEN_3346; // @[CPU6502Core.scala 237:20 397:16]
  wire [15:0] _GEN_3366 = 8'hc1 == opcode ? execResult_result_result_9_memAddr : _GEN_3347; // @[CPU6502Core.scala 237:20 397:16]
  wire [7:0] _GEN_3367 = 8'hc1 == opcode ? 8'h0 : _GEN_3348; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3368 = 8'hc1 == opcode ? 1'h0 : _GEN_3349; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3369 = 8'hc1 == opcode ? execResult_result_result_9_memRead : _GEN_3350; // @[CPU6502Core.scala 237:20 397:16]
  wire [15:0] _GEN_3370 = 8'hc1 == opcode ? execResult_result_result_9_operand : _GEN_3351; // @[CPU6502Core.scala 237:20 397:16]
  wire  _GEN_3371 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_done : _GEN_3352; // @[CPU6502Core.scala 237:20 392:16]
  wire [2:0] _GEN_3372 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_6_nextCycle : _GEN_3353; // @[CPU6502Core.scala 237:20 392:16]
  wire [7:0] _GEN_3373 = 8'hdd == opcode | 8'hd9 == opcode ? regs_a : _GEN_3354; // @[CPU6502Core.scala 237:20 392:16]
  wire [7:0] _GEN_3374 = 8'hdd == opcode | 8'hd9 == opcode ? regs_x : _GEN_3355; // @[CPU6502Core.scala 237:20 392:16]
  wire [7:0] _GEN_3375 = 8'hdd == opcode | 8'hd9 == opcode ? regs_y : _GEN_3356; // @[CPU6502Core.scala 237:20 392:16]
  wire [7:0] _GEN_3376 = 8'hdd == opcode | 8'hd9 == opcode ? regs_sp : _GEN_3357; // @[CPU6502Core.scala 237:20 392:16]
  wire [15:0] _GEN_3377 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_7_pc : _GEN_3358; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3378 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagC : _GEN_3359; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3379 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagZ : _GEN_3360; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3380 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagI : _GEN_3361; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3381 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagD : _GEN_3362; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3383 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagV : _GEN_3364; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3384 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_31_flagN : _GEN_3365; // @[CPU6502Core.scala 237:20 392:16]
  wire [15:0] _GEN_3385 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_memAddr : _GEN_3366; // @[CPU6502Core.scala 237:20 392:16]
  wire [7:0] _GEN_3386 = 8'hdd == opcode | 8'hd9 == opcode ? 8'h0 : _GEN_3367; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3387 = 8'hdd == opcode | 8'hd9 == opcode ? 1'h0 : _GEN_3368; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3388 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_8_memRead : _GEN_3369; // @[CPU6502Core.scala 237:20 392:16]
  wire [15:0] _GEN_3389 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_33_operand : _GEN_3370; // @[CPU6502Core.scala 237:20 392:16]
  wire  _GEN_3390 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_done : _GEN_3371; // @[CPU6502Core.scala 237:20 387:16]
  wire [2:0] _GEN_3391 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3372; // @[CPU6502Core.scala 237:20 387:16]
  wire [7:0] _GEN_3392 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_a : _GEN_3373; // @[CPU6502Core.scala 237:20 387:16]
  wire [7:0] _GEN_3393 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_x : _GEN_3374; // @[CPU6502Core.scala 237:20 387:16]
  wire [7:0] _GEN_3394 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_y : _GEN_3375; // @[CPU6502Core.scala 237:20 387:16]
  wire [7:0] _GEN_3395 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_sp : _GEN_3376; // @[CPU6502Core.scala 237:20 387:16]
  wire [15:0] _GEN_3396 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_7_pc :
    _GEN_3377; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3397 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagC : _GEN_3378
    ; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3398 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagZ : _GEN_3379
    ; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3399 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagI : _GEN_3380; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3400 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagD : _GEN_3381; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3402 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagV : _GEN_3383; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3403 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_31_flagN : _GEN_3384
    ; // @[CPU6502Core.scala 237:20 387:16]
  wire [15:0] _GEN_3404 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_memAddr :
    _GEN_3385; // @[CPU6502Core.scala 237:20 387:16]
  wire [7:0] _GEN_3405 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 8'h0 : _GEN_3386; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3406 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 1'h0 : _GEN_3387; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3407 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_memRead : _GEN_3388
    ; // @[CPU6502Core.scala 237:20 387:16]
  wire [15:0] _GEN_3408 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_8_operand :
    _GEN_3389; // @[CPU6502Core.scala 237:20 387:16]
  wire  _GEN_3409 = 8'hd5 == opcode ? execResult_result_result_6_done : _GEN_3390; // @[CPU6502Core.scala 237:20 382:16]
  wire [2:0] _GEN_3410 = 8'hd5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3391; // @[CPU6502Core.scala 237:20 382:16]
  wire [7:0] _GEN_3411 = 8'hd5 == opcode ? regs_a : _GEN_3392; // @[CPU6502Core.scala 237:20 382:16]
  wire [7:0] _GEN_3412 = 8'hd5 == opcode ? regs_x : _GEN_3393; // @[CPU6502Core.scala 237:20 382:16]
  wire [7:0] _GEN_3413 = 8'hd5 == opcode ? regs_y : _GEN_3394; // @[CPU6502Core.scala 237:20 382:16]
  wire [7:0] _GEN_3414 = 8'hd5 == opcode ? regs_sp : _GEN_3395; // @[CPU6502Core.scala 237:20 382:16]
  wire [15:0] _GEN_3415 = 8'hd5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3396; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3416 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagC : _GEN_3397; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3417 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagZ : _GEN_3398; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3418 = 8'hd5 == opcode ? regs_flagI : _GEN_3399; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3419 = 8'hd5 == opcode ? regs_flagD : _GEN_3400; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3421 = 8'hd5 == opcode ? regs_flagV : _GEN_3402; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3422 = 8'hd5 == opcode ? execResult_result_newRegs_29_flagN : _GEN_3403; // @[CPU6502Core.scala 237:20 382:16]
  wire [15:0] _GEN_3423 = 8'hd5 == opcode ? execResult_result_result_6_memAddr : _GEN_3404; // @[CPU6502Core.scala 237:20 382:16]
  wire [7:0] _GEN_3424 = 8'hd5 == opcode ? 8'h0 : _GEN_3405; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3425 = 8'hd5 == opcode ? 1'h0 : _GEN_3406; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3426 = 8'hd5 == opcode ? execResult_result_result_6_memRead : _GEN_3407; // @[CPU6502Core.scala 237:20 382:16]
  wire [15:0] _GEN_3427 = 8'hd5 == opcode ? execResult_result_result_7_operand : _GEN_3408; // @[CPU6502Core.scala 237:20 382:16]
  wire  _GEN_3428 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_done : _GEN_3409; // @[CPU6502Core.scala 237:20 377:16]
  wire [2:0] _GEN_3429 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3410; // @[CPU6502Core.scala 237:20 377:16]
  wire [7:0] _GEN_3430 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_a : _GEN_3411; // @[CPU6502Core.scala 237:20 377:16]
  wire [7:0] _GEN_3431 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_x : _GEN_3412; // @[CPU6502Core.scala 237:20 377:16]
  wire [7:0] _GEN_3432 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_y : _GEN_3413; // @[CPU6502Core.scala 237:20 377:16]
  wire [7:0] _GEN_3433 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_sp : _GEN_3414; // @[CPU6502Core.scala 237:20 377:16]
  wire [15:0] _GEN_3434 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3415; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3435 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagC : _GEN_3416
    ; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3436 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagZ : _GEN_3417
    ; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3437 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagI : _GEN_3418; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3438 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagD : _GEN_3419; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3440 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagV : _GEN_3421; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3441 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_29_flagN : _GEN_3422
    ; // @[CPU6502Core.scala 237:20 377:16]
  wire [15:0] _GEN_3442 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3423; // @[CPU6502Core.scala 237:20 377:16]
  wire [7:0] _GEN_3443 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 8'h0 : _GEN_3424; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3444 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 1'h0 : _GEN_3425; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3445 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memRead : _GEN_3426
    ; // @[CPU6502Core.scala 237:20 377:16]
  wire [15:0] _GEN_3446 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_operand :
    _GEN_3427; // @[CPU6502Core.scala 237:20 377:16]
  wire  _GEN_3447 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_3428; // @[CPU6502Core.scala 237:20 372:16]
  wire [2:0] _GEN_3448 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 3'h0 : _GEN_3429; // @[CPU6502Core.scala 237:20 372:16]
  wire [7:0] _GEN_3449 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_a : _GEN_3430; // @[CPU6502Core.scala 237:20 372:16]
  wire [7:0] _GEN_3450 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_x : _GEN_3431; // @[CPU6502Core.scala 237:20 372:16]
  wire [7:0] _GEN_3451 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_y : _GEN_3432; // @[CPU6502Core.scala 237:20 372:16]
  wire [7:0] _GEN_3452 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_sp : _GEN_3433; // @[CPU6502Core.scala 237:20 372:16]
  wire [15:0] _GEN_3453 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? _regs_pc_T_1 : _GEN_3434; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3454 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagC : _GEN_3435
    ; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3455 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagZ : _GEN_3436
    ; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3456 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagI : _GEN_3437; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3457 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagD : _GEN_3438; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3459 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagV : _GEN_3440; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3460 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_28_flagN : _GEN_3441
    ; // @[CPU6502Core.scala 237:20 372:16]
  wire [15:0] _GEN_3461 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_pc : _GEN_3442; // @[CPU6502Core.scala 237:20 372:16]
  wire [7:0] _GEN_3462 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 8'h0 : _GEN_3443; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3463 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 1'h0 : _GEN_3444; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3464 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_3445; // @[CPU6502Core.scala 237:20 372:16]
  wire [15:0] _GEN_3465 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 16'h0 : _GEN_3446; // @[CPU6502Core.scala 237:20 372:16]
  wire  _GEN_3466 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_9_done : _GEN_3447; // @[CPU6502Core.scala 237:20 367:16]
  wire [2:0] _GEN_3467 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_6_nextCycle : _GEN_3448; // @[CPU6502Core.scala 237:20 367:16]
  wire [7:0] _GEN_3468 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_a : _GEN_3449; // @[CPU6502Core.scala 237:20 367:16]
  wire [7:0] _GEN_3469 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_x : _GEN_3450; // @[CPU6502Core.scala 237:20 367:16]
  wire [7:0] _GEN_3470 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_y : _GEN_3451; // @[CPU6502Core.scala 237:20 367:16]
  wire [7:0] _GEN_3471 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_sp : _GEN_3452; // @[CPU6502Core.scala 237:20 367:16]
  wire [15:0] _GEN_3472 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_newRegs_7_pc : _GEN_3453; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3473 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_newRegs_26_flagC : _GEN_3454; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3474 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_newRegs_26_flagZ : _GEN_3455; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3475 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_flagI : _GEN_3456; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3476 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_flagD : _GEN_3457; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3478 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? regs_flagV : _GEN_3459; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3479 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_newRegs_26_flagN : _GEN_3460; // @[CPU6502Core.scala 237:20 367:16]
  wire [15:0] _GEN_3480 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_13_memAddr : _GEN_3461; // @[CPU6502Core.scala 237:20 367:16]
  wire [7:0] _GEN_3481 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_27_memData : _GEN_3462; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3482 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_9_done : _GEN_3463; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3483 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_8_memRead : _GEN_3464; // @[CPU6502Core.scala 237:20 367:16]
  wire [15:0] _GEN_3484 = _execResult_result_T_94 | _execResult_result_T_101 | _execResult_result_T_108 |
    _execResult_result_T_115 ? execResult_result_result_14_operand : _GEN_3465; // @[CPU6502Core.scala 237:20 367:16]
  wire  _GEN_3485 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_9_done : _GEN_3466; // @[CPU6502Core.scala 237:20 362:16]
  wire [2:0] _GEN_3486 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_6_nextCycle : _GEN_3467; // @[CPU6502Core.scala 237:20 362:16]
  wire [7:0] _GEN_3487 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_a : _GEN_3468; // @[CPU6502Core.scala 237:20 362:16]
  wire [7:0] _GEN_3488 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_x : _GEN_3469; // @[CPU6502Core.scala 237:20 362:16]
  wire [7:0] _GEN_3489 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_y : _GEN_3470; // @[CPU6502Core.scala 237:20 362:16]
  wire [7:0] _GEN_3490 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_sp : _GEN_3471; // @[CPU6502Core.scala 237:20 362:16]
  wire [15:0] _GEN_3491 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_7_pc : _GEN_3472; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3492 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagC : _GEN_3473; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3493 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagZ : _GEN_3474; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3494 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagI : _GEN_3475; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3495 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagD : _GEN_3476; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3497 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? regs_flagV : _GEN_3478; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3498 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_newRegs_26_flagN : _GEN_3479; // @[CPU6502Core.scala 237:20 362:16]
  wire [15:0] _GEN_3499 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_13_memAddr : _GEN_3480; // @[CPU6502Core.scala 237:20 362:16]
  wire [7:0] _GEN_3500 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_27_memData : _GEN_3481; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3501 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_9_done : _GEN_3482; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3502 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_8_memRead : _GEN_3483; // @[CPU6502Core.scala 237:20 362:16]
  wire [15:0] _GEN_3503 = _execResult_result_T_93 | _execResult_result_T_100 | _execResult_result_T_107 |
    _execResult_result_T_114 ? execResult_result_result_8_operand : _GEN_3484; // @[CPU6502Core.scala 237:20 362:16]
  wire  _GEN_3504 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_8_done : _GEN_3485; // @[CPU6502Core.scala 237:20 357:16]
  wire [2:0] _GEN_3505 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3486; // @[CPU6502Core.scala 237:20 357:16]
  wire [7:0] _GEN_3506 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_a : _GEN_3487; // @[CPU6502Core.scala 237:20 357:16]
  wire [7:0] _GEN_3507 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_x : _GEN_3488; // @[CPU6502Core.scala 237:20 357:16]
  wire [7:0] _GEN_3508 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_y : _GEN_3489; // @[CPU6502Core.scala 237:20 357:16]
  wire [7:0] _GEN_3509 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_sp : _GEN_3490; // @[CPU6502Core.scala 237:20 357:16]
  wire [15:0] _GEN_3510 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3491; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3511 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagC : _GEN_3492; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3512 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagZ : _GEN_3493; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3513 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagI : _GEN_3494; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3514 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagD : _GEN_3495; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3516 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ? regs_flagV : _GEN_3497; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3517 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_newRegs_25_flagN : _GEN_3498; // @[CPU6502Core.scala 237:20 357:16]
  wire [15:0] _GEN_3518 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_11_memAddr : _GEN_3499; // @[CPU6502Core.scala 237:20 357:16]
  wire [7:0] _GEN_3519 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_26_memData : _GEN_3500; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3520 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_8_done : _GEN_3501; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3521 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_6_memRead : _GEN_3502; // @[CPU6502Core.scala 237:20 357:16]
  wire [15:0] _GEN_3522 = 8'h16 == opcode | 8'h56 == opcode | 8'h36 == opcode | 8'h76 == opcode ?
    execResult_result_result_7_operand : _GEN_3503; // @[CPU6502Core.scala 237:20 357:16]
  wire  _GEN_3523 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_8_done : _GEN_3504; // @[CPU6502Core.scala 237:20 352:16]
  wire [2:0] _GEN_3524 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_11_nextCycle : _GEN_3505; // @[CPU6502Core.scala 237:20 352:16]
  wire [7:0] _GEN_3525 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_a : _GEN_3506; // @[CPU6502Core.scala 237:20 352:16]
  wire [7:0] _GEN_3526 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_x : _GEN_3507; // @[CPU6502Core.scala 237:20 352:16]
  wire [7:0] _GEN_3527 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_y : _GEN_3508; // @[CPU6502Core.scala 237:20 352:16]
  wire [7:0] _GEN_3528 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_sp : _GEN_3509; // @[CPU6502Core.scala 237:20 352:16]
  wire [15:0] _GEN_3529 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_3510; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3530 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagC : _GEN_3511; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3531 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagZ : _GEN_3512; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3532 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagI : _GEN_3513; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3533 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagD : _GEN_3514; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3535 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagV : _GEN_3516; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3536 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_24_flagN : _GEN_3517; // @[CPU6502Core.scala 237:20 352:16]
  wire [15:0] _GEN_3537 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_11_memAddr : _GEN_3518; // @[CPU6502Core.scala 237:20 352:16]
  wire [7:0] _GEN_3538 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_25_memData : _GEN_3519; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3539 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_8_done : _GEN_3520; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3540 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memRead : _GEN_3521; // @[CPU6502Core.scala 237:20 352:16]
  wire [15:0] _GEN_3541 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_operand : _GEN_3522; // @[CPU6502Core.scala 237:20 352:16]
  wire  _GEN_3542 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode | _GEN_3523; // @[CPU6502Core.scala 237:20 347:16]
  wire [2:0] _GEN_3543 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 3'h0 : _GEN_3524; // @[CPU6502Core.scala 237:20 347:16]
  wire [7:0] _GEN_3544 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? execResult_result_res_22
     : _GEN_3525; // @[CPU6502Core.scala 237:20 347:16]
  wire [7:0] _GEN_3545 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_x : _GEN_3526; // @[CPU6502Core.scala 237:20 347:16]
  wire [7:0] _GEN_3546 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_y : _GEN_3527; // @[CPU6502Core.scala 237:20 347:16]
  wire [7:0] _GEN_3547 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_sp : _GEN_3528; // @[CPU6502Core.scala 237:20 347:16]
  wire [15:0] _GEN_3548 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_pc : _GEN_3529; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3549 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagC : _GEN_3530; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3550 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagZ : _GEN_3531; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3551 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagI : _GEN_3532; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3552 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagD : _GEN_3533; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3554 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagV : _GEN_3535; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3555 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_23_flagN : _GEN_3536; // @[CPU6502Core.scala 237:20 347:16]
  wire [15:0] _GEN_3556 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_3537; // @[CPU6502Core.scala 237:20 347:16]
  wire [7:0] _GEN_3557 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 8'h0 : _GEN_3538; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3558 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_3539; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3559 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_3540; // @[CPU6502Core.scala 237:20 347:16]
  wire [15:0] _GEN_3560 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_3541; // @[CPU6502Core.scala 237:20 347:16]
  wire  _GEN_3561 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_done : _GEN_3542; // @[CPU6502Core.scala 237:20 342:16]
  wire [2:0] _GEN_3562 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3543; // @[CPU6502Core.scala 237:20 342:16]
  wire [7:0] _GEN_3563 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_a :
    _GEN_3544; // @[CPU6502Core.scala 237:20 342:16]
  wire [7:0] _GEN_3564 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_x : _GEN_3545; // @[CPU6502Core.scala 237:20 342:16]
  wire [7:0] _GEN_3565 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_y : _GEN_3546; // @[CPU6502Core.scala 237:20 342:16]
  wire [7:0] _GEN_3566 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_sp : _GEN_3547; // @[CPU6502Core.scala 237:20 342:16]
  wire [15:0] _GEN_3567 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3548; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3568 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagC : _GEN_3549; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3569 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_3550
    ; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3570 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagI : _GEN_3551; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3571 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagD : _GEN_3552; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3573 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagV : _GEN_3554; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3574 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_21_flagN : _GEN_3555
    ; // @[CPU6502Core.scala 237:20 342:16]
  wire [15:0] _GEN_3575 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_memAddr :
    _GEN_3556; // @[CPU6502Core.scala 237:20 342:16]
  wire [7:0] _GEN_3576 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 8'h0 : _GEN_3557; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3577 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 1'h0 : _GEN_3558; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3578 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_9_memRead : _GEN_3559
    ; // @[CPU6502Core.scala 237:20 342:16]
  wire [15:0] _GEN_3579 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_10_operand :
    _GEN_3560; // @[CPU6502Core.scala 237:20 342:16]
  wire  _GEN_3580 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_done : _GEN_3561; // @[CPU6502Core.scala 237:20 337:16]
  wire [2:0] _GEN_3581 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3562; // @[CPU6502Core.scala 237:20 337:16]
  wire [7:0] _GEN_3582 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_a : _GEN_3563
    ; // @[CPU6502Core.scala 237:20 337:16]
  wire [7:0] _GEN_3583 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_x : _GEN_3564; // @[CPU6502Core.scala 237:20 337:16]
  wire [7:0] _GEN_3584 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_y : _GEN_3565; // @[CPU6502Core.scala 237:20 337:16]
  wire [7:0] _GEN_3585 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_sp : _GEN_3566; // @[CPU6502Core.scala 237:20 337:16]
  wire [15:0] _GEN_3586 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3567; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3587 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagC : _GEN_3568; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3588 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_3569; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3589 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagI : _GEN_3570; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3590 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagD : _GEN_3571; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3592 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagV : _GEN_3573; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3593 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_21_flagN : _GEN_3574; // @[CPU6502Core.scala 237:20 337:16]
  wire [15:0] _GEN_3594 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_memAddr :
    _GEN_3575; // @[CPU6502Core.scala 237:20 337:16]
  wire [7:0] _GEN_3595 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 8'h0 : _GEN_3576; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3596 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 1'h0 : _GEN_3577; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3597 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_memRead : _GEN_3578; // @[CPU6502Core.scala 237:20 337:16]
  wire [15:0] _GEN_3598 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_9_operand :
    _GEN_3579; // @[CPU6502Core.scala 237:20 337:16]
  wire  _GEN_3599 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_8_done : _GEN_3580; // @[CPU6502Core.scala 237:20 332:16]
  wire [2:0] _GEN_3600 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_6_nextCycle : _GEN_3581; // @[CPU6502Core.scala 237:20 332:16]
  wire [7:0] _GEN_3601 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_20_a : _GEN_3582; // @[CPU6502Core.scala 237:20 332:16]
  wire [7:0] _GEN_3602 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_x : _GEN_3583; // @[CPU6502Core.scala 237:20 332:16]
  wire [7:0] _GEN_3603 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_y : _GEN_3584; // @[CPU6502Core.scala 237:20 332:16]
  wire [7:0] _GEN_3604 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_sp : _GEN_3585; // @[CPU6502Core.scala 237:20 332:16]
  wire [15:0] _GEN_3605 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_7_pc : _GEN_3586; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3606 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagC : _GEN_3587; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3607 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_20_flagZ : _GEN_3588; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3608 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagI : _GEN_3589; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3609 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagD : _GEN_3590; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3611 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagV : _GEN_3592; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3612 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_20_flagN : _GEN_3593; // @[CPU6502Core.scala 237:20 332:16]
  wire [15:0] _GEN_3613 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_8_memAddr : _GEN_3594; // @[CPU6502Core.scala 237:20 332:16]
  wire [7:0] _GEN_3614 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? 8'h0 : _GEN_3595; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3615 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? 1'h0 : _GEN_3596; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3616 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_8_memRead : _GEN_3597; // @[CPU6502Core.scala 237:20 332:16]
  wire [15:0] _GEN_3617 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_21_operand : _GEN_3598; // @[CPU6502Core.scala 237:20 332:16]
  wire  _GEN_3618 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_done : _GEN_3599; // @[CPU6502Core.scala 237:20 327:16]
  wire [2:0] _GEN_3619 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3600; // @[CPU6502Core.scala 237:20 327:16]
  wire [7:0] _GEN_3620 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_a : _GEN_3601; // @[CPU6502Core.scala 237:20 327:16]
  wire [7:0] _GEN_3621 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_x : _GEN_3602; // @[CPU6502Core.scala 237:20 327:16]
  wire [7:0] _GEN_3622 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_y : _GEN_3603; // @[CPU6502Core.scala 237:20 327:16]
  wire [7:0] _GEN_3623 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_sp : _GEN_3604; // @[CPU6502Core.scala 237:20 327:16]
  wire [15:0] _GEN_3624 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_7_pc : _GEN_3605; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3625 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagC : _GEN_3606; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3626 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagZ : _GEN_3607; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3627 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagI : _GEN_3608; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3628 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagD : _GEN_3609; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3630 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagV : _GEN_3611; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3631 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_19_flagN : _GEN_3612; // @[CPU6502Core.scala 237:20 327:16]
  wire [15:0] _GEN_3632 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_memAddr : _GEN_3613; // @[CPU6502Core.scala 237:20 327:16]
  wire [7:0] _GEN_3633 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 8'h0 : _GEN_3614; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3634 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 1'h0 : _GEN_3615; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3635 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_memRead : _GEN_3616; // @[CPU6502Core.scala 237:20 327:16]
  wire [15:0] _GEN_3636 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_8_operand : _GEN_3617; // @[CPU6502Core.scala 237:20 327:16]
  wire  _GEN_3637 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_done : _GEN_3618; // @[CPU6502Core.scala 237:20 322:16]
  wire [2:0] _GEN_3638 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3619; // @[CPU6502Core.scala 237:20 322:16]
  wire [7:0] _GEN_3639 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_a :
    _GEN_3620; // @[CPU6502Core.scala 237:20 322:16]
  wire [7:0] _GEN_3640 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_x : _GEN_3621; // @[CPU6502Core.scala 237:20 322:16]
  wire [7:0] _GEN_3641 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_y : _GEN_3622; // @[CPU6502Core.scala 237:20 322:16]
  wire [7:0] _GEN_3642 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_sp : _GEN_3623; // @[CPU6502Core.scala 237:20 322:16]
  wire [15:0] _GEN_3643 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3624; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3644 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagC : _GEN_3625; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3645 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_3626
    ; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3646 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagI : _GEN_3627; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3647 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagD : _GEN_3628; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3649 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagV : _GEN_3630; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3650 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_17_flagN : _GEN_3631
    ; // @[CPU6502Core.scala 237:20 322:16]
  wire [15:0] _GEN_3651 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3632; // @[CPU6502Core.scala 237:20 322:16]
  wire [7:0] _GEN_3652 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 8'h0 : _GEN_3633; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3653 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 1'h0 : _GEN_3634; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3654 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memRead : _GEN_3635
    ; // @[CPU6502Core.scala 237:20 322:16]
  wire [15:0] _GEN_3655 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_7_operand :
    _GEN_3636; // @[CPU6502Core.scala 237:20 322:16]
  wire  _GEN_3656 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_done : _GEN_3637; // @[CPU6502Core.scala 237:20 317:16]
  wire [2:0] _GEN_3657 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_nextCycle :
    _GEN_3638; // @[CPU6502Core.scala 237:20 317:16]
  wire [7:0] _GEN_3658 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_a : _GEN_3639
    ; // @[CPU6502Core.scala 237:20 317:16]
  wire [7:0] _GEN_3659 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_x : _GEN_3640; // @[CPU6502Core.scala 237:20 317:16]
  wire [7:0] _GEN_3660 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_y : _GEN_3641; // @[CPU6502Core.scala 237:20 317:16]
  wire [7:0] _GEN_3661 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_sp : _GEN_3642; // @[CPU6502Core.scala 237:20 317:16]
  wire [15:0] _GEN_3662 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_3643; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3663 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagC : _GEN_3644; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3664 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_3645; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3665 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagI : _GEN_3646; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3666 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagD : _GEN_3647; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3668 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagV : _GEN_3649; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3669 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_17_flagN : _GEN_3650; // @[CPU6502Core.scala 237:20 317:16]
  wire [15:0] _GEN_3670 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memAddr :
    _GEN_3651; // @[CPU6502Core.scala 237:20 317:16]
  wire [7:0] _GEN_3671 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 8'h0 : _GEN_3652; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3672 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 1'h0 : _GEN_3653; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3673 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memRead : _GEN_3654; // @[CPU6502Core.scala 237:20 317:16]
  wire [15:0] _GEN_3674 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_operand :
    _GEN_3655; // @[CPU6502Core.scala 237:20 317:16]
  wire  _GEN_3675 = 8'h24 == opcode ? execResult_result_result_6_done : _GEN_3656; // @[CPU6502Core.scala 237:20 314:16]
  wire [2:0] _GEN_3676 = 8'h24 == opcode ? execResult_result_result_17_nextCycle : _GEN_3657; // @[CPU6502Core.scala 237:20 314:16]
  wire [7:0] _GEN_3677 = 8'h24 == opcode ? regs_a : _GEN_3658; // @[CPU6502Core.scala 237:20 314:16]
  wire [7:0] _GEN_3678 = 8'h24 == opcode ? regs_x : _GEN_3659; // @[CPU6502Core.scala 237:20 314:16]
  wire [7:0] _GEN_3679 = 8'h24 == opcode ? regs_y : _GEN_3660; // @[CPU6502Core.scala 237:20 314:16]
  wire [7:0] _GEN_3680 = 8'h24 == opcode ? regs_sp : _GEN_3661; // @[CPU6502Core.scala 237:20 314:16]
  wire [15:0] _GEN_3681 = 8'h24 == opcode ? execResult_result_newRegs_5_pc : _GEN_3662; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3682 = 8'h24 == opcode ? regs_flagC : _GEN_3663; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3683 = 8'h24 == opcode ? execResult_result_newRegs_16_flagZ : _GEN_3664; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3684 = 8'h24 == opcode ? regs_flagI : _GEN_3665; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3685 = 8'h24 == opcode ? regs_flagD : _GEN_3666; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3687 = 8'h24 == opcode ? execResult_result_newRegs_16_flagV : _GEN_3668; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3688 = 8'h24 == opcode ? execResult_result_newRegs_16_flagN : _GEN_3669; // @[CPU6502Core.scala 237:20 314:16]
  wire [15:0] _GEN_3689 = 8'h24 == opcode ? execResult_result_result_6_memAddr : _GEN_3670; // @[CPU6502Core.scala 237:20 314:16]
  wire [7:0] _GEN_3690 = 8'h24 == opcode ? 8'h0 : _GEN_3671; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3691 = 8'h24 == opcode ? 1'h0 : _GEN_3672; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3692 = 8'h24 == opcode ? execResult_result_result_6_memRead : _GEN_3673; // @[CPU6502Core.scala 237:20 314:16]
  wire [15:0] _GEN_3693 = 8'h24 == opcode ? execResult_result_result_6_operand : _GEN_3674; // @[CPU6502Core.scala 237:20 314:16]
  wire  _GEN_3694 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_3675; // @[CPU6502Core.scala 237:20 309:16]
  wire [2:0] _GEN_3695 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 3'h0 : _GEN_3676; // @[CPU6502Core.scala 237:20 309:16]
  wire [7:0] _GEN_3696 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_res_15 : _GEN_3677; // @[CPU6502Core.scala 237:20 309:16]
  wire [7:0] _GEN_3697 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_x : _GEN_3678; // @[CPU6502Core.scala 237:20 309:16]
  wire [7:0] _GEN_3698 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_y : _GEN_3679; // @[CPU6502Core.scala 237:20 309:16]
  wire [7:0] _GEN_3699 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_sp : _GEN_3680; // @[CPU6502Core.scala 237:20 309:16]
  wire [15:0] _GEN_3700 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? _regs_pc_T_1 : _GEN_3681; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3701 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagC : _GEN_3682; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3702 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_15_flagZ : _GEN_3683; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3703 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagI : _GEN_3684; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3704 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagD : _GEN_3685; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3706 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagV : _GEN_3687; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3707 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_15_flagN : _GEN_3688; // @[CPU6502Core.scala 237:20 309:16]
  wire [15:0] _GEN_3708 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_pc : _GEN_3689; // @[CPU6502Core.scala 237:20 309:16]
  wire [7:0] _GEN_3709 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 8'h0 : _GEN_3690; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3710 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 1'h0 : _GEN_3691; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3711 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_3692; // @[CPU6502Core.scala 237:20 309:16]
  wire [15:0] _GEN_3712 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 16'h0 : _GEN_3693; // @[CPU6502Core.scala 237:20 309:16]
  wire  _GEN_3713 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_9_done : _GEN_3694; // @[CPU6502Core.scala 237:20 304:16]
  wire [2:0] _GEN_3714 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_6_nextCycle : _GEN_3695; // @[CPU6502Core.scala 237:20 304:16]
  wire [7:0] _GEN_3715 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_a : _GEN_3696; // @[CPU6502Core.scala 237:20 304:16]
  wire [7:0] _GEN_3716 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_x : _GEN_3697; // @[CPU6502Core.scala 237:20 304:16]
  wire [7:0] _GEN_3717 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_y : _GEN_3698; // @[CPU6502Core.scala 237:20 304:16]
  wire [7:0] _GEN_3718 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_sp : _GEN_3699; // @[CPU6502Core.scala 237:20 304:16]
  wire [15:0] _GEN_3719 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_pc : _GEN_3700; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3720 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagC : _GEN_3701; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3721 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagZ : _GEN_3702; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3722 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagI : _GEN_3703; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3723 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagD : _GEN_3704; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3725 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagV : _GEN_3706; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3726 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_14_flagN : _GEN_3707; // @[CPU6502Core.scala 237:20 304:16]
  wire [15:0] _GEN_3727 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_15_memAddr : _GEN_3708; // @[CPU6502Core.scala 237:20 304:16]
  wire [7:0] _GEN_3728 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 8'h0 : _GEN_3709; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3729 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 1'h0 : _GEN_3710; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3730 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_memRead : _GEN_3711; // @[CPU6502Core.scala 237:20 304:16]
  wire [15:0] _GEN_3731 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_operand : _GEN_3712; // @[CPU6502Core.scala 237:20 304:16]
  wire  _GEN_3732 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_9_done : _GEN_3713; // @[CPU6502Core.scala 237:20 299:16]
  wire [2:0] _GEN_3733 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_6_nextCycle : _GEN_3714; // @[CPU6502Core.scala 237:20 299:16]
  wire [7:0] _GEN_3734 = 8'hfe == opcode | 8'hde == opcode ? regs_a : _GEN_3715; // @[CPU6502Core.scala 237:20 299:16]
  wire [7:0] _GEN_3735 = 8'hfe == opcode | 8'hde == opcode ? regs_x : _GEN_3716; // @[CPU6502Core.scala 237:20 299:16]
  wire [7:0] _GEN_3736 = 8'hfe == opcode | 8'hde == opcode ? regs_y : _GEN_3717; // @[CPU6502Core.scala 237:20 299:16]
  wire [7:0] _GEN_3737 = 8'hfe == opcode | 8'hde == opcode ? regs_sp : _GEN_3718; // @[CPU6502Core.scala 237:20 299:16]
  wire [15:0] _GEN_3738 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_7_pc : _GEN_3719; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3739 = 8'hfe == opcode | 8'hde == opcode ? regs_flagC : _GEN_3720; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3740 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_13_flagZ : _GEN_3721; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3741 = 8'hfe == opcode | 8'hde == opcode ? regs_flagI : _GEN_3722; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3742 = 8'hfe == opcode | 8'hde == opcode ? regs_flagD : _GEN_3723; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3744 = 8'hfe == opcode | 8'hde == opcode ? regs_flagV : _GEN_3725; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3745 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_newRegs_13_flagN : _GEN_3726; // @[CPU6502Core.scala 237:20 299:16]
  wire [15:0] _GEN_3746 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_13_memAddr : _GEN_3727; // @[CPU6502Core.scala 237:20 299:16]
  wire [7:0] _GEN_3747 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_14_memData : _GEN_3728; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3748 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_9_done : _GEN_3729; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3749 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_8_memRead : _GEN_3730; // @[CPU6502Core.scala 237:20 299:16]
  wire [15:0] _GEN_3750 = 8'hfe == opcode | 8'hde == opcode ? execResult_result_result_14_operand : _GEN_3731; // @[CPU6502Core.scala 237:20 299:16]
  wire  _GEN_3751 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_9_done : _GEN_3732; // @[CPU6502Core.scala 237:20 294:16]
  wire [2:0] _GEN_3752 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_6_nextCycle : _GEN_3733; // @[CPU6502Core.scala 237:20 294:16]
  wire [7:0] _GEN_3753 = 8'hee == opcode | 8'hce == opcode ? regs_a : _GEN_3734; // @[CPU6502Core.scala 237:20 294:16]
  wire [7:0] _GEN_3754 = 8'hee == opcode | 8'hce == opcode ? regs_x : _GEN_3735; // @[CPU6502Core.scala 237:20 294:16]
  wire [7:0] _GEN_3755 = 8'hee == opcode | 8'hce == opcode ? regs_y : _GEN_3736; // @[CPU6502Core.scala 237:20 294:16]
  wire [7:0] _GEN_3756 = 8'hee == opcode | 8'hce == opcode ? regs_sp : _GEN_3737; // @[CPU6502Core.scala 237:20 294:16]
  wire [15:0] _GEN_3757 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_7_pc : _GEN_3738; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3758 = 8'hee == opcode | 8'hce == opcode ? regs_flagC : _GEN_3739; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3759 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_12_flagZ : _GEN_3740; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3760 = 8'hee == opcode | 8'hce == opcode ? regs_flagI : _GEN_3741; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3761 = 8'hee == opcode | 8'hce == opcode ? regs_flagD : _GEN_3742; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3763 = 8'hee == opcode | 8'hce == opcode ? regs_flagV : _GEN_3744; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3764 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_12_flagN : _GEN_3745; // @[CPU6502Core.scala 237:20 294:16]
  wire [15:0] _GEN_3765 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_13_memAddr : _GEN_3746; // @[CPU6502Core.scala 237:20 294:16]
  wire [7:0] _GEN_3766 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_13_memData : _GEN_3747; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3767 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_9_done : _GEN_3748; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3768 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_8_memRead : _GEN_3749; // @[CPU6502Core.scala 237:20 294:16]
  wire [15:0] _GEN_3769 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_8_operand : _GEN_3750; // @[CPU6502Core.scala 237:20 294:16]
  wire  _GEN_3770 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_8_done : _GEN_3751; // @[CPU6502Core.scala 237:20 289:16]
  wire [2:0] _GEN_3771 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_6_nextCycle : _GEN_3752; // @[CPU6502Core.scala 237:20 289:16]
  wire [7:0] _GEN_3772 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_a : _GEN_3753; // @[CPU6502Core.scala 237:20 289:16]
  wire [7:0] _GEN_3773 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_x : _GEN_3754; // @[CPU6502Core.scala 237:20 289:16]
  wire [7:0] _GEN_3774 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_y : _GEN_3755; // @[CPU6502Core.scala 237:20 289:16]
  wire [7:0] _GEN_3775 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_sp : _GEN_3756; // @[CPU6502Core.scala 237:20 289:16]
  wire [15:0] _GEN_3776 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_5_pc : _GEN_3757; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3777 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagC : _GEN_3758; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3778 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_11_flagZ : _GEN_3759; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3779 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagI : _GEN_3760; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3780 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagD : _GEN_3761; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3782 = 8'hf6 == opcode | 8'hd6 == opcode ? regs_flagV : _GEN_3763; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3783 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_newRegs_11_flagN : _GEN_3764; // @[CPU6502Core.scala 237:20 289:16]
  wire [15:0] _GEN_3784 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_11_memAddr : _GEN_3765; // @[CPU6502Core.scala 237:20 289:16]
  wire [7:0] _GEN_3785 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_12_memData : _GEN_3766; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3786 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_8_done : _GEN_3767; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3787 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_6_memRead : _GEN_3768; // @[CPU6502Core.scala 237:20 289:16]
  wire [15:0] _GEN_3788 = 8'hf6 == opcode | 8'hd6 == opcode ? execResult_result_result_7_operand : _GEN_3769; // @[CPU6502Core.scala 237:20 289:16]
  wire  _GEN_3789 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_8_done : _GEN_3770; // @[CPU6502Core.scala 237:20 284:16]
  wire [2:0] _GEN_3790 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_nextCycle : _GEN_3771; // @[CPU6502Core.scala 237:20 284:16]
  wire [7:0] _GEN_3791 = 8'he6 == opcode | 8'hc6 == opcode ? regs_a : _GEN_3772; // @[CPU6502Core.scala 237:20 284:16]
  wire [7:0] _GEN_3792 = 8'he6 == opcode | 8'hc6 == opcode ? regs_x : _GEN_3773; // @[CPU6502Core.scala 237:20 284:16]
  wire [7:0] _GEN_3793 = 8'he6 == opcode | 8'hc6 == opcode ? regs_y : _GEN_3774; // @[CPU6502Core.scala 237:20 284:16]
  wire [7:0] _GEN_3794 = 8'he6 == opcode | 8'hc6 == opcode ? regs_sp : _GEN_3775; // @[CPU6502Core.scala 237:20 284:16]
  wire [15:0] _GEN_3795 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_pc : _GEN_3776; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3796 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagC : _GEN_3777; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3797 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_10_flagZ : _GEN_3778; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3798 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagI : _GEN_3779; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3799 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagD : _GEN_3780; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3801 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagV : _GEN_3782; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3802 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_10_flagN : _GEN_3783; // @[CPU6502Core.scala 237:20 284:16]
  wire [15:0] _GEN_3803 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_memAddr : _GEN_3784; // @[CPU6502Core.scala 237:20 284:16]
  wire [7:0] _GEN_3804 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_11_memData : _GEN_3785; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3805 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_8_done : _GEN_3786; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3806 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memRead : _GEN_3787; // @[CPU6502Core.scala 237:20 284:16]
  wire [15:0] _GEN_3807 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_operand : _GEN_3788; // @[CPU6502Core.scala 237:20 284:16]
  wire  _GEN_3808 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_done : _GEN_3789; // @[CPU6502Core.scala 237:20 279:16]
  wire [2:0] _GEN_3809 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3790; // @[CPU6502Core.scala 237:20 279:16]
  wire [7:0] _GEN_3810 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_a : _GEN_3791; // @[CPU6502Core.scala 237:20 279:16]
  wire [7:0] _GEN_3811 = 8'h71 == opcode | 8'hf1 == opcode ? regs_x : _GEN_3792; // @[CPU6502Core.scala 237:20 279:16]
  wire [7:0] _GEN_3812 = 8'h71 == opcode | 8'hf1 == opcode ? regs_y : _GEN_3793; // @[CPU6502Core.scala 237:20 279:16]
  wire [7:0] _GEN_3813 = 8'h71 == opcode | 8'hf1 == opcode ? regs_sp : _GEN_3794; // @[CPU6502Core.scala 237:20 279:16]
  wire [15:0] _GEN_3814 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3795; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3815 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagC : _GEN_3796; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3816 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_3797; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3817 = 8'h71 == opcode | 8'hf1 == opcode ? regs_flagI : _GEN_3798; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3818 = 8'h71 == opcode | 8'hf1 == opcode ? regs_flagD : _GEN_3799; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3820 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagV : _GEN_3801; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3821 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_newRegs_8_flagN : _GEN_3802; // @[CPU6502Core.scala 237:20 279:16]
  wire [15:0] _GEN_3822 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_memAddr : _GEN_3803; // @[CPU6502Core.scala 237:20 279:16]
  wire [7:0] _GEN_3823 = 8'h71 == opcode | 8'hf1 == opcode ? 8'h0 : _GEN_3804; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3824 = 8'h71 == opcode | 8'hf1 == opcode ? 1'h0 : _GEN_3805; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3825 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_9_memRead : _GEN_3806; // @[CPU6502Core.scala 237:20 279:16]
  wire [15:0] _GEN_3826 = 8'h71 == opcode | 8'hf1 == opcode ? execResult_result_result_10_operand : _GEN_3807; // @[CPU6502Core.scala 237:20 279:16]
  wire  _GEN_3827 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_done : _GEN_3808; // @[CPU6502Core.scala 237:20 274:16]
  wire [2:0] _GEN_3828 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_6_nextCycle : _GEN_3809; // @[CPU6502Core.scala 237:20 274:16]
  wire [7:0] _GEN_3829 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_a : _GEN_3810; // @[CPU6502Core.scala 237:20 274:16]
  wire [7:0] _GEN_3830 = 8'h61 == opcode | 8'he1 == opcode ? regs_x : _GEN_3811; // @[CPU6502Core.scala 237:20 274:16]
  wire [7:0] _GEN_3831 = 8'h61 == opcode | 8'he1 == opcode ? regs_y : _GEN_3812; // @[CPU6502Core.scala 237:20 274:16]
  wire [7:0] _GEN_3832 = 8'h61 == opcode | 8'he1 == opcode ? regs_sp : _GEN_3813; // @[CPU6502Core.scala 237:20 274:16]
  wire [15:0] _GEN_3833 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_5_pc : _GEN_3814; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3834 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagC : _GEN_3815; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3835 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_3816; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3836 = 8'h61 == opcode | 8'he1 == opcode ? regs_flagI : _GEN_3817; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3837 = 8'h61 == opcode | 8'he1 == opcode ? regs_flagD : _GEN_3818; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3839 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagV : _GEN_3820; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3840 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_newRegs_8_flagN : _GEN_3821; // @[CPU6502Core.scala 237:20 274:16]
  wire [15:0] _GEN_3841 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_memAddr : _GEN_3822; // @[CPU6502Core.scala 237:20 274:16]
  wire [7:0] _GEN_3842 = 8'h61 == opcode | 8'he1 == opcode ? 8'h0 : _GEN_3823; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3843 = 8'h61 == opcode | 8'he1 == opcode ? 1'h0 : _GEN_3824; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3844 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_memRead : _GEN_3825; // @[CPU6502Core.scala 237:20 274:16]
  wire [15:0] _GEN_3845 = 8'h61 == opcode | 8'he1 == opcode ? execResult_result_result_9_operand : _GEN_3826; // @[CPU6502Core.scala 237:20 274:16]
  wire  _GEN_3846 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_done : _GEN_3827; // @[CPU6502Core.scala 237:20 269:16]
  wire [2:0] _GEN_3847 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_6_nextCycle : _GEN_3828; // @[CPU6502Core.scala 237:20 269:16]
  wire [7:0] _GEN_3848 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_a : _GEN_3829; // @[CPU6502Core.scala 237:20 269:16]
  wire [7:0] _GEN_3849 = 8'h6d == opcode | 8'hed == opcode ? regs_x : _GEN_3830; // @[CPU6502Core.scala 237:20 269:16]
  wire [7:0] _GEN_3850 = 8'h6d == opcode | 8'hed == opcode ? regs_y : _GEN_3831; // @[CPU6502Core.scala 237:20 269:16]
  wire [7:0] _GEN_3851 = 8'h6d == opcode | 8'hed == opcode ? regs_sp : _GEN_3832; // @[CPU6502Core.scala 237:20 269:16]
  wire [15:0] _GEN_3852 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_pc : _GEN_3833; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3853 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagC : _GEN_3834; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3854 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagZ : _GEN_3835; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3855 = 8'h6d == opcode | 8'hed == opcode ? regs_flagI : _GEN_3836; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3856 = 8'h6d == opcode | 8'hed == opcode ? regs_flagD : _GEN_3837; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3858 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagV : _GEN_3839; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3859 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_newRegs_7_flagN : _GEN_3840; // @[CPU6502Core.scala 237:20 269:16]
  wire [15:0] _GEN_3860 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_memAddr : _GEN_3841; // @[CPU6502Core.scala 237:20 269:16]
  wire [7:0] _GEN_3861 = 8'h6d == opcode | 8'hed == opcode ? 8'h0 : _GEN_3842; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3862 = 8'h6d == opcode | 8'hed == opcode ? 1'h0 : _GEN_3843; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3863 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_memRead : _GEN_3844; // @[CPU6502Core.scala 237:20 269:16]
  wire [15:0] _GEN_3864 = 8'h6d == opcode | 8'hed == opcode ? execResult_result_result_8_operand : _GEN_3845; // @[CPU6502Core.scala 237:20 269:16]
  wire  _GEN_3865 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_done : _GEN_3846; // @[CPU6502Core.scala 237:20 264:16]
  wire [2:0] _GEN_3866 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3847; // @[CPU6502Core.scala 237:20 264:16]
  wire [7:0] _GEN_3867 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_a : _GEN_3848; // @[CPU6502Core.scala 237:20 264:16]
  wire [7:0] _GEN_3868 = 8'h75 == opcode | 8'hf5 == opcode ? regs_x : _GEN_3849; // @[CPU6502Core.scala 237:20 264:16]
  wire [7:0] _GEN_3869 = 8'h75 == opcode | 8'hf5 == opcode ? regs_y : _GEN_3850; // @[CPU6502Core.scala 237:20 264:16]
  wire [7:0] _GEN_3870 = 8'h75 == opcode | 8'hf5 == opcode ? regs_sp : _GEN_3851; // @[CPU6502Core.scala 237:20 264:16]
  wire [15:0] _GEN_3871 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3852; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3872 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagC : _GEN_3853; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3873 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_3854; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3874 = 8'h75 == opcode | 8'hf5 == opcode ? regs_flagI : _GEN_3855; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3875 = 8'h75 == opcode | 8'hf5 == opcode ? regs_flagD : _GEN_3856; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3877 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagV : _GEN_3858; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3878 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_newRegs_5_flagN : _GEN_3859; // @[CPU6502Core.scala 237:20 264:16]
  wire [15:0] _GEN_3879 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_memAddr : _GEN_3860; // @[CPU6502Core.scala 237:20 264:16]
  wire [7:0] _GEN_3880 = 8'h75 == opcode | 8'hf5 == opcode ? 8'h0 : _GEN_3861; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3881 = 8'h75 == opcode | 8'hf5 == opcode ? 1'h0 : _GEN_3862; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3882 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_6_memRead : _GEN_3863; // @[CPU6502Core.scala 237:20 264:16]
  wire [15:0] _GEN_3883 = 8'h75 == opcode | 8'hf5 == opcode ? execResult_result_result_7_operand : _GEN_3864; // @[CPU6502Core.scala 237:20 264:16]
  wire  _GEN_3884 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_done : _GEN_3865; // @[CPU6502Core.scala 237:20 259:16]
  wire [2:0] _GEN_3885 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_nextCycle : _GEN_3866; // @[CPU6502Core.scala 237:20 259:16]
  wire [7:0] _GEN_3886 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_a : _GEN_3867; // @[CPU6502Core.scala 237:20 259:16]
  wire [7:0] _GEN_3887 = 8'h65 == opcode | 8'he5 == opcode ? regs_x : _GEN_3868; // @[CPU6502Core.scala 237:20 259:16]
  wire [7:0] _GEN_3888 = 8'h65 == opcode | 8'he5 == opcode ? regs_y : _GEN_3869; // @[CPU6502Core.scala 237:20 259:16]
  wire [7:0] _GEN_3889 = 8'h65 == opcode | 8'he5 == opcode ? regs_sp : _GEN_3870; // @[CPU6502Core.scala 237:20 259:16]
  wire [15:0] _GEN_3890 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_pc : _GEN_3871; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3891 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagC : _GEN_3872; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3892 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_3873; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3893 = 8'h65 == opcode | 8'he5 == opcode ? regs_flagI : _GEN_3874; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3894 = 8'h65 == opcode | 8'he5 == opcode ? regs_flagD : _GEN_3875; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3896 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagV : _GEN_3877; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3897 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_newRegs_5_flagN : _GEN_3878; // @[CPU6502Core.scala 237:20 259:16]
  wire [15:0] _GEN_3898 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_memAddr : _GEN_3879; // @[CPU6502Core.scala 237:20 259:16]
  wire [7:0] _GEN_3899 = 8'h65 == opcode | 8'he5 == opcode ? 8'h0 : _GEN_3880; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3900 = 8'h65 == opcode | 8'he5 == opcode ? 1'h0 : _GEN_3881; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3901 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_memRead : _GEN_3882; // @[CPU6502Core.scala 237:20 259:16]
  wire [15:0] _GEN_3902 = 8'h65 == opcode | 8'he5 == opcode ? execResult_result_result_6_operand : _GEN_3883; // @[CPU6502Core.scala 237:20 259:16]
  wire  _GEN_3903 = 8'he9 == opcode | _GEN_3884; // @[CPU6502Core.scala 237:20 255:27]
  wire [2:0] _GEN_3904 = 8'he9 == opcode ? 3'h0 : _GEN_3885; // @[CPU6502Core.scala 237:20 255:27]
  wire [7:0] _GEN_3905 = 8'he9 == opcode ? execResult_result_newRegs_4_a : _GEN_3886; // @[CPU6502Core.scala 237:20 255:27]
  wire [7:0] _GEN_3906 = 8'he9 == opcode ? regs_x : _GEN_3887; // @[CPU6502Core.scala 237:20 255:27]
  wire [7:0] _GEN_3907 = 8'he9 == opcode ? regs_y : _GEN_3888; // @[CPU6502Core.scala 237:20 255:27]
  wire [7:0] _GEN_3908 = 8'he9 == opcode ? regs_sp : _GEN_3889; // @[CPU6502Core.scala 237:20 255:27]
  wire [15:0] _GEN_3909 = 8'he9 == opcode ? _regs_pc_T_1 : _GEN_3890; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3910 = 8'he9 == opcode ? execResult_result_newRegs_4_flagC : _GEN_3891; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3911 = 8'he9 == opcode ? execResult_result_newRegs_4_flagZ : _GEN_3892; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3912 = 8'he9 == opcode ? regs_flagI : _GEN_3893; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3913 = 8'he9 == opcode ? regs_flagD : _GEN_3894; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3915 = 8'he9 == opcode ? execResult_result_newRegs_4_flagV : _GEN_3896; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3916 = 8'he9 == opcode ? execResult_result_newRegs_4_flagN : _GEN_3897; // @[CPU6502Core.scala 237:20 255:27]
  wire [15:0] _GEN_3917 = 8'he9 == opcode ? regs_pc : _GEN_3898; // @[CPU6502Core.scala 237:20 255:27]
  wire [7:0] _GEN_3918 = 8'he9 == opcode ? 8'h0 : _GEN_3899; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3919 = 8'he9 == opcode ? 1'h0 : _GEN_3900; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3920 = 8'he9 == opcode | _GEN_3901; // @[CPU6502Core.scala 237:20 255:27]
  wire [15:0] _GEN_3921 = 8'he9 == opcode ? 16'h0 : _GEN_3902; // @[CPU6502Core.scala 237:20 255:27]
  wire  _GEN_3922 = 8'h69 == opcode | _GEN_3903; // @[CPU6502Core.scala 237:20 254:27]
  wire [2:0] _GEN_3923 = 8'h69 == opcode ? 3'h0 : _GEN_3904; // @[CPU6502Core.scala 237:20 254:27]
  wire [7:0] _GEN_3924 = 8'h69 == opcode ? execResult_result_newRegs_3_a : _GEN_3905; // @[CPU6502Core.scala 237:20 254:27]
  wire [7:0] _GEN_3925 = 8'h69 == opcode ? regs_x : _GEN_3906; // @[CPU6502Core.scala 237:20 254:27]
  wire [7:0] _GEN_3926 = 8'h69 == opcode ? regs_y : _GEN_3907; // @[CPU6502Core.scala 237:20 254:27]
  wire [7:0] _GEN_3927 = 8'h69 == opcode ? regs_sp : _GEN_3908; // @[CPU6502Core.scala 237:20 254:27]
  wire [15:0] _GEN_3928 = 8'h69 == opcode ? _regs_pc_T_1 : _GEN_3909; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3929 = 8'h69 == opcode ? execResult_result_newRegs_3_flagC : _GEN_3910; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3930 = 8'h69 == opcode ? execResult_result_newRegs_3_flagZ : _GEN_3911; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3931 = 8'h69 == opcode ? regs_flagI : _GEN_3912; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3932 = 8'h69 == opcode ? regs_flagD : _GEN_3913; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3934 = 8'h69 == opcode ? execResult_result_newRegs_3_flagV : _GEN_3915; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3935 = 8'h69 == opcode ? execResult_result_newRegs_3_flagN : _GEN_3916; // @[CPU6502Core.scala 237:20 254:27]
  wire [15:0] _GEN_3936 = 8'h69 == opcode ? regs_pc : _GEN_3917; // @[CPU6502Core.scala 237:20 254:27]
  wire [7:0] _GEN_3937 = 8'h69 == opcode ? 8'h0 : _GEN_3918; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3938 = 8'h69 == opcode ? 1'h0 : _GEN_3919; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3939 = 8'h69 == opcode | _GEN_3920; // @[CPU6502Core.scala 237:20 254:27]
  wire [15:0] _GEN_3940 = 8'h69 == opcode ? 16'h0 : _GEN_3921; // @[CPU6502Core.scala 237:20 254:27]
  wire  _GEN_3941 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode | _GEN_3922; // @[CPU6502Core.scala 237:20 250:16]
  wire [2:0] _GEN_3942 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 3'h0 : _GEN_3923; // @[CPU6502Core.scala 237:20 250:16]
  wire [7:0] _GEN_3943 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_a : _GEN_3924; // @[CPU6502Core.scala 237:20 250:16]
  wire [7:0] _GEN_3944 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_x : _GEN_3925; // @[CPU6502Core.scala 237:20 250:16]
  wire [7:0] _GEN_3945 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_y : _GEN_3926; // @[CPU6502Core.scala 237:20 250:16]
  wire [7:0] _GEN_3946 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_sp : _GEN_3927; // @[CPU6502Core.scala 237:20 250:16]
  wire [15:0] _GEN_3947 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_pc : _GEN_3928; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3948 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagC : _GEN_3929; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3949 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagZ : _GEN_3930; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3950 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagI : _GEN_3931; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3951 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagD : _GEN_3932; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3953 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagV : _GEN_3934; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3954 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagN : _GEN_3935; // @[CPU6502Core.scala 237:20 250:16]
  wire [15:0] _GEN_3955 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_3936; // @[CPU6502Core.scala 237:20 250:16]
  wire [7:0] _GEN_3956 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 8'h0 : _GEN_3937; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3957 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_3938; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3958 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_3939; // @[CPU6502Core.scala 237:20 250:16]
  wire [15:0] _GEN_3959 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_3940; // @[CPU6502Core.scala 237:20 250:16]
  wire  _GEN_3960 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode | _GEN_3941; // @[CPU6502Core.scala 237:20 245:16]
  wire [2:0] _GEN_3961 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 3'h0 : _GEN_3942; // @[CPU6502Core.scala 237:20 245:16]
  wire [7:0] _GEN_3962 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_a : _GEN_3943; // @[CPU6502Core.scala 237:20 245:16]
  wire [7:0] _GEN_3963 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_x : _GEN_3944; // @[CPU6502Core.scala 237:20 245:16]
  wire [7:0] _GEN_3964 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_y : _GEN_3945; // @[CPU6502Core.scala 237:20 245:16]
  wire [7:0] _GEN_3965 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_sp : _GEN_3946; // @[CPU6502Core.scala 237:20 245:16]
  wire [15:0] _GEN_3966 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? regs_pc : _GEN_3947; // @[CPU6502Core.scala 237:20 245:16]
  wire  _GEN_3967 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagC : _GEN_3948; // @[CPU6502Core.scala 237:20 245:16]
  wire  _GEN_3968 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagZ : _GEN_3949; // @[CPU6502Core.scala 237:20 245:16]
  wire  _GEN_3969 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagI : _GEN_3950; // @[CPU6502Core.scala 237:20 245:16]
  wire  _GEN_3970 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagD : _GEN_3951; // @[CPU6502Core.scala 237:20 245:16]
  wire  _GEN_3972 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagV : _GEN_3953; // @[CPU6502Core.scala 237:20 245:16]
  wire  _GEN_3973 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagN : _GEN_3954; // @[CPU6502Core.scala 237:20 245:16]
  wire [15:0] _GEN_3974 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_3955; // @[CPU6502Core.scala 237:20 245:16]
  wire [7:0] _GEN_3975 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 8'h0 : _GEN_3956; // @[CPU6502Core.scala 237:20 245:16]
  wire  _GEN_3976 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_3957; // @[CPU6502Core.scala 237:20 245:16]
  wire  _GEN_3977 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_3958; // @[CPU6502Core.scala 237:20 245:16]
  wire [15:0] _GEN_3978 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_3959; // @[CPU6502Core.scala 237:20 245:16]
  wire  execResult_result_1_done = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode | _GEN_3960; // @[CPU6502Core.scala 237:20 240:16]
  wire [2:0] execResult_result_1_nextCycle = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 3'h0 : _GEN_3961; // @[CPU6502Core.scala 237:20 240:16]
  wire [7:0] execResult_result_1_regs_a = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_a : _GEN_3962; // @[CPU6502Core.scala 237:20 240:16]
  wire [7:0] execResult_result_1_regs_x = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_x : _GEN_3963; // @[CPU6502Core.scala 237:20 240:16]
  wire [7:0] execResult_result_1_regs_y = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_y : _GEN_3964; // @[CPU6502Core.scala 237:20 240:16]
  wire [7:0] execResult_result_1_regs_sp = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_sp : _GEN_3965; // @[CPU6502Core.scala 237:20 240:16]
  wire [15:0] execResult_result_1_regs_pc = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_pc : _GEN_3966; // @[CPU6502Core.scala 237:20 240:16]
  wire  execResult_result_1_regs_flagC = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagC : _GEN_3967; // @[CPU6502Core.scala 237:20 240:16]
  wire  execResult_result_1_regs_flagZ = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagZ : _GEN_3968; // @[CPU6502Core.scala 237:20 240:16]
  wire  execResult_result_1_regs_flagI = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagI : _GEN_3969; // @[CPU6502Core.scala 237:20 240:16]
  wire  execResult_result_1_regs_flagD = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagD : _GEN_3970; // @[CPU6502Core.scala 237:20 240:16]
  wire  execResult_result_1_regs_flagV = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagV : _GEN_3972; // @[CPU6502Core.scala 237:20 240:16]
  wire  execResult_result_1_regs_flagN = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagN : _GEN_3973; // @[CPU6502Core.scala 237:20 240:16]
  wire [15:0] execResult_result_1_memAddr = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_3974; // @[CPU6502Core.scala 237:20 240:16]
  wire [7:0] execResult_result_1_memData = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 8'h0 : _GEN_3975; // @[CPU6502Core.scala 237:20 240:16]
  wire  execResult_result_1_memWrite = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_3976; // @[CPU6502Core.scala 237:20 240:16]
  wire  execResult_result_1_memRead = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_3977; // @[CPU6502Core.scala 237:20 240:16]
  wire [15:0] execResult_result_1_operand = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_3978; // @[CPU6502Core.scala 237:20 240:16]
  wire  _GEN_4077 = 3'h2 == state & execResult_result_1_done; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4121 = 3'h1 == state ? 1'h0 : _GEN_4077; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4163 = 3'h0 == state ? 1'h0 : _GEN_4121; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_done = io_reset ? 1'h0 : _GEN_4163; // @[CPU6502Core.scala 56:14 59:18]
  wire [2:0] _GEN_4078 = 3'h2 == state ? execResult_result_1_nextCycle : 3'h0; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [2:0] _GEN_4122 = 3'h1 == state ? 3'h0 : _GEN_4078; // @[CPU6502Core.scala 56:14 69:19]
  wire [2:0] _GEN_4164 = 3'h0 == state ? 3'h0 : _GEN_4122; // @[CPU6502Core.scala 56:14 69:19]
  wire [2:0] execResult_nextCycle = io_reset ? 3'h0 : _GEN_4164; // @[CPU6502Core.scala 56:14 59:18]
  wire [2:0] _GEN_3998 = execResult_done ? 3'h0 : execResult_nextCycle; // @[CPU6502Core.scala 148:19 150:33 151:19]
  wire [2:0] _GEN_3999 = execResult_done ? 3'h1 : state; // @[CPU6502Core.scala 150:33 152:19 25:22]
  wire [7:0] status = {regs_flagN,regs_flagV,2'h2,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire  _T_25 = cycle == 3'h7; // @[CPU6502Core.scala 200:28]
  wire [15:0] _GEN_4000 = cycle == 3'h7 ? 16'hfffb : regs_pc; // @[CPU6502Core.scala 200:37 202:24 49:17]
  wire [3:0] _GEN_4002 = cycle == 3'h7 ? 4'h8 : 4'h0; // @[CPU6502Core.scala 200:37 204:19 210:19]
  wire [15:0] _GEN_4003 = cycle == 3'h7 ? regs_pc : resetVector; // @[CPU6502Core.scala 200:37 208:21 21:21]
  wire  _GEN_4004 = cycle == 3'h7 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 200:37 21:21 209:24]
  wire [2:0] _GEN_4005 = cycle == 3'h7 ? state : 3'h1; // @[CPU6502Core.scala 200:37 211:19 25:22]
  wire [15:0] _GEN_4006 = cycle == 3'h6 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 194:37 196:21 28:24]
  wire [15:0] _GEN_4007 = cycle == 3'h6 ? 16'hfffb : _GEN_4000; // @[CPU6502Core.scala 194:37 197:24]
  wire  _GEN_4008 = cycle == 3'h6 | _T_25; // @[CPU6502Core.scala 194:37 198:24]
  wire [3:0] _GEN_4009 = cycle == 3'h6 ? 4'h7 : _GEN_4002; // @[CPU6502Core.scala 194:37 199:19]
  wire [15:0] _GEN_4010 = cycle == 3'h6 ? regs_pc : _GEN_4003; // @[CPU6502Core.scala 194:37 21:21]
  wire  _GEN_4011 = cycle == 3'h6 ? regs_flagI : _GEN_4004; // @[CPU6502Core.scala 194:37 21:21]
  wire [2:0] _GEN_4012 = cycle == 3'h6 ? state : _GEN_4005; // @[CPU6502Core.scala 194:37 25:22]
  wire [15:0] _GEN_4013 = cycle == 3'h5 ? 16'hfffa : _GEN_4007; // @[CPU6502Core.scala 189:37 191:24]
  wire  _GEN_4014 = cycle == 3'h5 | _GEN_4008; // @[CPU6502Core.scala 189:37 192:24]
  wire [3:0] _GEN_4015 = cycle == 3'h5 ? 4'h6 : _GEN_4009; // @[CPU6502Core.scala 189:37 193:19]
  wire [15:0] _GEN_4016 = cycle == 3'h5 ? operand : _GEN_4006; // @[CPU6502Core.scala 189:37 28:24]
  wire [15:0] _GEN_4017 = cycle == 3'h5 ? regs_pc : _GEN_4010; // @[CPU6502Core.scala 189:37 21:21]
  wire  _GEN_4018 = cycle == 3'h5 ? regs_flagI : _GEN_4011; // @[CPU6502Core.scala 189:37 21:21]
  wire [2:0] _GEN_4019 = cycle == 3'h5 ? state : _GEN_4012; // @[CPU6502Core.scala 189:37 25:22]
  wire [15:0] _GEN_4020 = _T_9 ? 16'hfffa : _GEN_4013; // @[CPU6502Core.scala 184:37 186:24]
  wire  _GEN_4021 = _T_9 | _GEN_4014; // @[CPU6502Core.scala 184:37 187:24]
  wire [3:0] _GEN_4022 = _T_9 ? 4'h5 : _GEN_4015; // @[CPU6502Core.scala 184:37 188:19]
  wire [15:0] _GEN_4023 = _T_9 ? operand : _GEN_4016; // @[CPU6502Core.scala 184:37 28:24]
  wire [15:0] _GEN_4024 = _T_9 ? regs_pc : _GEN_4017; // @[CPU6502Core.scala 184:37 21:21]
  wire  _GEN_4025 = _T_9 ? regs_flagI : _GEN_4018; // @[CPU6502Core.scala 184:37 21:21]
  wire [2:0] _GEN_4026 = _T_9 ? state : _GEN_4019; // @[CPU6502Core.scala 184:37 25:22]
  wire [15:0] _GEN_4027 = _T_8 ? execResult_result_result_46_memAddr : _GEN_4020; // @[CPU6502Core.scala 175:37 179:24]
  wire [7:0] _GEN_4028 = _T_8 ? status : 8'h0; // @[CPU6502Core.scala 175:37 180:27 50:17]
  wire [7:0] _GEN_4030 = _T_8 ? execResult_result_newRegs_45_sp : regs_sp; // @[CPU6502Core.scala 175:37 182:21 21:21]
  wire [3:0] _GEN_4031 = _T_8 ? 4'h4 : _GEN_4022; // @[CPU6502Core.scala 175:37 183:19]
  wire  _GEN_4032 = _T_8 ? 1'h0 : _GEN_4021; // @[CPU6502Core.scala 175:37 52:17]
  wire [15:0] _GEN_4033 = _T_8 ? operand : _GEN_4023; // @[CPU6502Core.scala 175:37 28:24]
  wire [15:0] _GEN_4034 = _T_8 ? regs_pc : _GEN_4024; // @[CPU6502Core.scala 175:37 21:21]
  wire  _GEN_4035 = _T_8 ? regs_flagI : _GEN_4025; // @[CPU6502Core.scala 175:37 21:21]
  wire [2:0] _GEN_4036 = _T_8 ? state : _GEN_4026; // @[CPU6502Core.scala 175:37 25:22]
  wire [15:0] _GEN_4037 = _T_7 ? execResult_result_result_46_memAddr : _GEN_4027; // @[CPU6502Core.scala 168:37 170:24]
  wire [7:0] _GEN_4038 = _T_7 ? regs_pc[7:0] : _GEN_4028; // @[CPU6502Core.scala 168:37 171:27]
  wire  _GEN_4039 = _T_7 | _T_8; // @[CPU6502Core.scala 168:37 172:25]
  wire [7:0] _GEN_4040 = _T_7 ? execResult_result_newRegs_45_sp : _GEN_4030; // @[CPU6502Core.scala 168:37 173:21]
  wire [3:0] _GEN_4041 = _T_7 ? 4'h3 : _GEN_4031; // @[CPU6502Core.scala 168:37 174:19]
  wire  _GEN_4042 = _T_7 ? 1'h0 : _GEN_4032; // @[CPU6502Core.scala 168:37 52:17]
  wire [15:0] _GEN_4043 = _T_7 ? operand : _GEN_4033; // @[CPU6502Core.scala 168:37 28:24]
  wire [15:0] _GEN_4044 = _T_7 ? regs_pc : _GEN_4034; // @[CPU6502Core.scala 168:37 21:21]
  wire  _GEN_4045 = _T_7 ? regs_flagI : _GEN_4035; // @[CPU6502Core.scala 168:37 21:21]
  wire [2:0] _GEN_4046 = _T_7 ? state : _GEN_4036; // @[CPU6502Core.scala 168:37 25:22]
  wire [15:0] _GEN_4047 = _T_6 ? execResult_result_result_46_memAddr : _GEN_4037; // @[CPU6502Core.scala 161:37 163:24]
  wire [7:0] _GEN_4048 = _T_6 ? regs_pc[15:8] : _GEN_4038; // @[CPU6502Core.scala 161:37 164:27]
  wire  _GEN_4049 = _T_6 | _GEN_4039; // @[CPU6502Core.scala 161:37 165:25]
  wire [7:0] _GEN_4050 = _T_6 ? execResult_result_newRegs_45_sp : _GEN_4040; // @[CPU6502Core.scala 161:37 166:21]
  wire [3:0] _GEN_4051 = _T_6 ? 4'h2 : _GEN_4041; // @[CPU6502Core.scala 161:37 167:19]
  wire  _GEN_4052 = _T_6 ? 1'h0 : _GEN_4042; // @[CPU6502Core.scala 161:37 52:17]
  wire [15:0] _GEN_4053 = _T_6 ? operand : _GEN_4043; // @[CPU6502Core.scala 161:37 28:24]
  wire [15:0] _GEN_4054 = _T_6 ? regs_pc : _GEN_4044; // @[CPU6502Core.scala 161:37 21:21]
  wire  _GEN_4055 = _T_6 ? regs_flagI : _GEN_4045; // @[CPU6502Core.scala 161:37 21:21]
  wire [2:0] _GEN_4056 = _T_6 ? state : _GEN_4046; // @[CPU6502Core.scala 161:37 25:22]
  wire [3:0] _GEN_4057 = _T_5 ? 4'h1 : _GEN_4051; // @[CPU6502Core.scala 158:31 160:19]
  wire [15:0] _GEN_4058 = _T_5 ? regs_pc : _GEN_4047; // @[CPU6502Core.scala 158:31 49:17]
  wire [7:0] _GEN_4059 = _T_5 ? 8'h0 : _GEN_4048; // @[CPU6502Core.scala 158:31 50:17]
  wire  _GEN_4060 = _T_5 ? 1'h0 : _GEN_4049; // @[CPU6502Core.scala 158:31 51:17]
  wire [7:0] _GEN_4061 = _T_5 ? regs_sp : _GEN_4050; // @[CPU6502Core.scala 158:31 21:21]
  wire  _GEN_4062 = _T_5 ? 1'h0 : _GEN_4052; // @[CPU6502Core.scala 158:31 52:17]
  wire [15:0] _GEN_4063 = _T_5 ? operand : _GEN_4053; // @[CPU6502Core.scala 158:31 28:24]
  wire [15:0] _GEN_4064 = _T_5 ? regs_pc : _GEN_4054; // @[CPU6502Core.scala 158:31 21:21]
  wire  _GEN_4065 = _T_5 ? regs_flagI : _GEN_4055; // @[CPU6502Core.scala 158:31 21:21]
  wire [2:0] _GEN_4066 = _T_5 ? state : _GEN_4056; // @[CPU6502Core.scala 158:31 25:22]
  wire [3:0] _GEN_4067 = 3'h3 == state ? _GEN_4057 : {{1'd0}, cycle}; // @[CPU6502Core.scala 69:19 29:24]
  wire [15:0] _GEN_4068 = 3'h3 == state ? _GEN_4058 : regs_pc; // @[CPU6502Core.scala 49:17 69:19]
  wire [7:0] _GEN_4069 = 3'h3 == state ? _GEN_4059 : 8'h0; // @[CPU6502Core.scala 50:17 69:19]
  wire  _GEN_4070 = 3'h3 == state & _GEN_4060; // @[CPU6502Core.scala 51:17 69:19]
  wire [7:0] _GEN_4071 = 3'h3 == state ? _GEN_4061 : regs_sp; // @[CPU6502Core.scala 69:19 21:21]
  wire  _GEN_4072 = 3'h3 == state & _GEN_4062; // @[CPU6502Core.scala 52:17 69:19]
  wire [15:0] _GEN_4073 = 3'h3 == state ? _GEN_4063 : operand; // @[CPU6502Core.scala 69:19 28:24]
  wire [15:0] _GEN_4074 = 3'h3 == state ? _GEN_4064 : regs_pc; // @[CPU6502Core.scala 69:19 21:21]
  wire  _GEN_4075 = 3'h3 == state ? _GEN_4065 : regs_flagI; // @[CPU6502Core.scala 69:19 21:21]
  wire [2:0] _GEN_4076 = 3'h3 == state ? _GEN_4066 : state; // @[CPU6502Core.scala 69:19 25:22]
  wire [7:0] _GEN_4079 = 3'h2 == state ? execResult_result_1_regs_a : regs_a; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [7:0] _GEN_4080 = 3'h2 == state ? execResult_result_1_regs_x : regs_x; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [7:0] _GEN_4081 = 3'h2 == state ? execResult_result_1_regs_y : regs_y; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [7:0] _GEN_4082 = 3'h2 == state ? execResult_result_1_regs_sp : regs_sp; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [15:0] _GEN_4083 = 3'h2 == state ? execResult_result_1_regs_pc : regs_pc; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4084 = 3'h2 == state ? execResult_result_1_regs_flagC : regs_flagC; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4085 = 3'h2 == state ? execResult_result_1_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4086 = 3'h2 == state ? execResult_result_1_regs_flagI : regs_flagI; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4087 = 3'h2 == state ? execResult_result_1_regs_flagD : regs_flagD; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4089 = 3'h2 == state ? execResult_result_1_regs_flagV : regs_flagV; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4090 = 3'h2 == state ? execResult_result_1_regs_flagN : regs_flagN; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [15:0] _GEN_4091 = 3'h2 == state ? execResult_result_1_memAddr : 16'h0; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [7:0] _GEN_4092 = 3'h2 == state ? execResult_result_1_memData : 8'h0; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4093 = 3'h2 == state & execResult_result_1_memWrite; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire  _GEN_4094 = 3'h2 == state & execResult_result_1_memRead; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [15:0] _GEN_4095 = 3'h2 == state ? execResult_result_1_operand : operand; // @[CPU6502Core.scala 69:19 138:22 56:14]
  wire [15:0] _GEN_4135 = 3'h1 == state ? 16'h0 : _GEN_4091; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] _GEN_4177 = 3'h0 == state ? 16'h0 : _GEN_4135; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] execResult_memAddr = io_reset ? 16'h0 : _GEN_4177; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4096 = 3'h2 == state ? execResult_memAddr : _GEN_4068; // @[CPU6502Core.scala 69:19 141:25]
  wire [7:0] _GEN_4136 = 3'h1 == state ? 8'h0 : _GEN_4092; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4178 = 3'h0 == state ? 8'h0 : _GEN_4136; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_memData = io_reset ? 8'h0 : _GEN_4178; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4097 = 3'h2 == state ? execResult_memData : _GEN_4069; // @[CPU6502Core.scala 69:19 142:25]
  wire  _GEN_4137 = 3'h1 == state ? 1'h0 : _GEN_4093; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4179 = 3'h0 == state ? 1'h0 : _GEN_4137; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_memWrite = io_reset ? 1'h0 : _GEN_4179; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4098 = 3'h2 == state ? execResult_memWrite : _GEN_4070; // @[CPU6502Core.scala 69:19 143:25]
  wire  _GEN_4138 = 3'h1 == state ? 1'h0 : _GEN_4094; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4180 = 3'h0 == state ? 1'h0 : _GEN_4138; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_memRead = io_reset ? 1'h0 : _GEN_4180; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4099 = 3'h2 == state ? execResult_memRead : _GEN_4072; // @[CPU6502Core.scala 69:19 144:25]
  wire [7:0] _GEN_4123 = 3'h1 == state ? regs_a : _GEN_4079; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4165 = 3'h0 == state ? regs_a : _GEN_4123; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_regs_a = io_reset ? regs_a : _GEN_4165; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4100 = 3'h2 == state ? execResult_regs_a : regs_a; // @[CPU6502Core.scala 146:19 69:19 21:21]
  wire [7:0] _GEN_4124 = 3'h1 == state ? regs_x : _GEN_4080; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4166 = 3'h0 == state ? regs_x : _GEN_4124; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_regs_x = io_reset ? regs_x : _GEN_4166; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4101 = 3'h2 == state ? execResult_regs_x : regs_x; // @[CPU6502Core.scala 146:19 69:19 21:21]
  wire [7:0] _GEN_4125 = 3'h1 == state ? regs_y : _GEN_4081; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4167 = 3'h0 == state ? regs_y : _GEN_4125; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_regs_y = io_reset ? regs_y : _GEN_4167; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4102 = 3'h2 == state ? execResult_regs_y : regs_y; // @[CPU6502Core.scala 146:19 69:19 21:21]
  wire [7:0] _GEN_4126 = 3'h1 == state ? regs_sp : _GEN_4082; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] _GEN_4168 = 3'h0 == state ? regs_sp : _GEN_4126; // @[CPU6502Core.scala 56:14 69:19]
  wire [7:0] execResult_regs_sp = io_reset ? regs_sp : _GEN_4168; // @[CPU6502Core.scala 56:14 59:18]
  wire [7:0] _GEN_4103 = 3'h2 == state ? execResult_regs_sp : _GEN_4071; // @[CPU6502Core.scala 146:19 69:19]
  wire [15:0] _GEN_4127 = 3'h1 == state ? regs_pc : _GEN_4083; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] _GEN_4169 = 3'h0 == state ? regs_pc : _GEN_4127; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] execResult_regs_pc = io_reset ? regs_pc : _GEN_4169; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4104 = 3'h2 == state ? execResult_regs_pc : _GEN_4074; // @[CPU6502Core.scala 146:19 69:19]
  wire  _GEN_4128 = 3'h1 == state ? regs_flagC : _GEN_4084; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4170 = 3'h0 == state ? regs_flagC : _GEN_4128; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagC = io_reset ? regs_flagC : _GEN_4170; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4105 = 3'h2 == state ? execResult_regs_flagC : regs_flagC; // @[CPU6502Core.scala 146:19 69:19 21:21]
  wire  _GEN_4129 = 3'h1 == state ? regs_flagZ : _GEN_4085; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4171 = 3'h0 == state ? regs_flagZ : _GEN_4129; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagZ = io_reset ? regs_flagZ : _GEN_4171; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4106 = 3'h2 == state ? execResult_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 146:19 69:19 21:21]
  wire  _GEN_4130 = 3'h1 == state ? regs_flagI : _GEN_4086; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4172 = 3'h0 == state ? regs_flagI : _GEN_4130; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagI = io_reset ? regs_flagI : _GEN_4172; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4107 = 3'h2 == state ? execResult_regs_flagI : _GEN_4075; // @[CPU6502Core.scala 146:19 69:19]
  wire  _GEN_4131 = 3'h1 == state ? regs_flagD : _GEN_4087; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4173 = 3'h0 == state ? regs_flagD : _GEN_4131; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagD = io_reset ? regs_flagD : _GEN_4173; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4108 = 3'h2 == state ? execResult_regs_flagD : regs_flagD; // @[CPU6502Core.scala 146:19 69:19 21:21]
  wire  _GEN_4133 = 3'h1 == state ? regs_flagV : _GEN_4089; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4175 = 3'h0 == state ? regs_flagV : _GEN_4133; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagV = io_reset ? regs_flagV : _GEN_4175; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4110 = 3'h2 == state ? execResult_regs_flagV : regs_flagV; // @[CPU6502Core.scala 146:19 69:19 21:21]
  wire  _GEN_4134 = 3'h1 == state ? regs_flagN : _GEN_4090; // @[CPU6502Core.scala 56:14 69:19]
  wire  _GEN_4176 = 3'h0 == state ? regs_flagN : _GEN_4134; // @[CPU6502Core.scala 56:14 69:19]
  wire  execResult_regs_flagN = io_reset ? regs_flagN : _GEN_4176; // @[CPU6502Core.scala 56:14 59:18]
  wire  _GEN_4111 = 3'h2 == state ? execResult_regs_flagN : regs_flagN; // @[CPU6502Core.scala 146:19 69:19 21:21]
  wire [15:0] _GEN_4139 = 3'h1 == state ? operand : _GEN_4095; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] _GEN_4181 = 3'h0 == state ? operand : _GEN_4139; // @[CPU6502Core.scala 56:14 69:19]
  wire [15:0] execResult_operand = io_reset ? operand : _GEN_4181; // @[CPU6502Core.scala 56:14 59:18]
  wire [15:0] _GEN_4112 = 3'h2 == state ? execResult_operand : _GEN_4073; // @[CPU6502Core.scala 147:19 69:19]
  wire [3:0] _GEN_4113 = 3'h2 == state ? {{1'd0}, _GEN_3998} : _GEN_4067; // @[CPU6502Core.scala 69:19]
  wire [2:0] _GEN_4114 = 3'h2 == state ? _GEN_3999 : _GEN_4076; // @[CPU6502Core.scala 69:19]
  wire [3:0] _GEN_4115 = 3'h1 == state ? {{3'd0}, _GEN_46} : _GEN_4113; // @[CPU6502Core.scala 69:19]
  wire [15:0] _GEN_4117 = 3'h1 == state ? regs_pc : _GEN_4096; // @[CPU6502Core.scala 69:19]
  wire  _GEN_4118 = 3'h1 == state ? _GEN_49 : _GEN_4099; // @[CPU6502Core.scala 69:19]
  wire [7:0] _GEN_4140 = 3'h1 == state ? 8'h0 : _GEN_4097; // @[CPU6502Core.scala 50:17 69:19]
  wire  _GEN_4141 = 3'h1 == state ? 1'h0 : _GEN_4098; // @[CPU6502Core.scala 51:17 69:19]
  wire [15:0] _GEN_4154 = 3'h0 == state ? _GEN_32 : _GEN_4117; // @[CPU6502Core.scala 69:19]
  wire  _GEN_4155 = 3'h0 == state | _GEN_4118; // @[CPU6502Core.scala 69:19]
  wire [3:0] _GEN_4156 = 3'h0 == state ? {{1'd0}, _GEN_34} : _GEN_4115; // @[CPU6502Core.scala 69:19]
  wire [7:0] _GEN_4182 = 3'h0 == state ? 8'h0 : _GEN_4140; // @[CPU6502Core.scala 50:17 69:19]
  wire  _GEN_4183 = 3'h0 == state ? 1'h0 : _GEN_4141; // @[CPU6502Core.scala 51:17 69:19]
  wire [3:0] _GEN_4194 = io_reset ? 4'h0 : _GEN_4156; // @[CPU6502Core.scala 59:18 62:11]
  wire [3:0] _GEN_4259 = reset ? 4'h0 : _GEN_4194; // @[CPU6502Core.scala 29:{24,24}]
  wire  _GEN_4262 = ~io_reset & ~_T_4; // @[CPU6502Core.scala 129:21]
  wire  _GEN_4266 = ~_T_5; // @[CPU6502Core.scala 129:21]
  wire  _GEN_4273 = _GEN_4262 & ~_T_10 & _T_14; // @[CPU6502Core.scala 136:17]
  wire  _GEN_4309 = _GEN_4273 & ~_execResult_T_14 & ~_execResult_T_25 & ~_execResult_T_36 & ~_execResult_T_37 & ~
    _execResult_T_38 & ~_execResult_T_41 & ~_execResult_T_44 & ~_execResult_T_47 & ~_execResult_T_50 & ~_execResult_T_53
     & ~_execResult_T_56 & ~_execResult_T_59 & ~_execResult_T_62 & ~_execResult_T_65 & ~_execResult_T_72; // @[CPU6502Core.scala 417:15]
  wire  _GEN_4339 = _GEN_4309 & ~_execResult_T_77 & ~_execResult_T_78 & ~_execResult_T_83 & ~_execResult_T_88 & ~
    _execResult_T_95 & ~_execResult_T_106 & ~_execResult_T_111 & ~_execResult_T_116 & ~_execResult_T_123 & ~
    _execResult_T_130 & ~_execResult_T_137 & ~_execResult_T_144 & ~_execResult_T_151 & ~_execResult_T_156 & ~
    _execResult_T_161; // @[CPU6502Core.scala 417:15]
  wire  _GEN_4354 = _GEN_4339 & ~_execResult_T_162 & ~_execResult_T_167 & ~_execResult_T_170 & ~_execResult_T_171 & ~
    _execResult_T_172 & ~_execResult_T_173 & ~_execResult_T_188 & _execResult_T_193; // @[CPU6502Core.scala 417:15]
  assign io_memAddr = io_reset ? regs_pc : _GEN_4154; // @[CPU6502Core.scala 49:17 59:18]
  assign io_memDataOut = io_reset ? 8'h0 : _GEN_4182; // @[CPU6502Core.scala 50:17 59:18]
  assign io_memWrite = io_reset ? 1'h0 : _GEN_4183; // @[CPU6502Core.scala 51:17 59:18]
  assign io_memRead = io_reset ? 1'h0 : _GEN_4155; // @[CPU6502Core.scala 52:17 59:18]
  assign io_debug_regA = regs_a; // @[DebugBundle.scala 23:21 24:16]
  assign io_debug_regX = regs_x; // @[DebugBundle.scala 23:21 25:16]
  assign io_debug_regY = regs_y; // @[DebugBundle.scala 23:21 26:16]
  assign io_debug_regPC = regs_pc; // @[DebugBundle.scala 23:21 27:17]
  assign io_debug_opcode = opcode; // @[DebugBundle.scala 23:21 33:18]
  assign io_debug_state = state[1:0]; // @[DebugBundle.scala 23:21 34:17]
  assign io_debug_cycle = cycle; // @[DebugBundle.scala 23:21 35:17]
  always @(posedge clock) begin
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_a <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_a <= _GEN_4100;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_x <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_x <= _GEN_4101;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_y <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_y <= _GEN_4102;
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
        regs_sp <= _GEN_4103;
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
        regs_pc <= _GEN_51;
      end else begin
        regs_pc <= _GEN_4104;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagC <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagC <= _GEN_4105;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagZ <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagZ <= _GEN_4106;
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
        regs_flagI <= _GEN_4107;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagD <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagD <= _GEN_4108;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagV <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagV <= _GEN_4110;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagN <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 59:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 69:19]
          regs_flagN <= _GEN_4111;
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
      state <= _GEN_47;
    end else begin
      state <= _GEN_4114;
    end
    if (reset) begin // @[CPU6502Core.scala 27:24]
      opcode <= 8'h0; // @[CPU6502Core.scala 27:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 59:18]
      opcode <= 8'h0; // @[CPU6502Core.scala 63:12]
    end else if (!(3'h0 == state)) begin // @[CPU6502Core.scala 69:19]
      if (3'h1 == state) begin // @[CPU6502Core.scala 69:19]
        opcode <= _GEN_50;
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
      operand <= _GEN_4112;
    end
    cycle <= _GEN_4259[2:0]; // @[CPU6502Core.scala 29:{24,24}]
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
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~io_reset & ~_T_4 & _T_10 & ~nmiPending & ~_T_5 & ~reset) begin
          $fwrite(32'h80000002,"[Fetch?Execute] opcode=0x%x PC=0x%x\n",io_memDataIn,regs_pc); // @[CPU6502Core.scala 129:21]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4262 & ~_T_10 & _T_14 & _T_13) begin
          $fwrite(32'h80000002,"[Execute] opcode=0x%x cycle=%d\n",opcode,cycle); // @[CPU6502Core.scala 136:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4339 & ~_execResult_T_162 & ~_execResult_T_167 & ~_execResult_T_170 & ~_execResult_T_171 & ~
          _execResult_T_172 & ~_execResult_T_173 & ~_execResult_T_188 & _execResult_T_193 & _T_13) begin
          $fwrite(32'h80000002,"[Dispatch] LDA/LDX/LDY immediate: opcode=0x%x cycle=%d\n",opcode,cycle); // @[CPU6502Core.scala 417:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4354 & _T_5 & _T_13) begin
          $fwrite(32'h80000002,"[LDA] Cycle 0: Reading immediate at PC=0x%x\n",regs_pc); // @[LoadStore.scala 37:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_4354 & _GEN_4266 & _T_13) begin
          $fwrite(32'h80000002,"[LDA] Cycle 1: Execute with data=0x%x\n",io_memDataIn); // @[LoadStore.scala 45:13]
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
  assign io_debug_opcode = core_io_debug_opcode; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_state = core_io_debug_state; // @[CPU6502Refactored.scala 27:17]
  assign io_debug_cycle = core_io_debug_cycle; // @[CPU6502Refactored.scala 27:17]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_memDataIn = io_memDataIn; // @[CPU6502Refactored.scala 24:21]
  assign core_io_reset = io_reset; // @[CPU6502Refactored.scala 28:17]
  assign core_io_nmi = io_nmi; // @[CPU6502Refactored.scala 29:17]
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
  input         io_setVBlank,
  input         io_clearVBlank,
  input         io_setSprite0Hit
);
  reg [7:0] regs_ppuCtrl; // @[PPURegisters.scala 63:21]
  reg [7:0] regs_ppuMask; // @[PPURegisters.scala 63:21]
  reg [7:0] regs_ppuStatus; // @[PPURegisters.scala 63:21]
  reg [15:0] regs_ppuAddr; // @[PPURegisters.scala 63:21]
  reg [7:0] regs_ppuData; // @[PPURegisters.scala 63:21]
  reg  regs_addrLatch; // @[PPURegisters.scala 63:21]
  reg  regs_vblank; // @[PPURegisters.scala 63:21]
  reg  regs_sprite0Hit; // @[PPURegisters.scala 63:21]
  wire [7:0] _io_cpuDataOut_T_1 = 3'h2 == io_cpuAddr ? regs_ppuStatus : 8'h0; // @[Mux.scala 81:58]
  wire  _io_cpuDataOut_T_2 = 3'h4 == io_cpuAddr; // @[Mux.scala 81:61]
  wire [7:0] _io_cpuDataOut_T_3 = 3'h4 == io_cpuAddr ? 8'h0 : _io_cpuDataOut_T_1; // @[Mux.scala 81:58]
  wire  _io_cpuDataOut_T_4 = 3'h7 == io_cpuAddr; // @[Mux.scala 81:61]
  wire  _T = 3'h0 == io_cpuAddr; // @[PPURegisters.scala 74:24]
  wire  _T_3 = ~reset; // @[PPURegisters.scala 77:15]
  wire  _T_10 = ~regs_addrLatch; // @[PPURegisters.scala 98:14]
  wire [15:0] _regs_ppuAddr_T_1 = {io_cpuDataIn,regs_ppuAddr[7:0]}; // @[Cat.scala 33:92]
  wire [15:0] _regs_ppuAddr_T_3 = {regs_ppuAddr[15:8],io_cpuDataIn}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_1 = ~regs_addrLatch ? _regs_ppuAddr_T_1 : _regs_ppuAddr_T_3; // @[PPURegisters.scala 101:24 98:31 99:24]
  wire [7:0] _GEN_2 = _io_cpuDataOut_T_4 ? io_cpuDataIn : regs_ppuData; // @[PPURegisters.scala 106:22 63:21 74:24]
  wire [15:0] _GEN_3 = 3'h6 == io_cpuAddr ? _GEN_1 : regs_ppuAddr; // @[PPURegisters.scala 63:21 74:24]
  wire  _GEN_4 = 3'h6 == io_cpuAddr ? _T_10 : regs_addrLatch; // @[PPURegisters.scala 103:24 63:21 74:24]
  wire [7:0] _GEN_5 = 3'h6 == io_cpuAddr ? regs_ppuData : _GEN_2; // @[PPURegisters.scala 63:21 74:24]
  wire [15:0] _GEN_8 = 3'h5 == io_cpuAddr ? regs_ppuAddr : _GEN_3; // @[PPURegisters.scala 63:21 74:24]
  wire  _GEN_9 = 3'h5 == io_cpuAddr ? regs_addrLatch : _GEN_4; // @[PPURegisters.scala 63:21 74:24]
  wire [7:0] _GEN_10 = 3'h5 == io_cpuAddr ? regs_ppuData : _GEN_5; // @[PPURegisters.scala 63:21 74:24]
  wire [15:0] _GEN_13 = _io_cpuDataOut_T_2 ? regs_ppuAddr : _GEN_8; // @[PPURegisters.scala 63:21 74:24]
  wire  _GEN_14 = _io_cpuDataOut_T_2 ? regs_addrLatch : _GEN_9; // @[PPURegisters.scala 63:21 74:24]
  wire [7:0] _GEN_15 = _io_cpuDataOut_T_2 ? regs_ppuData : _GEN_10; // @[PPURegisters.scala 63:21 74:24]
  wire [15:0] _GEN_19 = 3'h3 == io_cpuAddr ? regs_ppuAddr : _GEN_13; // @[PPURegisters.scala 63:21 74:24]
  wire  _GEN_20 = 3'h3 == io_cpuAddr ? regs_addrLatch : _GEN_14; // @[PPURegisters.scala 63:21 74:24]
  wire [7:0] _GEN_21 = 3'h3 == io_cpuAddr ? regs_ppuData : _GEN_15; // @[PPURegisters.scala 63:21 74:24]
  wire  _GEN_27 = 3'h1 == io_cpuAddr ? regs_addrLatch : _GEN_20; // @[PPURegisters.scala 63:21 74:24]
  wire  _T_13 = io_cpuRead & io_cpuAddr == 3'h2; // @[PPURegisters.scala 113:19]
  wire  _GEN_45 = io_cpuRead & io_cpuAddr == 3'h2 ? 1'h0 : regs_vblank; // @[PPURegisters.scala 113:42 115:17 63:21]
  wire  _GEN_48 = io_setVBlank | _GEN_45; // @[PPURegisters.scala 121:22 122:17]
  wire  _GEN_50 = io_setSprite0Hit | regs_sprite0Hit; // @[PPURegisters.scala 127:26 128:21 63:21]
  wire [7:0] _regs_ppuStatus_T = {regs_vblank,regs_sprite0Hit,6'h0}; // @[Cat.scala 33:92]
  assign io_cpuDataOut = 3'h7 == io_cpuAddr ? regs_ppuData : _io_cpuDataOut_T_3; // @[Mux.scala 81:58]
  assign io_regs_ppuCtrl = regs_ppuCtrl; // @[PPURegisters.scala 142:11]
  assign io_regs_ppuMask = regs_ppuMask; // @[PPURegisters.scala 142:11]
  assign io_regs_ppuAddr = regs_ppuAddr; // @[PPURegisters.scala 142:11]
  always @(posedge clock) begin
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuCtrl <= 8'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 73:21]
      if (3'h0 == io_cpuAddr) begin // @[PPURegisters.scala 74:24]
        regs_ppuCtrl <= io_cpuDataIn; // @[PPURegisters.scala 76:22]
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuMask <= 8'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 73:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPURegisters.scala 74:24]
        if (3'h1 == io_cpuAddr) begin // @[PPURegisters.scala 74:24]
          regs_ppuMask <= io_cpuDataIn; // @[PPURegisters.scala 81:22]
        end
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuStatus <= 8'h0; // @[PPURegisters.scala 63:21]
    end else begin
      regs_ppuStatus <= _regs_ppuStatus_T; // @[PPURegisters.scala 135:18]
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuAddr <= 16'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 73:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPURegisters.scala 74:24]
        if (!(3'h1 == io_cpuAddr)) begin // @[PPURegisters.scala 74:24]
          regs_ppuAddr <= _GEN_19;
        end
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_ppuData <= 8'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 73:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPURegisters.scala 74:24]
        if (!(3'h1 == io_cpuAddr)) begin // @[PPURegisters.scala 74:24]
          regs_ppuData <= _GEN_21;
        end
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_addrLatch <= 1'h0; // @[PPURegisters.scala 63:21]
    end else if (io_cpuRead & io_cpuAddr == 3'h2) begin // @[PPURegisters.scala 113:42]
      regs_addrLatch <= 1'h0; // @[PPURegisters.scala 116:20]
    end else if (io_cpuWrite) begin // @[PPURegisters.scala 73:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPURegisters.scala 74:24]
        regs_addrLatch <= _GEN_27;
      end
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_vblank <= 1'h0; // @[PPURegisters.scala 63:21]
    end else if (io_clearVBlank) begin // @[PPURegisters.scala 124:24]
      regs_vblank <= 1'h0; // @[PPURegisters.scala 125:17]
    end else begin
      regs_vblank <= _GEN_48;
    end
    if (reset) begin // @[PPURegisters.scala 63:21]
      regs_sprite0Hit <= 1'h0; // @[PPURegisters.scala 63:21]
    end else begin
      regs_sprite0Hit <= _GEN_50;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_cpuWrite & _T & ~reset) begin
          $fwrite(32'h80000002,"[PPU] Write PPUCTRL = 0x%x (NMI enable = %d)\n",io_cpuDataIn,io_cpuDataIn[7]); // @[PPURegisters.scala 77:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_13 & _T_3) begin
          $fwrite(32'h80000002,"[PPU] Read PPUSTATUS = 0x%x\n",regs_ppuStatus); // @[PPURegisters.scala 114:11]
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
  wire  regControl_io_setVBlank; // @[PPURefactored.scala 50:26]
  wire  regControl_io_clearVBlank; // @[PPURefactored.scala 50:26]
  wire  regControl_io_setSprite0Hit; // @[PPURefactored.scala 50:26]
  reg [7:0] chrRom [0:8191]; // @[PPURefactored.scala 104:27]
  wire  chrRom_patternLow_en; // @[PPURefactored.scala 104:27]
  wire [12:0] chrRom_patternLow_addr; // @[PPURefactored.scala 104:27]
  wire [7:0] chrRom_patternLow_data; // @[PPURefactored.scala 104:27]
  wire  chrRom_patternHigh_en; // @[PPURefactored.scala 104:27]
  wire [12:0] chrRom_patternHigh_addr; // @[PPURefactored.scala 104:27]
  wire [7:0] chrRom_patternHigh_data; // @[PPURefactored.scala 104:27]
  wire  chrRom_spritePatternLow_en; // @[PPURefactored.scala 104:27]
  wire [12:0] chrRom_spritePatternLow_addr; // @[PPURefactored.scala 104:27]
  wire [7:0] chrRom_spritePatternLow_data; // @[PPURefactored.scala 104:27]
  wire  chrRom_spritePatternHigh_en; // @[PPURefactored.scala 104:27]
  wire [12:0] chrRom_spritePatternHigh_addr; // @[PPURefactored.scala 104:27]
  wire [7:0] chrRom_spritePatternHigh_data; // @[PPURefactored.scala 104:27]
  wire [7:0] chrRom_MPORT_data; // @[PPURefactored.scala 104:27]
  wire [12:0] chrRom_MPORT_addr; // @[PPURefactored.scala 104:27]
  wire  chrRom_MPORT_mask; // @[PPURefactored.scala 104:27]
  wire  chrRom_MPORT_en; // @[PPURefactored.scala 104:27]
  reg  chrRom_patternLow_en_pipe_0;
  reg [12:0] chrRom_patternLow_addr_pipe_0;
  reg  chrRom_patternHigh_en_pipe_0;
  reg [12:0] chrRom_patternHigh_addr_pipe_0;
  reg  chrRom_spritePatternLow_en_pipe_0;
  reg [12:0] chrRom_spritePatternLow_addr_pipe_0;
  reg  chrRom_spritePatternHigh_en_pipe_0;
  reg [12:0] chrRom_spritePatternHigh_addr_pipe_0;
  reg [7:0] nametableRam [0:2047]; // @[PPURefactored.scala 118:33]
  wire  nametableRam_tileIndex_en; // @[PPURefactored.scala 118:33]
  wire [10:0] nametableRam_tileIndex_addr; // @[PPURefactored.scala 118:33]
  wire [7:0] nametableRam_tileIndex_data; // @[PPURefactored.scala 118:33]
  wire  nametableRam_attrByte_en; // @[PPURefactored.scala 118:33]
  wire [10:0] nametableRam_attrByte_addr; // @[PPURefactored.scala 118:33]
  wire [7:0] nametableRam_attrByte_data; // @[PPURefactored.scala 118:33]
  wire [7:0] nametableRam_MPORT_1_data; // @[PPURefactored.scala 118:33]
  wire [10:0] nametableRam_MPORT_1_addr; // @[PPURefactored.scala 118:33]
  wire  nametableRam_MPORT_1_mask; // @[PPURefactored.scala 118:33]
  wire  nametableRam_MPORT_1_en; // @[PPURefactored.scala 118:33]
  reg  nametableRam_tileIndex_en_pipe_0;
  reg [10:0] nametableRam_tileIndex_addr_pipe_0;
  reg  nametableRam_attrByte_en_pipe_0;
  reg [10:0] nametableRam_attrByte_addr_pipe_0;
  reg [8:0] scanline; // @[PPURefactored.scala 60:25]
  reg [8:0] pixel; // @[PPURefactored.scala 61:22]
  wire  _T_1 = scanline == 9'h105; // @[PPURefactored.scala 66:19]
  wire [8:0] _scanline_T_1 = scanline + 9'h1; // @[PPURefactored.scala 69:28]
  wire [8:0] _pixel_T_1 = pixel + 9'h1; // @[PPURefactored.scala 72:20]
  reg  vblankFlag; // @[PPURefactored.scala 76:27]
  wire  _T_3 = pixel == 9'h1; // @[PPURefactored.scala 82:36]
  wire  _T_4 = scanline == 9'hf1 & pixel == 9'h1; // @[PPURefactored.scala 82:27]
  wire  _T_7 = _T_1 & _T_3; // @[PPURefactored.scala 85:33]
  wire  _GEN_3 = _T_1 & _T_3 ? 1'h0 : vblankFlag; // @[PPURefactored.scala 85:51 86:16 76:27]
  wire  _GEN_5 = scanline == 9'hf1 & pixel == 9'h1 | _GEN_3; // @[PPURefactored.scala 82:45 83:16]
  wire  nmiEnable = regControl_io_regs_ppuCtrl[7]; // @[PPURefactored.scala 91:31]
  reg  nmiTrigger; // @[PPURefactored.scala 92:27]
  wire  _T_11 = _T_4 & nmiEnable; // @[PPURefactored.scala 95:44]
  reg [5:0] paletteRam_0; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_1; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_2; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_3; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_4; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_5; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_6; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_7; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_8; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_9; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_10; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_11; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_12; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_13; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_14; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_15; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_16; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_17; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_18; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_19; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_20; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_21; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_22; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_23; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_24; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_25; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_26; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_27; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_28; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_29; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_30; // @[PPURefactored.scala 110:27]
  reg [5:0] paletteRam_31; // @[PPURefactored.scala 110:27]
  wire  _T_13 = io_cpuWrite & io_cpuAddr == 3'h7; // @[PPURefactored.scala 121:20]
  wire [4:0] paletteAddr = regControl_io_regs_ppuAddr[4:0]; // @[PPURefactored.scala 125:32]
  wire  _T_19 = regControl_io_regs_ppuAddr >= 16'h2000 & regControl_io_regs_ppuAddr < 16'h3f00; // @[PPURefactored.scala 127:36]
  wire  _GEN_85 = regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff ? 1'h0 : _T_19; // @[PPURefactored.scala 118:33 123:54]
  wire  isRendering = scanline < 9'hf0 & pixel < 9'h100; // @[PPURefactored.scala 141:38]
  wire [11:0] nametableBase = {regControl_io_regs_ppuCtrl[1:0],10'h0}; // @[Cat.scala 33:92]
  wire [9:0] _tileX_T = {{1'd0}, pixel}; // @[PPURefactored.scala 153:22]
  wire [5:0] tileX = _tileX_T[8:3]; // @[PPURefactored.scala 153:33]
  wire [9:0] _tileY_T = {{1'd0}, scanline}; // @[PPURefactored.scala 154:25]
  wire [5:0] tileY = _tileY_T[8:3]; // @[PPURefactored.scala 154:36]
  wire [10:0] _tileAddr_T = {tileY, 5'h0}; // @[PPURefactored.scala 155:41]
  wire [11:0] _GEN_718 = {{1'd0}, _tileAddr_T}; // @[PPURefactored.scala 155:32]
  wire [11:0] _tileAddr_T_2 = nametableBase + _GEN_718; // @[PPURefactored.scala 155:32]
  wire [11:0] _GEN_719 = {{6'd0}, tileX}; // @[PPURefactored.scala 155:47]
  wire [11:0] tileAddr = _tileAddr_T_2 + _GEN_719; // @[PPURefactored.scala 155:47]
  wire [12:0] patternBase = regControl_io_regs_ppuCtrl[4] ? 13'h1000 : 13'h0; // @[PPURefactored.scala 158:24]
  wire [2:0] fineY = _tileY_T[2:0]; // @[PPURefactored.scala 159:35]
  wire [11:0] _patternAddr_T = {nametableRam_tileIndex_data, 4'h0}; // @[PPURefactored.scala 160:46]
  wire [12:0] _GEN_720 = {{1'd0}, _patternAddr_T}; // @[PPURefactored.scala 160:33]
  wire [12:0] _patternAddr_T_2 = patternBase + _GEN_720; // @[PPURefactored.scala 160:33]
  wire [12:0] _GEN_721 = {{10'd0}, fineY}; // @[PPURefactored.scala 160:52]
  wire [12:0] patternAddr = _patternAddr_T_2 + _GEN_721; // @[PPURefactored.scala 160:52]
  wire [2:0] fineX = _tileX_T[2:0]; // @[PPURefactored.scala 164:32]
  wire [2:0] bitPos = 3'h7 - fineX; // @[PPURefactored.scala 165:20]
  wire [7:0] _pixelBit_T = chrRom_patternHigh_data >> bitPos; // @[PPURefactored.scala 166:32]
  wire [1:0] _pixelBit_T_2 = {_pixelBit_T[0], 1'h0}; // @[PPURefactored.scala 166:46]
  wire [7:0] _pixelBit_T_3 = chrRom_patternLow_data >> bitPos; // @[PPURefactored.scala 166:67]
  wire [1:0] _GEN_722 = {{1'd0}, _pixelBit_T_3[0]}; // @[PPURefactored.scala 166:52]
  wire [1:0] pixelBit = _pixelBit_T_2 | _GEN_722; // @[PPURefactored.scala 166:52]
  wire [11:0] _attrAddr_T_1 = nametableBase + 12'h3c0; // @[PPURefactored.scala 168:32]
  wire [6:0] _attrAddr_T_3 = {tileY[5:2], 3'h0}; // @[PPURefactored.scala 168:58]
  wire [11:0] _GEN_723 = {{5'd0}, _attrAddr_T_3}; // @[PPURefactored.scala 168:42]
  wire [11:0] _attrAddr_T_5 = _attrAddr_T_1 + _GEN_723; // @[PPURefactored.scala 168:42]
  wire [11:0] _GEN_724 = {{8'd0}, tileX[5:2]}; // @[PPURefactored.scala 168:64]
  wire [11:0] attrAddr = _attrAddr_T_5 + _GEN_724; // @[PPURefactored.scala 168:64]
  wire [4:0] spriteSize = regControl_io_regs_ppuCtrl[5] ? 5'h10 : 5'h8; // @[PPURefactored.scala 181:23]
  wire  inSpriteX = pixel < 9'h8; // @[PPURefactored.scala 183:45]
  wire [7:0] _GEN_743 = {{3'd0}, spriteSize}; // @[PPURefactored.scala 184:62]
  wire [8:0] _inSpriteY_T_1 = {{1'd0}, _GEN_743}; // @[PPURefactored.scala 184:62]
  wire [8:0] _GEN_744 = {{1'd0}, _inSpriteY_T_1[7:0]}; // @[PPURefactored.scala 184:51]
  wire  inSpriteY = scanline < _GEN_744; // @[PPURefactored.scala 184:51]
  wire  spriteActive = inSpriteX & inSpriteY; // @[PPURefactored.scala 185:32]
  wire [8:0] spriteFineX = pixel - 9'h0; // @[PPURefactored.scala 187:27]
  wire [8:0] spriteFineY = scanline - 9'h0; // @[PPURefactored.scala 188:30]
  wire [12:0] spritePatternBase = regControl_io_regs_ppuCtrl[3] ? 13'h1000 : 13'h0; // @[PPURefactored.scala 189:30]
  wire [13:0] _spritePatternAddr_T_1 = {{1'd0}, spritePatternBase}; // @[PPURefactored.scala 190:45]
  wire [12:0] _GEN_745 = {{4'd0}, spriteFineY}; // @[PPURefactored.scala 190:65]
  wire [12:0] spritePatternAddr = _spritePatternAddr_T_1[12:0] + _GEN_745; // @[PPURefactored.scala 190:65]
  wire [8:0] spriteBitPos = 9'h7 - spriteFineX; // @[PPURefactored.scala 194:26]
  wire [7:0] _spritePixelBit_T = chrRom_spritePatternHigh_data >> spriteBitPos; // @[PPURefactored.scala 195:44]
  wire [1:0] _spritePixelBit_T_2 = {_spritePixelBit_T[0], 1'h0}; // @[PPURefactored.scala 195:64]
  wire [7:0] _spritePixelBit_T_3 = chrRom_spritePatternLow_data >> spriteBitPos; // @[PPURefactored.scala 195:91]
  wire [1:0] _GEN_746 = {{1'd0}, _spritePixelBit_T_3[0]}; // @[PPURefactored.scala 195:70]
  wire [1:0] spritePixelBit = _spritePixelBit_T_2 | _GEN_746; // @[PPURefactored.scala 195:70]
  reg [7:0] finalColor; // @[PPURefactored.scala 211:27]
  reg [7:0] patternLowReg; // @[PPURefactored.scala 215:30]
  reg [7:0] patternHighReg; // @[PPURefactored.scala 216:31]
  reg [7:0] attrByteReg; // @[PPURefactored.scala 217:28]
  reg [2:0] fineXReg; // @[PPURefactored.scala 220:25]
  wire [2:0] bitPosReg = 3'h7 - fineXReg; // @[PPURefactored.scala 221:23]
  wire [7:0] _pixelBitReg_T = patternHighReg >> bitPosReg; // @[PPURefactored.scala 222:38]
  wire [1:0] _pixelBitReg_T_2 = {_pixelBitReg_T[0], 1'h0}; // @[PPURefactored.scala 222:55]
  wire [7:0] _pixelBitReg_T_3 = patternLowReg >> bitPosReg; // @[PPURefactored.scala 222:79]
  wire [1:0] _GEN_748 = {{1'd0}, _pixelBitReg_T_3[0]}; // @[PPURefactored.scala 222:61]
  wire [1:0] pixelBitReg = _pixelBitReg_T_2 | _GEN_748; // @[PPURefactored.scala 222:61]
  reg [5:0] tileXReg; // @[PPURefactored.scala 224:25]
  reg [5:0] tileYReg; // @[PPURefactored.scala 225:25]
  wire [2:0] _attrShiftReg_T_1 = {tileYReg[1], 2'h0}; // @[PPURefactored.scala 226:36]
  wire [1:0] _attrShiftReg_T_3 = {tileXReg[1], 1'h0}; // @[PPURefactored.scala 226:57]
  wire [2:0] _GEN_749 = {{1'd0}, _attrShiftReg_T_3}; // @[PPURefactored.scala 226:42]
  wire [2:0] attrShiftReg = _attrShiftReg_T_1 | _GEN_749; // @[PPURefactored.scala 226:42]
  wire [7:0] _paletteIdxReg_T = attrByteReg >> attrShiftReg; // @[PPURefactored.scala 227:36]
  wire [1:0] paletteIdxReg = _paletteIdxReg_T[1:0]; // @[PPURefactored.scala 227:52]
  wire [3:0] _bgPaletteAddrReg_T = {paletteIdxReg, 2'h0}; // @[PPURefactored.scala 229:41]
  wire [3:0] _GEN_750 = {{2'd0}, pixelBitReg}; // @[PPURefactored.scala 229:47]
  wire [3:0] bgPaletteAddrReg = _bgPaletteAddrReg_T | _GEN_750; // @[PPURefactored.scala 229:47]
  wire [5:0] _GEN_685 = 4'h1 == bgPaletteAddrReg ? paletteRam_1 : paletteRam_0; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_686 = 4'h2 == bgPaletteAddrReg ? paletteRam_2 : _GEN_685; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_687 = 4'h3 == bgPaletteAddrReg ? paletteRam_3 : _GEN_686; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_688 = 4'h4 == bgPaletteAddrReg ? paletteRam_4 : _GEN_687; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_689 = 4'h5 == bgPaletteAddrReg ? paletteRam_5 : _GEN_688; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_690 = 4'h6 == bgPaletteAddrReg ? paletteRam_6 : _GEN_689; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_691 = 4'h7 == bgPaletteAddrReg ? paletteRam_7 : _GEN_690; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_692 = 4'h8 == bgPaletteAddrReg ? paletteRam_8 : _GEN_691; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_693 = 4'h9 == bgPaletteAddrReg ? paletteRam_9 : _GEN_692; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_694 = 4'ha == bgPaletteAddrReg ? paletteRam_10 : _GEN_693; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_695 = 4'hb == bgPaletteAddrReg ? paletteRam_11 : _GEN_694; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_696 = 4'hc == bgPaletteAddrReg ? paletteRam_12 : _GEN_695; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_697 = 4'hd == bgPaletteAddrReg ? paletteRam_13 : _GEN_696; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_698 = 4'he == bgPaletteAddrReg ? paletteRam_14 : _GEN_697; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_699 = 4'hf == bgPaletteAddrReg ? paletteRam_15 : _GEN_698; // @[PPURefactored.scala 230:{23,23}]
  wire [4:0] _GEN_751 = {{1'd0}, bgPaletteAddrReg}; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_700 = 5'h10 == _GEN_751 ? paletteRam_16 : _GEN_699; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_701 = 5'h11 == _GEN_751 ? paletteRam_17 : _GEN_700; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_702 = 5'h12 == _GEN_751 ? paletteRam_18 : _GEN_701; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_703 = 5'h13 == _GEN_751 ? paletteRam_19 : _GEN_702; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_704 = 5'h14 == _GEN_751 ? paletteRam_20 : _GEN_703; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_705 = 5'h15 == _GEN_751 ? paletteRam_21 : _GEN_704; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_706 = 5'h16 == _GEN_751 ? paletteRam_22 : _GEN_705; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_707 = 5'h17 == _GEN_751 ? paletteRam_23 : _GEN_706; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_708 = 5'h18 == _GEN_751 ? paletteRam_24 : _GEN_707; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_709 = 5'h19 == _GEN_751 ? paletteRam_25 : _GEN_708; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_710 = 5'h1a == _GEN_751 ? paletteRam_26 : _GEN_709; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_711 = 5'h1b == _GEN_751 ? paletteRam_27 : _GEN_710; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_712 = 5'h1c == _GEN_751 ? paletteRam_28 : _GEN_711; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_713 = 5'h1d == _GEN_751 ? paletteRam_29 : _GEN_712; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_714 = 5'h1e == _GEN_751 ? paletteRam_30 : _GEN_713; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] _GEN_715 = 5'h1f == _GEN_751 ? paletteRam_31 : _GEN_714; // @[PPURefactored.scala 230:{23,23}]
  wire [5:0] bgColorReg = pixelBitReg == 2'h0 ? paletteRam_0 : _GEN_715; // @[PPURefactored.scala 230:23]
  wire [5:0] _GEN_716 = pixelBitReg != 2'h0 ? bgColorReg : paletteRam_0; // @[PPURefactored.scala 233:16 234:31 236:18]
  wire [5:0] _GEN_717 = isRendering ? _GEN_716 : paletteRam_0; // @[PPURefactored.scala 232:21 239:16]
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
    .io_setVBlank(regControl_io_setVBlank),
    .io_clearVBlank(regControl_io_clearVBlank),
    .io_setSprite0Hit(regControl_io_setSprite0Hit)
  );
  assign chrRom_patternLow_en = chrRom_patternLow_en_pipe_0;
  assign chrRom_patternLow_addr = chrRom_patternLow_addr_pipe_0;
  assign chrRom_patternLow_data = chrRom[chrRom_patternLow_addr]; // @[PPURefactored.scala 104:27]
  assign chrRom_patternHigh_en = chrRom_patternHigh_en_pipe_0;
  assign chrRom_patternHigh_addr = chrRom_patternHigh_addr_pipe_0;
  assign chrRom_patternHigh_data = chrRom[chrRom_patternHigh_addr]; // @[PPURefactored.scala 104:27]
  assign chrRom_spritePatternLow_en = chrRom_spritePatternLow_en_pipe_0;
  assign chrRom_spritePatternLow_addr = chrRom_spritePatternLow_addr_pipe_0;
  assign chrRom_spritePatternLow_data = chrRom[chrRom_spritePatternLow_addr]; // @[PPURefactored.scala 104:27]
  assign chrRom_spritePatternHigh_en = chrRom_spritePatternHigh_en_pipe_0;
  assign chrRom_spritePatternHigh_addr = chrRom_spritePatternHigh_addr_pipe_0;
  assign chrRom_spritePatternHigh_data = chrRom[chrRom_spritePatternHigh_addr]; // @[PPURefactored.scala 104:27]
  assign chrRom_MPORT_data = io_chrLoadData;
  assign chrRom_MPORT_addr = io_chrLoadAddr;
  assign chrRom_MPORT_mask = 1'h1;
  assign chrRom_MPORT_en = io_chrLoadEn;
  assign nametableRam_tileIndex_en = nametableRam_tileIndex_en_pipe_0;
  assign nametableRam_tileIndex_addr = nametableRam_tileIndex_addr_pipe_0;
  assign nametableRam_tileIndex_data = nametableRam[nametableRam_tileIndex_addr]; // @[PPURefactored.scala 118:33]
  assign nametableRam_attrByte_en = nametableRam_attrByte_en_pipe_0;
  assign nametableRam_attrByte_addr = nametableRam_attrByte_addr_pipe_0;
  assign nametableRam_attrByte_data = nametableRam[nametableRam_attrByte_addr]; // @[PPURefactored.scala 118:33]
  assign nametableRam_MPORT_1_data = io_cpuDataIn;
  assign nametableRam_MPORT_1_addr = regControl_io_regs_ppuAddr[10:0];
  assign nametableRam_MPORT_1_mask = 1'h1;
  assign nametableRam_MPORT_1_en = _T_13 & _GEN_85;
  assign io_cpuDataOut = regControl_io_cpuDataOut; // @[PPURefactored.scala 55:17]
  assign io_pixelX = pixel; // @[PPURefactored.scala 243:13]
  assign io_pixelY = scanline; // @[PPURefactored.scala 244:13]
  assign io_pixelColor = finalColor[5:0]; // @[PPURefactored.scala 245:30]
  assign io_vblank = vblankFlag; // @[PPURefactored.scala 246:13]
  assign io_nmiOut = nmiTrigger; // @[PPURefactored.scala 101:13]
  assign io_debug_ppuCtrl = regControl_io_regs_ppuCtrl; // @[PPURefactored.scala 252:20]
  assign io_debug_ppuMask = regControl_io_regs_ppuMask; // @[PPURefactored.scala 253:20]
  assign regControl_clock = clock;
  assign regControl_reset = reset;
  assign regControl_io_cpuAddr = io_cpuAddr; // @[PPURefactored.scala 51:25]
  assign regControl_io_cpuDataIn = io_cpuDataIn; // @[PPURefactored.scala 52:27]
  assign regControl_io_cpuWrite = io_cpuWrite; // @[PPURefactored.scala 53:26]
  assign regControl_io_cpuRead = io_cpuRead; // @[PPURefactored.scala 54:25]
  assign regControl_io_setVBlank = scanline == 9'hf1 & pixel == 9'h1; // @[PPURefactored.scala 82:27]
  assign regControl_io_clearVBlank = scanline == 9'hf1 & pixel == 9'h1 ? 1'h0 : _T_7; // @[PPURefactored.scala 78:29 82:45]
  assign regControl_io_setSprite0Hit = spriteActive & spritePixelBit != 2'h0 & pixelBit != 2'h0 & pixel != 9'hff; // @[PPURefactored.scala 202:67]
  always @(posedge clock) begin
    if (chrRom_MPORT_en & chrRom_MPORT_mask) begin
      chrRom[chrRom_MPORT_addr] <= chrRom_MPORT_data; // @[PPURefactored.scala 104:27]
    end
    chrRom_patternLow_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      chrRom_patternLow_addr_pipe_0 <= _patternAddr_T_2 + _GEN_721;
    end
    chrRom_patternHigh_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      chrRom_patternHigh_addr_pipe_0 <= patternAddr + 13'h8;
    end
    chrRom_spritePatternLow_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      chrRom_spritePatternLow_addr_pipe_0 <= _spritePatternAddr_T_1[12:0] + _GEN_745;
    end
    chrRom_spritePatternHigh_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      chrRom_spritePatternHigh_addr_pipe_0 <= spritePatternAddr + 13'h8;
    end
    if (nametableRam_MPORT_1_en & nametableRam_MPORT_1_mask) begin
      nametableRam[nametableRam_MPORT_1_addr] <= nametableRam_MPORT_1_data; // @[PPURefactored.scala 118:33]
    end
    nametableRam_tileIndex_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      nametableRam_tileIndex_addr_pipe_0 <= tileAddr[10:0];
    end
    nametableRam_attrByte_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      nametableRam_attrByte_addr_pipe_0 <= attrAddr[10:0];
    end
    if (reset) begin // @[PPURefactored.scala 60:25]
      scanline <= 9'h0; // @[PPURefactored.scala 60:25]
    end else if (pixel == 9'h154) begin // @[PPURefactored.scala 64:25]
      if (scanline == 9'h105) begin // @[PPURefactored.scala 66:30]
        scanline <= 9'h0; // @[PPURefactored.scala 67:16]
      end else begin
        scanline <= _scanline_T_1; // @[PPURefactored.scala 69:16]
      end
    end
    if (reset) begin // @[PPURefactored.scala 61:22]
      pixel <= 9'h0; // @[PPURefactored.scala 61:22]
    end else if (pixel == 9'h154) begin // @[PPURefactored.scala 64:25]
      pixel <= 9'h0; // @[PPURefactored.scala 65:11]
    end else begin
      pixel <= _pixel_T_1; // @[PPURefactored.scala 72:11]
    end
    if (reset) begin // @[PPURefactored.scala 76:27]
      vblankFlag <= 1'h0; // @[PPURefactored.scala 76:27]
    end else begin
      vblankFlag <= _GEN_5;
    end
    if (reset) begin // @[PPURefactored.scala 92:27]
      nmiTrigger <= 1'h0; // @[PPURefactored.scala 92:27]
    end else begin
      nmiTrigger <= _T_11;
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_0 <= 6'h9; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h0 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_0 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_1 <= 6'h1; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h1 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_1 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_2 <= 6'h0; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h2 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_2 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_3 <= 6'h1; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h3 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_3 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_4 <= 6'h0; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h4 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_4 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_5 <= 6'h2; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h5 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_5 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_6 <= 6'h2; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h6 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_6 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_7 <= 6'hd; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h7 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_7 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_8 <= 6'h8; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h8 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_8 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_9 <= 6'h10; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h9 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_9 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_10 <= 6'h8; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'ha == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_10 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_11 <= 6'h24; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'hb == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_11 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_12 <= 6'h0; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'hc == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_12 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_13 <= 6'h0; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'hd == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_13 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_14 <= 6'h4; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'he == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_14 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_15 <= 6'h2c; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'hf == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_15 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_16 <= 6'h9; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h10 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_16 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_17 <= 6'h1; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h11 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_17 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_18 <= 6'h34; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h12 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_18 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_19 <= 6'h3; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h13 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_19 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_20 <= 6'h0; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h14 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_20 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_21 <= 6'h4; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h15 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_21 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_22 <= 6'h0; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h16 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_22 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_23 <= 6'h14; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h17 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_23 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_24 <= 6'h8; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h18 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_24 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_25 <= 6'h3a; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h19 == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_25 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_26 <= 6'h0; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h1a == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_26 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_27 <= 6'h2; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h1b == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_27 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_28 <= 6'h0; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h1c == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_28 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_29 <= 6'h20; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h1d == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_29 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_30 <= 6'h2c; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h1e == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_30 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 110:27]
      paletteRam_31 <= 6'h8; // @[PPURefactored.scala 110:27]
    end else if (io_cpuWrite & io_cpuAddr == 3'h7) begin // @[PPURefactored.scala 121:43]
      if (regControl_io_regs_ppuAddr >= 16'h3f00 & regControl_io_regs_ppuAddr <= 16'h3fff) begin // @[PPURefactored.scala 123:54]
        if (5'h1f == paletteAddr) begin // @[PPURefactored.scala 126:31]
          paletteRam_31 <= io_cpuDataIn[5:0]; // @[PPURefactored.scala 126:31]
        end
      end
    end
    if (reset) begin // @[PPURefactored.scala 211:27]
      finalColor <= 8'h0; // @[PPURefactored.scala 211:27]
    end else begin
      finalColor <= {{2'd0}, _GEN_717};
    end
    patternLowReg <= chrRom_patternLow_data; // @[PPURefactored.scala 215:30]
    patternHighReg <= chrRom_patternHigh_data; // @[PPURefactored.scala 216:31]
    attrByteReg <= nametableRam_attrByte_data; // @[PPURefactored.scala 217:28]
    fineXReg <= _tileX_T[2:0]; // @[PPURefactored.scala 164:32]
    tileXReg <= _tileX_T[8:3]; // @[PPURefactored.scala 153:33]
    tileYReg <= _tileY_T[8:3]; // @[PPURefactored.scala 154:36]
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
  input  [15:0] io_prgLoadAddr,
  input  [7:0]  io_prgLoadData,
  input         io_chrLoadEn,
  input  [12:0] io_chrLoadAddr,
  input  [7:0]  io_chrLoadData,
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
  output [7:0]  io_debug_cpuOpcode
);
  wire  cpu_clock; // @[NESSystemRefactored.scala 54:19]
  wire  cpu_reset; // @[NESSystemRefactored.scala 54:19]
  wire [15:0] cpu_io_memAddr; // @[NESSystemRefactored.scala 54:19]
  wire [7:0] cpu_io_memDataOut; // @[NESSystemRefactored.scala 54:19]
  wire [7:0] cpu_io_memDataIn; // @[NESSystemRefactored.scala 54:19]
  wire  cpu_io_memWrite; // @[NESSystemRefactored.scala 54:19]
  wire  cpu_io_memRead; // @[NESSystemRefactored.scala 54:19]
  wire [7:0] cpu_io_debug_regA; // @[NESSystemRefactored.scala 54:19]
  wire [7:0] cpu_io_debug_regX; // @[NESSystemRefactored.scala 54:19]
  wire [7:0] cpu_io_debug_regY; // @[NESSystemRefactored.scala 54:19]
  wire [15:0] cpu_io_debug_regPC; // @[NESSystemRefactored.scala 54:19]
  wire [7:0] cpu_io_debug_opcode; // @[NESSystemRefactored.scala 54:19]
  wire [1:0] cpu_io_debug_state; // @[NESSystemRefactored.scala 54:19]
  wire [2:0] cpu_io_debug_cycle; // @[NESSystemRefactored.scala 54:19]
  wire  cpu_io_reset; // @[NESSystemRefactored.scala 54:19]
  wire  cpu_io_nmi; // @[NESSystemRefactored.scala 54:19]
  wire  ppu_clock; // @[NESSystemRefactored.scala 57:19]
  wire  ppu_reset; // @[NESSystemRefactored.scala 57:19]
  wire [2:0] ppu_io_cpuAddr; // @[NESSystemRefactored.scala 57:19]
  wire [7:0] ppu_io_cpuDataIn; // @[NESSystemRefactored.scala 57:19]
  wire [7:0] ppu_io_cpuDataOut; // @[NESSystemRefactored.scala 57:19]
  wire  ppu_io_cpuWrite; // @[NESSystemRefactored.scala 57:19]
  wire  ppu_io_cpuRead; // @[NESSystemRefactored.scala 57:19]
  wire [8:0] ppu_io_pixelX; // @[NESSystemRefactored.scala 57:19]
  wire [8:0] ppu_io_pixelY; // @[NESSystemRefactored.scala 57:19]
  wire [5:0] ppu_io_pixelColor; // @[NESSystemRefactored.scala 57:19]
  wire  ppu_io_vblank; // @[NESSystemRefactored.scala 57:19]
  wire  ppu_io_nmiOut; // @[NESSystemRefactored.scala 57:19]
  wire  ppu_io_chrLoadEn; // @[NESSystemRefactored.scala 57:19]
  wire [12:0] ppu_io_chrLoadAddr; // @[NESSystemRefactored.scala 57:19]
  wire [7:0] ppu_io_chrLoadData; // @[NESSystemRefactored.scala 57:19]
  wire [7:0] ppu_io_debug_ppuCtrl; // @[NESSystemRefactored.scala 57:19]
  wire [7:0] ppu_io_debug_ppuMask; // @[NESSystemRefactored.scala 57:19]
  reg [7:0] prgRom [0:32767]; // @[NESSystemRefactored.scala 63:27]
  wire  prgRom_prgData_en; // @[NESSystemRefactored.scala 63:27]
  wire [14:0] prgRom_prgData_addr; // @[NESSystemRefactored.scala 63:27]
  wire [7:0] prgRom_prgData_data; // @[NESSystemRefactored.scala 63:27]
  wire [7:0] prgRom_MPORT_data; // @[NESSystemRefactored.scala 63:27]
  wire [14:0] prgRom_MPORT_addr; // @[NESSystemRefactored.scala 63:27]
  wire  prgRom_MPORT_mask; // @[NESSystemRefactored.scala 63:27]
  wire  prgRom_MPORT_en; // @[NESSystemRefactored.scala 63:27]
  reg  prgRom_prgData_en_pipe_0;
  reg [14:0] prgRom_prgData_addr_pipe_0;
  reg [7:0] ram [0:2047]; // @[NESSystemRefactored.scala 69:24]
  wire  ram_ramData_en; // @[NESSystemRefactored.scala 69:24]
  wire [10:0] ram_ramData_addr; // @[NESSystemRefactored.scala 69:24]
  wire [7:0] ram_ramData_data; // @[NESSystemRefactored.scala 69:24]
  wire [7:0] ram_MPORT_1_data; // @[NESSystemRefactored.scala 69:24]
  wire [10:0] ram_MPORT_1_addr; // @[NESSystemRefactored.scala 69:24]
  wire  ram_MPORT_1_mask; // @[NESSystemRefactored.scala 69:24]
  wire  ram_MPORT_1_en; // @[NESSystemRefactored.scala 69:24]
  reg  ram_ramData_en_pipe_0;
  reg [10:0] ram_ramData_addr_pipe_0;
  wire  isRam = cpu_io_memAddr < 16'h2000; // @[NESSystemRefactored.scala 73:23]
  wire  isPpuReg = cpu_io_memAddr >= 16'h2000 & cpu_io_memAddr < 16'h4000; // @[NESSystemRefactored.scala 74:38]
  wire  _isController_T = cpu_io_memAddr == 16'h4016; // @[NESSystemRefactored.scala 76:30]
  wire  isController = cpu_io_memAddr == 16'h4016 | cpu_io_memAddr == 16'h4017; // @[NESSystemRefactored.scala 76:43]
  wire  isPrgRom = cpu_io_memAddr >= 16'h8000; // @[NESSystemRefactored.scala 77:26]
  reg [7:0] controller1Shift; // @[NESSystemRefactored.scala 80:33]
  reg [7:0] controller2Shift; // @[NESSystemRefactored.scala 81:33]
  reg  controllerStrobe; // @[NESSystemRefactored.scala 82:33]
  wire [7:0] _GEN_5 = cpu_io_memDataOut[0] ? io_controller1 : controller1Shift; // @[NESSystemRefactored.scala 86:32 88:24 80:33]
  wire [7:0] _GEN_6 = cpu_io_memDataOut[0] ? io_controller2 : controller2Shift; // @[NESSystemRefactored.scala 86:32 89:24 81:33]
  wire [7:0] _GEN_8 = cpu_io_memWrite & _isController_T ? _GEN_5 : controller1Shift; // @[NESSystemRefactored.scala 80:33 84:49]
  wire [7:0] _GEN_9 = cpu_io_memWrite & _isController_T ? _GEN_6 : controller2Shift; // @[NESSystemRefactored.scala 81:33 84:49]
  wire  controller1Data = controller1Shift[0]; // @[NESSystemRefactored.scala 94:41]
  wire  controller2Data = controller2Shift[0]; // @[NESSystemRefactored.scala 95:41]
  wire  controllerData = cpu_io_memAddr[0] ? controller2Data : controller1Data; // @[NESSystemRefactored.scala 105:27]
  wire [13:0] prgAddr = cpu_io_memAddr[14] ? cpu_io_memAddr[13:0] : cpu_io_memAddr[13:0]; // @[NESSystemRefactored.scala 115:20]
  wire [7:0] _cpu_io_memDataIn_T = isPrgRom ? prgRom_prgData_data : 8'h0; // @[Mux.scala 101:16]
  wire [7:0] _cpu_io_memDataIn_T_1 = isController ? {{7'd0}, controllerData} : _cpu_io_memDataIn_T; // @[Mux.scala 101:16]
  wire [7:0] _cpu_io_memDataIn_T_2 = isPpuReg ? ppu_io_cpuDataOut : _cpu_io_memDataIn_T_1; // @[Mux.scala 101:16]
  wire  _ppu_io_cpuWrite_T = cpu_io_memWrite & isPpuReg; // @[NESSystemRefactored.scala 136:38]
  CPU6502Refactored cpu ( // @[NESSystemRefactored.scala 54:19]
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
  PPURefactored ppu ( // @[NESSystemRefactored.scala 57:19]
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
  assign prgRom_prgData_en = prgRom_prgData_en_pipe_0;
  assign prgRom_prgData_addr = prgRom_prgData_addr_pipe_0;
  assign prgRom_prgData_data = prgRom[prgRom_prgData_addr]; // @[NESSystemRefactored.scala 63:27]
  assign prgRom_MPORT_data = io_prgLoadData;
  assign prgRom_MPORT_addr = io_prgLoadAddr[14:0];
  assign prgRom_MPORT_mask = 1'h1;
  assign prgRom_MPORT_en = io_prgLoadEn;
  assign ram_ramData_en = ram_ramData_en_pipe_0;
  assign ram_ramData_addr = ram_ramData_addr_pipe_0;
  assign ram_ramData_data = ram[ram_ramData_addr]; // @[NESSystemRefactored.scala 69:24]
  assign ram_MPORT_1_data = cpu_io_memDataOut;
  assign ram_MPORT_1_addr = cpu_io_memAddr[10:0];
  assign ram_MPORT_1_mask = 1'h1;
  assign ram_MPORT_1_en = cpu_io_memWrite & isRam;
  assign io_pixelX = ppu_io_pixelX; // @[NESSystemRefactored.scala 161:13]
  assign io_pixelY = ppu_io_pixelY; // @[NESSystemRefactored.scala 162:13]
  assign io_pixelColor = ppu_io_pixelColor; // @[NESSystemRefactored.scala 163:17]
  assign io_vblank = ppu_io_vblank; // @[NESSystemRefactored.scala 164:13]
  assign io_audioOut = 16'h0; // @[NESSystemRefactored.scala 165:15]
  assign io_debug_cpuPC = cpu_io_debug_regPC; // @[NESSystemRefactored.scala 168:18]
  assign io_debug_cpuA = cpu_io_debug_regA; // @[NESSystemRefactored.scala 169:17]
  assign io_debug_cpuX = cpu_io_debug_regX; // @[NESSystemRefactored.scala 170:17]
  assign io_debug_cpuY = cpu_io_debug_regY; // @[NESSystemRefactored.scala 171:17]
  assign io_debug_ppuCtrl = ppu_io_debug_ppuCtrl; // @[NESSystemRefactored.scala 175:20]
  assign io_debug_ppuMask = ppu_io_debug_ppuMask; // @[NESSystemRefactored.scala 176:20]
  assign io_debug_vblank = ppu_io_vblank; // @[NESSystemRefactored.scala 177:19]
  assign io_debug_nmi = ppu_io_nmiOut; // @[NESSystemRefactored.scala 178:16]
  assign io_debug_apuPulse1Active = 1'h0; // @[NESSystemRefactored.scala 179:28]
  assign io_debug_apuPulse2Active = 1'h0; // @[NESSystemRefactored.scala 180:28]
  assign io_debug_cpuState = {{1'd0}, cpu_io_debug_state}; // @[NESSystemRefactored.scala 172:21]
  assign io_debug_cpuCycle = cpu_io_debug_cycle; // @[NESSystemRefactored.scala 173:21]
  assign io_debug_cpuOpcode = cpu_io_debug_opcode; // @[NESSystemRefactored.scala 174:22]
  assign cpu_clock = clock;
  assign cpu_reset = reset;
  assign cpu_io_memDataIn = isRam ? ram_ramData_data : _cpu_io_memDataIn_T_2; // @[Mux.scala 101:16]
  assign cpu_io_reset = reset; // @[NESSystemRefactored.scala 157:25]
  assign cpu_io_nmi = ppu_io_nmiOut; // @[NESSystemRefactored.scala 158:14]
  assign ppu_clock = clock;
  assign ppu_reset = reset;
  assign ppu_io_cpuAddr = cpu_io_memAddr[2:0]; // @[NESSystemRefactored.scala 134:28]
  assign ppu_io_cpuDataIn = cpu_io_memDataOut; // @[NESSystemRefactored.scala 135:20]
  assign ppu_io_cpuWrite = cpu_io_memWrite & isPpuReg; // @[NESSystemRefactored.scala 136:38]
  assign ppu_io_cpuRead = cpu_io_memRead & isPpuReg; // @[NESSystemRefactored.scala 137:36]
  assign ppu_io_chrLoadEn = io_chrLoadEn; // @[NESSystemRefactored.scala 146:20]
  assign ppu_io_chrLoadAddr = io_chrLoadAddr; // @[NESSystemRefactored.scala 147:22]
  assign ppu_io_chrLoadData = io_chrLoadData; // @[NESSystemRefactored.scala 148:22]
  always @(posedge clock) begin
    if (prgRom_MPORT_en & prgRom_MPORT_mask) begin
      prgRom[prgRom_MPORT_addr] <= prgRom_MPORT_data; // @[NESSystemRefactored.scala 63:27]
    end
    prgRom_prgData_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      prgRom_prgData_addr_pipe_0 <= {{1'd0}, prgAddr};
    end
    if (ram_MPORT_1_en & ram_MPORT_1_mask) begin
      ram[ram_MPORT_1_addr] <= ram_MPORT_1_data; // @[NESSystemRefactored.scala 69:24]
    end
    ram_ramData_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      ram_ramData_addr_pipe_0 <= cpu_io_memAddr[10:0];
    end
    if (reset) begin // @[NESSystemRefactored.scala 80:33]
      controller1Shift <= 8'h0; // @[NESSystemRefactored.scala 80:33]
    end else if (cpu_io_memRead & isController & ~controllerStrobe) begin // @[NESSystemRefactored.scala 97:61]
      if (_isController_T) begin // @[NESSystemRefactored.scala 98:32]
        controller1Shift <= {{1'd0}, controller1Shift[7:1]}; // @[NESSystemRefactored.scala 99:24]
      end else begin
        controller1Shift <= _GEN_8;
      end
    end else begin
      controller1Shift <= _GEN_8;
    end
    if (reset) begin // @[NESSystemRefactored.scala 81:33]
      controller2Shift <= 8'h0; // @[NESSystemRefactored.scala 81:33]
    end else if (cpu_io_memRead & isController & ~controllerStrobe) begin // @[NESSystemRefactored.scala 97:61]
      if (_isController_T) begin // @[NESSystemRefactored.scala 98:32]
        controller2Shift <= _GEN_9;
      end else begin
        controller2Shift <= {{1'd0}, controller2Shift[7:1]}; // @[NESSystemRefactored.scala 101:24]
      end
    end else begin
      controller2Shift <= _GEN_9;
    end
    if (reset) begin // @[NESSystemRefactored.scala 82:33]
      controllerStrobe <= 1'h0; // @[NESSystemRefactored.scala 82:33]
    end else if (cpu_io_memWrite & _isController_T) begin // @[NESSystemRefactored.scala 84:49]
      controllerStrobe <= cpu_io_memDataOut[0]; // @[NESSystemRefactored.scala 85:22]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_ppu_io_cpuWrite_T & ~reset) begin
          $fwrite(32'h80000002,"[PPU Write] Addr=$%x RegAddr=%d Data=0x%x\n",cpu_io_memAddr,cpu_io_memAddr[2:0],
            cpu_io_memDataOut); // @[NESSystemRefactored.scala 141:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
