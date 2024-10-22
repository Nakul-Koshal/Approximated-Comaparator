`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2023 03:33:26
// Design Name: 
// Module Name: mux8bit
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


module mux8bit(
input sel,
input [7:0]I1,I0,
output [7:0]Y
    );
    
assign Y = sel ? I1 : I0;

endmodule