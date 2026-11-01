`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2026 10:17:23
// Design Name: 
// Module Name: ALU
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


module ALU(
    input logic [4:0] alu_control,
    input logic [31:0] rs1_data,rs2_data,
    output logic [31:0] alu_out,
    output logic zero 
        );
        logic signed [31:0] rs1_signed,rs2_signed;
        assign rs1_signed = $signed(rs1_data);
        assign rs2_signed = $signed(rs2_data);
        
        always_comb begin
        //default 
        alu_out = {32{1'b0}};
        zero = 1'b0;
        
        unique case (alu_control)
            // Arthemetic
            5'b00000: //ADD /ADDI
                alu_out = rs1_data + rs2_data; 
            5'b00001: // SUB
                alu_out = rs1_data - rs2_data;
            //Logical
            5'b00010: //XOR /XORI
                alu_out = rs1_data ^ rs2_data; 
            5'b00011: //OR /ORI
                alu_out = rs1_data | rs2_data;
            5'b00100: //AND /ANDI
                alu_out = rs1_data & rs2_data;
            //Shift Operations
            5'b00101: // SLL /SLLI
                alu_out = rs1_data << rs2_data[4:0];
            5'b00110: // SRL /SRLI
                alu_out = rs1_data >> rs2_data[4:0];
            5'b00111: // SRA /SRAI
                alu_out = rs1_data >>> rs2_data[4:0];
            //Set less than
            5'b01000: // SLT /SLTI
                alu_out = (rs1_signed < rs2_signed) ? 32'd1 : 32'd0;
            5'b01001: // SLTU /SLTIU
                alu_out = (rs1_data < rs2_data) ? 32'd1 : 32'd0;
            //Branch
            5'b01010: //BEQ
                zero = (rs1_data == rs2_data);
            5'b01011: //BNE
                zero = (rs1_data != rs2_data);
            5'b01100: //BLT
                zero = (rs1_signed < rs2_signed);
            5'b01101: //BGE
                zero = (rs1_signed >= rs2_signed);
            5'b01110: //BLTU
                zero = (rs1_data < rs2_data);
            5'b01111: //BGEU
                zero = (rs1_data >= rs2_data);
              
            // Undefined control codes
            default:
            begin
                alu_out = {32{1'b0}};
                zero = 1'b0;
            end
    endcase
    end
endmodule
