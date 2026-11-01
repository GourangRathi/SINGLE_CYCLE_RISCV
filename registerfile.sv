`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2026 14:46:57
// Design Name: 
// Module Name: registerfile
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


module registerfile(
    input logic [4:0] rs1_sel, rs2_sel, rd_sel,
    input logic [31:0] wb_data,
    input logic reg_write, clk, reset,
    output logic [31:0] rs1_data, rs2_data
);

logic [31:0] reg_file [31:0];

always_ff @(posedge clk) begin
    if (reset) begin
        for (int i = 0; i < 32; i++)
            reg_file[i] <= 32'd0;
    end
    else if ((rd_sel != 0) && reg_write) begin
        reg_file[rd_sel] <= wb_data;
    end
end

// Read logic
assign rs1_data = (rs1_sel == 0) ? 32'b0 : reg_file[rs1_sel];
assign rs2_data = (rs2_sel == 0) ? 32'b0 : reg_file[rs2_sel];

endmodule