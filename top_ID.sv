`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2026 18:16:36
// Design Name: 
// Module Name: top_ID
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module top_ID(
    input logic clk, reset,
    input logic [31:0] instruction,
    input logic [31:0] wb_data,
    // ID outputs
    output logic [4:0] rs1, rs2, rd,
    output logic [6:0] opcode, imm11_5,
    output logic [2:0] fn3,
    output logic [12:0] imm,
    output logic func7_5,
    output logic [19:0] imm_uj,
    // Register file outputs
    output logic [31:0] rs1_data, rs2_data,
    // Immediate generator output
    output logic [31:0] imm_output,
    // Main control outputs
    output logic branch, mux_inp, memread, memwrite,
    output logic alusrc, reg_write,
    output logic [1:0] memtoreg,
    output logic [2:0] aluop
);
// 1. INSTRUCTION DECODE
ID ID1 (
    .instruction(instruction),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .opcode(opcode),
    .imm11_5(imm11_5),
    .fn3(fn3),
    .imm(imm),
    .func7_5(func7_5),
    .imm_uj(imm_uj)
);
// 2. MAIN CONTROL
MAIN_CONTROL MC1 (
    .opcode(opcode),
    .branch(branch),
    .mux_inp(mux_inp),
    .memread(memread),
    .memwrite(memwrite),
    .alusrc(alusrc),
    .reg_write(reg_write),
    .memtoreg(memtoreg),
    .aluop(aluop)
);
// 3. IMMEDIATE GENERATOR
imm_generator IMM1 (
    .imm_input(imm[11:0]),
    .fn3(fn3),
    .opcode(opcode),
    .imm_input_uj(imm_uj),
    .imm_output(imm_output)
);
// 4. REGISTER FILE
registerfile RF1 (
    .rs1_sel(rs1),
    .rs2_sel(rs2),
    .rd_sel(rd),
    .wb_data(wb_data),
    .reg_write(reg_write),
    .clk(clk),
    .reset(reset),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);
endmodule
