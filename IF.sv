`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2026 14:33:08
// Design Name: 
// Module Name: IF
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


module IF(input logic clk,reset,stall,pc_src,input logic[31:0]pc_signed_offset,
output logic[31:0] address,pc_new);
//MUX
logic[31:0] pc_next;
assign pc_new=address+32'd4;
always_comb begin 
    if(pc_src)
        pc_next=pc_signed_offset;
    else
        pc_next=pc_new;
end
//PC Register
always_ff @(posedge clk or posedge reset) begin 
if (reset)
    address <= 32'h80000000;
else if (!stall) 
/*why stall?
to wait for the current instruction to go in only after the previous
instrution has compete the WB stage(exicution )
stall gets updated in wb stage 
till the wb stage its 1 and after wb its put to 0 using some hardware*/

    address <= pc_next;
end 
endmodule
