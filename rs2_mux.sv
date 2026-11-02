`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2026 11:39:05
// Design Name: 
// Module Name: rs2_mux
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


module rs2_mux(input logic [31:0]rs2_data,
input logic [31:0] imm,
input logic alu_src,
input logic [6:0] opcode,
output logic [31:0] rs2
    );
      assign rs2=alu_src?imm:rs2_data;
endmodule
