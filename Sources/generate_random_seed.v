`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2020 09:00:53 PM
// Design Name: 
// Module Name: generate_random_seed
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


module generate_random_seed #(parameter N = 6)(
    input clk,
    input stop,
    input reset,
    output reg [N -1 : 0] seed = 0
    );
    
    reg [N - 1:0] counter = 0;
    
    always @(posedge clk) begin
        if(reset == 1'b1) begin
            counter <= 0;
        end
        if(stop == 1'b0) begin
            counter <= counter + 1;
        end
    end
    
    always @(posedge clk) begin
        if(reset == 1'b1) begin
            seed <= 0;
        end else if(stop == 1'b1) begin
            seed <= counter;
        end
    end
    
endmodule
