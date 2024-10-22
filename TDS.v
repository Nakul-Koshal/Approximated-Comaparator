`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2023 02:36:44
// Design Name: 
// Module Name: TDS
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

// Ternary Data Sorter
module TDS(
input [7:0]P0,P1,P2,
output [7:0]Min,Med,Max
    );
    
wire [20:0]w;
wire [5:0]EC_next;
wire [8:0]EC_out;
wire [2:0]mux_sel;
wire [7:0]Temp_max,Temp_min_1,Temp_min_2;

// REMEMBER : Lowest(diagram made in paper) TBC is comparing MSB 

// Stage-1 -> Comparing two Random Pixels
// Starting from BELOW(diagram made in paper)
TBC TBC_1_MSB_67(.X0(P0[6]),.X1(P0[7]),.Y0(P1[6]),.Y1(P1[7]),.H(w[0]),.L(w[1]));
TBC TBC_1_BITS45(.X0(P0[4]),.X1(P0[5]),.Y0(P1[4]),.Y1(P1[5]),.H(w[2]),.L(w[3]));
TBC TBC_1_BITS23(.X0(P0[2]),.X1(P0[3]),.Y0(P1[2]),.Y1(P1[3]),.H(w[4]),.L(w[5]));
TBC TBC_1_LSB_01(.X0(P0[0]),.X1(P0[1]),.Y0(P1[0]),.Y1(P1[1]),.H(w[6]),.L());
// Use TBAC for accurate comparator

EC EC_1_MSB_45(.H0(w[0]),.L0(w[1]),.EC_prev(1'b1),.H1(w[2]),.EC_next(EC_next[0]),.EC_out(EC_out[0]));
EC EC_1_BITS23(.H0(w[2]),.L0(w[3]),.EC_prev(EC_next[0]),.H1(w[4]),.EC_next(EC_next[1]),.EC_out(EC_out[1]));
EC EC_1_LSB_01(.H0(w[4]),.L0(w[5]),.EC_prev(EC_next[1]),.H1(w[6]),.EC_next(),.EC_out(EC_out[2]));

assign mux_sel[0] = EC_out[0] | EC_out[1] | EC_out[2] | w[0]; // ORing of all H bits 

mux8bit m_1_min(.sel(mux_sel[0]),.I1(P1),.I0(P0),.Y(Temp_min_1));
mux8bit m_1_max(.sel(mux_sel[0]),.I1(P0),.I0(P1),.Y(Temp_max));





// Stage-2 -> Comparing Higher pixel with a New Pixel
TBC TBC_2_MSB_67(.X0(Temp_max[6]),.X1(Temp_max[7]),.Y0(P2[6]),.Y1(P2[7]),.H(w[7]),.L(w[8]));
TBC TBC_2_BITS45(.X0(Temp_max[4]),.X1(Temp_max[5]),.Y0(P2[4]),.Y1(P2[5]),.H(w[9]),.L(w[10]));
TBC TBC_2_BITS23(.X0(Temp_max[2]),.X1(Temp_max[3]),.Y0(P2[2]),.Y1(P2[3]),.H(w[11]),.L(w[12]));
TBC TBC_2_LSB_01(.X0(Temp_max[0]),.X1(Temp_max[1]),.Y0(P2[0]),.Y1(P2[1]),.H(w[13]),.L());
// Use TBAC for accurate comparator

EC EC_2_MSB_45(.H0(w[7]),.L0(w[8]),.EC_prev(1'b1),.H1(w[9]),.EC_next(EC_next[2]),.EC_out(EC_out[3]));
EC EC_2_BITS23(.H0(w[9]),.L0(w[10]),.EC_prev(EC_next[2]),.H1(w[11]),.EC_next(EC_next[3]),.EC_out(EC_out[4]));
EC EC_2_LSB_01(.H0(w[11]),.L0(w[12]),.EC_prev(EC_next[3]),.H1(w[13]),.EC_next(),.EC_out(EC_out[5]));

assign mux_sel[1] = EC_out[3] | EC_out[4] | EC_out[5] | w[7];

mux8bit m_2_min(.sel(mux_sel[1]),.I1(P2),.I0(Temp_max),.Y(Temp_min_2));
mux8bit m_2_max(.sel(mux_sel[1]),.I1(Temp_max),.I0(P2),.Y(Max)); // MAX VALUE





// Stage-3 -> Comparing Both the Minimum Pixels
TBC TBC_3_MSB_67(.X0(Temp_min_1[6]),.X1(Temp_min_1[7]),.Y0(Temp_min_2[6]),.Y1(Temp_min_2[7]),.H(w[14]),.L(w[15]));
TBC TBC_3_BITS45(.X0(Temp_min_1[4]),.X1(Temp_min_1[5]),.Y0(Temp_min_2[4]),.Y1(Temp_min_2[5]),.H(w[16]),.L(w[17]));
TBC TBC_3_BITS23(.X0(Temp_min_1[2]),.X1(Temp_min_1[3]),.Y0(Temp_min_2[2]),.Y1(Temp_min_2[3]),.H(w[18]),.L(w[19]));
TBC TBC_3_LSB_01(.X0(Temp_min_1[0]),.X1(Temp_min_1[1]),.Y0(Temp_min_2[0]),.Y1(Temp_min_2[1]),.H(w[20]),.L());
// Use TBAC for accurate comparator

EC EC_3_MSB_45(.H0(w[14]),.L0(w[15]),.EC_prev(1'b1),.H1(w[16]),.EC_next(EC_next[4]),.EC_out(EC_out[6]));
EC EC_3_BITS23(.H0(w[16]),.L0(w[17]),.EC_prev(EC_next[4]),.H1(w[18]),.EC_next(EC_next[5]),.EC_out(EC_out[7]));
EC EC_3_LSB_01(.H0(w[18]),.L0(w[19]),.EC_prev(EC_next[5]),.H1(w[20]),.EC_next(),.EC_out(EC_out[8]));

assign mux_sel[2] = EC_out[6] | EC_out[7] | EC_out[8] | w[14];

mux8bit m_3_min(.sel(mux_sel[2]),.I1(Temp_min_2),.I0(Temp_min_1),.Y(Min)); // MIN VLAUE
mux8bit m_3_max(.sel(mux_sel[2]),.I1(Temp_min_1),.I0(Temp_min_2),.Y(Med)); // MED VALUE


endmodule
