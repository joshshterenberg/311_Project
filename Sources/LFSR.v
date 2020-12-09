`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2020 08:50:45 PM
// Design Name: 
// Module Name: LFSR
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


module LFSR(
    input clk,
    input reset,
    input [5:0] seed,
    input load,
    output wire q
    );
    
    wire[5:0] state_out;
    wire[5:0] state_in;
    wire next_bit;
    
    DFlipFlop F[5:0] (clk, reset, state_in, state_out);
    mux_2_x_1 M1[5:0] (state_in, load, seed, {state_out[4],state_out[3],state_out[2],
                                        state_out[1],
                                        state_out[0],
                                        next_bit});
     assign next_bit = state_out[4] ^ state_out[5];
     assign q = next_bit;
                                        
endmodule
