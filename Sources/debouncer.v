`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2020 01:32:05 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input PB,
    output reg PB_state
    );
    reg PB_sync_0;  always @(posedge clk) PB_sync_0 <= ~PB; 
    reg PB_sync_1;  always @(posedge clk) PB_sync_1 <= PB_sync_0;
    reg [15:0] PB_cnt;
    wire PB_idle = (PB_state==PB_sync_1);
    wire PB_cnt_max = &PB_cnt;
    
    always @(posedge clk)
        if(PB_idle)
            PB_cnt <= 0;  // nothings going on
        else begin
            PB_cnt <= PB_cnt + 16'd1;  // somethings going on, increment
            if(PB_cnt_max) PB_state <= ~PB_state;
        end
endmodule
