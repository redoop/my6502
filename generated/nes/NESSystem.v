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
  reg  resetReleased; // @[CPU6502Core.scala 52:30]
  wire  _T_4 = cycle == 3'h0; // @[CPU6502Core.scala 70:22]
  wire  _T_5 = cycle == 3'h1; // @[CPU6502Core.scala 75:28]
  wire  _T_6 = cycle == 3'h2; // @[CPU6502Core.scala 80:28]
  wire [15:0] resetVector = {io_memDataIn,operand[7:0]}; // @[Cat.scala 33:92]
  wire [1:0] _GEN_3 = cycle == 3'h2 ? 2'h3 : 2'h0; // @[CPU6502Core.scala 80:37 84:19 91:19]
  wire [15:0] _GEN_4 = cycle == 3'h2 ? regs_pc : resetVector; // @[CPU6502Core.scala 21:21 80:37 90:21]
  wire [2:0] _GEN_5 = cycle == 3'h2 ? state : 3'h1; // @[CPU6502Core.scala 25:22 80:37 92:19]
  wire [15:0] _GEN_6 = cycle == 3'h1 ? 16'hfffc : 16'hfffd; // @[CPU6502Core.scala 75:37 76:24]
  wire [15:0] _GEN_8 = cycle == 3'h1 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 75:37 78:21 28:24]
  wire [1:0] _GEN_9 = cycle == 3'h1 ? 2'h2 : _GEN_3; // @[CPU6502Core.scala 75:37 79:19]
  wire [15:0] _GEN_10 = cycle == 3'h1 ? regs_pc : _GEN_4; // @[CPU6502Core.scala 21:21 75:37]
  wire [2:0] _GEN_11 = cycle == 3'h1 ? state : _GEN_5; // @[CPU6502Core.scala 25:22 75:37]
  wire [15:0] _GEN_12 = cycle == 3'h0 ? 16'hfffc : _GEN_6; // @[CPU6502Core.scala 70:31 72:24]
  wire [1:0] _GEN_14 = cycle == 3'h0 ? 2'h1 : _GEN_9; // @[CPU6502Core.scala 70:31 74:19]
  wire [15:0] _GEN_15 = cycle == 3'h0 ? operand : _GEN_8; // @[CPU6502Core.scala 28:24 70:31]
  wire [15:0] _GEN_16 = cycle == 3'h0 ? regs_pc : _GEN_10; // @[CPU6502Core.scala 21:21 70:31]
  wire [2:0] _GEN_17 = cycle == 3'h0 ? state : _GEN_11; // @[CPU6502Core.scala 25:22 70:31]
  wire [15:0] _regs_pc_T_1 = regs_pc + 16'h1; // @[CPU6502Core.scala 106:32]
  wire  _GEN_18 = nmiEdge ? 1'h0 : _GEN_0; // @[CPU6502Core.scala 98:25 99:21]
  wire [2:0] _GEN_20 = nmiEdge ? 3'h3 : 3'h2; // @[CPU6502Core.scala 101:19 108:19 98:25]
  wire  _GEN_22 = nmiEdge ? 1'h0 : 1'h1; // @[CPU6502Core.scala 45:17 104:24 98:25]
  wire [7:0] _GEN_23 = nmiEdge ? opcode : io_memDataIn; // @[CPU6502Core.scala 105:20 27:24 98:25]
  wire [15:0] _GEN_24 = nmiEdge ? regs_pc : _regs_pc_T_1; // @[CPU6502Core.scala 106:21 21:21 98:25]
  wire  _execResult_T = 8'h18 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_1 = 8'h38 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_2 = 8'hd8 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_3 = 8'hf8 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_4 = 8'h58 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_5 = 8'h78 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_6 = 8'hb8 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _GEN_25 = _execResult_T_6 ? 1'h0 : regs_flagV; // @[Flag.scala 14:13 24:20 31:34]
  wire  _GEN_26 = _execResult_T_5 | regs_flagI; // @[Flag.scala 14:13 24:20 30:34]
  wire  _GEN_27 = _execResult_T_5 ? regs_flagV : _GEN_25; // @[Flag.scala 14:13 24:20]
  wire  _GEN_28 = _execResult_T_4 ? 1'h0 : _GEN_26; // @[Flag.scala 24:20 29:34]
  wire  _GEN_29 = _execResult_T_4 ? regs_flagV : _GEN_27; // @[Flag.scala 14:13 24:20]
  wire  _GEN_30 = _execResult_T_3 | regs_flagD; // @[Flag.scala 14:13 24:20 28:34]
  wire  _GEN_31 = _execResult_T_3 ? regs_flagI : _GEN_28; // @[Flag.scala 14:13 24:20]
  wire  _GEN_32 = _execResult_T_3 ? regs_flagV : _GEN_29; // @[Flag.scala 14:13 24:20]
  wire  _GEN_33 = _execResult_T_2 ? 1'h0 : _GEN_30; // @[Flag.scala 24:20 27:34]
  wire  _GEN_34 = _execResult_T_2 ? regs_flagI : _GEN_31; // @[Flag.scala 14:13 24:20]
  wire  _GEN_35 = _execResult_T_2 ? regs_flagV : _GEN_32; // @[Flag.scala 14:13 24:20]
  wire  _GEN_36 = _execResult_T_1 | regs_flagC; // @[Flag.scala 14:13 24:20 26:34]
  wire  _GEN_37 = _execResult_T_1 ? regs_flagD : _GEN_33; // @[Flag.scala 14:13 24:20]
  wire  _GEN_38 = _execResult_T_1 ? regs_flagI : _GEN_34; // @[Flag.scala 14:13 24:20]
  wire  _GEN_39 = _execResult_T_1 ? regs_flagV : _GEN_35; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagC = _execResult_T ? 1'h0 : _GEN_36; // @[Flag.scala 24:20 25:34]
  wire  execResult_result_newRegs_flagD = _execResult_T ? regs_flagD : _GEN_37; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagI = _execResult_T ? regs_flagI : _GEN_38; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagV = _execResult_T ? regs_flagV : _GEN_39; // @[Flag.scala 14:13 24:20]
  wire  _execResult_T_15 = 8'haa == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_16 = 8'ha8 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_17 = 8'h8a == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_18 = 8'h98 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_19 = 8'hba == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_20 = 8'h9a == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_result_newRegs_flagZ_T = regs_a == 8'h0; // @[Transfer.scala 28:33]
  wire [7:0] _GEN_44 = _execResult_T_20 ? regs_x : regs_sp; // @[Transfer.scala 14:13 24:20 51:20]
  wire [7:0] _GEN_45 = _execResult_T_19 ? regs_sp : regs_x; // @[Transfer.scala 14:13 24:20 46:19]
  wire  _GEN_46 = _execResult_T_19 ? regs_sp[7] : regs_flagN; // @[Transfer.scala 14:13 24:20 47:23]
  wire  _GEN_47 = _execResult_T_19 ? regs_sp == 8'h0 : regs_flagZ; // @[Transfer.scala 14:13 24:20 48:23]
  wire [7:0] _GEN_48 = _execResult_T_19 ? regs_sp : _GEN_44; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_49 = _execResult_T_18 ? regs_y : regs_a; // @[Transfer.scala 14:13 24:20 41:19]
  wire  _GEN_50 = _execResult_T_18 ? regs_y[7] : _GEN_46; // @[Transfer.scala 24:20 42:23]
  wire  _GEN_51 = _execResult_T_18 ? regs_y == 8'h0 : _GEN_47; // @[Transfer.scala 24:20 43:23]
  wire [7:0] _GEN_52 = _execResult_T_18 ? regs_x : _GEN_45; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_53 = _execResult_T_18 ? regs_sp : _GEN_48; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_54 = _execResult_T_17 ? regs_x : _GEN_49; // @[Transfer.scala 24:20 36:19]
  wire  _GEN_55 = _execResult_T_17 ? regs_x[7] : _GEN_50; // @[Transfer.scala 24:20 37:23]
  wire  _GEN_56 = _execResult_T_17 ? regs_x == 8'h0 : _GEN_51; // @[Transfer.scala 24:20 38:23]
  wire [7:0] _GEN_57 = _execResult_T_17 ? regs_x : _GEN_52; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_58 = _execResult_T_17 ? regs_sp : _GEN_53; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_59 = _execResult_T_16 ? regs_a : regs_y; // @[Transfer.scala 14:13 24:20 31:19]
  wire  _GEN_60 = _execResult_T_16 ? regs_a[7] : _GEN_55; // @[Transfer.scala 24:20 32:23]
  wire  _GEN_61 = _execResult_T_16 ? _execResult_result_newRegs_flagZ_T : _GEN_56; // @[Transfer.scala 24:20 33:23]
  wire [7:0] _GEN_62 = _execResult_T_16 ? regs_a : _GEN_54; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_63 = _execResult_T_16 ? regs_x : _GEN_57; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_64 = _execResult_T_16 ? regs_sp : _GEN_58; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_x = _execResult_T_15 ? regs_a : _GEN_63; // @[Transfer.scala 24:20 26:19]
  wire  execResult_result_newRegs_1_flagN = _execResult_T_15 ? regs_a[7] : _GEN_60; // @[Transfer.scala 24:20 27:23]
  wire  execResult_result_newRegs_1_flagZ = _execResult_T_15 ? regs_a == 8'h0 : _GEN_61; // @[Transfer.scala 24:20 28:23]
  wire [7:0] execResult_result_newRegs_1_y = _execResult_T_15 ? regs_y : _GEN_59; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_a = _execResult_T_15 ? regs_a : _GEN_62; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_sp = _execResult_T_15 ? regs_sp : _GEN_64; // @[Transfer.scala 14:13 24:20]
  wire  _execResult_T_26 = 8'he8 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_27 = 8'hc8 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_28 = 8'hca == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_29 = 8'h88 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_30 = 8'h1a == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_31 = 8'h3a == opcode; // @[CPU6502Core.scala 204:20]
  wire [7:0] execResult_result_res = regs_x + 8'h1; // @[Arithmetic.scala 34:26]
  wire [7:0] execResult_result_res_1 = regs_y + 8'h1; // @[Arithmetic.scala 40:26]
  wire [7:0] execResult_result_res_2 = regs_x - 8'h1; // @[Arithmetic.scala 46:26]
  wire [7:0] execResult_result_res_3 = regs_y - 8'h1; // @[Arithmetic.scala 52:26]
  wire [7:0] execResult_result_res_4 = regs_a + 8'h1; // @[Arithmetic.scala 58:26]
  wire [7:0] execResult_result_res_5 = regs_a - 8'h1; // @[Arithmetic.scala 64:26]
  wire [7:0] _GEN_71 = _execResult_T_31 ? execResult_result_res_5 : regs_a; // @[Arithmetic.scala 22:13 32:20 65:19]
  wire  _GEN_72 = _execResult_T_31 ? execResult_result_res_5[7] : regs_flagN; // @[Arithmetic.scala 22:13 32:20 66:23]
  wire  _GEN_73 = _execResult_T_31 ? execResult_result_res_5 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 22:13 32:20 67:23]
  wire [7:0] _GEN_74 = _execResult_T_30 ? execResult_result_res_4 : _GEN_71; // @[Arithmetic.scala 32:20 59:19]
  wire  _GEN_75 = _execResult_T_30 ? execResult_result_res_4[7] : _GEN_72; // @[Arithmetic.scala 32:20 60:23]
  wire  _GEN_76 = _execResult_T_30 ? execResult_result_res_4 == 8'h0 : _GEN_73; // @[Arithmetic.scala 32:20 61:23]
  wire [7:0] _GEN_77 = _execResult_T_29 ? execResult_result_res_3 : regs_y; // @[Arithmetic.scala 22:13 32:20 53:19]
  wire  _GEN_78 = _execResult_T_29 ? execResult_result_res_3[7] : _GEN_75; // @[Arithmetic.scala 32:20 54:23]
  wire  _GEN_79 = _execResult_T_29 ? execResult_result_res_3 == 8'h0 : _GEN_76; // @[Arithmetic.scala 32:20 55:23]
  wire [7:0] _GEN_80 = _execResult_T_29 ? regs_a : _GEN_74; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] _GEN_81 = _execResult_T_28 ? execResult_result_res_2 : regs_x; // @[Arithmetic.scala 22:13 32:20 47:19]
  wire  _GEN_82 = _execResult_T_28 ? execResult_result_res_2[7] : _GEN_78; // @[Arithmetic.scala 32:20 48:23]
  wire  _GEN_83 = _execResult_T_28 ? execResult_result_res_2 == 8'h0 : _GEN_79; // @[Arithmetic.scala 32:20 49:23]
  wire [7:0] _GEN_84 = _execResult_T_28 ? regs_y : _GEN_77; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] _GEN_85 = _execResult_T_28 ? regs_a : _GEN_80; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] _GEN_86 = _execResult_T_27 ? execResult_result_res_1 : _GEN_84; // @[Arithmetic.scala 32:20 41:19]
  wire  _GEN_87 = _execResult_T_27 ? execResult_result_res_1[7] : _GEN_82; // @[Arithmetic.scala 32:20 42:23]
  wire  _GEN_88 = _execResult_T_27 ? execResult_result_res_1 == 8'h0 : _GEN_83; // @[Arithmetic.scala 32:20 43:23]
  wire [7:0] _GEN_89 = _execResult_T_27 ? regs_x : _GEN_81; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] _GEN_90 = _execResult_T_27 ? regs_a : _GEN_85; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] execResult_result_newRegs_2_x = _execResult_T_26 ? execResult_result_res : _GEN_89; // @[Arithmetic.scala 32:20 35:19]
  wire  execResult_result_newRegs_2_flagN = _execResult_T_26 ? execResult_result_res[7] : _GEN_87; // @[Arithmetic.scala 32:20 36:23]
  wire  execResult_result_newRegs_2_flagZ = _execResult_T_26 ? execResult_result_res == 8'h0 : _GEN_88; // @[Arithmetic.scala 32:20 37:23]
  wire [7:0] execResult_result_newRegs_2_y = _execResult_T_26 ? regs_y : _GEN_86; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] execResult_result_newRegs_2_a = _execResult_T_26 ? regs_a : _GEN_90; // @[Arithmetic.scala 22:13 32:20]
  wire [8:0] _execResult_result_sum_T = regs_a + io_memDataIn; // @[Arithmetic.scala 81:22]
  wire [8:0] _GEN_1720 = {{8'd0}, regs_flagC}; // @[Arithmetic.scala 81:35]
  wire [9:0] execResult_result_sum = _execResult_result_sum_T + _GEN_1720; // @[Arithmetic.scala 81:35]
  wire [7:0] execResult_result_newRegs_3_a = execResult_result_sum[7:0]; // @[Arithmetic.scala 82:21]
  wire  execResult_result_newRegs_3_flagC = execResult_result_sum[8]; // @[Arithmetic.scala 83:25]
  wire  execResult_result_newRegs_3_flagN = execResult_result_sum[7]; // @[Arithmetic.scala 84:25]
  wire  execResult_result_newRegs_3_flagZ = execResult_result_newRegs_3_a == 8'h0; // @[Arithmetic.scala 85:32]
  wire  execResult_result_newRegs_3_flagV = regs_a[7] == io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_3_flagN; // @[Arithmetic.scala 86:51]
  wire [8:0] _execResult_result_diff_T = regs_a - io_memDataIn; // @[Arithmetic.scala 106:23]
  wire  _execResult_result_diff_T_2 = ~regs_flagC; // @[Arithmetic.scala 106:40]
  wire [8:0] _GEN_1721 = {{8'd0}, _execResult_result_diff_T_2}; // @[Arithmetic.scala 106:36]
  wire [9:0] execResult_result_diff = _execResult_result_diff_T - _GEN_1721; // @[Arithmetic.scala 106:36]
  wire [7:0] execResult_result_newRegs_4_a = execResult_result_diff[7:0]; // @[Arithmetic.scala 107:22]
  wire  execResult_result_newRegs_4_flagC = ~execResult_result_diff[8]; // @[Arithmetic.scala 108:22]
  wire  execResult_result_newRegs_4_flagN = execResult_result_diff[7]; // @[Arithmetic.scala 109:26]
  wire  execResult_result_newRegs_4_flagZ = execResult_result_newRegs_4_a == 8'h0; // @[Arithmetic.scala 110:33]
  wire  execResult_result_newRegs_4_flagV = regs_a[7] != io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_4_flagN; // @[Arithmetic.scala 111:51]
  wire [2:0] _execResult_result_result_nextCycle_T_1 = cycle + 3'h1; // @[Arithmetic.scala 132:31]
  wire  _execResult_result_T_20 = 3'h0 == cycle; // @[Arithmetic.scala 140:19]
  wire  _execResult_result_T_21 = 3'h1 == cycle; // @[Arithmetic.scala 140:19]
  wire  _execResult_result_T_22 = 3'h2 == cycle; // @[Arithmetic.scala 140:19]
  wire [7:0] _execResult_result_res_T_8 = io_memDataIn + 8'h1; // @[Arithmetic.scala 156:52]
  wire [7:0] _execResult_result_res_T_10 = io_memDataIn - 8'h1; // @[Arithmetic.scala 156:69]
  wire [7:0] execResult_result_res_6 = opcode == 8'he6 ? _execResult_result_res_T_8 : _execResult_result_res_T_10; // @[Arithmetic.scala 156:22]
  wire [15:0] _GEN_96 = 3'h2 == cycle ? operand : 16'h0; // @[Arithmetic.scala 140:19 134:20 155:24]
  wire [7:0] _GEN_97 = 3'h2 == cycle ? execResult_result_res_6 : 8'h0; // @[Arithmetic.scala 140:19 135:20 157:24]
  wire  _GEN_99 = 3'h2 == cycle ? execResult_result_res_6[7] : regs_flagN; // @[Arithmetic.scala 129:13 140:19 159:23]
  wire  _GEN_100 = 3'h2 == cycle ? execResult_result_res_6 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 129:13 140:19 160:23]
  wire [15:0] execResult_result_newRegs_5_pc = 3'h0 == cycle ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 129:13 140:19 145:20]
  wire  _GEN_119 = 3'h1 == cycle ? regs_flagZ : _GEN_100; // @[Arithmetic.scala 129:13 140:19]
  wire  execResult_result_newRegs_5_flagZ = 3'h0 == cycle ? regs_flagZ : _GEN_119; // @[Arithmetic.scala 129:13 140:19]
  wire  _GEN_118 = 3'h1 == cycle ? regs_flagN : _GEN_99; // @[Arithmetic.scala 129:13 140:19]
  wire  execResult_result_newRegs_5_flagN = 3'h0 == cycle ? regs_flagN : _GEN_118; // @[Arithmetic.scala 129:13 140:19]
  wire [15:0] _GEN_113 = 3'h1 == cycle ? operand : _GEN_96; // @[Arithmetic.scala 140:19 150:24]
  wire [2:0] _GEN_115 = 3'h1 == cycle ? 3'h2 : _execResult_result_result_nextCycle_T_1; // @[Arithmetic.scala 140:19 132:22 152:26]
  wire [7:0] _GEN_116 = 3'h1 == cycle ? 8'h0 : _GEN_97; // @[Arithmetic.scala 140:19 135:20]
  wire  _GEN_117 = 3'h1 == cycle ? 1'h0 : 3'h2 == cycle; // @[Arithmetic.scala 140:19 136:21]
  wire [15:0] execResult_result_result_6_memAddr = 3'h0 == cycle ? regs_pc : _GEN_113; // @[Arithmetic.scala 140:19 142:24]
  wire  execResult_result_result_6_memRead = 3'h0 == cycle | 3'h1 == cycle; // @[Arithmetic.scala 140:19 143:24]
  wire [15:0] execResult_result_result_6_operand = 3'h0 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Arithmetic.scala 140:19 138:20 144:24]
  wire [2:0] execResult_result_result_6_nextCycle = 3'h0 == cycle ? 3'h1 : _GEN_115; // @[Arithmetic.scala 140:19 147:26]
  wire [7:0] execResult_result_result_6_memData = 3'h0 == cycle ? 8'h0 : _GEN_116; // @[Arithmetic.scala 140:19 135:20]
  wire  execResult_result_result_6_done = 3'h0 == cycle ? 1'h0 : _GEN_117; // @[Arithmetic.scala 140:19 136:21]
  wire  _execResult_T_42 = 8'h29 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_43 = 8'h9 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_44 = 8'h49 == opcode; // @[CPU6502Core.scala 204:20]
  wire [7:0] _execResult_result_res_T_11 = regs_a & io_memDataIn; // @[Logic.scala 24:34]
  wire [7:0] _execResult_result_res_T_12 = regs_a | io_memDataIn; // @[Logic.scala 25:34]
  wire [7:0] _execResult_result_res_T_13 = regs_a ^ io_memDataIn; // @[Logic.scala 26:34]
  wire [7:0] _GEN_153 = _execResult_T_44 ? _execResult_result_res_T_13 : 8'h0; // @[Logic.scala 23:20 26:24 21:9]
  wire [7:0] _GEN_154 = _execResult_T_43 ? _execResult_result_res_T_12 : _GEN_153; // @[Logic.scala 23:20 25:24]
  wire [7:0] execResult_result_res_7 = _execResult_T_42 ? _execResult_result_res_T_11 : _GEN_154; // @[Logic.scala 23:20 24:24]
  wire  execResult_result_newRegs_6_flagN = execResult_result_res_7[7]; // @[Logic.scala 30:25]
  wire  execResult_result_newRegs_6_flagZ = execResult_result_res_7 == 8'h0; // @[Logic.scala 31:26]
  wire [15:0] _GEN_156 = _execResult_result_T_21 ? operand : 16'h0; // @[Logic.scala 60:19 54:20 70:24]
  wire  _GEN_158 = _execResult_result_T_21 ? _execResult_result_res_T_11 == 8'h0 : regs_flagZ; // @[Logic.scala 49:13 60:19 72:23]
  wire  _GEN_159 = _execResult_result_T_21 ? io_memDataIn[7] : regs_flagN; // @[Logic.scala 49:13 60:19 73:23]
  wire  _GEN_160 = _execResult_result_T_21 ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 49:13 60:19 74:23]
  wire  execResult_result_newRegs_7_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_158; // @[Logic.scala 49:13 60:19]
  wire  execResult_result_newRegs_7_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_160; // @[Logic.scala 49:13 60:19]
  wire  execResult_result_newRegs_7_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_159; // @[Logic.scala 49:13 60:19]
  wire [15:0] execResult_result_result_8_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_156; // @[Logic.scala 60:19 62:24]
  wire [2:0] execResult_result_result_8_nextCycle = _execResult_result_T_20 ? 3'h1 :
    _execResult_result_result_nextCycle_T_1; // @[Logic.scala 60:19 52:22 67:26]
  wire  execResult_result_result_8_done = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21; // @[Logic.scala 51:17 60:19]
  wire  _execResult_T_48 = 8'ha == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_49 = 8'h4a == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_50 = 8'h2a == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_51 = 8'h6a == opcode; // @[CPU6502Core.scala 204:20]
  wire [8:0] _execResult_result_res_T_14 = {regs_a, 1'h0}; // @[Shift.scala 35:24]
  wire [7:0] _execResult_result_res_T_18 = {regs_a[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_20 = {regs_flagC,regs_a[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_194 = _execResult_T_51 ? regs_a[0] : regs_flagC; // @[Shift.scala 18:13 32:20 46:23]
  wire [7:0] _GEN_195 = _execResult_T_51 ? _execResult_result_res_T_20 : regs_a; // @[Shift.scala 32:20 47:13 29:9]
  wire  _GEN_196 = _execResult_T_50 ? regs_a[7] : _GEN_194; // @[Shift.scala 32:20 42:23]
  wire [7:0] _GEN_197 = _execResult_T_50 ? _execResult_result_res_T_18 : _GEN_195; // @[Shift.scala 32:20 43:13]
  wire  _GEN_198 = _execResult_T_49 ? regs_a[0] : _GEN_196; // @[Shift.scala 32:20 38:23]
  wire [7:0] _GEN_199 = _execResult_T_49 ? {{1'd0}, regs_a[7:1]} : _GEN_197; // @[Shift.scala 32:20 39:13]
  wire  execResult_result_newRegs_8_flagC = _execResult_T_48 ? regs_a[7] : _GEN_198; // @[Shift.scala 32:20 34:23]
  wire [7:0] execResult_result_res_8 = _execResult_T_48 ? _execResult_result_res_T_14[7:0] : _GEN_199; // @[Shift.scala 32:20 35:13]
  wire  execResult_result_newRegs_8_flagN = execResult_result_res_8[7]; // @[Shift.scala 52:25]
  wire  execResult_result_newRegs_8_flagZ = execResult_result_res_8 == 8'h0; // @[Shift.scala 53:26]
  wire  _execResult_T_55 = 8'h6 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_56 = 8'h46 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_57 = 8'h26 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_58 = 8'h66 == opcode; // @[CPU6502Core.scala 204:20]
  wire [8:0] _execResult_result_res_T_21 = {io_memDataIn, 1'h0}; // @[Shift.scala 95:31]
  wire [7:0] _execResult_result_res_T_25 = {io_memDataIn[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_27 = {regs_flagC,io_memDataIn[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_202 = _execResult_T_58 ? io_memDataIn[0] : regs_flagC; // @[Shift.scala 92:24 108:27 62:13]
  wire [7:0] _GEN_203 = _execResult_T_58 ? _execResult_result_res_T_27 : 8'h0; // @[Shift.scala 109:17 90:13 92:24]
  wire  _GEN_204 = _execResult_T_57 ? io_memDataIn[7] : _GEN_202; // @[Shift.scala 92:24 103:27]
  wire [7:0] _GEN_205 = _execResult_T_57 ? _execResult_result_res_T_25 : _GEN_203; // @[Shift.scala 104:17 92:24]
  wire  _GEN_206 = _execResult_T_56 ? io_memDataIn[0] : _GEN_204; // @[Shift.scala 92:24 98:27]
  wire [7:0] _GEN_207 = _execResult_T_56 ? {{1'd0}, io_memDataIn[7:1]} : _GEN_205; // @[Shift.scala 92:24 99:17]
  wire  _GEN_208 = _execResult_T_55 ? io_memDataIn[7] : _GEN_206; // @[Shift.scala 92:24 94:27]
  wire [7:0] execResult_result_res_9 = _execResult_T_55 ? _execResult_result_res_T_21[7:0] : _GEN_207; // @[Shift.scala 92:24 95:17]
  wire  _GEN_211 = _execResult_result_T_22 ? _GEN_208 : regs_flagC; // @[Shift.scala 62:13 73:19]
  wire [7:0] _GEN_212 = _execResult_result_T_22 ? execResult_result_res_9 : 8'h0; // @[Shift.scala 73:19 113:24 68:20]
  wire  _GEN_214 = _execResult_result_T_22 ? execResult_result_res_9[7] : regs_flagN; // @[Shift.scala 73:19 115:23 62:13]
  wire  _GEN_215 = _execResult_result_T_22 ? execResult_result_res_9 == 8'h0 : regs_flagZ; // @[Shift.scala 73:19 116:23 62:13]
  wire  _GEN_231 = _execResult_result_T_21 ? regs_flagC : _GEN_211; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_9_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_231; // @[Shift.scala 62:13 73:19]
  wire  _GEN_235 = _execResult_result_T_21 ? regs_flagZ : _GEN_215; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_9_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_235; // @[Shift.scala 62:13 73:19]
  wire  _GEN_234 = _execResult_result_T_21 ? regs_flagN : _GEN_214; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_9_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_234; // @[Shift.scala 62:13 73:19]
  wire [7:0] _GEN_232 = _execResult_result_T_21 ? 8'h0 : _GEN_212; // @[Shift.scala 73:19 68:20]
  wire [7:0] execResult_result_result_10_memData = _execResult_result_T_20 ? 8'h0 : _GEN_232; // @[Shift.scala 73:19 68:20]
  wire  _execResult_T_62 = 8'hc9 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_63 = 8'he0 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_64 = 8'hc0 == opcode; // @[CPU6502Core.scala 204:20]
  wire [7:0] _GEN_270 = _execResult_T_64 ? regs_y : regs_a; // @[Compare.scala 21:14 23:20 26:29]
  wire [7:0] _GEN_271 = _execResult_T_63 ? regs_x : _GEN_270; // @[Compare.scala 23:20 25:29]
  wire [7:0] execResult_result_regValue = _execResult_T_62 ? regs_a : _GEN_271; // @[Compare.scala 23:20 24:29]
  wire [8:0] execResult_result_diff_1 = execResult_result_regValue - io_memDataIn; // @[Compare.scala 29:25]
  wire  execResult_result_newRegs_10_flagC = execResult_result_regValue >= io_memDataIn; // @[Compare.scala 30:31]
  wire  execResult_result_newRegs_10_flagZ = execResult_result_regValue == io_memDataIn; // @[Compare.scala 31:31]
  wire  execResult_result_newRegs_10_flagN = execResult_result_diff_1[7]; // @[Compare.scala 32:26]
  wire  _GEN_275 = _execResult_result_T_21 ? regs_a >= io_memDataIn : regs_flagC; // @[Compare.scala 50:13 61:19 74:23]
  wire  _GEN_276 = _execResult_result_T_21 ? regs_a == io_memDataIn : regs_flagZ; // @[Compare.scala 50:13 61:19 75:23]
  wire  _GEN_277 = _execResult_result_T_21 ? _execResult_result_diff_T[7] : regs_flagN; // @[Compare.scala 50:13 61:19 76:23]
  wire  execResult_result_newRegs_11_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_275; // @[Compare.scala 50:13 61:19]
  wire  execResult_result_newRegs_11_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_276; // @[Compare.scala 50:13 61:19]
  wire  execResult_result_newRegs_11_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_277; // @[Compare.scala 50:13 61:19]
  wire  _execResult_T_68 = 8'hf0 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_69 = 8'hd0 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_70 = 8'hb0 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_71 = 8'h90 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_72 = 8'h30 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_73 = 8'h10 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_74 = 8'h50 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_75 = 8'h70 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _GEN_311 = _execResult_T_74 & ~regs_flagV; // @[Branch.scala 18:16 20:20 28:31]
  wire  _GEN_312 = _execResult_T_75 ? regs_flagV : _GEN_311; // @[Branch.scala 20:20 27:31]
  wire  _GEN_313 = _execResult_T_73 ? ~regs_flagN : _GEN_312; // @[Branch.scala 20:20 26:31]
  wire  _GEN_314 = _execResult_T_72 ? regs_flagN : _GEN_313; // @[Branch.scala 20:20 25:31]
  wire  _GEN_315 = _execResult_T_71 ? _execResult_result_diff_T_2 : _GEN_314; // @[Branch.scala 20:20 24:31]
  wire  _GEN_316 = _execResult_T_70 ? regs_flagC : _GEN_315; // @[Branch.scala 20:20 23:31]
  wire  _GEN_317 = _execResult_T_69 ? ~regs_flagZ : _GEN_316; // @[Branch.scala 20:20 22:31]
  wire  execResult_result_takeBranch = _execResult_T_68 ? regs_flagZ : _GEN_317; // @[Branch.scala 20:20 21:31]
  wire [7:0] execResult_result_offset = io_memDataIn; // @[Branch.scala 32:28]
  wire [15:0] _GEN_1722 = {{8{execResult_result_offset[7]}},execResult_result_offset}; // @[Branch.scala 34:51]
  wire [15:0] _execResult_result_newRegs_pc_T_20 = $signed(regs_pc) + $signed(_GEN_1722); // @[Branch.scala 34:61]
  wire [15:0] execResult_result_newRegs_12_pc = execResult_result_takeBranch ? _execResult_result_newRegs_pc_T_20 :
    regs_pc; // @[Branch.scala 34:22]
  wire  _execResult_T_83 = 8'ha9 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_84 = 8'ha2 == opcode; // @[CPU6502Core.scala 204:20]
  wire  _execResult_T_85 = 8'ha0 == opcode; // @[CPU6502Core.scala 204:20]
  wire [7:0] _GEN_319 = _execResult_T_85 ? io_memDataIn : regs_y; // @[LoadStore.scala 23:13 25:20 28:30]
  wire [7:0] _GEN_320 = _execResult_T_84 ? io_memDataIn : regs_x; // @[LoadStore.scala 23:13 25:20 27:30]
  wire [7:0] _GEN_321 = _execResult_T_84 ? regs_y : _GEN_319; // @[LoadStore.scala 23:13 25:20]
  wire [7:0] execResult_result_newRegs_13_a = _execResult_T_83 ? io_memDataIn : regs_a; // @[LoadStore.scala 23:13 25:20 26:30]
  wire [7:0] execResult_result_newRegs_13_x = _execResult_T_83 ? regs_x : _GEN_320; // @[LoadStore.scala 23:13 25:20]
  wire [7:0] execResult_result_newRegs_13_y = _execResult_T_83 ? regs_y : _GEN_321; // @[LoadStore.scala 23:13 25:20]
  wire  execResult_result_newRegs_13_flagZ = io_memDataIn == 8'h0; // @[LoadStore.scala 32:32]
  wire  execResult_result_isLoad = opcode == 8'ha5; // @[LoadStore.scala 61:25]
  wire  execResult_result_isStoreA = opcode == 8'h85; // @[LoadStore.scala 62:27]
  wire  execResult_result_isStoreX = opcode == 8'h86; // @[LoadStore.scala 63:27]
  wire [7:0] _execResult_result_result_memData_T = execResult_result_isStoreX ? regs_x : regs_y; // @[LoadStore.scala 84:54]
  wire [7:0] _execResult_result_result_memData_T_1 = execResult_result_isStoreA ? regs_a :
    _execResult_result_result_memData_T; // @[LoadStore.scala 84:32]
  wire [7:0] _GEN_326 = execResult_result_isLoad ? io_memDataIn : regs_a; // @[LoadStore.scala 50:13 77:22 79:21]
  wire  _GEN_327 = execResult_result_isLoad ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 50:13 77:22 80:25]
  wire  _GEN_328 = execResult_result_isLoad ? execResult_result_newRegs_13_flagZ : regs_flagZ; // @[LoadStore.scala 50:13 77:22 81:25]
  wire  _GEN_329 = execResult_result_isLoad ? 1'h0 : 1'h1; // @[LoadStore.scala 57:21 77:22 83:27]
  wire [7:0] _GEN_330 = execResult_result_isLoad ? 8'h0 : _execResult_result_result_memData_T_1; // @[LoadStore.scala 56:20 77:22 84:26]
  wire  _GEN_332 = _execResult_result_T_21 & execResult_result_isLoad; // @[LoadStore.scala 66:19 58:20]
  wire [7:0] _GEN_333 = _execResult_result_T_21 ? _GEN_326 : regs_a; // @[LoadStore.scala 50:13 66:19]
  wire  _GEN_334 = _execResult_result_T_21 ? _GEN_327 : regs_flagN; // @[LoadStore.scala 50:13 66:19]
  wire  _GEN_335 = _execResult_result_T_21 ? _GEN_328 : regs_flagZ; // @[LoadStore.scala 50:13 66:19]
  wire [7:0] _GEN_337 = _execResult_result_T_21 ? _GEN_330 : 8'h0; // @[LoadStore.scala 66:19 56:20]
  wire [7:0] execResult_result_newRegs_14_a = _execResult_result_T_20 ? regs_a : _GEN_333; // @[LoadStore.scala 50:13 66:19]
  wire  execResult_result_newRegs_14_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_335; // @[LoadStore.scala 50:13 66:19]
  wire  execResult_result_newRegs_14_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_334; // @[LoadStore.scala 50:13 66:19]
  wire  execResult_result_result_15_memRead = _execResult_result_T_20 | _GEN_332; // @[LoadStore.scala 66:19 69:24]
  wire  execResult_result_result_15_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_329; // @[LoadStore.scala 66:19 57:21]
  wire [7:0] execResult_result_result_15_memData = _execResult_result_T_20 ? 8'h0 : _GEN_337; // @[LoadStore.scala 66:19 56:20]
  wire  execResult_result_isLoad_1 = opcode == 8'hb5; // @[LoadStore.scala 109:25]
  wire [7:0] _execResult_result_result_operand_T_1 = io_memDataIn + regs_x; // @[LoadStore.scala 115:38]
  wire [7:0] _GEN_375 = execResult_result_isLoad_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 122:22 124:21 98:13]
  wire  _GEN_376 = execResult_result_isLoad_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 122:22 125:25 98:13]
  wire  _GEN_377 = execResult_result_isLoad_1 ? execResult_result_newRegs_13_flagZ : regs_flagZ; // @[LoadStore.scala 122:22 126:25 98:13]
  wire  _GEN_378 = execResult_result_isLoad_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 105:21 122:22 128:27]
  wire [7:0] _GEN_379 = execResult_result_isLoad_1 ? 8'h0 : regs_a; // @[LoadStore.scala 104:20 122:22 129:26]
  wire  _GEN_381 = _execResult_result_T_21 & execResult_result_isLoad_1; // @[LoadStore.scala 111:19 106:20]
  wire [7:0] _GEN_382 = _execResult_result_T_21 ? _GEN_375 : regs_a; // @[LoadStore.scala 111:19 98:13]
  wire  _GEN_383 = _execResult_result_T_21 ? _GEN_376 : regs_flagN; // @[LoadStore.scala 111:19 98:13]
  wire  _GEN_384 = _execResult_result_T_21 ? _GEN_377 : regs_flagZ; // @[LoadStore.scala 111:19 98:13]
  wire [7:0] _GEN_386 = _execResult_result_T_21 ? _GEN_379 : 8'h0; // @[LoadStore.scala 111:19 104:20]
  wire [7:0] execResult_result_newRegs_15_a = _execResult_result_T_20 ? regs_a : _GEN_382; // @[LoadStore.scala 111:19 98:13]
  wire  execResult_result_newRegs_15_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_384; // @[LoadStore.scala 111:19 98:13]
  wire  execResult_result_newRegs_15_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_383; // @[LoadStore.scala 111:19 98:13]
  wire  execResult_result_result_16_memRead = _execResult_result_T_20 | _GEN_381; // @[LoadStore.scala 111:19 114:24]
  wire [15:0] execResult_result_result_16_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : operand; // @[LoadStore.scala 111:19 107:20 115:24]
  wire  execResult_result_result_16_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_378; // @[LoadStore.scala 111:19 105:21]
  wire [7:0] execResult_result_result_16_memData = _execResult_result_T_20 ? 8'h0 : _GEN_386; // @[LoadStore.scala 111:19 104:20]
  wire  execResult_result_isLoad_2 = opcode == 8'had; // @[LoadStore.scala 154:25]
  wire [7:0] _GEN_424 = execResult_result_isLoad_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 143:13 175:22 177:21]
  wire  _GEN_425 = execResult_result_isLoad_2 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 143:13 175:22 178:25]
  wire  _GEN_426 = execResult_result_isLoad_2 ? execResult_result_newRegs_13_flagZ : regs_flagZ; // @[LoadStore.scala 143:13 175:22 179:25]
  wire  _GEN_427 = execResult_result_isLoad_2 ? 1'h0 : 1'h1; // @[LoadStore.scala 150:21 175:22 181:27]
  wire [7:0] _GEN_428 = execResult_result_isLoad_2 ? 8'h0 : regs_a; // @[LoadStore.scala 149:20 175:22 182:26]
  wire  _GEN_430 = _execResult_result_T_22 & execResult_result_isLoad_2; // @[LoadStore.scala 156:19 151:20]
  wire [7:0] _GEN_431 = _execResult_result_T_22 ? _GEN_424 : regs_a; // @[LoadStore.scala 143:13 156:19]
  wire  _GEN_432 = _execResult_result_T_22 ? _GEN_425 : regs_flagN; // @[LoadStore.scala 143:13 156:19]
  wire  _GEN_433 = _execResult_result_T_22 ? _GEN_426 : regs_flagZ; // @[LoadStore.scala 143:13 156:19]
  wire [7:0] _GEN_435 = _execResult_result_T_22 ? _GEN_428 : 8'h0; // @[LoadStore.scala 156:19 149:20]
  wire [7:0] _GEN_466 = _execResult_result_T_21 ? regs_a : _GEN_431; // @[LoadStore.scala 143:13 156:19]
  wire [7:0] execResult_result_newRegs_16_a = _execResult_result_T_20 ? regs_a : _GEN_466; // @[LoadStore.scala 143:13 156:19]
  wire [15:0] _GEN_452 = _execResult_result_T_21 ? _regs_pc_T_1 : regs_pc; // @[LoadStore.scala 143:13 156:19 169:20]
  wire [15:0] execResult_result_newRegs_16_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_452; // @[LoadStore.scala 156:19 161:20]
  wire  _GEN_468 = _execResult_result_T_21 ? regs_flagZ : _GEN_433; // @[LoadStore.scala 143:13 156:19]
  wire  execResult_result_newRegs_16_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_468; // @[LoadStore.scala 143:13 156:19]
  wire  _GEN_467 = _execResult_result_T_21 ? regs_flagN : _GEN_432; // @[LoadStore.scala 143:13 156:19]
  wire  execResult_result_newRegs_16_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_467; // @[LoadStore.scala 143:13 156:19]
  wire [15:0] _GEN_449 = _execResult_result_T_21 ? regs_pc : _GEN_96; // @[LoadStore.scala 156:19 166:24]
  wire  _GEN_450 = _execResult_result_T_21 | _GEN_430; // @[LoadStore.scala 156:19 167:24]
  wire [15:0] _GEN_451 = _execResult_result_T_21 ? resetVector : operand; // @[LoadStore.scala 156:19 152:20 168:24]
  wire  _GEN_469 = _execResult_result_T_21 ? 1'h0 : _execResult_result_T_22 & _GEN_427; // @[LoadStore.scala 156:19 150:21]
  wire [7:0] _GEN_470 = _execResult_result_T_21 ? 8'h0 : _GEN_435; // @[LoadStore.scala 156:19 149:20]
  wire [15:0] execResult_result_result_17_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_449; // @[LoadStore.scala 156:19 158:24]
  wire  execResult_result_result_17_memRead = _execResult_result_T_20 | _GEN_450; // @[LoadStore.scala 156:19 159:24]
  wire [15:0] execResult_result_result_17_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_451; // @[LoadStore.scala 156:19 160:24]
  wire  execResult_result_result_17_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_469; // @[LoadStore.scala 156:19 150:21]
  wire [7:0] execResult_result_result_17_memData = _execResult_result_T_20 ? 8'h0 : _GEN_470; // @[LoadStore.scala 156:19 149:20]
  wire [7:0] execResult_result_indexReg = opcode == 8'hbd ? regs_x : regs_y; // @[LoadStore.scala 207:23]
  wire [15:0] _GEN_1723 = {{8'd0}, execResult_result_indexReg}; // @[LoadStore.scala 221:57]
  wire [15:0] _execResult_result_result_operand_T_8 = resetVector + _GEN_1723; // @[LoadStore.scala 221:57]
  wire [7:0] _GEN_497 = _execResult_result_T_22 ? io_memDataIn : regs_a; // @[LoadStore.scala 196:13 209:19 229:19]
  wire  _GEN_498 = _execResult_result_T_22 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 196:13 209:19 230:23]
  wire  _GEN_499 = _execResult_result_T_22 ? execResult_result_newRegs_13_flagZ : regs_flagZ; // @[LoadStore.scala 196:13 209:19 231:23]
  wire [7:0] _GEN_529 = _execResult_result_T_21 ? regs_a : _GEN_497; // @[LoadStore.scala 196:13 209:19]
  wire [7:0] execResult_result_newRegs_17_a = _execResult_result_T_20 ? regs_a : _GEN_529; // @[LoadStore.scala 196:13 209:19]
  wire  _GEN_531 = _execResult_result_T_21 ? regs_flagZ : _GEN_499; // @[LoadStore.scala 196:13 209:19]
  wire  execResult_result_newRegs_17_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_531; // @[LoadStore.scala 196:13 209:19]
  wire  _GEN_530 = _execResult_result_T_21 ? regs_flagN : _GEN_498; // @[LoadStore.scala 196:13 209:19]
  wire  execResult_result_newRegs_17_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_530; // @[LoadStore.scala 196:13 209:19]
  wire  _GEN_513 = _execResult_result_T_21 | _execResult_result_T_22; // @[LoadStore.scala 209:19 220:24]
  wire [15:0] _GEN_514 = _execResult_result_T_21 ? _execResult_result_result_operand_T_8 : operand; // @[LoadStore.scala 209:19 205:20 221:24]
  wire  execResult_result_result_18_memRead = _execResult_result_T_20 | _GEN_513; // @[LoadStore.scala 209:19 212:24]
  wire [15:0] execResult_result_result_18_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_514; // @[LoadStore.scala 209:19 213:24]
  wire [7:0] _execResult_result_pushData_T = {regs_flagN,regs_flagV,2'h3,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] execResult_result_pushData = opcode == 8'h8 ? _execResult_result_pushData_T : regs_a; // @[Stack.scala 21:14 23:29 24:16]
  wire [7:0] execResult_result_newRegs_18_sp = regs_sp - 8'h1; // @[Stack.scala 27:27]
  wire [15:0] execResult_result_result_19_memAddr = {8'h1,regs_sp}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_newRegs_sp_T_3 = regs_sp + 8'h1; // @[Stack.scala 57:31]
  wire [7:0] _GEN_555 = opcode == 8'h68 ? io_memDataIn : regs_a; // @[Stack.scala 44:13 65:33 66:21]
  wire  _GEN_556 = opcode == 8'h68 ? io_memDataIn[7] : io_memDataIn[7]; // @[Stack.scala 65:33 67:25 75:25]
  wire  _GEN_557 = opcode == 8'h68 ? execResult_result_newRegs_13_flagZ : io_memDataIn[1]; // @[Stack.scala 65:33 68:25 71:25]
  wire  _GEN_558 = opcode == 8'h68 ? regs_flagC : io_memDataIn[0]; // @[Stack.scala 44:13 65:33 70:25]
  wire  _GEN_559 = opcode == 8'h68 ? regs_flagI : io_memDataIn[2]; // @[Stack.scala 44:13 65:33 72:25]
  wire  _GEN_560 = opcode == 8'h68 ? regs_flagD : io_memDataIn[3]; // @[Stack.scala 44:13 65:33 73:25]
  wire  _GEN_561 = opcode == 8'h68 ? regs_flagV : io_memDataIn[6]; // @[Stack.scala 44:13 65:33 74:25]
  wire [15:0] _GEN_562 = _execResult_result_T_21 ? execResult_result_result_19_memAddr : 16'h0; // @[Stack.scala 55:19 49:20 62:24]
  wire [7:0] _GEN_564 = _execResult_result_T_21 ? _GEN_555 : regs_a; // @[Stack.scala 44:13 55:19]
  wire  _GEN_565 = _execResult_result_T_21 ? _GEN_556 : regs_flagN; // @[Stack.scala 44:13 55:19]
  wire  _GEN_566 = _execResult_result_T_21 ? _GEN_557 : regs_flagZ; // @[Stack.scala 44:13 55:19]
  wire  _GEN_567 = _execResult_result_T_21 ? _GEN_558 : regs_flagC; // @[Stack.scala 44:13 55:19]
  wire  _GEN_568 = _execResult_result_T_21 ? _GEN_559 : regs_flagI; // @[Stack.scala 44:13 55:19]
  wire  _GEN_569 = _execResult_result_T_21 ? _GEN_560 : regs_flagD; // @[Stack.scala 44:13 55:19]
  wire  _GEN_570 = _execResult_result_T_21 ? _GEN_561 : regs_flagV; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_19_a = _execResult_result_T_20 ? regs_a : _GEN_564; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_19_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Stack.scala 44:13 55:19 57:20]
  wire  execResult_result_newRegs_19_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_567; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_566; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_568; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_569; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_570; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_565; // @[Stack.scala 44:13 55:19]
  wire [15:0] execResult_result_result_20_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_562; // @[Stack.scala 55:19 49:20]
  wire [15:0] _GEN_606 = _execResult_result_T_21 ? regs_pc : 16'h0; // @[Jump.scala 26:19 20:20 36:24]
  wire [15:0] _GEN_608 = _execResult_result_T_21 ? resetVector : regs_pc; // @[Jump.scala 15:13 26:19 38:20]
  wire [15:0] execResult_result_newRegs_20_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_608; // @[Jump.scala 26:19 31:20]
  wire [15:0] execResult_result_result_21_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_606; // @[Jump.scala 26:19 28:24]
  wire  _execResult_result_T_74 = 3'h3 == cycle; // @[Jump.scala 62:19]
  wire [15:0] _GEN_639 = 3'h3 == cycle ? execResult_result_result_19_memAddr : 16'h0; // @[Jump.scala 62:19 56:20 86:24]
  wire [7:0] _GEN_640 = 3'h3 == cycle ? regs_pc[7:0] : 8'h0; // @[Jump.scala 62:19 57:20 87:24]
  wire [7:0] _GEN_642 = 3'h3 == cycle ? execResult_result_newRegs_18_sp : regs_sp; // @[Jump.scala 51:13 62:19 89:20]
  wire [15:0] _GEN_643 = 3'h3 == cycle ? operand : regs_pc; // @[Jump.scala 51:13 62:19 90:20]
  wire [7:0] _GEN_659 = _execResult_result_T_22 ? execResult_result_newRegs_18_sp : _GEN_642; // @[Jump.scala 62:19 81:20]
  wire [7:0] _GEN_681 = _execResult_result_T_21 ? regs_sp : _GEN_659; // @[Jump.scala 51:13 62:19]
  wire [7:0] execResult_result_newRegs_21_sp = _execResult_result_T_20 ? regs_sp : _GEN_681; // @[Jump.scala 51:13 62:19]
  wire [15:0] _GEN_673 = _execResult_result_T_22 ? regs_pc : _GEN_643; // @[Jump.scala 51:13 62:19]
  wire [15:0] _GEN_694 = _execResult_result_T_21 ? regs_pc : _GEN_673; // @[Jump.scala 51:13 62:19]
  wire [15:0] execResult_result_newRegs_21_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_694; // @[Jump.scala 62:19 67:20]
  wire [15:0] _GEN_656 = _execResult_result_T_22 ? execResult_result_result_19_memAddr : _GEN_639; // @[Jump.scala 62:19 78:24]
  wire [7:0] _GEN_657 = _execResult_result_T_22 ? regs_pc[15:8] : _GEN_640; // @[Jump.scala 62:19 79:24]
  wire  _GEN_658 = _execResult_result_T_22 | 3'h3 == cycle; // @[Jump.scala 62:19 80:25]
  wire [2:0] _GEN_672 = _execResult_result_T_22 ? 3'h3 : _execResult_result_result_nextCycle_T_1; // @[Jump.scala 62:19 54:22 83:26]
  wire  _GEN_674 = _execResult_result_T_22 ? 1'h0 : 3'h3 == cycle; // @[Jump.scala 53:17 62:19]
  wire [15:0] _GEN_675 = _execResult_result_T_21 ? regs_pc : _GEN_656; // @[Jump.scala 62:19 72:24]
  wire [2:0] _GEN_678 = _execResult_result_T_21 ? 3'h2 : _GEN_672; // @[Jump.scala 62:19 75:26]
  wire [7:0] _GEN_679 = _execResult_result_T_21 ? 8'h0 : _GEN_657; // @[Jump.scala 62:19 57:20]
  wire  _GEN_680 = _execResult_result_T_21 ? 1'h0 : _GEN_658; // @[Jump.scala 62:19 58:21]
  wire  _GEN_695 = _execResult_result_T_21 ? 1'h0 : _GEN_674; // @[Jump.scala 53:17 62:19]
  wire [15:0] execResult_result_result_22_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_675; // @[Jump.scala 62:19 64:24]
  wire [2:0] execResult_result_result_22_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_678; // @[Jump.scala 62:19 69:26]
  wire [7:0] execResult_result_result_22_memData = _execResult_result_T_20 ? 8'h0 : _GEN_679; // @[Jump.scala 62:19 57:20]
  wire  execResult_result_result_22_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_680; // @[Jump.scala 62:19 58:21]
  wire  execResult_result_result_22_done = _execResult_result_T_20 ? 1'h0 : _GEN_695; // @[Jump.scala 53:17 62:19]
  wire [15:0] _execResult_result_newRegs_pc_T_45 = resetVector + 16'h1; // @[Jump.scala 131:53]
  wire [15:0] _GEN_717 = _execResult_result_T_22 ? execResult_result_result_19_memAddr : 16'h0; // @[Jump.scala 114:19 108:20 129:24]
  wire [15:0] _GEN_719 = _execResult_result_T_22 ? _execResult_result_newRegs_pc_T_45 : regs_pc; // @[Jump.scala 103:13 114:19 131:20]
  wire [7:0] _GEN_735 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 103:13 114:19 124:20]
  wire [7:0] execResult_result_newRegs_22_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_735; // @[Jump.scala 114:19 116:20]
  wire [15:0] _GEN_749 = _execResult_result_T_21 ? regs_pc : _GEN_719; // @[Jump.scala 103:13 114:19]
  wire [15:0] execResult_result_newRegs_22_pc = _execResult_result_T_20 ? regs_pc : _GEN_749; // @[Jump.scala 103:13 114:19]
  wire [15:0] _GEN_732 = _execResult_result_T_21 ? execResult_result_result_19_memAddr : _GEN_717; // @[Jump.scala 114:19 121:24]
  wire [15:0] _GEN_734 = _execResult_result_T_21 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 114:19 112:20 123:24]
  wire [15:0] execResult_result_result_23_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_732; // @[Jump.scala 114:19 108:20]
  wire  execResult_result_result_23_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_513; // @[Jump.scala 114:19 111:20]
  wire [15:0] execResult_result_result_23_operand = _execResult_result_T_20 ? operand : _GEN_734; // @[Jump.scala 114:19 112:20]
  wire [15:0] _GEN_770 = 3'h5 == cycle ? 16'hffff : 16'h0; // @[Jump.scala 155:19 149:20 195:24]
  wire [15:0] _GEN_772 = 3'h5 == cycle ? resetVector : regs_pc; // @[Jump.scala 144:13 155:19 197:20]
  wire [7:0] _GEN_852 = _execResult_result_T_21 ? execResult_result_newRegs_18_sp : _GEN_659; // @[Jump.scala 155:19 165:20]
  wire [7:0] execResult_result_newRegs_23_sp = _execResult_result_T_20 ? regs_sp : _GEN_852; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_789 = 3'h4 == cycle ? regs_pc : _GEN_772; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_824 = _execResult_result_T_74 ? regs_pc : _GEN_789; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_847 = _execResult_result_T_22 ? regs_pc : _GEN_824; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_870 = _execResult_result_T_21 ? regs_pc : _GEN_847; // @[Jump.scala 144:13 155:19]
  wire [15:0] execResult_result_newRegs_23_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_870; // @[Jump.scala 155:19 157:20]
  wire  _GEN_807 = _execResult_result_T_74 | regs_flagI; // @[Jump.scala 144:13 155:19 183:23]
  wire  _GEN_843 = _execResult_result_T_22 ? regs_flagI : _GEN_807; // @[Jump.scala 144:13 155:19]
  wire  _GEN_866 = _execResult_result_T_21 ? regs_flagI : _GEN_843; // @[Jump.scala 144:13 155:19]
  wire  execResult_result_newRegs_23_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_866; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_785 = 3'h4 == cycle ? 16'hfffe : _GEN_770; // @[Jump.scala 155:19 189:24]
  wire  _GEN_786 = 3'h4 == cycle | 3'h5 == cycle; // @[Jump.scala 155:19 190:24]
  wire [15:0] _GEN_787 = 3'h4 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 155:19 153:20 191:24]
  wire [2:0] _GEN_788 = 3'h4 == cycle ? 3'h5 : _execResult_result_result_nextCycle_T_1; // @[Jump.scala 155:19 147:22 192:26]
  wire  _GEN_802 = 3'h4 == cycle ? 1'h0 : 3'h5 == cycle; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_803 = _execResult_result_T_74 ? execResult_result_result_19_memAddr : _GEN_785; // @[Jump.scala 155:19 179:24]
  wire [7:0] _GEN_804 = _execResult_result_T_74 ? _execResult_result_pushData_T : 8'h0; // @[Jump.scala 155:19 150:20 180:24]
  wire [2:0] _GEN_821 = _execResult_result_T_74 ? 3'h4 : _GEN_788; // @[Jump.scala 155:19 186:26]
  wire  _GEN_822 = _execResult_result_T_74 ? 1'h0 : _GEN_786; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_823 = _execResult_result_T_74 ? operand : _GEN_787; // @[Jump.scala 155:19 153:20]
  wire  _GEN_825 = _execResult_result_T_74 ? 1'h0 : _GEN_802; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_826 = _execResult_result_T_22 ? execResult_result_result_19_memAddr : _GEN_803; // @[Jump.scala 155:19 170:24]
  wire [7:0] _GEN_827 = _execResult_result_T_22 ? regs_pc[7:0] : _GEN_804; // @[Jump.scala 155:19 171:24]
  wire [2:0] _GEN_842 = _execResult_result_T_22 ? 3'h3 : _GEN_821; // @[Jump.scala 155:19 175:26]
  wire  _GEN_845 = _execResult_result_T_22 ? 1'h0 : _GEN_822; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_846 = _execResult_result_T_22 ? operand : _GEN_823; // @[Jump.scala 155:19 153:20]
  wire  _GEN_848 = _execResult_result_T_22 ? 1'h0 : _GEN_825; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_849 = _execResult_result_T_21 ? execResult_result_result_19_memAddr : _GEN_826; // @[Jump.scala 155:19 162:24]
  wire [7:0] _GEN_850 = _execResult_result_T_21 ? regs_pc[15:8] : _GEN_827; // @[Jump.scala 155:19 163:24]
  wire  _GEN_851 = _execResult_result_T_21 | _GEN_658; // @[Jump.scala 155:19 164:25]
  wire [2:0] _GEN_865 = _execResult_result_T_21 ? 3'h2 : _GEN_842; // @[Jump.scala 155:19 167:26]
  wire  _GEN_868 = _execResult_result_T_21 ? 1'h0 : _GEN_845; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_869 = _execResult_result_T_21 ? operand : _GEN_846; // @[Jump.scala 155:19 153:20]
  wire  _GEN_871 = _execResult_result_T_21 ? 1'h0 : _GEN_848; // @[Jump.scala 146:17 155:19]
  wire [2:0] execResult_result_result_24_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_865; // @[Jump.scala 155:19 159:26]
  wire [15:0] execResult_result_result_24_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_849; // @[Jump.scala 155:19 149:20]
  wire [7:0] execResult_result_result_24_memData = _execResult_result_T_20 ? 8'h0 : _GEN_850; // @[Jump.scala 155:19 150:20]
  wire  execResult_result_result_24_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_851; // @[Jump.scala 155:19 151:21]
  wire  execResult_result_result_24_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_868; // @[Jump.scala 155:19 152:20]
  wire [15:0] execResult_result_result_24_operand = _execResult_result_T_20 ? operand : _GEN_869; // @[Jump.scala 155:19 153:20]
  wire  execResult_result_result_24_done = _execResult_result_T_20 ? 1'h0 : _GEN_871; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_897 = _execResult_result_T_74 ? resetVector : regs_pc; // @[Jump.scala 210:13 221:19 251:20]
  wire [7:0] _GEN_913 = _execResult_result_T_22 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 210:13 221:19 244:20]
  wire [7:0] _GEN_937 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : _GEN_913; // @[Jump.scala 221:19 236:20]
  wire [7:0] execResult_result_newRegs_24_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_937; // @[Jump.scala 221:19 223:20]
  wire [15:0] _GEN_927 = _execResult_result_T_22 ? regs_pc : _GEN_897; // @[Jump.scala 210:13 221:19]
  wire [15:0] _GEN_952 = _execResult_result_T_21 ? regs_pc : _GEN_927; // @[Jump.scala 210:13 221:19]
  wire [15:0] execResult_result_newRegs_24_pc = _execResult_result_T_20 ? regs_pc : _GEN_952; // @[Jump.scala 210:13 221:19]
  wire  _GEN_931 = _execResult_result_T_21 ? io_memDataIn[0] : regs_flagC; // @[Jump.scala 210:13 221:19 230:23]
  wire  execResult_result_newRegs_24_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_931; // @[Jump.scala 210:13 221:19]
  wire  _GEN_932 = _execResult_result_T_21 ? io_memDataIn[1] : regs_flagZ; // @[Jump.scala 210:13 221:19 231:23]
  wire  execResult_result_newRegs_24_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_932; // @[Jump.scala 210:13 221:19]
  wire  _GEN_933 = _execResult_result_T_21 ? io_memDataIn[2] : regs_flagI; // @[Jump.scala 210:13 221:19 232:23]
  wire  execResult_result_newRegs_24_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_933; // @[Jump.scala 210:13 221:19]
  wire  _GEN_934 = _execResult_result_T_21 ? io_memDataIn[3] : regs_flagD; // @[Jump.scala 210:13 221:19 233:23]
  wire  execResult_result_newRegs_24_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_934; // @[Jump.scala 210:13 221:19]
  wire [15:0] _GEN_912 = _execResult_result_T_22 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 221:19 219:20 243:24]
  wire [15:0] _GEN_929 = _execResult_result_T_21 ? execResult_result_result_19_memAddr : _GEN_656; // @[Jump.scala 221:19 228:24]
  wire [15:0] _GEN_951 = _execResult_result_T_21 ? operand : _GEN_912; // @[Jump.scala 221:19 219:20]
  wire [15:0] execResult_result_result_25_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_929; // @[Jump.scala 221:19 215:20]
  wire [15:0] execResult_result_result_25_operand = _execResult_result_T_20 ? operand : _GEN_951; // @[Jump.scala 221:19 219:20]
  wire  _GEN_979 = 8'h40 == opcode & execResult_result_result_22_done; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire [2:0] _GEN_980 = 8'h40 == opcode ? execResult_result_result_22_nextCycle : 3'h0; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire [7:0] _GEN_984 = 8'h40 == opcode ? execResult_result_newRegs_24_sp : regs_sp; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire [15:0] _GEN_985 = 8'h40 == opcode ? execResult_result_newRegs_24_pc : regs_pc; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire  _GEN_986 = 8'h40 == opcode ? execResult_result_newRegs_24_flagC : regs_flagC; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire  _GEN_987 = 8'h40 == opcode ? execResult_result_newRegs_24_flagZ : regs_flagZ; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire  _GEN_988 = 8'h40 == opcode ? execResult_result_newRegs_24_flagI : regs_flagI; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire  _GEN_989 = 8'h40 == opcode ? execResult_result_newRegs_24_flagD : regs_flagD; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire  _GEN_991 = 8'h40 == opcode ? execResult_result_newRegs_7_flagV : regs_flagV; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire  _GEN_992 = 8'h40 == opcode ? execResult_result_newRegs_7_flagN : regs_flagN; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire [15:0] _GEN_993 = 8'h40 == opcode ? execResult_result_result_25_memAddr : 16'h0; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire  _GEN_996 = 8'h40 == opcode & execResult_result_result_24_memWrite; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire [15:0] _GEN_997 = 8'h40 == opcode ? execResult_result_result_25_operand : operand; // @[CPU6502Core.scala 202:12 204:20 304:27]
  wire  _GEN_998 = 8'h0 == opcode ? execResult_result_result_24_done : _GEN_979; // @[CPU6502Core.scala 204:20 303:27]
  wire [2:0] _GEN_999 = 8'h0 == opcode ? execResult_result_result_24_nextCycle : _GEN_980; // @[CPU6502Core.scala 204:20 303:27]
  wire [7:0] _GEN_1003 = 8'h0 == opcode ? execResult_result_newRegs_23_sp : _GEN_984; // @[CPU6502Core.scala 204:20 303:27]
  wire [15:0] _GEN_1004 = 8'h0 == opcode ? execResult_result_newRegs_23_pc : _GEN_985; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1005 = 8'h0 == opcode ? regs_flagC : _GEN_986; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1006 = 8'h0 == opcode ? regs_flagZ : _GEN_987; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1007 = 8'h0 == opcode ? execResult_result_newRegs_23_flagI : _GEN_988; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1008 = 8'h0 == opcode ? regs_flagD : _GEN_989; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1010 = 8'h0 == opcode ? regs_flagV : _GEN_991; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1011 = 8'h0 == opcode ? regs_flagN : _GEN_992; // @[CPU6502Core.scala 204:20 303:27]
  wire [15:0] _GEN_1012 = 8'h0 == opcode ? execResult_result_result_24_memAddr : _GEN_993; // @[CPU6502Core.scala 204:20 303:27]
  wire [7:0] _GEN_1013 = 8'h0 == opcode ? execResult_result_result_24_memData : 8'h0; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1014 = 8'h0 == opcode & execResult_result_result_24_memWrite; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1015 = 8'h0 == opcode ? execResult_result_result_24_memRead : _GEN_996; // @[CPU6502Core.scala 204:20 303:27]
  wire [15:0] _GEN_1016 = 8'h0 == opcode ? execResult_result_result_24_operand : _GEN_997; // @[CPU6502Core.scala 204:20 303:27]
  wire  _GEN_1017 = 8'h60 == opcode ? execResult_result_result_6_done : _GEN_998; // @[CPU6502Core.scala 204:20 302:27]
  wire [2:0] _GEN_1018 = 8'h60 == opcode ? execResult_result_result_6_nextCycle : _GEN_999; // @[CPU6502Core.scala 204:20 302:27]
  wire [7:0] _GEN_1022 = 8'h60 == opcode ? execResult_result_newRegs_22_sp : _GEN_1003; // @[CPU6502Core.scala 204:20 302:27]
  wire [15:0] _GEN_1023 = 8'h60 == opcode ? execResult_result_newRegs_22_pc : _GEN_1004; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1024 = 8'h60 == opcode ? regs_flagC : _GEN_1005; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1025 = 8'h60 == opcode ? regs_flagZ : _GEN_1006; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1026 = 8'h60 == opcode ? regs_flagI : _GEN_1007; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1027 = 8'h60 == opcode ? regs_flagD : _GEN_1008; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1029 = 8'h60 == opcode ? regs_flagV : _GEN_1010; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1030 = 8'h60 == opcode ? regs_flagN : _GEN_1011; // @[CPU6502Core.scala 204:20 302:27]
  wire [15:0] _GEN_1031 = 8'h60 == opcode ? execResult_result_result_23_memAddr : _GEN_1012; // @[CPU6502Core.scala 204:20 302:27]
  wire [7:0] _GEN_1032 = 8'h60 == opcode ? 8'h0 : _GEN_1013; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1033 = 8'h60 == opcode ? 1'h0 : _GEN_1014; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1034 = 8'h60 == opcode ? execResult_result_result_23_memRead : _GEN_1015; // @[CPU6502Core.scala 204:20 302:27]
  wire [15:0] _GEN_1035 = 8'h60 == opcode ? execResult_result_result_23_operand : _GEN_1016; // @[CPU6502Core.scala 204:20 302:27]
  wire  _GEN_1036 = 8'h20 == opcode ? execResult_result_result_22_done : _GEN_1017; // @[CPU6502Core.scala 204:20 301:27]
  wire [2:0] _GEN_1037 = 8'h20 == opcode ? execResult_result_result_22_nextCycle : _GEN_1018; // @[CPU6502Core.scala 204:20 301:27]
  wire [7:0] _GEN_1041 = 8'h20 == opcode ? execResult_result_newRegs_21_sp : _GEN_1022; // @[CPU6502Core.scala 204:20 301:27]
  wire [15:0] _GEN_1042 = 8'h20 == opcode ? execResult_result_newRegs_21_pc : _GEN_1023; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1043 = 8'h20 == opcode ? regs_flagC : _GEN_1024; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1044 = 8'h20 == opcode ? regs_flagZ : _GEN_1025; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1045 = 8'h20 == opcode ? regs_flagI : _GEN_1026; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1046 = 8'h20 == opcode ? regs_flagD : _GEN_1027; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1048 = 8'h20 == opcode ? regs_flagV : _GEN_1029; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1049 = 8'h20 == opcode ? regs_flagN : _GEN_1030; // @[CPU6502Core.scala 204:20 301:27]
  wire [15:0] _GEN_1050 = 8'h20 == opcode ? execResult_result_result_22_memAddr : _GEN_1031; // @[CPU6502Core.scala 204:20 301:27]
  wire [7:0] _GEN_1051 = 8'h20 == opcode ? execResult_result_result_22_memData : _GEN_1032; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1052 = 8'h20 == opcode ? execResult_result_result_22_memWrite : _GEN_1033; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1053 = 8'h20 == opcode ? execResult_result_result_6_memRead : _GEN_1034; // @[CPU6502Core.scala 204:20 301:27]
  wire [15:0] _GEN_1054 = 8'h20 == opcode ? execResult_result_result_17_operand : _GEN_1035; // @[CPU6502Core.scala 204:20 301:27]
  wire  _GEN_1055 = 8'h4c == opcode ? execResult_result_result_8_done : _GEN_1036; // @[CPU6502Core.scala 204:20 300:27]
  wire [2:0] _GEN_1056 = 8'h4c == opcode ? execResult_result_result_8_nextCycle : _GEN_1037; // @[CPU6502Core.scala 204:20 300:27]
  wire [7:0] _GEN_1060 = 8'h4c == opcode ? regs_sp : _GEN_1041; // @[CPU6502Core.scala 204:20 300:27]
  wire [15:0] _GEN_1061 = 8'h4c == opcode ? execResult_result_newRegs_20_pc : _GEN_1042; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1062 = 8'h4c == opcode ? regs_flagC : _GEN_1043; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1063 = 8'h4c == opcode ? regs_flagZ : _GEN_1044; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1064 = 8'h4c == opcode ? regs_flagI : _GEN_1045; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1065 = 8'h4c == opcode ? regs_flagD : _GEN_1046; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1067 = 8'h4c == opcode ? regs_flagV : _GEN_1048; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1068 = 8'h4c == opcode ? regs_flagN : _GEN_1049; // @[CPU6502Core.scala 204:20 300:27]
  wire [15:0] _GEN_1069 = 8'h4c == opcode ? execResult_result_result_21_memAddr : _GEN_1050; // @[CPU6502Core.scala 204:20 300:27]
  wire [7:0] _GEN_1070 = 8'h4c == opcode ? 8'h0 : _GEN_1051; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1071 = 8'h4c == opcode ? 1'h0 : _GEN_1052; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1072 = 8'h4c == opcode ? execResult_result_result_6_memRead : _GEN_1053; // @[CPU6502Core.scala 204:20 300:27]
  wire [15:0] _GEN_1073 = 8'h4c == opcode ? execResult_result_result_6_operand : _GEN_1054; // @[CPU6502Core.scala 204:20 300:27]
  wire  _GEN_1074 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_8_done : _GEN_1055; // @[CPU6502Core.scala 204:20 296:16]
  wire [2:0] _GEN_1075 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_8_nextCycle : _GEN_1056; // @[CPU6502Core.scala 204:20 296:16]
  wire [7:0] _GEN_1076 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_a : regs_a; // @[CPU6502Core.scala 204:20 296:16]
  wire [7:0] _GEN_1079 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_sp : _GEN_1060; // @[CPU6502Core.scala 204:20 296:16]
  wire [15:0] _GEN_1080 = 8'h68 == opcode | 8'h28 == opcode ? regs_pc : _GEN_1061; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1081 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagC : _GEN_1062; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1082 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagZ : _GEN_1063; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1083 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagI : _GEN_1064; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1084 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagD : _GEN_1065; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1086 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagV : _GEN_1067; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1087 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagN : _GEN_1068; // @[CPU6502Core.scala 204:20 296:16]
  wire [15:0] _GEN_1088 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_20_memAddr : _GEN_1069; // @[CPU6502Core.scala 204:20 296:16]
  wire [7:0] _GEN_1089 = 8'h68 == opcode | 8'h28 == opcode ? 8'h0 : _GEN_1070; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1090 = 8'h68 == opcode | 8'h28 == opcode ? 1'h0 : _GEN_1071; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1091 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_8_done : _GEN_1072; // @[CPU6502Core.scala 204:20 296:16]
  wire [15:0] _GEN_1092 = 8'h68 == opcode | 8'h28 == opcode ? 16'h0 : _GEN_1073; // @[CPU6502Core.scala 204:20 296:16]
  wire  _GEN_1093 = 8'h48 == opcode | 8'h8 == opcode | _GEN_1074; // @[CPU6502Core.scala 204:20 291:16]
  wire [2:0] _GEN_1094 = 8'h48 == opcode | 8'h8 == opcode ? 3'h0 : _GEN_1075; // @[CPU6502Core.scala 204:20 291:16]
  wire [7:0] _GEN_1095 = 8'h48 == opcode | 8'h8 == opcode ? regs_a : _GEN_1076; // @[CPU6502Core.scala 204:20 291:16]
  wire [7:0] _GEN_1098 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_newRegs_18_sp : _GEN_1079; // @[CPU6502Core.scala 204:20 291:16]
  wire [15:0] _GEN_1099 = 8'h48 == opcode | 8'h8 == opcode ? regs_pc : _GEN_1080; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1100 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagC : _GEN_1081; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1101 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagZ : _GEN_1082; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1102 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagI : _GEN_1083; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1103 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagD : _GEN_1084; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1105 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagV : _GEN_1086; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1106 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagN : _GEN_1087; // @[CPU6502Core.scala 204:20 291:16]
  wire [15:0] _GEN_1107 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_result_19_memAddr : _GEN_1088; // @[CPU6502Core.scala 204:20 291:16]
  wire [7:0] _GEN_1108 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_pushData : _GEN_1089; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1109 = 8'h48 == opcode | 8'h8 == opcode | _GEN_1090; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1110 = 8'h48 == opcode | 8'h8 == opcode ? 1'h0 : _GEN_1091; // @[CPU6502Core.scala 204:20 291:16]
  wire [15:0] _GEN_1111 = 8'h48 == opcode | 8'h8 == opcode ? 16'h0 : _GEN_1092; // @[CPU6502Core.scala 204:20 291:16]
  wire  _GEN_1112 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_6_done : _GEN_1093; // @[CPU6502Core.scala 204:20 286:16]
  wire [2:0] _GEN_1113 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_6_nextCycle : _GEN_1094; // @[CPU6502Core.scala 204:20 286:16]
  wire [7:0] _GEN_1114 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_newRegs_17_a : _GEN_1095; // @[CPU6502Core.scala 204:20 286:16]
  wire [7:0] _GEN_1117 = 8'hbd == opcode | 8'hb9 == opcode ? regs_sp : _GEN_1098; // @[CPU6502Core.scala 204:20 286:16]
  wire [15:0] _GEN_1118 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_newRegs_16_pc : _GEN_1099; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1119 = 8'hbd == opcode | 8'hb9 == opcode ? regs_flagC : _GEN_1100; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1120 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_1101; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1121 = 8'hbd == opcode | 8'hb9 == opcode ? regs_flagI : _GEN_1102; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1122 = 8'hbd == opcode | 8'hb9 == opcode ? regs_flagD : _GEN_1103; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1124 = 8'hbd == opcode | 8'hb9 == opcode ? regs_flagV : _GEN_1105; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1125 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_newRegs_17_flagN : _GEN_1106; // @[CPU6502Core.scala 204:20 286:16]
  wire [15:0] _GEN_1126 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_17_memAddr : _GEN_1107; // @[CPU6502Core.scala 204:20 286:16]
  wire [7:0] _GEN_1127 = 8'hbd == opcode | 8'hb9 == opcode ? 8'h0 : _GEN_1108; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1128 = 8'hbd == opcode | 8'hb9 == opcode ? 1'h0 : _GEN_1109; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1129 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_18_memRead : _GEN_1110; // @[CPU6502Core.scala 204:20 286:16]
  wire [15:0] _GEN_1130 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_18_operand : _GEN_1111; // @[CPU6502Core.scala 204:20 286:16]
  wire  _GEN_1131 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_6_done : _GEN_1112; // @[CPU6502Core.scala 204:20 281:16]
  wire [2:0] _GEN_1132 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_6_nextCycle : _GEN_1113; // @[CPU6502Core.scala 204:20 281:16]
  wire [7:0] _GEN_1133 = 8'had == opcode | 8'h8d == opcode ? execResult_result_newRegs_16_a : _GEN_1114; // @[CPU6502Core.scala 204:20 281:16]
  wire [7:0] _GEN_1136 = 8'had == opcode | 8'h8d == opcode ? regs_sp : _GEN_1117; // @[CPU6502Core.scala 204:20 281:16]
  wire [15:0] _GEN_1137 = 8'had == opcode | 8'h8d == opcode ? execResult_result_newRegs_16_pc : _GEN_1118; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1138 = 8'had == opcode | 8'h8d == opcode ? regs_flagC : _GEN_1119; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1139 = 8'had == opcode | 8'h8d == opcode ? execResult_result_newRegs_16_flagZ : _GEN_1120; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1140 = 8'had == opcode | 8'h8d == opcode ? regs_flagI : _GEN_1121; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1141 = 8'had == opcode | 8'h8d == opcode ? regs_flagD : _GEN_1122; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1143 = 8'had == opcode | 8'h8d == opcode ? regs_flagV : _GEN_1124; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1144 = 8'had == opcode | 8'h8d == opcode ? execResult_result_newRegs_16_flagN : _GEN_1125; // @[CPU6502Core.scala 204:20 281:16]
  wire [15:0] _GEN_1145 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_memAddr : _GEN_1126; // @[CPU6502Core.scala 204:20 281:16]
  wire [7:0] _GEN_1146 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_memData : _GEN_1127; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1147 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_memWrite : _GEN_1128; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1148 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_memRead : _GEN_1129; // @[CPU6502Core.scala 204:20 281:16]
  wire [15:0] _GEN_1149 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_operand : _GEN_1130; // @[CPU6502Core.scala 204:20 281:16]
  wire  _GEN_1150 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_8_done : _GEN_1131; // @[CPU6502Core.scala 204:20 276:16]
  wire [2:0] _GEN_1151 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_8_nextCycle : _GEN_1132; // @[CPU6502Core.scala 204:20 276:16]
  wire [7:0] _GEN_1152 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_newRegs_15_a : _GEN_1133; // @[CPU6502Core.scala 204:20 276:16]
  wire [7:0] _GEN_1155 = 8'hb5 == opcode | 8'h95 == opcode ? regs_sp : _GEN_1136; // @[CPU6502Core.scala 204:20 276:16]
  wire [15:0] _GEN_1156 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_newRegs_5_pc : _GEN_1137; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1157 = 8'hb5 == opcode | 8'h95 == opcode ? regs_flagC : _GEN_1138; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1158 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_newRegs_15_flagZ : _GEN_1139; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1159 = 8'hb5 == opcode | 8'h95 == opcode ? regs_flagI : _GEN_1140; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1160 = 8'hb5 == opcode | 8'h95 == opcode ? regs_flagD : _GEN_1141; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1162 = 8'hb5 == opcode | 8'h95 == opcode ? regs_flagV : _GEN_1143; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1163 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_newRegs_15_flagN : _GEN_1144; // @[CPU6502Core.scala 204:20 276:16]
  wire [15:0] _GEN_1164 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_8_memAddr : _GEN_1145; // @[CPU6502Core.scala 204:20 276:16]
  wire [7:0] _GEN_1165 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_16_memData : _GEN_1146; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1166 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_16_memWrite : _GEN_1147; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1167 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_16_memRead : _GEN_1148; // @[CPU6502Core.scala 204:20 276:16]
  wire [15:0] _GEN_1168 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_16_operand : _GEN_1149; // @[CPU6502Core.scala 204:20 276:16]
  wire  _GEN_1169 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_8_done : _GEN_1150; // @[CPU6502Core.scala 204:20 271:16]
  wire [2:0] _GEN_1170 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_8_nextCycle : _GEN_1151; // @[CPU6502Core.scala 204:20 271:16]
  wire [7:0] _GEN_1171 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_newRegs_14_a : _GEN_1152; // @[CPU6502Core.scala 204:20 271:16]
  wire [7:0] _GEN_1174 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_sp : _GEN_1155; // @[CPU6502Core.scala 204:20 271:16]
  wire [15:0] _GEN_1175 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_1156; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1176 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_flagC : _GEN_1157; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1177 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_newRegs_14_flagZ : _GEN_1158; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1178 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_flagI : _GEN_1159; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1179 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_flagD : _GEN_1160; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1181 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_flagV : _GEN_1162; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1182 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_newRegs_14_flagN : _GEN_1163; // @[CPU6502Core.scala 204:20 271:16]
  wire [15:0] _GEN_1183 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_8_memAddr : _GEN_1164; // @[CPU6502Core.scala 204:20 271:16]
  wire [7:0] _GEN_1184 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_15_memData : _GEN_1165; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1185 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_15_memWrite : _GEN_1166; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1186 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_15_memRead : _GEN_1167; // @[CPU6502Core.scala 204:20 271:16]
  wire [15:0] _GEN_1187 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_6_operand : _GEN_1168; // @[CPU6502Core.scala 204:20 271:16]
  wire  _GEN_1188 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_1169; // @[CPU6502Core.scala 204:20 266:16]
  wire [2:0] _GEN_1189 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 3'h0 : _GEN_1170; // @[CPU6502Core.scala 204:20 266:16]
  wire [7:0] _GEN_1190 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_13_a :
    _GEN_1171; // @[CPU6502Core.scala 204:20 266:16]
  wire [7:0] _GEN_1191 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_13_x : regs_x; // @[CPU6502Core.scala 204:20 266:16]
  wire [7:0] _GEN_1192 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_13_y : regs_y; // @[CPU6502Core.scala 204:20 266:16]
  wire [7:0] _GEN_1193 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_sp : _GEN_1174; // @[CPU6502Core.scala 204:20 266:16]
  wire [15:0] _GEN_1194 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? _regs_pc_T_1 : _GEN_1175; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1195 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagC : _GEN_1176; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1196 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_13_flagZ : _GEN_1177
    ; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1197 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagI : _GEN_1178; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1198 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagD : _GEN_1179; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1200 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagV : _GEN_1181; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1201 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? io_memDataIn[7] : _GEN_1182; // @[CPU6502Core.scala 204:20 266:16]
  wire [15:0] _GEN_1202 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_pc : _GEN_1183; // @[CPU6502Core.scala 204:20 266:16]
  wire [7:0] _GEN_1203 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 8'h0 : _GEN_1184; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1204 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 1'h0 : _GEN_1185; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1205 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_1186; // @[CPU6502Core.scala 204:20 266:16]
  wire [15:0] _GEN_1206 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 16'h0 : _GEN_1187; // @[CPU6502Core.scala 204:20 266:16]
  wire  _GEN_1207 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_1188; // @[CPU6502Core.scala 204:20 261:16]
  wire [2:0] _GEN_1208 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 3'h0 : _GEN_1189; // @[CPU6502Core.scala 204:20 261:16]
  wire [7:0] _GEN_1209 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_a : _GEN_1190; // @[CPU6502Core.scala 204:20 261:16]
  wire [7:0] _GEN_1210 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_x : _GEN_1191; // @[CPU6502Core.scala 204:20 261:16]
  wire [7:0] _GEN_1211 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_y : _GEN_1192; // @[CPU6502Core.scala 204:20 261:16]
  wire [7:0] _GEN_1212 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_sp : _GEN_1193; // @[CPU6502Core.scala 204:20 261:16]
  wire [15:0] _GEN_1213 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? execResult_result_newRegs_12_pc : _GEN_1194; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1214 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagC : _GEN_1195; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1215 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagZ : _GEN_1196; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1216 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagI : _GEN_1197; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1217 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagD : _GEN_1198; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1219 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagV : _GEN_1200; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1220 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagN : _GEN_1201; // @[CPU6502Core.scala 204:20 261:16]
  wire [15:0] _GEN_1221 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_pc : _GEN_1202; // @[CPU6502Core.scala 204:20 261:16]
  wire [7:0] _GEN_1222 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 8'h0 : _GEN_1203; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1223 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? 1'h0 : _GEN_1204; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1224 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_1205; // @[CPU6502Core.scala 204:20 261:16]
  wire [15:0] _GEN_1225 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 16'h0 : _GEN_1206; // @[CPU6502Core.scala 204:20 261:16]
  wire  _GEN_1226 = 8'hc5 == opcode ? execResult_result_result_8_done : _GEN_1207; // @[CPU6502Core.scala 204:20 256:16]
  wire [2:0] _GEN_1227 = 8'hc5 == opcode ? execResult_result_result_8_nextCycle : _GEN_1208; // @[CPU6502Core.scala 204:20 256:16]
  wire [7:0] _GEN_1228 = 8'hc5 == opcode ? regs_a : _GEN_1209; // @[CPU6502Core.scala 204:20 256:16]
  wire [7:0] _GEN_1229 = 8'hc5 == opcode ? regs_x : _GEN_1210; // @[CPU6502Core.scala 204:20 256:16]
  wire [7:0] _GEN_1230 = 8'hc5 == opcode ? regs_y : _GEN_1211; // @[CPU6502Core.scala 204:20 256:16]
  wire [7:0] _GEN_1231 = 8'hc5 == opcode ? regs_sp : _GEN_1212; // @[CPU6502Core.scala 204:20 256:16]
  wire [15:0] _GEN_1232 = 8'hc5 == opcode ? execResult_result_newRegs_5_pc : _GEN_1213; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1233 = 8'hc5 == opcode ? execResult_result_newRegs_11_flagC : _GEN_1214; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1234 = 8'hc5 == opcode ? execResult_result_newRegs_11_flagZ : _GEN_1215; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1235 = 8'hc5 == opcode ? regs_flagI : _GEN_1216; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1236 = 8'hc5 == opcode ? regs_flagD : _GEN_1217; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1238 = 8'hc5 == opcode ? regs_flagV : _GEN_1219; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1239 = 8'hc5 == opcode ? execResult_result_newRegs_11_flagN : _GEN_1220; // @[CPU6502Core.scala 204:20 256:16]
  wire [15:0] _GEN_1240 = 8'hc5 == opcode ? execResult_result_result_8_memAddr : _GEN_1221; // @[CPU6502Core.scala 204:20 256:16]
  wire [7:0] _GEN_1241 = 8'hc5 == opcode ? 8'h0 : _GEN_1222; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1242 = 8'hc5 == opcode ? 1'h0 : _GEN_1223; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1243 = 8'hc5 == opcode ? execResult_result_result_6_memRead : _GEN_1224; // @[CPU6502Core.scala 204:20 256:16]
  wire [15:0] _GEN_1244 = 8'hc5 == opcode ? execResult_result_result_6_operand : _GEN_1225; // @[CPU6502Core.scala 204:20 256:16]
  wire  _GEN_1245 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_1226; // @[CPU6502Core.scala 204:20 251:16]
  wire [2:0] _GEN_1246 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 3'h0 : _GEN_1227; // @[CPU6502Core.scala 204:20 251:16]
  wire [7:0] _GEN_1247 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_a : _GEN_1228; // @[CPU6502Core.scala 204:20 251:16]
  wire [7:0] _GEN_1248 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_x : _GEN_1229; // @[CPU6502Core.scala 204:20 251:16]
  wire [7:0] _GEN_1249 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_y : _GEN_1230; // @[CPU6502Core.scala 204:20 251:16]
  wire [7:0] _GEN_1250 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_sp : _GEN_1231; // @[CPU6502Core.scala 204:20 251:16]
  wire [15:0] _GEN_1251 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? _regs_pc_T_1 : _GEN_1232; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1252 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_10_flagC : _GEN_1233
    ; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1253 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_10_flagZ : _GEN_1234
    ; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1254 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagI : _GEN_1235; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1255 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagD : _GEN_1236; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1257 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagV : _GEN_1238; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1258 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_10_flagN : _GEN_1239
    ; // @[CPU6502Core.scala 204:20 251:16]
  wire [15:0] _GEN_1259 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_pc : _GEN_1240; // @[CPU6502Core.scala 204:20 251:16]
  wire [7:0] _GEN_1260 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 8'h0 : _GEN_1241; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1261 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 1'h0 : _GEN_1242; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1262 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_1243; // @[CPU6502Core.scala 204:20 251:16]
  wire [15:0] _GEN_1263 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 16'h0 : _GEN_1244; // @[CPU6502Core.scala 204:20 251:16]
  wire  _GEN_1264 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_done : _GEN_1245; // @[CPU6502Core.scala 204:20 246:16]
  wire [2:0] _GEN_1265 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_nextCycle : _GEN_1246; // @[CPU6502Core.scala 204:20 246:16]
  wire [7:0] _GEN_1266 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_a : _GEN_1247; // @[CPU6502Core.scala 204:20 246:16]
  wire [7:0] _GEN_1267 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_x : _GEN_1248; // @[CPU6502Core.scala 204:20 246:16]
  wire [7:0] _GEN_1268 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_y : _GEN_1249; // @[CPU6502Core.scala 204:20 246:16]
  wire [7:0] _GEN_1269 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_sp : _GEN_1250; // @[CPU6502Core.scala 204:20 246:16]
  wire [15:0] _GEN_1270 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_1251; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1271 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_9_flagC : _GEN_1252; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1272 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_9_flagZ : _GEN_1253; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1273 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagI : _GEN_1254; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1274 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagD : _GEN_1255; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1276 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagV : _GEN_1257; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1277 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_9_flagN : _GEN_1258; // @[CPU6502Core.scala 204:20 246:16]
  wire [15:0] _GEN_1278 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memAddr : _GEN_1259; // @[CPU6502Core.scala 204:20 246:16]
  wire [7:0] _GEN_1279 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_10_memData : _GEN_1260; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1280 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_done : _GEN_1261; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1281 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memRead : _GEN_1262; // @[CPU6502Core.scala 204:20 246:16]
  wire [15:0] _GEN_1282 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_operand : _GEN_1263; // @[CPU6502Core.scala 204:20 246:16]
  wire  _GEN_1283 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode | _GEN_1264; // @[CPU6502Core.scala 204:20 241:16]
  wire [2:0] _GEN_1284 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 3'h0 : _GEN_1265; // @[CPU6502Core.scala 204:20 241:16]
  wire [7:0] _GEN_1285 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? execResult_result_res_8
     : _GEN_1266; // @[CPU6502Core.scala 204:20 241:16]
  wire [7:0] _GEN_1286 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_x : _GEN_1267; // @[CPU6502Core.scala 204:20 241:16]
  wire [7:0] _GEN_1287 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_y : _GEN_1268; // @[CPU6502Core.scala 204:20 241:16]
  wire [7:0] _GEN_1288 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_sp : _GEN_1269; // @[CPU6502Core.scala 204:20 241:16]
  wire [15:0] _GEN_1289 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_pc : _GEN_1270; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1290 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_8_flagC : _GEN_1271; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1291 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_8_flagZ : _GEN_1272; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1292 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagI : _GEN_1273; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1293 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagD : _GEN_1274; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1295 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagV : _GEN_1276; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1296 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_8_flagN : _GEN_1277; // @[CPU6502Core.scala 204:20 241:16]
  wire [15:0] _GEN_1297 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_1278; // @[CPU6502Core.scala 204:20 241:16]
  wire [7:0] _GEN_1298 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 8'h0 : _GEN_1279; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1299 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_1280; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1300 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_1281; // @[CPU6502Core.scala 204:20 241:16]
  wire [15:0] _GEN_1301 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_1282; // @[CPU6502Core.scala 204:20 241:16]
  wire  _GEN_1302 = 8'h24 == opcode ? execResult_result_result_8_done : _GEN_1283; // @[CPU6502Core.scala 204:20 236:16]
  wire [2:0] _GEN_1303 = 8'h24 == opcode ? execResult_result_result_8_nextCycle : _GEN_1284; // @[CPU6502Core.scala 204:20 236:16]
  wire [7:0] _GEN_1304 = 8'h24 == opcode ? regs_a : _GEN_1285; // @[CPU6502Core.scala 204:20 236:16]
  wire [7:0] _GEN_1305 = 8'h24 == opcode ? regs_x : _GEN_1286; // @[CPU6502Core.scala 204:20 236:16]
  wire [7:0] _GEN_1306 = 8'h24 == opcode ? regs_y : _GEN_1287; // @[CPU6502Core.scala 204:20 236:16]
  wire [7:0] _GEN_1307 = 8'h24 == opcode ? regs_sp : _GEN_1288; // @[CPU6502Core.scala 204:20 236:16]
  wire [15:0] _GEN_1308 = 8'h24 == opcode ? execResult_result_newRegs_5_pc : _GEN_1289; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1309 = 8'h24 == opcode ? regs_flagC : _GEN_1290; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1310 = 8'h24 == opcode ? execResult_result_newRegs_7_flagZ : _GEN_1291; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1311 = 8'h24 == opcode ? regs_flagI : _GEN_1292; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1312 = 8'h24 == opcode ? regs_flagD : _GEN_1293; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1314 = 8'h24 == opcode ? execResult_result_newRegs_7_flagV : _GEN_1295; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1315 = 8'h24 == opcode ? execResult_result_newRegs_7_flagN : _GEN_1296; // @[CPU6502Core.scala 204:20 236:16]
  wire [15:0] _GEN_1316 = 8'h24 == opcode ? execResult_result_result_8_memAddr : _GEN_1297; // @[CPU6502Core.scala 204:20 236:16]
  wire [7:0] _GEN_1317 = 8'h24 == opcode ? 8'h0 : _GEN_1298; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1318 = 8'h24 == opcode ? 1'h0 : _GEN_1299; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1319 = 8'h24 == opcode ? execResult_result_result_6_memRead : _GEN_1300; // @[CPU6502Core.scala 204:20 236:16]
  wire [15:0] _GEN_1320 = 8'h24 == opcode ? execResult_result_result_6_operand : _GEN_1301; // @[CPU6502Core.scala 204:20 236:16]
  wire  _GEN_1321 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_1302; // @[CPU6502Core.scala 204:20 231:16]
  wire [2:0] _GEN_1322 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 3'h0 : _GEN_1303; // @[CPU6502Core.scala 204:20 231:16]
  wire [7:0] _GEN_1323 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_res_7 : _GEN_1304; // @[CPU6502Core.scala 204:20 231:16]
  wire [7:0] _GEN_1324 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_x : _GEN_1305; // @[CPU6502Core.scala 204:20 231:16]
  wire [7:0] _GEN_1325 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_y : _GEN_1306; // @[CPU6502Core.scala 204:20 231:16]
  wire [7:0] _GEN_1326 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_sp : _GEN_1307; // @[CPU6502Core.scala 204:20 231:16]
  wire [15:0] _GEN_1327 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? _regs_pc_T_1 : _GEN_1308; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1328 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagC : _GEN_1309; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1329 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_6_flagZ : _GEN_1310; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1330 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagI : _GEN_1311; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1331 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagD : _GEN_1312; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1333 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagV : _GEN_1314; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1334 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_6_flagN : _GEN_1315; // @[CPU6502Core.scala 204:20 231:16]
  wire [15:0] _GEN_1335 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_pc : _GEN_1316; // @[CPU6502Core.scala 204:20 231:16]
  wire [7:0] _GEN_1336 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 8'h0 : _GEN_1317; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1337 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 1'h0 : _GEN_1318; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1338 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_1319; // @[CPU6502Core.scala 204:20 231:16]
  wire [15:0] _GEN_1339 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 16'h0 : _GEN_1320; // @[CPU6502Core.scala 204:20 231:16]
  wire  _GEN_1340 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_done : _GEN_1321; // @[CPU6502Core.scala 204:20 226:16]
  wire [2:0] _GEN_1341 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_nextCycle : _GEN_1322; // @[CPU6502Core.scala 204:20 226:16]
  wire [7:0] _GEN_1342 = 8'he6 == opcode | 8'hc6 == opcode ? regs_a : _GEN_1323; // @[CPU6502Core.scala 204:20 226:16]
  wire [7:0] _GEN_1343 = 8'he6 == opcode | 8'hc6 == opcode ? regs_x : _GEN_1324; // @[CPU6502Core.scala 204:20 226:16]
  wire [7:0] _GEN_1344 = 8'he6 == opcode | 8'hc6 == opcode ? regs_y : _GEN_1325; // @[CPU6502Core.scala 204:20 226:16]
  wire [7:0] _GEN_1345 = 8'he6 == opcode | 8'hc6 == opcode ? regs_sp : _GEN_1326; // @[CPU6502Core.scala 204:20 226:16]
  wire [15:0] _GEN_1346 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_pc : _GEN_1327; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1347 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagC : _GEN_1328; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1348 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_1329; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1349 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagI : _GEN_1330; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1350 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagD : _GEN_1331; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1352 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagV : _GEN_1333; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1353 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_flagN : _GEN_1334; // @[CPU6502Core.scala 204:20 226:16]
  wire [15:0] _GEN_1354 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memAddr : _GEN_1335; // @[CPU6502Core.scala 204:20 226:16]
  wire [7:0] _GEN_1355 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memData : _GEN_1336; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1356 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_done : _GEN_1337; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1357 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memRead : _GEN_1338; // @[CPU6502Core.scala 204:20 226:16]
  wire [15:0] _GEN_1358 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_operand : _GEN_1339; // @[CPU6502Core.scala 204:20 226:16]
  wire  _GEN_1359 = 8'he9 == opcode | _GEN_1340; // @[CPU6502Core.scala 204:20 222:27]
  wire [2:0] _GEN_1360 = 8'he9 == opcode ? 3'h0 : _GEN_1341; // @[CPU6502Core.scala 204:20 222:27]
  wire [7:0] _GEN_1361 = 8'he9 == opcode ? execResult_result_newRegs_4_a : _GEN_1342; // @[CPU6502Core.scala 204:20 222:27]
  wire [7:0] _GEN_1362 = 8'he9 == opcode ? regs_x : _GEN_1343; // @[CPU6502Core.scala 204:20 222:27]
  wire [7:0] _GEN_1363 = 8'he9 == opcode ? regs_y : _GEN_1344; // @[CPU6502Core.scala 204:20 222:27]
  wire [7:0] _GEN_1364 = 8'he9 == opcode ? regs_sp : _GEN_1345; // @[CPU6502Core.scala 204:20 222:27]
  wire [15:0] _GEN_1365 = 8'he9 == opcode ? _regs_pc_T_1 : _GEN_1346; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1366 = 8'he9 == opcode ? execResult_result_newRegs_4_flagC : _GEN_1347; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1367 = 8'he9 == opcode ? execResult_result_newRegs_4_flagZ : _GEN_1348; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1368 = 8'he9 == opcode ? regs_flagI : _GEN_1349; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1369 = 8'he9 == opcode ? regs_flagD : _GEN_1350; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1371 = 8'he9 == opcode ? execResult_result_newRegs_4_flagV : _GEN_1352; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1372 = 8'he9 == opcode ? execResult_result_newRegs_4_flagN : _GEN_1353; // @[CPU6502Core.scala 204:20 222:27]
  wire [15:0] _GEN_1373 = 8'he9 == opcode ? regs_pc : _GEN_1354; // @[CPU6502Core.scala 204:20 222:27]
  wire [7:0] _GEN_1374 = 8'he9 == opcode ? 8'h0 : _GEN_1355; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1375 = 8'he9 == opcode ? 1'h0 : _GEN_1356; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1376 = 8'he9 == opcode | _GEN_1357; // @[CPU6502Core.scala 204:20 222:27]
  wire [15:0] _GEN_1377 = 8'he9 == opcode ? 16'h0 : _GEN_1358; // @[CPU6502Core.scala 204:20 222:27]
  wire  _GEN_1378 = 8'h69 == opcode | _GEN_1359; // @[CPU6502Core.scala 204:20 221:27]
  wire [2:0] _GEN_1379 = 8'h69 == opcode ? 3'h0 : _GEN_1360; // @[CPU6502Core.scala 204:20 221:27]
  wire [7:0] _GEN_1380 = 8'h69 == opcode ? execResult_result_newRegs_3_a : _GEN_1361; // @[CPU6502Core.scala 204:20 221:27]
  wire [7:0] _GEN_1381 = 8'h69 == opcode ? regs_x : _GEN_1362; // @[CPU6502Core.scala 204:20 221:27]
  wire [7:0] _GEN_1382 = 8'h69 == opcode ? regs_y : _GEN_1363; // @[CPU6502Core.scala 204:20 221:27]
  wire [7:0] _GEN_1383 = 8'h69 == opcode ? regs_sp : _GEN_1364; // @[CPU6502Core.scala 204:20 221:27]
  wire [15:0] _GEN_1384 = 8'h69 == opcode ? _regs_pc_T_1 : _GEN_1365; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1385 = 8'h69 == opcode ? execResult_result_newRegs_3_flagC : _GEN_1366; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1386 = 8'h69 == opcode ? execResult_result_newRegs_3_flagZ : _GEN_1367; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1387 = 8'h69 == opcode ? regs_flagI : _GEN_1368; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1388 = 8'h69 == opcode ? regs_flagD : _GEN_1369; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1390 = 8'h69 == opcode ? execResult_result_newRegs_3_flagV : _GEN_1371; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1391 = 8'h69 == opcode ? execResult_result_newRegs_3_flagN : _GEN_1372; // @[CPU6502Core.scala 204:20 221:27]
  wire [15:0] _GEN_1392 = 8'h69 == opcode ? regs_pc : _GEN_1373; // @[CPU6502Core.scala 204:20 221:27]
  wire [7:0] _GEN_1393 = 8'h69 == opcode ? 8'h0 : _GEN_1374; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1394 = 8'h69 == opcode ? 1'h0 : _GEN_1375; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1395 = 8'h69 == opcode | _GEN_1376; // @[CPU6502Core.scala 204:20 221:27]
  wire [15:0] _GEN_1396 = 8'h69 == opcode ? 16'h0 : _GEN_1377; // @[CPU6502Core.scala 204:20 221:27]
  wire  _GEN_1397 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode | _GEN_1378; // @[CPU6502Core.scala 204:20 217:16]
  wire [2:0] _GEN_1398 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 3'h0 : _GEN_1379; // @[CPU6502Core.scala 204:20 217:16]
  wire [7:0] _GEN_1399 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_a : _GEN_1380; // @[CPU6502Core.scala 204:20 217:16]
  wire [7:0] _GEN_1400 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_x : _GEN_1381; // @[CPU6502Core.scala 204:20 217:16]
  wire [7:0] _GEN_1401 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_y : _GEN_1382; // @[CPU6502Core.scala 204:20 217:16]
  wire [7:0] _GEN_1402 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_sp : _GEN_1383; // @[CPU6502Core.scala 204:20 217:16]
  wire [15:0] _GEN_1403 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_pc : _GEN_1384; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1404 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagC : _GEN_1385; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1405 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagZ : _GEN_1386; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1406 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagI : _GEN_1387; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1407 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagD : _GEN_1388; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1409 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagV : _GEN_1390; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1410 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagN : _GEN_1391; // @[CPU6502Core.scala 204:20 217:16]
  wire [15:0] _GEN_1411 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_1392; // @[CPU6502Core.scala 204:20 217:16]
  wire [7:0] _GEN_1412 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 8'h0 : _GEN_1393; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1413 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_1394; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1414 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_1395; // @[CPU6502Core.scala 204:20 217:16]
  wire [15:0] _GEN_1415 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_1396; // @[CPU6502Core.scala 204:20 217:16]
  wire  _GEN_1416 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode | _GEN_1397; // @[CPU6502Core.scala 204:20 212:16]
  wire [2:0] _GEN_1417 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 3'h0 : _GEN_1398; // @[CPU6502Core.scala 204:20 212:16]
  wire [7:0] _GEN_1418 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_a : _GEN_1399; // @[CPU6502Core.scala 204:20 212:16]
  wire [7:0] _GEN_1419 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_x : _GEN_1400; // @[CPU6502Core.scala 204:20 212:16]
  wire [7:0] _GEN_1420 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_y : _GEN_1401; // @[CPU6502Core.scala 204:20 212:16]
  wire [7:0] _GEN_1421 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_sp : _GEN_1402; // @[CPU6502Core.scala 204:20 212:16]
  wire [15:0] _GEN_1422 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? regs_pc : _GEN_1403; // @[CPU6502Core.scala 204:20 212:16]
  wire  _GEN_1423 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagC : _GEN_1404; // @[CPU6502Core.scala 204:20 212:16]
  wire  _GEN_1424 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagZ : _GEN_1405; // @[CPU6502Core.scala 204:20 212:16]
  wire  _GEN_1425 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagI : _GEN_1406; // @[CPU6502Core.scala 204:20 212:16]
  wire  _GEN_1426 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagD : _GEN_1407; // @[CPU6502Core.scala 204:20 212:16]
  wire  _GEN_1428 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagV : _GEN_1409; // @[CPU6502Core.scala 204:20 212:16]
  wire  _GEN_1429 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagN : _GEN_1410; // @[CPU6502Core.scala 204:20 212:16]
  wire [15:0] _GEN_1430 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_1411; // @[CPU6502Core.scala 204:20 212:16]
  wire [7:0] _GEN_1431 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 8'h0 : _GEN_1412; // @[CPU6502Core.scala 204:20 212:16]
  wire  _GEN_1432 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_1413; // @[CPU6502Core.scala 204:20 212:16]
  wire  _GEN_1433 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_1414; // @[CPU6502Core.scala 204:20 212:16]
  wire [15:0] _GEN_1434 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_1415; // @[CPU6502Core.scala 204:20 212:16]
  wire  execResult_result_1_done = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode | _GEN_1416; // @[CPU6502Core.scala 204:20 207:16]
  wire [2:0] execResult_result_1_nextCycle = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 3'h0 : _GEN_1417; // @[CPU6502Core.scala 204:20 207:16]
  wire [7:0] execResult_result_1_regs_a = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_a : _GEN_1418; // @[CPU6502Core.scala 204:20 207:16]
  wire [7:0] execResult_result_1_regs_x = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_x : _GEN_1419; // @[CPU6502Core.scala 204:20 207:16]
  wire [7:0] execResult_result_1_regs_y = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_y : _GEN_1420; // @[CPU6502Core.scala 204:20 207:16]
  wire [7:0] execResult_result_1_regs_sp = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_sp : _GEN_1421; // @[CPU6502Core.scala 204:20 207:16]
  wire [15:0] execResult_result_1_regs_pc = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_pc : _GEN_1422; // @[CPU6502Core.scala 204:20 207:16]
  wire  execResult_result_1_regs_flagC = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagC : _GEN_1423; // @[CPU6502Core.scala 204:20 207:16]
  wire  execResult_result_1_regs_flagZ = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagZ : _GEN_1424; // @[CPU6502Core.scala 204:20 207:16]
  wire  execResult_result_1_regs_flagI = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagI : _GEN_1425; // @[CPU6502Core.scala 204:20 207:16]
  wire  execResult_result_1_regs_flagD = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagD : _GEN_1426; // @[CPU6502Core.scala 204:20 207:16]
  wire  execResult_result_1_regs_flagV = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagV : _GEN_1428; // @[CPU6502Core.scala 204:20 207:16]
  wire  execResult_result_1_regs_flagN = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagN : _GEN_1429; // @[CPU6502Core.scala 204:20 207:16]
  wire [15:0] execResult_result_1_memAddr = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_1430; // @[CPU6502Core.scala 204:20 207:16]
  wire [7:0] execResult_result_1_memData = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 8'h0 : _GEN_1431; // @[CPU6502Core.scala 204:20 207:16]
  wire  execResult_result_1_memWrite = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_1432; // @[CPU6502Core.scala 204:20 207:16]
  wire  execResult_result_1_memRead = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_1433; // @[CPU6502Core.scala 204:20 207:16]
  wire [15:0] execResult_result_1_operand = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_1434; // @[CPU6502Core.scala 204:20 207:16]
  wire  _GEN_1520 = 3'h2 == state & execResult_result_1_done; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1565 = 3'h1 == state ? 1'h0 : _GEN_1520; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1606 = 3'h0 == state ? 1'h0 : _GEN_1565; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1647 = ~resetReleased ? 1'h0 : _GEN_1606; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_done = io_reset ? 1'h0 : _GEN_1647; // @[CPU6502Core.scala 49:14 55:18]
  wire [2:0] _GEN_1521 = 3'h2 == state ? execResult_result_1_nextCycle : 3'h0; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [2:0] _GEN_1566 = 3'h1 == state ? 3'h0 : _GEN_1521; // @[CPU6502Core.scala 49:14 67:21]
  wire [2:0] _GEN_1607 = 3'h0 == state ? 3'h0 : _GEN_1566; // @[CPU6502Core.scala 49:14 67:21]
  wire [2:0] _GEN_1648 = ~resetReleased ? 3'h0 : _GEN_1607; // @[CPU6502Core.scala 49:14 62:26]
  wire [2:0] execResult_nextCycle = io_reset ? 3'h0 : _GEN_1648; // @[CPU6502Core.scala 49:14 55:18]
  wire [2:0] _GEN_1454 = execResult_done ? 3'h0 : execResult_nextCycle; // @[CPU6502Core.scala 124:19 126:33 127:19]
  wire [2:0] _GEN_1455 = execResult_done ? 3'h1 : state; // @[CPU6502Core.scala 126:33 128:19 25:22]
  wire  _T_13 = cycle == 3'h3; // @[CPU6502Core.scala 151:28]
  wire [7:0] status = {regs_flagN,regs_flagV,2'h2,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_1456 = cycle == 3'h5 ? 16'hfffa : 16'hfffb; // @[CPU6502Core.scala 165:37 167:24 173:24]
  wire [15:0] _GEN_1458 = cycle == 3'h5 ? {{8'd0}, io_memDataIn} : operand; // @[CPU6502Core.scala 165:37 169:21 28:24]
  wire [2:0] _GEN_1459 = cycle == 3'h5 ? 3'h6 : 3'h0; // @[CPU6502Core.scala 165:37 170:19 178:19]
  wire [15:0] _GEN_1460 = cycle == 3'h5 ? regs_pc : resetVector; // @[CPU6502Core.scala 165:37 176:21 21:21]
  wire  _GEN_1461 = cycle == 3'h5 ? regs_flagI : 1'h1; // @[CPU6502Core.scala 165:37 21:21 177:24]
  wire [2:0] _GEN_1462 = cycle == 3'h5 ? state : 3'h1; // @[CPU6502Core.scala 165:37 179:19 25:22]
  wire [15:0] _GEN_1463 = cycle == 3'h4 ? 16'hfffa : _GEN_1456; // @[CPU6502Core.scala 160:37 162:24]
  wire [2:0] _GEN_1465 = cycle == 3'h4 ? 3'h5 : _GEN_1459; // @[CPU6502Core.scala 160:37 164:19]
  wire [15:0] _GEN_1466 = cycle == 3'h4 ? operand : _GEN_1458; // @[CPU6502Core.scala 160:37 28:24]
  wire [15:0] _GEN_1467 = cycle == 3'h4 ? regs_pc : _GEN_1460; // @[CPU6502Core.scala 160:37 21:21]
  wire  _GEN_1468 = cycle == 3'h4 ? regs_flagI : _GEN_1461; // @[CPU6502Core.scala 160:37 21:21]
  wire [2:0] _GEN_1469 = cycle == 3'h4 ? state : _GEN_1462; // @[CPU6502Core.scala 160:37 25:22]
  wire [15:0] _GEN_1470 = cycle == 3'h3 ? execResult_result_result_19_memAddr : _GEN_1463; // @[CPU6502Core.scala 151:37 155:24]
  wire [7:0] _GEN_1471 = cycle == 3'h3 ? status : 8'h0; // @[CPU6502Core.scala 151:37 156:27 43:17]
  wire [7:0] _GEN_1473 = cycle == 3'h3 ? execResult_result_newRegs_18_sp : regs_sp; // @[CPU6502Core.scala 151:37 158:21 21:21]
  wire [2:0] _GEN_1474 = cycle == 3'h3 ? 3'h4 : _GEN_1465; // @[CPU6502Core.scala 151:37 159:19]
  wire  _GEN_1475 = cycle == 3'h3 ? 1'h0 : 1'h1; // @[CPU6502Core.scala 151:37 45:17]
  wire [15:0] _GEN_1476 = cycle == 3'h3 ? operand : _GEN_1466; // @[CPU6502Core.scala 151:37 28:24]
  wire [15:0] _GEN_1477 = cycle == 3'h3 ? regs_pc : _GEN_1467; // @[CPU6502Core.scala 151:37 21:21]
  wire  _GEN_1478 = cycle == 3'h3 ? regs_flagI : _GEN_1468; // @[CPU6502Core.scala 151:37 21:21]
  wire [2:0] _GEN_1479 = cycle == 3'h3 ? state : _GEN_1469; // @[CPU6502Core.scala 151:37 25:22]
  wire [15:0] _GEN_1480 = _T_6 ? execResult_result_result_19_memAddr : _GEN_1470; // @[CPU6502Core.scala 144:37 146:24]
  wire [7:0] _GEN_1481 = _T_6 ? regs_pc[7:0] : _GEN_1471; // @[CPU6502Core.scala 144:37 147:27]
  wire  _GEN_1482 = _T_6 | _T_13; // @[CPU6502Core.scala 144:37 148:25]
  wire [7:0] _GEN_1483 = _T_6 ? execResult_result_newRegs_18_sp : _GEN_1473; // @[CPU6502Core.scala 144:37 149:21]
  wire [2:0] _GEN_1484 = _T_6 ? 3'h3 : _GEN_1474; // @[CPU6502Core.scala 144:37 150:19]
  wire  _GEN_1485 = _T_6 ? 1'h0 : _GEN_1475; // @[CPU6502Core.scala 144:37 45:17]
  wire [15:0] _GEN_1486 = _T_6 ? operand : _GEN_1476; // @[CPU6502Core.scala 144:37 28:24]
  wire [15:0] _GEN_1487 = _T_6 ? regs_pc : _GEN_1477; // @[CPU6502Core.scala 144:37 21:21]
  wire  _GEN_1488 = _T_6 ? regs_flagI : _GEN_1478; // @[CPU6502Core.scala 144:37 21:21]
  wire [2:0] _GEN_1489 = _T_6 ? state : _GEN_1479; // @[CPU6502Core.scala 144:37 25:22]
  wire [15:0] _GEN_1490 = _T_5 ? execResult_result_result_19_memAddr : _GEN_1480; // @[CPU6502Core.scala 137:37 139:24]
  wire [7:0] _GEN_1491 = _T_5 ? regs_pc[15:8] : _GEN_1481; // @[CPU6502Core.scala 137:37 140:27]
  wire  _GEN_1492 = _T_5 | _GEN_1482; // @[CPU6502Core.scala 137:37 141:25]
  wire [7:0] _GEN_1493 = _T_5 ? execResult_result_newRegs_18_sp : _GEN_1483; // @[CPU6502Core.scala 137:37 142:21]
  wire [2:0] _GEN_1494 = _T_5 ? 3'h2 : _GEN_1484; // @[CPU6502Core.scala 137:37 143:19]
  wire  _GEN_1495 = _T_5 ? 1'h0 : _GEN_1485; // @[CPU6502Core.scala 137:37 45:17]
  wire [15:0] _GEN_1496 = _T_5 ? operand : _GEN_1486; // @[CPU6502Core.scala 137:37 28:24]
  wire [15:0] _GEN_1497 = _T_5 ? regs_pc : _GEN_1487; // @[CPU6502Core.scala 137:37 21:21]
  wire  _GEN_1498 = _T_5 ? regs_flagI : _GEN_1488; // @[CPU6502Core.scala 137:37 21:21]
  wire [2:0] _GEN_1499 = _T_5 ? state : _GEN_1489; // @[CPU6502Core.scala 137:37 25:22]
  wire [2:0] _GEN_1500 = _T_4 ? 3'h1 : _GEN_1494; // @[CPU6502Core.scala 134:31 136:19]
  wire [15:0] _GEN_1501 = _T_4 ? regs_pc : _GEN_1490; // @[CPU6502Core.scala 134:31 42:17]
  wire [7:0] _GEN_1502 = _T_4 ? 8'h0 : _GEN_1491; // @[CPU6502Core.scala 134:31 43:17]
  wire  _GEN_1503 = _T_4 ? 1'h0 : _GEN_1492; // @[CPU6502Core.scala 134:31 44:17]
  wire [7:0] _GEN_1504 = _T_4 ? regs_sp : _GEN_1493; // @[CPU6502Core.scala 134:31 21:21]
  wire  _GEN_1505 = _T_4 ? 1'h0 : _GEN_1495; // @[CPU6502Core.scala 134:31 45:17]
  wire [15:0] _GEN_1506 = _T_4 ? operand : _GEN_1496; // @[CPU6502Core.scala 134:31 28:24]
  wire [15:0] _GEN_1507 = _T_4 ? regs_pc : _GEN_1497; // @[CPU6502Core.scala 134:31 21:21]
  wire  _GEN_1508 = _T_4 ? regs_flagI : _GEN_1498; // @[CPU6502Core.scala 134:31 21:21]
  wire [2:0] _GEN_1509 = _T_4 ? state : _GEN_1499; // @[CPU6502Core.scala 134:31 25:22]
  wire [2:0] _GEN_1510 = 3'h3 == state ? _GEN_1500 : cycle; // @[CPU6502Core.scala 67:21 29:24]
  wire [15:0] _GEN_1511 = 3'h3 == state ? _GEN_1501 : regs_pc; // @[CPU6502Core.scala 42:17 67:21]
  wire [7:0] _GEN_1512 = 3'h3 == state ? _GEN_1502 : 8'h0; // @[CPU6502Core.scala 43:17 67:21]
  wire  _GEN_1513 = 3'h3 == state & _GEN_1503; // @[CPU6502Core.scala 44:17 67:21]
  wire [7:0] _GEN_1514 = 3'h3 == state ? _GEN_1504 : regs_sp; // @[CPU6502Core.scala 21:21 67:21]
  wire  _GEN_1515 = 3'h3 == state & _GEN_1505; // @[CPU6502Core.scala 45:17 67:21]
  wire [15:0] _GEN_1516 = 3'h3 == state ? _GEN_1506 : operand; // @[CPU6502Core.scala 67:21 28:24]
  wire [15:0] _GEN_1517 = 3'h3 == state ? _GEN_1507 : regs_pc; // @[CPU6502Core.scala 21:21 67:21]
  wire  _GEN_1518 = 3'h3 == state ? _GEN_1508 : regs_flagI; // @[CPU6502Core.scala 21:21 67:21]
  wire [2:0] _GEN_1519 = 3'h3 == state ? _GEN_1509 : state; // @[CPU6502Core.scala 67:21 25:22]
  wire [7:0] _GEN_1522 = 3'h2 == state ? execResult_result_1_regs_a : regs_a; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [7:0] _GEN_1523 = 3'h2 == state ? execResult_result_1_regs_x : regs_x; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [7:0] _GEN_1524 = 3'h2 == state ? execResult_result_1_regs_y : regs_y; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [7:0] _GEN_1525 = 3'h2 == state ? execResult_result_1_regs_sp : regs_sp; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [15:0] _GEN_1526 = 3'h2 == state ? execResult_result_1_regs_pc : regs_pc; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1527 = 3'h2 == state ? execResult_result_1_regs_flagC : regs_flagC; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1528 = 3'h2 == state ? execResult_result_1_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1529 = 3'h2 == state ? execResult_result_1_regs_flagI : regs_flagI; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1530 = 3'h2 == state ? execResult_result_1_regs_flagD : regs_flagD; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1532 = 3'h2 == state ? execResult_result_1_regs_flagV : regs_flagV; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1533 = 3'h2 == state ? execResult_result_1_regs_flagN : regs_flagN; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [15:0] _GEN_1534 = 3'h2 == state ? execResult_result_1_memAddr : 16'h0; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [7:0] _GEN_1535 = 3'h2 == state ? execResult_result_1_memData : 8'h0; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1536 = 3'h2 == state & execResult_result_1_memWrite; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire  _GEN_1537 = 3'h2 == state & execResult_result_1_memRead; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [15:0] _GEN_1538 = 3'h2 == state ? execResult_result_1_operand : operand; // @[CPU6502Core.scala 67:21 114:22 49:14]
  wire [15:0] _GEN_1579 = 3'h1 == state ? 16'h0 : _GEN_1534; // @[CPU6502Core.scala 49:14 67:21]
  wire [15:0] _GEN_1620 = 3'h0 == state ? 16'h0 : _GEN_1579; // @[CPU6502Core.scala 49:14 67:21]
  wire [15:0] _GEN_1661 = ~resetReleased ? 16'h0 : _GEN_1620; // @[CPU6502Core.scala 49:14 62:26]
  wire [15:0] execResult_memAddr = io_reset ? 16'h0 : _GEN_1661; // @[CPU6502Core.scala 49:14 55:18]
  wire [15:0] _GEN_1539 = 3'h2 == state ? execResult_memAddr : _GEN_1511; // @[CPU6502Core.scala 67:21 117:25]
  wire [7:0] _GEN_1580 = 3'h1 == state ? 8'h0 : _GEN_1535; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1621 = 3'h0 == state ? 8'h0 : _GEN_1580; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1662 = ~resetReleased ? 8'h0 : _GEN_1621; // @[CPU6502Core.scala 49:14 62:26]
  wire [7:0] execResult_memData = io_reset ? 8'h0 : _GEN_1662; // @[CPU6502Core.scala 49:14 55:18]
  wire [7:0] _GEN_1540 = 3'h2 == state ? execResult_memData : _GEN_1512; // @[CPU6502Core.scala 67:21 118:25]
  wire  _GEN_1581 = 3'h1 == state ? 1'h0 : _GEN_1536; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1622 = 3'h0 == state ? 1'h0 : _GEN_1581; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1663 = ~resetReleased ? 1'h0 : _GEN_1622; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_memWrite = io_reset ? 1'h0 : _GEN_1663; // @[CPU6502Core.scala 49:14 55:18]
  wire  _GEN_1541 = 3'h2 == state ? execResult_memWrite : _GEN_1513; // @[CPU6502Core.scala 67:21 119:25]
  wire  _GEN_1582 = 3'h1 == state ? 1'h0 : _GEN_1537; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1623 = 3'h0 == state ? 1'h0 : _GEN_1582; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1664 = ~resetReleased ? 1'h0 : _GEN_1623; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_memRead = io_reset ? 1'h0 : _GEN_1664; // @[CPU6502Core.scala 49:14 55:18]
  wire  _GEN_1542 = 3'h2 == state ? execResult_memRead : _GEN_1515; // @[CPU6502Core.scala 67:21 120:25]
  wire [7:0] _GEN_1567 = 3'h1 == state ? regs_a : _GEN_1522; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1608 = 3'h0 == state ? regs_a : _GEN_1567; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1649 = ~resetReleased ? regs_a : _GEN_1608; // @[CPU6502Core.scala 49:14 62:26]
  wire [7:0] execResult_regs_a = io_reset ? regs_a : _GEN_1649; // @[CPU6502Core.scala 49:14 55:18]
  wire [7:0] _GEN_1543 = 3'h2 == state ? execResult_regs_a : regs_a; // @[CPU6502Core.scala 122:19 21:21 67:21]
  wire [7:0] _GEN_1568 = 3'h1 == state ? regs_x : _GEN_1523; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1609 = 3'h0 == state ? regs_x : _GEN_1568; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1650 = ~resetReleased ? regs_x : _GEN_1609; // @[CPU6502Core.scala 49:14 62:26]
  wire [7:0] execResult_regs_x = io_reset ? regs_x : _GEN_1650; // @[CPU6502Core.scala 49:14 55:18]
  wire [7:0] _GEN_1544 = 3'h2 == state ? execResult_regs_x : regs_x; // @[CPU6502Core.scala 122:19 21:21 67:21]
  wire [7:0] _GEN_1569 = 3'h1 == state ? regs_y : _GEN_1524; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1610 = 3'h0 == state ? regs_y : _GEN_1569; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1651 = ~resetReleased ? regs_y : _GEN_1610; // @[CPU6502Core.scala 49:14 62:26]
  wire [7:0] execResult_regs_y = io_reset ? regs_y : _GEN_1651; // @[CPU6502Core.scala 49:14 55:18]
  wire [7:0] _GEN_1545 = 3'h2 == state ? execResult_regs_y : regs_y; // @[CPU6502Core.scala 122:19 21:21 67:21]
  wire [7:0] _GEN_1570 = 3'h1 == state ? regs_sp : _GEN_1525; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1611 = 3'h0 == state ? regs_sp : _GEN_1570; // @[CPU6502Core.scala 49:14 67:21]
  wire [7:0] _GEN_1652 = ~resetReleased ? regs_sp : _GEN_1611; // @[CPU6502Core.scala 49:14 62:26]
  wire [7:0] execResult_regs_sp = io_reset ? regs_sp : _GEN_1652; // @[CPU6502Core.scala 49:14 55:18]
  wire [7:0] _GEN_1546 = 3'h2 == state ? execResult_regs_sp : _GEN_1514; // @[CPU6502Core.scala 122:19 67:21]
  wire [15:0] _GEN_1571 = 3'h1 == state ? regs_pc : _GEN_1526; // @[CPU6502Core.scala 49:14 67:21]
  wire [15:0] _GEN_1612 = 3'h0 == state ? regs_pc : _GEN_1571; // @[CPU6502Core.scala 49:14 67:21]
  wire [15:0] _GEN_1653 = ~resetReleased ? regs_pc : _GEN_1612; // @[CPU6502Core.scala 49:14 62:26]
  wire [15:0] execResult_regs_pc = io_reset ? regs_pc : _GEN_1653; // @[CPU6502Core.scala 49:14 55:18]
  wire [15:0] _GEN_1547 = 3'h2 == state ? execResult_regs_pc : _GEN_1517; // @[CPU6502Core.scala 122:19 67:21]
  wire  _GEN_1572 = 3'h1 == state ? regs_flagC : _GEN_1527; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1613 = 3'h0 == state ? regs_flagC : _GEN_1572; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1654 = ~resetReleased ? regs_flagC : _GEN_1613; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_regs_flagC = io_reset ? regs_flagC : _GEN_1654; // @[CPU6502Core.scala 49:14 55:18]
  wire  _GEN_1548 = 3'h2 == state ? execResult_regs_flagC : regs_flagC; // @[CPU6502Core.scala 122:19 21:21 67:21]
  wire  _GEN_1573 = 3'h1 == state ? regs_flagZ : _GEN_1528; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1614 = 3'h0 == state ? regs_flagZ : _GEN_1573; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1655 = ~resetReleased ? regs_flagZ : _GEN_1614; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_regs_flagZ = io_reset ? regs_flagZ : _GEN_1655; // @[CPU6502Core.scala 49:14 55:18]
  wire  _GEN_1549 = 3'h2 == state ? execResult_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 122:19 21:21 67:21]
  wire  _GEN_1574 = 3'h1 == state ? regs_flagI : _GEN_1529; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1615 = 3'h0 == state ? regs_flagI : _GEN_1574; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1656 = ~resetReleased ? regs_flagI : _GEN_1615; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_regs_flagI = io_reset ? regs_flagI : _GEN_1656; // @[CPU6502Core.scala 49:14 55:18]
  wire  _GEN_1550 = 3'h2 == state ? execResult_regs_flagI : _GEN_1518; // @[CPU6502Core.scala 122:19 67:21]
  wire  _GEN_1575 = 3'h1 == state ? regs_flagD : _GEN_1530; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1616 = 3'h0 == state ? regs_flagD : _GEN_1575; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1657 = ~resetReleased ? regs_flagD : _GEN_1616; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_regs_flagD = io_reset ? regs_flagD : _GEN_1657; // @[CPU6502Core.scala 49:14 55:18]
  wire  _GEN_1551 = 3'h2 == state ? execResult_regs_flagD : regs_flagD; // @[CPU6502Core.scala 122:19 21:21 67:21]
  wire  _GEN_1577 = 3'h1 == state ? regs_flagV : _GEN_1532; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1618 = 3'h0 == state ? regs_flagV : _GEN_1577; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1659 = ~resetReleased ? regs_flagV : _GEN_1618; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_regs_flagV = io_reset ? regs_flagV : _GEN_1659; // @[CPU6502Core.scala 49:14 55:18]
  wire  _GEN_1553 = 3'h2 == state ? execResult_regs_flagV : regs_flagV; // @[CPU6502Core.scala 122:19 21:21 67:21]
  wire  _GEN_1578 = 3'h1 == state ? regs_flagN : _GEN_1533; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1619 = 3'h0 == state ? regs_flagN : _GEN_1578; // @[CPU6502Core.scala 49:14 67:21]
  wire  _GEN_1660 = ~resetReleased ? regs_flagN : _GEN_1619; // @[CPU6502Core.scala 49:14 62:26]
  wire  execResult_regs_flagN = io_reset ? regs_flagN : _GEN_1660; // @[CPU6502Core.scala 49:14 55:18]
  wire  _GEN_1554 = 3'h2 == state ? execResult_regs_flagN : regs_flagN; // @[CPU6502Core.scala 122:19 21:21 67:21]
  wire [15:0] _GEN_1583 = 3'h1 == state ? operand : _GEN_1538; // @[CPU6502Core.scala 49:14 67:21]
  wire [15:0] _GEN_1624 = 3'h0 == state ? operand : _GEN_1583; // @[CPU6502Core.scala 49:14 67:21]
  wire [15:0] _GEN_1665 = ~resetReleased ? operand : _GEN_1624; // @[CPU6502Core.scala 49:14 62:26]
  wire [15:0] execResult_operand = io_reset ? operand : _GEN_1665; // @[CPU6502Core.scala 49:14 55:18]
  wire [15:0] _GEN_1555 = 3'h2 == state ? execResult_operand : _GEN_1516; // @[CPU6502Core.scala 123:19 67:21]
  wire [2:0] _GEN_1556 = 3'h2 == state ? _GEN_1454 : _GEN_1510; // @[CPU6502Core.scala 67:21]
  wire [2:0] _GEN_1557 = 3'h2 == state ? _GEN_1455 : _GEN_1519; // @[CPU6502Core.scala 67:21]
  wire  _GEN_1558 = 3'h1 == state ? _GEN_18 : _GEN_0; // @[CPU6502Core.scala 67:21]
  wire [2:0] _GEN_1559 = 3'h1 == state ? 3'h0 : _GEN_1556; // @[CPU6502Core.scala 67:21]
  wire [2:0] _GEN_1560 = 3'h1 == state ? _GEN_20 : _GEN_1557; // @[CPU6502Core.scala 67:21]
  wire [15:0] _GEN_1561 = 3'h1 == state ? regs_pc : _GEN_1539; // @[CPU6502Core.scala 67:21]
  wire  _GEN_1562 = 3'h1 == state ? _GEN_22 : _GEN_1542; // @[CPU6502Core.scala 67:21]
  wire [7:0] _GEN_1563 = 3'h1 == state ? _GEN_23 : opcode; // @[CPU6502Core.scala 67:21 27:24]
  wire [15:0] _GEN_1564 = 3'h1 == state ? _GEN_24 : _GEN_1547; // @[CPU6502Core.scala 67:21]
  wire [7:0] _GEN_1584 = 3'h1 == state ? 8'h0 : _GEN_1540; // @[CPU6502Core.scala 43:17 67:21]
  wire  _GEN_1585 = 3'h1 == state ? 1'h0 : _GEN_1541; // @[CPU6502Core.scala 44:17 67:21]
  wire [7:0] _GEN_1586 = 3'h1 == state ? regs_a : _GEN_1543; // @[CPU6502Core.scala 21:21 67:21]
  wire [7:0] _GEN_1587 = 3'h1 == state ? regs_x : _GEN_1544; // @[CPU6502Core.scala 21:21 67:21]
  wire [7:0] _GEN_1588 = 3'h1 == state ? regs_y : _GEN_1545; // @[CPU6502Core.scala 21:21 67:21]
  wire [7:0] _GEN_1589 = 3'h1 == state ? regs_sp : _GEN_1546; // @[CPU6502Core.scala 21:21 67:21]
  wire  _GEN_1590 = 3'h1 == state ? regs_flagC : _GEN_1548; // @[CPU6502Core.scala 21:21 67:21]
  wire  _GEN_1591 = 3'h1 == state ? regs_flagZ : _GEN_1549; // @[CPU6502Core.scala 21:21 67:21]
  wire  _GEN_1592 = 3'h1 == state ? regs_flagI : _GEN_1550; // @[CPU6502Core.scala 21:21 67:21]
  wire  _GEN_1593 = 3'h1 == state ? regs_flagD : _GEN_1551; // @[CPU6502Core.scala 21:21 67:21]
  wire  _GEN_1595 = 3'h1 == state ? regs_flagV : _GEN_1553; // @[CPU6502Core.scala 21:21 67:21]
  wire  _GEN_1596 = 3'h1 == state ? regs_flagN : _GEN_1554; // @[CPU6502Core.scala 21:21 67:21]
  wire [15:0] _GEN_1597 = 3'h1 == state ? operand : _GEN_1555; // @[CPU6502Core.scala 67:21 28:24]
  wire [15:0] _GEN_1598 = 3'h0 == state ? _GEN_12 : _GEN_1561; // @[CPU6502Core.scala 67:21]
  wire  _GEN_1599 = 3'h0 == state | _GEN_1562; // @[CPU6502Core.scala 67:21]
  wire [7:0] _GEN_1625 = 3'h0 == state ? 8'h0 : _GEN_1584; // @[CPU6502Core.scala 43:17 67:21]
  wire  _GEN_1626 = 3'h0 == state ? 1'h0 : _GEN_1585; // @[CPU6502Core.scala 44:17 67:21]
  wire  _GEN_1638 = ~resetReleased | resetReleased; // @[CPU6502Core.scala 62:26 64:21 52:30]
  wire [15:0] _GEN_1640 = ~resetReleased ? regs_pc : _GEN_1598; // @[CPU6502Core.scala 42:17 62:26]
  wire  _GEN_1641 = ~resetReleased ? 1'h0 : _GEN_1599; // @[CPU6502Core.scala 45:17 62:26]
  wire [7:0] _GEN_1666 = ~resetReleased ? 8'h0 : _GEN_1625; // @[CPU6502Core.scala 43:17 62:26]
  wire  _GEN_1667 = ~resetReleased ? 1'h0 : _GEN_1626; // @[CPU6502Core.scala 44:17 62:26]
  assign io_memAddr = io_reset ? regs_pc : _GEN_1640; // @[CPU6502Core.scala 42:17 55:18]
  assign io_memDataOut = io_reset ? 8'h0 : _GEN_1666; // @[CPU6502Core.scala 43:17 55:18]
  assign io_memWrite = io_reset ? 1'h0 : _GEN_1667; // @[CPU6502Core.scala 44:17 55:18]
  assign io_memRead = io_reset ? 1'h0 : _GEN_1641; // @[CPU6502Core.scala 45:17 55:18]
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
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_a <= _GEN_1586;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_x <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_x <= _GEN_1587;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_y <= 8'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_y <= _GEN_1588;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_sp <= 8'hff; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_sp <= _GEN_1589;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 21:21]
    end else if (io_reset) begin // @[CPU6502Core.scala 55:18]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 59:13]
    end else if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
      if (3'h0 == state) begin // @[CPU6502Core.scala 67:21]
        regs_pc <= _GEN_16;
      end else begin
        regs_pc <= _GEN_1564;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagC <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_flagC <= _GEN_1590;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagZ <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_flagZ <= _GEN_1591;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagI <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_flagI <= _GEN_1592;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagD <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_flagD <= _GEN_1593;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagV <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_flagV <= _GEN_1595;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 21:21]
      regs_flagN <= 1'h0; // @[CPU6502Core.scala 21:21]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          regs_flagN <= _GEN_1596;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 25:22]
      state <= 3'h0; // @[CPU6502Core.scala 25:22]
    end else if (io_reset) begin // @[CPU6502Core.scala 55:18]
      state <= 3'h0; // @[CPU6502Core.scala 57:11]
    end else if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
      if (3'h0 == state) begin // @[CPU6502Core.scala 67:21]
        state <= _GEN_17;
      end else begin
        state <= _GEN_1560;
      end
    end
    if (reset) begin // @[CPU6502Core.scala 27:24]
      opcode <= 8'h0; // @[CPU6502Core.scala 27:24]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (!(3'h0 == state)) begin // @[CPU6502Core.scala 67:21]
          opcode <= _GEN_1563;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 28:24]
      operand <= 16'h0; // @[CPU6502Core.scala 28:24]
    end else if (!(io_reset)) begin // @[CPU6502Core.scala 55:18]
      if (!(~resetReleased)) begin // @[CPU6502Core.scala 62:26]
        if (3'h0 == state) begin // @[CPU6502Core.scala 67:21]
          operand <= _GEN_15;
        end else begin
          operand <= _GEN_1597;
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 29:24]
      cycle <= 3'h0; // @[CPU6502Core.scala 29:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 55:18]
      cycle <= 3'h0; // @[CPU6502Core.scala 58:11]
    end else if (~resetReleased) begin // @[CPU6502Core.scala 62:26]
      cycle <= 3'h0; // @[CPU6502Core.scala 65:13]
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 67:21]
      cycle <= {{1'd0}, _GEN_14};
    end else begin
      cycle <= _GEN_1559;
    end
    if (reset) begin // @[CPU6502Core.scala 32:24]
      nmiLast <= 1'h0; // @[CPU6502Core.scala 32:24]
    end else begin
      nmiLast <= io_nmi; // @[CPU6502Core.scala 39:11]
    end
    if (reset) begin // @[CPU6502Core.scala 33:24]
      nmiEdge <= 1'h0; // @[CPU6502Core.scala 33:24]
    end else if (io_reset) begin // @[CPU6502Core.scala 55:18]
      nmiEdge <= _GEN_0;
    end else if (~resetReleased) begin // @[CPU6502Core.scala 62:26]
      nmiEdge <= _GEN_0;
    end else if (3'h0 == state) begin // @[CPU6502Core.scala 67:21]
      nmiEdge <= _GEN_0;
    end else begin
      nmiEdge <= _GEN_1558;
    end
    if (reset) begin // @[CPU6502Core.scala 52:30]
      resetReleased <= 1'h0; // @[CPU6502Core.scala 52:30]
    end else if (io_reset) begin // @[CPU6502Core.scala 55:18]
      resetReleased <= 1'h0; // @[CPU6502Core.scala 60:19]
    end else begin
      resetReleased <= _GEN_1638;
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
  wire [2:0] _GEN_45 = _T_3 ? io_cpuAddr[2:0] : _GEN_35; // @[MemoryController.scala 88:65 90:18]
  wire [7:0] _GEN_46 = _T_3 ? io_cpuDataIn : 8'h0; // @[MemoryController.scala 44:16 88:65 91:20]
  wire  _GEN_50 = _T_3 ? 1'h0 : _T_6; // @[MemoryController.scala 39:19 88:65]
  wire [2:0] _GEN_58 = _T ? _GEN_35 : _GEN_45; // @[MemoryController.scala 84:33]
  wire [7:0] _GEN_59 = _T ? 8'h0 : _GEN_46; // @[MemoryController.scala 44:16 84:33]
  wire  _GEN_63 = _T ? 1'h0 : _GEN_50; // @[MemoryController.scala 39:19 84:33]
  wire  _T_12 = io_romLoadEn & io_romLoadPRG; // @[MemoryController.scala 101:21]
  wire  _T_13 = io_romLoadAddr < 16'h8000; // @[MemoryController.scala 103:25]
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
  assign prgROM_MPORT_2_en = _T_12 & _T_13;
  assign io_cpuDataOut = io_cpuRead ? _GEN_25 : 8'h0; // @[MemoryController.scala 42:17 57:20]
  assign io_ppuAddr = io_cpuWrite ? _GEN_58 : _GEN_35; // @[MemoryController.scala 83:21]
  assign io_ppuDataIn = io_cpuWrite ? _GEN_59 : 8'h0; // @[MemoryController.scala 44:16 83:21]
  assign io_ppuWrite = io_cpuWrite & _GEN_27; // @[MemoryController.scala 45:15 83:21]
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
