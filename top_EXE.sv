`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2026 11:41:23
// Design Name: 
// Module Name: top_EXE
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

module top_EXE(
    input logic [31:0] rs1_data,
    input logic [31:0] rs2_data,
    input logic [31:0] imm,
    input logic [31:0] pc,
    input logic [6:0] opcode,
    // Control Inputs
    input logic alu_src,
    input logic [2:0] alu_op,
    input logic [2:0] fn3,
    input logic fu7_5,
    input logic [6:0] imm11_5,
    // Outputs
    output logic [31:0] alu_out,
    output logic [31:0] rs2_selected,
    output logic [31:0] pc_new,
    output logic zero
);
    // Internal ALU Control Signal
    logic [4:0] alu_control;
    // ALU CONTROL
    ALU_CONTROL ALU_CTRL (
        .alu_op(alu_op),
        .fn3(fn3),
        .fu7_5(fu7_5),
        .imm11_5(imm11_5),
        .control_out(alu_control)
    );
    // RS2 MUX
    rs2_mux MUX_RS2 (
        .rs2_data(rs2_data),
        .imm(imm),
        .alu_src(alu_src),
        .opcode(opcode),
        .rs2(rs2_selected)
    );
    // ALU
    ALU ALU_EXE (
        .alu_control(alu_control),
        .rs1_data(rs1_data),
        .rs2_data(rs2_selected),
        .alu_out(alu_out),
        .zero(zero)
    );
    // PC Calculation
    PCnew PC_EX (
        .opcode(opcode),
        .pc(pc),
        .imm(imm),
        .pc_new(pc_new)
    );
endmodule