`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 04:28:49
// Design Name: 
// Module Name: TBAC
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

// Two-Bit Accurate Comparator
module TBAC(
input X0,X1,Y0,Y1, // X and Y are the two bits from different pixels where 0 is LSB and 1 is MSB
output H,L // H -> X > Y , L -> X < Y
    );

assign H = (X1 & (!Y1)) | (X1 & X0 & (!Y0)) | (X0 & (!Y1) & (!Y0));
assign L = ((!X1) & Y1) | ((!X0) & Y1 & Y0) | ((!X1) & (!X0) & Y0);

endmodule
