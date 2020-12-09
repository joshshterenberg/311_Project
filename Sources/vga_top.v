`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 04:18:56 PM
// Design Name: 
// Module Name: vga_top
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


module vga_top(
    input CLK100MHZ,
    input [4:0]threshold,
    output VGA_HS,
    output VGA_VS,
    output  [11:0] VGA
    );
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    wire enable_V_counter;
    wire clk_pix;
    wire [15:0] H_count_value, V_count_value;
    
    reg[2:0] counter = 3'd0;
    parameter DIVISOR = 4;
    always @(posedge CLK100MHZ) begin
        counter <= counter + 3'd1;
        if(counter >= (DIVISOR - 1))
            counter <= 3'd0;
    end 
    assign clk_pix = (counter < DIVISOR / 2) ? 1'b0 : 1'b1;
    
    horizantal_counter VGA_Horz(clk_pix, enable_V_counter, H_count_value);
    vertical_counter VGA_Vert(clk_pix, enable_V_counter, V_count_value);
    
    // outputs
    assign VGA_HS = (H_count_value < 96) ? 1'b1 : 1'b0;
    assign VGA_VS = (V_count_value < 2) ? 1'b1 : 1'b0;
    
    wire [299: 0] atPoint, atVal;
    reg [8:0] y;
    reg [3:0]vgar, vgag, vgab;
    
    
    wire [11:0]xaxis, yaxis, line21;
    assign xaxis = (161 < H_count_value && H_count_value < 165 && V_count_value>94 && V_count_value<488) ? 12'hfff : 0;
    assign yaxis = (94 < V_count_value && V_count_value < 98 && H_count_value>163 && H_count_value<763) ? 12'hfff : 0;
    assign line21 = (372 < V_count_value && V_count_value < 374 && H_count_value>163 && H_count_value<763 && H_count_value % 4 != 0) ? 12'h999 : 0;
    
    wire [11:0]zero, threehundred, thirty, runs, vals, val21;
    assign zero = ((153 < H_count_value && H_count_value < 163 && 61 < V_count_value && V_count_value < 63) ||
                  (153 < H_count_value && H_count_value < 163 && 81 < V_count_value && V_count_value < 83) ||
                  (151 < H_count_value && H_count_value < 153 && 61 < V_count_value && V_count_value < 81) ||
                  (161 < H_count_value && H_count_value < 163 && 61 < V_count_value && V_count_value < 81))?12'hFFF:0 ;
    assign thirty = ((149 < H_count_value && H_count_value < 159 && 461 < V_count_value && V_count_value < 463) ||
                    (149 < H_count_value && H_count_value < 159 && 481 < V_count_value && V_count_value < 483) ||
                    (147 < H_count_value && H_count_value < 149 && 461 < V_count_value && V_count_value < 481) ||
                    (157 < H_count_value && H_count_value < 159 && 461 < V_count_value && V_count_value < 481) ||
                    
                    (143 < H_count_value && H_count_value < 145 && 461 < V_count_value && V_count_value < 481) ||
                    (135 < H_count_value && H_count_value < 145 && 479 < V_count_value && V_count_value < 481) ||
                    (135 < H_count_value && H_count_value < 145 && 468 < V_count_value && V_count_value < 470) ||
                    (135 < H_count_value && H_count_value < 145 && 461 < V_count_value && V_count_value < 463))?12'hFFF:0 ;
    assign val21 = ((157 < H_count_value && H_count_value < 159 && 361 < V_count_value && V_count_value < 381) ||
                    
                    (143 < H_count_value && H_count_value < 145 && 361 < V_count_value && V_count_value < 370) ||
                    (135 < H_count_value && H_count_value < 137 && 370 < V_count_value && V_count_value < 381) ||
                    (135 < H_count_value && H_count_value < 145 && 379 < V_count_value && V_count_value < 381) ||
                    (135 < H_count_value && H_count_value < 145 && 368 < V_count_value && V_count_value < 370) ||
                    (135 < H_count_value && H_count_value < 145 && 361 < V_count_value && V_count_value < 363))?12'h999:0 ;
    assign threehundred = ((753 < H_count_value && H_count_value < 763 && 61 < V_count_value && V_count_value < 63) ||
                          (753 < H_count_value && H_count_value < 763 && 81 < V_count_value && V_count_value < 83) ||
                          (751 < H_count_value && H_count_value < 753 && 61 < V_count_value && V_count_value < 81) ||
                          (761 < H_count_value && H_count_value < 763 && 61 < V_count_value && V_count_value < 81) || 
                          
                          (739 < H_count_value && H_count_value < 749 && 61 < V_count_value && V_count_value < 63) ||
                          (739 < H_count_value && H_count_value < 749 && 81 < V_count_value && V_count_value < 83) ||
                          (737 < H_count_value && H_count_value < 739 && 61 < V_count_value && V_count_value < 81) ||
                          (747 < H_count_value && H_count_value < 749 && 61 < V_count_value && V_count_value < 81) ||
                          
                          (734 < H_count_value && H_count_value < 736 && 61 < V_count_value && V_count_value < 81) ||
                          (724 < H_count_value && H_count_value < 734 && 79 < V_count_value && V_count_value < 81) ||
                          (724 < H_count_value && H_count_value < 734 && 68 < V_count_value && V_count_value < 70) ||
                          (724 < H_count_value && H_count_value < 734 && 61 < V_count_value && V_count_value < 63))?12'hFFF:0 ;
    assign runs = ((353 < H_count_value && H_count_value < 363 && 68 < V_count_value && V_count_value < 70) ||
                   (351 < H_count_value && H_count_value < 353 && 70 < V_count_value && V_count_value < 81) ||
                   (361 < H_count_value && H_count_value < 363 && 70 < V_count_value && V_count_value < 81) || 
                                                           
                   (339 < H_count_value && H_count_value < 349 && 81 < V_count_value && V_count_value < 83) ||
                   (337 < H_count_value && H_count_value < 339 && 70 < V_count_value && V_count_value < 81) ||
                   (347 < H_count_value && H_count_value < 349 && 70 < V_count_value && V_count_value < 81) ||
                    
                   (324 < H_count_value && H_count_value < 326 && 70 < V_count_value && V_count_value < 81) ||
                   (324 < H_count_value && H_count_value < 334 && 68 < V_count_value && V_count_value < 70))?12'hFFF:0 ;
    assign vals = ((149 < H_count_value && H_count_value < 159 && 219 < V_count_value && V_count_value < 221) ||
                   (147 < H_count_value && H_count_value < 149 && 201 < V_count_value && V_count_value < 221) ||
                   (157 < H_count_value && H_count_value < 159 && 201 < V_count_value && V_count_value < 221) ||
                   
                   (149 < H_count_value && H_count_value < 159 && 231 < V_count_value && V_count_value < 233) ||
                   (149 < H_count_value && H_count_value < 159 && 241 < V_count_value && V_count_value < 243) ||
                   (147 < H_count_value && H_count_value < 149 && 231 < V_count_value && V_count_value < 251) ||
                   (157 < H_count_value && H_count_value < 159 && 231 < V_count_value && V_count_value < 251) ||
                   
                   (149 < H_count_value && H_count_value < 159 && 281 < V_count_value && V_count_value < 283) ||
                   (147 < H_count_value && H_count_value < 149 && 261 < V_count_value && V_count_value < 281))?12'hFFF:0 ;
                  
    wire [3:0] alltotals[0:299];
    wire [11:0]points[0:299];
    wire [4:0]total;
    reg start = 0;
    always @(posedge CLK100MHZ) start = 1;
    fibonacci_lfsr F1(CLK100MHZ, start, total);
    genvar t;
    generate
        for (t = 0; t < 300; t = t + 1) begin
            assign alltotals[t] = ((total+(t%7))%10);
        end
    endgenerate
    generate
        for (t = 0; t < 300; t = t + 1) begin
            assign points[t] = (98+((threshold+alltotals[t])*13) < V_count_value && V_count_value < 100+((threshold+alltotals[t])*13) && 
                                2*t+165 < H_count_value && H_count_value < 2*t+167) ? 
                                ((V_count_value <= 373)?12'h0F0:12'h00F) : 0;
        end
    endgenerate

    assign VGA = (xaxis | yaxis | zero | line21 | thirty | threehundred | runs | vals | val21 |
        points[0] | points[1] | points[2] | points[3] | points[4] | points[5] | points[6] | points[7] | points[8] | points[9] | 
        points[10] | points[11] | points[12] | points[13] | points[14] | points[15] | points[16] | points[17] | points[18] | points[19] | 
        points[20] | points[21] | points[22] | points[23] | points[24] | points[25] | points[26] | points[27] | points[28] | points[29] | 
        points[30] | points[31] | points[32] | points[33] | points[34] | points[35] | points[36] | points[37] | points[38] | points[39] | 
        points[40] | points[41] | points[42] | points[43] | points[44] | points[45] | points[46] | points[47] | points[48] | points[49] | 
        points[50] | points[51] | points[52] | points[53] | points[54] | points[55] | points[56] | points[57] | points[58] | points[59] | 
        points[60] | points[61] | points[62] | points[63] | points[64] | points[65] | points[66] | points[67] | points[68] | points[69] | 
        points[70] | points[71] | points[72] | points[73] | points[74] | points[75] | points[76] | points[77] | points[78] | points[79] | 
        points[80] | points[81] | points[82] | points[83] | points[84] | points[85] | points[86] | points[87] | points[88] | points[89] | 
        points[90] | points[91] | points[92] | points[93] | points[94] | points[95] | points[96] | points[97] | points[98] | points[99] | 
        
        points[100] | points[101] | points[102] | points[103] | points[104] | points[105] | points[106] | points[107] | points[108] | points[109] | 
        points[110] | points[111] | points[112] | points[113] | points[114] | points[115] | points[116] | points[117] | points[118] | points[119] | 
        points[120] | points[121] | points[122] | points[123] | points[124] | points[125] | points[126] | points[127] | points[128] | points[129] | 
        points[130] | points[131] | points[132] | points[133] | points[134] | points[135] | points[136] | points[137] | points[138] | points[139] | 
        points[140] | points[141] | points[142] | points[143] | points[144] | points[145] | points[146] | points[147] | points[148] | points[149] | 
        points[150] | points[151] | points[152] | points[153] | points[154] | points[155] | points[156] | points[157] | points[158] | points[159] | 
        points[160] | points[161] | points[162] | points[163] | points[164] | points[165] | points[166] | points[167] | points[168] | points[169] | 
        points[170] | points[171] | points[172] | points[173] | points[174] | points[175] | points[176] | points[177] | points[178] | points[179] | 
        points[180] | points[181] | points[182] | points[183] | points[184] | points[185] | points[186] | points[187] | points[188] | points[189] | 
        points[190] | points[191] | points[192] | points[193] | points[194] | points[195] | points[196] | points[197] | points[198] | points[199] | 
        
        points[200] | points[201] | points[202] | points[203] | points[204] | points[205] | points[206] | points[207] | points[208] | points[209] | 
        points[210] | points[211] | points[212] | points[213] | points[214] | points[215] | points[216] | points[217] | points[218] | points[219] | 
        points[220] | points[221] | points[222] | points[223] | points[224] | points[225] | points[226] | points[227] | points[228] | points[229] | 
        points[230] | points[231] | points[232] | points[233] | points[234] | points[235] | points[236] | points[237] | points[238] | points[239] | 
        points[240] | points[241] | points[242] | points[243] | points[244] | points[245] | points[246] | points[247] | points[248] | points[249] | 
        points[250] | points[251] | points[252] | points[253] | points[254] | points[255] | points[256] | points[257] | points[258] | points[259] | 
        points[260] | points[261] | points[262] | points[263] | points[264] | points[265] | points[266] | points[267] | points[268] | points[269] | 
        points[270] | points[271] | points[272] | points[273] | points[274] | points[275] | points[276] | points[277] | points[278] | points[279] | 
        points[280] | points[281] | points[282] | points[283] | points[284] | points[285] | points[286] | points[287] | points[288] | points[289] | 
        points[290] | points[291] | points[292] | points[293] | points[294] | points[295] | points[296] | points[297] | points[298] | points[299] );
    
endmodule

module fibonacci_lfsr(
      input  clk,
      input  rst_n,
      output [4:0] data
    );
    wire feedback = data[4] ^ data[1] ;
    reg [4:0] out1, out2;
    always @(posedge clk)
      if (~rst_n) 
        out1 <= 4'hf;
      else
        out1 <= {out1[3:0], feedback} ;
    always @(negedge clk)
      if (~rst_n) 
        out2 <= 4'hf;
      else
        out2 <= {out2[3:0], feedback} ;
    assign data = out1;
endmodule
