`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2020 10:11:17 AM
// Design Name: 
// Module Name: master
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


module master(
    input clock_100Mhz, staylever, reset,
    input [4:0]threshold, [5:0]seed,
    output VGA_HS,
    output VGA_VS,
    output [11:0] VGA,
    output reg[7:0]Anode_Activate,
    output reg[6:0]LED_out
    );
    
    vga_top V1(clock_100Mhz, threshold, VGA_HS, VGA_VS, VGA);
    
    wire [5:0]out[0:7];
    ten_second_timer T1(clock_100Mhz, staylever, reset, seed, out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7]);
    
    reg [4:0] LED_BCD;
    reg [19:0] refresh_counter;
    wire [2:0]LED_activating_counter;
    always @(posedge clock_100Mhz) begin
        refresh_counter <= refresh_counter + 1;
    end
    assign LED_activating_counter = refresh_counter[19:17];
    always @(*) begin
        case(LED_activating_counter)
        0: begin
            Anode_Activate = 8'b01111111;
            LED_BCD = out[7];
        end
        1: begin
            Anode_Activate = 8'b10111111;
            LED_BCD = out[6];
        end
        2: begin
            Anode_Activate = 8'b11011111;
            LED_BCD = out[5];
        end
        3: begin
            Anode_Activate = 8'b11101111;
            LED_BCD = out[4];
        end
        4: begin
            Anode_Activate = 8'b11110111;
            LED_BCD = out[3];
        end
        5: begin
            Anode_Activate = 8'b11111011;
            LED_BCD = out[2];
        end
        6: begin
            Anode_Activate = 8'b11111101;
            LED_BCD = out[1];
        end
        7: begin
            Anode_Activate = 8'b11111110;
            LED_BCD = out[0];
        end
        endcase
    end
    always @(*) begin
        case(LED_BCD)
        0: LED_out = 7'b0000001;//0 or O
        1: LED_out = 7'b1001111;//1 or I
        2: LED_out = 7'b0010010;//2
        3: LED_out = 7'b0000110;//3
        4: LED_out = 7'b1001100;//4
        5: LED_out = 7'b0100100;//5 or S
        6: LED_out = 7'b0100000;//6
        7: LED_out = 7'b0001111;//7
        8: LED_out = 7'b0000000;//8
        9: LED_out = 7'b0000100;//9
        10: LED_out = 7'b0011001;//R
        11: LED_out = 7'b0110000;//E
        12: LED_out = 7'b0001000;//A
        13: LED_out = 7'b1000010;//D
        14: LED_out = 7'b1000100;//Y
        15: LED_out = 7'b1000001;//U
        16: LED_out = 7'b1110001;//L
        17: LED_out = 7'b1010101;//W
        18: LED_out = 7'b0001001;//N
        19: LED_out = 7'b1110000;//T
        20: LED_out = 7'b1111111;//blank
        21: LED_out = 7'b0011010;//?
        22: LED_out = 7'b0110001;//C
        default: LED_out = 7'b1111111;//blank
        endcase
    end
endmodule
