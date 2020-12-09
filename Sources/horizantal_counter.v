`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 04:09:47 PM
// Design Name: 
// Module Name: horizantal_counter
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


module horizantal_counter(
    input CLK25MHZ,
    output reg enable_V_counter = 0,
    output reg[15:0] H_count_value = 0
    );
    
    
    always @(posedge CLK25MHZ) begin
        if (H_count_value < 799) begin
            H_count_value <= H_count_value + 1;
            enable_V_counter <= 0;
        end else begin
            H_count_value <= 0; // reset Horizantal counter
            enable_V_counter <= 1; // trigger V counter
        end
    end
    
endmodule
