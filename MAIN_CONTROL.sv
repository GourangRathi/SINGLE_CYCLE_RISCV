`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2026 17:08:43
// Design Name: 
// Module Name: MAIN_CONTROL
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


module MAIN_CONTROL(
    input  logic [6:0] opcode,
    output logic branch, mux_inp, memread, memwrite, alusrc, reg_write,
    output logic [1:0] memtoreg,
    output logic [2:0] aluop
);
always_comb begin
    // Default values
    branch   = 0;
    mux_inp  = 0;
    memread  = 0;
    memwrite = 0;
    alusrc   = 0;
    reg_write = 0;
    memtoreg = 2'b00;
    aluop    = 3'b000;
    
    case (opcode)
        7'b0110011: begin // R-Type
            memtoreg  = 2'b00;
            branch    = 0;
            memread   = 0;
            memwrite  = 0;
            alusrc    = 0;
            reg_write = 1;
            aluop     = 3'b000;
            mux_inp   = 0;
        end
        7'b0010011: begin // I-Type ALU
            memtoreg  = 2'b00;
            branch    = 0;
            memread   = 0;
            memwrite  = 0;
            alusrc    = 1;
            reg_write = 1;
            aluop     = 3'b001;
            mux_inp   = 0;
        end
        7'b0000011: begin // Load
            memtoreg  = 2'b01;
            branch    = 0;
            memread   = 1;
            memwrite  = 0;
            alusrc    = 1;
            reg_write = 1;
            aluop     = 3'b010;
            mux_inp   = 0;
        end
        7'b0100011: begin // Store
            memtoreg  = 2'b11;
            branch    = 0;
            memread   = 0;
            memwrite  = 1;
            alusrc    = 1;
            reg_write = 0;
            aluop     = 3'b011;
            mux_inp   = 0;
        end
        7'b1100011: begin // Branch
            memtoreg  = 2'b00;
            branch    = 1;
            memread   = 0;
            memwrite  = 0;
            alusrc    = 0;
            reg_write = 0;
            aluop     = 3'b100;
            mux_inp   = 0;
        end
        7'b1101111: begin // JAL
            memtoreg  = 2'b10;
            branch    = 0;
            memread   = 0;
            memwrite  = 0;
            alusrc    = 1;
            reg_write = 1;
            aluop     = 3'b110;
            mux_inp   = 0;
        end
        7'b1100111: begin // JALR
            memtoreg  = 2'b10;
            branch    = 0;
            memread   = 0;
            memwrite  = 0;
            alusrc    = 1;
            reg_write = 1;
            aluop     = 3'b001;
            mux_inp   = 1;
        end
        7'b0110111: begin // LUI
            memtoreg  = 2'b10;
            branch    = 0;
            memread   = 0;
            memwrite  = 0;
            alusrc    = 1;
            reg_write = 1;
            aluop     = 3'b110;
            mux_inp   = 0;
        end
        7'b0010111: begin // AUIPC
            memtoreg  = 2'b10;
            branch    = 0;
            memread   = 0;
            memwrite  = 0;
            alusrc    = 1;
            reg_write = 1;
            aluop     = 3'b000;
            mux_inp   = 0;
        end
        default: begin
        end
    endcase
end
endmodule
