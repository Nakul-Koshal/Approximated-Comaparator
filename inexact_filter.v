`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2024 04:26:02
// Design Name: 
// Module Name: inexact_filter
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


module inexact_filter
# (parameter COUNT= 256)//Size of Line Buffer
(input [7:0] Pixel_in,
input  clk,
output [7:0] Median
);
    
    reg [7:0]  line_buff1 [COUNT-1:0];
    reg [7:0]  line_buff2 [COUNT-1:0];
    reg [7:0]  R1_Max,R1_Med,R1_Min,R2_Max,R2_Med,R2_Min,Buffer_reg;
    wire [7:0] Min,Max,Med,Last_Max,Last_Med,Last_Min;
    integer i;
        
// Buffer of 1 Pixel is made in order to recieve correct Pixel coulumn
    always @(posedge clk)begin
    Buffer_reg <= Pixel_in;
    end
    
// Line Buffers
    always @ (posedge clk)
    begin
    line_buff2[COUNT-1] <= Buffer_reg;
    line_buff1[COUNT-1] <= line_buff2[0];
    
    for ( i=0 ; i<COUNT-1; i=i+1 )
        line_buff2[i] <= line_buff2[i+1];

    for ( i=0 ; i<COUNT-1; i=i+1 )
         line_buff1[i] <= line_buff1[i+1];
    end 
      
    
// TDS stage 1
    TDS tds1_1(.P0(line_buff1[0]),.P1(line_buff2[0]),.P2(Buffer_reg),.Min(Min),.Max(Max),.Med(Med));
   
// Saving the value in set of registers
    always @(posedge clk) begin
    R1_Max <= Max;
    R1_Med <= Med;
    R1_Min <= Min;
    end
    
// Shifting the contents of registers to the next set of registers
    always @(posedge clk) begin
    R2_Max <= R1_Max;
    R2_Med <= R1_Med;
    R2_Min <= R1_Min;
    end
    
// TDS stage 2
    TDS tds2_1(.P0(Max),.P1(R1_Max),.P2(R2_Max),.Min(Last_Min),.Max(),.Med());
    TDS tds2_2(.P0(Med),.P1(R1_Med),.P2(R2_Med),.Min(),.Max(),.Med(Last_Med));
    TDS tds2_3(.P0(Min),.P1(R1_Min),.P2(R2_Min),.Min(),.Max(Last_Max),.Med());

// TDS final stage
    TDS tds_f(.P0(Last_Min),.P1(Last_Med),.P2(Last_Max),.Min(),.Max(),.Med(Median));
    
    endmodule
    