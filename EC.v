`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2023 02:29:19
// Design Name: 
// Module Name: EC
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

// Equality Checker
module EC(
input H0,L0,EC_prev,H1, // H0 -> High bit of Previous TBC , L0 -> Low bit of Previous TBC , H1 -> High bit of Current TBC
output EC_out,EC_next 
    );
    
wire w; // Output from NOR gate

assign w = ~(H0 | L0);
assign EC_next = (w & EC_prev);
assign EC_out = (EC_next & H1);

endmodule
