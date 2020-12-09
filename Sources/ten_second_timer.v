`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2020 01:20:18 PM
// Design Name: 
// Module Name: ten_second_timer
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


module ten_second_timer(
    input clock_100Mhz,
    input staylever, reset,
    input [5:0]seed,
    //output reg [7:0]Anode_Activate,
    //output reg [6:0]LED_out
    output [5:0]out0, out1, out2, out3, out4, out5, out6, out7
    );
    //time variables
    reg [3:0]countdown;
    integer overall_counter;
    reg [30:0] ten_second_counter;
    wire ten_second_enable;
    
    //card generation//////////////////////////////////////////////////////////////////////////////////////////////
    reg [6:0] i, j, k;
    reg [5:0] cards[0:51];
    integer b, g;
    reg [5:0] playercards[0:10];
    reg [5:0] dealercards[0:10];
    reg [4:0]dealertotal = 0;
    reg [5:0]ccard;
    reg [4:0]playerinitial;
    reg[5:0]card1,card2,card3,card4,card5,card6,card7,card8;
    reg [5:0]temp;
    reg [1:0] counter = 0;
    
    //builds the stay lever
    wire amIstaying;
    fsm_for_stay F1(clock_100Mhz, staylever, reset, amIstaying);
    
    //random stuff
    wire [5:0]randyboy, randygirl;
    reg [5:0] seeds[0:5];
    reg load;
    reg get_new_num;
    initial begin 
        load = 0; 
        seeds[0] = seed%2; seeds[1] = seed/4; seeds[2] = seed%5; seeds[3] = (seed%12)-1; seeds[4] = seed/3; seeds[5] = seed%19;
        load = 1;
    end 
    always @(posedge get_new_num) load = 0;
    //LFSR lfsr[5:0] (get_new_num, reset, {seed[0], seed[1], seed[2], seed[3], seed[4], seed[5]}, load, randyboy);
    //LFSR lfsr2[5:0] (get_new_num, reset, {seed[0], seed[1], seed[2], seed[3], seed[4], seed[5]}, load, randygirl);
    
    wire [3:0] alltotals[0:19];
    wire [3:0]total;
    genvar t;
    reg start = 0;
    reg stop = 0;//(t<20)?0:1;
    always @(posedge clock_100Mhz) start = 1;
    fibonacci_lfsr2 L1(clock_100Mhz, seed, start, total);
    generate
        for (t = 0; t < 20; t = t + 1) begin
            assign alltotals[t] = ((total%10)+1);
        end
    endgenerate
    //logic for 10 second countdown and for the running sum of player cards
    always @(posedge clock_100Mhz) begin
        if (~reset) begin
            counter = counter + 1;
            //generating the array of cards
            for (i = 0; i < 52; i = i + 1) begin
                cards[i] = i;
            end            
//            for (i = 0; i < 300; i = i + 1) begin
//                get_new_num = 1;
//                get_new_num = 0;
//                b = (randyboy>51)?51:(randyboy);
//                g = (randygirl>51)?51:randygirl;
//                temp = cards[b];
//                cards[b] = cards[g];
//                cards[g] = temp;
//            end
            j = 0;
            //assigning initial cards for player and dealer
            playercards[0] = alltotals[j];
            j = j + 1;
            playercards[1] = alltotals[j];
            j = j + 1;
            dealercards[0] = alltotals[j];
            j = j + 1;
            dealercards[1] = alltotals[j];
            j = j + 1;
            dealertotal = dealercards[0] + dealercards[1];
            for (i = 0; i < 50; i = i + 1) begin
                if (dealertotal <= 15) begin
                    ccard = alltotals[j];
                    dealertotal = dealertotal + ccard;
                    j = j + 1;
                end
            end
            playerinitial = playercards[0] + playercards[1];
            ten_second_counter <= 999999990; 
            countdown <= 10; 
            overall_counter <= playerinitial; 
        end else begin
            if( ten_second_counter<=0) begin
                ten_second_counter <= 999999990;
                if (amIstaying || overall_counter>=21) overall_counter <= overall_counter;
                else begin
                    //overall_counter = overall_counter + 2;
                    ccard = alltotals[j];
                    overall_counter = overall_counter + ((total%10)+1);
                    j = j + 1;
                end
            end else begin
                countdown <= (ten_second_counter / 99999999) + 1;
                ten_second_counter <= ten_second_counter - 1;
            end
        end
    end 
    
    //logic for generating output on 7-seg
    reg [5:0]out[0:7];
    reg [30:0] alt_ten = 999999990;
    always @(posedge clock_100Mhz) begin
    if (counter > 0) begin
        if (amIstaying) begin
            //STAY, wait 3, C: number, wait 3, WIN/LOSE/TIE, wait 3
            if (alt_ten >= 699999993) begin
                out[0] = 14;//STAY 
                out[1] = 12; 
                out[2] = 19; 
                out[3] = 5; 
            end else if (alt_ten >= 399999996) begin
                out[0] = dealertotal % 10;//C 19 
                out[1] = dealertotal / 10; 
                out[2] = 20; 
                out[3] = 22; 
            end else begin
                if (dealertotal > overall_counter && dealertotal < 22) begin
                    out[0] = 11;//LOSE 
                    out[1] = 5; 
                    out[2] = 0; 
                    out[3] = 16; 
                end else if (dealertotal < overall_counter || dealertotal > 21) begin
                    out[0] = 18;// WIN
                    out[1] = 1; 
                    out[2] = 17; 
                    out[3] = 20; 
                end else begin
                    out[0] = 11;// TIE 
                    out[1] = 1; 
                    out[2] = 19; 
                    out[3] = 20; 
                end
            end
            if (alt_ten <= 0) alt_ten <= 999999990;
            else alt_ten = alt_ten - 1;
        end else if (overall_counter >= 21) begin 
            //DONE, wait 3, C: number, wait 3, WIN/LOSE/TIE, wait 3
            if (alt_ten >= 699999993) begin
                out[0] = 11;//DONE 
                out[1] = 18; 
                out[2] = 0; 
                out[3] = 13; 
            end else if (alt_ten >= 399999996) begin
                out[0] = dealertotal % 10;//C 19 
                out[1] = dealertotal / 10; 
                out[2] = 20; 
                out[3] = 22; 
            end else begin
                if (overall_counter == 21) begin
                    if (dealertotal < overall_counter || dealertotal > 21) begin
                        out[0] = 18;// WIN
                        out[1] = 1; 
                        out[2] = 17; 
                        out[3] = 20; 
                    end else begin
                        out[0] = 11;// TIE 
                        out[1] = 1; 
                        out[2] = 19; 
                        out[3] = 20; 
                    end
                end else begin
                    out[0] = 11;//LOSE 
                    out[1] = 5; 
                    out[2] = 0; 
                    out[3] = 16; 
                end
            end
            if (alt_ten <= 0) alt_ten <= 999999990;
            else alt_ten = alt_ten - 1;
        end else begin
            out[0] = countdown % 10; //timer 1
            out[1] = countdown / 10; //timer 2
            out[2] = 20; //blank
            out[3] = 20; //blank
        end
        out[4] <= 20; //blank
        out[5] <= 20; //blank
        out[6] <= overall_counter % 10; //overall_counter 1
        out[7] <= overall_counter / 10; //overall_counter 2
    end else begin
        out[0] = 21;
        out[1] = 14;
        out[2] = 13;
        out[3] = 12;
        out[4] = 11;
        out[5] = 10;
        out[6] = 20;
        out[7] = 20;
    end
    end
    
    //7-seg output logic
    assign out0 = out[0];
    assign out1 = out[1];
    assign out2 = out[2];
    assign out3 = out[3];
    assign out4 = out[4];
    assign out5 = out[5];
    assign out6 = out[6];
    assign out7 = out[7];
endmodule

module fibonacci_lfsr2(
      input  clk, [5:0]seedz,
      input  rst_n,
      output [3:0] data
    );
    wire feedback = data[3] ^ data[1] ;
    reg [3:0] out1 = 0 , out2 = 0;
    always @(posedge clk)
      if (~rst_n) 
        out1 <= 3'hf;
      else
        out1 <= {out1[2:0], feedback} ;
    always @(negedge clk)
      if (~rst_n) 
        out2 <= 3'hf;
      else
        out2 <= {out2[2:0], feedback} ;
    assign data = (out1 | out2 != 0)?(out1 | out2):seedz[5:2];
endmodule