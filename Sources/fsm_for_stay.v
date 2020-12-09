`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2020 03:15:45 PM
// Design Name: 
// Module Name: fsm_for_stay
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


module fsm_for_stay(
    input clock_100Mhz, x, reset,
    output y
    );
    reg current = 0;
    reg next = 0;
    assign y = (~reset)?0:current;
    always @(posedge clock_100Mhz) current <= next;
    always @(*) begin
        if (~reset) next = 0;
        else begin
            case(current)
                1'b0: begin
                    if (x) next = 1;
                    else next = 0;
                end
                1'b1: next = 1;
            endcase
        end
    end
endmodule
