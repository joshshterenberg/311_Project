`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 04:14:13 PM
// Design Name: 
// Module Name: vertical_counter
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


module vertical_counter(
    input CLK25MHZ,
    input  enable_V_counter,
    output reg[15:0] V_count_value = 0
    );
    
     always @(posedge CLK25MHZ) begin
         if(enable_V_counter == 1'b1) begin
            if (V_count_value < 524) begin
                V_count_value <= V_count_value + 1; // keep counting until 525
            end else begin
                V_count_value <= 0; // reset vertical  counter
            end
        end
    end
endmodule
