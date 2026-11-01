`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 15:08:28
// Design Name: 
// Module Name: ALU_CONTROL
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

module ALU_CONTROL(
    input  logic [2:0] alu_op, fn3,
    input  logic fu7_5,
    input  logic [6:0] imm11_5,
    output logic [4:0] control_out
);

always_comb begin
    control_out = 5'b00000;
    case (alu_op)
        3'b000: begin // R-Type instructions
            case (fn3)
                3'b000: begin
                    if (fu7_5 == 1'b0)
                        control_out = 5'b00000; // ADD
                    else
                        control_out = 5'b00001; // SUB
                end
                3'b001: begin
                    control_out = 5'b00101; // SLL
                end
                3'b010: begin
                    control_out = 5'b01000; // SLT
                end
                3'b011: begin
                    control_out = 5'b01001; // SLTU
                end
                3'b100: begin
                    control_out = 5'b00010; // XOR
                end
                3'b101: begin
                    if (fu7_5 == 1'b0)
                        control_out = 5'b00110; // SRL
                    else
                        control_out = 5'b00111; // SRA
                end
                3'b110: begin
                    control_out = 5'b00011; // OR
                end
                3'b111: begin
                    control_out = 5'b00100; // AND
                end
                default: control_out = 5'b00000;
            endcase
        end
        3'b001: begin // I-Type ALU instructions
            case (fn3)
                3'b000: control_out = 5'b00000; // ADDI
                3'b010: control_out = 5'b01000; // SLTI
                3'b011: control_out = 5'b01001; // SLTIU
                3'b100: control_out = 5'b00010; // XORI
                3'b110: control_out = 5'b00011; // ORI
                3'b111: control_out = 5'b00100; // ANDI
                3'b001: control_out = 5'b00101; // SLLI
                3'b101: begin
                    if (imm11_5 == 7'b0000000)
                        control_out = 5'b00110; // SRLI
                    else if (imm11_5 == 7'b0100000)
                        control_out = 5'b00111; // SRAI
                    else
                        control_out = 5'b00000;
                end
                default: control_out = 5'b00000;
            endcase
        end
        3'b010,3'b011: begin // Load and Store: address calculation
            control_out = 5'b00000; // ADD address
        end
        3'b100: begin // Branch instructions
            case (fn3)
                3'b000: control_out = 5'b01010; // BEQ
                3'b001: control_out = 5'b01011; // BNE
                3'b100: control_out = 5'b01100; // BLT
                3'b101: control_out = 5'b01101; // BGE
                3'b110: control_out = 5'b01110; // BLTU
                3'b111: control_out = 5'b01111; // BGEU
                default: control_out = 5'b00000;
            endcase
        end
        3'b110: begin // JAL, LUI, AUIPC
            control_out = 5'b00000; // ADD path
        end
        default: begin
            control_out = 5'b00000;
        end
    endcase
end
endmodule