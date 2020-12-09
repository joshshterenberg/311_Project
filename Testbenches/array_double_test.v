`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 03:46:17 PM
// Design Name: 
// Module Name: array_double_test
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


module array_double_test;
    wire [4:0]dealertotal, playerinitial;
    wire [5:0]card1,card2,card3,card4,card5,card6,card7,card8;
    give_cards_plz R1(dealertotal,playerinitial,card1,card2,card3,card4,card5,card6,card7,card8);
    
    reg [7:0]overall_counter;
    initial begin
        #5 overall_counter <= playerinitial;
    end
endmodule
