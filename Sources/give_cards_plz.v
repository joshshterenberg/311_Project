`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 04:01:07 PM
// Design Name: 
// Module Name: give_cards_plz
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


module give_cards_plz(
    input CLK100MHZ, [5:0]seed, [4:0]threshold,
    output reg [4:0] finalnums
    );
    reg [8:0] i, j, k;
    reg [5:0] cards[0:51];
    integer b, g;
    reg [5:0] dealercards[0:10];
    reg [4:0]dealertotal = 0;
    reg [5:0]ccard;
    reg [5:0]temp;
    reg [8:0] count;
    reg [4:0]alltotals[0:299];
    
    wire [4:0]randyboy;
    reg [5:0] seeds[0:5];
    reg load;
    reg get_new_num = 0;
//    initial begin 
//        load = 0;
//        seeds[0] = seed[0]*10; 
//        seeds[1] = seed[1]+13; 
//        seeds[2] = seed[2]+12; 
//        seeds[3] = seed[3]*2; 
//        seeds[4] = seed[4]+4;  
//        load = 1;
//    end 
//    always @(posedge get_new_num) load = 0;
//    LFSR lfsr[4:0] (get_new_num, 1'b0, {seeds[0], seeds[1], seeds[2], seeds[3], seeds[4]}, load, randyboy);
//    always @(posedge CLK100MHZ) begin
//        get_new_num = ~get_new_num;
//        if (randyboy < threshold) finalnums <= threshold; 
//        else if (randyboy > threshold+9) finalnums <= threshold+9;
//        else finalnums <= randyboy;
//    end
    //LFSR lfsr2[5:0] (get_new_num, 1'b0, {seeds[0], seeds[1], seeds[2], seeds[3], seeds[4], seeds[5]}, load, randygirl);
    
//    always @(*) begin
//        //for (count = 0; count < 300; count = count + 1) begin
//            //generating the array of cards
//            for (i = 0; i < 52; i = i + 1) begin
//                cards[i] = i;
//            end            
//            for (i = 0; i < 52; i = i + 1) begin
//                get_new_num = 1;
//                get_new_num = 0;
//                b = (randyboy>51)?51:randyboy;
//                g = (randygirl>51)?51:randygirl;
//                temp = cards[b];
//                cards[b] = cards[g];
//                cards[g] = temp;
//            end
//            j = 0;
//            //assigning initial cards for player and dealer
//            dealercards[0] = (((cards[j]%12)+1)>10)?10:((cards[j]%12)+1);
//            j = j + 1;
//            dealercards[1] = (((cards[j]%12)+1)>10)?10:((cards[j]%12)+1);
//            j = j + 1;
//            dealertotal = dealercards[0] + dealercards[1];
//            for (i = 0; i < 50; i = i + 1) begin
//                if (dealertotal <= 15) begin
//                    ccard = (((cards[j]%12)+1)>10)?10:((cards[j]%12)+1);
//                    dealertotal = dealertotal + ccard;
//                    j = j + 1;
//                end
//            end
//            //alltotals[count] = dealertotal;
//            finalnums = dealertotal;
//        //end
//    end
    reg [4:0] numsnext = 4;
    always @* begin
      numsnext[4] = finalnums[4]^finalnums[1];
      numsnext[3] = finalnums[3]^finalnums[0];
      numsnext[2] = finalnums[2]^numsnext[4];
      numsnext[1] = finalnums[1]^numsnext[3];
      numsnext[0] = finalnums[0]^numsnext[2];
    end
    
    always @(posedge CLK100MHZ)
      finalnums <= numsnext;
endmodule
