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
  input         io_reset
);
  reg [7:0] regs_a; // @[CPU6502Core.scala 20:21]
  reg [7:0] regs_x; // @[CPU6502Core.scala 20:21]
  reg [7:0] regs_y; // @[CPU6502Core.scala 20:21]
  reg [7:0] regs_sp; // @[CPU6502Core.scala 20:21]
  reg [15:0] regs_pc; // @[CPU6502Core.scala 20:21]
  reg  regs_flagC; // @[CPU6502Core.scala 20:21]
  reg  regs_flagZ; // @[CPU6502Core.scala 20:21]
  reg  regs_flagI; // @[CPU6502Core.scala 20:21]
  reg  regs_flagD; // @[CPU6502Core.scala 20:21]
  reg  regs_flagV; // @[CPU6502Core.scala 20:21]
  reg  regs_flagN; // @[CPU6502Core.scala 20:21]
  reg [1:0] state; // @[CPU6502Core.scala 24:22]
  reg [7:0] opcode; // @[CPU6502Core.scala 26:24]
  reg [15:0] operand; // @[CPU6502Core.scala 27:24]
  reg [2:0] cycle; // @[CPU6502Core.scala 28:24]
  wire [1:0] _GEN_0 = io_reset ? 2'h0 : state; // @[CPU6502Core.scala 41:18 42:11 24:22]
  wire [2:0] _GEN_1 = io_reset ? 3'h0 : cycle; // @[CPU6502Core.scala 41:18 43:11 28:24]
  wire  _T_2 = cycle == 3'h1; // @[CPU6502Core.scala 55:24]
  wire [15:0] resetVector = {io_memDataIn,operand[7:0]}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_2 = cycle == 3'h1 ? 16'hfffd : regs_pc; // @[CPU6502Core.scala 31:17 55:33 56:20]
  wire [15:0] _GEN_7 = cycle == 3'h0 ? 16'hfffc : _GEN_2; // @[CPU6502Core.scala 50:27 51:20]
  wire  _GEN_8 = cycle == 3'h0 | _T_2; // @[CPU6502Core.scala 50:27 52:20]
  wire [15:0] _regs_pc_T_1 = regs_pc + 16'h1; // @[CPU6502Core.scala 69:26]
  wire  _execResult_T = 8'h18 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_1 = 8'h38 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_2 = 8'hd8 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_3 = 8'hf8 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_4 = 8'h58 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_5 = 8'h78 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_6 = 8'hb8 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _GEN_13 = _execResult_T_6 ? 1'h0 : regs_flagV; // @[Flag.scala 14:13 24:20 31:34]
  wire  _GEN_14 = _execResult_T_5 | regs_flagI; // @[Flag.scala 14:13 24:20 30:34]
  wire  _GEN_15 = _execResult_T_5 ? regs_flagV : _GEN_13; // @[Flag.scala 14:13 24:20]
  wire  _GEN_16 = _execResult_T_4 ? 1'h0 : _GEN_14; // @[Flag.scala 24:20 29:34]
  wire  _GEN_17 = _execResult_T_4 ? regs_flagV : _GEN_15; // @[Flag.scala 14:13 24:20]
  wire  _GEN_18 = _execResult_T_3 | regs_flagD; // @[Flag.scala 14:13 24:20 28:34]
  wire  _GEN_19 = _execResult_T_3 ? regs_flagI : _GEN_16; // @[Flag.scala 14:13 24:20]
  wire  _GEN_20 = _execResult_T_3 ? regs_flagV : _GEN_17; // @[Flag.scala 14:13 24:20]
  wire  _GEN_21 = _execResult_T_2 ? 1'h0 : _GEN_18; // @[Flag.scala 24:20 27:34]
  wire  _GEN_22 = _execResult_T_2 ? regs_flagI : _GEN_19; // @[Flag.scala 14:13 24:20]
  wire  _GEN_23 = _execResult_T_2 ? regs_flagV : _GEN_20; // @[Flag.scala 14:13 24:20]
  wire  _GEN_24 = _execResult_T_1 | regs_flagC; // @[Flag.scala 14:13 24:20 26:34]
  wire  _GEN_25 = _execResult_T_1 ? regs_flagD : _GEN_21; // @[Flag.scala 14:13 24:20]
  wire  _GEN_26 = _execResult_T_1 ? regs_flagI : _GEN_22; // @[Flag.scala 14:13 24:20]
  wire  _GEN_27 = _execResult_T_1 ? regs_flagV : _GEN_23; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagC = _execResult_T ? 1'h0 : _GEN_24; // @[Flag.scala 24:20 25:34]
  wire  execResult_result_newRegs_flagD = _execResult_T ? regs_flagD : _GEN_25; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagI = _execResult_T ? regs_flagI : _GEN_26; // @[Flag.scala 14:13 24:20]
  wire  execResult_result_newRegs_flagV = _execResult_T ? regs_flagV : _GEN_27; // @[Flag.scala 14:13 24:20]
  wire  _execResult_T_15 = 8'haa == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_16 = 8'ha8 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_17 = 8'h8a == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_18 = 8'h98 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_19 = 8'hba == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_20 = 8'h9a == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_result_newRegs_flagZ_T = regs_a == 8'h0; // @[Transfer.scala 28:33]
  wire [7:0] _GEN_32 = _execResult_T_20 ? regs_x : regs_sp; // @[Transfer.scala 14:13 24:20 51:20]
  wire [7:0] _GEN_33 = _execResult_T_19 ? regs_sp : regs_x; // @[Transfer.scala 14:13 24:20 46:19]
  wire  _GEN_34 = _execResult_T_19 ? regs_sp[7] : regs_flagN; // @[Transfer.scala 14:13 24:20 47:23]
  wire  _GEN_35 = _execResult_T_19 ? regs_sp == 8'h0 : regs_flagZ; // @[Transfer.scala 14:13 24:20 48:23]
  wire [7:0] _GEN_36 = _execResult_T_19 ? regs_sp : _GEN_32; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_37 = _execResult_T_18 ? regs_y : regs_a; // @[Transfer.scala 14:13 24:20 41:19]
  wire  _GEN_38 = _execResult_T_18 ? regs_y[7] : _GEN_34; // @[Transfer.scala 24:20 42:23]
  wire  _GEN_39 = _execResult_T_18 ? regs_y == 8'h0 : _GEN_35; // @[Transfer.scala 24:20 43:23]
  wire [7:0] _GEN_40 = _execResult_T_18 ? regs_x : _GEN_33; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_41 = _execResult_T_18 ? regs_sp : _GEN_36; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_42 = _execResult_T_17 ? regs_x : _GEN_37; // @[Transfer.scala 24:20 36:19]
  wire  _GEN_43 = _execResult_T_17 ? regs_x[7] : _GEN_38; // @[Transfer.scala 24:20 37:23]
  wire  _GEN_44 = _execResult_T_17 ? regs_x == 8'h0 : _GEN_39; // @[Transfer.scala 24:20 38:23]
  wire [7:0] _GEN_45 = _execResult_T_17 ? regs_x : _GEN_40; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_46 = _execResult_T_17 ? regs_sp : _GEN_41; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_47 = _execResult_T_16 ? regs_a : regs_y; // @[Transfer.scala 14:13 24:20 31:19]
  wire  _GEN_48 = _execResult_T_16 ? regs_a[7] : _GEN_43; // @[Transfer.scala 24:20 32:23]
  wire  _GEN_49 = _execResult_T_16 ? _execResult_result_newRegs_flagZ_T : _GEN_44; // @[Transfer.scala 24:20 33:23]
  wire [7:0] _GEN_50 = _execResult_T_16 ? regs_a : _GEN_42; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_51 = _execResult_T_16 ? regs_x : _GEN_45; // @[Transfer.scala 14:13 24:20]
  wire [7:0] _GEN_52 = _execResult_T_16 ? regs_sp : _GEN_46; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_x = _execResult_T_15 ? regs_a : _GEN_51; // @[Transfer.scala 24:20 26:19]
  wire  execResult_result_newRegs_1_flagN = _execResult_T_15 ? regs_a[7] : _GEN_48; // @[Transfer.scala 24:20 27:23]
  wire  execResult_result_newRegs_1_flagZ = _execResult_T_15 ? regs_a == 8'h0 : _GEN_49; // @[Transfer.scala 24:20 28:23]
  wire [7:0] execResult_result_newRegs_1_y = _execResult_T_15 ? regs_y : _GEN_47; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_a = _execResult_T_15 ? regs_a : _GEN_50; // @[Transfer.scala 14:13 24:20]
  wire [7:0] execResult_result_newRegs_1_sp = _execResult_T_15 ? regs_sp : _GEN_52; // @[Transfer.scala 14:13 24:20]
  wire  _execResult_T_26 = 8'he8 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_27 = 8'hc8 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_28 = 8'hca == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_29 = 8'h88 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_30 = 8'h1a == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_31 = 8'h3a == opcode; // @[CPU6502Core.scala 113:20]
  wire [7:0] execResult_result_res = regs_x + 8'h1; // @[Arithmetic.scala 34:26]
  wire [7:0] execResult_result_res_1 = regs_y + 8'h1; // @[Arithmetic.scala 40:26]
  wire [7:0] execResult_result_res_2 = regs_x - 8'h1; // @[Arithmetic.scala 46:26]
  wire [7:0] execResult_result_res_3 = regs_y - 8'h1; // @[Arithmetic.scala 52:26]
  wire [7:0] execResult_result_res_4 = regs_a + 8'h1; // @[Arithmetic.scala 58:26]
  wire [7:0] execResult_result_res_5 = regs_a - 8'h1; // @[Arithmetic.scala 64:26]
  wire [7:0] _GEN_59 = _execResult_T_31 ? execResult_result_res_5 : regs_a; // @[Arithmetic.scala 22:13 32:20 65:19]
  wire  _GEN_60 = _execResult_T_31 ? execResult_result_res_5[7] : regs_flagN; // @[Arithmetic.scala 22:13 32:20 66:23]
  wire  _GEN_61 = _execResult_T_31 ? execResult_result_res_5 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 22:13 32:20 67:23]
  wire [7:0] _GEN_62 = _execResult_T_30 ? execResult_result_res_4 : _GEN_59; // @[Arithmetic.scala 32:20 59:19]
  wire  _GEN_63 = _execResult_T_30 ? execResult_result_res_4[7] : _GEN_60; // @[Arithmetic.scala 32:20 60:23]
  wire  _GEN_64 = _execResult_T_30 ? execResult_result_res_4 == 8'h0 : _GEN_61; // @[Arithmetic.scala 32:20 61:23]
  wire [7:0] _GEN_65 = _execResult_T_29 ? execResult_result_res_3 : regs_y; // @[Arithmetic.scala 22:13 32:20 53:19]
  wire  _GEN_66 = _execResult_T_29 ? execResult_result_res_3[7] : _GEN_63; // @[Arithmetic.scala 32:20 54:23]
  wire  _GEN_67 = _execResult_T_29 ? execResult_result_res_3 == 8'h0 : _GEN_64; // @[Arithmetic.scala 32:20 55:23]
  wire [7:0] _GEN_68 = _execResult_T_29 ? regs_a : _GEN_62; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] _GEN_69 = _execResult_T_28 ? execResult_result_res_2 : regs_x; // @[Arithmetic.scala 22:13 32:20 47:19]
  wire  _GEN_70 = _execResult_T_28 ? execResult_result_res_2[7] : _GEN_66; // @[Arithmetic.scala 32:20 48:23]
  wire  _GEN_71 = _execResult_T_28 ? execResult_result_res_2 == 8'h0 : _GEN_67; // @[Arithmetic.scala 32:20 49:23]
  wire [7:0] _GEN_72 = _execResult_T_28 ? regs_y : _GEN_65; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] _GEN_73 = _execResult_T_28 ? regs_a : _GEN_68; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] _GEN_74 = _execResult_T_27 ? execResult_result_res_1 : _GEN_72; // @[Arithmetic.scala 32:20 41:19]
  wire  _GEN_75 = _execResult_T_27 ? execResult_result_res_1[7] : _GEN_70; // @[Arithmetic.scala 32:20 42:23]
  wire  _GEN_76 = _execResult_T_27 ? execResult_result_res_1 == 8'h0 : _GEN_71; // @[Arithmetic.scala 32:20 43:23]
  wire [7:0] _GEN_77 = _execResult_T_27 ? regs_x : _GEN_69; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] _GEN_78 = _execResult_T_27 ? regs_a : _GEN_73; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] execResult_result_newRegs_2_x = _execResult_T_26 ? execResult_result_res : _GEN_77; // @[Arithmetic.scala 32:20 35:19]
  wire  execResult_result_newRegs_2_flagN = _execResult_T_26 ? execResult_result_res[7] : _GEN_75; // @[Arithmetic.scala 32:20 36:23]
  wire  execResult_result_newRegs_2_flagZ = _execResult_T_26 ? execResult_result_res == 8'h0 : _GEN_76; // @[Arithmetic.scala 32:20 37:23]
  wire [7:0] execResult_result_newRegs_2_y = _execResult_T_26 ? regs_y : _GEN_74; // @[Arithmetic.scala 22:13 32:20]
  wire [7:0] execResult_result_newRegs_2_a = _execResult_T_26 ? regs_a : _GEN_78; // @[Arithmetic.scala 22:13 32:20]
  wire [8:0] _execResult_result_sum_T = regs_a + io_memDataIn; // @[Arithmetic.scala 81:22]
  wire [8:0] _GEN_1560 = {{8'd0}, regs_flagC}; // @[Arithmetic.scala 81:35]
  wire [9:0] execResult_result_sum = _execResult_result_sum_T + _GEN_1560; // @[Arithmetic.scala 81:35]
  wire [7:0] execResult_result_newRegs_3_a = execResult_result_sum[7:0]; // @[Arithmetic.scala 82:21]
  wire  execResult_result_newRegs_3_flagC = execResult_result_sum[8]; // @[Arithmetic.scala 83:25]
  wire  execResult_result_newRegs_3_flagN = execResult_result_sum[7]; // @[Arithmetic.scala 84:25]
  wire  execResult_result_newRegs_3_flagZ = execResult_result_newRegs_3_a == 8'h0; // @[Arithmetic.scala 85:32]
  wire  execResult_result_newRegs_3_flagV = regs_a[7] == io_memDataIn[7] & regs_a[7] !=
    execResult_result_newRegs_3_flagN; // @[Arithmetic.scala 86:51]
  wire [8:0] _execResult_result_diff_T = regs_a - io_memDataIn; // @[Arithmetic.scala 106:23]
  wire  _execResult_result_diff_T_2 = ~regs_flagC; // @[Arithmetic.scala 106:40]
  wire [8:0] _GEN_1561 = {{8'd0}, _execResult_result_diff_T_2}; // @[Arithmetic.scala 106:36]
  wire [9:0] execResult_result_diff = _execResult_result_diff_T - _GEN_1561; // @[Arithmetic.scala 106:36]
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
  wire [15:0] _GEN_84 = 3'h2 == cycle ? operand : 16'h0; // @[Arithmetic.scala 140:19 134:20 155:24]
  wire [7:0] _GEN_85 = 3'h2 == cycle ? execResult_result_res_6 : 8'h0; // @[Arithmetic.scala 140:19 135:20 157:24]
  wire  _GEN_87 = 3'h2 == cycle ? execResult_result_res_6[7] : regs_flagN; // @[Arithmetic.scala 129:13 140:19 159:23]
  wire  _GEN_88 = 3'h2 == cycle ? execResult_result_res_6 == 8'h0 : regs_flagZ; // @[Arithmetic.scala 129:13 140:19 160:23]
  wire [15:0] execResult_result_newRegs_5_pc = 3'h0 == cycle ? _regs_pc_T_1 : regs_pc; // @[Arithmetic.scala 129:13 140:19 145:20]
  wire  _GEN_107 = 3'h1 == cycle ? regs_flagZ : _GEN_88; // @[Arithmetic.scala 129:13 140:19]
  wire  execResult_result_newRegs_5_flagZ = 3'h0 == cycle ? regs_flagZ : _GEN_107; // @[Arithmetic.scala 129:13 140:19]
  wire  _GEN_106 = 3'h1 == cycle ? regs_flagN : _GEN_87; // @[Arithmetic.scala 129:13 140:19]
  wire  execResult_result_newRegs_5_flagN = 3'h0 == cycle ? regs_flagN : _GEN_106; // @[Arithmetic.scala 129:13 140:19]
  wire [15:0] _GEN_101 = 3'h1 == cycle ? operand : _GEN_84; // @[Arithmetic.scala 140:19 150:24]
  wire [2:0] _GEN_103 = 3'h1 == cycle ? 3'h2 : _execResult_result_result_nextCycle_T_1; // @[Arithmetic.scala 140:19 132:22 152:26]
  wire [7:0] _GEN_104 = 3'h1 == cycle ? 8'h0 : _GEN_85; // @[Arithmetic.scala 140:19 135:20]
  wire  _GEN_105 = 3'h1 == cycle ? 1'h0 : 3'h2 == cycle; // @[Arithmetic.scala 140:19 136:21]
  wire [15:0] execResult_result_result_6_memAddr = 3'h0 == cycle ? regs_pc : _GEN_101; // @[Arithmetic.scala 140:19 142:24]
  wire  execResult_result_result_6_memRead = 3'h0 == cycle | 3'h1 == cycle; // @[Arithmetic.scala 140:19 143:24]
  wire [15:0] execResult_result_result_6_operand = 3'h0 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Arithmetic.scala 140:19 138:20 144:24]
  wire [2:0] execResult_result_result_6_nextCycle = 3'h0 == cycle ? 3'h1 : _GEN_103; // @[Arithmetic.scala 140:19 147:26]
  wire [7:0] execResult_result_result_6_memData = 3'h0 == cycle ? 8'h0 : _GEN_104; // @[Arithmetic.scala 140:19 135:20]
  wire  execResult_result_result_6_done = 3'h0 == cycle ? 1'h0 : _GEN_105; // @[Arithmetic.scala 140:19 136:21]
  wire  _execResult_T_42 = 8'h29 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_43 = 8'h9 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_44 = 8'h49 == opcode; // @[CPU6502Core.scala 113:20]
  wire [7:0] _execResult_result_res_T_11 = regs_a & io_memDataIn; // @[Logic.scala 24:34]
  wire [7:0] _execResult_result_res_T_12 = regs_a | io_memDataIn; // @[Logic.scala 25:34]
  wire [7:0] _execResult_result_res_T_13 = regs_a ^ io_memDataIn; // @[Logic.scala 26:34]
  wire [7:0] _GEN_141 = _execResult_T_44 ? _execResult_result_res_T_13 : 8'h0; // @[Logic.scala 23:20 26:24 21:9]
  wire [7:0] _GEN_142 = _execResult_T_43 ? _execResult_result_res_T_12 : _GEN_141; // @[Logic.scala 23:20 25:24]
  wire [7:0] execResult_result_res_7 = _execResult_T_42 ? _execResult_result_res_T_11 : _GEN_142; // @[Logic.scala 23:20 24:24]
  wire  execResult_result_newRegs_6_flagN = execResult_result_res_7[7]; // @[Logic.scala 30:25]
  wire  execResult_result_newRegs_6_flagZ = execResult_result_res_7 == 8'h0; // @[Logic.scala 31:26]
  wire [15:0] _GEN_144 = _execResult_result_T_21 ? operand : 16'h0; // @[Logic.scala 60:19 54:20 70:24]
  wire  _GEN_146 = _execResult_result_T_21 ? _execResult_result_res_T_11 == 8'h0 : regs_flagZ; // @[Logic.scala 49:13 60:19 72:23]
  wire  _GEN_147 = _execResult_result_T_21 ? io_memDataIn[7] : regs_flagN; // @[Logic.scala 49:13 60:19 73:23]
  wire  _GEN_148 = _execResult_result_T_21 ? io_memDataIn[6] : regs_flagV; // @[Logic.scala 49:13 60:19 74:23]
  wire  execResult_result_newRegs_7_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_146; // @[Logic.scala 49:13 60:19]
  wire  execResult_result_newRegs_7_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_148; // @[Logic.scala 49:13 60:19]
  wire  execResult_result_newRegs_7_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_147; // @[Logic.scala 49:13 60:19]
  wire [15:0] execResult_result_result_8_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_144; // @[Logic.scala 60:19 62:24]
  wire [2:0] execResult_result_result_8_nextCycle = _execResult_result_T_20 ? 3'h1 :
    _execResult_result_result_nextCycle_T_1; // @[Logic.scala 60:19 52:22 67:26]
  wire  execResult_result_result_8_done = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21; // @[Logic.scala 51:17 60:19]
  wire  _execResult_T_48 = 8'ha == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_49 = 8'h4a == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_50 = 8'h2a == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_51 = 8'h6a == opcode; // @[CPU6502Core.scala 113:20]
  wire [8:0] _execResult_result_res_T_14 = {regs_a, 1'h0}; // @[Shift.scala 35:24]
  wire [7:0] _execResult_result_res_T_18 = {regs_a[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_20 = {regs_flagC,regs_a[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_182 = _execResult_T_51 ? regs_a[0] : regs_flagC; // @[Shift.scala 18:13 32:20 46:23]
  wire [7:0] _GEN_183 = _execResult_T_51 ? _execResult_result_res_T_20 : regs_a; // @[Shift.scala 32:20 47:13 29:9]
  wire  _GEN_184 = _execResult_T_50 ? regs_a[7] : _GEN_182; // @[Shift.scala 32:20 42:23]
  wire [7:0] _GEN_185 = _execResult_T_50 ? _execResult_result_res_T_18 : _GEN_183; // @[Shift.scala 32:20 43:13]
  wire  _GEN_186 = _execResult_T_49 ? regs_a[0] : _GEN_184; // @[Shift.scala 32:20 38:23]
  wire [7:0] _GEN_187 = _execResult_T_49 ? {{1'd0}, regs_a[7:1]} : _GEN_185; // @[Shift.scala 32:20 39:13]
  wire  execResult_result_newRegs_8_flagC = _execResult_T_48 ? regs_a[7] : _GEN_186; // @[Shift.scala 32:20 34:23]
  wire [7:0] execResult_result_res_8 = _execResult_T_48 ? _execResult_result_res_T_14[7:0] : _GEN_187; // @[Shift.scala 32:20 35:13]
  wire  execResult_result_newRegs_8_flagN = execResult_result_res_8[7]; // @[Shift.scala 52:25]
  wire  execResult_result_newRegs_8_flagZ = execResult_result_res_8 == 8'h0; // @[Shift.scala 53:26]
  wire  _execResult_T_55 = 8'h6 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_56 = 8'h46 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_57 = 8'h26 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_58 = 8'h66 == opcode; // @[CPU6502Core.scala 113:20]
  wire [8:0] _execResult_result_res_T_21 = {io_memDataIn, 1'h0}; // @[Shift.scala 95:31]
  wire [7:0] _execResult_result_res_T_25 = {io_memDataIn[6:0],regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_res_T_27 = {regs_flagC,io_memDataIn[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_190 = _execResult_T_58 ? io_memDataIn[0] : regs_flagC; // @[Shift.scala 92:24 108:27 62:13]
  wire [7:0] _GEN_191 = _execResult_T_58 ? _execResult_result_res_T_27 : 8'h0; // @[Shift.scala 109:17 90:13 92:24]
  wire  _GEN_192 = _execResult_T_57 ? io_memDataIn[7] : _GEN_190; // @[Shift.scala 92:24 103:27]
  wire [7:0] _GEN_193 = _execResult_T_57 ? _execResult_result_res_T_25 : _GEN_191; // @[Shift.scala 104:17 92:24]
  wire  _GEN_194 = _execResult_T_56 ? io_memDataIn[0] : _GEN_192; // @[Shift.scala 92:24 98:27]
  wire [7:0] _GEN_195 = _execResult_T_56 ? {{1'd0}, io_memDataIn[7:1]} : _GEN_193; // @[Shift.scala 92:24 99:17]
  wire  _GEN_196 = _execResult_T_55 ? io_memDataIn[7] : _GEN_194; // @[Shift.scala 92:24 94:27]
  wire [7:0] execResult_result_res_9 = _execResult_T_55 ? _execResult_result_res_T_21[7:0] : _GEN_195; // @[Shift.scala 92:24 95:17]
  wire  _GEN_199 = _execResult_result_T_22 ? _GEN_196 : regs_flagC; // @[Shift.scala 62:13 73:19]
  wire [7:0] _GEN_200 = _execResult_result_T_22 ? execResult_result_res_9 : 8'h0; // @[Shift.scala 73:19 113:24 68:20]
  wire  _GEN_202 = _execResult_result_T_22 ? execResult_result_res_9[7] : regs_flagN; // @[Shift.scala 73:19 115:23 62:13]
  wire  _GEN_203 = _execResult_result_T_22 ? execResult_result_res_9 == 8'h0 : regs_flagZ; // @[Shift.scala 73:19 116:23 62:13]
  wire  _GEN_219 = _execResult_result_T_21 ? regs_flagC : _GEN_199; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_9_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_219; // @[Shift.scala 62:13 73:19]
  wire  _GEN_223 = _execResult_result_T_21 ? regs_flagZ : _GEN_203; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_9_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_223; // @[Shift.scala 62:13 73:19]
  wire  _GEN_222 = _execResult_result_T_21 ? regs_flagN : _GEN_202; // @[Shift.scala 62:13 73:19]
  wire  execResult_result_newRegs_9_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_222; // @[Shift.scala 62:13 73:19]
  wire [7:0] _GEN_220 = _execResult_result_T_21 ? 8'h0 : _GEN_200; // @[Shift.scala 73:19 68:20]
  wire [7:0] execResult_result_result_10_memData = _execResult_result_T_20 ? 8'h0 : _GEN_220; // @[Shift.scala 73:19 68:20]
  wire  _execResult_T_62 = 8'hc9 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_63 = 8'he0 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_64 = 8'hc0 == opcode; // @[CPU6502Core.scala 113:20]
  wire [7:0] _GEN_258 = _execResult_T_64 ? regs_y : regs_a; // @[Compare.scala 21:14 23:20 26:29]
  wire [7:0] _GEN_259 = _execResult_T_63 ? regs_x : _GEN_258; // @[Compare.scala 23:20 25:29]
  wire [7:0] execResult_result_regValue = _execResult_T_62 ? regs_a : _GEN_259; // @[Compare.scala 23:20 24:29]
  wire [8:0] execResult_result_diff_1 = execResult_result_regValue - io_memDataIn; // @[Compare.scala 29:25]
  wire  execResult_result_newRegs_10_flagC = execResult_result_regValue >= io_memDataIn; // @[Compare.scala 30:31]
  wire  execResult_result_newRegs_10_flagZ = execResult_result_regValue == io_memDataIn; // @[Compare.scala 31:31]
  wire  execResult_result_newRegs_10_flagN = execResult_result_diff_1[7]; // @[Compare.scala 32:26]
  wire  _GEN_263 = _execResult_result_T_21 ? regs_a >= io_memDataIn : regs_flagC; // @[Compare.scala 50:13 61:19 74:23]
  wire  _GEN_264 = _execResult_result_T_21 ? regs_a == io_memDataIn : regs_flagZ; // @[Compare.scala 50:13 61:19 75:23]
  wire  _GEN_265 = _execResult_result_T_21 ? _execResult_result_diff_T[7] : regs_flagN; // @[Compare.scala 50:13 61:19 76:23]
  wire  execResult_result_newRegs_11_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_263; // @[Compare.scala 50:13 61:19]
  wire  execResult_result_newRegs_11_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_264; // @[Compare.scala 50:13 61:19]
  wire  execResult_result_newRegs_11_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_265; // @[Compare.scala 50:13 61:19]
  wire  _execResult_T_68 = 8'hf0 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_69 = 8'hd0 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_70 = 8'hb0 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_71 = 8'h90 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_72 = 8'h30 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_73 = 8'h10 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_74 = 8'h50 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_75 = 8'h70 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _GEN_299 = _execResult_T_74 & ~regs_flagV; // @[Branch.scala 18:16 20:20 28:31]
  wire  _GEN_300 = _execResult_T_75 ? regs_flagV : _GEN_299; // @[Branch.scala 20:20 27:31]
  wire  _GEN_301 = _execResult_T_73 ? ~regs_flagN : _GEN_300; // @[Branch.scala 20:20 26:31]
  wire  _GEN_302 = _execResult_T_72 ? regs_flagN : _GEN_301; // @[Branch.scala 20:20 25:31]
  wire  _GEN_303 = _execResult_T_71 ? _execResult_result_diff_T_2 : _GEN_302; // @[Branch.scala 20:20 24:31]
  wire  _GEN_304 = _execResult_T_70 ? regs_flagC : _GEN_303; // @[Branch.scala 20:20 23:31]
  wire  _GEN_305 = _execResult_T_69 ? ~regs_flagZ : _GEN_304; // @[Branch.scala 20:20 22:31]
  wire  execResult_result_takeBranch = _execResult_T_68 ? regs_flagZ : _GEN_305; // @[Branch.scala 20:20 21:31]
  wire [7:0] execResult_result_offset = io_memDataIn; // @[Branch.scala 32:28]
  wire [15:0] _GEN_1562 = {{8{execResult_result_offset[7]}},execResult_result_offset}; // @[Branch.scala 34:51]
  wire [15:0] _execResult_result_newRegs_pc_T_20 = $signed(regs_pc) + $signed(_GEN_1562); // @[Branch.scala 34:61]
  wire [15:0] execResult_result_newRegs_12_pc = execResult_result_takeBranch ? _execResult_result_newRegs_pc_T_20 :
    regs_pc; // @[Branch.scala 34:22]
  wire  _execResult_T_83 = 8'ha9 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_84 = 8'ha2 == opcode; // @[CPU6502Core.scala 113:20]
  wire  _execResult_T_85 = 8'ha0 == opcode; // @[CPU6502Core.scala 113:20]
  wire [7:0] _GEN_307 = _execResult_T_85 ? io_memDataIn : regs_y; // @[LoadStore.scala 23:13 25:20 28:30]
  wire [7:0] _GEN_308 = _execResult_T_84 ? io_memDataIn : regs_x; // @[LoadStore.scala 23:13 25:20 27:30]
  wire [7:0] _GEN_309 = _execResult_T_84 ? regs_y : _GEN_307; // @[LoadStore.scala 23:13 25:20]
  wire [7:0] execResult_result_newRegs_13_a = _execResult_T_83 ? io_memDataIn : regs_a; // @[LoadStore.scala 23:13 25:20 26:30]
  wire [7:0] execResult_result_newRegs_13_x = _execResult_T_83 ? regs_x : _GEN_308; // @[LoadStore.scala 23:13 25:20]
  wire [7:0] execResult_result_newRegs_13_y = _execResult_T_83 ? regs_y : _GEN_309; // @[LoadStore.scala 23:13 25:20]
  wire  execResult_result_newRegs_13_flagZ = io_memDataIn == 8'h0; // @[LoadStore.scala 32:32]
  wire  execResult_result_isLoad = opcode == 8'ha5; // @[LoadStore.scala 61:25]
  wire  execResult_result_isStoreA = opcode == 8'h85; // @[LoadStore.scala 62:27]
  wire  execResult_result_isStoreX = opcode == 8'h86; // @[LoadStore.scala 63:27]
  wire [7:0] _execResult_result_result_memData_T = execResult_result_isStoreX ? regs_x : regs_y; // @[LoadStore.scala 84:54]
  wire [7:0] _execResult_result_result_memData_T_1 = execResult_result_isStoreA ? regs_a :
    _execResult_result_result_memData_T; // @[LoadStore.scala 84:32]
  wire [7:0] _GEN_314 = execResult_result_isLoad ? io_memDataIn : regs_a; // @[LoadStore.scala 50:13 77:22 79:21]
  wire  _GEN_315 = execResult_result_isLoad ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 50:13 77:22 80:25]
  wire  _GEN_316 = execResult_result_isLoad ? execResult_result_newRegs_13_flagZ : regs_flagZ; // @[LoadStore.scala 50:13 77:22 81:25]
  wire  _GEN_317 = execResult_result_isLoad ? 1'h0 : 1'h1; // @[LoadStore.scala 57:21 77:22 83:27]
  wire [7:0] _GEN_318 = execResult_result_isLoad ? 8'h0 : _execResult_result_result_memData_T_1; // @[LoadStore.scala 56:20 77:22 84:26]
  wire  _GEN_320 = _execResult_result_T_21 & execResult_result_isLoad; // @[LoadStore.scala 66:19 58:20]
  wire [7:0] _GEN_321 = _execResult_result_T_21 ? _GEN_314 : regs_a; // @[LoadStore.scala 50:13 66:19]
  wire  _GEN_322 = _execResult_result_T_21 ? _GEN_315 : regs_flagN; // @[LoadStore.scala 50:13 66:19]
  wire  _GEN_323 = _execResult_result_T_21 ? _GEN_316 : regs_flagZ; // @[LoadStore.scala 50:13 66:19]
  wire [7:0] _GEN_325 = _execResult_result_T_21 ? _GEN_318 : 8'h0; // @[LoadStore.scala 66:19 56:20]
  wire [7:0] execResult_result_newRegs_14_a = _execResult_result_T_20 ? regs_a : _GEN_321; // @[LoadStore.scala 50:13 66:19]
  wire  execResult_result_newRegs_14_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_323; // @[LoadStore.scala 50:13 66:19]
  wire  execResult_result_newRegs_14_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_322; // @[LoadStore.scala 50:13 66:19]
  wire  execResult_result_result_15_memRead = _execResult_result_T_20 | _GEN_320; // @[LoadStore.scala 66:19 69:24]
  wire  execResult_result_result_15_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_317; // @[LoadStore.scala 66:19 57:21]
  wire [7:0] execResult_result_result_15_memData = _execResult_result_T_20 ? 8'h0 : _GEN_325; // @[LoadStore.scala 66:19 56:20]
  wire  execResult_result_isLoad_1 = opcode == 8'hb5; // @[LoadStore.scala 109:25]
  wire [7:0] _execResult_result_result_operand_T_1 = io_memDataIn + regs_x; // @[LoadStore.scala 115:38]
  wire [7:0] _GEN_363 = execResult_result_isLoad_1 ? io_memDataIn : regs_a; // @[LoadStore.scala 122:22 124:21 98:13]
  wire  _GEN_364 = execResult_result_isLoad_1 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 122:22 125:25 98:13]
  wire  _GEN_365 = execResult_result_isLoad_1 ? execResult_result_newRegs_13_flagZ : regs_flagZ; // @[LoadStore.scala 122:22 126:25 98:13]
  wire  _GEN_366 = execResult_result_isLoad_1 ? 1'h0 : 1'h1; // @[LoadStore.scala 105:21 122:22 128:27]
  wire [7:0] _GEN_367 = execResult_result_isLoad_1 ? 8'h0 : regs_a; // @[LoadStore.scala 104:20 122:22 129:26]
  wire  _GEN_369 = _execResult_result_T_21 & execResult_result_isLoad_1; // @[LoadStore.scala 111:19 106:20]
  wire [7:0] _GEN_370 = _execResult_result_T_21 ? _GEN_363 : regs_a; // @[LoadStore.scala 111:19 98:13]
  wire  _GEN_371 = _execResult_result_T_21 ? _GEN_364 : regs_flagN; // @[LoadStore.scala 111:19 98:13]
  wire  _GEN_372 = _execResult_result_T_21 ? _GEN_365 : regs_flagZ; // @[LoadStore.scala 111:19 98:13]
  wire [7:0] _GEN_374 = _execResult_result_T_21 ? _GEN_367 : 8'h0; // @[LoadStore.scala 111:19 104:20]
  wire [7:0] execResult_result_newRegs_15_a = _execResult_result_T_20 ? regs_a : _GEN_370; // @[LoadStore.scala 111:19 98:13]
  wire  execResult_result_newRegs_15_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_372; // @[LoadStore.scala 111:19 98:13]
  wire  execResult_result_newRegs_15_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_371; // @[LoadStore.scala 111:19 98:13]
  wire  execResult_result_result_16_memRead = _execResult_result_T_20 | _GEN_369; // @[LoadStore.scala 111:19 114:24]
  wire [15:0] execResult_result_result_16_operand = _execResult_result_T_20 ? {{8'd0},
    _execResult_result_result_operand_T_1} : operand; // @[LoadStore.scala 111:19 107:20 115:24]
  wire  execResult_result_result_16_memWrite = _execResult_result_T_20 ? 1'h0 : _execResult_result_T_21 & _GEN_366; // @[LoadStore.scala 111:19 105:21]
  wire [7:0] execResult_result_result_16_memData = _execResult_result_T_20 ? 8'h0 : _GEN_374; // @[LoadStore.scala 111:19 104:20]
  wire  execResult_result_isLoad_2 = opcode == 8'had; // @[LoadStore.scala 154:25]
  wire [7:0] _GEN_412 = execResult_result_isLoad_2 ? io_memDataIn : regs_a; // @[LoadStore.scala 143:13 175:22 177:21]
  wire  _GEN_413 = execResult_result_isLoad_2 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 143:13 175:22 178:25]
  wire  _GEN_414 = execResult_result_isLoad_2 ? execResult_result_newRegs_13_flagZ : regs_flagZ; // @[LoadStore.scala 143:13 175:22 179:25]
  wire  _GEN_415 = execResult_result_isLoad_2 ? 1'h0 : 1'h1; // @[LoadStore.scala 150:21 175:22 181:27]
  wire [7:0] _GEN_416 = execResult_result_isLoad_2 ? 8'h0 : regs_a; // @[LoadStore.scala 149:20 175:22 182:26]
  wire  _GEN_418 = _execResult_result_T_22 & execResult_result_isLoad_2; // @[LoadStore.scala 156:19 151:20]
  wire [7:0] _GEN_419 = _execResult_result_T_22 ? _GEN_412 : regs_a; // @[LoadStore.scala 143:13 156:19]
  wire  _GEN_420 = _execResult_result_T_22 ? _GEN_413 : regs_flagN; // @[LoadStore.scala 143:13 156:19]
  wire  _GEN_421 = _execResult_result_T_22 ? _GEN_414 : regs_flagZ; // @[LoadStore.scala 143:13 156:19]
  wire [7:0] _GEN_423 = _execResult_result_T_22 ? _GEN_416 : 8'h0; // @[LoadStore.scala 156:19 149:20]
  wire [7:0] _GEN_454 = _execResult_result_T_21 ? regs_a : _GEN_419; // @[LoadStore.scala 143:13 156:19]
  wire [7:0] execResult_result_newRegs_16_a = _execResult_result_T_20 ? regs_a : _GEN_454; // @[LoadStore.scala 143:13 156:19]
  wire [15:0] _GEN_440 = _execResult_result_T_21 ? _regs_pc_T_1 : regs_pc; // @[LoadStore.scala 143:13 156:19 169:20]
  wire [15:0] execResult_result_newRegs_16_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_440; // @[LoadStore.scala 156:19 161:20]
  wire  _GEN_456 = _execResult_result_T_21 ? regs_flagZ : _GEN_421; // @[LoadStore.scala 143:13 156:19]
  wire  execResult_result_newRegs_16_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_456; // @[LoadStore.scala 143:13 156:19]
  wire  _GEN_455 = _execResult_result_T_21 ? regs_flagN : _GEN_420; // @[LoadStore.scala 143:13 156:19]
  wire  execResult_result_newRegs_16_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_455; // @[LoadStore.scala 143:13 156:19]
  wire [15:0] _GEN_437 = _execResult_result_T_21 ? regs_pc : _GEN_84; // @[LoadStore.scala 156:19 166:24]
  wire  _GEN_438 = _execResult_result_T_21 | _GEN_418; // @[LoadStore.scala 156:19 167:24]
  wire [15:0] _GEN_439 = _execResult_result_T_21 ? resetVector : operand; // @[LoadStore.scala 156:19 152:20 168:24]
  wire  _GEN_457 = _execResult_result_T_21 ? 1'h0 : _execResult_result_T_22 & _GEN_415; // @[LoadStore.scala 156:19 150:21]
  wire [7:0] _GEN_458 = _execResult_result_T_21 ? 8'h0 : _GEN_423; // @[LoadStore.scala 156:19 149:20]
  wire [15:0] execResult_result_result_17_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_437; // @[LoadStore.scala 156:19 158:24]
  wire  execResult_result_result_17_memRead = _execResult_result_T_20 | _GEN_438; // @[LoadStore.scala 156:19 159:24]
  wire [15:0] execResult_result_result_17_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_439; // @[LoadStore.scala 156:19 160:24]
  wire  execResult_result_result_17_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_457; // @[LoadStore.scala 156:19 150:21]
  wire [7:0] execResult_result_result_17_memData = _execResult_result_T_20 ? 8'h0 : _GEN_458; // @[LoadStore.scala 156:19 149:20]
  wire [7:0] execResult_result_indexReg = opcode == 8'hbd ? regs_x : regs_y; // @[LoadStore.scala 207:23]
  wire [15:0] _GEN_1563 = {{8'd0}, execResult_result_indexReg}; // @[LoadStore.scala 221:57]
  wire [15:0] _execResult_result_result_operand_T_8 = resetVector + _GEN_1563; // @[LoadStore.scala 221:57]
  wire [7:0] _GEN_485 = _execResult_result_T_22 ? io_memDataIn : regs_a; // @[LoadStore.scala 196:13 209:19 229:19]
  wire  _GEN_486 = _execResult_result_T_22 ? io_memDataIn[7] : regs_flagN; // @[LoadStore.scala 196:13 209:19 230:23]
  wire  _GEN_487 = _execResult_result_T_22 ? execResult_result_newRegs_13_flagZ : regs_flagZ; // @[LoadStore.scala 196:13 209:19 231:23]
  wire [7:0] _GEN_517 = _execResult_result_T_21 ? regs_a : _GEN_485; // @[LoadStore.scala 196:13 209:19]
  wire [7:0] execResult_result_newRegs_17_a = _execResult_result_T_20 ? regs_a : _GEN_517; // @[LoadStore.scala 196:13 209:19]
  wire  _GEN_519 = _execResult_result_T_21 ? regs_flagZ : _GEN_487; // @[LoadStore.scala 196:13 209:19]
  wire  execResult_result_newRegs_17_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_519; // @[LoadStore.scala 196:13 209:19]
  wire  _GEN_518 = _execResult_result_T_21 ? regs_flagN : _GEN_486; // @[LoadStore.scala 196:13 209:19]
  wire  execResult_result_newRegs_17_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_518; // @[LoadStore.scala 196:13 209:19]
  wire  _GEN_501 = _execResult_result_T_21 | _execResult_result_T_22; // @[LoadStore.scala 209:19 220:24]
  wire [15:0] _GEN_502 = _execResult_result_T_21 ? _execResult_result_result_operand_T_8 : operand; // @[LoadStore.scala 209:19 205:20 221:24]
  wire  execResult_result_result_18_memRead = _execResult_result_T_20 | _GEN_501; // @[LoadStore.scala 209:19 212:24]
  wire [15:0] execResult_result_result_18_operand = _execResult_result_T_20 ? {{8'd0}, io_memDataIn} : _GEN_502; // @[LoadStore.scala 209:19 213:24]
  wire [7:0] _execResult_result_pushData_T = {regs_flagN,regs_flagV,2'h3,regs_flagD,regs_flagI,regs_flagZ,regs_flagC}; // @[Cat.scala 33:92]
  wire [7:0] execResult_result_pushData = opcode == 8'h8 ? _execResult_result_pushData_T : regs_a; // @[Stack.scala 21:14 23:29 24:16]
  wire [7:0] execResult_result_newRegs_18_sp = regs_sp - 8'h1; // @[Stack.scala 27:27]
  wire [15:0] execResult_result_result_19_memAddr = {8'h1,regs_sp}; // @[Cat.scala 33:92]
  wire [7:0] _execResult_result_newRegs_sp_T_3 = regs_sp + 8'h1; // @[Stack.scala 57:31]
  wire [7:0] _GEN_543 = opcode == 8'h68 ? io_memDataIn : regs_a; // @[Stack.scala 44:13 65:33 66:21]
  wire  _GEN_544 = opcode == 8'h68 ? io_memDataIn[7] : io_memDataIn[7]; // @[Stack.scala 65:33 67:25 75:25]
  wire  _GEN_545 = opcode == 8'h68 ? execResult_result_newRegs_13_flagZ : io_memDataIn[1]; // @[Stack.scala 65:33 68:25 71:25]
  wire  _GEN_546 = opcode == 8'h68 ? regs_flagC : io_memDataIn[0]; // @[Stack.scala 44:13 65:33 70:25]
  wire  _GEN_547 = opcode == 8'h68 ? regs_flagI : io_memDataIn[2]; // @[Stack.scala 44:13 65:33 72:25]
  wire  _GEN_548 = opcode == 8'h68 ? regs_flagD : io_memDataIn[3]; // @[Stack.scala 44:13 65:33 73:25]
  wire  _GEN_549 = opcode == 8'h68 ? regs_flagV : io_memDataIn[6]; // @[Stack.scala 44:13 65:33 74:25]
  wire [15:0] _GEN_550 = _execResult_result_T_21 ? execResult_result_result_19_memAddr : 16'h0; // @[Stack.scala 55:19 49:20 62:24]
  wire [7:0] _GEN_552 = _execResult_result_T_21 ? _GEN_543 : regs_a; // @[Stack.scala 44:13 55:19]
  wire  _GEN_553 = _execResult_result_T_21 ? _GEN_544 : regs_flagN; // @[Stack.scala 44:13 55:19]
  wire  _GEN_554 = _execResult_result_T_21 ? _GEN_545 : regs_flagZ; // @[Stack.scala 44:13 55:19]
  wire  _GEN_555 = _execResult_result_T_21 ? _GEN_546 : regs_flagC; // @[Stack.scala 44:13 55:19]
  wire  _GEN_556 = _execResult_result_T_21 ? _GEN_547 : regs_flagI; // @[Stack.scala 44:13 55:19]
  wire  _GEN_557 = _execResult_result_T_21 ? _GEN_548 : regs_flagD; // @[Stack.scala 44:13 55:19]
  wire  _GEN_558 = _execResult_result_T_21 ? _GEN_549 : regs_flagV; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_19_a = _execResult_result_T_20 ? regs_a : _GEN_552; // @[Stack.scala 44:13 55:19]
  wire [7:0] execResult_result_newRegs_19_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Stack.scala 44:13 55:19 57:20]
  wire  execResult_result_newRegs_19_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_555; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_554; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_556; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_557; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagV = _execResult_result_T_20 ? regs_flagV : _GEN_558; // @[Stack.scala 44:13 55:19]
  wire  execResult_result_newRegs_19_flagN = _execResult_result_T_20 ? regs_flagN : _GEN_553; // @[Stack.scala 44:13 55:19]
  wire [15:0] execResult_result_result_20_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_550; // @[Stack.scala 55:19 49:20]
  wire [15:0] _GEN_594 = _execResult_result_T_21 ? regs_pc : 16'h0; // @[Jump.scala 26:19 20:20 36:24]
  wire [15:0] _GEN_596 = _execResult_result_T_21 ? resetVector : regs_pc; // @[Jump.scala 15:13 26:19 38:20]
  wire [15:0] execResult_result_newRegs_20_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_596; // @[Jump.scala 26:19 31:20]
  wire [15:0] execResult_result_result_21_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_594; // @[Jump.scala 26:19 28:24]
  wire  _execResult_result_T_74 = 3'h3 == cycle; // @[Jump.scala 62:19]
  wire [15:0] _GEN_627 = 3'h3 == cycle ? execResult_result_result_19_memAddr : 16'h0; // @[Jump.scala 62:19 56:20 86:24]
  wire [7:0] _GEN_628 = 3'h3 == cycle ? regs_pc[7:0] : 8'h0; // @[Jump.scala 62:19 57:20 87:24]
  wire [7:0] _GEN_630 = 3'h3 == cycle ? execResult_result_newRegs_18_sp : regs_sp; // @[Jump.scala 51:13 62:19 89:20]
  wire [15:0] _GEN_631 = 3'h3 == cycle ? operand : regs_pc; // @[Jump.scala 51:13 62:19 90:20]
  wire [7:0] _GEN_647 = _execResult_result_T_22 ? execResult_result_newRegs_18_sp : _GEN_630; // @[Jump.scala 62:19 81:20]
  wire [7:0] _GEN_669 = _execResult_result_T_21 ? regs_sp : _GEN_647; // @[Jump.scala 51:13 62:19]
  wire [7:0] execResult_result_newRegs_21_sp = _execResult_result_T_20 ? regs_sp : _GEN_669; // @[Jump.scala 51:13 62:19]
  wire [15:0] _GEN_661 = _execResult_result_T_22 ? regs_pc : _GEN_631; // @[Jump.scala 51:13 62:19]
  wire [15:0] _GEN_682 = _execResult_result_T_21 ? regs_pc : _GEN_661; // @[Jump.scala 51:13 62:19]
  wire [15:0] execResult_result_newRegs_21_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_682; // @[Jump.scala 62:19 67:20]
  wire [15:0] _GEN_644 = _execResult_result_T_22 ? execResult_result_result_19_memAddr : _GEN_627; // @[Jump.scala 62:19 78:24]
  wire [7:0] _GEN_645 = _execResult_result_T_22 ? regs_pc[15:8] : _GEN_628; // @[Jump.scala 62:19 79:24]
  wire  _GEN_646 = _execResult_result_T_22 | 3'h3 == cycle; // @[Jump.scala 62:19 80:25]
  wire [2:0] _GEN_660 = _execResult_result_T_22 ? 3'h3 : _execResult_result_result_nextCycle_T_1; // @[Jump.scala 62:19 54:22 83:26]
  wire  _GEN_662 = _execResult_result_T_22 ? 1'h0 : 3'h3 == cycle; // @[Jump.scala 53:17 62:19]
  wire [15:0] _GEN_663 = _execResult_result_T_21 ? regs_pc : _GEN_644; // @[Jump.scala 62:19 72:24]
  wire [2:0] _GEN_666 = _execResult_result_T_21 ? 3'h2 : _GEN_660; // @[Jump.scala 62:19 75:26]
  wire [7:0] _GEN_667 = _execResult_result_T_21 ? 8'h0 : _GEN_645; // @[Jump.scala 62:19 57:20]
  wire  _GEN_668 = _execResult_result_T_21 ? 1'h0 : _GEN_646; // @[Jump.scala 62:19 58:21]
  wire  _GEN_683 = _execResult_result_T_21 ? 1'h0 : _GEN_662; // @[Jump.scala 53:17 62:19]
  wire [15:0] execResult_result_result_22_memAddr = _execResult_result_T_20 ? regs_pc : _GEN_663; // @[Jump.scala 62:19 64:24]
  wire [2:0] execResult_result_result_22_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_666; // @[Jump.scala 62:19 69:26]
  wire [7:0] execResult_result_result_22_memData = _execResult_result_T_20 ? 8'h0 : _GEN_667; // @[Jump.scala 62:19 57:20]
  wire  execResult_result_result_22_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_668; // @[Jump.scala 62:19 58:21]
  wire  execResult_result_result_22_done = _execResult_result_T_20 ? 1'h0 : _GEN_683; // @[Jump.scala 53:17 62:19]
  wire [15:0] _execResult_result_newRegs_pc_T_45 = resetVector + 16'h1; // @[Jump.scala 131:53]
  wire [15:0] _GEN_705 = _execResult_result_T_22 ? execResult_result_result_19_memAddr : 16'h0; // @[Jump.scala 114:19 108:20 129:24]
  wire [15:0] _GEN_707 = _execResult_result_T_22 ? _execResult_result_newRegs_pc_T_45 : regs_pc; // @[Jump.scala 103:13 114:19 131:20]
  wire [7:0] _GEN_723 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 103:13 114:19 124:20]
  wire [7:0] execResult_result_newRegs_22_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_723; // @[Jump.scala 114:19 116:20]
  wire [15:0] _GEN_737 = _execResult_result_T_21 ? regs_pc : _GEN_707; // @[Jump.scala 103:13 114:19]
  wire [15:0] execResult_result_newRegs_22_pc = _execResult_result_T_20 ? regs_pc : _GEN_737; // @[Jump.scala 103:13 114:19]
  wire [15:0] _GEN_720 = _execResult_result_T_21 ? execResult_result_result_19_memAddr : _GEN_705; // @[Jump.scala 114:19 121:24]
  wire [15:0] _GEN_722 = _execResult_result_T_21 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 114:19 112:20 123:24]
  wire [15:0] execResult_result_result_23_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_720; // @[Jump.scala 114:19 108:20]
  wire  execResult_result_result_23_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_501; // @[Jump.scala 114:19 111:20]
  wire [15:0] execResult_result_result_23_operand = _execResult_result_T_20 ? operand : _GEN_722; // @[Jump.scala 114:19 112:20]
  wire [15:0] _GEN_758 = 3'h5 == cycle ? 16'hffff : 16'h0; // @[Jump.scala 155:19 149:20 195:24]
  wire [15:0] _GEN_760 = 3'h5 == cycle ? resetVector : regs_pc; // @[Jump.scala 144:13 155:19 197:20]
  wire [7:0] _GEN_840 = _execResult_result_T_21 ? execResult_result_newRegs_18_sp : _GEN_647; // @[Jump.scala 155:19 165:20]
  wire [7:0] execResult_result_newRegs_23_sp = _execResult_result_T_20 ? regs_sp : _GEN_840; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_777 = 3'h4 == cycle ? regs_pc : _GEN_760; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_812 = _execResult_result_T_74 ? regs_pc : _GEN_777; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_835 = _execResult_result_T_22 ? regs_pc : _GEN_812; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_858 = _execResult_result_T_21 ? regs_pc : _GEN_835; // @[Jump.scala 144:13 155:19]
  wire [15:0] execResult_result_newRegs_23_pc = _execResult_result_T_20 ? _regs_pc_T_1 : _GEN_858; // @[Jump.scala 155:19 157:20]
  wire  _GEN_795 = _execResult_result_T_74 | regs_flagI; // @[Jump.scala 144:13 155:19 183:23]
  wire  _GEN_831 = _execResult_result_T_22 ? regs_flagI : _GEN_795; // @[Jump.scala 144:13 155:19]
  wire  _GEN_854 = _execResult_result_T_21 ? regs_flagI : _GEN_831; // @[Jump.scala 144:13 155:19]
  wire  execResult_result_newRegs_23_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_854; // @[Jump.scala 144:13 155:19]
  wire [15:0] _GEN_773 = 3'h4 == cycle ? 16'hfffe : _GEN_758; // @[Jump.scala 155:19 189:24]
  wire  _GEN_774 = 3'h4 == cycle | 3'h5 == cycle; // @[Jump.scala 155:19 190:24]
  wire [15:0] _GEN_775 = 3'h4 == cycle ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 155:19 153:20 191:24]
  wire [2:0] _GEN_776 = 3'h4 == cycle ? 3'h5 : _execResult_result_result_nextCycle_T_1; // @[Jump.scala 155:19 147:22 192:26]
  wire  _GEN_790 = 3'h4 == cycle ? 1'h0 : 3'h5 == cycle; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_791 = _execResult_result_T_74 ? execResult_result_result_19_memAddr : _GEN_773; // @[Jump.scala 155:19 179:24]
  wire [7:0] _GEN_792 = _execResult_result_T_74 ? _execResult_result_pushData_T : 8'h0; // @[Jump.scala 155:19 150:20 180:24]
  wire [2:0] _GEN_809 = _execResult_result_T_74 ? 3'h4 : _GEN_776; // @[Jump.scala 155:19 186:26]
  wire  _GEN_810 = _execResult_result_T_74 ? 1'h0 : _GEN_774; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_811 = _execResult_result_T_74 ? operand : _GEN_775; // @[Jump.scala 155:19 153:20]
  wire  _GEN_813 = _execResult_result_T_74 ? 1'h0 : _GEN_790; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_814 = _execResult_result_T_22 ? execResult_result_result_19_memAddr : _GEN_791; // @[Jump.scala 155:19 170:24]
  wire [7:0] _GEN_815 = _execResult_result_T_22 ? regs_pc[7:0] : _GEN_792; // @[Jump.scala 155:19 171:24]
  wire [2:0] _GEN_830 = _execResult_result_T_22 ? 3'h3 : _GEN_809; // @[Jump.scala 155:19 175:26]
  wire  _GEN_833 = _execResult_result_T_22 ? 1'h0 : _GEN_810; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_834 = _execResult_result_T_22 ? operand : _GEN_811; // @[Jump.scala 155:19 153:20]
  wire  _GEN_836 = _execResult_result_T_22 ? 1'h0 : _GEN_813; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_837 = _execResult_result_T_21 ? execResult_result_result_19_memAddr : _GEN_814; // @[Jump.scala 155:19 162:24]
  wire [7:0] _GEN_838 = _execResult_result_T_21 ? regs_pc[15:8] : _GEN_815; // @[Jump.scala 155:19 163:24]
  wire  _GEN_839 = _execResult_result_T_21 | _GEN_646; // @[Jump.scala 155:19 164:25]
  wire [2:0] _GEN_853 = _execResult_result_T_21 ? 3'h2 : _GEN_830; // @[Jump.scala 155:19 167:26]
  wire  _GEN_856 = _execResult_result_T_21 ? 1'h0 : _GEN_833; // @[Jump.scala 155:19 152:20]
  wire [15:0] _GEN_857 = _execResult_result_T_21 ? operand : _GEN_834; // @[Jump.scala 155:19 153:20]
  wire  _GEN_859 = _execResult_result_T_21 ? 1'h0 : _GEN_836; // @[Jump.scala 146:17 155:19]
  wire [2:0] execResult_result_result_24_nextCycle = _execResult_result_T_20 ? 3'h1 : _GEN_853; // @[Jump.scala 155:19 159:26]
  wire [15:0] execResult_result_result_24_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_837; // @[Jump.scala 155:19 149:20]
  wire [7:0] execResult_result_result_24_memData = _execResult_result_T_20 ? 8'h0 : _GEN_838; // @[Jump.scala 155:19 150:20]
  wire  execResult_result_result_24_memWrite = _execResult_result_T_20 ? 1'h0 : _GEN_839; // @[Jump.scala 155:19 151:21]
  wire  execResult_result_result_24_memRead = _execResult_result_T_20 ? 1'h0 : _GEN_856; // @[Jump.scala 155:19 152:20]
  wire [15:0] execResult_result_result_24_operand = _execResult_result_T_20 ? operand : _GEN_857; // @[Jump.scala 155:19 153:20]
  wire  execResult_result_result_24_done = _execResult_result_T_20 ? 1'h0 : _GEN_859; // @[Jump.scala 146:17 155:19]
  wire [15:0] _GEN_885 = _execResult_result_T_74 ? resetVector : regs_pc; // @[Jump.scala 210:13 221:19 251:20]
  wire [7:0] _GEN_901 = _execResult_result_T_22 ? _execResult_result_newRegs_sp_T_3 : regs_sp; // @[Jump.scala 210:13 221:19 244:20]
  wire [7:0] _GEN_925 = _execResult_result_T_21 ? _execResult_result_newRegs_sp_T_3 : _GEN_901; // @[Jump.scala 221:19 236:20]
  wire [7:0] execResult_result_newRegs_24_sp = _execResult_result_T_20 ? _execResult_result_newRegs_sp_T_3 : _GEN_925; // @[Jump.scala 221:19 223:20]
  wire [15:0] _GEN_915 = _execResult_result_T_22 ? regs_pc : _GEN_885; // @[Jump.scala 210:13 221:19]
  wire [15:0] _GEN_940 = _execResult_result_T_21 ? regs_pc : _GEN_915; // @[Jump.scala 210:13 221:19]
  wire [15:0] execResult_result_newRegs_24_pc = _execResult_result_T_20 ? regs_pc : _GEN_940; // @[Jump.scala 210:13 221:19]
  wire  _GEN_919 = _execResult_result_T_21 ? io_memDataIn[0] : regs_flagC; // @[Jump.scala 210:13 221:19 230:23]
  wire  execResult_result_newRegs_24_flagC = _execResult_result_T_20 ? regs_flagC : _GEN_919; // @[Jump.scala 210:13 221:19]
  wire  _GEN_920 = _execResult_result_T_21 ? io_memDataIn[1] : regs_flagZ; // @[Jump.scala 210:13 221:19 231:23]
  wire  execResult_result_newRegs_24_flagZ = _execResult_result_T_20 ? regs_flagZ : _GEN_920; // @[Jump.scala 210:13 221:19]
  wire  _GEN_921 = _execResult_result_T_21 ? io_memDataIn[2] : regs_flagI; // @[Jump.scala 210:13 221:19 232:23]
  wire  execResult_result_newRegs_24_flagI = _execResult_result_T_20 ? regs_flagI : _GEN_921; // @[Jump.scala 210:13 221:19]
  wire  _GEN_922 = _execResult_result_T_21 ? io_memDataIn[3] : regs_flagD; // @[Jump.scala 210:13 221:19 233:23]
  wire  execResult_result_newRegs_24_flagD = _execResult_result_T_20 ? regs_flagD : _GEN_922; // @[Jump.scala 210:13 221:19]
  wire [15:0] _GEN_900 = _execResult_result_T_22 ? {{8'd0}, io_memDataIn} : operand; // @[Jump.scala 221:19 219:20 243:24]
  wire [15:0] _GEN_917 = _execResult_result_T_21 ? execResult_result_result_19_memAddr : _GEN_644; // @[Jump.scala 221:19 228:24]
  wire [15:0] _GEN_939 = _execResult_result_T_21 ? operand : _GEN_900; // @[Jump.scala 221:19 219:20]
  wire [15:0] execResult_result_result_25_memAddr = _execResult_result_T_20 ? 16'h0 : _GEN_917; // @[Jump.scala 221:19 215:20]
  wire [15:0] execResult_result_result_25_operand = _execResult_result_T_20 ? operand : _GEN_939; // @[Jump.scala 221:19 219:20]
  wire  _GEN_967 = 8'h40 == opcode & execResult_result_result_22_done; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire [2:0] _GEN_968 = 8'h40 == opcode ? execResult_result_result_22_nextCycle : 3'h0; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire [7:0] _GEN_972 = 8'h40 == opcode ? execResult_result_newRegs_24_sp : regs_sp; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire [15:0] _GEN_973 = 8'h40 == opcode ? execResult_result_newRegs_24_pc : regs_pc; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire  _GEN_974 = 8'h40 == opcode ? execResult_result_newRegs_24_flagC : regs_flagC; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire  _GEN_975 = 8'h40 == opcode ? execResult_result_newRegs_24_flagZ : regs_flagZ; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire  _GEN_976 = 8'h40 == opcode ? execResult_result_newRegs_24_flagI : regs_flagI; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire  _GEN_977 = 8'h40 == opcode ? execResult_result_newRegs_24_flagD : regs_flagD; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire  _GEN_979 = 8'h40 == opcode ? execResult_result_newRegs_7_flagV : regs_flagV; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire  _GEN_980 = 8'h40 == opcode ? execResult_result_newRegs_7_flagN : regs_flagN; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire [15:0] _GEN_981 = 8'h40 == opcode ? execResult_result_result_25_memAddr : 16'h0; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire  _GEN_984 = 8'h40 == opcode & execResult_result_result_24_memWrite; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire [15:0] _GEN_985 = 8'h40 == opcode ? execResult_result_result_25_operand : operand; // @[CPU6502Core.scala 111:12 113:20 213:27]
  wire  _GEN_986 = 8'h0 == opcode ? execResult_result_result_24_done : _GEN_967; // @[CPU6502Core.scala 113:20 212:27]
  wire [2:0] _GEN_987 = 8'h0 == opcode ? execResult_result_result_24_nextCycle : _GEN_968; // @[CPU6502Core.scala 113:20 212:27]
  wire [7:0] _GEN_991 = 8'h0 == opcode ? execResult_result_newRegs_23_sp : _GEN_972; // @[CPU6502Core.scala 113:20 212:27]
  wire [15:0] _GEN_992 = 8'h0 == opcode ? execResult_result_newRegs_23_pc : _GEN_973; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_993 = 8'h0 == opcode ? regs_flagC : _GEN_974; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_994 = 8'h0 == opcode ? regs_flagZ : _GEN_975; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_995 = 8'h0 == opcode ? execResult_result_newRegs_23_flagI : _GEN_976; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_996 = 8'h0 == opcode ? regs_flagD : _GEN_977; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_998 = 8'h0 == opcode ? regs_flagV : _GEN_979; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_999 = 8'h0 == opcode ? regs_flagN : _GEN_980; // @[CPU6502Core.scala 113:20 212:27]
  wire [15:0] _GEN_1000 = 8'h0 == opcode ? execResult_result_result_24_memAddr : _GEN_981; // @[CPU6502Core.scala 113:20 212:27]
  wire [7:0] _GEN_1001 = 8'h0 == opcode ? execResult_result_result_24_memData : 8'h0; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_1002 = 8'h0 == opcode & execResult_result_result_24_memWrite; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_1003 = 8'h0 == opcode ? execResult_result_result_24_memRead : _GEN_984; // @[CPU6502Core.scala 113:20 212:27]
  wire [15:0] _GEN_1004 = 8'h0 == opcode ? execResult_result_result_24_operand : _GEN_985; // @[CPU6502Core.scala 113:20 212:27]
  wire  _GEN_1005 = 8'h60 == opcode ? execResult_result_result_6_done : _GEN_986; // @[CPU6502Core.scala 113:20 211:27]
  wire [2:0] _GEN_1006 = 8'h60 == opcode ? execResult_result_result_6_nextCycle : _GEN_987; // @[CPU6502Core.scala 113:20 211:27]
  wire [7:0] _GEN_1010 = 8'h60 == opcode ? execResult_result_newRegs_22_sp : _GEN_991; // @[CPU6502Core.scala 113:20 211:27]
  wire [15:0] _GEN_1011 = 8'h60 == opcode ? execResult_result_newRegs_22_pc : _GEN_992; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1012 = 8'h60 == opcode ? regs_flagC : _GEN_993; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1013 = 8'h60 == opcode ? regs_flagZ : _GEN_994; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1014 = 8'h60 == opcode ? regs_flagI : _GEN_995; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1015 = 8'h60 == opcode ? regs_flagD : _GEN_996; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1017 = 8'h60 == opcode ? regs_flagV : _GEN_998; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1018 = 8'h60 == opcode ? regs_flagN : _GEN_999; // @[CPU6502Core.scala 113:20 211:27]
  wire [15:0] _GEN_1019 = 8'h60 == opcode ? execResult_result_result_23_memAddr : _GEN_1000; // @[CPU6502Core.scala 113:20 211:27]
  wire [7:0] _GEN_1020 = 8'h60 == opcode ? 8'h0 : _GEN_1001; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1021 = 8'h60 == opcode ? 1'h0 : _GEN_1002; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1022 = 8'h60 == opcode ? execResult_result_result_23_memRead : _GEN_1003; // @[CPU6502Core.scala 113:20 211:27]
  wire [15:0] _GEN_1023 = 8'h60 == opcode ? execResult_result_result_23_operand : _GEN_1004; // @[CPU6502Core.scala 113:20 211:27]
  wire  _GEN_1024 = 8'h20 == opcode ? execResult_result_result_22_done : _GEN_1005; // @[CPU6502Core.scala 113:20 210:27]
  wire [2:0] _GEN_1025 = 8'h20 == opcode ? execResult_result_result_22_nextCycle : _GEN_1006; // @[CPU6502Core.scala 113:20 210:27]
  wire [7:0] _GEN_1029 = 8'h20 == opcode ? execResult_result_newRegs_21_sp : _GEN_1010; // @[CPU6502Core.scala 113:20 210:27]
  wire [15:0] _GEN_1030 = 8'h20 == opcode ? execResult_result_newRegs_21_pc : _GEN_1011; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1031 = 8'h20 == opcode ? regs_flagC : _GEN_1012; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1032 = 8'h20 == opcode ? regs_flagZ : _GEN_1013; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1033 = 8'h20 == opcode ? regs_flagI : _GEN_1014; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1034 = 8'h20 == opcode ? regs_flagD : _GEN_1015; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1036 = 8'h20 == opcode ? regs_flagV : _GEN_1017; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1037 = 8'h20 == opcode ? regs_flagN : _GEN_1018; // @[CPU6502Core.scala 113:20 210:27]
  wire [15:0] _GEN_1038 = 8'h20 == opcode ? execResult_result_result_22_memAddr : _GEN_1019; // @[CPU6502Core.scala 113:20 210:27]
  wire [7:0] _GEN_1039 = 8'h20 == opcode ? execResult_result_result_22_memData : _GEN_1020; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1040 = 8'h20 == opcode ? execResult_result_result_22_memWrite : _GEN_1021; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1041 = 8'h20 == opcode ? execResult_result_result_6_memRead : _GEN_1022; // @[CPU6502Core.scala 113:20 210:27]
  wire [15:0] _GEN_1042 = 8'h20 == opcode ? execResult_result_result_17_operand : _GEN_1023; // @[CPU6502Core.scala 113:20 210:27]
  wire  _GEN_1043 = 8'h4c == opcode ? execResult_result_result_8_done : _GEN_1024; // @[CPU6502Core.scala 113:20 209:27]
  wire [2:0] _GEN_1044 = 8'h4c == opcode ? execResult_result_result_8_nextCycle : _GEN_1025; // @[CPU6502Core.scala 113:20 209:27]
  wire [7:0] _GEN_1048 = 8'h4c == opcode ? regs_sp : _GEN_1029; // @[CPU6502Core.scala 113:20 209:27]
  wire [15:0] _GEN_1049 = 8'h4c == opcode ? execResult_result_newRegs_20_pc : _GEN_1030; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1050 = 8'h4c == opcode ? regs_flagC : _GEN_1031; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1051 = 8'h4c == opcode ? regs_flagZ : _GEN_1032; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1052 = 8'h4c == opcode ? regs_flagI : _GEN_1033; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1053 = 8'h4c == opcode ? regs_flagD : _GEN_1034; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1055 = 8'h4c == opcode ? regs_flagV : _GEN_1036; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1056 = 8'h4c == opcode ? regs_flagN : _GEN_1037; // @[CPU6502Core.scala 113:20 209:27]
  wire [15:0] _GEN_1057 = 8'h4c == opcode ? execResult_result_result_21_memAddr : _GEN_1038; // @[CPU6502Core.scala 113:20 209:27]
  wire [7:0] _GEN_1058 = 8'h4c == opcode ? 8'h0 : _GEN_1039; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1059 = 8'h4c == opcode ? 1'h0 : _GEN_1040; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1060 = 8'h4c == opcode ? execResult_result_result_6_memRead : _GEN_1041; // @[CPU6502Core.scala 113:20 209:27]
  wire [15:0] _GEN_1061 = 8'h4c == opcode ? execResult_result_result_6_operand : _GEN_1042; // @[CPU6502Core.scala 113:20 209:27]
  wire  _GEN_1062 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_8_done : _GEN_1043; // @[CPU6502Core.scala 113:20 205:16]
  wire [2:0] _GEN_1063 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_8_nextCycle : _GEN_1044; // @[CPU6502Core.scala 113:20 205:16]
  wire [7:0] _GEN_1064 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_a : regs_a; // @[CPU6502Core.scala 113:20 205:16]
  wire [7:0] _GEN_1067 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_sp : _GEN_1048; // @[CPU6502Core.scala 113:20 205:16]
  wire [15:0] _GEN_1068 = 8'h68 == opcode | 8'h28 == opcode ? regs_pc : _GEN_1049; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1069 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagC : _GEN_1050; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1070 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagZ : _GEN_1051; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1071 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagI : _GEN_1052; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1072 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagD : _GEN_1053; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1074 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagV : _GEN_1055; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1075 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_newRegs_19_flagN : _GEN_1056; // @[CPU6502Core.scala 113:20 205:16]
  wire [15:0] _GEN_1076 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_20_memAddr : _GEN_1057; // @[CPU6502Core.scala 113:20 205:16]
  wire [7:0] _GEN_1077 = 8'h68 == opcode | 8'h28 == opcode ? 8'h0 : _GEN_1058; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1078 = 8'h68 == opcode | 8'h28 == opcode ? 1'h0 : _GEN_1059; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1079 = 8'h68 == opcode | 8'h28 == opcode ? execResult_result_result_8_done : _GEN_1060; // @[CPU6502Core.scala 113:20 205:16]
  wire [15:0] _GEN_1080 = 8'h68 == opcode | 8'h28 == opcode ? 16'h0 : _GEN_1061; // @[CPU6502Core.scala 113:20 205:16]
  wire  _GEN_1081 = 8'h48 == opcode | 8'h8 == opcode | _GEN_1062; // @[CPU6502Core.scala 113:20 200:16]
  wire [2:0] _GEN_1082 = 8'h48 == opcode | 8'h8 == opcode ? 3'h0 : _GEN_1063; // @[CPU6502Core.scala 113:20 200:16]
  wire [7:0] _GEN_1083 = 8'h48 == opcode | 8'h8 == opcode ? regs_a : _GEN_1064; // @[CPU6502Core.scala 113:20 200:16]
  wire [7:0] _GEN_1086 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_newRegs_18_sp : _GEN_1067; // @[CPU6502Core.scala 113:20 200:16]
  wire [15:0] _GEN_1087 = 8'h48 == opcode | 8'h8 == opcode ? regs_pc : _GEN_1068; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1088 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagC : _GEN_1069; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1089 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagZ : _GEN_1070; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1090 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagI : _GEN_1071; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1091 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagD : _GEN_1072; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1093 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagV : _GEN_1074; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1094 = 8'h48 == opcode | 8'h8 == opcode ? regs_flagN : _GEN_1075; // @[CPU6502Core.scala 113:20 200:16]
  wire [15:0] _GEN_1095 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_result_19_memAddr : _GEN_1076; // @[CPU6502Core.scala 113:20 200:16]
  wire [7:0] _GEN_1096 = 8'h48 == opcode | 8'h8 == opcode ? execResult_result_pushData : _GEN_1077; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1097 = 8'h48 == opcode | 8'h8 == opcode | _GEN_1078; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1098 = 8'h48 == opcode | 8'h8 == opcode ? 1'h0 : _GEN_1079; // @[CPU6502Core.scala 113:20 200:16]
  wire [15:0] _GEN_1099 = 8'h48 == opcode | 8'h8 == opcode ? 16'h0 : _GEN_1080; // @[CPU6502Core.scala 113:20 200:16]
  wire  _GEN_1100 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_6_done : _GEN_1081; // @[CPU6502Core.scala 113:20 195:16]
  wire [2:0] _GEN_1101 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_6_nextCycle : _GEN_1082; // @[CPU6502Core.scala 113:20 195:16]
  wire [7:0] _GEN_1102 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_newRegs_17_a : _GEN_1083; // @[CPU6502Core.scala 113:20 195:16]
  wire [7:0] _GEN_1105 = 8'hbd == opcode | 8'hb9 == opcode ? regs_sp : _GEN_1086; // @[CPU6502Core.scala 113:20 195:16]
  wire [15:0] _GEN_1106 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_newRegs_16_pc : _GEN_1087; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1107 = 8'hbd == opcode | 8'hb9 == opcode ? regs_flagC : _GEN_1088; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1108 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_newRegs_17_flagZ : _GEN_1089; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1109 = 8'hbd == opcode | 8'hb9 == opcode ? regs_flagI : _GEN_1090; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1110 = 8'hbd == opcode | 8'hb9 == opcode ? regs_flagD : _GEN_1091; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1112 = 8'hbd == opcode | 8'hb9 == opcode ? regs_flagV : _GEN_1093; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1113 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_newRegs_17_flagN : _GEN_1094; // @[CPU6502Core.scala 113:20 195:16]
  wire [15:0] _GEN_1114 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_17_memAddr : _GEN_1095; // @[CPU6502Core.scala 113:20 195:16]
  wire [7:0] _GEN_1115 = 8'hbd == opcode | 8'hb9 == opcode ? 8'h0 : _GEN_1096; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1116 = 8'hbd == opcode | 8'hb9 == opcode ? 1'h0 : _GEN_1097; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1117 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_18_memRead : _GEN_1098; // @[CPU6502Core.scala 113:20 195:16]
  wire [15:0] _GEN_1118 = 8'hbd == opcode | 8'hb9 == opcode ? execResult_result_result_18_operand : _GEN_1099; // @[CPU6502Core.scala 113:20 195:16]
  wire  _GEN_1119 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_6_done : _GEN_1100; // @[CPU6502Core.scala 113:20 190:16]
  wire [2:0] _GEN_1120 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_6_nextCycle : _GEN_1101; // @[CPU6502Core.scala 113:20 190:16]
  wire [7:0] _GEN_1121 = 8'had == opcode | 8'h8d == opcode ? execResult_result_newRegs_16_a : _GEN_1102; // @[CPU6502Core.scala 113:20 190:16]
  wire [7:0] _GEN_1124 = 8'had == opcode | 8'h8d == opcode ? regs_sp : _GEN_1105; // @[CPU6502Core.scala 113:20 190:16]
  wire [15:0] _GEN_1125 = 8'had == opcode | 8'h8d == opcode ? execResult_result_newRegs_16_pc : _GEN_1106; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1126 = 8'had == opcode | 8'h8d == opcode ? regs_flagC : _GEN_1107; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1127 = 8'had == opcode | 8'h8d == opcode ? execResult_result_newRegs_16_flagZ : _GEN_1108; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1128 = 8'had == opcode | 8'h8d == opcode ? regs_flagI : _GEN_1109; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1129 = 8'had == opcode | 8'h8d == opcode ? regs_flagD : _GEN_1110; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1131 = 8'had == opcode | 8'h8d == opcode ? regs_flagV : _GEN_1112; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1132 = 8'had == opcode | 8'h8d == opcode ? execResult_result_newRegs_16_flagN : _GEN_1113; // @[CPU6502Core.scala 113:20 190:16]
  wire [15:0] _GEN_1133 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_memAddr : _GEN_1114; // @[CPU6502Core.scala 113:20 190:16]
  wire [7:0] _GEN_1134 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_memData : _GEN_1115; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1135 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_memWrite : _GEN_1116; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1136 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_memRead : _GEN_1117; // @[CPU6502Core.scala 113:20 190:16]
  wire [15:0] _GEN_1137 = 8'had == opcode | 8'h8d == opcode ? execResult_result_result_17_operand : _GEN_1118; // @[CPU6502Core.scala 113:20 190:16]
  wire  _GEN_1138 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_8_done : _GEN_1119; // @[CPU6502Core.scala 113:20 185:16]
  wire [2:0] _GEN_1139 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_8_nextCycle : _GEN_1120; // @[CPU6502Core.scala 113:20 185:16]
  wire [7:0] _GEN_1140 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_newRegs_15_a : _GEN_1121; // @[CPU6502Core.scala 113:20 185:16]
  wire [7:0] _GEN_1143 = 8'hb5 == opcode | 8'h95 == opcode ? regs_sp : _GEN_1124; // @[CPU6502Core.scala 113:20 185:16]
  wire [15:0] _GEN_1144 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_newRegs_5_pc : _GEN_1125; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1145 = 8'hb5 == opcode | 8'h95 == opcode ? regs_flagC : _GEN_1126; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1146 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_newRegs_15_flagZ : _GEN_1127; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1147 = 8'hb5 == opcode | 8'h95 == opcode ? regs_flagI : _GEN_1128; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1148 = 8'hb5 == opcode | 8'h95 == opcode ? regs_flagD : _GEN_1129; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1150 = 8'hb5 == opcode | 8'h95 == opcode ? regs_flagV : _GEN_1131; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1151 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_newRegs_15_flagN : _GEN_1132; // @[CPU6502Core.scala 113:20 185:16]
  wire [15:0] _GEN_1152 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_8_memAddr : _GEN_1133; // @[CPU6502Core.scala 113:20 185:16]
  wire [7:0] _GEN_1153 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_16_memData : _GEN_1134; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1154 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_16_memWrite : _GEN_1135; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1155 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_16_memRead : _GEN_1136; // @[CPU6502Core.scala 113:20 185:16]
  wire [15:0] _GEN_1156 = 8'hb5 == opcode | 8'h95 == opcode ? execResult_result_result_16_operand : _GEN_1137; // @[CPU6502Core.scala 113:20 185:16]
  wire  _GEN_1157 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_8_done : _GEN_1138; // @[CPU6502Core.scala 113:20 180:16]
  wire [2:0] _GEN_1158 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_8_nextCycle : _GEN_1139; // @[CPU6502Core.scala 113:20 180:16]
  wire [7:0] _GEN_1159 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_newRegs_14_a : _GEN_1140; // @[CPU6502Core.scala 113:20 180:16]
  wire [7:0] _GEN_1162 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_sp : _GEN_1143; // @[CPU6502Core.scala 113:20 180:16]
  wire [15:0] _GEN_1163 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_1144; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1164 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_flagC : _GEN_1145; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1165 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_newRegs_14_flagZ : _GEN_1146; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1166 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_flagI : _GEN_1147; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1167 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_flagD : _GEN_1148; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1169 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ? regs_flagV : _GEN_1150; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1170 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_newRegs_14_flagN : _GEN_1151; // @[CPU6502Core.scala 113:20 180:16]
  wire [15:0] _GEN_1171 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_8_memAddr : _GEN_1152; // @[CPU6502Core.scala 113:20 180:16]
  wire [7:0] _GEN_1172 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_15_memData : _GEN_1153; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1173 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_15_memWrite : _GEN_1154; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1174 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_15_memRead : _GEN_1155; // @[CPU6502Core.scala 113:20 180:16]
  wire [15:0] _GEN_1175 = 8'ha5 == opcode | 8'h85 == opcode | 8'h86 == opcode | 8'h84 == opcode ?
    execResult_result_result_6_operand : _GEN_1156; // @[CPU6502Core.scala 113:20 180:16]
  wire  _GEN_1176 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_1157; // @[CPU6502Core.scala 113:20 175:16]
  wire [2:0] _GEN_1177 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 3'h0 : _GEN_1158; // @[CPU6502Core.scala 113:20 175:16]
  wire [7:0] _GEN_1178 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_13_a :
    _GEN_1159; // @[CPU6502Core.scala 113:20 175:16]
  wire [7:0] _GEN_1179 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_13_x : regs_x; // @[CPU6502Core.scala 113:20 175:16]
  wire [7:0] _GEN_1180 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_13_y : regs_y; // @[CPU6502Core.scala 113:20 175:16]
  wire [7:0] _GEN_1181 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_sp : _GEN_1162; // @[CPU6502Core.scala 113:20 175:16]
  wire [15:0] _GEN_1182 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? _regs_pc_T_1 : _GEN_1163; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1183 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagC : _GEN_1164; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1184 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? execResult_result_newRegs_13_flagZ : _GEN_1165
    ; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1185 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagI : _GEN_1166; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1186 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagD : _GEN_1167; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1188 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_flagV : _GEN_1169; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1189 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? io_memDataIn[7] : _GEN_1170; // @[CPU6502Core.scala 113:20 175:16]
  wire [15:0] _GEN_1190 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? regs_pc : _GEN_1171; // @[CPU6502Core.scala 113:20 175:16]
  wire [7:0] _GEN_1191 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 8'h0 : _GEN_1172; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1192 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 1'h0 : _GEN_1173; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1193 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode | _GEN_1174; // @[CPU6502Core.scala 113:20 175:16]
  wire [15:0] _GEN_1194 = 8'ha9 == opcode | 8'ha2 == opcode | 8'ha0 == opcode ? 16'h0 : _GEN_1175; // @[CPU6502Core.scala 113:20 175:16]
  wire  _GEN_1195 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_1176; // @[CPU6502Core.scala 113:20 170:16]
  wire [2:0] _GEN_1196 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 3'h0 : _GEN_1177; // @[CPU6502Core.scala 113:20 170:16]
  wire [7:0] _GEN_1197 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_a : _GEN_1178; // @[CPU6502Core.scala 113:20 170:16]
  wire [7:0] _GEN_1198 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_x : _GEN_1179; // @[CPU6502Core.scala 113:20 170:16]
  wire [7:0] _GEN_1199 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_y : _GEN_1180; // @[CPU6502Core.scala 113:20 170:16]
  wire [7:0] _GEN_1200 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_sp : _GEN_1181; // @[CPU6502Core.scala 113:20 170:16]
  wire [15:0] _GEN_1201 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? execResult_result_newRegs_12_pc : _GEN_1182; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1202 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagC : _GEN_1183; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1203 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagZ : _GEN_1184; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1204 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagI : _GEN_1185; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1205 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagD : _GEN_1186; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1207 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagV : _GEN_1188; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1208 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_flagN : _GEN_1189; // @[CPU6502Core.scala 113:20 170:16]
  wire [15:0] _GEN_1209 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? regs_pc : _GEN_1190; // @[CPU6502Core.scala 113:20 170:16]
  wire [7:0] _GEN_1210 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 8'h0 : _GEN_1191; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1211 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode ? 1'h0 : _GEN_1192; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1212 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10 ==
    opcode | 8'h50 == opcode | 8'h70 == opcode | _GEN_1193; // @[CPU6502Core.scala 113:20 170:16]
  wire [15:0] _GEN_1213 = 8'hf0 == opcode | 8'hd0 == opcode | 8'hb0 == opcode | 8'h90 == opcode | 8'h30 == opcode | 8'h10
     == opcode | 8'h50 == opcode | 8'h70 == opcode ? 16'h0 : _GEN_1194; // @[CPU6502Core.scala 113:20 170:16]
  wire  _GEN_1214 = 8'hc5 == opcode ? execResult_result_result_8_done : _GEN_1195; // @[CPU6502Core.scala 113:20 165:16]
  wire [2:0] _GEN_1215 = 8'hc5 == opcode ? execResult_result_result_8_nextCycle : _GEN_1196; // @[CPU6502Core.scala 113:20 165:16]
  wire [7:0] _GEN_1216 = 8'hc5 == opcode ? regs_a : _GEN_1197; // @[CPU6502Core.scala 113:20 165:16]
  wire [7:0] _GEN_1217 = 8'hc5 == opcode ? regs_x : _GEN_1198; // @[CPU6502Core.scala 113:20 165:16]
  wire [7:0] _GEN_1218 = 8'hc5 == opcode ? regs_y : _GEN_1199; // @[CPU6502Core.scala 113:20 165:16]
  wire [7:0] _GEN_1219 = 8'hc5 == opcode ? regs_sp : _GEN_1200; // @[CPU6502Core.scala 113:20 165:16]
  wire [15:0] _GEN_1220 = 8'hc5 == opcode ? execResult_result_newRegs_5_pc : _GEN_1201; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1221 = 8'hc5 == opcode ? execResult_result_newRegs_11_flagC : _GEN_1202; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1222 = 8'hc5 == opcode ? execResult_result_newRegs_11_flagZ : _GEN_1203; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1223 = 8'hc5 == opcode ? regs_flagI : _GEN_1204; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1224 = 8'hc5 == opcode ? regs_flagD : _GEN_1205; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1226 = 8'hc5 == opcode ? regs_flagV : _GEN_1207; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1227 = 8'hc5 == opcode ? execResult_result_newRegs_11_flagN : _GEN_1208; // @[CPU6502Core.scala 113:20 165:16]
  wire [15:0] _GEN_1228 = 8'hc5 == opcode ? execResult_result_result_8_memAddr : _GEN_1209; // @[CPU6502Core.scala 113:20 165:16]
  wire [7:0] _GEN_1229 = 8'hc5 == opcode ? 8'h0 : _GEN_1210; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1230 = 8'hc5 == opcode ? 1'h0 : _GEN_1211; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1231 = 8'hc5 == opcode ? execResult_result_result_6_memRead : _GEN_1212; // @[CPU6502Core.scala 113:20 165:16]
  wire [15:0] _GEN_1232 = 8'hc5 == opcode ? execResult_result_result_6_operand : _GEN_1213; // @[CPU6502Core.scala 113:20 165:16]
  wire  _GEN_1233 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_1214; // @[CPU6502Core.scala 113:20 160:16]
  wire [2:0] _GEN_1234 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 3'h0 : _GEN_1215; // @[CPU6502Core.scala 113:20 160:16]
  wire [7:0] _GEN_1235 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_a : _GEN_1216; // @[CPU6502Core.scala 113:20 160:16]
  wire [7:0] _GEN_1236 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_x : _GEN_1217; // @[CPU6502Core.scala 113:20 160:16]
  wire [7:0] _GEN_1237 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_y : _GEN_1218; // @[CPU6502Core.scala 113:20 160:16]
  wire [7:0] _GEN_1238 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_sp : _GEN_1219; // @[CPU6502Core.scala 113:20 160:16]
  wire [15:0] _GEN_1239 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? _regs_pc_T_1 : _GEN_1220; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1240 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_10_flagC : _GEN_1221
    ; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1241 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_10_flagZ : _GEN_1222
    ; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1242 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagI : _GEN_1223; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1243 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagD : _GEN_1224; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1245 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_flagV : _GEN_1226; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1246 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? execResult_result_newRegs_10_flagN : _GEN_1227
    ; // @[CPU6502Core.scala 113:20 160:16]
  wire [15:0] _GEN_1247 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? regs_pc : _GEN_1228; // @[CPU6502Core.scala 113:20 160:16]
  wire [7:0] _GEN_1248 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 8'h0 : _GEN_1229; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1249 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 1'h0 : _GEN_1230; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1250 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode | _GEN_1231; // @[CPU6502Core.scala 113:20 160:16]
  wire [15:0] _GEN_1251 = 8'hc9 == opcode | 8'he0 == opcode | 8'hc0 == opcode ? 16'h0 : _GEN_1232; // @[CPU6502Core.scala 113:20 160:16]
  wire  _GEN_1252 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_done : _GEN_1233; // @[CPU6502Core.scala 113:20 155:16]
  wire [2:0] _GEN_1253 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_nextCycle : _GEN_1234; // @[CPU6502Core.scala 113:20 155:16]
  wire [7:0] _GEN_1254 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_a : _GEN_1235; // @[CPU6502Core.scala 113:20 155:16]
  wire [7:0] _GEN_1255 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_x : _GEN_1236; // @[CPU6502Core.scala 113:20 155:16]
  wire [7:0] _GEN_1256 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_y : _GEN_1237; // @[CPU6502Core.scala 113:20 155:16]
  wire [7:0] _GEN_1257 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_sp : _GEN_1238; // @[CPU6502Core.scala 113:20 155:16]
  wire [15:0] _GEN_1258 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_5_pc : _GEN_1239; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1259 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_9_flagC : _GEN_1240; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1260 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_9_flagZ : _GEN_1241; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1261 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagI : _GEN_1242; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1262 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagD : _GEN_1243; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1264 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ? regs_flagV : _GEN_1245; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1265 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_newRegs_9_flagN : _GEN_1246; // @[CPU6502Core.scala 113:20 155:16]
  wire [15:0] _GEN_1266 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memAddr : _GEN_1247; // @[CPU6502Core.scala 113:20 155:16]
  wire [7:0] _GEN_1267 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_10_memData : _GEN_1248; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1268 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_done : _GEN_1249; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1269 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_memRead : _GEN_1250; // @[CPU6502Core.scala 113:20 155:16]
  wire [15:0] _GEN_1270 = 8'h6 == opcode | 8'h46 == opcode | 8'h26 == opcode | 8'h66 == opcode ?
    execResult_result_result_6_operand : _GEN_1251; // @[CPU6502Core.scala 113:20 155:16]
  wire  _GEN_1271 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode | _GEN_1252; // @[CPU6502Core.scala 113:20 150:16]
  wire [2:0] _GEN_1272 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 3'h0 : _GEN_1253; // @[CPU6502Core.scala 113:20 150:16]
  wire [7:0] _GEN_1273 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? execResult_result_res_8
     : _GEN_1254; // @[CPU6502Core.scala 113:20 150:16]
  wire [7:0] _GEN_1274 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_x : _GEN_1255; // @[CPU6502Core.scala 113:20 150:16]
  wire [7:0] _GEN_1275 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_y : _GEN_1256; // @[CPU6502Core.scala 113:20 150:16]
  wire [7:0] _GEN_1276 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_sp : _GEN_1257; // @[CPU6502Core.scala 113:20 150:16]
  wire [15:0] _GEN_1277 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_pc : _GEN_1258; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1278 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_8_flagC : _GEN_1259; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1279 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_8_flagZ : _GEN_1260; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1280 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagI : _GEN_1261; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1281 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagD : _GEN_1262; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1283 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? regs_flagV : _GEN_1264; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1284 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ?
    execResult_result_newRegs_8_flagN : _GEN_1265; // @[CPU6502Core.scala 113:20 150:16]
  wire [15:0] _GEN_1285 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_1266; // @[CPU6502Core.scala 113:20 150:16]
  wire [7:0] _GEN_1286 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 8'h0 : _GEN_1267; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1287 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_1268; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1288 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 1'h0 : _GEN_1269; // @[CPU6502Core.scala 113:20 150:16]
  wire [15:0] _GEN_1289 = 8'ha == opcode | 8'h4a == opcode | 8'h2a == opcode | 8'h6a == opcode ? 16'h0 : _GEN_1270; // @[CPU6502Core.scala 113:20 150:16]
  wire  _GEN_1290 = 8'h24 == opcode ? execResult_result_result_8_done : _GEN_1271; // @[CPU6502Core.scala 113:20 145:16]
  wire [2:0] _GEN_1291 = 8'h24 == opcode ? execResult_result_result_8_nextCycle : _GEN_1272; // @[CPU6502Core.scala 113:20 145:16]
  wire [7:0] _GEN_1292 = 8'h24 == opcode ? regs_a : _GEN_1273; // @[CPU6502Core.scala 113:20 145:16]
  wire [7:0] _GEN_1293 = 8'h24 == opcode ? regs_x : _GEN_1274; // @[CPU6502Core.scala 113:20 145:16]
  wire [7:0] _GEN_1294 = 8'h24 == opcode ? regs_y : _GEN_1275; // @[CPU6502Core.scala 113:20 145:16]
  wire [7:0] _GEN_1295 = 8'h24 == opcode ? regs_sp : _GEN_1276; // @[CPU6502Core.scala 113:20 145:16]
  wire [15:0] _GEN_1296 = 8'h24 == opcode ? execResult_result_newRegs_5_pc : _GEN_1277; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1297 = 8'h24 == opcode ? regs_flagC : _GEN_1278; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1298 = 8'h24 == opcode ? execResult_result_newRegs_7_flagZ : _GEN_1279; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1299 = 8'h24 == opcode ? regs_flagI : _GEN_1280; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1300 = 8'h24 == opcode ? regs_flagD : _GEN_1281; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1302 = 8'h24 == opcode ? execResult_result_newRegs_7_flagV : _GEN_1283; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1303 = 8'h24 == opcode ? execResult_result_newRegs_7_flagN : _GEN_1284; // @[CPU6502Core.scala 113:20 145:16]
  wire [15:0] _GEN_1304 = 8'h24 == opcode ? execResult_result_result_8_memAddr : _GEN_1285; // @[CPU6502Core.scala 113:20 145:16]
  wire [7:0] _GEN_1305 = 8'h24 == opcode ? 8'h0 : _GEN_1286; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1306 = 8'h24 == opcode ? 1'h0 : _GEN_1287; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1307 = 8'h24 == opcode ? execResult_result_result_6_memRead : _GEN_1288; // @[CPU6502Core.scala 113:20 145:16]
  wire [15:0] _GEN_1308 = 8'h24 == opcode ? execResult_result_result_6_operand : _GEN_1289; // @[CPU6502Core.scala 113:20 145:16]
  wire  _GEN_1309 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_1290; // @[CPU6502Core.scala 113:20 140:16]
  wire [2:0] _GEN_1310 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 3'h0 : _GEN_1291; // @[CPU6502Core.scala 113:20 140:16]
  wire [7:0] _GEN_1311 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_res_7 : _GEN_1292; // @[CPU6502Core.scala 113:20 140:16]
  wire [7:0] _GEN_1312 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_x : _GEN_1293; // @[CPU6502Core.scala 113:20 140:16]
  wire [7:0] _GEN_1313 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_y : _GEN_1294; // @[CPU6502Core.scala 113:20 140:16]
  wire [7:0] _GEN_1314 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_sp : _GEN_1295; // @[CPU6502Core.scala 113:20 140:16]
  wire [15:0] _GEN_1315 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? _regs_pc_T_1 : _GEN_1296; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1316 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagC : _GEN_1297; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1317 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_6_flagZ : _GEN_1298; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1318 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagI : _GEN_1299; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1319 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagD : _GEN_1300; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1321 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_flagV : _GEN_1302; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1322 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? execResult_result_newRegs_6_flagN : _GEN_1303; // @[CPU6502Core.scala 113:20 140:16]
  wire [15:0] _GEN_1323 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? regs_pc : _GEN_1304; // @[CPU6502Core.scala 113:20 140:16]
  wire [7:0] _GEN_1324 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 8'h0 : _GEN_1305; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1325 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 1'h0 : _GEN_1306; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1326 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode | _GEN_1307; // @[CPU6502Core.scala 113:20 140:16]
  wire [15:0] _GEN_1327 = 8'h29 == opcode | 8'h9 == opcode | 8'h49 == opcode ? 16'h0 : _GEN_1308; // @[CPU6502Core.scala 113:20 140:16]
  wire  _GEN_1328 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_done : _GEN_1309; // @[CPU6502Core.scala 113:20 135:16]
  wire [2:0] _GEN_1329 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_nextCycle : _GEN_1310; // @[CPU6502Core.scala 113:20 135:16]
  wire [7:0] _GEN_1330 = 8'he6 == opcode | 8'hc6 == opcode ? regs_a : _GEN_1311; // @[CPU6502Core.scala 113:20 135:16]
  wire [7:0] _GEN_1331 = 8'he6 == opcode | 8'hc6 == opcode ? regs_x : _GEN_1312; // @[CPU6502Core.scala 113:20 135:16]
  wire [7:0] _GEN_1332 = 8'he6 == opcode | 8'hc6 == opcode ? regs_y : _GEN_1313; // @[CPU6502Core.scala 113:20 135:16]
  wire [7:0] _GEN_1333 = 8'he6 == opcode | 8'hc6 == opcode ? regs_sp : _GEN_1314; // @[CPU6502Core.scala 113:20 135:16]
  wire [15:0] _GEN_1334 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_pc : _GEN_1315; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1335 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagC : _GEN_1316; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1336 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_flagZ : _GEN_1317; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1337 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagI : _GEN_1318; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1338 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagD : _GEN_1319; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1340 = 8'he6 == opcode | 8'hc6 == opcode ? regs_flagV : _GEN_1321; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1341 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_newRegs_5_flagN : _GEN_1322; // @[CPU6502Core.scala 113:20 135:16]
  wire [15:0] _GEN_1342 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memAddr : _GEN_1323; // @[CPU6502Core.scala 113:20 135:16]
  wire [7:0] _GEN_1343 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memData : _GEN_1324; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1344 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_done : _GEN_1325; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1345 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_memRead : _GEN_1326; // @[CPU6502Core.scala 113:20 135:16]
  wire [15:0] _GEN_1346 = 8'he6 == opcode | 8'hc6 == opcode ? execResult_result_result_6_operand : _GEN_1327; // @[CPU6502Core.scala 113:20 135:16]
  wire  _GEN_1347 = 8'he9 == opcode | _GEN_1328; // @[CPU6502Core.scala 113:20 131:27]
  wire [2:0] _GEN_1348 = 8'he9 == opcode ? 3'h0 : _GEN_1329; // @[CPU6502Core.scala 113:20 131:27]
  wire [7:0] _GEN_1349 = 8'he9 == opcode ? execResult_result_newRegs_4_a : _GEN_1330; // @[CPU6502Core.scala 113:20 131:27]
  wire [7:0] _GEN_1350 = 8'he9 == opcode ? regs_x : _GEN_1331; // @[CPU6502Core.scala 113:20 131:27]
  wire [7:0] _GEN_1351 = 8'he9 == opcode ? regs_y : _GEN_1332; // @[CPU6502Core.scala 113:20 131:27]
  wire [7:0] _GEN_1352 = 8'he9 == opcode ? regs_sp : _GEN_1333; // @[CPU6502Core.scala 113:20 131:27]
  wire [15:0] _GEN_1353 = 8'he9 == opcode ? _regs_pc_T_1 : _GEN_1334; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1354 = 8'he9 == opcode ? execResult_result_newRegs_4_flagC : _GEN_1335; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1355 = 8'he9 == opcode ? execResult_result_newRegs_4_flagZ : _GEN_1336; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1356 = 8'he9 == opcode ? regs_flagI : _GEN_1337; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1357 = 8'he9 == opcode ? regs_flagD : _GEN_1338; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1359 = 8'he9 == opcode ? execResult_result_newRegs_4_flagV : _GEN_1340; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1360 = 8'he9 == opcode ? execResult_result_newRegs_4_flagN : _GEN_1341; // @[CPU6502Core.scala 113:20 131:27]
  wire [15:0] _GEN_1361 = 8'he9 == opcode ? regs_pc : _GEN_1342; // @[CPU6502Core.scala 113:20 131:27]
  wire [7:0] _GEN_1362 = 8'he9 == opcode ? 8'h0 : _GEN_1343; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1363 = 8'he9 == opcode ? 1'h0 : _GEN_1344; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1364 = 8'he9 == opcode | _GEN_1345; // @[CPU6502Core.scala 113:20 131:27]
  wire [15:0] _GEN_1365 = 8'he9 == opcode ? 16'h0 : _GEN_1346; // @[CPU6502Core.scala 113:20 131:27]
  wire  _GEN_1366 = 8'h69 == opcode | _GEN_1347; // @[CPU6502Core.scala 113:20 130:27]
  wire [2:0] _GEN_1367 = 8'h69 == opcode ? 3'h0 : _GEN_1348; // @[CPU6502Core.scala 113:20 130:27]
  wire [7:0] _GEN_1368 = 8'h69 == opcode ? execResult_result_newRegs_3_a : _GEN_1349; // @[CPU6502Core.scala 113:20 130:27]
  wire [7:0] _GEN_1369 = 8'h69 == opcode ? regs_x : _GEN_1350; // @[CPU6502Core.scala 113:20 130:27]
  wire [7:0] _GEN_1370 = 8'h69 == opcode ? regs_y : _GEN_1351; // @[CPU6502Core.scala 113:20 130:27]
  wire [7:0] _GEN_1371 = 8'h69 == opcode ? regs_sp : _GEN_1352; // @[CPU6502Core.scala 113:20 130:27]
  wire [15:0] _GEN_1372 = 8'h69 == opcode ? _regs_pc_T_1 : _GEN_1353; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1373 = 8'h69 == opcode ? execResult_result_newRegs_3_flagC : _GEN_1354; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1374 = 8'h69 == opcode ? execResult_result_newRegs_3_flagZ : _GEN_1355; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1375 = 8'h69 == opcode ? regs_flagI : _GEN_1356; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1376 = 8'h69 == opcode ? regs_flagD : _GEN_1357; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1378 = 8'h69 == opcode ? execResult_result_newRegs_3_flagV : _GEN_1359; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1379 = 8'h69 == opcode ? execResult_result_newRegs_3_flagN : _GEN_1360; // @[CPU6502Core.scala 113:20 130:27]
  wire [15:0] _GEN_1380 = 8'h69 == opcode ? regs_pc : _GEN_1361; // @[CPU6502Core.scala 113:20 130:27]
  wire [7:0] _GEN_1381 = 8'h69 == opcode ? 8'h0 : _GEN_1362; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1382 = 8'h69 == opcode ? 1'h0 : _GEN_1363; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1383 = 8'h69 == opcode | _GEN_1364; // @[CPU6502Core.scala 113:20 130:27]
  wire [15:0] _GEN_1384 = 8'h69 == opcode ? 16'h0 : _GEN_1365; // @[CPU6502Core.scala 113:20 130:27]
  wire  _GEN_1385 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode | _GEN_1366; // @[CPU6502Core.scala 113:20 126:16]
  wire [2:0] _GEN_1386 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 3'h0 : _GEN_1367; // @[CPU6502Core.scala 113:20 126:16]
  wire [7:0] _GEN_1387 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_a : _GEN_1368; // @[CPU6502Core.scala 113:20 126:16]
  wire [7:0] _GEN_1388 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_x : _GEN_1369; // @[CPU6502Core.scala 113:20 126:16]
  wire [7:0] _GEN_1389 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? execResult_result_newRegs_2_y : _GEN_1370; // @[CPU6502Core.scala 113:20 126:16]
  wire [7:0] _GEN_1390 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_sp : _GEN_1371; // @[CPU6502Core.scala 113:20 126:16]
  wire [15:0] _GEN_1391 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? regs_pc : _GEN_1372; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1392 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagC : _GEN_1373; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1393 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagZ : _GEN_1374; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1394 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagI : _GEN_1375; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1395 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagD : _GEN_1376; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1397 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? regs_flagV : _GEN_1378; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1398 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? execResult_result_newRegs_2_flagN : _GEN_1379; // @[CPU6502Core.scala 113:20 126:16]
  wire [15:0] _GEN_1399 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_1380; // @[CPU6502Core.scala 113:20 126:16]
  wire [7:0] _GEN_1400 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 8'h0 : _GEN_1381; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1401 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_1382; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1402 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a ==
    opcode ? 1'h0 : _GEN_1383; // @[CPU6502Core.scala 113:20 126:16]
  wire [15:0] _GEN_1403 = 8'he8 == opcode | 8'hc8 == opcode | 8'hca == opcode | 8'h88 == opcode | 8'h1a == opcode | 8'h3a
     == opcode ? 16'h0 : _GEN_1384; // @[CPU6502Core.scala 113:20 126:16]
  wire  _GEN_1404 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode | _GEN_1385; // @[CPU6502Core.scala 113:20 121:16]
  wire [2:0] _GEN_1405 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 3'h0 : _GEN_1386; // @[CPU6502Core.scala 113:20 121:16]
  wire [7:0] _GEN_1406 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_a : _GEN_1387; // @[CPU6502Core.scala 113:20 121:16]
  wire [7:0] _GEN_1407 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_x : _GEN_1388; // @[CPU6502Core.scala 113:20 121:16]
  wire [7:0] _GEN_1408 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_y : _GEN_1389; // @[CPU6502Core.scala 113:20 121:16]
  wire [7:0] _GEN_1409 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? execResult_result_newRegs_1_sp : _GEN_1390; // @[CPU6502Core.scala 113:20 121:16]
  wire [15:0] _GEN_1410 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? regs_pc : _GEN_1391; // @[CPU6502Core.scala 113:20 121:16]
  wire  _GEN_1411 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagC : _GEN_1392; // @[CPU6502Core.scala 113:20 121:16]
  wire  _GEN_1412 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagZ : _GEN_1393; // @[CPU6502Core.scala 113:20 121:16]
  wire  _GEN_1413 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagI : _GEN_1394; // @[CPU6502Core.scala 113:20 121:16]
  wire  _GEN_1414 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagD : _GEN_1395; // @[CPU6502Core.scala 113:20 121:16]
  wire  _GEN_1416 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? regs_flagV : _GEN_1397; // @[CPU6502Core.scala 113:20 121:16]
  wire  _GEN_1417 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? execResult_result_newRegs_1_flagN : _GEN_1398; // @[CPU6502Core.scala 113:20 121:16]
  wire [15:0] _GEN_1418 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_1399; // @[CPU6502Core.scala 113:20 121:16]
  wire [7:0] _GEN_1419 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 8'h0 : _GEN_1400; // @[CPU6502Core.scala 113:20 121:16]
  wire  _GEN_1420 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_1401; // @[CPU6502Core.scala 113:20 121:16]
  wire  _GEN_1421 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a ==
    opcode ? 1'h0 : _GEN_1402; // @[CPU6502Core.scala 113:20 121:16]
  wire [15:0] _GEN_1422 = 8'haa == opcode | 8'ha8 == opcode | 8'h8a == opcode | 8'h98 == opcode | 8'hba == opcode | 8'h9a
     == opcode ? 16'h0 : _GEN_1403; // @[CPU6502Core.scala 113:20 121:16]
  wire  execResult_result_1_done = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode | _GEN_1404; // @[CPU6502Core.scala 113:20 116:16]
  wire [2:0] execResult_result_1_nextCycle = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 3'h0 : _GEN_1405; // @[CPU6502Core.scala 113:20 116:16]
  wire [7:0] execResult_result_1_regs_a = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_a : _GEN_1406; // @[CPU6502Core.scala 113:20 116:16]
  wire [7:0] execResult_result_1_regs_x = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_x : _GEN_1407; // @[CPU6502Core.scala 113:20 116:16]
  wire [7:0] execResult_result_1_regs_y = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_y : _GEN_1408; // @[CPU6502Core.scala 113:20 116:16]
  wire [7:0] execResult_result_1_regs_sp = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_sp : _GEN_1409; // @[CPU6502Core.scala 113:20 116:16]
  wire [15:0] execResult_result_1_regs_pc = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_pc : _GEN_1410; // @[CPU6502Core.scala 113:20 116:16]
  wire  execResult_result_1_regs_flagC = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagC : _GEN_1411; // @[CPU6502Core.scala 113:20 116:16]
  wire  execResult_result_1_regs_flagZ = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagZ : _GEN_1412; // @[CPU6502Core.scala 113:20 116:16]
  wire  execResult_result_1_regs_flagI = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagI : _GEN_1413; // @[CPU6502Core.scala 113:20 116:16]
  wire  execResult_result_1_regs_flagD = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagD : _GEN_1414; // @[CPU6502Core.scala 113:20 116:16]
  wire  execResult_result_1_regs_flagV = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? execResult_result_newRegs_flagV : _GEN_1416; // @[CPU6502Core.scala 113:20 116:16]
  wire  execResult_result_1_regs_flagN = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? regs_flagN : _GEN_1417; // @[CPU6502Core.scala 113:20 116:16]
  wire [15:0] execResult_result_1_memAddr = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_1418; // @[CPU6502Core.scala 113:20 116:16]
  wire [7:0] execResult_result_1_memData = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 8'h0 : _GEN_1419; // @[CPU6502Core.scala 113:20 116:16]
  wire  execResult_result_1_memWrite = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_1420; // @[CPU6502Core.scala 113:20 116:16]
  wire  execResult_result_1_memRead = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58 ==
    opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 1'h0 : _GEN_1421; // @[CPU6502Core.scala 113:20 116:16]
  wire [15:0] execResult_result_1_operand = 8'h18 == opcode | 8'h38 == opcode | 8'hd8 == opcode | 8'hf8 == opcode | 8'h58
     == opcode | 8'h78 == opcode | 8'hb8 == opcode | 8'hea == opcode ? 16'h0 : _GEN_1422; // @[CPU6502Core.scala 113:20 116:16]
  wire  _GEN_1444 = 2'h2 == state & execResult_result_1_done; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1488 = 2'h1 == state ? 1'h0 : _GEN_1444; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_done = 2'h0 == state ? 1'h0 : _GEN_1488; // @[CPU6502Core.scala 38:14 47:17]
  wire [2:0] _GEN_1445 = 2'h2 == state ? execResult_result_1_nextCycle : 3'h0; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [2:0] _GEN_1489 = 2'h1 == state ? 3'h0 : _GEN_1445; // @[CPU6502Core.scala 38:14 47:17]
  wire [2:0] execResult_nextCycle = 2'h0 == state ? 3'h0 : _GEN_1489; // @[CPU6502Core.scala 38:14 47:17]
  wire [2:0] _GEN_1442 = execResult_done ? 3'h0 : execResult_nextCycle; // @[CPU6502Core.scala 86:15 88:29 89:15]
  wire [1:0] _GEN_1443 = execResult_done ? 2'h1 : _GEN_0; // @[CPU6502Core.scala 88:29 90:15]
  wire [7:0] _GEN_1446 = 2'h2 == state ? execResult_result_1_regs_a : regs_a; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [7:0] _GEN_1447 = 2'h2 == state ? execResult_result_1_regs_x : regs_x; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [7:0] _GEN_1448 = 2'h2 == state ? execResult_result_1_regs_y : regs_y; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [7:0] _GEN_1449 = 2'h2 == state ? execResult_result_1_regs_sp : regs_sp; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [15:0] _GEN_1450 = 2'h2 == state ? execResult_result_1_regs_pc : regs_pc; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1451 = 2'h2 == state ? execResult_result_1_regs_flagC : regs_flagC; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1452 = 2'h2 == state ? execResult_result_1_regs_flagZ : regs_flagZ; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1453 = 2'h2 == state ? execResult_result_1_regs_flagI : regs_flagI; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1454 = 2'h2 == state ? execResult_result_1_regs_flagD : regs_flagD; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1456 = 2'h2 == state ? execResult_result_1_regs_flagV : regs_flagV; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1457 = 2'h2 == state ? execResult_result_1_regs_flagN : regs_flagN; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [15:0] _GEN_1458 = 2'h2 == state ? execResult_result_1_memAddr : 16'h0; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [7:0] _GEN_1459 = 2'h2 == state ? execResult_result_1_memData : 8'h0; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1460 = 2'h2 == state & execResult_result_1_memWrite; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire  _GEN_1461 = 2'h2 == state & execResult_result_1_memRead; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [15:0] _GEN_1462 = 2'h2 == state ? execResult_result_1_operand : operand; // @[CPU6502Core.scala 38:14 47:17 76:18]
  wire [15:0] _GEN_1502 = 2'h1 == state ? 16'h0 : _GEN_1458; // @[CPU6502Core.scala 38:14 47:17]
  wire [15:0] execResult_memAddr = 2'h0 == state ? 16'h0 : _GEN_1502; // @[CPU6502Core.scala 38:14 47:17]
  wire [15:0] _GEN_1463 = 2'h2 == state ? execResult_memAddr : regs_pc; // @[CPU6502Core.scala 31:17 47:17 79:21]
  wire [7:0] _GEN_1503 = 2'h1 == state ? 8'h0 : _GEN_1459; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] execResult_memData = 2'h0 == state ? 8'h0 : _GEN_1503; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] _GEN_1464 = 2'h2 == state ? execResult_memData : 8'h0; // @[CPU6502Core.scala 32:17 47:17 80:21]
  wire  _GEN_1504 = 2'h1 == state ? 1'h0 : _GEN_1460; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_memWrite = 2'h0 == state ? 1'h0 : _GEN_1504; // @[CPU6502Core.scala 38:14 47:17]
  wire  _GEN_1465 = 2'h2 == state & execResult_memWrite; // @[CPU6502Core.scala 33:17 47:17 81:21]
  wire  _GEN_1505 = 2'h1 == state ? 1'h0 : _GEN_1461; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_memRead = 2'h0 == state ? 1'h0 : _GEN_1505; // @[CPU6502Core.scala 38:14 47:17]
  wire  _GEN_1466 = 2'h2 == state & execResult_memRead; // @[CPU6502Core.scala 34:17 47:17 82:21]
  wire [7:0] _GEN_1490 = 2'h1 == state ? regs_a : _GEN_1446; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] execResult_regs_a = 2'h0 == state ? regs_a : _GEN_1490; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] _GEN_1491 = 2'h1 == state ? regs_x : _GEN_1447; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] execResult_regs_x = 2'h0 == state ? regs_x : _GEN_1491; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] _GEN_1492 = 2'h1 == state ? regs_y : _GEN_1448; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] execResult_regs_y = 2'h0 == state ? regs_y : _GEN_1492; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] _GEN_1493 = 2'h1 == state ? regs_sp : _GEN_1449; // @[CPU6502Core.scala 38:14 47:17]
  wire [7:0] execResult_regs_sp = 2'h0 == state ? regs_sp : _GEN_1493; // @[CPU6502Core.scala 38:14 47:17]
  wire [15:0] _GEN_1494 = 2'h1 == state ? regs_pc : _GEN_1450; // @[CPU6502Core.scala 38:14 47:17]
  wire [15:0] execResult_regs_pc = 2'h0 == state ? regs_pc : _GEN_1494; // @[CPU6502Core.scala 38:14 47:17]
  wire  _GEN_1495 = 2'h1 == state ? regs_flagC : _GEN_1451; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_regs_flagC = 2'h0 == state ? regs_flagC : _GEN_1495; // @[CPU6502Core.scala 38:14 47:17]
  wire  _GEN_1496 = 2'h1 == state ? regs_flagZ : _GEN_1452; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_regs_flagZ = 2'h0 == state ? regs_flagZ : _GEN_1496; // @[CPU6502Core.scala 38:14 47:17]
  wire  _GEN_1497 = 2'h1 == state ? regs_flagI : _GEN_1453; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_regs_flagI = 2'h0 == state ? regs_flagI : _GEN_1497; // @[CPU6502Core.scala 38:14 47:17]
  wire  _GEN_1498 = 2'h1 == state ? regs_flagD : _GEN_1454; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_regs_flagD = 2'h0 == state ? regs_flagD : _GEN_1498; // @[CPU6502Core.scala 38:14 47:17]
  wire  _GEN_1500 = 2'h1 == state ? regs_flagV : _GEN_1456; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_regs_flagV = 2'h0 == state ? regs_flagV : _GEN_1500; // @[CPU6502Core.scala 38:14 47:17]
  wire  _GEN_1501 = 2'h1 == state ? regs_flagN : _GEN_1457; // @[CPU6502Core.scala 38:14 47:17]
  wire  execResult_regs_flagN = 2'h0 == state ? regs_flagN : _GEN_1501; // @[CPU6502Core.scala 38:14 47:17]
  wire [15:0] _GEN_1506 = 2'h1 == state ? operand : _GEN_1462; // @[CPU6502Core.scala 38:14 47:17]
  wire [15:0] execResult_operand = 2'h0 == state ? operand : _GEN_1506; // @[CPU6502Core.scala 38:14 47:17]
  wire [15:0] _GEN_1482 = 2'h1 == state ? regs_pc : _GEN_1463; // @[CPU6502Core.scala 47:17 66:18]
  wire  _GEN_1483 = 2'h1 == state | _GEN_1466; // @[CPU6502Core.scala 47:17 67:18]
  wire [7:0] _GEN_1507 = 2'h1 == state ? 8'h0 : _GEN_1464; // @[CPU6502Core.scala 32:17 47:17]
  wire  _GEN_1508 = 2'h1 == state ? 1'h0 : _GEN_1465; // @[CPU6502Core.scala 33:17 47:17]
  assign io_memAddr = 2'h0 == state ? _GEN_7 : _GEN_1482; // @[CPU6502Core.scala 47:17]
  assign io_memDataOut = 2'h0 == state ? 8'h0 : _GEN_1507; // @[CPU6502Core.scala 32:17 47:17]
  assign io_memWrite = 2'h0 == state ? 1'h0 : _GEN_1508; // @[CPU6502Core.scala 33:17 47:17]
  assign io_memRead = 2'h0 == state ? _GEN_8 : _GEN_1483; // @[CPU6502Core.scala 47:17]
  assign io_debug_regA = regs_a; // @[DebugBundle.scala 21:21 22:16]
  assign io_debug_regX = regs_x; // @[DebugBundle.scala 21:21 23:16]
  assign io_debug_regY = regs_y; // @[DebugBundle.scala 21:21 24:16]
  assign io_debug_regPC = regs_pc; // @[DebugBundle.scala 21:21 25:17]
  assign io_debug_regSP = regs_sp; // @[DebugBundle.scala 21:21 26:17]
  assign io_debug_flagC = regs_flagC; // @[DebugBundle.scala 21:21 27:17]
  assign io_debug_flagZ = regs_flagZ; // @[DebugBundle.scala 21:21 28:17]
  assign io_debug_flagN = regs_flagN; // @[DebugBundle.scala 21:21 29:17]
  assign io_debug_flagV = regs_flagV; // @[DebugBundle.scala 21:21 30:17]
  assign io_debug_opcode = opcode; // @[DebugBundle.scala 21:21 31:18]
  always @(posedge clock) begin
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_a <= 8'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_a <= execResult_regs_a; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_x <= 8'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_x <= execResult_regs_x; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_y <= 8'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_y <= execResult_regs_y; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_sp <= 8'hff; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_sp <= execResult_regs_sp; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_pc <= 16'h0; // @[CPU6502Core.scala 20:21]
    end else if (2'h0 == state) begin // @[CPU6502Core.scala 47:17]
      if (!(cycle == 3'h0)) begin // @[CPU6502Core.scala 50:27]
        if (cycle == 3'h1) begin // @[CPU6502Core.scala 55:33]
          regs_pc <= resetVector; // @[CPU6502Core.scala 59:17]
        end
      end
    end else if (2'h1 == state) begin // @[CPU6502Core.scala 47:17]
      regs_pc <= _regs_pc_T_1; // @[CPU6502Core.scala 69:15]
    end else if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
      regs_pc <= execResult_regs_pc; // @[CPU6502Core.scala 84:15]
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_flagC <= 1'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_flagC <= execResult_regs_flagC; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_flagZ <= 1'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_flagZ <= execResult_regs_flagZ; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_flagI <= 1'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_flagI <= execResult_regs_flagI; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_flagD <= 1'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_flagD <= execResult_regs_flagD; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_flagV <= 1'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_flagV <= execResult_regs_flagV; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 20:21]
      regs_flagN <= 1'h0; // @[CPU6502Core.scala 20:21]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
        if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
          regs_flagN <= execResult_regs_flagN; // @[CPU6502Core.scala 84:15]
        end
      end
    end
    if (reset) begin // @[CPU6502Core.scala 24:22]
      state <= 2'h0; // @[CPU6502Core.scala 24:22]
    end else if (2'h0 == state) begin // @[CPU6502Core.scala 47:17]
      if (cycle == 3'h0) begin // @[CPU6502Core.scala 50:27]
        state <= _GEN_0;
      end else if (cycle == 3'h1) begin // @[CPU6502Core.scala 55:33]
        state <= 2'h1; // @[CPU6502Core.scala 61:15]
      end else begin
        state <= _GEN_0;
      end
    end else if (2'h1 == state) begin // @[CPU6502Core.scala 47:17]
      state <= 2'h2; // @[CPU6502Core.scala 71:13]
    end else if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
      state <= _GEN_1443;
    end else begin
      state <= _GEN_0;
    end
    if (reset) begin // @[CPU6502Core.scala 26:24]
      opcode <= 8'h0; // @[CPU6502Core.scala 26:24]
    end else if (!(2'h0 == state)) begin // @[CPU6502Core.scala 47:17]
      if (2'h1 == state) begin // @[CPU6502Core.scala 47:17]
        opcode <= io_memDataIn; // @[CPU6502Core.scala 68:14]
      end
    end
    if (reset) begin // @[CPU6502Core.scala 27:24]
      operand <= 16'h0; // @[CPU6502Core.scala 27:24]
    end else if (2'h0 == state) begin // @[CPU6502Core.scala 47:17]
      if (cycle == 3'h0) begin // @[CPU6502Core.scala 50:27]
        operand <= {{8'd0}, io_memDataIn}; // @[CPU6502Core.scala 53:17]
      end
    end else if (!(2'h1 == state)) begin // @[CPU6502Core.scala 47:17]
      if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
        operand <= execResult_operand; // @[CPU6502Core.scala 85:15]
      end
    end
    if (reset) begin // @[CPU6502Core.scala 28:24]
      cycle <= 3'h0; // @[CPU6502Core.scala 28:24]
    end else if (2'h0 == state) begin // @[CPU6502Core.scala 47:17]
      if (cycle == 3'h0) begin // @[CPU6502Core.scala 50:27]
        cycle <= 3'h1; // @[CPU6502Core.scala 54:15]
      end else if (cycle == 3'h1) begin // @[CPU6502Core.scala 55:33]
        cycle <= 3'h0; // @[CPU6502Core.scala 60:15]
      end else begin
        cycle <= _GEN_1;
      end
    end else if (2'h1 == state) begin // @[CPU6502Core.scala 47:17]
      cycle <= 3'h0; // @[CPU6502Core.scala 70:13]
    end else if (2'h2 == state) begin // @[CPU6502Core.scala 47:17]
      cycle <= _GEN_1442;
    end else begin
      cycle <= _GEN_1;
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
  input         io_reset
);
  wire  core_clock; // @[CPU6502Refactored.scala 19:20]
  wire  core_reset; // @[CPU6502Refactored.scala 19:20]
  wire [15:0] core_io_memAddr; // @[CPU6502Refactored.scala 19:20]
  wire [7:0] core_io_memDataOut; // @[CPU6502Refactored.scala 19:20]
  wire [7:0] core_io_memDataIn; // @[CPU6502Refactored.scala 19:20]
  wire  core_io_memWrite; // @[CPU6502Refactored.scala 19:20]
  wire  core_io_memRead; // @[CPU6502Refactored.scala 19:20]
  wire [7:0] core_io_debug_regA; // @[CPU6502Refactored.scala 19:20]
  wire [7:0] core_io_debug_regX; // @[CPU6502Refactored.scala 19:20]
  wire [7:0] core_io_debug_regY; // @[CPU6502Refactored.scala 19:20]
  wire [15:0] core_io_debug_regPC; // @[CPU6502Refactored.scala 19:20]
  wire [7:0] core_io_debug_regSP; // @[CPU6502Refactored.scala 19:20]
  wire  core_io_debug_flagC; // @[CPU6502Refactored.scala 19:20]
  wire  core_io_debug_flagZ; // @[CPU6502Refactored.scala 19:20]
  wire  core_io_debug_flagN; // @[CPU6502Refactored.scala 19:20]
  wire  core_io_debug_flagV; // @[CPU6502Refactored.scala 19:20]
  wire [7:0] core_io_debug_opcode; // @[CPU6502Refactored.scala 19:20]
  wire  core_io_reset; // @[CPU6502Refactored.scala 19:20]
  CPU6502Core core ( // @[CPU6502Refactored.scala 19:20]
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
    .io_reset(core_io_reset)
  );
  assign io_memAddr = core_io_memAddr; // @[CPU6502Refactored.scala 21:17]
  assign io_memDataOut = core_io_memDataOut; // @[CPU6502Refactored.scala 22:17]
  assign io_memWrite = core_io_memWrite; // @[CPU6502Refactored.scala 24:17]
  assign io_memRead = core_io_memRead; // @[CPU6502Refactored.scala 25:17]
  assign io_debug_regA = core_io_debug_regA; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_regX = core_io_debug_regX; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_regY = core_io_debug_regY; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_regPC = core_io_debug_regPC; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_regSP = core_io_debug_regSP; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_flagC = core_io_debug_flagC; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_flagZ = core_io_debug_flagZ; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_flagN = core_io_debug_flagN; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_flagV = core_io_debug_flagV; // @[CPU6502Refactored.scala 26:17]
  assign io_debug_opcode = core_io_debug_opcode; // @[CPU6502Refactored.scala 26:17]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_memDataIn = io_memDataIn; // @[CPU6502Refactored.scala 23:21]
  assign core_io_reset = io_reset; // @[CPU6502Refactored.scala 27:17]
endmodule
module PPU(
  input        clock,
  input        reset,
  input  [2:0] io_cpuAddr,
  input  [7:0] io_cpuDataIn,
  output [7:0] io_cpuDataOut,
  input        io_cpuWrite,
  input        io_cpuRead,
  output [8:0] io_pixelX,
  output [8:0] io_pixelY,
  output       io_vblank
);
  reg [7:0] vram [0:2047]; // @[PPU.scala 52:25]
  wire  vram_io_cpuDataOut_MPORT_1_en; // @[PPU.scala 52:25]
  wire [10:0] vram_io_cpuDataOut_MPORT_1_addr; // @[PPU.scala 52:25]
  wire [7:0] vram_io_cpuDataOut_MPORT_1_data; // @[PPU.scala 52:25]
  wire [7:0] vram_MPORT_1_data; // @[PPU.scala 52:25]
  wire [10:0] vram_MPORT_1_addr; // @[PPU.scala 52:25]
  wire  vram_MPORT_1_mask; // @[PPU.scala 52:25]
  wire  vram_MPORT_1_en; // @[PPU.scala 52:25]
  reg  vram_io_cpuDataOut_MPORT_1_en_pipe_0;
  reg [10:0] vram_io_cpuDataOut_MPORT_1_addr_pipe_0;
  reg [7:0] oam [0:255]; // @[PPU.scala 53:24]
  wire  oam_io_cpuDataOut_MPORT_en; // @[PPU.scala 53:24]
  wire [7:0] oam_io_cpuDataOut_MPORT_addr; // @[PPU.scala 53:24]
  wire [7:0] oam_io_cpuDataOut_MPORT_data; // @[PPU.scala 53:24]
  wire [7:0] oam_MPORT_data; // @[PPU.scala 53:24]
  wire [7:0] oam_MPORT_addr; // @[PPU.scala 53:24]
  wire  oam_MPORT_mask; // @[PPU.scala 53:24]
  wire  oam_MPORT_en; // @[PPU.scala 53:24]
  reg  oam_io_cpuDataOut_MPORT_en_pipe_0;
  reg [7:0] oam_io_cpuDataOut_MPORT_addr_pipe_0;
  reg [7:0] oamAddr; // @[PPU.scala 45:24]
  reg  ppuAddrLatch; // @[PPU.scala 48:29]
  reg [15:0] ppuAddrReg; // @[PPU.scala 49:27]
  reg [8:0] scanlineX; // @[PPU.scala 58:26]
  reg [8:0] scanlineY; // @[PPU.scala 59:26]
  reg  vblankFlag; // @[PPU.scala 62:27]
  wire [8:0] _scanlineX_T_1 = scanlineX + 9'h1; // @[PPU.scala 66:26]
  wire [8:0] _scanlineY_T_1 = scanlineY + 9'h1; // @[PPU.scala 69:28]
  wire  _T_1 = scanlineY == 9'h105; // @[PPU.scala 71:20]
  wire  _T_3 = scanlineX == 9'h1; // @[PPU.scala 77:41]
  wire  _GEN_4 = scanlineY == 9'hf1 & scanlineX == 9'h1 | vblankFlag; // @[PPU.scala 77:50 78:16 62:27]
  wire  _GEN_6 = _T_1 & _T_3 ? 1'h0 : _GEN_4; // @[PPU.scala 84:50 85:16]
  wire [7:0] _io_cpuDataOut_T = {vblankFlag,7'h0}; // @[Cat.scala 33:92]
  wire  _T_10 = 3'h4 == io_cpuAddr; // @[PPU.scala 93:24]
  wire  _T_11 = 3'h7 == io_cpuAddr; // @[PPU.scala 93:24]
  wire [15:0] _ppuAddrReg_T_1 = ppuAddrReg + 16'h1; // @[PPU.scala 105:34]
  wire [7:0] _GEN_17 = 3'h7 == io_cpuAddr ? vram_io_cpuDataOut_MPORT_1_data : 8'h0; // @[PPU.scala 104:23 90:17 93:24]
  wire [15:0] _GEN_18 = 3'h7 == io_cpuAddr ? _ppuAddrReg_T_1 : ppuAddrReg; // @[PPU.scala 105:20 93:24 49:27]
  wire [7:0] _GEN_22 = 3'h4 == io_cpuAddr ? oam_io_cpuDataOut_MPORT_data : _GEN_17; // @[PPU.scala 100:23 93:24]
  wire  _GEN_23 = 3'h4 == io_cpuAddr ? 1'h0 : 3'h7 == io_cpuAddr; // @[PPU.scala 93:24 52:25]
  wire [15:0] _GEN_26 = 3'h4 == io_cpuAddr ? ppuAddrReg : _GEN_18; // @[PPU.scala 93:24 49:27]
  wire [7:0] _GEN_27 = 3'h2 == io_cpuAddr ? _io_cpuDataOut_T : _GEN_22; // @[PPU.scala 93:24 95:23]
  wire  _GEN_29 = 3'h2 == io_cpuAddr ? 1'h0 : ppuAddrLatch; // @[PPU.scala 93:24 97:22 48:29]
  wire  _GEN_30 = 3'h2 == io_cpuAddr ? 1'h0 : 3'h4 == io_cpuAddr; // @[PPU.scala 53:24 93:24]
  wire  _GEN_33 = 3'h2 == io_cpuAddr ? 1'h0 : _GEN_23; // @[PPU.scala 93:24 52:25]
  wire [15:0] _GEN_36 = 3'h2 == io_cpuAddr ? ppuAddrReg : _GEN_26; // @[PPU.scala 93:24 49:27]
  wire  _GEN_39 = io_cpuRead ? _GEN_29 : ppuAddrLatch; // @[PPU.scala 92:20 48:29]
  wire [15:0] _GEN_46 = io_cpuRead ? _GEN_36 : ppuAddrReg; // @[PPU.scala 92:20 49:27]
  wire [7:0] _oamAddr_T_1 = oamAddr + 8'h1; // @[PPU.scala 123:28]
  wire  _T_17 = ~ppuAddrLatch; // @[PPU.scala 126:14]
  wire [13:0] _ppuAddrReg_T_3 = {io_cpuDataIn[5:0],8'h0}; // @[Cat.scala 33:92]
  wire [15:0] _ppuAddrReg_T_5 = {ppuAddrReg[15:8],io_cpuDataIn}; // @[Cat.scala 33:92]
  wire [15:0] _GEN_49 = _T_17 ? {{2'd0}, _ppuAddrReg_T_3} : _ppuAddrReg_T_5; // @[PPU.scala 134:29 135:22 137:22]
  wire [15:0] _GEN_55 = _T_11 ? _ppuAddrReg_T_1 : _GEN_46; // @[PPU.scala 111:24 144:20]
  wire [15:0] _GEN_56 = 3'h6 == io_cpuAddr ? _GEN_49 : _GEN_55; // @[PPU.scala 111:24]
  wire  _GEN_57 = 3'h6 == io_cpuAddr ? _T_17 : _GEN_39; // @[PPU.scala 111:24 139:22]
  wire  _GEN_60 = 3'h6 == io_cpuAddr ? 1'h0 : _T_11; // @[PPU.scala 111:24 52:25]
  wire  _GEN_65 = 3'h5 == io_cpuAddr ? _T_17 : _GEN_57; // @[PPU.scala 111:24 131:22]
  wire [15:0] _GEN_66 = 3'h5 == io_cpuAddr ? _GEN_46 : _GEN_56; // @[PPU.scala 111:24]
  wire  _GEN_69 = 3'h5 == io_cpuAddr ? 1'h0 : _GEN_60; // @[PPU.scala 111:24 52:25]
  wire [7:0] _GEN_77 = _T_10 ? _oamAddr_T_1 : oamAddr; // @[PPU.scala 111:24 123:17 45:24]
  wire  _GEN_80 = _T_10 ? _GEN_39 : _GEN_65; // @[PPU.scala 111:24]
  wire [15:0] _GEN_81 = _T_10 ? _GEN_46 : _GEN_66; // @[PPU.scala 111:24]
  wire  _GEN_84 = _T_10 ? 1'h0 : _GEN_69; // @[PPU.scala 111:24 52:25]
  wire [7:0] _GEN_87 = 3'h3 == io_cpuAddr ? io_cpuDataIn : _GEN_77; // @[PPU.scala 111:24 119:17]
  wire  _GEN_90 = 3'h3 == io_cpuAddr ? 1'h0 : _T_10; // @[PPU.scala 111:24 53:24]
  wire  _GEN_95 = 3'h3 == io_cpuAddr ? _GEN_39 : _GEN_80; // @[PPU.scala 111:24]
  wire [15:0] _GEN_96 = 3'h3 == io_cpuAddr ? _GEN_46 : _GEN_81; // @[PPU.scala 111:24]
  wire  _GEN_99 = 3'h3 == io_cpuAddr ? 1'h0 : _GEN_84; // @[PPU.scala 111:24 52:25]
  wire  _GEN_106 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_90; // @[PPU.scala 111:24 53:24]
  wire  _GEN_115 = 3'h1 == io_cpuAddr ? 1'h0 : _GEN_99; // @[PPU.scala 111:24 52:25]
  wire  _GEN_123 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_106; // @[PPU.scala 111:24 53:24]
  wire  _GEN_132 = 3'h0 == io_cpuAddr ? 1'h0 : _GEN_115; // @[PPU.scala 111:24 52:25]
  assign vram_io_cpuDataOut_MPORT_1_en = vram_io_cpuDataOut_MPORT_1_en_pipe_0;
  assign vram_io_cpuDataOut_MPORT_1_addr = vram_io_cpuDataOut_MPORT_1_addr_pipe_0;
  assign vram_io_cpuDataOut_MPORT_1_data = vram[vram_io_cpuDataOut_MPORT_1_addr]; // @[PPU.scala 52:25]
  assign vram_MPORT_1_data = io_cpuDataIn;
  assign vram_MPORT_1_addr = ppuAddrReg[10:0];
  assign vram_MPORT_1_mask = 1'h1;
  assign vram_MPORT_1_en = io_cpuWrite & _GEN_132;
  assign oam_io_cpuDataOut_MPORT_en = oam_io_cpuDataOut_MPORT_en_pipe_0;
  assign oam_io_cpuDataOut_MPORT_addr = oam_io_cpuDataOut_MPORT_addr_pipe_0;
  assign oam_io_cpuDataOut_MPORT_data = oam[oam_io_cpuDataOut_MPORT_addr]; // @[PPU.scala 53:24]
  assign oam_MPORT_data = io_cpuDataIn;
  assign oam_MPORT_addr = oamAddr;
  assign oam_MPORT_mask = 1'h1;
  assign oam_MPORT_en = io_cpuWrite & _GEN_123;
  assign io_cpuDataOut = io_cpuRead ? _GEN_27 : 8'h0; // @[PPU.scala 90:17 92:20]
  assign io_pixelX = scanlineX; // @[PPU.scala 155:13]
  assign io_pixelY = scanlineY; // @[PPU.scala 156:13]
  assign io_vblank = vblankFlag; // @[PPU.scala 158:13]
  always @(posedge clock) begin
    if (vram_MPORT_1_en & vram_MPORT_1_mask) begin
      vram[vram_MPORT_1_addr] <= vram_MPORT_1_data; // @[PPU.scala 52:25]
    end
    vram_io_cpuDataOut_MPORT_1_en_pipe_0 <= io_cpuRead & _GEN_33;
    if (io_cpuRead & _GEN_33) begin
      vram_io_cpuDataOut_MPORT_1_addr_pipe_0 <= ppuAddrReg[10:0];
    end
    if (oam_MPORT_en & oam_MPORT_mask) begin
      oam[oam_MPORT_addr] <= oam_MPORT_data; // @[PPU.scala 53:24]
    end
    oam_io_cpuDataOut_MPORT_en_pipe_0 <= io_cpuRead & _GEN_30;
    if (io_cpuRead & _GEN_30) begin
      oam_io_cpuDataOut_MPORT_addr_pipe_0 <= oamAddr;
    end
    if (reset) begin // @[PPU.scala 45:24]
      oamAddr <= 8'h0; // @[PPU.scala 45:24]
    end else if (io_cpuWrite) begin // @[PPU.scala 110:21]
      if (!(3'h0 == io_cpuAddr)) begin // @[PPU.scala 111:24]
        if (!(3'h1 == io_cpuAddr)) begin // @[PPU.scala 111:24]
          oamAddr <= _GEN_87;
        end
      end
    end
    if (reset) begin // @[PPU.scala 48:29]
      ppuAddrLatch <= 1'h0; // @[PPU.scala 48:29]
    end else if (io_cpuWrite) begin // @[PPU.scala 110:21]
      if (3'h0 == io_cpuAddr) begin // @[PPU.scala 111:24]
        ppuAddrLatch <= _GEN_39;
      end else if (3'h1 == io_cpuAddr) begin // @[PPU.scala 111:24]
        ppuAddrLatch <= _GEN_39;
      end else begin
        ppuAddrLatch <= _GEN_95;
      end
    end else begin
      ppuAddrLatch <= _GEN_39;
    end
    if (reset) begin // @[PPU.scala 49:27]
      ppuAddrReg <= 16'h0; // @[PPU.scala 49:27]
    end else if (io_cpuWrite) begin // @[PPU.scala 110:21]
      if (3'h0 == io_cpuAddr) begin // @[PPU.scala 111:24]
        ppuAddrReg <= _GEN_46;
      end else if (3'h1 == io_cpuAddr) begin // @[PPU.scala 111:24]
        ppuAddrReg <= _GEN_46;
      end else begin
        ppuAddrReg <= _GEN_96;
      end
    end else begin
      ppuAddrReg <= _GEN_46;
    end
    if (reset) begin // @[PPU.scala 58:26]
      scanlineX <= 9'h0; // @[PPU.scala 58:26]
    end else if (scanlineX == 9'h154) begin // @[PPU.scala 67:29]
      scanlineX <= 9'h0; // @[PPU.scala 68:15]
    end else begin
      scanlineX <= _scanlineX_T_1; // @[PPU.scala 66:13]
    end
    if (reset) begin // @[PPU.scala 59:26]
      scanlineY <= 9'h0; // @[PPU.scala 59:26]
    end else if (scanlineX == 9'h154) begin // @[PPU.scala 67:29]
      if (scanlineY == 9'h105) begin // @[PPU.scala 71:31]
        scanlineY <= 9'h0; // @[PPU.scala 72:17]
      end else begin
        scanlineY <= _scanlineY_T_1; // @[PPU.scala 69:15]
      end
    end
    if (reset) begin // @[PPU.scala 62:27]
      vblankFlag <= 1'h0; // @[PPU.scala 62:27]
    end else if (io_cpuRead) begin // @[PPU.scala 92:20]
      if (3'h2 == io_cpuAddr) begin // @[PPU.scala 93:24]
        vblankFlag <= 1'h0; // @[PPU.scala 96:20]
      end else begin
        vblankFlag <= _GEN_6;
      end
    end else begin
      vblankFlag <= _GEN_6;
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
  reg [7:0] prgROM [0:32767]; // @[MemoryController.scala 38:27]
  wire  prgROM_io_cpuDataOut_MPORT_1_en; // @[MemoryController.scala 38:27]
  wire [14:0] prgROM_io_cpuDataOut_MPORT_1_addr; // @[MemoryController.scala 38:27]
  wire [7:0] prgROM_io_cpuDataOut_MPORT_1_data; // @[MemoryController.scala 38:27]
  wire [7:0] prgROM_MPORT_1_data; // @[MemoryController.scala 38:27]
  wire [14:0] prgROM_MPORT_1_addr; // @[MemoryController.scala 38:27]
  wire  prgROM_MPORT_1_mask; // @[MemoryController.scala 38:27]
  wire  prgROM_MPORT_1_en; // @[MemoryController.scala 38:27]
  wire [7:0] prgROM_MPORT_2_data; // @[MemoryController.scala 38:27]
  wire [14:0] prgROM_MPORT_2_addr; // @[MemoryController.scala 38:27]
  wire  prgROM_MPORT_2_mask; // @[MemoryController.scala 38:27]
  wire  prgROM_MPORT_2_en; // @[MemoryController.scala 38:27]
  reg  prgROM_io_cpuDataOut_MPORT_1_en_pipe_0;
  reg [14:0] prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0;
  wire  _T = io_cpuAddr < 16'h2000; // @[MemoryController.scala 57:21]
  wire  _T_3 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000; // @[MemoryController.scala 61:39]
  wire  _T_6 = io_cpuAddr >= 16'h8000; // @[MemoryController.scala 72:27]
  wire [15:0] romAddr = io_cpuAddr - 16'h8000; // @[MemoryController.scala 74:32]
  wire [7:0] _GEN_9 = io_cpuAddr >= 16'h8000 ? prgROM_io_cpuDataOut_MPORT_1_data : 8'h0; // @[MemoryController.scala 41:17 72:40 75:21]
  wire [7:0] _GEN_10 = io_cpuAddr == 16'h4017 ? io_controller2 : _GEN_9; // @[MemoryController.scala 69:41 71:21]
  wire  _GEN_11 = io_cpuAddr == 16'h4017 ? 1'h0 : _T_6; // @[MemoryController.scala 38:27 69:41]
  wire [7:0] _GEN_14 = io_cpuAddr == 16'h4016 ? io_controller1 : _GEN_10; // @[MemoryController.scala 66:41 68:21]
  wire  _GEN_15 = io_cpuAddr == 16'h4016 ? 1'h0 : _GEN_11; // @[MemoryController.scala 38:27 66:41]
  wire [2:0] _GEN_18 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? io_cpuAddr[2:0] : 3'h0; // @[MemoryController.scala 42:14 61:65 63:18]
  wire [7:0] _GEN_20 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? io_ppuDataOut : _GEN_14; // @[MemoryController.scala 61:65 65:21]
  wire  _GEN_21 = io_cpuAddr >= 16'h2000 & io_cpuAddr < 16'h4000 ? 1'h0 : _GEN_15; // @[MemoryController.scala 38:27 61:65]
  wire [7:0] _GEN_27 = io_cpuAddr < 16'h2000 ? internalRAM_io_cpuDataOut_MPORT_data : _GEN_20; // @[MemoryController.scala 57:33 60:21]
  wire [2:0] _GEN_28 = io_cpuAddr < 16'h2000 ? 3'h0 : _GEN_18; // @[MemoryController.scala 42:14 57:33]
  wire  _GEN_29 = io_cpuAddr < 16'h2000 ? 1'h0 : _T_3; // @[MemoryController.scala 45:14 57:33]
  wire  _GEN_30 = io_cpuAddr < 16'h2000 ? 1'h0 : _GEN_21; // @[MemoryController.scala 38:27 57:33]
  wire [2:0] _GEN_37 = io_cpuRead ? _GEN_28 : 3'h0; // @[MemoryController.scala 42:14 56:20]
  wire [2:0] _GEN_47 = _T_3 ? io_cpuAddr[2:0] : _GEN_37; // @[MemoryController.scala 84:65 86:18]
  wire [7:0] _GEN_48 = _T_3 ? io_cpuDataIn : 8'h0; // @[MemoryController.scala 43:16 84:65 87:20]
  wire  _GEN_52 = _T_3 ? 1'h0 : _T_6; // @[MemoryController.scala 38:27 84:65]
  wire [2:0] _GEN_60 = _T ? _GEN_37 : _GEN_47; // @[MemoryController.scala 80:33]
  wire [7:0] _GEN_61 = _T ? 8'h0 : _GEN_48; // @[MemoryController.scala 43:16 80:33]
  wire  _GEN_65 = _T ? 1'h0 : _GEN_52; // @[MemoryController.scala 38:27 80:33]
  wire  _T_13 = io_romLoadEn & io_romLoadPRG; // @[MemoryController.scala 97:21]
  wire  _T_14 = io_romLoadAddr < 16'h8000; // @[MemoryController.scala 99:25]
  assign internalRAM_io_cpuDataOut_MPORT_en = internalRAM_io_cpuDataOut_MPORT_en_pipe_0;
  assign internalRAM_io_cpuDataOut_MPORT_addr = internalRAM_io_cpuDataOut_MPORT_addr_pipe_0;
  assign internalRAM_io_cpuDataOut_MPORT_data = internalRAM[internalRAM_io_cpuDataOut_MPORT_addr]; // @[MemoryController.scala 35:32]
  assign internalRAM_MPORT_data = io_cpuDataIn;
  assign internalRAM_MPORT_addr = io_cpuAddr[10:0];
  assign internalRAM_MPORT_mask = 1'h1;
  assign internalRAM_MPORT_en = io_cpuWrite & _T;
  assign prgROM_io_cpuDataOut_MPORT_1_en = prgROM_io_cpuDataOut_MPORT_1_en_pipe_0;
  assign prgROM_io_cpuDataOut_MPORT_1_addr = prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0;
  assign prgROM_io_cpuDataOut_MPORT_1_data = prgROM[prgROM_io_cpuDataOut_MPORT_1_addr]; // @[MemoryController.scala 38:27]
  assign prgROM_MPORT_1_data = io_cpuDataIn;
  assign prgROM_MPORT_1_addr = romAddr[14:0];
  assign prgROM_MPORT_1_mask = 1'h1;
  assign prgROM_MPORT_1_en = io_cpuWrite & _GEN_65;
  assign prgROM_MPORT_2_data = io_romLoadData;
  assign prgROM_MPORT_2_addr = io_romLoadAddr[14:0];
  assign prgROM_MPORT_2_mask = 1'h1;
  assign prgROM_MPORT_2_en = _T_13 & _T_14;
  assign io_cpuDataOut = io_cpuRead ? _GEN_27 : 8'h0; // @[MemoryController.scala 41:17 56:20]
  assign io_ppuAddr = io_cpuWrite ? _GEN_60 : _GEN_37; // @[MemoryController.scala 79:21]
  assign io_ppuDataIn = io_cpuWrite ? _GEN_61 : 8'h0; // @[MemoryController.scala 43:16 79:21]
  assign io_ppuWrite = io_cpuWrite & _GEN_29; // @[MemoryController.scala 44:15 79:21]
  assign io_ppuRead = io_cpuRead & _GEN_29; // @[MemoryController.scala 45:14 56:20]
  always @(posedge clock) begin
    if (internalRAM_MPORT_en & internalRAM_MPORT_mask) begin
      internalRAM[internalRAM_MPORT_addr] <= internalRAM_MPORT_data; // @[MemoryController.scala 35:32]
    end
    internalRAM_io_cpuDataOut_MPORT_en_pipe_0 <= io_cpuRead & _T;
    if (io_cpuRead & _T) begin
      internalRAM_io_cpuDataOut_MPORT_addr_pipe_0 <= io_cpuAddr[10:0];
    end
    if (prgROM_MPORT_1_en & prgROM_MPORT_1_mask) begin
      prgROM[prgROM_MPORT_1_addr] <= prgROM_MPORT_1_data; // @[MemoryController.scala 38:27]
    end
    if (prgROM_MPORT_2_en & prgROM_MPORT_2_mask) begin
      prgROM[prgROM_MPORT_2_addr] <= prgROM_MPORT_2_data; // @[MemoryController.scala 38:27]
    end
    prgROM_io_cpuDataOut_MPORT_1_en_pipe_0 <= io_cpuRead & _GEN_30;
    if (io_cpuRead & _GEN_30) begin
      prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0 <= romAddr[14:0];
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
  input         io_romLoadEn,
  input  [15:0] io_romLoadAddr,
  input  [7:0]  io_romLoadData,
  input         io_romLoadPRG
);
  wire  cpu_clock; // @[NESSystem.scala 32:19]
  wire  cpu_reset; // @[NESSystem.scala 32:19]
  wire [15:0] cpu_io_memAddr; // @[NESSystem.scala 32:19]
  wire [7:0] cpu_io_memDataOut; // @[NESSystem.scala 32:19]
  wire [7:0] cpu_io_memDataIn; // @[NESSystem.scala 32:19]
  wire  cpu_io_memWrite; // @[NESSystem.scala 32:19]
  wire  cpu_io_memRead; // @[NESSystem.scala 32:19]
  wire [7:0] cpu_io_debug_regA; // @[NESSystem.scala 32:19]
  wire [7:0] cpu_io_debug_regX; // @[NESSystem.scala 32:19]
  wire [7:0] cpu_io_debug_regY; // @[NESSystem.scala 32:19]
  wire [15:0] cpu_io_debug_regPC; // @[NESSystem.scala 32:19]
  wire [7:0] cpu_io_debug_regSP; // @[NESSystem.scala 32:19]
  wire  cpu_io_debug_flagC; // @[NESSystem.scala 32:19]
  wire  cpu_io_debug_flagZ; // @[NESSystem.scala 32:19]
  wire  cpu_io_debug_flagN; // @[NESSystem.scala 32:19]
  wire  cpu_io_debug_flagV; // @[NESSystem.scala 32:19]
  wire [7:0] cpu_io_debug_opcode; // @[NESSystem.scala 32:19]
  wire  cpu_io_reset; // @[NESSystem.scala 32:19]
  wire  ppu_clock; // @[NESSystem.scala 33:19]
  wire  ppu_reset; // @[NESSystem.scala 33:19]
  wire [2:0] ppu_io_cpuAddr; // @[NESSystem.scala 33:19]
  wire [7:0] ppu_io_cpuDataIn; // @[NESSystem.scala 33:19]
  wire [7:0] ppu_io_cpuDataOut; // @[NESSystem.scala 33:19]
  wire  ppu_io_cpuWrite; // @[NESSystem.scala 33:19]
  wire  ppu_io_cpuRead; // @[NESSystem.scala 33:19]
  wire [8:0] ppu_io_pixelX; // @[NESSystem.scala 33:19]
  wire [8:0] ppu_io_pixelY; // @[NESSystem.scala 33:19]
  wire  ppu_io_vblank; // @[NESSystem.scala 33:19]
  wire  memory_clock; // @[NESSystem.scala 34:22]
  wire [15:0] memory_io_cpuAddr; // @[NESSystem.scala 34:22]
  wire [7:0] memory_io_cpuDataIn; // @[NESSystem.scala 34:22]
  wire [7:0] memory_io_cpuDataOut; // @[NESSystem.scala 34:22]
  wire  memory_io_cpuWrite; // @[NESSystem.scala 34:22]
  wire  memory_io_cpuRead; // @[NESSystem.scala 34:22]
  wire [2:0] memory_io_ppuAddr; // @[NESSystem.scala 34:22]
  wire [7:0] memory_io_ppuDataIn; // @[NESSystem.scala 34:22]
  wire [7:0] memory_io_ppuDataOut; // @[NESSystem.scala 34:22]
  wire  memory_io_ppuWrite; // @[NESSystem.scala 34:22]
  wire  memory_io_ppuRead; // @[NESSystem.scala 34:22]
  wire [7:0] memory_io_controller1; // @[NESSystem.scala 34:22]
  wire [7:0] memory_io_controller2; // @[NESSystem.scala 34:22]
  wire  memory_io_romLoadEn; // @[NESSystem.scala 34:22]
  wire [15:0] memory_io_romLoadAddr; // @[NESSystem.scala 34:22]
  wire [7:0] memory_io_romLoadData; // @[NESSystem.scala 34:22]
  wire  memory_io_romLoadPRG; // @[NESSystem.scala 34:22]
  CPU6502Refactored cpu ( // @[NESSystem.scala 32:19]
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
    .io_reset(cpu_io_reset)
  );
  PPU ppu ( // @[NESSystem.scala 33:19]
    .clock(ppu_clock),
    .reset(ppu_reset),
    .io_cpuAddr(ppu_io_cpuAddr),
    .io_cpuDataIn(ppu_io_cpuDataIn),
    .io_cpuDataOut(ppu_io_cpuDataOut),
    .io_cpuWrite(ppu_io_cpuWrite),
    .io_cpuRead(ppu_io_cpuRead),
    .io_pixelX(ppu_io_pixelX),
    .io_pixelY(ppu_io_pixelY),
    .io_vblank(ppu_io_vblank)
  );
  MemoryController memory ( // @[NESSystem.scala 34:22]
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
  assign io_pixelX = ppu_io_pixelX; // @[NESSystem.scala 58:13]
  assign io_pixelY = ppu_io_pixelY; // @[NESSystem.scala 59:13]
  assign io_pixelColor = 6'h0; // @[NESSystem.scala 60:17]
  assign io_vblank = ppu_io_vblank; // @[NESSystem.scala 61:13]
  assign io_debug_regA = cpu_io_debug_regA; // @[NESSystem.scala 64:12]
  assign io_debug_regX = cpu_io_debug_regX; // @[NESSystem.scala 64:12]
  assign io_debug_regY = cpu_io_debug_regY; // @[NESSystem.scala 64:12]
  assign io_debug_regPC = cpu_io_debug_regPC; // @[NESSystem.scala 64:12]
  assign io_debug_regSP = cpu_io_debug_regSP; // @[NESSystem.scala 64:12]
  assign io_debug_flagC = cpu_io_debug_flagC; // @[NESSystem.scala 64:12]
  assign io_debug_flagZ = cpu_io_debug_flagZ; // @[NESSystem.scala 64:12]
  assign io_debug_flagN = cpu_io_debug_flagN; // @[NESSystem.scala 64:12]
  assign io_debug_flagV = cpu_io_debug_flagV; // @[NESSystem.scala 64:12]
  assign io_debug_opcode = cpu_io_debug_opcode; // @[NESSystem.scala 64:12]
  assign cpu_clock = clock;
  assign cpu_reset = reset;
  assign cpu_io_memDataIn = memory_io_cpuDataOut; // @[NESSystem.scala 42:20]
  assign cpu_io_reset = reset; // @[NESSystem.scala 37:25]
  assign ppu_clock = clock;
  assign ppu_reset = reset;
  assign ppu_io_cpuAddr = memory_io_ppuAddr; // @[NESSystem.scala 47:18]
  assign ppu_io_cpuDataIn = memory_io_ppuDataIn; // @[NESSystem.scala 48:20]
  assign ppu_io_cpuWrite = memory_io_ppuWrite; // @[NESSystem.scala 50:19]
  assign ppu_io_cpuRead = memory_io_ppuRead; // @[NESSystem.scala 51:18]
  assign memory_clock = clock;
  assign memory_io_cpuAddr = cpu_io_memAddr; // @[NESSystem.scala 40:21]
  assign memory_io_cpuDataIn = cpu_io_memDataOut; // @[NESSystem.scala 41:23]
  assign memory_io_cpuWrite = cpu_io_memWrite; // @[NESSystem.scala 43:22]
  assign memory_io_cpuRead = cpu_io_memRead; // @[NESSystem.scala 44:21]
  assign memory_io_ppuDataOut = ppu_io_cpuDataOut; // @[NESSystem.scala 49:24]
  assign memory_io_controller1 = io_controller1; // @[NESSystem.scala 54:25]
  assign memory_io_controller2 = io_controller2; // @[NESSystem.scala 55:25]
  assign memory_io_romLoadEn = io_romLoadEn; // @[NESSystem.scala 67:23]
  assign memory_io_romLoadAddr = io_romLoadAddr; // @[NESSystem.scala 68:25]
  assign memory_io_romLoadData = io_romLoadData; // @[NESSystem.scala 69:25]
  assign memory_io_romLoadPRG = io_romLoadPRG; // @[NESSystem.scala 70:24]
endmodule
