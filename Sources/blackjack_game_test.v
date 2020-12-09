`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 04:28:55 PM
// Design Name: 
// Module Name: blackjack_game_test
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


module blackjack_game_test(
    input clock_100Mhz, reset, staylever,
    output reg [7:0]Anode_Activate,
    output reg [6:0]LED_out
    );
    reg [4:0] LED_BCD;
    reg [19:0] refresh_counter;
    wire [2:0]LED_activating_counter;
    reg [4:0]out0, out1, out2, out3, out4, out5, out6, out7;
    
    integer seed = 1337;
    integer i;
    integer cards[0:51];
    integer fcards[0:51];
    reg [5:0]r;
    integer playercards[0:10];
    integer dealercards[0:10];
    initial begin
        //generating the array of cards
        for (i = 0; i < 52; i = i + 1) cards[i] = i;
        r = $random(seed)%52;
        while (i > 0) begin
            if (cards[r] != -1) begin
                fcards[i-1] = r+1;
                cards[r] = -1;
                i = i - 1;
            end
            r = $random(seed)%52;
        end
        //assigning initial cards for player and dealer
        playercards[0] = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
        i = i + 1;
        playercards[1] = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
        i = i + 1;
        dealercards[0] = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
        i = i + 1;
        dealercards[1] = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
        i = i + 1;
    end
    
    always @(posedge clock_100Mhz) begin
        if (!reset) begin
            if (staylever) begin
//                out0 = 20; //YAY
//                out1 = 20;
//                out2 = 20;
//                out3 = 20;
//                out4 = 20;
//                out5 = 14;
//                out6 = 12;
//                out7 = 14;
            end else begin
                out0 = 20; //READY?
                out1 = 20;
                out2 = 10;
                out3 = 11;
                out4 = 12;
                out5 = 13;
                out6 = 14;
                out7 = 21;
            end
        end
    end
    
    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset) refresh_counter <= 0;
        else refresh_counter <= refresh_counter + 1;
    end
    assign LED_activating_counter = refresh_counter[19:17];
    always @(*) begin
        case(LED_activating_counter)
        0: begin
            Anode_Activate = 8'b01111111;
            LED_BCD = out0;
        end
        1: begin
            Anode_Activate = 8'b10111111;
            LED_BCD = out1;
        end
        2: begin
            Anode_Activate = 8'b11011111;
            LED_BCD = out2;
        end
        3: begin
            Anode_Activate = 8'b11101111;
            LED_BCD = out3;
        end
        4: begin
            Anode_Activate = 8'b11110111;
            LED_BCD = out4;
        end
        5: begin
            Anode_Activate = 8'b11111011;
            LED_BCD = out5;
        end
        6: begin
            Anode_Activate = 8'b11111101;
            LED_BCD = out6;
        end
        7: begin
            Anode_Activate = 8'b11111110;
            LED_BCD = out7;
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
        default: LED_out = 7'b1111111;//blank
        endcase
    end
endmodule
