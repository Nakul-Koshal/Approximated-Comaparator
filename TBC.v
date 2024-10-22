`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2023 20:39:14
// Design Name: 
// Module Name: TBC
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

// Two-Bit Comparator
module TBC(
input X0,X1,Y0,Y1, // X and Y are the two bits from different pixels where 0 is LSB and 1 is MSB
output H,L // H -> X > Y , L -> X < Y
    );

assign H = ((X0) & (!Y1)) | (X1 & (!Y1)) | (X1 & (!Y0));
assign L = (!X1) & Y1;

endmodule
