`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2020 10:35:36 AM
// Design Name: 
// Module Name: random_array_test
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

module random_array_test();
    reg [5:0] seed = 20;
    reg [6:0] i, j, k;
    reg [5:0] cards[0:51];
    reg [5:0] fcards[0:51];
    integer r;
    reg [5:0] playercards[0:10];
    reg [5:0] dealercards[0:10];
    reg [4:0]dealertotal = 0;
    reg [5:0]ccard;
    reg [4:0]playerinitial;
    reg[5:0]card1,card2,card3,card4,card5,card6,card7,card8;
    always @(*) begin 
        //generating the array of cards
        $display("i: ", i);
        for (i = 0; i < 52; i = i + 1) begin
            cards[i] = i;
        end
        $display("i: ", i);
        r = $random(seed)%52;
        while (i > 0) begin
            if (cards[r] != 52) begin
                fcards[i-1] = r+1;
                cards[r] = 52;
                i = i - 1;
            end
            r = $random(seed)%52;
        end
        j = 0;
        $display("i: ", i);
        $display("j: ", j);
        //assigning initial cards for player and dealer
        playercards[0] = (((fcards[j]%12)+1)>10)?10:((fcards[j]%12)+1);
        j = j + 1;
        playercards[1] = (((fcards[j]%12)+1)>10)?10:((fcards[j]%12)+1);
        j = j + 1;
        dealercards[0] = (((fcards[j]%12)+1)>10)?10:((fcards[j]%12)+1);
        j = j + 1;
        dealercards[1] = (((fcards[j]%12)+1)>10)?10:((fcards[j]%12)+1);
        j = j + 1;
        dealertotal = dealercards[0] + dealercards[1];
        while (dealertotal <= 15) begin
            ccard = (((fcards[j]%12)+1)>10)?10:((fcards[j]%12)+1);
            dealertotal = dealertotal + ccard;
            j = j + 1;
        end
        playerinitial = playercards[0] + playercards[1];
        $display("i: ", i);
        $display("j: ", j);
//        #1 card1 = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
//        #1 i = i + 1;
//        #1 card2 = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
//        #1 i = i + 1;
//        #1 card3 = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
//        #1 i = i + 1;
//        #1 card4 = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
//        #1 i = i + 1;
//        #1 card5 = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
//        #1 i = i + 1;
//        #1 card6 = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
//        #1 i = i + 1;
//        #1 card7 = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
//        #1 i = i + 1;
//        #1 card8 = (((fcards[i]%12)+1)>10)?10:((fcards[i]%12)+1);
//        #1 i = i + 1;
        k = j;
        j = 0;
        $display("i: ", i);
        $display("j: ", j);
        $display("k: ", k);
    end 
//    initial begin 
//        ten_second_counter <= 999999990; 
//        countdown <= 10; 
//        overall_counter <= playerinitial; 
//    end
endmodule
