`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2020 08:43:51 PM
// Design Name: 
// Module Name: mux_2_x_1
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


module mux_2_x_1(
    output reg q,
    input control,
    input a,
    input b
    );
    
    always @(control or a or b)
        q = (control & a) | ((~control) & b);
        
    
endmodule
