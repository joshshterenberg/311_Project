`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2020 05:33:34 PM
// Design Name: 
// Module Name: GuessingGame
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


module GuessingGame(
    input [3:0] Guess,
    input get_new_num,
    input reset,
    output wire led_red,
    output wire led_green,
    output wire led_blue
    );
    
    
    reg [3:0] seeds[0:3];
    reg load;
    // Setting the seeds and loading them into 4-bit LFSR
    initial begin
        load = 0;
        seeds[0] = 4'b0010;
        seeds[1] = 4'b0101;
        seeds[2] = 4'b1010;
        seeds[3] = 4'b1111;
        #10 load = 1;
    end
    
    // set load to zero after user pushes button for new number
    always @(posedge get_new_num)
        #5 load = 0;
        
    
 
    
    wire[3:0] secret_num;
    LFSR lfsr[3:0] (get_new_num, reset, {seeds[0],
                                         seeds[1],
                                         seeds[2],
                                         seeds[3]},      
                                                 
                                                   load, secret_num);
                                                   
    
    assign led_red = Guess > secret_num;
    assign led_blue = Guess < secret_num;
    assign led_green = Guess == secret_num;
    
endmodule
