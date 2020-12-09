`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2020 08:37:17 PM
// Design Name: 
// Module Name: DFlipFlop
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


module DFlipFlop(
    input clk,
    input reset,
    input d,
    output wire q
    );
    reg q_reg;
    always @(posedge clk or posedge reset) begin
        if(reset)
            q_reg = 0;
        else
            q_reg = d;
    end
    assign q = q_reg;
    
    specify
        $setup(d, clk, 2);
        $hold(clk, d, 0);
    endspecify
endmodule
