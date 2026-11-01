`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2026 15:32:17
// Design Name: 
// Module Name: ID
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


module ID(
          input logic [31:0] instruction,
          output logic [4:0] rs1,rs2,rd,
          output logic [6:0] opcode,imm11_5,
          output logic [2:0] fn3,
          output logic [12:0] imm,
          output logic func7_5, // 5th bit as only that bit changes
          output logic [19:0] imm_uj
);
always_comb 
begin 
// Default value 
rd = 5'd0;
fn3 = 3'd0;
rs1 = 5'd0;
rs2 = 5'd0;
imm = 12'd0;
imm_uj = 20'd0;
imm11_5 = 7'd0;
func7_5 = 1'b0;
opcode = instruction[6:0];

case(opcode)
7'b0110011:begin//R_type
    rd = instruction[11:7];
    fn3 = instruction[14:12];
    rs1 = instruction[19:15];
    rs2 = instruction[24:20];
    func7_5 = instruction[30];
end
7'b0010011, 7'b0000011, 7'b1100111: begin // I-type (ALU imm, load, jalr)
    rd      = instruction[11:7];
    fn3   = instruction[14:12];
    rs1     = instruction[19:15];
    imm     = instruction[31:20];
    func7_5 = instruction[30];   // needed for srli vs srai
end

7'b0100011: begin // S-type (store)
    fn3   = instruction[14:12];
    rs1     = instruction[19:15];
    rs2     = instruction[24:20];
    imm11_5 = instruction[31:25];
    imm     = {instruction[31:25], instruction[11:7]}; // full 12-bit offset
end

7'b1100011: begin // B-type (branch)
    fn3   = instruction[14:12];
    rs1     = instruction[19:15];
    rs2     = instruction[24:20];
    imm11_5 = instruction[31:25];
    imm     = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]}; // imm[12:1]
end

7'b0110111, 7'b0010111: begin // U-type (lui, auipc)
    rd     = instruction[11:7];
    imm_uj = instruction[31:12];  // upper 20 bits
end

7'b1101111: begin // J-type (jal)
    rd     = instruction[11:7];
    imm_uj = {instruction[31], instruction[19:12], instruction[20], instruction[30:21]}; // imm[20:1]
end

default: ; // defaults already assigned above  
endcase
end
endmodule