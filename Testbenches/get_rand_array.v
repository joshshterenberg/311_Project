`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2020 05:47:42 PM
// Design Name: 
// Module Name: get_rand_array
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


module get_rand_array();
    reg [5:0] seed = 20;
    reg [8:0] i, j, k;
    reg [5:0] cards[0:51];
    integer b, g;
    reg [5:0] dealercards[0:10];
    reg [4:0]dealertotal = 0;
    reg [5:0]ccard;
    reg [5:0]temp;
    reg [8:0] count;
    reg [4:0]alltotals[0:299];
    
    wire [5:0]randyboy, randygirl;
    reg [5:0] seeds[0:5];
    reg load;
    reg get_new_num;
    initial begin 
        load = 0; 
        seeds[0] = 1; seeds[1] = 3; seeds[2] = 5; seeds[3] = 11; seeds[4] = 28; seeds[5] = 52;
        load = 1;
    end 
    always @(posedge get_new_num) load = 0;
    LFSR lfsr[5:0] (get_new_num, 1'b0, {seeds[0], seeds[1], seeds[2], seeds[3], seeds[4], seeds[5]}, load, randyboy);
    LFSR lfsr2[5:0] (get_new_num, 1'b0, {seeds[0], seeds[1], seeds[2], seeds[3], seeds[4], seeds[5]}, load, randygirl);
    
    always @(*) begin
        for (count = 0; count < 300; count = count + 1) begin
            //generating the array of cards
            for (i = 0; i < 52; i = i + 1) begin
                cards[i] = i;
            end            
            for (i = 0; i < 52; i = i + 1) begin
                get_new_num = 1;
                get_new_num = 0;
                b = (randyboy>51)?51:randyboy;
                g = (randygirl>51)?51:randygirl;
                temp = cards[b];
                cards[b] = cards[g];
                cards[g] = temp;
            end
            j = 0;
            //assigning initial cards for player and dealer
            dealercards[0] = (((cards[j]%12)+1)>10)?10:((cards[j]%12)+1);
            j = j + 1;
            dealercards[1] = (((cards[j]%12)+1)>10)?10:((cards[j]%12)+1);
            j = j + 1;
            dealertotal = dealercards[0] + dealercards[1];
            for (i = 0; i < 50; i = i + 1) begin
                if (dealertotal <= 45) begin
                    ccard = (((cards[j]%12)+1)>10)?10:((cards[j]%12)+1);
                    dealertotal = dealertotal + ccard;
                    j = j + 1;
                end
            end
            alltotals[count] = dealertotal;
        end
    end
endmodule
