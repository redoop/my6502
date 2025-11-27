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
  wire  _GEN_0 = io_nmi & ~nmiLast | nmiEdge; // @[CPU6502Core.scala 36:28 37:13 33:24]
  wire  _T_3 = cycle == 3'h0; // @[CPU6502Core.scala 63:22]
  wire  _T_4 = cycle == 3'h1; // @[CPU6502Core.scala 69:28]
  wire  _T_5 = cycle == 3'h2; // @[CPU6502Core.scala 76:28]
  wire  _T_6 = cycle == 3'h3; // @[CPU6502Core.scala 82:28]
  wire [15:0] resetVector = {io_memDataIn,operand[7:0]}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_3 = cycle == 3'h3 ? 3'h4 : 3'h0; // @[CPU6502Core.scala 82:37 86:19 96:19]
  wire [15:0] _GEN_4 = cycle == 3'h3 ? regs_pc : resetVector; // @[CPU6502Core.scala 21:21 82:37 93:21]
  wire [7:0] _GEN_5 = cycle == 3'h3 ? regs_sp : 8'hfd; // @[CPU6502Core.scala 21:21 82:37 94:21]
  wire  _GEN_6 = cycle == 3'h3 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 21:21 82:37 95:24]
  wire [2:0] _GEN_7 = cycle == 3'h3 ? state : 3'h1; // @[CPU6502Core.scala 25:22 82:37 97:19]
  wire [2:0] _GEN_10 = cycle == 3'h2 ? 3'h3 : _GEN_3; // @[CPU6502Core.scala 76:37 80:19]
  wire [15:0] _GEN_11 = cycle == 3'h2 ? regs_pc : _GEN_4; // @[CPU6502Core.scala 21:21 76:37]
  wire [7:0] _GEN_12 = cycle == 3'h2 ? regs_sp : _GEN_5; // @[CPU6502Core.scala 21:21 76:37]
  wire  _GEN_13 = cycle == 3'h2 ? regs_flagI : _GEN_6; // @[CPU6502Core.scala 21:21 76:37]
  wire [2:0] _GEN_14 = cycle == 3'h2 ? state : _GEN_7; // @[CPU6502Core.scala 25:22 76:37]
  wire [15:0] _GEN_15 = cycle == 3'h1 ? 16'hfffc : 16'hfffd; // @[CPU6502Core.scala 69:37 71:24]
  wire [15:0] _GEN_17 = cycle == 3'h1 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 69:37 73:21 28:24]
  wire [2:0] _GEN_18 = cycle == 3'h1 ? 3'h2 : _GEN_10; // @[CPU6502Core.scala 69:37 74:19]
  wire [15:0] _GEN_19 = cycle == 3'h1 ? regs_pc : _GEN_11; // @[CPU6502Core.scala 21:21 69:37]
  wire [7:0] _GEN_20 = cycle == 3'h1 ? regs_sp : _GEN_12; // @[CPU6502Core.scala 21:21 69:37]
  wire  _GEN_21 = cycle == 3'h1 ? regs_flagI : _GEN_13; // @[CPU6502Core.scala 21:21 69:37]
  wire [2:0] _GEN_22 = cycle == 3'h1 ? state : _GEN_14; // @[CPU6502Core.scala 25:22 69:37]
  wire [15:0] _GEN_23 = cycle == 3'h0 ? 16'hfffc : _GEN_15; // @[CPU6502Core.scala 63:31 65:24]
  wire [15:0] _regs_pc_T_1 = regs_pc + 16'h1; // @[CPU6502Core.scala 112:32]
  wire  _GEN_31 = nmiEdge ? 1'h0 : _GEN_0; // @[CPU6502Core.scala 104:25 105:21]
  wire [2:0] _GEN_33 = nmiEdge ? 3'h3 : 3'h2; // @[CPU6502Core.scala 104:25 107:19 114:19]
  wire  _GEN_35 = nmiEdge ? 1'h0 : 1'h1; // @[CPU6502Core.scala 104:25 45:17 110:24]
  wire [7:0] _GEN_36 = nmiEdge ? opcode : io_memDataIn; // @[CPU6502Core.scala 104:25 111:20 27:24]
  wire [15:0] _GEN_37 = nmiEdge ? regs_pc : _regs_pc_T_1; // @[CPU6502Core.scala 104:25 112:21 21:21]
  wire  _execResult_T = 8'h18 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_1 = 8'h38 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_2 = 8'hd8 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_3 = 8'hf8 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_4 = 8'h58 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_5 = 8'h78 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_6 = 8'hb8 == opcode; // @[CPU6502Core.scala 209:20]
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
  wire  _execResult_T_15 = 8'haa == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_16 = 8'ha8 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_17 = 8'h8a == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_18 = 8'h98 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_19 = 8'hba == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_20 = 8'h9a == opcode; // @[CPU6502Core.scala 209:20]
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
  wire  _execResult_T_26 = 8'he8 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_27 = 8'hc8 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_28 = 8'hca == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_29 = 8'h88 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_30 = 8'h1a == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_31 = 8'h3a == opcode; // @[CPU6502Core.scala 209:20]
  wire [7:0] execResult_result_res = regs_x + 8'h1; // @[Arithmetic.scala 38:26]
  wire [7:0] execResult_result_res_1 = regs_y + 8'h1; // @[Arithmetic.scala 44:26]
  wire [7:0] execResult_result_res_2 = regs_x - 8'h1; // @[Arithmetic.scala 50:26]
  wire [7:0] execResult_result_res_3 = regs_y - 8'h1; // @[Arithmetic.scala 56:26]
  wire [7:0] execResult_result_res_4 = regs_a + 8'h1; // @[Arithmetic.scala 62:26]
  wire [7:0] execResult_result_res_5 = regs_a - 8'h1; // @[Arithmetic.scala 68:26]
  wire [7:0] _GEN_84 = _execResult_T_31 ? execResult_result_res_5 : regs_a; // @[Arithmetic.scala 26:13 36:20 69:19]
  wire  _GEN_85 = _execResult_T_31 ? execResult_result_res_5[7] : regs_flagN; // @[Arithmetic.scala 26:13 36:20 70:23]
  wire  _GEN_86 = _execResult_T_31 ? execResult_result_res_5 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 26:13 36:20 71:23]
  wire [7:0] _GEN_87 = _execResult_T_30 ? execResult_result_res_4 : _GEN_84; // @[Arithmetic.scala 36:20 63:19]
  wire  _GEN_88 = _execResult_T_30 ? execResult_result_res_4[7] : _GEN_85; // @[Arithmetic.scala 36:20 64:23]
  wire  _GEN_89 = _execResult_T_30 ? execResult_result_res_4 == 8'h0 : _GEN_86; // @[Arithmetic.scala 36:20 65:23]
  wire [7:0] _GEN_90 = _execResult_T_29 ? execResult_result_res_3 : regs_y; // @[Arithmetic.scala 26:13 36:20 57:19]
  wire  _GEN_91 = _execResult_T_29 ? execResult_result_res_3[7] : _GEN_88; // @[Arithmetic.scala 36:20 58:23]
  wire  _GEN_92 = _execResult_T_29 ? execResult_result_res_3 == 8'h0 : _GEN_89; // @[Arithmetic.scala 36:20 59:23]
  wire [7:0] _GEN_93 = _execResult_T_29 ? regs_a : _GEN_87; // @[Arithmetic.scala 26:13 36:20]
  wire [7:0] _GEN_94 = _execResult_T_28 ? execResult_result_res_2 : regs_x; // @[Arithmetic.scala 26:13 36:20 51:19]
  wire  _GEN_95 = _execResult_T_28 ? execResult_result_res_2[7] : _GEN_91; // @[Arithmetic.scala 36:20 52:23]
  wire  _GEN_96 = _execResult_T_28 ? execResult_result_res_2 == 8'h0 : _GEN_92; // @[Arithmetic.scala 36:20 53:23]
  wire [7:0] _GEN_97 = _execResult_T_28 ? regs_y : _GEN_90; // @[Arithmetic.scala 26:13 36:20]
  wire [7:0] _GEN_98 = _execResult_T_28 ? regs_a : _GEN_93; // @[Arithmetic.scala 26:13 36:20]
  wire [7:0] _GEN_99 = _execResult_T_27 ? execResult_result_res_1 : _GEN_97; // @[Arithmetic.scala 36:20 45:19]
  wire  _GEN_100 = _execResult_T_27 ? execResult_result_res_1[7] : _GEN_95; // @[Arithmetic.scala 36:20 46:23]
  wire  _GEN_101 = _execResult_T_27 ? execResult_result_res_1 == 8'h0 : _GEN_96; // @[Arithmetic.scala 36:20 47:23]
  wire [7:0] _GEN_102 = _execResult_T_27 ? regs_x : _GEN_94; // @[Arithmetic.scala 26:13 36:20]
  wire [7:0] _GEN_103 = _execResult_T_27 ? regs_a : _GEN_98; // @[Arithmetic.scala 26:13 36:20]
  wire [7:0] execResult_result_newRegs_2_x = _execResult_T_26 ? execResult_result_res : _GEN_102; // @[Arithmetic.scala 36:20 39:19]
  wire  execResult_result_newRegs_2_flagN = _execResult_T_26 ? execResult_result_res[7] : _GEN_100; // @[Arithmetic.scala 36:20 40:23]
  wire  execResult_result_newRegs_2_flagZ = _execResult_T_26 ? execResult_result_res == 8'h0 : _GEN_101; // @[Arithmetic.scala 36:20 41:23]
  wire [7:0] execResult_result_newRegs_2_y = _execResult_T_26 ? regs_y : _GEN_99; // @[Arithmetic.scala 26:13 36:20]
  wire [7:0] execResult_result_newRegs_2_a = _execResult_T_26 ? regs_a : _GEN_103; // @[Arithmetic.scala 26:13 36:20]
  wire [8:0] _execResult_result_sum_T = regs_a + io_memDataIn; // @[Arithmetic.scala 85:22]
  wire [8:0] _GEN_3202 = {{8'd0}, regs_flagC}; // @[Arithmetic.scala 85:35]
  wire [9:0] execResult_result_sum = _execResult_result_sum_T + _GEN_3202; // @[Arithmetic.scala 85:35]
  wire [7:0] execResult_result_newRegs_3_a = execResult_result_sum[7:0]; // @[Arithmetic.scala 86:21]
  wire  execResult_result_newRegs_3_flagC = execResult_result_sum[8]; // @[Arithmetic.scala 87:25]
  wire  execResult_result_newRegs_3_flagN = execResult_result_sum[7]; // @[Arithmetic.scala 88:25]
  wire  execResult_result_newRegs_3_flagZ = execResult_result_newRegs_3_a == 8'h0; // @[Arithmetic.scala 89:32]
  wire  execResult_result_newRegs_3_flagV = regs_a[7] == io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_3_flagN; // @[Arithmetic.scala 90:51]
  wire [8:0] _execResult_result_diff_T = regs_a - io_memDataIn; // @[Arithmetic.scala 110:23]
  wire  _execResult_result_diff_T_2 = ~regs_flagC; // @[Arithmetic.scala 110:40]
  wire [8:0] _GEN_3203 = {{8'd0}, _execResult_result_diff_T_2}; // @[Arithmetic.scala 110:36]
  wire [9:0] execResult_result_diff = _execResult_result_diff_T - _GEN_3203; // @[Arithmetic.scala 110:36]
  wire [7:0] execResult_result_newRegs_4_a = execResult_result_diff[7:0]; // @[Arithmetic.scala 111:22]
  wire  execResult_result_newRegs_4_flagC = ~execResult_result_diff[8]; // @[Arithmetic.scala 112:22]
  wire  execResult_result_newRegs_4_flagN = execResult_result_diff[7]; // @[Arithmetic.scala 113:26]
  wire  execResult_result_newRegs_4_flagZ = execResult_result_newRegs_4_a == 8'h0; // @[Arithmetic.scala 114:33]
  wire  execResult_result_newRegs_4_flagV = regs_a[7] != io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 115:51]
  wire [2:0] _execResult_result_result_nextCycle_T_1 = cycle + 3'h1; // @[Arithmetic.scala 136:31]
  wire  _execResult_result_T_20 = 3'h0 == cycle; // @[Arithmetic.scala 144:19]
  wire  _execResult_result_T_21 = 3'h1 == cycle; // @[Arithmetic.scala 144:19]
  wire  _execResult_result_T_22 = 3'h2 == cycle; // @[Arithmetic.scala 144:19]
  wire [7:0] _execResult_result_res_T_8 = io_memDataIn + 8'h1; // @[Arithmetic.scala 160:52]
  wire [7:0] _execResult_result_res_T_10 = io_memDataIn - 8'h1; // @[Arithmetic.scala 160:69]
  wire [7:0] execResult_result_res_6 = opcode == 8'he6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 160:22]
  wire [15:0] _GEN_109 = 3'h2 == cycle ? operand : 16'h0; // @[Arithmetic.scala 144:19 138:20 159:24]
  wire [7:0] _GEN_110 = 3'h2 == cycle ? execResult_result_res_6 : 8'h0; // @[Arithmetic.scala 144:19 139:20 161:24]
  wire  _GEN_112 = 3'h2 == cycle ? execResult_result_res_6[7] : regs_flagN; // @[Arithmetic.scala 133:13 144:19 163:23]
  wire  _GEN_113 = 3'h2 == cycle ? execResult_result_res_6 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 133:13 144:19 164:23]
  wire [15:0] execResult_result_newRegs_5_pc = 3'h0 == cycle ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 133:13 144:19 149:20]
  wire  _GEN_132 = 3'h1 == cycle ? regs_flagZ : _GEN_113; // @[Arithmetic.scala 133:13 144:19]
  wire  execResult_result_newRegs_5_flagZ = 3'h0 == cycle ? regs_flagZ : _GEN_132; // @[Arithmetic.scala 133:13 144:19]
  wire  _GEN_131 = 3'h1 == cycle ? regs_flagN : _GEN_112; // @[Arithmetic.scala 133:13 144:19]
  wire  execResult_result_newRegs_5_flagN = 3'h0 == cycle ? regs_flagN : _GEN_131; // @[Arithmetic.scala 133:13 144:19]
  wire [15:0] _GEN_126 = 3'h1 == cycle ? operand : _GEN_109; // @[Arithmetic.scala 144:19 154:24]
  wire [2:0] _GEN_128 = 3'h1 == cycle ? 3'h2 : _execResult_result_result_nextCycle_T_1; // @[Arithmetic.scala 144:19 136:22 156:26]
  wire [7:0] _GEN_129 = 3'h1 == cycle ? 8'h0 : _GEN_110; // @[Arithmetic.scala 144:19 139:20]
  wire  _GEN_130 = 3'h1 == cycle ? 1'h0 : 3'h2 == cycle; // @[Arithmetic.scala 144:19 140:21]
  wire [15:0] execResult_result_result_6_memAddr = 3'h0 == cycle ? regs_pc : _GEN_126; // @[Arithmetic.scala 144:19 146:24]
  wire  execResult_result_result_6_memRead = 3'h0 == cycle | 3'h1 == cycle; // @[Arithmetic.scala 144:19 147:24]
  wire [15:0] execResult_result_result_6_operand = 3'h0 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Arithmetic.scala 144:19 142:20 148:24]
  wire [2:0] execResult_result_result_6_nextCycle = 3'h0 == cycle ? 3'h1 : _GEN_128; // @[Arithmetic.scala 144:19 151:26]
  wire [7:0] execResult_result_result_6_memData = 3'h0 == cycle ? 8'h0 : _GEN_129; // @[Arithmetic.scala 144:19 139:20]
  wire  execResult_result_result_6_done = 3'h0 == cycle ? 1'h0 : _GEN_130; // @[Arithmetic.scala 144:19 140:21]
  wire  _execResult_result_T_26 = 3'h3 == cycle; // @[Arithmetic.scala 188:19]
  wire [7:0] execResult_result_res_7 = opcode == 8'hee ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 213:22]
  wire [15:0] _GEN_166 = 3'h3 == cycle ? operand : 16'h0; // @[Arithmetic.scala 188:19 182:20 212:24]
  wire [7:0] _GEN_167 = 3'h3 == cycle ? execResult_result_res_7 : 8'h0; // @[Arithmetic.scala 188:19 183:20 214:24]
  wire  _GEN_169 = 3'h3 == cycle ? execResult_result_res_7[7] : regs_flagN; // @[Arithmetic.scala 177:13 188:19 216:23]
  wire  _GEN_170 = 3'h3 == cycle ? execResult_result_res_7 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 177:13 188:19 217:23]
  wire [15:0] _GEN_204 = _execResult_result_T_21 ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 177:13 188:19 202:20]
  wire [15:0] execResult_result_newRegs_6_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_204; // @[Arithmetic.scala 188:19 194:20]
  wire  _GEN_188 = _execResult_result_T_22 ? regs_flagZ : _GEN_170; // @[Arithmetic.scala 177:13 188:19]
  wire  _GEN_220 = _execResult_result_T_21 ? regs_flagZ : _GEN_188; // @[Arithmetic.scala 177:13 188:19]
  wire  execResult_result_newRegs_6_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_220; // @[Arithmetic.scala 177:13 188:19]
  wire  _GEN_187 = _execResult_result_T_22 ? regs_flagN : _GEN_169; // @[Arithmetic.scala 177:13 188:19]
  wire  _GEN_219 = _execResult_result_T_21 ? regs_flagN : _GEN_187; // @[Arithmetic.scala 177:13 188:19]
  wire  execResult_result_newRegs_6_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_219; // @[Arithmetic.scala 177:13 188:19]
  wire [15:0] _GEN_183 = _execResult_result_T_22 ? operand : _GEN_166; // @[Arithmetic.scala 188:19 207:24]
  wire [7:0] _GEN_185 = _execResult_result_T_22 ? 8'h0 : _GEN_167; // @[Arithmetic.scala 188:19 183:20]
  wire  _GEN_186 = _execResult_result_T_22 ? 1'h0 : 3'h3 == cycle; // @[Arithmetic.scala 188:19 184:21]
  wire [15:0] _GEN_201 = _execResult_result_T_21 ? regs_pc : _GEN_183; // @[Arithmetic.scala 188:19 199:24]
  wire  _GEN_202 = _execResult_result_T_21 | _execResult_result_T_22; // @[Arithmetic.scala 188:19 200:24]
  wire [15:0] _GEN_203 = _execResult_result_T_21 ? resetVector : operand; // @[Arithmetic.scala 188:19 186:20 201:24]
  wire [7:0] _GEN_217 = _execResult_result_T_21 ? 8'h0 : _GEN_185; // @[Arithmetic.scala 188:19 183:20]
  wire  _GEN_218 = _execResult_result_T_21 ? 1'h0 : _GEN_186; // @[Arithmetic.scala 188:19 184:21]
  wire [15:0] execResult_result_result_7_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_201; // @[Arithmetic.scala 188:19 191:24]
  wire  execResult_result_result_7_memRead = _execResult_result_T_20 | _GEN_202; // @[Arithmetic.scala 188:19 192:24]
  wire [15:0] execResult_result_result_7_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_203; // @[Arithmetic.scala 188:19 193:24]
  wire [7:0] execResult_result_result_7_memData = _execResult_result_T_20 ? 8'h0 : _GEN_217; // @[Arithmetic.scala 188:19 183:20]
  wire  execResult_result_result_7_done = _execResult_result_T_20 ? 1'h0 : _GEN_218; // @[Arithmetic.scala 188:19 184:21]
  wire  _execResult_result_useY_T = opcode == 8'h79; // @[Arithmetic.scala 242:24]
  wire  execResult_result_useY = opcode == 8'h79 | opcode == 8'hf9; // @[Arithmetic.scala 242:36]
  wire [7:0] execResult_result_index = execResult_result_useY ? regs_y : regs_x; // @[Arithmetic.scala 243:20]
  wire [15:0] _GEN_3204 = {{8'd0}, execResult_result_index}; // @[Arithmetic.scala 264:28]
  wire [15:0] execResult_result_addr = operand + _GEN_3204; // @[Arithmetic.scala 264:28]
  wire  execResult_result_isADC = _execResult_result_useY_T | opcode == 8'h7d; // @[Arithmetic.scala 270:41]
  wire [7:0] _GEN_241 = execResult_result_isADC ? execResult_result_newRegs_3_a : execResult_result_newRegs_4_a; // @[Arithmetic.scala 272:21 275:21 283:21]
  wire  _GEN_242 = execResult_result_isADC ? execResult_result_newRegs_3_flagC : execResult_result_newRegs_4_flagC; // @[Arithmetic.scala 272:21 276:25 284:25]
  wire  _GEN_243 = execResult_result_isADC ? execResult_result_newRegs_3_flagN : execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 272:21 277:25 285:25]
  wire  _GEN_244 = execResult_result_isADC ? execResult_result_newRegs_3_flagZ : execResult_result_newRegs_4_flagZ; // @[Arithmetic.scala 272:21 278:25 286:25]
  wire  _GEN_245 = execResult_result_isADC ? execResult_result_newRegs_3_flagV : execResult_result_newRegs_4_flagV; // @[Arithmetic.scala 272:21 279:25 287:25]
  wire [7:0] _GEN_246 = _execResult_result_T_26 ? _GEN_241 : regs_a; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_247 = _execResult_result_T_26 ? _GEN_242 : regs_flagC; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_248 = _execResult_result_T_26 ? _GEN_243 : regs_flagN; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_249 = _execResult_result_T_26 ? _GEN_244 : regs_flagZ; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_250 = _execResult_result_T_26 ? _GEN_245 : regs_flagV; // @[Arithmetic.scala 230:13 245:19]
  wire [7:0] _GEN_266 = _execResult_result_T_22 ? regs_a : _GEN_246; // @[Arithmetic.scala 230:13 245:19]
  wire [7:0] _GEN_300 = _execResult_result_T_21 ? regs_a : _GEN_266; // @[Arithmetic.scala 230:13 245:19]
  wire [7:0] execResult_result_newRegs_7_a = _execResult_result_T_20 ? regs_a : _GEN_300; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_267 = _execResult_result_T_22 ? regs_flagC : _GEN_247; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_301 = _execResult_result_T_21 ? regs_flagC : _GEN_267; // @[Arithmetic.scala 230:13 245:19]
  wire  execResult_result_newRegs_7_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_301; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_269 = _execResult_result_T_22 ? regs_flagZ : _GEN_249; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_303 = _execResult_result_T_21 ? regs_flagZ : _GEN_269; // @[Arithmetic.scala 230:13 245:19]
  wire  execResult_result_newRegs_7_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_303; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_270 = _execResult_result_T_22 ? regs_flagV : _GEN_250; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_304 = _execResult_result_T_21 ? regs_flagV : _GEN_270; // @[Arithmetic.scala 230:13 245:19]
  wire  execResult_result_newRegs_7_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_304; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_268 = _execResult_result_T_22 ? regs_flagN : _GEN_248; // @[Arithmetic.scala 230:13 245:19]
  wire  _GEN_302 = _execResult_result_T_21 ? regs_flagN : _GEN_268; // @[Arithmetic.scala 230:13 245:19]
  wire  execResult_result_newRegs_7_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_302; // @[Arithmetic.scala 230:13 245:19]
  wire [15:0] _GEN_264 = _execResult_result_T_22 ? execResult_result_addr : 16'h0; // @[Arithmetic.scala 245:19 235:20 265:24]
  wire [15:0] _GEN_284 = _execResult_result_T_21 ? regs_pc : _GEN_264; // @[Arithmetic.scala 245:19 256:24]
  wire [15:0] execResult_result_result_8_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_284; // @[Arithmetic.scala 245:19 248:24]
  wire  _execResult_T_52 = 8'h29 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_53 = 8'h9 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_54 = 8'h49 == opcode; // @[CPU6502Core.scala 209:20]
  wire [7:0] _execResult_result_res_T_16 = regs_a & io_memDataIn; // @[Logic.scala 32:34]
  wire [7:0] _execResult_result_res_T_17 = regs_a | io_memDataIn; // @[Logic.scala 33:34]
  wire [7:0] _execResult_result_res_T_18 = regs_a ^ io_memDataIn; // @[Logic.scala 34:34]
  wire [7:0] _GEN_328 = _execResult_T_54 ? _execResult_result_res_T_18 : 8'h0; // @[Logic.scala 31:20 34:24 29:9]
  wire [7:0] _GEN_329 = _execResult_T_53 ? _execResult_result_res_T_17 : _GEN_328; // @[Logic.scala 31:20 33:24]
  wire [7:0] execResult_result_res_8 = _execResult_T_52 ? _execResult_result_res_T_16 : _GEN_329; // @[Logic.scala 31:20 32:24]
  wire  execResult_result_newRegs_8_flagN = execResult_result_res_8[7]; // @[Logic.scala 38:25]
  wire  execResult_result_newRegs_8_flagZ = execResult_result_res_8 == 8'h0; // @[Logic.scala 39:26]
  wire [15:0] _GEN_331 = _execResult_result_T_21 ? operand : 16'h0; // @[Logic.scala 68:19 62:20 78:24]
  wire  _GEN_333 = _execResult_result_T_21 ? _execResult_result_res_T_16 == 8'h0 : regs_flagZ; // @[Logic.scala 57:13 68:19 80:23]
  wire  _GEN_334 = _execResult_result_T_21 ? io_memDataIn[7] : regs_flagN; // @[Logic.scala 57:13 68:19 81:23]
  wire  _GEN_335 = _execResult_result_T_21 ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 57:13 68:19 82:23]
  wire  execResult_result_newRegs_9_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_333; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_9_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_335; // @[Logic.scala 57:13 68:19]
  wire  execResult_result_newRegs_9_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_334; // @[Logic.scala 57:13 68:19]
  wire [15:0] execResult_result_result_10_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_331; // @[Logic.scala 68:19 70:24]
  wire [2:0] execResult_result_result_10_nextCycle = _execResult_result_T_20 ? 3'h1 :
    _execResult_result_result_nextCycle_T_1; // @[Logic.scala 68:19 60:22 75:26]
  wire  execResult_result_result_10_done = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21; // @[Logic.scala 59:17 68:19]
  wire  _execResult_result_res_T_26 = opcode == 8'h3d; // @[Logic.scala 95:15]
  wire  _execResult_result_res_T_27 = opcode == 8'h29 | opcode == 8'h25 | opcode == 8'h35 | opcode == 8'h2d |
    _execResult_result_res_T_26; // @[Logic.scala 94:89]
  wire  _execResult_result_res_T_28 = opcode == 8'h39; // @[Logic.scala 95:36]
  wire  _execResult_result_res_T_33 = _execResult_result_res_T_27 | opcode == 8'h39 | opcode == 8'h21 | opcode == 8'h31; // @[Logic.scala 95:68]
  wire  _execResult_result_res_T_42 = opcode == 8'h1d; // @[Logic.scala 97:15]
  wire  _execResult_result_res_T_43 = opcode == 8'h9 | opcode == 8'h5 | opcode == 8'h15 | opcode == 8'hd |
    _execResult_result_res_T_42; // @[Logic.scala 96:89]
  wire  _execResult_result_res_T_44 = opcode == 8'h19; // @[Logic.scala 97:36]
  wire  _execResult_result_res_T_49 = _execResult_result_res_T_43 | opcode == 8'h19 | opcode == 8'h1 | opcode == 8'h11; // @[Logic.scala 97:68]
  wire  _execResult_result_res_T_58 = opcode == 8'h5d; // @[Logic.scala 99:15]
  wire  _execResult_result_res_T_59 = opcode == 8'h49 | opcode == 8'h45 | opcode == 8'h55 | opcode == 8'h4d |
    _execResult_result_res_T_58; // @[Logic.scala 98:89]
  wire  _execResult_result_res_T_60 = opcode == 8'h59; // @[Logic.scala 99:36]
  wire  _execResult_result_res_T_65 = _execResult_result_res_T_59 | opcode == 8'h59 | opcode == 8'h41 | opcode == 8'h51; // @[Logic.scala 99:68]
  wire [7:0] _execResult_result_res_T_67 = _execResult_result_res_T_65 ? _execResult_result_res_T_18 : regs_a; // @[Mux.scala 101:16]
  wire [7:0] _execResult_result_res_T_68 = _execResult_result_res_T_49 ? _execResult_result_res_T_17 :
    _execResult_result_res_T_67; // @[Mux.scala 101:16]
  wire [7:0] execResult_result_res_9 = _execResult_result_res_T_33 ? _execResult_result_res_T_16 :
    _execResult_result_res_T_68; // @[Mux.scala 101:16]
  wire  _execResult_result_newRegs_flagZ_T_24 = execResult_result_res_9 == 8'h0; // @[Logic.scala 132:30]
  wire [7:0] _GEN_371 = _execResult_result_T_21 ? execResult_result_res_9 : regs_a; // @[Logic.scala 107:13 118:19 130:19]
  wire  _GEN_372 = _execResult_result_T_21 ? execResult_result_res_9[7] : regs_flagN; // @[Logic.scala 107:13 118:19 131:23]
  wire  _GEN_373 = _execResult_result_T_21 ? execResult_result_res_9 == 8'h0 : regs_flagZ; // @[Logic.scala 107:13 118:19 132:23]
  wire [7:0] execResult_result_newRegs_10_a = _execResult_result_T_20 ? regs_a : _GEN_371; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_10_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_373; // @[Logic.scala 107:13 118:19]
  wire  execResult_result_newRegs_10_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_372; // @[Logic.scala 107:13 118:19]
  wire [7:0] _execResult_result_result_operand_T_5 = io_memDataIn + regs_x; // @[Logic.scala 160:38]
  wire [15:0] execResult_result_result_12_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_5} : operand; // @[Logic.scala 156:19 154:20 160:24]
  wire [7:0] _GEN_445 = _execResult_result_T_22 ? execResult_result_res_9 : regs_a; // @[Logic.scala 183:13 194:19 213:19]
  wire  _GEN_446 = _execResult_result_T_22 ? execResult_result_res_9[7] : regs_flagN; // @[Logic.scala 183:13 194:19 214:23]
  wire  _GEN_447 = _execResult_result_T_22 ? _execResult_result_newRegs_flagZ_T_24 : regs_flagZ; // @[Logic.scala 183:13 194:19 215:23]
  wire [7:0] _GEN_476 = _execResult_result_T_21 ? regs_a : _GEN_445; // @[Logic.scala 183:13 194:19]
  wire [7:0] execResult_result_newRegs_12_a = _execResult_result_T_20 ? regs_a : _GEN_476; // @[Logic.scala 183:13 194:19]
  wire  _GEN_478 = _execResult_result_T_21 ? regs_flagZ : _GEN_447; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_12_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_478; // @[Logic.scala 183:13 194:19]
  wire  _GEN_477 = _execResult_result_T_21 ? regs_flagN : _GEN_446; // @[Logic.scala 183:13 194:19]
  wire  execResult_result_newRegs_12_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_477; // @[Logic.scala 183:13 194:19]
  wire [15:0] _GEN_460 = _execResult_result_T_21 ? regs_pc : _GEN_109; // @[Logic.scala 194:19 203:24]
  wire [15:0] execResult_result_result_13_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_460; // @[Logic.scala 194:19 196:24]
  wire  execResult_result_useY_1 = _execResult_result_res_T_28 | _execResult_result_res_T_44 |
    _execResult_result_res_T_60; // @[Logic.scala 240:59]
  wire [7:0] execResult_result_index_1 = execResult_result_useY_1 ? regs_y : regs_x; // @[Logic.scala 241:20]
  wire [15:0] _GEN_3207 = {{8'd0}, execResult_result_index_1}; // @[Logic.scala 254:57]
  wire [15:0] _execResult_result_result_operand_T_12 = resetVector + _GEN_3207; // @[Logic.scala 254:57]
  wire [15:0] _GEN_519 = _execResult_result_T_21 ? _execResult_result_result_operand_T_12 : operand; // @[Logic.scala 243:19 237:20 254:24]
  wire [15:0] execResult_result_result_14_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_519; // @[Logic.scala 243:19 247:24]
  wire [15:0] _execResult_result_result_operand_T_17 = {operand[15:8],io_memDataIn}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_result_memAddr_T_3 = operand[7:0] + 8'h1; // @[Logic.scala 305:42]
  wire [7:0] _GEN_559 = _execResult_result_T_26 ? execResult_result_res_9 : regs_a; // @[Logic.scala 277:13 288:19 314:19]
  wire  _GEN_560 = _execResult_result_T_26 ? execResult_result_res_9[7] : regs_flagN; // @[Logic.scala 277:13 288:19 315:23]
  wire  _GEN_561 = _execResult_result_T_26 ? _execResult_result_newRegs_flagZ_T_24 : regs_flagZ; // @[Logic.scala 277:13 288:19 316:23]
  wire [7:0] _GEN_577 = _execResult_result_T_22 ? regs_a : _GEN_559; // @[Logic.scala 277:13 288:19]
  wire [7:0] _GEN_596 = _execResult_result_T_21 ? regs_a : _GEN_577; // @[Logic.scala 277:13 288:19]
  wire [7:0] execResult_result_newRegs_14_a = _execResult_result_T_20 ? regs_a : _GEN_596; // @[Logic.scala 277:13 288:19]
  wire  _GEN_579 = _execResult_result_T_22 ? regs_flagZ : _GEN_561; // @[Logic.scala 277:13 288:19]
  wire  _GEN_598 = _execResult_result_T_21 ? regs_flagZ : _GEN_579; // @[Logic.scala 277:13 288:19]
  wire  execResult_result_newRegs_14_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_598; // @[Logic.scala 277:13 288:19]
  wire  _GEN_578 = _execResult_result_T_22 ? regs_flagN : _GEN_560; // @[Logic.scala 277:13 288:19]
  wire  _GEN_597 = _execResult_result_T_21 ? regs_flagN : _GEN_578; // @[Logic.scala 277:13 288:19]
  wire  execResult_result_newRegs_14_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_597; // @[Logic.scala 277:13 288:19]
  wire [15:0] _GEN_574 = _execResult_result_T_22 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_166; // @[Logic.scala 288:19 305:24]
  wire  _GEN_575 = _execResult_result_T_22 | _execResult_result_T_26; // @[Logic.scala 288:19 306:24]
  wire [15:0] _GEN_576 = _execResult_result_T_22 ? resetVector : operand; // @[Logic.scala 288:19 286:20 307:24]
  wire [15:0] _GEN_593 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_574; // @[Logic.scala 288:19 299:24]
  wire  _GEN_594 = _execResult_result_T_21 | _GEN_575; // @[Logic.scala 288:19 300:24]
  wire [15:0] _GEN_595 = _execResult_result_T_21 ? _execResult_result_result_operand_T_17 : _GEN_576; // @[Logic.scala 288:19 301:24]
  wire [15:0] execResult_result_result_15_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_593; // @[Logic.scala 288:19 291:24]
  wire  execResult_result_result_15_memRead = _execResult_result_T_20 | _GEN_594; // @[Logic.scala 288:19 292:24]
  wire [15:0] execResult_result_result_15_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_5} : _GEN_595; // @[Logic.scala 288:19 293:24]
  wire [15:0] _GEN_3208 = {{8'd0}, regs_y}; // @[Logic.scala 359:57]
  wire [15:0] _execResult_result_result_operand_T_25 = resetVector + _GEN_3208; // @[Logic.scala 359:57]
  wire [15:0] _GEN_651 = _execResult_result_T_22 ? _execResult_result_result_operand_T_25 : operand; // @[Logic.scala 340:19 338:20 359:24]
  wire [15:0] _GEN_670 = _execResult_result_T_21 ? _execResult_result_result_operand_T_17 : _GEN_651; // @[Logic.scala 340:19 353:24]
  wire [15:0] execResult_result_result_16_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_670; // @[Logic.scala 340:19 345:24]
  wire  _execResult_T_96 = 8'ha == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_97 = 8'h4a == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_98 = 8'h2a == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_99 = 8'h6a == opcode; // @[CPU6502Core.scala 209:20]
  wire [8:0] _execResult_result_res_T_319 = {regs_a, 1'h0}; // @[Shift.scala 35:24]
  wire [7:0] _execResult_result_res_T_323 = {regs_a[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_325 = {regs_flagC,regs_a[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_707 = _execResult_T_99 ? regs_a[0] : regs_flagC; // @[Shift.scala 18:13 32:20 46:23]
  wire [7:0] _GEN_708 = _execResult_T_99 ? _execResult_result_res_T_325 : regs_a; // @[Shift.scala 32:20 47:13 29:9]
  wire  _GEN_709 = _execResult_T_98 ? regs_a[7] : _GEN_707; // @[Shift.scala 32:20 42:23]
  wire [7:0] _GEN_710 = _execResult_T_98 ? _execResult_result_res_T_323 : _GEN_708; // @[Shift.scala 32:20 43:13]
  wire  _GEN_711 = _execResult_T_97 ? regs_a[0] : _GEN_709; // @[Shift.scala 32:20 38:23]
  wire [7:0] _GEN_712 = _execResult_T_97 ? {{1'd0}, regs_a[7:1]} : _GEN_710; // @[Shift.scala 32:20 39:13]
  wire  execResult_result_newRegs_16_flagC = _execResult_T_96 ? regs_a[7] : _GEN_711; // @[Shift.scala 32:20 34:23]
  wire [7:0] execResult_result_res_15 = _execResult_T_96 ? _execResult_result_res_T_319[7:0] : _GEN_712; // @[Shift.scala 32:20 35:13]
  wire  execResult_result_newRegs_16_flagN = execResult_result_res_15[7]; // @[Shift.scala 52:25]
  wire  execResult_result_newRegs_16_flagZ = execResult_result_res_15 == 8'h0; // @[Shift.scala 53:26]
  wire  _execResult_T_103 = 8'h6 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_104 = 8'h46 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_105 = 8'h26 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_106 = 8'h66 == opcode; // @[CPU6502Core.scala 209:20]
  wire [8:0] _execResult_result_res_T_326 = {io_memDataIn, 1'h0}; // @[Shift.scala 95:31]
  wire [7:0] _execResult_result_res_T_330 = {io_memDataIn[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_332 = {regs_flagC,io_memDataIn[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_715 = _execResult_T_106 ? io_memDataIn[0] : regs_flagC; // @[Shift.scala 92:24 108:27 62:13]
  wire [7:0] _GEN_716 = _execResult_T_106 ? _execResult_result_res_T_332 : 8'h0; // @[Shift.scala 109:17 90:13 92:24]
  wire  _GEN_717 = _execResult_T_105 ? io_memDataIn[7] : _GEN_715; // @[Shift.scala 92:24 103:27]
  wire [7:0] _GEN_718 = _execResult_T_105 ? _execResult_result_res_T_330 : _GEN_716; // @[Shift.scala 104:17 92:24]
  wire  _GEN_719 = _execResult_T_104 ? io_memDataIn[0] : _GEN_717; // @[Shift.scala 92:24 98:27]
  wire [7:0] _GEN_720 = _execResult_T_104 ? {{1'd0}, io_memDataIn[7:1]} : _GEN_718; // @[Shift.scala 92:24 99:17]
  wire  _GEN_721 = _execResult_T_103 ? io_memDataIn[7] : _GEN_719; // @[Shift.scala 92:24 94:27]
  wire [7:0] execResult_result_res_16 = _execResult_T_103 ? _execResult_result_res_T_326[7:0] : _GEN_720; // @[Shift.scala 92:24 95:17]
  wire  _GEN_724 = _execResult_result_T_22 ? _GEN_721 : regs_flagC; // @[Shift.scala 62:13 73:19]
  wire [7:0] _GEN_725 = _execResult_result_T_22 ? execResult_result_res_16 : 8'h0; // @[Shift.scala 73:19 113:24 68:20]
  wire  _GEN_727 = _execResult_result_T_22 ? execResult_result_res_16[7] : regs_flagN; // @[Shift.scala 73:19 115:23 62:13]
  wire  _GEN_728 = _execResult_result_T_22 ? execResult_result_res_16 == 8'h0 : regs_flagZ; // @[Shift.scala 73:19 116:23 62:13]
  wire  _GEN_744 = _execResult_result_T_21 ? regs_flagC : _GEN_724; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_17_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_744; // @[Shift.scala 62:13 73:19]
  wire  _GEN_748 = _execResult_result_T_21 ? regs_flagZ : _GEN_728; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_17_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_748; // @[Shift.scala 62:13 73:19]
  wire  _GEN_747 = _execResult_result_T_21 ? regs_flagN : _GEN_727; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_17_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_747; // @[Shift.scala 62:13 73:19]
  wire [7:0] _GEN_745 = _execResult_result_T_21 ? 8'h0 : _GEN_725; // @[Shift.scala 73:19 68:20]
  wire [7:0] execResult_result_result_18_memData = _execResult_result_T_20 ? 8'h0 : _GEN_745; // @[Shift.scala 73:19 68:20]
  wire  _execResult_T_110 = 8'hc9 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_111 = 8'he0 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_112 = 8'hc0 == opcode; // @[CPU6502Core.scala 209:20]
  wire [7:0] _GEN_783 = _execResult_T_112 ? regs_y : regs_a; // @[Compare.scala 30:14 32:20 35:29]
  wire [7:0] _GEN_784 = _execResult_T_111 ? regs_x : _GEN_783; // @[Compare.scala 32:20 34:29]
  wire [7:0] execResult_result_regValue = _execResult_T_110 ? regs_a : _GEN_784; // @[Compare.scala 32:20 33:29]
  wire [8:0] execResult_result_diff_2 = execResult_result_regValue - io_memDataIn; // @[Compare.scala 38:25]
  wire  execResult_result_newRegs_18_flagC = execResult_result_regValue >= io_memDataIn; // @[Compare.scala 39:31]
  wire  execResult_result_newRegs_18_flagZ = execResult_result_regValue == io_memDataIn; // @[Compare.scala 40:31]
  wire  execResult_result_newRegs_18_flagN = execResult_result_diff_2[7]; // @[Compare.scala 41:26]
  wire  _execResult_result_regValue_T_4 = opcode == 8'he0 | opcode == 8'he4 | opcode == 8'hec; // @[Compare.scala 97:47]
  wire  _execResult_result_regValue_T_9 = opcode == 8'hc0 | opcode == 8'hc4 | opcode == 8'hcc; // @[Compare.scala 98:47]
  wire [7:0] _execResult_result_regValue_T_10 = _execResult_result_regValue_T_9 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] execResult_result_regValue_1 = _execResult_result_regValue_T_4 ? regs_x : _execResult_result_regValue_T_10; // @[Mux.scala 101:16]
  wire [8:0] execResult_result_diff_3 = execResult_result_regValue_1 - io_memDataIn; // @[Compare.scala 100:25]
  wire  execResult_result_flagC = execResult_result_regValue_1 >= io_memDataIn; // @[Compare.scala 101:26]
  wire  execResult_result_flagZ = execResult_result_regValue_1 == io_memDataIn; // @[Compare.scala 102:26]
  wire  execResult_result_flagN = execResult_result_diff_3[7]; // @[Compare.scala 103:21]
  wire  _GEN_788 = _execResult_result_T_21 ? execResult_result_flagC : regs_flagC; // @[Compare.scala 111:13 122:19 134:23]
  wire  _GEN_789 = _execResult_result_T_21 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 111:13 122:19 135:23]
  wire  _GEN_790 = _execResult_result_T_21 ? execResult_result_flagN : regs_flagN; // @[Compare.scala 111:13 122:19 136:23]
  wire  execResult_result_newRegs_19_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_788; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_19_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_789; // @[Compare.scala 111:13 122:19]
  wire  execResult_result_newRegs_19_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_790; // @[Compare.scala 111:13 122:19]
  wire  _GEN_862 = _execResult_result_T_22 ? execResult_result_flagC : regs_flagC; // @[Compare.scala 187:13 198:19 217:23]
  wire  _GEN_863 = _execResult_result_T_22 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 187:13 198:19 218:23]
  wire  _GEN_864 = _execResult_result_T_22 ? execResult_result_flagN : regs_flagN; // @[Compare.scala 187:13 198:19 219:23]
  wire  _GEN_893 = _execResult_result_T_21 ? regs_flagC : _GEN_862; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_21_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_893; // @[Compare.scala 187:13 198:19]
  wire  _GEN_894 = _execResult_result_T_21 ? regs_flagZ : _GEN_863; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_21_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_894; // @[Compare.scala 187:13 198:19]
  wire  _GEN_895 = _execResult_result_T_21 ? regs_flagN : _GEN_864; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_newRegs_21_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_895; // @[Compare.scala 187:13 198:19]
  wire  execResult_result_useY_2 = opcode == 8'hd9; // @[Compare.scala 243:23]
  wire [7:0] execResult_result_index_2 = execResult_result_useY_2 ? regs_y : regs_x; // @[Compare.scala 244:20]
  wire [15:0] _GEN_3209 = {{8'd0}, execResult_result_index_2}; // @[Compare.scala 257:57]
  wire [15:0] _execResult_result_result_operand_T_34 = resetVector + _GEN_3209; // @[Compare.scala 257:57]
  wire [15:0] _GEN_936 = _execResult_result_T_21 ? _execResult_result_result_operand_T_34 : operand; // @[Compare.scala 246:19 241:20 257:24]
  wire [15:0] execResult_result_result_23_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_936; // @[Compare.scala 246:19 250:24]
  wire  _GEN_976 = _execResult_result_T_26 ? execResult_result_flagC : regs_flagC; // @[Compare.scala 280:13 291:19 313:23]
  wire  _GEN_977 = _execResult_result_T_26 ? execResult_result_flagZ : regs_flagZ; // @[Compare.scala 280:13 291:19 314:23]
  wire  _GEN_978 = _execResult_result_T_26 ? execResult_result_flagN : regs_flagN; // @[Compare.scala 280:13 291:19 315:23]
  wire  _GEN_994 = _execResult_result_T_22 ? regs_flagC : _GEN_976; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1013 = _execResult_result_T_21 ? regs_flagC : _GEN_994; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_23_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1013; // @[Compare.scala 280:13 291:19]
  wire  _GEN_995 = _execResult_result_T_22 ? regs_flagZ : _GEN_977; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1014 = _execResult_result_T_21 ? regs_flagZ : _GEN_995; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_23_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1014; // @[Compare.scala 280:13 291:19]
  wire  _GEN_996 = _execResult_result_T_22 ? regs_flagN : _GEN_978; // @[Compare.scala 280:13 291:19]
  wire  _GEN_1015 = _execResult_result_T_21 ? regs_flagN : _GEN_996; // @[Compare.scala 280:13 291:19]
  wire  execResult_result_newRegs_23_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1015; // @[Compare.scala 280:13 291:19]
  wire [15:0] execResult_result_result_26_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_595; // @[Compare.scala 387:19 391:24]
  wire  _execResult_T_132 = 8'hf0 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_133 = 8'hd0 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_134 = 8'hb0 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_135 = 8'h90 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_136 = 8'h30 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_137 = 8'h10 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_138 = 8'h50 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_139 = 8'h70 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _GEN_1199 = _execResult_T_138 & ~regs_flagV; // @[Branch.scala 18:16 20:20 28:31]
  wire  _GEN_1200 = _execResult_T_139 ? regs_flagV : _GEN_1199; // @[Branch.scala 20:20 27:31]
  wire  _GEN_1201 = _execResult_T_137 ? ~regs_flagN : _GEN_1200; // @[Branch.scala 20:20 26:31]
  wire  _GEN_1202 = _execResult_T_136 ? regs_flagN : _GEN_1201; // @[Branch.scala 20:20 25:31]
  wire  _GEN_1203 = _execResult_T_135 ? _execResult_result_diff_T_2 : _GEN_1202; // @[Branch.scala 20:20 24:31]
  wire  _GEN_1204 = _execResult_T_134 ? regs_flagC : _GEN_1203; // @[Branch.scala 20:20 23:31]
  wire  _GEN_1205 = _execResult_T_133 ? ~regs_flagZ : _GEN_1204; // @[Branch.scala 20:20 22:31]
  wire  execResult_result_takeBranch = _execResult_T_132 ? regs_flagZ : _GEN_1205; // @[Branch.scala 20:20 21:31]
  wire [7:0] execResult_result_offset = io_memDataIn; // @[Branch.scala 32:28]
  wire [15:0] _GEN_3211 = {{8{execResult_result_offset[7]}},execResult_result_offset}; // @[Branch.scala 34:51]
  wire [15:0] _execResult_result_newRegs_pc_T_60 = $signed(regs_pc) + $signed(_GEN_3211); // @[Branch.scala 34:61]
  wire [15:0] execResult_result_newRegs_26_pc = execResult_result_takeBranch ? _execResult_result_newRegs_pc_T_60 :
    regs_pc; // @[Branch.scala 34:22]
  wire  _execResult_T_147 = 8'ha9 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_148 = 8'ha2 == opcode; // @[CPU6502Core.scala 209:20]
  wire  _execResult_T_149 = 8'ha0 == opcode; // @[CPU6502Core.scala 209:20]
  wire [7:0] _GEN_1207 = _execResult_T_149 ? io_memDataIn : regs_y; // @[LoadStore.scala 27:13 29:20 32:30]
  wire [7:0] _GEN_1208 = _execResult_T_148 ? io_memDataIn : regs_x; // @[LoadStore.scala 27:13 29:20 31:30]
  wire [7:0] _GEN_1209 = _execResult_T_148 ? regs_y : _GEN_1207; // @[LoadStore.scala 27:13 29:20]
  wire [7:0] execResult_result_newRegs_27_a = _execResult_T_147 ? io_memDataIn : regs_a; // @[LoadStore.scala 27:13 29:20 30:30]
  wire [7:0] execResult_result_newRegs_27_x = _execResult_T_147 ? regs_x : _GEN_1208; // @[LoadStore.scala 27:13 29:20]
  wire [7:0] execResult_result_newRegs_27_y = _execResult_T_147 ? regs_y : _GEN_1209; // @[LoadStore.scala 27:13 29:20]
  wire  execResult_result_newRegs_27_flagZ = io_memDataIn == 8'h0; // @[LoadStore.scala 36:32]
  wire  execResult_result_isLoadA = opcode == 8'ha5; // @[LoadStore.scala 65:26]
  wire  execResult_result_isLoadX = opcode == 8'ha6; // @[LoadStore.scala 66:26]
  wire  execResult_result_isLoadY = opcode == 8'ha4; // @[LoadStore.scala 67:26]
  wire  execResult_result_isStoreA = opcode == 8'h85; // @[LoadStore.scala 68:27]
  wire  execResult_result_isStoreX = opcode == 8'h86; // @[LoadStore.scala 69:27]
  wire  _execResult_result_T_104 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY; // @[LoadStore.scala 83:33]
  wire [7:0] _GEN_1213 = execResult_result_isLoadX ? io_memDataIn : regs_x; // @[LoadStore.scala 54:13 87:31 88:23]
  wire [7:0] _GEN_1214 = execResult_result_isLoadX ? regs_y : io_memDataIn; // @[LoadStore.scala 54:13 87:31 90:23]
  wire [7:0] _GEN_1215 = execResult_result_isLoadA ? io_memDataIn : regs_a; // @[LoadStore.scala 54:13 85:25 86:23]
  wire [7:0] _GEN_1216 = execResult_result_isLoadA ? regs_x : _GEN_1213; // @[LoadStore.scala 54:13 85:25]
  wire [7:0] _GEN_1217 = execResult_result_isLoadA ? regs_y : _GEN_1214; // @[LoadStore.scala 54:13 85:25]
  wire [7:0] _execResult_result_result_memData_T = execResult_result_isStoreX ? regs_x : regs_y; // @[LoadStore.scala 96:54]
  wire [7:0] _execResult_result_result_memData_T_1 = execResult_result_isStoreA ? regs_a :
    _execResult_result_result_memData_T; // @[LoadStore.scala 96:32]
  wire [7:0] _GEN_1219 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1215
     : regs_a; // @[LoadStore.scala 54:13 83:45]
  wire [7:0] _GEN_1220 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1216
     : regs_x; // @[LoadStore.scala 54:13 83:45]
  wire [7:0] _GEN_1221 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? _GEN_1217
     : regs_y; // @[LoadStore.scala 54:13 83:45]
  wire  _GEN_1222 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? io_memDataIn[7]
     : regs_flagN; // @[LoadStore.scala 54:13 83:45 92:25]
  wire  _GEN_1223 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ?
    execResult_result_newRegs_27_flagZ : regs_flagZ; // @[LoadStore.scala 54:13 83:45 93:25]
  wire  _GEN_1224 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 1'h0 : 1'h1; // @[LoadStore.scala 61:21 83:45 95:27]
  wire [7:0] _GEN_1225 = execResult_result_isLoadA | execResult_result_isLoadX | execResult_result_isLoadY ? 8'h0 :
    _execResult_result_result_memData_T_1; // @[LoadStore.scala 60:20 83:45 96:26]
  wire  _GEN_1227 = _execResult_result_T_21 & _execResult_result_T_104; // @[LoadStore.scala 72:19 62:20]
  wire [7:0] _GEN_1228 = _execResult_result_T_21 ? _GEN_1219 : regs_a; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1229 = _execResult_result_T_21 ? _GEN_1220 : regs_x; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1230 = _execResult_result_T_21 ? _GEN_1221 : regs_y; // @[LoadStore.scala 54:13 72:19]
  wire  _GEN_1231 = _execResult_result_T_21 ? _GEN_1222 : regs_flagN; // @[LoadStore.scala 54:13 72:19]
  wire  _GEN_1232 = _execResult_result_T_21 ? _GEN_1223 : regs_flagZ; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] _GEN_1234 = _execResult_result_T_21 ? _GEN_1225 : 8'h0; // @[LoadStore.scala 72:19 60:20]
  wire [7:0] execResult_result_newRegs_28_a = _execResult_result_T_20 ? regs_a : _GEN_1228; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] execResult_result_newRegs_28_x = _execResult_result_T_20 ? regs_x : _GEN_1229; // @[LoadStore.scala 54:13 72:19]
  wire [7:0] execResult_result_newRegs_28_y = _execResult_result_T_20 ? regs_y : _GEN_1230; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_newRegs_28_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1232; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_newRegs_28_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1231; // @[LoadStore.scala 54:13 72:19]
  wire  execResult_result_result_29_memRead = _execResult_result_T_20 | _GEN_1227; // @[LoadStore.scala 72:19 75:24]
  wire  execResult_result_result_29_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1224; // @[LoadStore.scala 72:19 61:21]
  wire [7:0] execResult_result_result_29_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1234; // @[LoadStore.scala 72:19 60:20]
  wire  execResult_result_isLoadA_1 = opcode == 8'hb5; // @[LoadStore.scala 121:26]
  wire  execResult_result_isLoadY_1 = opcode == 8'hb4; // @[LoadStore.scala 122:26]
  wire  _execResult_result_T_107 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1; // @[LoadStore.scala 136:22]
  wire [7:0] _GEN_1273 = execResult_result_isLoadA_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 110:13 138:25 139:23]
  wire [7:0] _GEN_1274 = execResult_result_isLoadA_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 110:13 138:25 141:23]
  wire [7:0] _execResult_result_result_memData_T_3 = opcode == 8'h95 ? regs_a : regs_y; // @[LoadStore.scala 147:32]
  wire [7:0] _GEN_1276 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_1273 : regs_a; // @[LoadStore.scala 110:13 136:34]
  wire [7:0] _GEN_1277 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? _GEN_1274 : regs_y; // @[LoadStore.scala 110:13 136:34]
  wire  _GEN_1278 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 110:13 136:34 143:25]
  wire  _GEN_1279 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? execResult_result_newRegs_27_flagZ :
    regs_flagZ; // @[LoadStore.scala 110:13 136:34 144:25]
  wire  _GEN_1280 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 117:21 136:34 146:27]
  wire [7:0] _GEN_1281 = execResult_result_isLoadA_1 | execResult_result_isLoadY_1 ? 8'h0 :
    _execResult_result_result_memData_T_3; // @[LoadStore.scala 116:20 136:34 147:26]
  wire  _GEN_1283 = _execResult_result_T_21 & _execResult_result_T_107; // @[LoadStore.scala 125:19 118:20]
  wire [7:0] _GEN_1284 = _execResult_result_T_21 ? _GEN_1276 : regs_a; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] _GEN_1285 = _execResult_result_T_21 ? _GEN_1277 : regs_y; // @[LoadStore.scala 110:13 125:19]
  wire  _GEN_1286 = _execResult_result_T_21 ? _GEN_1278 : regs_flagN; // @[LoadStore.scala 110:13 125:19]
  wire  _GEN_1287 = _execResult_result_T_21 ? _GEN_1279 : regs_flagZ; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] _GEN_1289 = _execResult_result_T_21 ? _GEN_1281 : 8'h0; // @[LoadStore.scala 125:19 116:20]
  wire [7:0] execResult_result_newRegs_29_a = _execResult_result_T_20 ? regs_a : _GEN_1284; // @[LoadStore.scala 110:13 125:19]
  wire [7:0] execResult_result_newRegs_29_y = _execResult_result_T_20 ? regs_y : _GEN_1285; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_newRegs_29_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1287; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_newRegs_29_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1286; // @[LoadStore.scala 110:13 125:19]
  wire  execResult_result_result_30_memRead = _execResult_result_T_20 | _GEN_1283; // @[LoadStore.scala 125:19 128:24]
  wire  execResult_result_result_30_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1280; // @[LoadStore.scala 125:19 117:21]
  wire [7:0] execResult_result_result_30_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1289; // @[LoadStore.scala 125:19 116:20]
  wire  execResult_result_isLoad = opcode == 8'hb6; // @[LoadStore.scala 172:25]
  wire [7:0] _execResult_result_result_operand_T_56 = io_memDataIn + regs_y; // @[LoadStore.scala 178:38]
  wire [7:0] _GEN_1328 = execResult_result_isLoad ? io_memDataIn : regs_x; // @[LoadStore.scala 161:13 184:22 186:21]
  wire  _GEN_1329 = execResult_result_isLoad ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 161:13 184:22 187:25]
  wire  _GEN_1330 = execResult_result_isLoad ? execResult_result_newRegs_27_flagZ : regs_flagZ; // @[LoadStore.scala 161:13 184:22 188:25]
  wire  _GEN_1331 = execResult_result_isLoad ? 1'h0 : 1'h1; // @[LoadStore.scala 168:21 184:22 190:27]
  wire [7:0] _GEN_1332 = execResult_result_isLoad ? 8'h0 : regs_x; // @[LoadStore.scala 167:20 184:22 191:26]
  wire  _GEN_1334 = _execResult_result_T_21 & execResult_result_isLoad; // @[LoadStore.scala 174:19 169:20]
  wire [7:0] _GEN_1335 = _execResult_result_T_21 ? _GEN_1328 : regs_x; // @[LoadStore.scala 161:13 174:19]
  wire  _GEN_1336 = _execResult_result_T_21 ? _GEN_1329 : regs_flagN; // @[LoadStore.scala 161:13 174:19]
  wire  _GEN_1337 = _execResult_result_T_21 ? _GEN_1330 : regs_flagZ; // @[LoadStore.scala 161:13 174:19]
  wire [7:0] _GEN_1339 = _execResult_result_T_21 ? _GEN_1332 : 8'h0; // @[LoadStore.scala 174:19 167:20]
  wire [7:0] execResult_result_newRegs_30_x = _execResult_result_T_20 ? regs_x : _GEN_1335; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_newRegs_30_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1337; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_newRegs_30_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1336; // @[LoadStore.scala 161:13 174:19]
  wire  execResult_result_result_31_memRead = _execResult_result_T_20 | _GEN_1334; // @[LoadStore.scala 174:19 177:24]
  wire [15:0] execResult_result_result_31_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_56} : operand; // @[LoadStore.scala 174:19 170:20 178:24]
  wire  execResult_result_result_31_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_1331; // @[LoadStore.scala 174:19 168:21]
  wire [7:0] execResult_result_result_31_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1339; // @[LoadStore.scala 174:19 167:20]
  wire  execResult_result_isLoadA_2 = opcode == 8'had; // @[LoadStore.scala 216:26]
  wire  execResult_result_isLoadX_1 = opcode == 8'hae; // @[LoadStore.scala 217:26]
  wire  execResult_result_isLoadY_2 = opcode == 8'hac; // @[LoadStore.scala 218:26]
  wire  _execResult_result_T_114 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 |
    execResult_result_isLoadY_2; // @[LoadStore.scala 239:33]
  wire [7:0] _GEN_1375 = execResult_result_isLoadX_1 ? io_memDataIn : regs_x; // @[LoadStore.scala 205:13 243:31 244:23]
  wire [7:0] _GEN_1376 = execResult_result_isLoadX_1 ? regs_y : io_memDataIn; // @[LoadStore.scala 205:13 243:31 246:23]
  wire [7:0] _GEN_1377 = execResult_result_isLoadA_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 205:13 241:25 242:23]
  wire [7:0] _GEN_1378 = execResult_result_isLoadA_2 ? regs_x : _GEN_1375; // @[LoadStore.scala 205:13 241:25]
  wire [7:0] _GEN_1379 = execResult_result_isLoadA_2 ? regs_y : _GEN_1376; // @[LoadStore.scala 205:13 241:25]
  wire  _execResult_result_result_memData_T_4 = opcode == 8'h8e; // @[LoadStore.scala 254:21]
  wire  _execResult_result_result_memData_T_5 = opcode == 8'h8c; // @[LoadStore.scala 255:21]
  wire [7:0] _execResult_result_result_memData_T_6 = _execResult_result_result_memData_T_5 ? regs_y : regs_a; // @[Mux.scala 101:16]
  wire [7:0] _execResult_result_result_memData_T_7 = _execResult_result_result_memData_T_4 ? regs_x :
    _execResult_result_result_memData_T_6; // @[Mux.scala 101:16]
  wire [7:0] _GEN_1381 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_1377 : regs_a; // @[LoadStore.scala 205:13 239:45]
  wire [7:0] _GEN_1382 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_1378 : regs_x; // @[LoadStore.scala 205:13 239:45]
  wire [7:0] _GEN_1383 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    _GEN_1379 : regs_y; // @[LoadStore.scala 205:13 239:45]
  wire  _GEN_1384 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 205:13 239:45 248:25]
  wire  _GEN_1385 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ?
    execResult_result_newRegs_27_flagZ : regs_flagZ; // @[LoadStore.scala 205:13 239:45 249:25]
  wire  _GEN_1386 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 1'h0 : 1'h1
    ; // @[LoadStore.scala 212:21 239:45 251:27]
  wire [7:0] _GEN_1387 = execResult_result_isLoadA_2 | execResult_result_isLoadX_1 | execResult_result_isLoadY_2 ? 8'h0
     : _execResult_result_result_memData_T_7; // @[LoadStore.scala 211:20 239:45 253:26]
  wire  _GEN_1389 = _execResult_result_T_22 & _execResult_result_T_114; // @[LoadStore.scala 220:19 213:20]
  wire [7:0] _GEN_1390 = _execResult_result_T_22 ? _GEN_1381 : regs_a; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_1391 = _execResult_result_T_22 ? _GEN_1382 : regs_x; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_1392 = _execResult_result_T_22 ? _GEN_1383 : regs_y; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_1393 = _execResult_result_T_22 ? _GEN_1384 : regs_flagN; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_1394 = _execResult_result_T_22 ? _GEN_1385 : regs_flagZ; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_1396 = _execResult_result_T_22 ? _GEN_1387 : 8'h0; // @[LoadStore.scala 220:19 211:20]
  wire [7:0] _GEN_1427 = _execResult_result_T_21 ? regs_a : _GEN_1390; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_31_a = _execResult_result_T_20 ? regs_a : _GEN_1427; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_1428 = _execResult_result_T_21 ? regs_x : _GEN_1391; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_31_x = _execResult_result_T_20 ? regs_x : _GEN_1428; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] _GEN_1429 = _execResult_result_T_21 ? regs_y : _GEN_1392; // @[LoadStore.scala 205:13 220:19]
  wire [7:0] execResult_result_newRegs_31_y = _execResult_result_T_20 ? regs_y : _GEN_1429; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_1431 = _execResult_result_T_21 ? regs_flagZ : _GEN_1394; // @[LoadStore.scala 205:13 220:19]
  wire  execResult_result_newRegs_31_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1431; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_1430 = _execResult_result_T_21 ? regs_flagN : _GEN_1393; // @[LoadStore.scala 205:13 220:19]
  wire  execResult_result_newRegs_31_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1430; // @[LoadStore.scala 205:13 220:19]
  wire  _GEN_1411 = _execResult_result_T_21 | _GEN_1389; // @[LoadStore.scala 220:19 231:24]
  wire  _GEN_1432 = _execResult_result_T_21 ? 1'h0 : _execResult_result_T_22 & _GEN_1386; // @[LoadStore.scala 220:19 212:21]
  wire [7:0] _GEN_1433 = _execResult_result_T_21 ? 8'h0 : _GEN_1396; // @[LoadStore.scala 220:19 211:20]
  wire  execResult_result_result_32_memRead = _execResult_result_T_20 | _GEN_1411; // @[LoadStore.scala 220:19 223:24]
  wire  execResult_result_result_32_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_1432; // @[LoadStore.scala 220:19 212:21]
  wire [7:0] execResult_result_result_32_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1433; // @[LoadStore.scala 220:19 211:20]
  wire  execResult_result_useY_3 = opcode == 8'hb9 | opcode == 8'hbe | opcode == 8'h99; // @[LoadStore.scala 282:59]
  wire [7:0] execResult_result_indexReg = execResult_result_useY_3 ? regs_y : regs_x; // @[LoadStore.scala 283:23]
  wire [15:0] _GEN_3212 = {{8'd0}, execResult_result_indexReg}; // @[LoadStore.scala 302:57]
  wire [15:0] _execResult_result_result_operand_T_63 = resetVector + _GEN_3212; // @[LoadStore.scala 302:57]
  wire [7:0] _GEN_1462 = _execResult_result_T_22 ? io_memDataIn : regs_a; // @[LoadStore.scala 270:13 290:19 310:19]
  wire  _GEN_1463 = _execResult_result_T_22 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 270:13 290:19 311:23]
  wire  _GEN_1464 = _execResult_result_T_22 ? execResult_result_newRegs_27_flagZ : regs_flagZ; // @[LoadStore.scala 270:13 290:19 312:23]
  wire [7:0] _GEN_1494 = _execResult_result_T_21 ? regs_a : _GEN_1462; // @[LoadStore.scala 270:13 290:19]
  wire [7:0] execResult_result_newRegs_32_a = _execResult_result_T_20 ? regs_a : _GEN_1494; // @[LoadStore.scala 270:13 290:19]
  wire  _GEN_1496 = _execResult_result_T_21 ? regs_flagZ : _GEN_1464; // @[LoadStore.scala 270:13 290:19]
  wire  execResult_result_newRegs_32_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1496; // @[LoadStore.scala 270:13 290:19]
  wire  _GEN_1495 = _execResult_result_T_21 ? regs_flagN : _GEN_1463; // @[LoadStore.scala 270:13 290:19]
  wire  execResult_result_newRegs_32_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1495; // @[LoadStore.scala 270:13 290:19]
  wire [15:0] _GEN_1479 = _execResult_result_T_21 ? _execResult_result_result_operand_T_63 : operand; // @[LoadStore.scala 290:19 279:20 302:24]
  wire [15:0] execResult_result_result_33_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_1479; // @[LoadStore.scala 290:19 294:24]
  wire  execResult_result_isLoad_1 = opcode == 8'ha1; // @[LoadStore.scala 336:25]
  wire  _GEN_1520 = execResult_result_isLoad_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 332:21 362:22 365:27]
  wire [7:0] _GEN_1521 = execResult_result_isLoad_1 ? 8'h0 : regs_a; // @[LoadStore.scala 331:20 362:22 366:26]
  wire  _execResult_result_T_122 = 3'h4 == cycle; // @[LoadStore.scala 338:19]
  wire [7:0] _GEN_1522 = execResult_result_isLoad_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 325:13 371:22 372:21]
  wire  _GEN_1523 = execResult_result_isLoad_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 325:13 371:22 373:25]
  wire  _GEN_1524 = execResult_result_isLoad_1 ? execResult_result_newRegs_27_flagZ : regs_flagZ; // @[LoadStore.scala 325:13 371:22 374:25]
  wire [7:0] _GEN_1537 = 3'h4 == cycle ? _GEN_1522 : regs_a; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_1557 = _execResult_result_T_26 ? regs_a : _GEN_1537; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_1578 = _execResult_result_T_22 ? regs_a : _GEN_1557; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] _GEN_1599 = _execResult_result_T_21 ? regs_a : _GEN_1578; // @[LoadStore.scala 325:13 338:19]
  wire [7:0] execResult_result_newRegs_33_a = _execResult_result_T_20 ? regs_a : _GEN_1599; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1539 = 3'h4 == cycle ? _GEN_1524 : regs_flagZ; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1559 = _execResult_result_T_26 ? regs_flagZ : _GEN_1539; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1580 = _execResult_result_T_22 ? regs_flagZ : _GEN_1559; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1601 = _execResult_result_T_21 ? regs_flagZ : _GEN_1580; // @[LoadStore.scala 325:13 338:19]
  wire  execResult_result_newRegs_33_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1601; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1538 = 3'h4 == cycle ? _GEN_1523 : regs_flagN; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1558 = _execResult_result_T_26 ? regs_flagN : _GEN_1538; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1579 = _execResult_result_T_22 ? regs_flagN : _GEN_1558; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1600 = _execResult_result_T_21 ? regs_flagN : _GEN_1579; // @[LoadStore.scala 325:13 338:19]
  wire  execResult_result_newRegs_33_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1600; // @[LoadStore.scala 325:13 338:19]
  wire  _GEN_1554 = _execResult_result_T_26 & execResult_result_isLoad_1; // @[LoadStore.scala 338:19 333:20]
  wire [7:0] _GEN_1556 = _execResult_result_T_26 ? _GEN_1521 : 8'h0; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_1572 = _execResult_result_T_26 ? 1'h0 : 3'h4 == cycle; // @[LoadStore.scala 327:17 338:19]
  wire  _GEN_1574 = _execResult_result_T_22 | _GEN_1554; // @[LoadStore.scala 338:19 356:24]
  wire  _GEN_1576 = _execResult_result_T_22 ? 1'h0 : _execResult_result_T_26 & _GEN_1520; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] _GEN_1577 = _execResult_result_T_22 ? 8'h0 : _GEN_1556; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_1593 = _execResult_result_T_22 ? 1'h0 : _GEN_1572; // @[LoadStore.scala 327:17 338:19]
  wire  _GEN_1595 = _execResult_result_T_21 | _GEN_1574; // @[LoadStore.scala 338:19 350:24]
  wire  _GEN_1597 = _execResult_result_T_21 ? 1'h0 : _GEN_1576; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] _GEN_1598 = _execResult_result_T_21 ? 8'h0 : _GEN_1577; // @[LoadStore.scala 338:19 331:20]
  wire  _GEN_1614 = _execResult_result_T_21 ? 1'h0 : _GEN_1593; // @[LoadStore.scala 327:17 338:19]
  wire  execResult_result_result_34_memRead = _execResult_result_T_20 | _GEN_1595; // @[LoadStore.scala 338:19 342:24]
  wire  execResult_result_result_34_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_1597; // @[LoadStore.scala 338:19 332:21]
  wire [7:0] execResult_result_result_34_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1598; // @[LoadStore.scala 338:19 331:20]
  wire  execResult_result_result_34_done = _execResult_result_T_20 ? 1'h0 : _GEN_1614; // @[LoadStore.scala 327:17 338:19]
  wire  execResult_result_isLoad_2 = opcode == 8'hb1; // @[LoadStore.scala 399:25]
  wire [15:0] execResult_result_finalAddr = operand + _GEN_3208; // @[LoadStore.scala 424:33]
  wire  _GEN_1638 = execResult_result_isLoad_2 ? 1'h0 : 1'h1; // @[LoadStore.scala 395:21 426:22 429:27]
  wire [7:0] _GEN_1639 = execResult_result_isLoad_2 ? 8'h0 : regs_a; // @[LoadStore.scala 394:20 426:22 430:26]
  wire [7:0] _GEN_1640 = execResult_result_isLoad_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 388:13 435:22 436:21]
  wire  _GEN_1641 = execResult_result_isLoad_2 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 388:13 435:22 437:25]
  wire  _GEN_1642 = execResult_result_isLoad_2 ? execResult_result_newRegs_27_flagZ : regs_flagZ; // @[LoadStore.scala 388:13 435:22 438:25]
  wire [7:0] _GEN_1655 = _execResult_result_T_122 ? _GEN_1640 : regs_a; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_1675 = _execResult_result_T_26 ? regs_a : _GEN_1655; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_1696 = _execResult_result_T_22 ? regs_a : _GEN_1675; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] _GEN_1717 = _execResult_result_T_21 ? regs_a : _GEN_1696; // @[LoadStore.scala 388:13 401:19]
  wire [7:0] execResult_result_newRegs_34_a = _execResult_result_T_20 ? regs_a : _GEN_1717; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_1657 = _execResult_result_T_122 ? _GEN_1642 : regs_flagZ; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_1677 = _execResult_result_T_26 ? regs_flagZ : _GEN_1657; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_1698 = _execResult_result_T_22 ? regs_flagZ : _GEN_1677; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_1719 = _execResult_result_T_21 ? regs_flagZ : _GEN_1698; // @[LoadStore.scala 388:13 401:19]
  wire  execResult_result_newRegs_34_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1719; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_1656 = _execResult_result_T_122 ? _GEN_1641 : regs_flagN; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_1676 = _execResult_result_T_26 ? regs_flagN : _GEN_1656; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_1697 = _execResult_result_T_22 ? regs_flagN : _GEN_1676; // @[LoadStore.scala 388:13 401:19]
  wire  _GEN_1718 = _execResult_result_T_21 ? regs_flagN : _GEN_1697; // @[LoadStore.scala 388:13 401:19]
  wire  execResult_result_newRegs_34_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1718; // @[LoadStore.scala 388:13 401:19]
  wire [15:0] _GEN_1671 = _execResult_result_T_26 ? execResult_result_finalAddr : 16'h0; // @[LoadStore.scala 401:19 393:20 425:24]
  wire  _GEN_1672 = _execResult_result_T_26 & execResult_result_isLoad_2; // @[LoadStore.scala 401:19 396:20]
  wire [7:0] _GEN_1674 = _execResult_result_T_26 ? _GEN_1639 : 8'h0; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] _GEN_1691 = _execResult_result_T_22 ? {{8'd0}, _execResult_result_result_memAddr_T_3} : _GEN_1671; // @[LoadStore.scala 401:19 418:24]
  wire  _GEN_1692 = _execResult_result_T_22 | _GEN_1672; // @[LoadStore.scala 401:19 419:24]
  wire  _GEN_1694 = _execResult_result_T_22 ? 1'h0 : _execResult_result_T_26 & _GEN_1638; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] _GEN_1695 = _execResult_result_T_22 ? 8'h0 : _GEN_1674; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] _GEN_1712 = _execResult_result_T_21 ? {{8'd0}, operand[7:0]} : _GEN_1691; // @[LoadStore.scala 401:19 412:24]
  wire  _GEN_1713 = _execResult_result_T_21 | _GEN_1692; // @[LoadStore.scala 401:19 413:24]
  wire  _GEN_1715 = _execResult_result_T_21 ? 1'h0 : _GEN_1694; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] _GEN_1716 = _execResult_result_T_21 ? 8'h0 : _GEN_1695; // @[LoadStore.scala 401:19 394:20]
  wire [15:0] execResult_result_result_35_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_1712; // @[LoadStore.scala 401:19 404:24]
  wire  execResult_result_result_35_memRead = _execResult_result_T_20 | _GEN_1713; // @[LoadStore.scala 401:19 405:24]
  wire  execResult_result_result_35_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_1715; // @[LoadStore.scala 401:19 395:21]
  wire [7:0] execResult_result_result_35_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1716; // @[LoadStore.scala 401:19 394:20]
  wire [7:0] _execResult_result_pushData_T = {regs_flagN,regs_flagV,2'h3,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] execResult_result_pushData = opcode == 8'h8 ? _execResult_result_pushData_T : regs_a; // @[Stack.scala 21:14 23:29 24:16]
  wire [7:0] execResult_result_newRegs_35_sp = regs_sp - 8'h1; // @[Stack.scala 27:27]
  wire [15:0] execResult_result_result_36_memAddr = {8'h1,regs_sp}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_newRegs_sp_T_3 = regs_sp + 8'h1; // @[Stack.scala 57:31]
  wire [7:0] _GEN_1756 = opcode == 8'h68 ? io_memDataIn : regs_a; // @[Stack.scala 44:13 65:33 66:21]
  wire  _GEN_1757 = opcode == 8'h68 ? io_memDataIn[7] : io_memDataIn[7]; // @[Stack.scala 65:33 67:25 75:25]
  wire  _GEN_1758 = opcode == 8'h68 ? execResult_result_newRegs_27_flagZ : io_memDataIn[1]; // @[Stack.scala 65:33 68:25 71:25]
  wire  _GEN_1759 = opcode == 8'h68 ? regs_flagC : io_memDataIn[0]; // @[Stack.scala 44:13 65:33 70:25]
  wire  _GEN_1760 = opcode == 8'h68 ? regs_flagI : io_memDataIn[2]; // @[Stack.scala 44:13 65:33 72:25]
  wire  _GEN_1761 = opcode == 8'h68 ? regs_flagD : io_memDataIn[3]; // @[Stack.scala 44:13 65:33 73:25]
  wire  _GEN_1762 = opcode == 8'h68 ? regs_flagV : io_memDataIn[6]; // @[Stack.scala 44:13 65:33 74:25]
  wire [15:0] _GEN_1763 = _execResult_result_T_21 ? execResult_result_result_36_memAddr : 16'h0; // @[Stack.scala 55:19 49:20 62:24]
  wire [7:0] _GEN_1765 = _execResult_result_T_21 ? _GEN_1756 : regs_a; // @[Stack.scala 44:13 55:19]
  wire  _GEN_1766 = _execResult_result_T_21 ? _GEN_1757 : regs_flagN; // @[Stack.scala 44:13 55:19]
  wire  _GEN_1767 = _execResult_result_T_21 ? _GEN_1758 : regs_flagZ; // @[Stack.scala 44:13 55:19]
  wire  _GEN_1768 = _execResult_result_T_21 ? _GEN_1759 : regs_flagC; // @[Stack.scala 44:13 55:19]
  wire  _GEN_1769 = _execResult_result_T_21 ? _GEN_1760 : regs_flagI; // @[Stack.scala 44:13 55:19]
  wire  _GEN_1770 = _execResult_result_T_21 ? _GEN_1761 : regs_flagD; // @[Stack.scala 44:13 55:19]
  wire  _GEN_1771 = _execResult_result_T_21 ? _GEN_1762 : regs_flagV; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_36_a = _execResult_result_T_20 ? regs_a : _GEN_1765; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_36_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Stack.scala 44:13 55:19 57:20]
  wire  execResult_result_newRegs_36_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_1768; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_36_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_1767; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_36_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_1769; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_36_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_1770; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_36_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_1771; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_36_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_1766; // @[Stack.scala 44:13 55:19]
  wire [15:0] execResult_result_result_37_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_1763; // @[Stack.scala 55:19 49:20]
  wire [15:0] _GEN_1807 = _execResult_result_T_21 ? regs_pc : 16'h0; // @[Jump.scala 26:19 20:20 36:24]
  wire [15:0] _GEN_1809 = _execResult_result_T_21 ? resetVector : regs_pc; // @[Jump.scala 15:13 26:19 38:20]
  wire [15:0] execResult_result_newRegs_37_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_1809; // @[Jump.scala 26:19 31:20]
  wire [15:0] execResult_result_result_38_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_1807; // @[Jump.scala 26:19 28:24]
  wire [15:0] _GEN_1840 = _execResult_result_T_26 ? execResult_result_result_36_memAddr : 16'h0; // @[Jump.scala 62:19 56:20 86:24]
  wire [7:0] _GEN_1841 = _execResult_result_T_26 ? regs_pc[7:0] : 8'h0; // @[Jump.scala 62:19 57:20 87:24]
  wire [7:0] _GEN_1843 = _execResult_result_T_26 ? execResult_result_newRegs_35_sp : regs_sp; // @[Jump.scala 51:13 62:19 89:20]
  wire [15:0] _GEN_1844 = _execResult_result_T_26 ? operand : regs_pc; // @[Jump.scala 51:13 62:19 90:20]
  wire [7:0] _GEN_1860 = _execResult_result_T_22 ? execResult_result_newRegs_35_sp : _GEN_1843; // @[Jump.scala 62:19 81:20]
  wire [7:0] _GEN_1882 = _execResult_result_T_21 ? regs_sp : _GEN_1860; // @[Jump.scala 51:13 62:19]
  wire [7:0] execResult_result_newRegs_38_sp = _execResult_result_T_20 ? regs_sp : _GEN_1882; // @[Jump.scala 51:13 62:19]
  wire [15:0] _GEN_1874 = _execResult_result_T_22 ? regs_pc : _GEN_1844; // @[Jump.scala 51:13 62:19]
  wire [15:0] _GEN_1895 = _execResult_result_T_21 ? regs_pc : _GEN_1874; // @[Jump.scala 51:13 62:19]
  wire [15:0] execResult_result_newRegs_38_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_1895; // @[Jump.scala 62:19 67:20]
  wire [15:0] _GEN_1857 = _execResult_result_T_22 ? execResult_result_result_36_memAddr : _GEN_1840; // @[Jump.scala 62:19 78:24]
  wire [7:0] _GEN_1858 = _execResult_result_T_22 ? regs_pc[15:8] : _GEN_1841; // @[Jump.scala 62:19 79:24]
  wire [2:0] _GEN_1873 = _execResult_result_T_22 ? 3'h3 : _execResult_result_result_nextCycle_T_1; // @[Jump.scala 62:19 54:22 83:26]
  wire [15:0] _GEN_1876 = _execResult_result_T_21 ? regs_pc : _GEN_1857; // @[Jump.scala 62:19 72:24]
  wire [2:0] _GEN_1879 = _execResult_result_T_21 ? 3'h2 : _GEN_1873; // @[Jump.scala 62:19 75:26]
  wire [7:0] _GEN_1880 = _execResult_result_T_21 ? 8'h0 : _GEN_1858; // @[Jump.scala 62:19 57:20]
  wire  _GEN_1881 = _execResult_result_T_21 ? 1'h0 : _GEN_575; // @[Jump.scala 62:19 58:21]
  wire [15:0] execResult_result_result_39_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_1876; // @[Jump.scala 62:19 64:24]
  wire [2:0] execResult_result_result_39_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_1879; // @[Jump.scala 62:19 69:26]
  wire [7:0] execResult_result_result_39_memData = _execResult_result_T_20 ? 8'h0 : _GEN_1880; // @[Jump.scala 62:19 57:20]
  wire  execResult_result_result_39_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_1881; // @[Jump.scala 62:19 58:21]
  wire [15:0] _execResult_result_newRegs_pc_T_91 = resetVector + 16'h1; // @[Jump.scala 131:53]
  wire [15:0] _GEN_1918 = _execResult_result_T_22 ? execResult_result_result_36_memAddr : 16'h0; // @[Jump.scala 114:19 108:20 129:24]
  wire [15:0] _GEN_1920 = _execResult_result_T_22 ? _execResult_result_newRegs_pc_T_91 : regs_pc; // @[Jump.scala 103:13 114:19 131:20]
  wire [7:0] _GEN_1936 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 103:13 114:19 124:20]
  wire [7:0] execResult_result_newRegs_39_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_1936; // @[Jump.scala 114:19 116:20]
  wire [15:0] _GEN_1950 = _execResult_result_T_21 ? regs_pc : _GEN_1920; // @[Jump.scala 103:13 114:19]
  wire [15:0] execResult_result_newRegs_39_pc = _execResult_result_T_20 ? regs_pc : _GEN_1950; // @[Jump.scala 103:13 114:19]
  wire [15:0] _GEN_1933 = _execResult_result_T_21 ? execResult_result_result_36_memAddr : _GEN_1918; // @[Jump.scala 114:19 121:24]
  wire [15:0] _GEN_1935 = _execResult_result_T_21 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 114:19 112:20 123:24]
  wire [15:0] execResult_result_result_40_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_1933; // @[Jump.scala 114:19 108:20]
  wire  execResult_result_result_40_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_202; // @[Jump.scala 114:19 111:20]
  wire [15:0] execResult_result_result_40_operand = _execResult_result_T_20 ? operand : _GEN_1935; // @[Jump.scala 114:19 112:20]
  wire [15:0] _GEN_1971 = 3'h5 == cycle ? 16'hffff : 16'h0; // @[Jump.scala 155:19 149:20 195:24]
  wire [15:0] _GEN_1973 = 3'h5 == cycle ? resetVector : regs_pc; // @[Jump.scala 144:13 155:19 197:20]
  wire [7:0] _GEN_2053 = _execResult_result_T_21 ? execResult_result_newRegs_35_sp : _GEN_1860; // @[Jump.scala 155:19 165:20]
  wire [7:0] execResult_result_newRegs_40_sp = _execResult_result_T_20 ? regs_sp : _GEN_2053; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_1990 = _execResult_result_T_122 ? regs_pc : _GEN_1973; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_2025 = _execResult_result_T_26 ? regs_pc : _GEN_1990; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_2048 = _execResult_result_T_22 ? regs_pc : _GEN_2025; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_2071 = _execResult_result_T_21 ? regs_pc : _GEN_2048; // @[Jump.scala 144:13 155:19]
  wire [15:0] execResult_result_newRegs_40_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_2071; // @[Jump.scala 155:19 157:20]
  wire  _GEN_2008 = _execResult_result_T_26 | regs_flagI; // @[Jump.scala 144:13 155:19 183:23]
  wire  _GEN_2044 = _execResult_result_T_22 ? regs_flagI : _GEN_2008; // @[Jump.scala 144:13 155:19]
  wire  _GEN_2067 = _execResult_result_T_21 ? regs_flagI : _GEN_2044; // @[Jump.scala 144:13 155:19]
  wire  execResult_result_newRegs_40_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2067; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_1986 = _execResult_result_T_122 ? 16'hfffe : _GEN_1971; // @[Jump.scala 155:19 189:24]
  wire  _GEN_1987 = _execResult_result_T_122 | 3'h5 == cycle; // @[Jump.scala 155:19 190:24]
  wire [15:0] _GEN_1988 = _execResult_result_T_122 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 155:19 153:20 191:24]
  wire [2:0] _GEN_1989 = _execResult_result_T_122 ? 3'h5 : _execResult_result_result_nextCycle_T_1; // @[Jump.scala 155:19 147:22 192:26]
  wire  _GEN_2003 = _execResult_result_T_122 ? 1'h0 : 3'h5 == cycle; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_2004 = _execResult_result_T_26 ? execResult_result_result_36_memAddr : _GEN_1986; // @[Jump.scala 155:19 179:24]
  wire [7:0] _GEN_2005 = _execResult_result_T_26 ? _execResult_result_pushData_T : 8'h0; // @[Jump.scala 155:19 150:20 180:24]
  wire [2:0] _GEN_2022 = _execResult_result_T_26 ? 3'h4 : _GEN_1989; // @[Jump.scala 155:19 186:26]
  wire  _GEN_2023 = _execResult_result_T_26 ? 1'h0 : _GEN_1987; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_2024 = _execResult_result_T_26 ? operand : _GEN_1988; // @[Jump.scala 155:19 153:20]
  wire  _GEN_2026 = _execResult_result_T_26 ? 1'h0 : _GEN_2003; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_2027 = _execResult_result_T_22 ? execResult_result_result_36_memAddr : _GEN_2004; // @[Jump.scala 155:19 170:24]
  wire [7:0] _GEN_2028 = _execResult_result_T_22 ? regs_pc[7:0] : _GEN_2005; // @[Jump.scala 155:19 171:24]
  wire [2:0] _GEN_2043 = _execResult_result_T_22 ? 3'h3 : _GEN_2022; // @[Jump.scala 155:19 175:26]
  wire  _GEN_2046 = _execResult_result_T_22 ? 1'h0 : _GEN_2023; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_2047 = _execResult_result_T_22 ? operand : _GEN_2024; // @[Jump.scala 155:19 153:20]
  wire  _GEN_2049 = _execResult_result_T_22 ? 1'h0 : _GEN_2026; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_2050 = _execResult_result_T_21 ? execResult_result_result_36_memAddr : _GEN_2027; // @[Jump.scala 155:19 162:24]
  wire [7:0] _GEN_2051 = _execResult_result_T_21 ? regs_pc[15:8] : _GEN_2028; // @[Jump.scala 155:19 163:24]
  wire [2:0] _GEN_2066 = _execResult_result_T_21 ? 3'h2 : _GEN_2043; // @[Jump.scala 155:19 167:26]
  wire  _GEN_2069 = _execResult_result_T_21 ? 1'h0 : _GEN_2046; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_2070 = _execResult_result_T_21 ? operand : _GEN_2047; // @[Jump.scala 155:19 153:20]
  wire  _GEN_2072 = _execResult_result_T_21 ? 1'h0 : _GEN_2049; // @[Jump.scala 146:17 155:19]
  wire [2:0] execResult_result_result_41_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_2066; // @[Jump.scala 155:19 159:26]
  wire [15:0] execResult_result_result_41_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2050; // @[Jump.scala 155:19 149:20]
  wire [7:0] execResult_result_result_41_memData = _execResult_result_T_20 ? 8'h0 : _GEN_2051; // @[Jump.scala 155:19 150:20]
  wire  execResult_result_result_41_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_594; // @[Jump.scala 155:19 151:21]
  wire  execResult_result_result_41_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_2069; // @[Jump.scala 155:19 152:20]
  wire [15:0] execResult_result_result_41_operand = _execResult_result_T_20 ? operand : _GEN_2070; // @[Jump.scala 155:19 153:20]
  wire  execResult_result_result_41_done = _execResult_result_T_20 ? 1'h0 : _GEN_2072; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_2098 = _execResult_result_T_26 ? resetVector : regs_pc; // @[Jump.scala 210:13 221:19 251:20]
  wire [7:0] _GEN_2114 = _execResult_result_T_22 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 210:13 221:19 244:20]
  wire [7:0] _GEN_2138 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : _GEN_2114; // @[Jump.scala 221:19 236:20]
  wire [7:0] execResult_result_newRegs_41_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_2138; // @[Jump.scala 221:19 223:20]
  wire [15:0] _GEN_2128 = _execResult_result_T_22 ? regs_pc : _GEN_2098; // @[Jump.scala 210:13 221:19]
  wire [15:0] _GEN_2153 = _execResult_result_T_21 ? regs_pc : _GEN_2128; // @[Jump.scala 210:13 221:19]
  wire [15:0] execResult_result_newRegs_41_pc = _execResult_result_T_20 ? regs_pc : _GEN_2153; // @[Jump.scala 210:13 221:19]
  wire  _GEN_2132 = _execResult_result_T_21 ? io_memDataIn[0] : regs_flagC; // @[Jump.scala 210:13 221:19 230:23]
  wire  execResult_result_newRegs_41_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_2132; // @[Jump.scala 210:13 221:19]
  wire  _GEN_2133 = _execResult_result_T_21 ? io_memDataIn[1] : regs_flagZ; // @[Jump.scala 210:13 221:19 231:23]
  wire  execResult_result_newRegs_41_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_2133; // @[Jump.scala 210:13 221:19]
  wire  _GEN_2134 = _execResult_result_T_21 ? io_memDataIn[2] : regs_flagI; // @[Jump.scala 210:13 221:19 232:23]
  wire  execResult_result_newRegs_41_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_2134; // @[Jump.scala 210:13 221:19]
  wire  _GEN_2135 = _execResult_result_T_21 ? io_memDataIn[3] : regs_flagD; // @[Jump.scala 210:13 221:19 233:23]
  wire  execResult_result_newRegs_41_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_2135; // @[Jump.scala 210:13 221:19]
  wire [15:0] _GEN_2113 = _execResult_result_T_22 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 221:19 219:20 243:24]
  wire [15:0] _GEN_2130 = _execResult_result_T_21 ? execResult_result_result_36_memAddr : _GEN_1857; // @[Jump.scala 221:19 228:24]
  wire [15:0] _GEN_2152 = _execResult_result_T_21 ? operand : _GEN_2113; // @[Jump.scala 221:19 219:20]
  wire [15:0] execResult_result_result_42_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_2130; // @[Jump.scala 221:19 215:20]
  wire [15:0] execResult_result_result_42_operand = _execResult_result_T_20 ? operand : _GEN_2152; // @[Jump.scala 221:19 219:20]
  wire  _GEN_2180 = 8'h40 == opcode & execResult_result_result_7_done; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire [2:0] _GEN_2181 = 8'h40 == opcode ? execResult_result_result_39_nextCycle : 3'h0; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire [7:0] _GEN_2185 = 8'h40 == opcode ? execResult_result_newRegs_41_sp : regs_sp; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire [15:0] _GEN_2186 = 8'h40 == opcode ? execResult_result_newRegs_41_pc : regs_pc; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire  _GEN_2187 = 8'h40 == opcode ? execResult_result_newRegs_41_flagC : regs_flagC; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire  _GEN_2188 = 8'h40 == opcode ? execResult_result_newRegs_41_flagZ : regs_flagZ; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire  _GEN_2189 = 8'h40 == opcode ? execResult_result_newRegs_41_flagI : regs_flagI; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire  _GEN_2190 = 8'h40 == opcode ? execResult_result_newRegs_41_flagD : regs_flagD; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire  _GEN_2192 = 8'h40 == opcode ? execResult_result_newRegs_9_flagV : regs_flagV; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire  _GEN_2193 = 8'h40 == opcode ? execResult_result_newRegs_9_flagN : regs_flagN; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire [15:0] _GEN_2194 = 8'h40 == opcode ? execResult_result_result_42_memAddr : 16'h0; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire  _GEN_2197 = 8'h40 == opcode & execResult_result_result_41_memWrite; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire [15:0] _GEN_2198 = 8'h40 == opcode ? execResult_result_result_42_operand : operand; // @[CPU6502Core.scala 207:12 209:20 392:27]
  wire  _GEN_2199 = 8'h0 == opcode ? execResult_result_result_41_done : _GEN_2180; // @[CPU6502Core.scala 209:20 391:27]
  wire [2:0] _GEN_2200 = 8'h0 == opcode ? execResult_result_result_41_nextCycle : _GEN_2181; // @[CPU6502Core.scala 209:20 391:27]
  wire [7:0] _GEN_2204 = 8'h0 == opcode ? execResult_result_newRegs_40_sp : _GEN_2185; // @[CPU6502Core.scala 209:20 391:27]
  wire [15:0] _GEN_2205 = 8'h0 == opcode ? execResult_result_newRegs_40_pc : _GEN_2186; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2206 = 8'h0 == opcode ? regs_flagC : _GEN_2187; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2207 = 8'h0 == opcode ? regs_flagZ : _GEN_2188; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2208 = 8'h0 == opcode ? execResult_result_newRegs_40_flagI : _GEN_2189; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2209 = 8'h0 == opcode ? regs_flagD : _GEN_2190; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2211 = 8'h0 == opcode ? regs_flagV : _GEN_2192; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2212 = 8'h0 == opcode ? regs_flagN : _GEN_2193; // @[CPU6502Core.scala 209:20 391:27]
  wire [15:0] _GEN_2213 = 8'h0 == opcode ? execResult_result_result_41_memAddr : _GEN_2194; // @[CPU6502Core.scala 209:20 391:27]
  wire [7:0] _GEN_2214 = 8'h0 == opcode ? execResult_result_result_41_memData : 8'h0; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2215 = 8'h0 == opcode & execResult_result_result_41_memWrite; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2216 = 8'h0 == opcode ? execResult_result_result_41_memRead : _GEN_2197; // @[CPU6502Core.scala 209:20 391:27]
  wire [15:0] _GEN_2217 = 8'h0 == opcode ? execResult_result_result_41_operand : _GEN_2198; // @[CPU6502Core.scala 209:20 391:27]
  wire  _GEN_2218 = 8'h60 == opcode ? execResult_result_result_6_done : _GEN_2199; // @[CPU6502Core.scala 209:20 390:27]
  wire [2:0] _GEN_2219 = 8'h60 == opcode ? execResult_result_result_6_nextCycle : _GEN_2200; // @[CPU6502Core.scala 209:20 390:27]
  wire [7:0] _GEN_2223 = 8'h60 == opcode ? execResult_result_newRegs_39_sp : _GEN_2204; // @[CPU6502Core.scala 209:20 390:27]
  wire [15:0] _GEN_2224 = 8'h60 == opcode ? execResult_result_newRegs_39_pc : _GEN_2205; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2225 = 8'h60 == opcode ? regs_flagC : _GEN_2206; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2226 = 8'h60 == opcode ? regs_flagZ : _GEN_2207; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2227 = 8'h60 == opcode ? regs_flagI : _GEN_2208; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2228 = 8'h60 == opcode ? regs_flagD : _GEN_2209; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2230 = 8'h60 == opcode ? regs_flagV : _GEN_2211; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2231 = 8'h60 == opcode ? regs_flagN : _GEN_2212; // @[CPU6502Core.scala 209:20 390:27]
  wire [15:0] _GEN_2232 = 8'h60 == opcode ? execResult_result_result_40_memAddr : _GEN_2213; // @[CPU6502Core.scala 209:20 390:27]
  wire [7:0] _GEN_2233 = 8'h60 == opcode ? 8'h0 : _GEN_2214; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2234 = 8'h60 == opcode ? 1'h0 : _GEN_2215; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2235 = 8'h60 == opcode ? execResult_result_result_40_memRead : _GEN_2216; // @[CPU6502Core.scala 209:20 390:27]
  wire [15:0] _GEN_2236 = 8'h60 == opcode ? execResult_result_result_40_operand : _GEN_2217; // @[CPU6502Core.scala 209:20 390:27]
  wire  _GEN_2237 = 8'h20 == opcode ? execResult_result_result_7_done : _GEN_2218; // @[CPU6502Core.scala 209:20 389:27]
  wire [2:0] _GEN_2238 = 8'h20 == opcode ? execResult_result_result_39_nextCycle : _GEN_2219; // @[CPU6502Core.scala 209:20 389:27]
  wire [7:0] _GEN_2242 = 8'h20 == opcode ? execResult_result_newRegs_38_sp : _GEN_2223; // @[CPU6502Core.scala 209:20 389:27]
  wire [15:0] _GEN_2243 = 8'h20 == opcode ? execResult_result_newRegs_38_pc : _GEN_2224; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2244 = 8'h20 == opcode ? regs_flagC : _GEN_2225; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2245 = 8'h20 == opcode ? regs_flagZ : _GEN_2226; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2246 = 8'h20 == opcode ? regs_flagI : _GEN_2227; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2247 = 8'h20 == opcode ? regs_flagD : _GEN_2228; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2249 = 8'h20 == opcode ? regs_flagV : _GEN_2230; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2250 = 8'h20 == opcode ? regs_flagN : _GEN_2231; // @[CPU6502Core.scala 209:20 389:27]
  wire [15:0] _GEN_2251 = 8'h20 == opcode ? execResult_result_result_39_memAddr : _GEN_2232; // @[CPU6502Core.scala 209:20 389:27]
  wire [7:0] _GEN_2252 = 8'h20 == opcode ? execResult_result_result_39_memData : _GEN_2233; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2253 = 8'h20 == opcode ? execResult_result_result_39_memWrite : _GEN_2234; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2254 = 8'h20 == opcode ? execResult_result_result_6_memRead : _GEN_2235; // @[CPU6502Core.scala 209:20 389:27]
  wire [15:0] _GEN_2255 = 8'h20 == opcode ? execResult_result_result_7_operand : _GEN_2236; // @[CPU6502Core.scala 209:20 389:27]
  wire  _GEN_2256 = 8'h4c == opcode ? execResult_result_result_10_done : _GEN_2237; // @[CPU6502Core.scala 209:20 388:27]
  wire [2:0] _GEN_2257 = 8'h4c == opcode ? execResult_result_result_10_nextCycle : _GEN_2238; // @[CPU6502Core.scala 209:20 388:27]
  wire [7:0] _GEN_2261 = 8'h4c == opcode ? regs_sp : _GEN_2242; // @[CPU6502Core.scala 209:20 388:27]
  wire [15:0] _GEN_2262 = 8'h4c == opcode ? execResult_result_newRegs_37_pc : _GEN_2243; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2263 = 8'h4c == opcode ? regs_flagC : _GEN_2244; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2264 = 8'h4c == opcode ? regs_flagZ : _GEN_2245; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2265 = 8'h4c == opcode ? regs_flagI : _GEN_2246; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2266 = 8'h4c == opcode ? regs_flagD : _GEN_2247; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2268 = 8'h4c == opcode ? regs_flagV : _GEN_2249; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2269 = 8'h4c == opcode ? regs_flagN : _GEN_2250; // @[CPU6502Core.scala 209:20 388:27]
  wire [15:0] _GEN_2270 = 8'h4c == opcode ? execResult_result_result_38_memAddr : _GEN_2251; // @[CPU6502Core.scala 209:20 388:27]
  wire [7:0] _GEN_2271 = 8'h4c == opcode ? 8'h0 : _GEN_2252; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2272 = 8'h4c == opcode ? 1'h0 : _GEN_2253; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2273 = 8'h4c == opcode ? execResult_result_result_6_memRead : _GEN_2254; // @[CPU6502Core.scala 209:20 388:27]
  wire [15:0] _GEN_2274 = 8'h4c == opcode ? execResult_result_result_6_operand : _GEN_2255; // @[CPU6502Core.scala 209:20 388:27]
  wire  _GEN_2275 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_10_done : _GEN_2256; // @[CPU6502Core.scala 209:20 384:16]
  wire [2:0] _GEN_2276 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_10_nextCycle : _GEN_2257; // @[CPU6502Core.scala 209:20 384:16]
  wire [7:0] _GEN_2277 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_36_a : regs_a; // @[CPU6502Core.scala 209:20 384:16]
  wire [7:0] _GEN_2280 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_36_sp : _GEN_2261; // @[CPU6502Core.scala 209:20 384:16]
  wire [15:0] _GEN_2281 = 8'h68 == opcode | 8'h28 == opcode ? regs_pc : _GEN_2262; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2282 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_36_flagC : _GEN_2263; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2283 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_36_flagZ : _GEN_2264; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2284 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_36_flagI : _GEN_2265; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2285 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_36_flagD : _GEN_2266; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2287 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_36_flagV : _GEN_2268; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2288 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_36_flagN : _GEN_2269; // @[CPU6502Core.scala 209:20 384:16]
  wire [15:0] _GEN_2289 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_37_memAddr : _GEN_2270; // @[CPU6502Core.scala 209:20 384:16]
  wire [7:0] _GEN_2290 = 8'h68 == opcode | 8'h28 == opcode ? 8'h0 : _GEN_2271; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2291 = 8'h68 == opcode | 8'h28 == opcode ? 1'h0 : _GEN_2272; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2292 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_10_done : _GEN_2273; // @[CPU6502Core.scala 209:20 384:16]
  wire [15:0] _GEN_2293 = 8'h68 == opcode | 8'h28 == opcode ? 16'h0 : _GEN_2274; // @[CPU6502Core.scala 209:20 384:16]
  wire  _GEN_2294 = 8'h48 == opcode | 8'h8 == opcode | _GEN_2275; // @[CPU6502Core.scala 209:20 379:16]
  wire [2:0] _GEN_2295 = 8'h48 == opcode | 8'h8 == opcode ? 3'h0 : _GEN_2276; // @[CPU6502Core.scala 209:20 379:16]
  wire [7:0] _GEN_2296 = 8'h48 == opcode | 8'h8 == opcode ? regs_a : _GEN_2277; // @[CPU6502Core.scala 209:20 379:16]
  wire [7:0] _GEN_2299 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_newRegs_35_sp : _GEN_2280; // @[CPU6502Core.scala 209:20 379:16]
  wire [15:0] _GEN_2300 = 8'h48 == opcode | 8'h8 == opcode ? regs_pc : _GEN_2281; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2301 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagC : _GEN_2282; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2302 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagZ : _GEN_2283; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2303 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagI : _GEN_2284; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2304 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagD : _GEN_2285; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2306 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagV : _GEN_2287; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2307 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagN : _GEN_2288; // @[CPU6502Core.scala 209:20 379:16]
  wire [15:0] _GEN_2308 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_result_36_memAddr : _GEN_2289; // @[CPU6502Core.scala 209:20 379:16]
  wire [7:0] _GEN_2309 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_pushData : _GEN_2290; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2310 = 8'h48 == opcode | 8'h8 == opcode | _GEN_2291; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2311 = 8'h48 == opcode | 8'h8 == opcode ? 1'h0 : _GEN_2292; // @[CPU6502Core.scala 209:20 379:16]
  wire [15:0] _GEN_2312 = 8'h48 == opcode | 8'h8 == opcode ? 16'h0 : _GEN_2293; // @[CPU6502Core.scala 209:20 379:16]
  wire  _GEN_2313 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_34_done : _GEN_2294; // @[CPU6502Core.scala 209:20 374:16]
  wire [2:0] _GEN_2314 = 8'h91 == opcode | 8'hb1 == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2295; // @[CPU6502Core.scala 209:20 374:16]
  wire [7:0] _GEN_2315 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_34_a : _GEN_2296; // @[CPU6502Core.scala 209:20 374:16]
  wire [7:0] _GEN_2318 = 8'h91 == opcode | 8'hb1 == opcode ? regs_sp : _GEN_2299; // @[CPU6502Core.scala 209:20 374:16]
  wire [15:0] _GEN_2319 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_5_pc : _GEN_2300; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2320 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagC : _GEN_2301; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2321 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_34_flagZ : _GEN_2302; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2322 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagI : _GEN_2303; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2323 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagD : _GEN_2304; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2325 = 8'h91 == opcode | 8'hb1 == opcode ? regs_flagV : _GEN_2306; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2326 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_newRegs_34_flagN : _GEN_2307; // @[CPU6502Core.scala 209:20 374:16]
  wire [15:0] _GEN_2327 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_35_memAddr : _GEN_2308; // @[CPU6502Core.scala 209:20 374:16]
  wire [7:0] _GEN_2328 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_35_memData : _GEN_2309; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2329 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_35_memWrite : _GEN_2310; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2330 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_35_memRead : _GEN_2311; // @[CPU6502Core.scala 209:20 374:16]
  wire [15:0] _GEN_2331 = 8'h91 == opcode | 8'hb1 == opcode ? execResult_result_result_26_operand : _GEN_2312; // @[CPU6502Core.scala 209:20 374:16]
  wire  _GEN_2332 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_34_done : _GEN_2313; // @[CPU6502Core.scala 209:20 369:16]
  wire [2:0] _GEN_2333 = 8'ha1 == opcode | 8'h81 == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2314; // @[CPU6502Core.scala 209:20 369:16]
  wire [7:0] _GEN_2334 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_33_a : _GEN_2315; // @[CPU6502Core.scala 209:20 369:16]
  wire [7:0] _GEN_2337 = 8'ha1 == opcode | 8'h81 == opcode ? regs_sp : _GEN_2318; // @[CPU6502Core.scala 209:20 369:16]
  wire [15:0] _GEN_2338 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_5_pc : _GEN_2319; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2339 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagC : _GEN_2320; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2340 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_33_flagZ : _GEN_2321; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2341 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagI : _GEN_2322; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2342 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagD : _GEN_2323; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2344 = 8'ha1 == opcode | 8'h81 == opcode ? regs_flagV : _GEN_2325; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2345 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_newRegs_33_flagN : _GEN_2326; // @[CPU6502Core.scala 209:20 369:16]
  wire [15:0] _GEN_2346 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_15_memAddr : _GEN_2327; // @[CPU6502Core.scala 209:20 369:16]
  wire [7:0] _GEN_2347 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_34_memData : _GEN_2328; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2348 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_34_memWrite : _GEN_2329; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2349 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_34_memRead : _GEN_2330; // @[CPU6502Core.scala 209:20 369:16]
  wire [15:0] _GEN_2350 = 8'ha1 == opcode | 8'h81 == opcode ? execResult_result_result_15_operand : _GEN_2331; // @[CPU6502Core.scala 209:20 369:16]
  wire  _GEN_2351 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_6_done : _GEN_2332; // @[CPU6502Core.scala 209:20 364:16]
  wire [2:0] _GEN_2352 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_6_nextCycle : _GEN_2333; // @[CPU6502Core.scala 209:20 364:16]
  wire [7:0] _GEN_2353 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_32_a : _GEN_2334; // @[CPU6502Core.scala 209:20 364:16]
  wire [7:0] _GEN_2356 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? regs_sp : _GEN_2337; // @[CPU6502Core.scala 209:20 364:16]
  wire [15:0] _GEN_2357 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_newRegs_6_pc : _GEN_2338; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2358 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagC : _GEN_2339; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2359 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_32_flagZ : _GEN_2340; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2360 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagI : _GEN_2341; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2361 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagD : _GEN_2342; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2363 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? regs_flagV : _GEN_2344; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2364 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_newRegs_32_flagN : _GEN_2345; // @[CPU6502Core.scala 209:20 364:16]
  wire [15:0] _GEN_2365 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_13_memAddr : _GEN_2346; // @[CPU6502Core.scala 209:20 364:16]
  wire [7:0] _GEN_2366 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? 8'h0 : _GEN_2347; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2367 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? 1'h0 : _GEN_2348; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2368 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99 ==
    opcode ? execResult_result_result_7_memRead : _GEN_2349; // @[CPU6502Core.scala 209:20 364:16]
  wire [15:0] _GEN_2369 = 8'hbd == opcode | 8'hb9 == opcode | 8'hbc == opcode | 8'hbe == opcode | 8'h9d == opcode | 8'h99
     == opcode ? execResult_result_result_33_operand : _GEN_2350; // @[CPU6502Core.scala 209:20 364:16]
  wire  _GEN_2370 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_6_done : _GEN_2351; // @[CPU6502Core.scala 209:20 359:16]
  wire [2:0] _GEN_2371 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_6_nextCycle : _GEN_2352; // @[CPU6502Core.scala 209:20 359:16]
  wire [7:0] _GEN_2372 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_31_a : _GEN_2353; // @[CPU6502Core.scala 209:20 359:16]
  wire [7:0] _GEN_2373 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_31_x : regs_x; // @[CPU6502Core.scala 209:20 359:16]
  wire [7:0] _GEN_2374 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_31_y : regs_y; // @[CPU6502Core.scala 209:20 359:16]
  wire [7:0] _GEN_2375 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? regs_sp : _GEN_2356; // @[CPU6502Core.scala 209:20 359:16]
  wire [15:0] _GEN_2376 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_newRegs_6_pc : _GEN_2357; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2377 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagC : _GEN_2358; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2378 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_31_flagZ : _GEN_2359; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2379 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagI : _GEN_2360; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2380 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagD : _GEN_2361; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2382 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? regs_flagV : _GEN_2363; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2383 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_newRegs_31_flagN : _GEN_2364; // @[CPU6502Core.scala 209:20 359:16]
  wire [15:0] _GEN_2384 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_13_memAddr : _GEN_2365; // @[CPU6502Core.scala 209:20 359:16]
  wire [7:0] _GEN_2385 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_32_memData : _GEN_2366; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2386 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_32_memWrite : _GEN_2367; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2387 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac ==
    opcode ? execResult_result_result_32_memRead : _GEN_2368; // @[CPU6502Core.scala 209:20 359:16]
  wire [15:0] _GEN_2388 = 8'had == opcode | 8'h8d == opcode | 8'h8e == opcode | 8'h8c == opcode | 8'hae == opcode | 8'hac
     == opcode ? execResult_result_result_7_operand : _GEN_2369; // @[CPU6502Core.scala 209:20 359:16]
  wire  _GEN_2389 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_10_done : _GEN_2370; // @[CPU6502Core.scala 209:20 354:16]
  wire [2:0] _GEN_2390 = 8'hb6 == opcode | 8'h96 == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2371; // @[CPU6502Core.scala 209:20 354:16]
  wire [7:0] _GEN_2391 = 8'hb6 == opcode | 8'h96 == opcode ? regs_a : _GEN_2372; // @[CPU6502Core.scala 209:20 354:16]
  wire [7:0] _GEN_2392 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_30_x : _GEN_2373; // @[CPU6502Core.scala 209:20 354:16]
  wire [7:0] _GEN_2393 = 8'hb6 == opcode | 8'h96 == opcode ? regs_y : _GEN_2374; // @[CPU6502Core.scala 209:20 354:16]
  wire [7:0] _GEN_2394 = 8'hb6 == opcode | 8'h96 == opcode ? regs_sp : _GEN_2375; // @[CPU6502Core.scala 209:20 354:16]
  wire [15:0] _GEN_2395 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_5_pc : _GEN_2376; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2396 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagC : _GEN_2377; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2397 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_30_flagZ : _GEN_2378; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2398 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagI : _GEN_2379; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2399 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagD : _GEN_2380; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2401 = 8'hb6 == opcode | 8'h96 == opcode ? regs_flagV : _GEN_2382; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2402 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_newRegs_30_flagN : _GEN_2383; // @[CPU6502Core.scala 209:20 354:16]
  wire [15:0] _GEN_2403 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_10_memAddr : _GEN_2384; // @[CPU6502Core.scala 209:20 354:16]
  wire [7:0] _GEN_2404 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_31_memData : _GEN_2385; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2405 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_31_memWrite : _GEN_2386; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2406 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_31_memRead : _GEN_2387; // @[CPU6502Core.scala 209:20 354:16]
  wire [15:0] _GEN_2407 = 8'hb6 == opcode | 8'h96 == opcode ? execResult_result_result_31_operand : _GEN_2388; // @[CPU6502Core.scala 209:20 354:16]
  wire  _GEN_2408 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_10_done : _GEN_2389; // @[CPU6502Core.scala 209:20 349:16]
  wire [2:0] _GEN_2409 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_10_nextCycle : _GEN_2390; // @[CPU6502Core.scala 209:20 349:16]
  wire [7:0] _GEN_2410 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_29_a : _GEN_2391; // @[CPU6502Core.scala 209:20 349:16]
  wire [7:0] _GEN_2411 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_x : _GEN_2392; // @[CPU6502Core.scala 209:20 349:16]
  wire [7:0] _GEN_2412 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_29_y : _GEN_2393; // @[CPU6502Core.scala 209:20 349:16]
  wire [7:0] _GEN_2413 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_sp : _GEN_2394; // @[CPU6502Core.scala 209:20 349:16]
  wire [15:0] _GEN_2414 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_2395; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2415 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagC : _GEN_2396; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2416 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_29_flagZ : _GEN_2397; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2417 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagI : _GEN_2398; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2418 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagD : _GEN_2399; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2420 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ? regs_flagV : _GEN_2401; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2421 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_newRegs_29_flagN : _GEN_2402; // @[CPU6502Core.scala 209:20 349:16]
  wire [15:0] _GEN_2422 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_10_memAddr : _GEN_2403; // @[CPU6502Core.scala 209:20 349:16]
  wire [7:0] _GEN_2423 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_30_memData : _GEN_2404; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2424 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_30_memWrite : _GEN_2405; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2425 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_30_memRead : _GEN_2406; // @[CPU6502Core.scala 209:20 349:16]
  wire [15:0] _GEN_2426 = 8'hb5 == opcode | 8'h95 == opcode | 8'hb4 == opcode | 8'h94 == opcode ?
    execResult_result_result_12_operand : _GEN_2407; // @[CPU6502Core.scala 209:20 349:16]
  wire  _GEN_2427 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_10_done : _GEN_2408; // @[CPU6502Core.scala 209:20 344:16]
  wire [2:0] _GEN_2428 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_10_nextCycle : _GEN_2409; // @[CPU6502Core.scala 209:20 344:16]
  wire [7:0] _GEN_2429 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_28_a : _GEN_2410; // @[CPU6502Core.scala 209:20 344:16]
  wire [7:0] _GEN_2430 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_28_x : _GEN_2411; // @[CPU6502Core.scala 209:20 344:16]
  wire [7:0] _GEN_2431 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_28_y : _GEN_2412; // @[CPU6502Core.scala 209:20 344:16]
  wire [7:0] _GEN_2432 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? regs_sp : _GEN_2413; // @[CPU6502Core.scala 209:20 344:16]
  wire [15:0] _GEN_2433 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_newRegs_5_pc : _GEN_2414; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2434 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagC : _GEN_2415; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2435 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_28_flagZ : _GEN_2416; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2436 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagI : _GEN_2417; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2437 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagD : _GEN_2418; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2439 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? regs_flagV : _GEN_2420; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2440 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_newRegs_28_flagN : _GEN_2421; // @[CPU6502Core.scala 209:20 344:16]
  wire [15:0] _GEN_2441 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_10_memAddr : _GEN_2422; // @[CPU6502Core.scala 209:20 344:16]
  wire [7:0] _GEN_2442 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_29_memData : _GEN_2423; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2443 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_29_memWrite : _GEN_2424; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2444 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4 ==
    opcode ? execResult_result_result_29_memRead : _GEN_2425; // @[CPU6502Core.scala 209:20 344:16]
  wire [15:0] _GEN_2445 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode | 8'ha6 == opcode | 8'ha4
     == opcode ? execResult_result_result_6_operand : _GEN_2426; // @[CPU6502Core.scala 209:20 344:16]
  wire  _GEN_2446 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_2427; // @[CPU6502Core.scala 209:20 339:16]
  wire [2:0] _GEN_2447 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 3'h0 : _GEN_2428; // @[CPU6502Core.scala 209:20 339:16]
  wire [7:0] _GEN_2448 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_27_a :
    _GEN_2429; // @[CPU6502Core.scala 209:20 339:16]
  wire [7:0] _GEN_2449 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_27_x :
    _GEN_2430; // @[CPU6502Core.scala 209:20 339:16]
  wire [7:0] _GEN_2450 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_27_y :
    _GEN_2431; // @[CPU6502Core.scala 209:20 339:16]
  wire [7:0] _GEN_2451 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_sp : _GEN_2432; // @[CPU6502Core.scala 209:20 339:16]
  wire [15:0] _GEN_2452 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? _regs_pc_T_1 : _GEN_2433; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2453 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagC : _GEN_2434; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2454 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_27_flagZ : _GEN_2435
    ; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2455 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagI : _GEN_2436; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2456 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagD : _GEN_2437; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2458 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagV : _GEN_2439; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2459 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? io_memDataIn[7] : _GEN_2440; // @[CPU6502Core.scala 209:20 339:16]
  wire [15:0] _GEN_2460 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_pc : _GEN_2441; // @[CPU6502Core.scala 209:20 339:16]
  wire [7:0] _GEN_2461 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 8'h0 : _GEN_2442; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2462 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 1'h0 : _GEN_2443; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2463 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_2444; // @[CPU6502Core.scala 209:20 339:16]
  wire [15:0] _GEN_2464 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 16'h0 : _GEN_2445; // @[CPU6502Core.scala 209:20 339:16]
  wire  _GEN_2465 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_2446; // @[CPU6502Core.scala 209:20 334:16]
  wire [2:0] _GEN_2466 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 3'h0 : _GEN_2447; // @[CPU6502Core.scala 209:20 334:16]
  wire [7:0] _GEN_2467 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_a : _GEN_2448; // @[CPU6502Core.scala 209:20 334:16]
  wire [7:0] _GEN_2468 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_x : _GEN_2449; // @[CPU6502Core.scala 209:20 334:16]
  wire [7:0] _GEN_2469 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_y : _GEN_2450; // @[CPU6502Core.scala 209:20 334:16]
  wire [7:0] _GEN_2470 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_sp : _GEN_2451; // @[CPU6502Core.scala 209:20 334:16]
  wire [15:0] _GEN_2471 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? execResult_result_newRegs_26_pc : _GEN_2452; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2472 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagC : _GEN_2453; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2473 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagZ : _GEN_2454; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2474 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagI : _GEN_2455; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2475 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagD : _GEN_2456; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2477 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagV : _GEN_2458; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2478 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagN : _GEN_2459; // @[CPU6502Core.scala 209:20 334:16]
  wire [15:0] _GEN_2479 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_pc : _GEN_2460; // @[CPU6502Core.scala 209:20 334:16]
  wire [7:0] _GEN_2480 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 8'h0 : _GEN_2461; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2481 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? 1'h0 : _GEN_2462; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2482 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_2463; // @[CPU6502Core.scala 209:20 334:16]
  wire [15:0] _GEN_2483 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 16'h0 : _GEN_2464; // @[CPU6502Core.scala 209:20 334:16]
  wire  _GEN_2484 = 8'hd2 == opcode ? execResult_result_result_7_done : _GEN_2465; // @[CPU6502Core.scala 209:20 329:16]
  wire [2:0] _GEN_2485 = 8'hd2 == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2466; // @[CPU6502Core.scala 209:20 329:16]
  wire [7:0] _GEN_2486 = 8'hd2 == opcode ? regs_a : _GEN_2467; // @[CPU6502Core.scala 209:20 329:16]
  wire [7:0] _GEN_2487 = 8'hd2 == opcode ? regs_x : _GEN_2468; // @[CPU6502Core.scala 209:20 329:16]
  wire [7:0] _GEN_2488 = 8'hd2 == opcode ? regs_y : _GEN_2469; // @[CPU6502Core.scala 209:20 329:16]
  wire [7:0] _GEN_2489 = 8'hd2 == opcode ? regs_sp : _GEN_2470; // @[CPU6502Core.scala 209:20 329:16]
  wire [15:0] _GEN_2490 = 8'hd2 == opcode ? execResult_result_newRegs_5_pc : _GEN_2471; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2491 = 8'hd2 == opcode ? execResult_result_newRegs_23_flagC : _GEN_2472; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2492 = 8'hd2 == opcode ? execResult_result_newRegs_23_flagZ : _GEN_2473; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2493 = 8'hd2 == opcode ? regs_flagI : _GEN_2474; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2494 = 8'hd2 == opcode ? regs_flagD : _GEN_2475; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2496 = 8'hd2 == opcode ? regs_flagV : _GEN_2477; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2497 = 8'hd2 == opcode ? execResult_result_newRegs_23_flagN : _GEN_2478; // @[CPU6502Core.scala 209:20 329:16]
  wire [15:0] _GEN_2498 = 8'hd2 == opcode ? execResult_result_result_15_memAddr : _GEN_2479; // @[CPU6502Core.scala 209:20 329:16]
  wire [7:0] _GEN_2499 = 8'hd2 == opcode ? 8'h0 : _GEN_2480; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2500 = 8'hd2 == opcode ? 1'h0 : _GEN_2481; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2501 = 8'hd2 == opcode ? execResult_result_result_15_memRead : _GEN_2482; // @[CPU6502Core.scala 209:20 329:16]
  wire [15:0] _GEN_2502 = 8'hd2 == opcode ? execResult_result_result_26_operand : _GEN_2483; // @[CPU6502Core.scala 209:20 329:16]
  wire  _GEN_2503 = 8'hd1 == opcode ? execResult_result_result_7_done : _GEN_2484; // @[CPU6502Core.scala 209:20 324:16]
  wire [2:0] _GEN_2504 = 8'hd1 == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2485; // @[CPU6502Core.scala 209:20 324:16]
  wire [7:0] _GEN_2505 = 8'hd1 == opcode ? regs_a : _GEN_2486; // @[CPU6502Core.scala 209:20 324:16]
  wire [7:0] _GEN_2506 = 8'hd1 == opcode ? regs_x : _GEN_2487; // @[CPU6502Core.scala 209:20 324:16]
  wire [7:0] _GEN_2507 = 8'hd1 == opcode ? regs_y : _GEN_2488; // @[CPU6502Core.scala 209:20 324:16]
  wire [7:0] _GEN_2508 = 8'hd1 == opcode ? regs_sp : _GEN_2489; // @[CPU6502Core.scala 209:20 324:16]
  wire [15:0] _GEN_2509 = 8'hd1 == opcode ? execResult_result_newRegs_5_pc : _GEN_2490; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2510 = 8'hd1 == opcode ? execResult_result_newRegs_23_flagC : _GEN_2491; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2511 = 8'hd1 == opcode ? execResult_result_newRegs_23_flagZ : _GEN_2492; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2512 = 8'hd1 == opcode ? regs_flagI : _GEN_2493; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2513 = 8'hd1 == opcode ? regs_flagD : _GEN_2494; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2515 = 8'hd1 == opcode ? regs_flagV : _GEN_2496; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2516 = 8'hd1 == opcode ? execResult_result_newRegs_23_flagN : _GEN_2497; // @[CPU6502Core.scala 209:20 324:16]
  wire [15:0] _GEN_2517 = 8'hd1 == opcode ? execResult_result_result_15_memAddr : _GEN_2498; // @[CPU6502Core.scala 209:20 324:16]
  wire [7:0] _GEN_2518 = 8'hd1 == opcode ? 8'h0 : _GEN_2499; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2519 = 8'hd1 == opcode ? 1'h0 : _GEN_2500; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2520 = 8'hd1 == opcode ? execResult_result_result_15_memRead : _GEN_2501; // @[CPU6502Core.scala 209:20 324:16]
  wire [15:0] _GEN_2521 = 8'hd1 == opcode ? execResult_result_result_16_operand : _GEN_2502; // @[CPU6502Core.scala 209:20 324:16]
  wire  _GEN_2522 = 8'hc1 == opcode ? execResult_result_result_7_done : _GEN_2503; // @[CPU6502Core.scala 209:20 319:16]
  wire [2:0] _GEN_2523 = 8'hc1 == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2504; // @[CPU6502Core.scala 209:20 319:16]
  wire [7:0] _GEN_2524 = 8'hc1 == opcode ? regs_a : _GEN_2505; // @[CPU6502Core.scala 209:20 319:16]
  wire [7:0] _GEN_2525 = 8'hc1 == opcode ? regs_x : _GEN_2506; // @[CPU6502Core.scala 209:20 319:16]
  wire [7:0] _GEN_2526 = 8'hc1 == opcode ? regs_y : _GEN_2507; // @[CPU6502Core.scala 209:20 319:16]
  wire [7:0] _GEN_2527 = 8'hc1 == opcode ? regs_sp : _GEN_2508; // @[CPU6502Core.scala 209:20 319:16]
  wire [15:0] _GEN_2528 = 8'hc1 == opcode ? execResult_result_newRegs_5_pc : _GEN_2509; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2529 = 8'hc1 == opcode ? execResult_result_newRegs_23_flagC : _GEN_2510; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2530 = 8'hc1 == opcode ? execResult_result_newRegs_23_flagZ : _GEN_2511; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2531 = 8'hc1 == opcode ? regs_flagI : _GEN_2512; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2532 = 8'hc1 == opcode ? regs_flagD : _GEN_2513; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2534 = 8'hc1 == opcode ? regs_flagV : _GEN_2515; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2535 = 8'hc1 == opcode ? execResult_result_newRegs_23_flagN : _GEN_2516; // @[CPU6502Core.scala 209:20 319:16]
  wire [15:0] _GEN_2536 = 8'hc1 == opcode ? execResult_result_result_15_memAddr : _GEN_2517; // @[CPU6502Core.scala 209:20 319:16]
  wire [7:0] _GEN_2537 = 8'hc1 == opcode ? 8'h0 : _GEN_2518; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2538 = 8'hc1 == opcode ? 1'h0 : _GEN_2519; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2539 = 8'hc1 == opcode ? execResult_result_result_15_memRead : _GEN_2520; // @[CPU6502Core.scala 209:20 319:16]
  wire [15:0] _GEN_2540 = 8'hc1 == opcode ? execResult_result_result_15_operand : _GEN_2521; // @[CPU6502Core.scala 209:20 319:16]
  wire  _GEN_2541 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_6_done : _GEN_2522; // @[CPU6502Core.scala 209:20 314:16]
  wire [2:0] _GEN_2542 = 8'hdd == opcode | 8'hd9 == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2523; // @[CPU6502Core.scala 209:20 314:16]
  wire [7:0] _GEN_2543 = 8'hdd == opcode | 8'hd9 == opcode ? regs_a : _GEN_2524; // @[CPU6502Core.scala 209:20 314:16]
  wire [7:0] _GEN_2544 = 8'hdd == opcode | 8'hd9 == opcode ? regs_x : _GEN_2525; // @[CPU6502Core.scala 209:20 314:16]
  wire [7:0] _GEN_2545 = 8'hdd == opcode | 8'hd9 == opcode ? regs_y : _GEN_2526; // @[CPU6502Core.scala 209:20 314:16]
  wire [7:0] _GEN_2546 = 8'hdd == opcode | 8'hd9 == opcode ? regs_sp : _GEN_2527; // @[CPU6502Core.scala 209:20 314:16]
  wire [15:0] _GEN_2547 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_6_pc : _GEN_2528; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2548 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_21_flagC : _GEN_2529; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2549 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_21_flagZ : _GEN_2530; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2550 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagI : _GEN_2531; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2551 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagD : _GEN_2532; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2553 = 8'hdd == opcode | 8'hd9 == opcode ? regs_flagV : _GEN_2534; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2554 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_newRegs_21_flagN : _GEN_2535; // @[CPU6502Core.scala 209:20 314:16]
  wire [15:0] _GEN_2555 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_13_memAddr : _GEN_2536; // @[CPU6502Core.scala 209:20 314:16]
  wire [7:0] _GEN_2556 = 8'hdd == opcode | 8'hd9 == opcode ? 8'h0 : _GEN_2537; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2557 = 8'hdd == opcode | 8'hd9 == opcode ? 1'h0 : _GEN_2538; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2558 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_7_memRead : _GEN_2539; // @[CPU6502Core.scala 209:20 314:16]
  wire [15:0] _GEN_2559 = 8'hdd == opcode | 8'hd9 == opcode ? execResult_result_result_23_operand : _GEN_2540; // @[CPU6502Core.scala 209:20 314:16]
  wire  _GEN_2560 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_6_done : _GEN_2541; // @[CPU6502Core.scala 209:20 309:16]
  wire [2:0] _GEN_2561 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? _execResult_result_result_nextCycle_T_1
     : _GEN_2542; // @[CPU6502Core.scala 209:20 309:16]
  wire [7:0] _GEN_2562 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_a : _GEN_2543; // @[CPU6502Core.scala 209:20 309:16]
  wire [7:0] _GEN_2563 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_x : _GEN_2544; // @[CPU6502Core.scala 209:20 309:16]
  wire [7:0] _GEN_2564 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_y : _GEN_2545; // @[CPU6502Core.scala 209:20 309:16]
  wire [7:0] _GEN_2565 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_sp : _GEN_2546; // @[CPU6502Core.scala 209:20 309:16]
  wire [15:0] _GEN_2566 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_6_pc :
    _GEN_2547; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2567 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_21_flagC : _GEN_2548
    ; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2568 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_21_flagZ : _GEN_2549
    ; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2569 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagI : _GEN_2550; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2570 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagD : _GEN_2551; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2572 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? regs_flagV : _GEN_2553; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2573 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_newRegs_21_flagN : _GEN_2554
    ; // @[CPU6502Core.scala 209:20 309:16]
  wire [15:0] _GEN_2574 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_13_memAddr :
    _GEN_2555; // @[CPU6502Core.scala 209:20 309:16]
  wire [7:0] _GEN_2575 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 8'h0 : _GEN_2556; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2576 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? 1'h0 : _GEN_2557; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2577 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_7_memRead : _GEN_2558
    ; // @[CPU6502Core.scala 209:20 309:16]
  wire [15:0] _GEN_2578 = 8'hcd == opcode | 8'hec == opcode | 8'hcc == opcode ? execResult_result_result_7_operand :
    _GEN_2559; // @[CPU6502Core.scala 209:20 309:16]
  wire  _GEN_2579 = 8'hd5 == opcode ? execResult_result_result_10_done : _GEN_2560; // @[CPU6502Core.scala 209:20 304:16]
  wire [2:0] _GEN_2580 = 8'hd5 == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2561; // @[CPU6502Core.scala 209:20 304:16]
  wire [7:0] _GEN_2581 = 8'hd5 == opcode ? regs_a : _GEN_2562; // @[CPU6502Core.scala 209:20 304:16]
  wire [7:0] _GEN_2582 = 8'hd5 == opcode ? regs_x : _GEN_2563; // @[CPU6502Core.scala 209:20 304:16]
  wire [7:0] _GEN_2583 = 8'hd5 == opcode ? regs_y : _GEN_2564; // @[CPU6502Core.scala 209:20 304:16]
  wire [7:0] _GEN_2584 = 8'hd5 == opcode ? regs_sp : _GEN_2565; // @[CPU6502Core.scala 209:20 304:16]
  wire [15:0] _GEN_2585 = 8'hd5 == opcode ? execResult_result_newRegs_5_pc : _GEN_2566; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2586 = 8'hd5 == opcode ? execResult_result_newRegs_19_flagC : _GEN_2567; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2587 = 8'hd5 == opcode ? execResult_result_newRegs_19_flagZ : _GEN_2568; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2588 = 8'hd5 == opcode ? regs_flagI : _GEN_2569; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2589 = 8'hd5 == opcode ? regs_flagD : _GEN_2570; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2591 = 8'hd5 == opcode ? regs_flagV : _GEN_2572; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2592 = 8'hd5 == opcode ? execResult_result_newRegs_19_flagN : _GEN_2573; // @[CPU6502Core.scala 209:20 304:16]
  wire [15:0] _GEN_2593 = 8'hd5 == opcode ? execResult_result_result_10_memAddr : _GEN_2574; // @[CPU6502Core.scala 209:20 304:16]
  wire [7:0] _GEN_2594 = 8'hd5 == opcode ? 8'h0 : _GEN_2575; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2595 = 8'hd5 == opcode ? 1'h0 : _GEN_2576; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2596 = 8'hd5 == opcode ? execResult_result_result_6_memRead : _GEN_2577; // @[CPU6502Core.scala 209:20 304:16]
  wire [15:0] _GEN_2597 = 8'hd5 == opcode ? execResult_result_result_12_operand : _GEN_2578; // @[CPU6502Core.scala 209:20 304:16]
  wire  _GEN_2598 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_10_done : _GEN_2579; // @[CPU6502Core.scala 209:20 299:16]
  wire [2:0] _GEN_2599 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? _execResult_result_result_nextCycle_T_1
     : _GEN_2580; // @[CPU6502Core.scala 209:20 299:16]
  wire [7:0] _GEN_2600 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_a : _GEN_2581; // @[CPU6502Core.scala 209:20 299:16]
  wire [7:0] _GEN_2601 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_x : _GEN_2582; // @[CPU6502Core.scala 209:20 299:16]
  wire [7:0] _GEN_2602 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_y : _GEN_2583; // @[CPU6502Core.scala 209:20 299:16]
  wire [7:0] _GEN_2603 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_sp : _GEN_2584; // @[CPU6502Core.scala 209:20 299:16]
  wire [15:0] _GEN_2604 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_2585; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2605 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_19_flagC : _GEN_2586
    ; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2606 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_19_flagZ : _GEN_2587
    ; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2607 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagI : _GEN_2588; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2608 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagD : _GEN_2589; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2610 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? regs_flagV : _GEN_2591; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2611 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_newRegs_19_flagN : _GEN_2592
    ; // @[CPU6502Core.scala 209:20 299:16]
  wire [15:0] _GEN_2612 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_10_memAddr :
    _GEN_2593; // @[CPU6502Core.scala 209:20 299:16]
  wire [7:0] _GEN_2613 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 8'h0 : _GEN_2594; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2614 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? 1'h0 : _GEN_2595; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2615 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_memRead : _GEN_2596
    ; // @[CPU6502Core.scala 209:20 299:16]
  wire [15:0] _GEN_2616 = 8'hc5 == opcode | 8'he4 == opcode | 8'hc4 == opcode ? execResult_result_result_6_operand :
    _GEN_2597; // @[CPU6502Core.scala 209:20 299:16]
  wire  _GEN_2617 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_2598; // @[CPU6502Core.scala 209:20 294:16]
  wire [2:0] _GEN_2618 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 3'h0 : _GEN_2599; // @[CPU6502Core.scala 209:20 294:16]
  wire [7:0] _GEN_2619 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_a : _GEN_2600; // @[CPU6502Core.scala 209:20 294:16]
  wire [7:0] _GEN_2620 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_x : _GEN_2601; // @[CPU6502Core.scala 209:20 294:16]
  wire [7:0] _GEN_2621 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_y : _GEN_2602; // @[CPU6502Core.scala 209:20 294:16]
  wire [7:0] _GEN_2622 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_sp : _GEN_2603; // @[CPU6502Core.scala 209:20 294:16]
  wire [15:0] _GEN_2623 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? _regs_pc_T_1 : _GEN_2604; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2624 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_18_flagC : _GEN_2605
    ; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2625 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_18_flagZ : _GEN_2606
    ; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2626 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagI : _GEN_2607; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2627 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagD : _GEN_2608; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2629 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagV : _GEN_2610; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2630 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_18_flagN : _GEN_2611
    ; // @[CPU6502Core.scala 209:20 294:16]
  wire [15:0] _GEN_2631 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_pc : _GEN_2612; // @[CPU6502Core.scala 209:20 294:16]
  wire [7:0] _GEN_2632 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 8'h0 : _GEN_2613; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2633 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 1'h0 : _GEN_2614; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2634 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_2615; // @[CPU6502Core.scala 209:20 294:16]
  wire [15:0] _GEN_2635 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 16'h0 : _GEN_2616; // @[CPU6502Core.scala 209:20 294:16]
  wire  _GEN_2636 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_done : _GEN_2617; // @[CPU6502Core.scala 209:20 289:16]
  wire [2:0] _GEN_2637 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_nextCycle : _GEN_2618; // @[CPU6502Core.scala 209:20 289:16]
  wire [7:0] _GEN_2638 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_a : _GEN_2619; // @[CPU6502Core.scala 209:20 289:16]
  wire [7:0] _GEN_2639 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_x : _GEN_2620; // @[CPU6502Core.scala 209:20 289:16]
  wire [7:0] _GEN_2640 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_y : _GEN_2621; // @[CPU6502Core.scala 209:20 289:16]
  wire [7:0] _GEN_2641 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_sp : _GEN_2622; // @[CPU6502Core.scala 209:20 289:16]
  wire [15:0] _GEN_2642 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_2623; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2643 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_17_flagC : _GEN_2624; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2644 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_17_flagZ : _GEN_2625; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2645 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagI : _GEN_2626; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2646 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagD : _GEN_2627; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2648 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagV : _GEN_2629; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2649 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_17_flagN : _GEN_2630; // @[CPU6502Core.scala 209:20 289:16]
  wire [15:0] _GEN_2650 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memAddr : _GEN_2631; // @[CPU6502Core.scala 209:20 289:16]
  wire [7:0] _GEN_2651 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_18_memData : _GEN_2632; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2652 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_done : _GEN_2633; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2653 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memRead : _GEN_2634; // @[CPU6502Core.scala 209:20 289:16]
  wire [15:0] _GEN_2654 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_operand : _GEN_2635; // @[CPU6502Core.scala 209:20 289:16]
  wire  _GEN_2655 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode | _GEN_2636; // @[CPU6502Core.scala 209:20 284:16]
  wire [2:0] _GEN_2656 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 3'h0 : _GEN_2637; // @[CPU6502Core.scala 209:20 284:16]
  wire [7:0] _GEN_2657 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? execResult_result_res_15
     : _GEN_2638; // @[CPU6502Core.scala 209:20 284:16]
  wire [7:0] _GEN_2658 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_x : _GEN_2639; // @[CPU6502Core.scala 209:20 284:16]
  wire [7:0] _GEN_2659 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_y : _GEN_2640; // @[CPU6502Core.scala 209:20 284:16]
  wire [7:0] _GEN_2660 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_sp : _GEN_2641; // @[CPU6502Core.scala 209:20 284:16]
  wire [15:0] _GEN_2661 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_pc : _GEN_2642; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2662 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_16_flagC : _GEN_2643; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2663 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_16_flagZ : _GEN_2644; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2664 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagI : _GEN_2645; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2665 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagD : _GEN_2646; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2667 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagV : _GEN_2648; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2668 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_16_flagN : _GEN_2649; // @[CPU6502Core.scala 209:20 284:16]
  wire [15:0] _GEN_2669 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_2650; // @[CPU6502Core.scala 209:20 284:16]
  wire [7:0] _GEN_2670 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 8'h0 : _GEN_2651; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2671 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_2652; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2672 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_2653; // @[CPU6502Core.scala 209:20 284:16]
  wire [15:0] _GEN_2673 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_2654; // @[CPU6502Core.scala 209:20 284:16]
  wire  _GEN_2674 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_7_done : _GEN_2655; // @[CPU6502Core.scala 209:20 279:16]
  wire [2:0] _GEN_2675 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? _execResult_result_result_nextCycle_T_1
     : _GEN_2656; // @[CPU6502Core.scala 209:20 279:16]
  wire [7:0] _GEN_2676 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_14_a :
    _GEN_2657; // @[CPU6502Core.scala 209:20 279:16]
  wire [7:0] _GEN_2677 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_x : _GEN_2658; // @[CPU6502Core.scala 209:20 279:16]
  wire [7:0] _GEN_2678 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_y : _GEN_2659; // @[CPU6502Core.scala 209:20 279:16]
  wire [7:0] _GEN_2679 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_sp : _GEN_2660; // @[CPU6502Core.scala 209:20 279:16]
  wire [15:0] _GEN_2680 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_2661; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2681 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagC : _GEN_2662; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2682 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_14_flagZ : _GEN_2663
    ; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2683 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagI : _GEN_2664; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2684 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagD : _GEN_2665; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2686 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? regs_flagV : _GEN_2667; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2687 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_newRegs_14_flagN : _GEN_2668
    ; // @[CPU6502Core.scala 209:20 279:16]
  wire [15:0] _GEN_2688 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_15_memAddr :
    _GEN_2669; // @[CPU6502Core.scala 209:20 279:16]
  wire [7:0] _GEN_2689 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 8'h0 : _GEN_2670; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2690 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? 1'h0 : _GEN_2671; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2691 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_15_memRead :
    _GEN_2672; // @[CPU6502Core.scala 209:20 279:16]
  wire [15:0] _GEN_2692 = 8'h31 == opcode | 8'h11 == opcode | 8'h51 == opcode ? execResult_result_result_16_operand :
    _GEN_2673; // @[CPU6502Core.scala 209:20 279:16]
  wire  _GEN_2693 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_7_done : _GEN_2674; // @[CPU6502Core.scala 209:20 274:16]
  wire [2:0] _GEN_2694 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? _execResult_result_result_nextCycle_T_1 :
    _GEN_2675; // @[CPU6502Core.scala 209:20 274:16]
  wire [7:0] _GEN_2695 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_14_a : _GEN_2676
    ; // @[CPU6502Core.scala 209:20 274:16]
  wire [7:0] _GEN_2696 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_x : _GEN_2677; // @[CPU6502Core.scala 209:20 274:16]
  wire [7:0] _GEN_2697 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_y : _GEN_2678; // @[CPU6502Core.scala 209:20 274:16]
  wire [7:0] _GEN_2698 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_sp : _GEN_2679; // @[CPU6502Core.scala 209:20 274:16]
  wire [15:0] _GEN_2699 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_2680; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2700 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagC : _GEN_2681; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2701 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_14_flagZ : _GEN_2682; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2702 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagI : _GEN_2683; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2703 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagD : _GEN_2684; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2705 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? regs_flagV : _GEN_2686; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2706 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_newRegs_14_flagN : _GEN_2687; // @[CPU6502Core.scala 209:20 274:16]
  wire [15:0] _GEN_2707 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_15_memAddr :
    _GEN_2688; // @[CPU6502Core.scala 209:20 274:16]
  wire [7:0] _GEN_2708 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 8'h0 : _GEN_2689; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2709 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? 1'h0 : _GEN_2690; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2710 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_15_memRead : _GEN_2691
    ; // @[CPU6502Core.scala 209:20 274:16]
  wire [15:0] _GEN_2711 = 8'h21 == opcode | 8'h1 == opcode | 8'h41 == opcode ? execResult_result_result_15_operand :
    _GEN_2692; // @[CPU6502Core.scala 209:20 274:16]
  wire  _GEN_2712 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_6_done : _GEN_2693; // @[CPU6502Core.scala 209:20 269:16]
  wire [2:0] _GEN_2713 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2694; // @[CPU6502Core.scala 209:20 269:16]
  wire [7:0] _GEN_2714 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_12_a : _GEN_2695; // @[CPU6502Core.scala 209:20 269:16]
  wire [7:0] _GEN_2715 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_x : _GEN_2696; // @[CPU6502Core.scala 209:20 269:16]
  wire [7:0] _GEN_2716 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_y : _GEN_2697; // @[CPU6502Core.scala 209:20 269:16]
  wire [7:0] _GEN_2717 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? regs_sp : _GEN_2698; // @[CPU6502Core.scala 209:20 269:16]
  wire [15:0] _GEN_2718 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_newRegs_6_pc : _GEN_2699; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2719 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagC : _GEN_2700; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2720 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_12_flagZ : _GEN_2701; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2721 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagI : _GEN_2702; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2722 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagD : _GEN_2703; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2724 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? regs_flagV : _GEN_2705; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2725 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_newRegs_12_flagN : _GEN_2706; // @[CPU6502Core.scala 209:20 269:16]
  wire [15:0] _GEN_2726 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_13_memAddr : _GEN_2707; // @[CPU6502Core.scala 209:20 269:16]
  wire [7:0] _GEN_2727 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? 8'h0 : _GEN_2708; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2728 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? 1'h0 : _GEN_2709; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2729 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59 ==
    opcode ? execResult_result_result_7_memRead : _GEN_2710; // @[CPU6502Core.scala 209:20 269:16]
  wire [15:0] _GEN_2730 = 8'h3d == opcode | 8'h1d == opcode | 8'h5d == opcode | 8'h39 == opcode | 8'h19 == opcode | 8'h59
     == opcode ? execResult_result_result_14_operand : _GEN_2711; // @[CPU6502Core.scala 209:20 269:16]
  wire  _GEN_2731 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_6_done : _GEN_2712; // @[CPU6502Core.scala 209:20 264:16]
  wire [2:0] _GEN_2732 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    _execResult_result_result_nextCycle_T_1 : _GEN_2713; // @[CPU6502Core.scala 209:20 264:16]
  wire [7:0] _GEN_2733 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_12_a : _GEN_2714; // @[CPU6502Core.scala 209:20 264:16]
  wire [7:0] _GEN_2734 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_x : _GEN_2715; // @[CPU6502Core.scala 209:20 264:16]
  wire [7:0] _GEN_2735 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_y : _GEN_2716; // @[CPU6502Core.scala 209:20 264:16]
  wire [7:0] _GEN_2736 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_sp : _GEN_2717; // @[CPU6502Core.scala 209:20 264:16]
  wire [15:0] _GEN_2737 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_6_pc : _GEN_2718; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2738 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagC : _GEN_2719; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2739 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_12_flagZ : _GEN_2720; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2740 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagI : _GEN_2721; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2741 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagD : _GEN_2722; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2743 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? regs_flagV : _GEN_2724; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2744 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_newRegs_12_flagN : _GEN_2725; // @[CPU6502Core.scala 209:20 264:16]
  wire [15:0] _GEN_2745 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_13_memAddr : _GEN_2726; // @[CPU6502Core.scala 209:20 264:16]
  wire [7:0] _GEN_2746 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 8'h0 : _GEN_2727; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2747 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ? 1'h0 : _GEN_2728; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2748 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_7_memRead : _GEN_2729; // @[CPU6502Core.scala 209:20 264:16]
  wire [15:0] _GEN_2749 = 8'h2c == opcode | 8'h2d == opcode | 8'hd == opcode | 8'h4d == opcode ?
    execResult_result_result_7_operand : _GEN_2730; // @[CPU6502Core.scala 209:20 264:16]
  wire  _GEN_2750 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_10_done : _GEN_2731; // @[CPU6502Core.scala 209:20 259:16]
  wire [2:0] _GEN_2751 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? _execResult_result_result_nextCycle_T_1
     : _GEN_2732; // @[CPU6502Core.scala 209:20 259:16]
  wire [7:0] _GEN_2752 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_10_a :
    _GEN_2733; // @[CPU6502Core.scala 209:20 259:16]
  wire [7:0] _GEN_2753 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_x : _GEN_2734; // @[CPU6502Core.scala 209:20 259:16]
  wire [7:0] _GEN_2754 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_y : _GEN_2735; // @[CPU6502Core.scala 209:20 259:16]
  wire [7:0] _GEN_2755 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_sp : _GEN_2736; // @[CPU6502Core.scala 209:20 259:16]
  wire [15:0] _GEN_2756 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_2737; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2757 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagC : _GEN_2738; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2758 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_10_flagZ : _GEN_2739
    ; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2759 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagI : _GEN_2740; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2760 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagD : _GEN_2741; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2762 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? regs_flagV : _GEN_2743; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2763 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_newRegs_10_flagN : _GEN_2744
    ; // @[CPU6502Core.scala 209:20 259:16]
  wire [15:0] _GEN_2764 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_10_memAddr :
    _GEN_2745; // @[CPU6502Core.scala 209:20 259:16]
  wire [7:0] _GEN_2765 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 8'h0 : _GEN_2746; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2766 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? 1'h0 : _GEN_2747; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2767 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_6_memRead : _GEN_2748
    ; // @[CPU6502Core.scala 209:20 259:16]
  wire [15:0] _GEN_2768 = 8'h35 == opcode | 8'h15 == opcode | 8'h55 == opcode ? execResult_result_result_12_operand :
    _GEN_2749; // @[CPU6502Core.scala 209:20 259:16]
  wire  _GEN_2769 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_10_done : _GEN_2750; // @[CPU6502Core.scala 209:20 254:16]
  wire [2:0] _GEN_2770 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? _execResult_result_result_nextCycle_T_1 :
    _GEN_2751; // @[CPU6502Core.scala 209:20 254:16]
  wire [7:0] _GEN_2771 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_10_a : _GEN_2752
    ; // @[CPU6502Core.scala 209:20 254:16]
  wire [7:0] _GEN_2772 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_x : _GEN_2753; // @[CPU6502Core.scala 209:20 254:16]
  wire [7:0] _GEN_2773 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_y : _GEN_2754; // @[CPU6502Core.scala 209:20 254:16]
  wire [7:0] _GEN_2774 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_sp : _GEN_2755; // @[CPU6502Core.scala 209:20 254:16]
  wire [15:0] _GEN_2775 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_5_pc :
    _GEN_2756; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2776 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagC : _GEN_2757; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2777 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_10_flagZ : _GEN_2758; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2778 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagI : _GEN_2759; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2779 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagD : _GEN_2760; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2781 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? regs_flagV : _GEN_2762; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2782 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_newRegs_10_flagN : _GEN_2763; // @[CPU6502Core.scala 209:20 254:16]
  wire [15:0] _GEN_2783 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_10_memAddr :
    _GEN_2764; // @[CPU6502Core.scala 209:20 254:16]
  wire [7:0] _GEN_2784 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 8'h0 : _GEN_2765; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2785 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? 1'h0 : _GEN_2766; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2786 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_memRead : _GEN_2767; // @[CPU6502Core.scala 209:20 254:16]
  wire [15:0] _GEN_2787 = 8'h25 == opcode | 8'h5 == opcode | 8'h45 == opcode ? execResult_result_result_6_operand :
    _GEN_2768; // @[CPU6502Core.scala 209:20 254:16]
  wire  _GEN_2788 = 8'h24 == opcode ? execResult_result_result_10_done : _GEN_2769; // @[CPU6502Core.scala 209:20 251:16]
  wire [2:0] _GEN_2789 = 8'h24 == opcode ? execResult_result_result_10_nextCycle : _GEN_2770; // @[CPU6502Core.scala 209:20 251:16]
  wire [7:0] _GEN_2790 = 8'h24 == opcode ? regs_a : _GEN_2771; // @[CPU6502Core.scala 209:20 251:16]
  wire [7:0] _GEN_2791 = 8'h24 == opcode ? regs_x : _GEN_2772; // @[CPU6502Core.scala 209:20 251:16]
  wire [7:0] _GEN_2792 = 8'h24 == opcode ? regs_y : _GEN_2773; // @[CPU6502Core.scala 209:20 251:16]
  wire [7:0] _GEN_2793 = 8'h24 == opcode ? regs_sp : _GEN_2774; // @[CPU6502Core.scala 209:20 251:16]
  wire [15:0] _GEN_2794 = 8'h24 == opcode ? execResult_result_newRegs_5_pc : _GEN_2775; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2795 = 8'h24 == opcode ? regs_flagC : _GEN_2776; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2796 = 8'h24 == opcode ? execResult_result_newRegs_9_flagZ : _GEN_2777; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2797 = 8'h24 == opcode ? regs_flagI : _GEN_2778; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2798 = 8'h24 == opcode ? regs_flagD : _GEN_2779; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2800 = 8'h24 == opcode ? execResult_result_newRegs_9_flagV : _GEN_2781; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2801 = 8'h24 == opcode ? execResult_result_newRegs_9_flagN : _GEN_2782; // @[CPU6502Core.scala 209:20 251:16]
  wire [15:0] _GEN_2802 = 8'h24 == opcode ? execResult_result_result_10_memAddr : _GEN_2783; // @[CPU6502Core.scala 209:20 251:16]
  wire [7:0] _GEN_2803 = 8'h24 == opcode ? 8'h0 : _GEN_2784; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2804 = 8'h24 == opcode ? 1'h0 : _GEN_2785; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2805 = 8'h24 == opcode ? execResult_result_result_6_memRead : _GEN_2786; // @[CPU6502Core.scala 209:20 251:16]
  wire [15:0] _GEN_2806 = 8'h24 == opcode ? execResult_result_result_6_operand : _GEN_2787; // @[CPU6502Core.scala 209:20 251:16]
  wire  _GEN_2807 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_2788; // @[CPU6502Core.scala 209:20 246:16]
  wire [2:0] _GEN_2808 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 3'h0 : _GEN_2789; // @[CPU6502Core.scala 209:20 246:16]
  wire [7:0] _GEN_2809 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_res_8 : _GEN_2790; // @[CPU6502Core.scala 209:20 246:16]
  wire [7:0] _GEN_2810 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_x : _GEN_2791; // @[CPU6502Core.scala 209:20 246:16]
  wire [7:0] _GEN_2811 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_y : _GEN_2792; // @[CPU6502Core.scala 209:20 246:16]
  wire [7:0] _GEN_2812 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_sp : _GEN_2793; // @[CPU6502Core.scala 209:20 246:16]
  wire [15:0] _GEN_2813 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? _regs_pc_T_1 : _GEN_2794; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2814 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagC : _GEN_2795; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2815 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_8_flagZ : _GEN_2796; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2816 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagI : _GEN_2797; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2817 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagD : _GEN_2798; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2819 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagV : _GEN_2800; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2820 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_8_flagN : _GEN_2801; // @[CPU6502Core.scala 209:20 246:16]
  wire [15:0] _GEN_2821 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_pc : _GEN_2802; // @[CPU6502Core.scala 209:20 246:16]
  wire [7:0] _GEN_2822 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 8'h0 : _GEN_2803; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2823 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 1'h0 : _GEN_2804; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2824 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_2805; // @[CPU6502Core.scala 209:20 246:16]
  wire [15:0] _GEN_2825 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 16'h0 : _GEN_2806; // @[CPU6502Core.scala 209:20 246:16]
  wire  _GEN_2826 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_7_done : _GEN_2807; // @[CPU6502Core.scala 209:20 241:16]
  wire [2:0] _GEN_2827 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    _execResult_result_result_nextCycle_T_1 : _GEN_2808; // @[CPU6502Core.scala 209:20 241:16]
  wire [7:0] _GEN_2828 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_a : _GEN_2809; // @[CPU6502Core.scala 209:20 241:16]
  wire [7:0] _GEN_2829 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_x : _GEN_2810; // @[CPU6502Core.scala 209:20 241:16]
  wire [7:0] _GEN_2830 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_y : _GEN_2811; // @[CPU6502Core.scala 209:20 241:16]
  wire [7:0] _GEN_2831 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_sp : _GEN_2812; // @[CPU6502Core.scala 209:20 241:16]
  wire [15:0] _GEN_2832 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_6_pc : _GEN_2813; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2833 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_flagC : _GEN_2814; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2834 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_flagZ : _GEN_2815; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2835 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagI : _GEN_2816; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2836 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? regs_flagD : _GEN_2817; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2838 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_flagV : _GEN_2819; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2839 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_newRegs_7_flagN : _GEN_2820; // @[CPU6502Core.scala 209:20 241:16]
  wire [15:0] _GEN_2840 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_8_memAddr : _GEN_2821; // @[CPU6502Core.scala 209:20 241:16]
  wire [7:0] _GEN_2841 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 8'h0 : _GEN_2822; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2842 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ? 1'h0 : _GEN_2823; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2843 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_7_memRead : _GEN_2824; // @[CPU6502Core.scala 209:20 241:16]
  wire [15:0] _GEN_2844 = 8'h79 == opcode | 8'hf9 == opcode | 8'h7d == opcode | 8'hfd == opcode ?
    execResult_result_result_7_operand : _GEN_2825; // @[CPU6502Core.scala 209:20 241:16]
  wire  _GEN_2845 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_7_done : _GEN_2826; // @[CPU6502Core.scala 209:20 236:16]
  wire [2:0] _GEN_2846 = 8'hee == opcode | 8'hce == opcode ? _execResult_result_result_nextCycle_T_1 : _GEN_2827; // @[CPU6502Core.scala 209:20 236:16]
  wire [7:0] _GEN_2847 = 8'hee == opcode | 8'hce == opcode ? regs_a : _GEN_2828; // @[CPU6502Core.scala 209:20 236:16]
  wire [7:0] _GEN_2848 = 8'hee == opcode | 8'hce == opcode ? regs_x : _GEN_2829; // @[CPU6502Core.scala 209:20 236:16]
  wire [7:0] _GEN_2849 = 8'hee == opcode | 8'hce == opcode ? regs_y : _GEN_2830; // @[CPU6502Core.scala 209:20 236:16]
  wire [7:0] _GEN_2850 = 8'hee == opcode | 8'hce == opcode ? regs_sp : _GEN_2831; // @[CPU6502Core.scala 209:20 236:16]
  wire [15:0] _GEN_2851 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_6_pc : _GEN_2832; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2852 = 8'hee == opcode | 8'hce == opcode ? regs_flagC : _GEN_2833; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2853 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_6_flagZ : _GEN_2834; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2854 = 8'hee == opcode | 8'hce == opcode ? regs_flagI : _GEN_2835; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2855 = 8'hee == opcode | 8'hce == opcode ? regs_flagD : _GEN_2836; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2857 = 8'hee == opcode | 8'hce == opcode ? regs_flagV : _GEN_2838; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2858 = 8'hee == opcode | 8'hce == opcode ? execResult_result_newRegs_6_flagN : _GEN_2839; // @[CPU6502Core.scala 209:20 236:16]
  wire [15:0] _GEN_2859 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_7_memAddr : _GEN_2840; // @[CPU6502Core.scala 209:20 236:16]
  wire [7:0] _GEN_2860 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_7_memData : _GEN_2841; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2861 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_7_done : _GEN_2842; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2862 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_7_memRead : _GEN_2843; // @[CPU6502Core.scala 209:20 236:16]
  wire [15:0] _GEN_2863 = 8'hee == opcode | 8'hce == opcode ? execResult_result_result_7_operand : _GEN_2844; // @[CPU6502Core.scala 209:20 236:16]
  wire  _GEN_2864 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_done : _GEN_2845; // @[CPU6502Core.scala 209:20 231:16]
  wire [2:0] _GEN_2865 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_nextCycle : _GEN_2846; // @[CPU6502Core.scala 209:20 231:16]
  wire [7:0] _GEN_2866 = 8'he6 == opcode | 8'hc6 == opcode ? regs_a : _GEN_2847; // @[CPU6502Core.scala 209:20 231:16]
  wire [7:0] _GEN_2867 = 8'he6 == opcode | 8'hc6 == opcode ? regs_x : _GEN_2848; // @[CPU6502Core.scala 209:20 231:16]
  wire [7:0] _GEN_2868 = 8'he6 == opcode | 8'hc6 == opcode ? regs_y : _GEN_2849; // @[CPU6502Core.scala 209:20 231:16]
  wire [7:0] _GEN_2869 = 8'he6 == opcode | 8'hc6 == opcode ? regs_sp : _GEN_2850; // @[CPU6502Core.scala 209:20 231:16]
  wire [15:0] _GEN_2870 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_pc : _GEN_2851; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2871 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagC : _GEN_2852; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2872 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_2853; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2873 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagI : _GEN_2854; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2874 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagD : _GEN_2855; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2876 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagV : _GEN_2857; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2877 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_flagN : _GEN_2858; // @[CPU6502Core.scala 209:20 231:16]
  wire [15:0] _GEN_2878 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memAddr : _GEN_2859; // @[CPU6502Core.scala 209:20 231:16]
  wire [7:0] _GEN_2879 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memData : _GEN_2860; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2880 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_done : _GEN_2861; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2881 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memRead : _GEN_2862; // @[CPU6502Core.scala 209:20 231:16]
  wire [15:0] _GEN_2882 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_operand : _GEN_2863; // @[CPU6502Core.scala 209:20 231:16]
  wire  _GEN_2883 = 8'he9 == opcode | _GEN_2864; // @[CPU6502Core.scala 209:20 227:27]
  wire [2:0] _GEN_2884 = 8'he9 == opcode ? 3'h0 : _GEN_2865; // @[CPU6502Core.scala 209:20 227:27]
  wire [7:0] _GEN_2885 = 8'he9 == opcode ? execResult_result_newRegs_4_a : _GEN_2866; // @[CPU6502Core.scala 209:20 227:27]
  wire [7:0] _GEN_2886 = 8'he9 == opcode ? regs_x : _GEN_2867; // @[CPU6502Core.scala 209:20 227:27]
  wire [7:0] _GEN_2887 = 8'he9 == opcode ? regs_y : _GEN_2868; // @[CPU6502Core.scala 209:20 227:27]
  wire [7:0] _GEN_2888 = 8'he9 == opcode ? regs_sp : _GEN_2869; // @[CPU6502Core.scala 209:20 227:27]
  wire [15:0] _GEN_2889 = 8'he9 == opcode ? _regs_pc_T_1 : _GEN_2870; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2890 = 8'he9 == opcode ? execResult_result_newRegs_4_flagC : _GEN_2871; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2891 = 8'he9 == opcode ? execResult_result_newRegs_4_flagZ : _GEN_2872; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2892 = 8'he9 == opcode ? regs_flagI : _GEN_2873; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2893 = 8'he9 == opcode ? regs_flagD : _GEN_2874; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2895 = 8'he9 == opcode ? execResult_result_newRegs_4_flagV : _GEN_2876; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2896 = 8'he9 == opcode ? execResult_result_newRegs_4_flagN : _GEN_2877; // @[CPU6502Core.scala 209:20 227:27]
  wire [15:0] _GEN_2897 = 8'he9 == opcode ? regs_pc : _GEN_2878; // @[CPU6502Core.scala 209:20 227:27]
  wire [7:0] _GEN_2898 = 8'he9 == opcode ? 8'h0 : _GEN_2879; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2899 = 8'he9 == opcode ? 1'h0 : _GEN_2880; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2900 = 8'he9 == opcode | _GEN_2881; // @[CPU6502Core.scala 209:20 227:27]
  wire [15:0] _GEN_2901 = 8'he9 == opcode ? 16'h0 : _GEN_2882; // @[CPU6502Core.scala 209:20 227:27]
  wire  _GEN_2902 = 8'h69 == opcode | _GEN_2883; // @[CPU6502Core.scala 209:20 226:27]
  wire [2:0] _GEN_2903 = 8'h69 == opcode ? 3'h0 : _GEN_2884; // @[CPU6502Core.scala 209:20 226:27]
  wire [7:0] _GEN_2904 = 8'h69 == opcode ? execResult_result_newRegs_3_a : _GEN_2885; // @[CPU6502Core.scala 209:20 226:27]
  wire [7:0] _GEN_2905 = 8'h69 == opcode ? regs_x : _GEN_2886; // @[CPU6502Core.scala 209:20 226:27]
  wire [7:0] _GEN_2906 = 8'h69 == opcode ? regs_y : _GEN_2887; // @[CPU6502Core.scala 209:20 226:27]
  wire [7:0] _GEN_2907 = 8'h69 == opcode ? regs_sp : _GEN_2888; // @[CPU6502Core.scala 209:20 226:27]
  wire [15:0] _GEN_2908 = 8'h69 == opcode ? _regs_pc_T_1 : _GEN_2889; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2909 = 8'h69 == opcode ? execResult_result_newRegs_3_flagC : _GEN_2890; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2910 = 8'h69 == opcode ? execResult_result_newRegs_3_flagZ : _GEN_2891; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2911 = 8'h69 == opcode ? regs_flagI : _GEN_2892; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2912 = 8'h69 == opcode ? regs_flagD : _GEN_2893; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2914 = 8'h69 == opcode ? execResult_result_newRegs_3_flagV : _GEN_2895; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2915 = 8'h69 == opcode ? execResult_result_newRegs_3_flagN : _GEN_2896; // @[CPU6502Core.scala 209:20 226:27]
  wire [15:0] _GEN_2916 = 8'h69 == opcode ? regs_pc : _GEN_2897; // @[CPU6502Core.scala 209:20 226:27]
  wire [7:0] _GEN_2917 = 8'h69 == opcode ? 8'h0 : _GEN_2898; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2918 = 8'h69 == opcode ? 1'h0 : _GEN_2899; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2919 = 8'h69 == opcode | _GEN_2900; // @[CPU6502Core.scala 209:20 226:27]
  wire [15:0] _GEN_2920 = 8'h69 == opcode ? 16'h0 : _GEN_2901; // @[CPU6502Core.scala 209:20 226:27]
  wire  _GEN_2921 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode | _GEN_2902; // @[CPU6502Core.scala 209:20 222:16]
  wire [2:0] _GEN_2922 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 3'h0 : _GEN_2903; // @[CPU6502Core.scala 209:20 222:16]
  wire [7:0] _GEN_2923 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_a : _GEN_2904; // @[CPU6502Core.scala 209:20 222:16]
  wire [7:0] _GEN_2924 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_x : _GEN_2905; // @[CPU6502Core.scala 209:20 222:16]
  wire [7:0] _GEN_2925 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_y : _GEN_2906; // @[CPU6502Core.scala 209:20 222:16]
  wire [7:0] _GEN_2926 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_sp : _GEN_2907; // @[CPU6502Core.scala 209:20 222:16]
  wire [15:0] _GEN_2927 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_pc : _GEN_2908; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2928 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagC : _GEN_2909; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2929 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagZ : _GEN_2910; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2930 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagI : _GEN_2911; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2931 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagD : _GEN_2912; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2933 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagV : _GEN_2914; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2934 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagN : _GEN_2915; // @[CPU6502Core.scala 209:20 222:16]
  wire [15:0] _GEN_2935 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_2916; // @[CPU6502Core.scala 209:20 222:16]
  wire [7:0] _GEN_2936 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 8'h0 : _GEN_2917; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2937 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_2918; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2938 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_2919; // @[CPU6502Core.scala 209:20 222:16]
  wire [15:0] _GEN_2939 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_2920; // @[CPU6502Core.scala 209:20 222:16]
  wire  _GEN_2940 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode | _GEN_2921; // @[CPU6502Core.scala 209:20 217:16]
  wire [2:0] _GEN_2941 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 3'h0 : _GEN_2922; // @[CPU6502Core.scala 209:20 217:16]
  wire [7:0] _GEN_2942 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_a : _GEN_2923; // @[CPU6502Core.scala 209:20 217:16]
  wire [7:0] _GEN_2943 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_x : _GEN_2924; // @[CPU6502Core.scala 209:20 217:16]
  wire [7:0] _GEN_2944 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_y : _GEN_2925; // @[CPU6502Core.scala 209:20 217:16]
  wire [7:0] _GEN_2945 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_sp : _GEN_2926; // @[CPU6502Core.scala 209:20 217:16]
  wire [15:0] _GEN_2946 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? regs_pc : _GEN_2927; // @[CPU6502Core.scala 209:20 217:16]
  wire  _GEN_2947 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagC : _GEN_2928; // @[CPU6502Core.scala 209:20 217:16]
  wire  _GEN_2948 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagZ : _GEN_2929; // @[CPU6502Core.scala 209:20 217:16]
  wire  _GEN_2949 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagI : _GEN_2930; // @[CPU6502Core.scala 209:20 217:16]
  wire  _GEN_2950 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagD : _GEN_2931; // @[CPU6502Core.scala 209:20 217:16]
  wire  _GEN_2952 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagV : _GEN_2933; // @[CPU6502Core.scala 209:20 217:16]
  wire  _GEN_2953 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagN : _GEN_2934; // @[CPU6502Core.scala 209:20 217:16]
  wire [15:0] _GEN_2954 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_2935; // @[CPU6502Core.scala 209:20 217:16]
  wire [7:0] _GEN_2955 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 8'h0 : _GEN_2936; // @[CPU6502Core.scala 209:20 217:16]
  wire  _GEN_2956 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_2937; // @[CPU6502Core.scala 209:20 217:16]
  wire  _GEN_2957 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_2938; // @[CPU6502Core.scala 209:20 217:16]
  wire [15:0] _GEN_2958 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_2939; // @[CPU6502Core.scala 209:20 217:16]
  wire  execResult_result_1_done = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode | _GEN_2940; // @[CPU6502Core.scala 209:20 212:16]
  wire [2:0] execResult_result_1_nextCycle = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 3'h0 : _GEN_2941; // @[CPU6502Core.scala 209:20 212:16]
  wire [7:0] execResult_result_1_regs_a = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_a : _GEN_2942; // @[CPU6502Core.scala 209:20 212:16]
  wire [7:0] execResult_result_1_regs_x = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_x : _GEN_2943; // @[CPU6502Core.scala 209:20 212:16]
  wire [7:0] execResult_result_1_regs_y = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_y : _GEN_2944; // @[CPU6502Core.scala 209:20 212:16]
  wire [7:0] execResult_result_1_regs_sp = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_sp : _GEN_2945; // @[CPU6502Core.scala 209:20 212:16]
  wire [15:0] execResult_result_1_regs_pc = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_pc : _GEN_2946; // @[CPU6502Core.scala 209:20 212:16]
  wire  execResult_result_1_regs_flagC = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagC : _GEN_2947; // @[CPU6502Core.scala 209:20 212:16]
  wire  execResult_result_1_regs_flagZ = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagZ : _GEN_2948; // @[CPU6502Core.scala 209:20 212:16]
  wire  execResult_result_1_regs_flagI = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagI : _GEN_2949; // @[CPU6502Core.scala 209:20 212:16]
  wire  execResult_result_1_regs_flagD = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagD : _GEN_2950; // @[CPU6502Core.scala 209:20 212:16]
  wire  execResult_result_1_regs_flagV = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagV : _GEN_2952; // @[CPU6502Core.scala 209:20 212:16]
  wire  execResult_result_1_regs_flagN = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagN : _GEN_2953; // @[CPU6502Core.scala 209:20 212:16]
  wire [15:0] execResult_result_1_memAddr = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_2954; // @[CPU6502Core.scala 209:20 212:16]
  wire [7:0] execResult_result_1_memData = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 8'h0 : _GEN_2955; // @[CPU6502Core.scala 209:20 212:16]
  wire  execResult_result_1_memWrite = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_2956; // @[CPU6502Core.scala 209:20 212:16]
  wire  execResult_result_1_memRead = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_2957; // @[CPU6502Core.scala 209:20 212:16]
  wire [15:0] execResult_result_1_operand = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_2958; // @[CPU6502Core.scala 209:20 212:16]
  wire  _GEN_3044 = 3'h2 == state & execResult_result_1_done; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3089 = 3'h1 == state ? 1'h0 : _GEN_3044; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3132 = 3'h0 == state ? 1'h0 : _GEN_3089; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_done = io_reset ? 1'h0 : _GEN_3132; // @[CPU6502Core.scala 49:14 52:18]
  wire [2:0] _GEN_3045 = 3'h2 == state ? execResult_result_1_nextCycle : 3'h0; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [2:0] _GEN_3090 = 3'h1 == state ? 3'h0 : _GEN_3045; // @[CPU6502Core.scala 49:14 59:19]
  wire [2:0] _GEN_3133 = 3'h0 == state ? 3'h0 : _GEN_3090; // @[CPU6502Core.scala 49:14 59:19]
  wire [2:0] execResult_nextCycle = io_reset ? 3'h0 : _GEN_3133; // @[CPU6502Core.scala 49:14 52:18]
  wire [2:0] _GEN_2978 = execResult_done ? 3'h0 : execResult_nextCycle; // @[CPU6502Core.scala 130:19 132:33 133:19]
  wire [2:0] _GEN_2979 = execResult_done ? 3'h1 : state; // @[CPU6502Core.scala 132:33 134:19 25:22]
  wire [7:0] status = {regs_flagN,regs_flagV,2'h2,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_2980 = cycle == 3'h5 ? 16'hfffa : 16'hfffb; // @[CPU6502Core.scala 171:37 173:24 179:24]
  wire [15:0] _GEN_2982 = cycle == 3'h5 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 171:37 175:21 28:24]
  wire [2:0] _GEN_2983 = cycle == 3'h5 ? 3'h6 : 3'h0; // @[CPU6502Core.scala 171:37 176:19 184:19]
  wire [15:0] _GEN_2984 = cycle == 3'h5 ? regs_pc : resetVector; // @[CPU6502Core.scala 171:37 182:21 21:21]
  wire  _GEN_2985 = cycle == 3'h5 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 171:37 21:21 183:24]
  wire [2:0] _GEN_2986 = cycle == 3'h5 ? state : 3'h1; // @[CPU6502Core.scala 171:37 185:19 25:22]
  wire [15:0] _GEN_2987 = cycle == 3'h4 ? 16'hfffa : _GEN_2980; // @[CPU6502Core.scala 166:37 168:24]
  wire [2:0] _GEN_2989 = cycle == 3'h4 ? 3'h5 : _GEN_2983; // @[CPU6502Core.scala 166:37 170:19]
  wire [15:0] _GEN_2990 = cycle == 3'h4 ? operand : _GEN_2982; // @[CPU6502Core.scala 166:37 28:24]
  wire [15:0] _GEN_2991 = cycle == 3'h4 ? regs_pc : _GEN_2984; // @[CPU6502Core.scala 166:37 21:21]
  wire  _GEN_2992 = cycle == 3'h4 ? regs_flagI : _GEN_2985; // @[CPU6502Core.scala 166:37 21:21]
  wire [2:0] _GEN_2993 = cycle == 3'h4 ? state : _GEN_2986; // @[CPU6502Core.scala 166:37 25:22]
  wire [15:0] _GEN_2994 = _T_6 ? execResult_result_result_36_memAddr : _GEN_2987; // @[CPU6502Core.scala 157:37 161:24]
  wire [7:0] _GEN_2995 = _T_6 ? status : 8'h0; // @[CPU6502Core.scala 157:37 162:27 43:17]
  wire [7:0] _GEN_2997 = _T_6 ? execResult_result_newRegs_35_sp : regs_sp; // @[CPU6502Core.scala 157:37 164:21 21:21]
  wire [2:0] _GEN_2998 = _T_6 ? 3'h4 : _GEN_2989; // @[CPU6502Core.scala 157:37 165:19]
  wire  _GEN_2999 = _T_6 ? 1'h0 : 1'h1; // @[CPU6502Core.scala 157:37 45:17]
  wire [15:0] _GEN_3000 = _T_6 ? operand : _GEN_2990; // @[CPU6502Core.scala 157:37 28:24]
  wire [15:0] _GEN_3001 = _T_6 ? regs_pc : _GEN_2991; // @[CPU6502Core.scala 157:37 21:21]
  wire  _GEN_3002 = _T_6 ? regs_flagI : _GEN_2992; // @[CPU6502Core.scala 157:37 21:21]
  wire [2:0] _GEN_3003 = _T_6 ? state : _GEN_2993; // @[CPU6502Core.scala 157:37 25:22]
  wire [15:0] _GEN_3004 = _T_5 ? execResult_result_result_36_memAddr : _GEN_2994; // @[CPU6502Core.scala 150:37 152:24]
  wire [7:0] _GEN_3005 = _T_5 ? regs_pc[7:0] : _GEN_2995; // @[CPU6502Core.scala 150:37 153:27]
  wire  _GEN_3006 = _T_5 | _T_6; // @[CPU6502Core.scala 150:37 154:25]
  wire [7:0] _GEN_3007 = _T_5 ? execResult_result_newRegs_35_sp : _GEN_2997; // @[CPU6502Core.scala 150:37 155:21]
  wire [2:0] _GEN_3008 = _T_5 ? 3'h3 : _GEN_2998; // @[CPU6502Core.scala 150:37 156:19]
  wire  _GEN_3009 = _T_5 ? 1'h0 : _GEN_2999; // @[CPU6502Core.scala 150:37 45:17]
  wire [15:0] _GEN_3010 = _T_5 ? operand : _GEN_3000; // @[CPU6502Core.scala 150:37 28:24]
  wire [15:0] _GEN_3011 = _T_5 ? regs_pc : _GEN_3001; // @[CPU6502Core.scala 150:37 21:21]
  wire  _GEN_3012 = _T_5 ? regs_flagI : _GEN_3002; // @[CPU6502Core.scala 150:37 21:21]
  wire [2:0] _GEN_3013 = _T_5 ? state : _GEN_3003; // @[CPU6502Core.scala 150:37 25:22]
  wire [15:0] _GEN_3014 = _T_4 ? execResult_result_result_36_memAddr : _GEN_3004; // @[CPU6502Core.scala 143:37 145:24]
  wire [7:0] _GEN_3015 = _T_4 ? regs_pc[15:8] : _GEN_3005; // @[CPU6502Core.scala 143:37 146:27]
  wire  _GEN_3016 = _T_4 | _GEN_3006; // @[CPU6502Core.scala 143:37 147:25]
  wire [7:0] _GEN_3017 = _T_4 ? execResult_result_newRegs_35_sp : _GEN_3007; // @[CPU6502Core.scala 143:37 148:21]
  wire [2:0] _GEN_3018 = _T_4 ? 3'h2 : _GEN_3008; // @[CPU6502Core.scala 143:37 149:19]
  wire  _GEN_3019 = _T_4 ? 1'h0 : _GEN_3009; // @[CPU6502Core.scala 143:37 45:17]
  wire [15:0] _GEN_3020 = _T_4 ? operand : _GEN_3010; // @[CPU6502Core.scala 143:37 28:24]
  wire [15:0] _GEN_3021 = _T_4 ? regs_pc : _GEN_3011; // @[CPU6502Core.scala 143:37 21:21]
  wire  _GEN_3022 = _T_4 ? regs_flagI : _GEN_3012; // @[CPU6502Core.scala 143:37 21:21]
  wire [2:0] _GEN_3023 = _T_4 ? state : _GEN_3013; // @[CPU6502Core.scala 143:37 25:22]
  wire [2:0] _GEN_3024 = _T_3 ? 3'h1 : _GEN_3018; // @[CPU6502Core.scala 140:31 142:19]
  wire [15:0] _GEN_3025 = _T_3 ? regs_pc : _GEN_3014; // @[CPU6502Core.scala 140:31 42:17]
  wire [7:0] _GEN_3026 = _T_3 ? 8'h0 : _GEN_3015; // @[CPU6502Core.scala 140:31 43:17]
  wire  _GEN_3027 = _T_3 ? 1'h0 : _GEN_3016; // @[CPU6502Core.scala 140:31 44:17]
  wire [7:0] _GEN_3028 = _T_3 ? regs_sp : _GEN_3017; // @[CPU6502Core.scala 140:31 21:21]
  wire  _GEN_3029 = _T_3 ? 1'h0 : _GEN_3019; // @[CPU6502Core.scala 140:31 45:17]
  wire [15:0] _GEN_3030 = _T_3 ? operand : _GEN_3020; // @[CPU6502Core.scala 140:31 28:24]
  wire [15:0] _GEN_3031 = _T_3 ? regs_pc : _GEN_3021; // @[CPU6502Core.scala 140:31 21:21]
  wire  _GEN_3032 = _T_3 ? regs_flagI : _GEN_3022; // @[CPU6502Core.scala 140:31 21:21]
  wire [2:0] _GEN_3033 = _T_3 ? state : _GEN_3023; // @[CPU6502Core.scala 140:31 25:22]
  wire [2:0] _GEN_3034 = 3'h3 == state ? _GEN_3024 : cycle; // @[CPU6502Core.scala 59:19 29:24]
  wire [15:0] _GEN_3035 = 3'h3 == state ? _GEN_3025 : regs_pc; // @[CPU6502Core.scala 42:17 59:19]
  wire [7:0] _GEN_3036 = 3'h3 == state ? _GEN_3026 : 8'h0; // @[CPU6502Core.scala 43:17 59:19]
  wire  _GEN_3037 = 3'h3 == state & _GEN_3027; // @[CPU6502Core.scala 44:17 59:19]
  wire [7:0] _GEN_3038 = 3'h3 == state ? _GEN_3028 : regs_sp; // @[CPU6502Core.scala 59:19 21:21]
  wire  _GEN_3039 = 3'h3 == state & _GEN_3029; // @[CPU6502Core.scala 45:17 59:19]
  wire [15:0] _GEN_3040 = 3'h3 == state ? _GEN_3030 : operand; // @[CPU6502Core.scala 59:19 28:24]
  wire [15:0] _GEN_3041 = 3'h3 == state ? _GEN_3031 : regs_pc; // @[CPU6502Core.scala 59:19 21:21]
  wire  _GEN_3042 = 3'h3 == state ? _GEN_3032 : regs_flagI; // @[CPU6502Core.scala 59:19 21:21]
  wire [2:0] _GEN_3043 = 3'h3 == state ? _GEN_3033 : state; // @[CPU6502Core.scala 59:19 25:22]
  wire [7:0] _GEN_3046 = 3'h2 == state ? execResult_result_1_regs_a : regs_a; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [7:0] _GEN_3047 = 3'h2 == state ? execResult_result_1_regs_x : regs_x; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [7:0] _GEN_3048 = 3'h2 == state ? execResult_result_1_regs_y : regs_y; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [7:0] _GEN_3049 = 3'h2 == state ? execResult_result_1_regs_sp : regs_sp; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [15:0] _GEN_3050 = 3'h2 == state ? execResult_result_1_regs_pc : regs_pc; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3051 = 3'h2 == state ? execResult_result_1_regs_flagC : regs_flagC; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3052 = 3'h2 == state ? execResult_result_1_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3053 = 3'h2 == state ? execResult_result_1_regs_flagI : regs_flagI; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3054 = 3'h2 == state ? execResult_result_1_regs_flagD : regs_flagD; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3056 = 3'h2 == state ? execResult_result_1_regs_flagV : regs_flagV; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3057 = 3'h2 == state ? execResult_result_1_regs_flagN : regs_flagN; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [15:0] _GEN_3058 = 3'h2 == state ? execResult_result_1_memAddr : 16'h0; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [7:0] _GEN_3059 = 3'h2 == state ? execResult_result_1_memData : 8'h0; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3060 = 3'h2 == state & execResult_result_1_memWrite; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire  _GEN_3061 = 3'h2 == state & execResult_result_1_memRead; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [15:0] _GEN_3062 = 3'h2 == state ? execResult_result_1_operand : operand; // @[CPU6502Core.scala 59:19 120:22 49:14]
  wire [15:0] _GEN_3103 = 3'h1 == state ? 16'h0 : _GEN_3058; // @[CPU6502Core.scala 49:14 59:19]
  wire [15:0] _GEN_3146 = 3'h0 == state ? 16'h0 : _GEN_3103; // @[CPU6502Core.scala 49:14 59:19]
  wire [15:0] execResult_memAddr = io_reset ? 16'h0 : _GEN_3146; // @[CPU6502Core.scala 49:14 52:18]
  wire [15:0] _GEN_3063 = 3'h2 == state ? execResult_memAddr : _GEN_3035; // @[CPU6502Core.scala 59:19 123:25]
  wire [7:0] _GEN_3104 = 3'h1 == state ? 8'h0 : _GEN_3059; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] _GEN_3147 = 3'h0 == state ? 8'h0 : _GEN_3104; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] execResult_memData = io_reset ? 8'h0 : _GEN_3147; // @[CPU6502Core.scala 49:14 52:18]
  wire [7:0] _GEN_3064 = 3'h2 == state ? execResult_memData : _GEN_3036; // @[CPU6502Core.scala 59:19 124:25]
  wire  _GEN_3105 = 3'h1 == state ? 1'h0 : _GEN_3060; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3148 = 3'h0 == state ? 1'h0 : _GEN_3105; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_memWrite = io_reset ? 1'h0 : _GEN_3148; // @[CPU6502Core.scala 49:14 52:18]
  wire  _GEN_3065 = 3'h2 == state ? execResult_memWrite : _GEN_3037; // @[CPU6502Core.scala 59:19 125:25]
  wire  _GEN_3106 = 3'h1 == state ? 1'h0 : _GEN_3061; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3149 = 3'h0 == state ? 1'h0 : _GEN_3106; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_memRead = io_reset ? 1'h0 : _GEN_3149; // @[CPU6502Core.scala 49:14 52:18]
  wire  _GEN_3066 = 3'h2 == state ? execResult_memRead : _GEN_3039; // @[CPU6502Core.scala 59:19 126:25]
  wire [7:0] _GEN_3091 = 3'h1 == state ? regs_a : _GEN_3046; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] _GEN_3134 = 3'h0 == state ? regs_a : _GEN_3091; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] execResult_regs_a = io_reset ? regs_a : _GEN_3134; // @[CPU6502Core.scala 49:14 52:18]
  wire [7:0] _GEN_3067 = 3'h2 == state ? execResult_regs_a : regs_a; // @[CPU6502Core.scala 128:19 59:19 21:21]
  wire [7:0] _GEN_3092 = 3'h1 == state ? regs_x : _GEN_3047; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] _GEN_3135 = 3'h0 == state ? regs_x : _GEN_3092; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] execResult_regs_x = io_reset ? regs_x : _GEN_3135; // @[CPU6502Core.scala 49:14 52:18]
  wire [7:0] _GEN_3068 = 3'h2 == state ? execResult_regs_x : regs_x; // @[CPU6502Core.scala 128:19 59:19 21:21]
  wire [7:0] _GEN_3093 = 3'h1 == state ? regs_y : _GEN_3048; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] _GEN_3136 = 3'h0 == state ? regs_y : _GEN_3093; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] execResult_regs_y = io_reset ? regs_y : _GEN_3136; // @[CPU6502Core.scala 49:14 52:18]
  wire [7:0] _GEN_3069 = 3'h2 == state ? execResult_regs_y : regs_y; // @[CPU6502Core.scala 128:19 59:19 21:21]
  wire [7:0] _GEN_3094 = 3'h1 == state ? regs_sp : _GEN_3049; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] _GEN_3137 = 3'h0 == state ? regs_sp : _GEN_3094; // @[CPU6502Core.scala 49:14 59:19]
  wire [7:0] execResult_regs_sp = io_reset ? regs_sp : _GEN_3137; // @[CPU6502Core.scala 49:14 52:18]
  wire [7:0] _GEN_3070 = 3'h2 == state ? execResult_regs_sp : _GEN_3038; // @[CPU6502Core.scala 128:19 59:19]
  wire [15:0] _GEN_3095 = 3'h1 == state ? regs_pc : _GEN_3050; // @[CPU6502Core.scala 49:14 59:19]
  wire [15:0] _GEN_3138 = 3'h0 == state ? regs_pc : _GEN_3095; // @[CPU6502Core.scala 49:14 59:19]
  wire [15:0] execResult_regs_pc = io_reset ? regs_pc : _GEN_3138; // @[CPU6502Core.scala 49:14 52:18]
  wire [15:0] _GEN_3071 = 3'h2 == state ? execResult_regs_pc : _GEN_3041; // @[CPU6502Core.scala 128:19 59:19]
  wire  _GEN_3096 = 3'h1 == state ? regs_flagC : _GEN_3051; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3139 = 3'h0 == state ? regs_flagC : _GEN_3096; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_regs_flagC = io_reset ? regs_flagC : _GEN_3139; // @[CPU6502Core.scala 49:14 52:18]
  wire  _GEN_3072 = 3'h2 == state ? execResult_regs_flagC : regs_flagC; // @[CPU6502Core.scala 128:19 59:19 21:21]
  wire  _GEN_3097 = 3'h1 == state ? regs_flagZ : _GEN_3052; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3140 = 3'h0 == state ? regs_flagZ : _GEN_3097; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_regs_flagZ = io_reset ? regs_flagZ : _GEN_3140; // @[CPU6502Core.scala 49:14 52:18]
  wire  _GEN_3073 = 3'h2 == state ? execResult_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 128:19 59:19 21:21]
  wire  _GEN_3098 = 3'h1 == state ? regs_flagI : _GEN_3053; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3141 = 3'h0 == state ? regs_flagI : _GEN_3098; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_regs_flagI = io_reset ? regs_flagI : _GEN_3141; // @[CPU6502Core.scala 49:14 52:18]
  wire  _GEN_3074 = 3'h2 == state ? execResult_regs_flagI : _GEN_3042; // @[CPU6502Core.scala 128:19 59:19]
  wire  _GEN_3099 = 3'h1 == state ? regs_flagD : _GEN_3054; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3142 = 3'h0 == state ? regs_flagD : _GEN_3099; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_regs_flagD = io_reset ? regs_flagD : _GEN_3142; // @[CPU6502Core.scala 49:14 52:18]
  wire  _GEN_3075 = 3'h2 == state ? execResult_regs_flagD : regs_flagD; // @[CPU6502Core.scala 128:19 59:19 21:21]
  wire  _GEN_3101 = 3'h1 == state ? regs_flagV : _GEN_3056; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3144 = 3'h0 == state ? regs_flagV : _GEN_3101; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_regs_flagV = io_reset ? regs_flagV : _GEN_3144; // @[CPU6502Core.scala 49:14 52:18]
  wire  _GEN_3077 = 3'h2 == state ? execResult_regs_flagV : regs_flagV; // @[CPU6502Core.scala 128:19 59:19 21:21]
  wire  _GEN_3102 = 3'h1 == state ? regs_flagN : _GEN_3057; // @[CPU6502Core.scala 49:14 59:19]
  wire  _GEN_3145 = 3'h0 == state ? regs_flagN : _GEN_3102; // @[CPU6502Core.scala 49:14 59:19]
  wire  execResult_regs_flagN = io_reset ? regs_flagN : _GEN_3145; // @[CPU6502Core.scala 49:14 52:18]
  wire  _GEN_3078 = 3'h2 == state ? execResult_regs_flagN : regs_flagN; // @[CPU6502Core.scala 128:19 59:19 21:21]
  wire [15:0] _GEN_3107 = 3'h1 == state ? operand : _GEN_3062; // @[CPU6502Core.scala 49:14 59:19]
  wire [15:0] _GEN_3150 = 3'h0 == state ? operand : _GEN_3107; // @[CPU6502Core.scala 49:14 59:19]
  wire [15:0] execResult_operand = io_reset ? operand : _GEN_3150; // @[CPU6502Core.scala 49:14 52:18]
  wire [15:0] _GEN_3079 = 3'h2 == state ? execResult_operand : _GEN_3040; // @[CPU6502Core.scala 129:19 59:19]
  wire [2:0] _GEN_3080 = 3'h2 == state ? _GEN_2978 : _GEN_3034; // @[CPU6502Core.scala 59:19]
  wire [2:0] _GEN_3081 = 3'h2 == state ? _GEN_2979 : _GEN_3043; // @[CPU6502Core.scala 59:19]
  wire [15:0] _GEN_3085 = 3'h1 == state ? regs_pc : _GEN_3063; // @[CPU6502Core.scala 59:19]
  wire  _GEN_3086 = 3'h1 == state ? _GEN_35 : _GEN_3066; // @[CPU6502Core.scala 59:19]
  wire [7:0] _GEN_3108 = 3'h1 == state ? 8'h0 : _GEN_3064; // @[CPU6502Core.scala 43:17 59:19]
  wire  _GEN_3109 = 3'h1 == state ? 1'h0 : _GEN_3065; // @[CPU6502Core.scala 44:17 59:19]
  wire [15:0] _GEN_3122 = 3'h0 == state ? _GEN_23 : _GEN_3085; // @[CPU6502Core.scala 59:19]
  wire  _GEN_3123 = 3'h0 == state | _GEN_3086; // @[CPU6502Core.scala 59:19]
  wire [7:0] _GEN_3151 = 3'h0 == state ? 8'h0 : _GEN_3108; // @[CPU6502Core.scala 43:17 59:19]
  wire  _GEN_3152 = 3'h0 == state ? 1'h0 : _GEN_3109; // @[CPU6502Core.scala 44:17 59:19]
  assign io_memAddr = io_reset ? regs_pc : _GEN_3122; // @[CPU6502Core.scala 42:17 52:18]
  assign io_memDataOut = io_reset ? 8'h0 : _GEN_3151; // @[CPU6502Core.scala 43:17 52:18]
  assign io_memWrite = io_reset ? 1'h0 : _GEN_3152; // @[CPU6502Core.scala 44:17 52:18]
  assign io_memRead = io_reset ? 1'h0 : _GEN_3123; // @[CPU6502Core.scala 45:17 52:18]
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
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
          regs_a <= _GEN_3067;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_x <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
          regs_x <= _GEN_3068;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_y <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
          regs_y <= _GEN_3069;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_sp <= 8'hff; // @[CPU6502Core.scala 21:21]
    end else if (io_reset) begin // @[CPU6502Core.scala 52:18]
      regs_sp <= 8'hff; // @[CPU6502Core.scala 57:13]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 59:19]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 63:31]
        regs_sp <= _GEN_20;
      end
    end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
      regs_sp <= _GEN_3070;
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 21:21]
    end else if (io_reset) begin // @[CPU6502Core.scala 52:18]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 56:13]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 59:19]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 63:31]
        regs_pc <= _GEN_19;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 59:19]
      regs_pc <= _GEN_37;
    end else begin
      regs_pc <= _GEN_3071;
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagC <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
          regs_flagC <= _GEN_3072;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagZ <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
          regs_flagZ <= _GEN_3073;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagI <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 59:19]
        if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 63:31]
          regs_flagI <= _GEN_21;
        end
      end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
        regs_flagI <= _GEN_3074;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagD <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
          regs_flagD <= _GEN_3075;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagV <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
          regs_flagV <= _GEN_3077;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagN <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
          regs_flagN <= _GEN_3078;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 25:22]
      state <= 3'h0; // @[CPU6502Core.scala 25:22]
    end else if (io_reset) begin // @[CPU6502Core.scala 52:18]
      state <= 3'h0; // @[CPU6502Core.scala 54:11]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 59:19]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 63:31]
        state <= _GEN_22;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 59:19]
      state <= _GEN_33;
    end else begin
      state <= _GEN_3081;
    end
    if (reset) begin // @[CPU6502Core.scala 27:24]
      opcode <= 8'h0; // @[CPU6502Core.scala 27:24]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (!(3'h0 == state)) begin // @[CPU6502Core.scala 59:19]
        if (3'h1 == state) begin // @[CPU6502Core.scala 59:19]
          opcode <= _GEN_36;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 28:24]
      operand <= 16'h0; // @[CPU6502Core.scala 28:24]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 52:18]
      if (3'h0 == state) begin // @[CPU6502Core.scala 59:19]
        if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 63:31]
          operand <= _GEN_17;
        end
      end else if (!(3'h1 == state)) begin // @[CPU6502Core.scala 59:19]
        operand <= _GEN_3079;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 29:24]
      cycle <= 3'h0; // @[CPU6502Core.scala 29:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 52:18]
      cycle <= 3'h0; // @[CPU6502Core.scala 55:11]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 59:19]
      if (cycle == 3'h0) begin // @[CPU6502Core.scala 63:31]
        cycle <= 3'h1; // @[CPU6502Core.scala 67:19]
      end else begin
        cycle <= _GEN_18;
      end
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 59:19]
      cycle <= 3'h0;
    end else begin
      cycle <= _GEN_3080;
    end
    if (reset) begin // @[CPU6502Core.scala 32:24]
      nmiLast <= 1'h0; // @[CPU6502Core.scala 32:24]
    end else begin
      nmiLast <= io_nmi; // @[CPU6502Core.scala 39:11]
    end
    if (reset) begin // @[CPU6502Core.scala 33:24]
      nmiEdge <= 1'h0; // @[CPU6502Core.scala 33:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 52:18]
      nmiEdge <= _GEN_0;
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 59:19]
      nmiEdge <= _GEN_0;
    end else if (3'h1 == state) begin // @[CPU6502Core.scala 59:19]
      nmiEdge <= _GEN_31;
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
  wire  _GEN_46 = _T_3 & _T_5 ? 1'h0 : _GEN_44; // @[PPU.scala 118:50 119:16]
  wire [7:0] _io_cpuDataOut_T = {vblankFlag,7'h0}; // @[Cat.scala 33:92]
  wire  _T_12 = 3'h4 == io_cpuAddr; // @[PPU.scala 127:24]
  wire  _T_13 = 3'h7 == io_cpuAddr; // @[PPU.scala 127:24]
  wire  _T_14 = ppuAddrReg < 16'h2000; // @[PPU.scala 138:25]
  wire  _T_15 = ppuAddrReg < 16'h3f00; // @[PPU.scala 141:31]
  wire [7:0] _GEN_51 = ppuAddrReg < 16'h3f00 ? vram_io_cpuDataOut_MPORT_2_data : palette_io_cpuDataOut_MPORT_3_data; // @[PPU.scala 141:43 143:25 146:25]
  wire  _GEN_54 = ppuAddrReg < 16'h3f00 ? 1'h0 : 1'h1; // @[PPU.scala 141:43 63:20 146:40]
  wire [7:0] _GEN_58 = ppuAddrReg < 16'h2000 ? chrROM_io_cpuDataOut_MPORT_1_data : _GEN_51; // @[PPU.scala 138:37 140:25]
  wire  _GEN_61 = ppuAddrReg < 16'h2000 ? 1'h0 : _T_15; // @[PPU.scala 138:37 61:17]
  wire  _GEN_64 = ppuAddrReg < 16'h2000 ? 1'h0 : _GEN_54; // @[PPU.scala 138:37 63:20]
  wire [15:0] _ppuAddrReg_T_1 = ppuAddrReg + 16'h1; // @[PPU.scala 148:34]
  wire  _GEN_67 = 3'h7 == io_cpuAddr & _T_14; // @[PPU.scala 127:24 64:19]
  wire [7:0] _GEN_68 = 3'h7 == io_cpuAddr ? _GEN_58 : 8'h0; // @[PPU.scala 124:17 127:24]
  wire  _GEN_71 = 3'h7 == io_cpuAddr & _GEN_61; // @[PPU.scala 127:24 61:17]
  wire  _GEN_74 = 3'h7 == io_cpuAddr & _GEN_64; // @[PPU.scala 127:24 63:20]
  wire [15:0] _GEN_75 = 3'h7 == io_cpuAddr ? _ppuAddrReg_T_1 : ppuAddrReg; // @[PPU.scala 127:24 148:20 58:27]
  wire [7:0] _GEN_79 = 3'h4 == io_cpuAddr ? oam_io_cpuDataOut_MPORT_data : _GEN_68; // @[PPU.scala 127:24 134:23]
  wire  _GEN_82 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _T_14; // @[PPU.scala 127:24 64:19]
  wire  _GEN_85 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _GEN_61; // @[PPU.scala 127:24 61:17]
  wire  _GEN_88 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr & _GEN_64; // @[PPU.scala 127:24 63:20]
  wire [15:0] _GEN_89 = 3'h4 == io_cpuAddr ? ppuAddrReg : _GEN_75; // @[PPU.scala 127:24 58:27]
  wire [7:0] _GEN_90 = 3'h2 == io_cpuAddr ? _io_cpuDataOut_T : _GEN_79; // @[PPU.scala 127:24 129:23]
  wire  _GEN_92 = 3'h2 == io_cpuAddr ? 1'h0 : ppuAddrLatch; // @[PPU.scala 127:24 131:22 57:29]
  wire  _GEN_95 = 3'h2 == io_cpuAddr ? 1'h0 : 3'h4 == io_cpuAddr; // @[PPU.scala 127:24 62:16]
  wire  _GEN_98 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_82; // @[PPU.scala 127:24 64:19]
  wire  _GEN_101 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_85; // @[PPU.scala 127:24 61:17]
  wire  _GEN_104 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_88; // @[PPU.scala 127:24 63:20]
  wire [15:0] _GEN_105 = 3'h2 == io_cpuAddr ? ppuAddrReg : _GEN_89; // @[PPU.scala 127:24 58:27]
  wire  _GEN_108 = io_cpuRead ? _GEN_92 : ppuAddrLatch; // @[PPU.scala 126:20 57:29]
  wire [15:0] _GEN_121 = io_cpuRead ? _GEN_105 : ppuAddrReg; // @[PPU.scala 126:20 58:27]
  wire [7:0] _oamAddr_T_1 = oamAddr + 8'h1; // @[PPU.scala 166:28]
  wire  _T_21 = ~ppuAddrLatch; // @[PPU.scala 169:14]
  wire [13:0] _ppuAddrReg_T_3 = {io_cpuDataIn[5:0],8'h0}; // @[Cat.scala 33:92]
  wire [15:0] _ppuAddrReg_T_5 = {ppuAddrReg[15:8],io_cpuDataIn}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_124 = _T_21 ? {{2'd0}, _ppuAddrReg_T_3} : _ppuAddrReg_T_5; // @[PPU.scala 177:29 178:22 180:22]
  wire [15:0] _GEN_165 = _T_13 ? _ppuAddrReg_T_1 : _GEN_121; // @[PPU.scala 154:24 196:20]
  wire [15:0] _GEN_166 = 3'h6 == io_cpuAddr ? _GEN_124 : _GEN_165; // @[PPU.scala 154:24]
  wire  _GEN_167 = 3'h6 == io_cpuAddr ? _T_21 : _GEN_108; // @[PPU.scala 154:24 182:22]
  wire  _GEN_170 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_67; // @[PPU.scala 154:24 64:19]
  wire  _GEN_175 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_71; // @[PPU.scala 154:24 61:17]
  wire  _GEN_180 = 3'h6 == io_cpuAddr ? 1'h0 : _GEN_74; // @[PPU.scala 154:24 63:20]
  wire  _GEN_185 = 3'h5 == io_cpuAddr ? _T_21 : _GEN_167; // @[PPU.scala 154:24 174:22]
  wire [15:0] _GEN_186 = 3'h5 == io_cpuAddr ? _GEN_121 : _GEN_166; // @[PPU.scala 154:24]
  wire  _GEN_189 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_170; // @[PPU.scala 154:24 64:19]
  wire  _GEN_194 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_175; // @[PPU.scala 154:24 61:17]
  wire  _GEN_199 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_180; // @[PPU.scala 154:24 63:20]
  wire [7:0] _GEN_207 = _T_12 ? _oamAddr_T_1 : oamAddr; // @[PPU.scala 154:24 166:17 54:24]
  wire  _GEN_210 = _T_12 ? _GEN_108 : _GEN_185; // @[PPU.scala 154:24]
  wire [15:0] _GEN_211 = _T_12 ? _GEN_121 : _GEN_186; // @[PPU.scala 154:24]
  wire  _GEN_214 = _T_12 ? 1'h0 : _GEN_189; // @[PPU.scala 154:24 64:19]
  wire  _GEN_219 = _T_12 ? 1'h0 : _GEN_194; // @[PPU.scala 154:24 61:17]
  wire  _GEN_224 = _T_12 ? 1'h0 : _GEN_199; // @[PPU.scala 154:24 63:20]
  wire [7:0] _GEN_227 = 3'h3 == io_cpuAddr ? io_cpuDataIn : _GEN_207; // @[PPU.scala 154:24 162:17]
  wire  _GEN_230 = 3'h3 == io_cpuAddr ? 1'h0 : _T_12; // @[PPU.scala 154:24 62:16]
  wire  _GEN_235 = 3'h3 == io_cpuAddr ? _GEN_108 : _GEN_210; // @[PPU.scala 154:24]
  wire [15:0] _GEN_236 = 3'h3 == io_cpuAddr ? _GEN_121 : _GEN_211; // @[PPU.scala 154:24]
  wire  _GEN_239 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_214; // @[PPU.scala 154:24 64:19]
  wire  _GEN_244 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_219; // @[PPU.scala 154:24 61:17]
  wire  _GEN_249 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_224; // @[PPU.scala 154:24 63:20]
  wire  _GEN_256 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_230; // @[PPU.scala 154:24 62:16]
  wire  _GEN_265 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_239; // @[PPU.scala 154:24 64:19]
  wire  _GEN_270 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_244; // @[PPU.scala 154:24 61:17]
  wire  _GEN_275 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_249; // @[PPU.scala 154:24 63:20]
  wire  _GEN_283 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_256; // @[PPU.scala 154:24 62:16]
  wire  _GEN_292 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_265; // @[PPU.scala 154:24 64:19]
  wire  _GEN_297 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_270; // @[PPU.scala 154:24 61:17]
  wire  _GEN_302 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_275; // @[PPU.scala 154:24 63:20]
  wire  _T_30 = renderX < 9'h100; // @[PPU.scala 212:16]
  wire  _T_31 = renderY < 9'hf0; // @[PPU.scala 212:35]
  wire [5:0] tileX = renderX[8:3]; // @[PPU.scala 214:25]
  wire [5:0] tileY = renderY[8:3]; // @[PPU.scala 215:25]
  wire [2:0] pixelInTileX = renderX[2:0]; // @[PPU.scala 216:31]
  wire [2:0] pixelInTileY = renderY[2:0]; // @[PPU.scala 217:31]
  wire [10:0] _nametableAddr_T = {tileY, 5'h0}; // @[PPU.scala 220:32]
  wire [10:0] _GEN_346 = {{5'd0}, tileX}; // @[PPU.scala 220:38]
  wire [3:0] attrX = tileX[5:2]; // @[PPU.scala 224:23]
  wire [3:0] attrY = tileY[5:2]; // @[PPU.scala 225:23]
  wire [6:0] _attrAddr_T = {attrY, 3'h0}; // @[PPU.scala 226:37]
  wire [9:0] _GEN_347 = {{3'd0}, _attrAddr_T}; // @[PPU.scala 226:28]
  wire [9:0] _attrAddr_T_2 = 10'h3c0 + _GEN_347; // @[PPU.scala 226:28]
  wire [9:0] _GEN_348 = {{6'd0}, attrX}; // @[PPU.scala 226:43]
  wire [9:0] attrAddr = _attrAddr_T_2 + _GEN_348; // @[PPU.scala 226:43]
  wire [2:0] _attrShift_T_1 = {tileY[1], 2'h0}; // @[PPU.scala 228:32]
  wire [1:0] _attrShift_T_3 = {tileX[1], 1'h0}; // @[PPU.scala 228:50]
  wire [2:0] _GEN_349 = {{1'd0}, _attrShift_T_3}; // @[PPU.scala 228:38]
  wire [2:0] attrShift = _attrShift_T_1 | _GEN_349; // @[PPU.scala 228:38]
  wire [7:0] _paletteHigh_T = vram_attrByte_data >> attrShift; // @[PPU.scala 229:33]
  wire [7:0] paletteHigh = _paletteHigh_T & 8'h3; // @[PPU.scala 229:47]
  wire [12:0] patternTableBase = ppuCtrl[4] ? 13'h1000 : 13'h0; // @[PPU.scala 232:31]
  wire [11:0] _patternAddr_T = {vram_tileIndex_data, 4'h0}; // @[PPU.scala 233:53]
  wire [12:0] _GEN_350 = {{1'd0}, _patternAddr_T}; // @[PPU.scala 233:40]
  wire [12:0] _patternAddr_T_2 = patternTableBase + _GEN_350; // @[PPU.scala 233:40]
  wire [12:0] _GEN_351 = {{10'd0}, pixelInTileY}; // @[PPU.scala 233:59]
  wire [12:0] patternAddr = _patternAddr_T_2 + _GEN_351; // @[PPU.scala 233:59]
  wire [2:0] bitPos = 3'h7 - pixelInTileX; // @[PPU.scala 240:22]
  wire [7:0] _colorLow_T = chrROM_patternLow_data >> bitPos; // @[PPU.scala 241:32]
  wire [7:0] colorLow = _colorLow_T & 8'h1; // @[PPU.scala 241:43]
  wire [7:0] _colorHigh_T = chrROM_patternHigh_data >> bitPos; // @[PPU.scala 242:34]
  wire [7:0] colorHigh = _colorHigh_T & 8'h1; // @[PPU.scala 242:45]
  wire [8:0] _paletteLow_T = {colorHigh, 1'h0}; // @[PPU.scala 243:33]
  wire [8:0] _GEN_352 = {{1'd0}, colorLow}; // @[PPU.scala 243:39]
  wire [8:0] paletteLow = _paletteLow_T | _GEN_352; // @[PPU.scala 243:39]
  wire [9:0] _fullPaletteIndex_T = {paletteHigh, 2'h0}; // @[PPU.scala 246:41]
  wire [9:0] _GEN_353 = {{1'd0}, paletteLow}; // @[PPU.scala 246:47]
  wire [9:0] fullPaletteIndex = _fullPaletteIndex_T | _GEN_353; // @[PPU.scala 246:47]
  wire  _paletteAddr_T = paletteLow == 9'h0; // @[PPU.scala 249:38]
  wire [9:0] paletteAddr = paletteLow == 9'h0 ? 10'h0 : fullPaletteIndex; // @[PPU.scala 249:26]
  wire [5:0] _pixelColor_T_3 = paletteLow == 9'h2 ? 6'h10 : 6'h30; // @[PPU.scala 257:24]
  wire [5:0] _pixelColor_T_4 = paletteLow == 9'h1 ? 6'h0 : _pixelColor_T_3; // @[PPU.scala 256:24]
  wire [5:0] _pixelColor_T_5 = _paletteAddr_T ? 6'hf : _pixelColor_T_4; // @[PPU.scala 255:24]
  wire [5:0] _GEN_337 = _T ? _pixelColor_T_5 : palette_paletteColor_data[5:0]; // @[PPU.scala 253:28 255:18 260:18]
  assign vram_io_cpuDataOut_MPORT_2_en = io_cpuRead & _GEN_101;
  assign vram_io_cpuDataOut_MPORT_2_addr = ppuAddrReg[10:0];
  assign vram_io_cpuDataOut_MPORT_2_data = vram[vram_io_cpuDataOut_MPORT_2_addr]; // @[PPU.scala 61:17]
  assign vram_tileIndex_en = _T_30 & _T_31;
  assign vram_tileIndex_addr = _nametableAddr_T + _GEN_346;
  assign vram_tileIndex_data = vram[vram_tileIndex_addr]; // @[PPU.scala 61:17]
  assign vram_attrByte_en = _T_30 & _T_31;
  assign vram_attrByte_addr = {{1'd0}, attrAddr};
  assign vram_attrByte_data = vram[vram_attrByte_addr]; // @[PPU.scala 61:17]
  assign vram_MPORT_3_data = io_cpuDataIn;
  assign vram_MPORT_3_addr = ppuAddrReg[10:0];
  assign vram_MPORT_3_mask = 1'h1;
  assign vram_MPORT_3_en = io_cpuWrite & _GEN_297;
  assign oam_io_cpuDataOut_MPORT_en = io_cpuRead & _GEN_95;
  assign oam_io_cpuDataOut_MPORT_addr = oamAddr;
  assign oam_io_cpuDataOut_MPORT_data = oam[oam_io_cpuDataOut_MPORT_addr]; // @[PPU.scala 62:16]
  assign oam_MPORT_1_data = io_cpuDataIn;
  assign oam_MPORT_1_addr = oamAddr;
  assign oam_MPORT_1_mask = 1'h1;
  assign oam_MPORT_1_en = io_cpuWrite & _GEN_283;
  assign palette_io_cpuDataOut_MPORT_3_en = io_cpuRead & _GEN_104;
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
  assign palette_MPORT_4_en = io_cpuWrite & _GEN_302;
  assign chrROM_io_cpuDataOut_MPORT_1_en = io_cpuRead & _GEN_98;
  assign chrROM_io_cpuDataOut_MPORT_1_addr = ppuAddrReg[12:0];
  assign chrROM_io_cpuDataOut_MPORT_1_data = chrROM[chrROM_io_cpuDataOut_MPORT_1_addr]; // @[PPU.scala 64:19]
  assign chrROM_patternLow_en = _T_30 & _T_31;
  assign chrROM_patternLow_addr = _patternAddr_T_2 + _GEN_351;
  assign chrROM_patternLow_data = chrROM[chrROM_patternLow_addr]; // @[PPU.scala 64:19]
  assign chrROM_patternHigh_en = _T_30 & _T_31;
  assign chrROM_patternHigh_addr = patternAddr + 13'h8;
  assign chrROM_patternHigh_data = chrROM[chrROM_patternHigh_addr]; // @[PPU.scala 64:19]
  assign chrROM_MPORT_2_data = io_cpuDataIn;
  assign chrROM_MPORT_2_addr = ppuAddrReg[12:0];
  assign chrROM_MPORT_2_mask = 1'h1;
  assign chrROM_MPORT_2_en = io_cpuWrite & _GEN_292;
  assign chrROM_MPORT_5_data = io_chrLoadData;
  assign chrROM_MPORT_5_addr = io_chrLoadAddr;
  assign chrROM_MPORT_5_mask = 1'h1;
  assign chrROM_MPORT_5_en = io_chrLoadEn;
  assign io_cpuDataOut = io_cpuRead ? _GEN_90 : 8'h0; // @[PPU.scala 124:17 126:20]
  assign io_pixelX = renderX; // @[PPU.scala 265:13]
  assign io_pixelY = renderY; // @[PPU.scala 266:13]
  assign io_pixelColor = renderX < 9'h100 & renderY < 9'hf0 ? _GEN_337 : 6'hf; // @[PPU.scala 209:31 212:44]
  assign io_vblank = vblankFlag; // @[PPU.scala 268:13]
  assign io_nmiOut = nmiOccurred; // @[PPU.scala 269:13]
  assign io_debug_ppuCtrl = ppuCtrl; // @[PPU.scala 272:20]
  assign io_debug_ppuMask = ppuMask; // @[PPU.scala 273:20]
  assign io_debug_ppuStatus = {vblankFlag,7'h0}; // @[Cat.scala 33:92]
  assign io_debug_ppuAddrReg = ppuAddrReg; // @[PPU.scala 275:23]
  assign io_debug_paletteInitDone = paletteInitDone; // @[PPU.scala 276:28]
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
    end else if (io_cpuWrite) begin // @[PPU.scala 153:21]
      if (3'h0 == io_cpuAddr) begin // @[PPU.scala 154:24]
        ppuCtrl <= io_cpuDataIn; // @[PPU.scala 156:17]
      end
    end
    if (reset) begin // @[PPU.scala 52:24]
      ppuMask <= 8'h0; // @[PPU.scala 52:24]
    end else if (io_cpuWrite) begin // @[PPU.scala 153:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPU.scala 154:24]
        if (3'h1 == io_cpuAddr) begin // @[PPU.scala 154:24]
          ppuMask <= io_cpuDataIn; // @[PPU.scala 159:17]
        end
      end
    end
    if (reset) begin // @[PPU.scala 54:24]
      oamAddr <= 8'h0; // @[PPU.scala 54:24]
    end else if (io_cpuWrite) begin // @[PPU.scala 153:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPU.scala 154:24]
        if (!(3'h1 == io_cpuAddr)) begin // @[PPU.scala 154:24]
          oamAddr <= _GEN_227;
        end
      end
    end
    if (reset) begin // @[PPU.scala 57:29]
      ppuAddrLatch <= 1'h0; // @[PPU.scala 57:29]
    end else if (io_cpuWrite) begin // @[PPU.scala 153:21]
      if (3'h0 == io_cpuAddr) begin // @[PPU.scala 154:24]
        ppuAddrLatch <= _GEN_108;
      end else if (3'h1 == io_cpuAddr) begin // @[PPU.scala 154:24]
        ppuAddrLatch <= _GEN_108;
      end else begin
        ppuAddrLatch <= _GEN_235;
      end
    end else begin
      ppuAddrLatch <= _GEN_108;
    end
    if (reset) begin // @[PPU.scala 58:27]
      ppuAddrReg <= 16'h0; // @[PPU.scala 58:27]
    end else if (io_cpuWrite) begin // @[PPU.scala 153:21]
      if (3'h0 == io_cpuAddr) begin // @[PPU.scala 154:24]
        ppuAddrReg <= _GEN_121;
      end else if (3'h1 == io_cpuAddr) begin // @[PPU.scala 154:24]
        ppuAddrReg <= _GEN_121;
      end else begin
        ppuAddrReg <= _GEN_236;
      end
    end else begin
      ppuAddrReg <= _GEN_121;
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
    end else if (_T_3 & _T_5) begin // @[PPU.scala 118:50]
      nmiOccurred <= 1'h0; // @[PPU.scala 120:17]
    end else if (renderY == 9'hf1 & renderX == 9'h1) begin // @[PPU.scala 111:50]
      nmiOccurred <= _GEN_43;
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
