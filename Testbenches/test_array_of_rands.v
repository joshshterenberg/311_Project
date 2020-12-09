`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2020 08:52:33 PM
// Design Name: 
// Module Name: test_array_of_rands
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


module test_array_of_rands();
    reg clk, rst_n=0;
    wire [4:0]data;
    reg [3:0] totaldata[0:299];
    reg [8:0] i = 0;
    fibonacci_lfsr F1(clk, rst_n, data);
    always @(*) begin 
        while (1) begin 
            #1 clk = ~clk;  
            #0 i = i + 1; totaldata[i] = (data%10);
        end 
    end
    initial begin
        #1 clk = 0; #1rst_n = 1;
    end
endmodule



//module mode2(
//    input clk,
//    input reset,
//    input [4:0] threshold,
//    input stopcounter,
//    output [3:0] VGA_R,
//    output [3:0] VGA_B,
//    output [3:0] VGA_G
//    );
//    wire [5:0] seeds[0:3];
//    reg load = 1; // load the LFSRs 
//    wire [3:0]randyboy;
//    reg [12:0] total = 0;
//    reg [8:0] counter = 0;
//    wire [12:0] next_total; 
//    wire cout1, cout2;
//    wire [12:0] score;
    
//    reg [1199:0] points; // 300 4-bit numbers
    
//    reg start = 0; 
//    always @(stopcounter or reset) begin
       
//        if(reset) begin
//            start = 1'b0; // stop calculations
//            load = 1'b1; // stop loading the LFSRs
//        end else if(stopcounter) begin
//            start = 1'b1; // start calculations
//            #10  load = 1'b0; // stop loading the LFSRs
//         end
         
//    end
//    generate_random_seed #(.N(6), .start(0)) grd0(clk,stopcounter,reset,seeds[0]);
//    generate_random_seed #(.N(6), .start(20)) grd1(clk,stopcounter,reset,seeds[1]);
//    generate_random_seed #(.N(6), .start(17)) grd2(clk,stopcounter,reset,seeds[2]);
//    generate_random_seed #(.N(6), .start(33)) grd3(clk,stopcounter,reset,seeds[3]);
//    LFSR lfsr[3:0] (clk, reset, {seeds[0], seeds[1], seeds[2], seeds[3]}, load, randyboy);
//    adder add_to_score({9'b0, randyboy % 10}, {8'b0, threshold}, score, cout1);
//    adder add_to_total(total, score, next_total, cout2);
    
//    wire [3:0] point1, p2; 
//    assign point1 = points[3:0];
//    assign p2 = points[7:4];
//    wire [7:0] count;
//    assign count = counter & start;
//    always @(posedge clk) begin
//        if(start) begin
//            if(counter < 300) begin
//                total <= next_total;
//                counter <= counter + 1;
//            end 
//            case(counter && start) 
//                0: points[3:0] <= randyboy;
//                1: points[7:4] <= randyboy;
//                2: points[11:8] <= randyboy;
//                3: points[15:12] <= randyboy;
//                4: points[19:16] <= randyboy;
//                5: points[23:20] <= randyboy;
//                6: points[27:24] <= randyboy;
//                7: points[31:28] <= randyboy;
//                8: points[35:32] <= randyboy;
//                9: points[39:36] <= randyboy;
//                10: points[43:40] <= randyboy;
//                11: points[47:44] <= randyboy;
//                12: points[51:48] <= randyboy;
//                13: points[55:52] <= randyboy;
//                14: points[59:56] <= randyboy;
//                15: points[63:60] <= randyboy;
//                16: points[67:64] <= randyboy;
//                17: points[71:68] <= randyboy;
//                18: points[75:72] <= randyboy;
//                19: points[79:76] <= randyboy;
//                20: points[83:80] <= randyboy;
//                21: points[87:84] <= randyboy;
//                22: points[91:88] <= randyboy;
//                23: points[95:92] <= randyboy;
//                24: points[99:96] <= randyboy;
//                25: points[103:100] <= randyboy;
//                26: points[107:104] <= randyboy;
//                27: points[111:108] <= randyboy;
//                28: points[115:112] <= randyboy;
//                29: points[119:116] <= randyboy;
//                30: points[123:120] <= randyboy;
//                31: points[127:124] <= randyboy;
//                32: points[131:128] <= randyboy;
//                33: points[135:132] <= randyboy;
//                34: points[139:136] <= randyboy;
//                35: points[143:140] <= randyboy;
//                36: points[147:144] <= randyboy;
//                37: points[151:148] <= randyboy;
//                38: points[155:152] <= randyboy;
//                39: points[159:156] <= randyboy;
//                40: points[163:160] <= randyboy;
//                41: points[167:164] <= randyboy;
//                42: points[171:168] <= randyboy;
//                43: points[175:172] <= randyboy;
//                44: points[179:176] <= randyboy;
//                45: points[183:180] <= randyboy;
//                46: points[187:184] <= randyboy;
//                47: points[191:188] <= randyboy;
//                48: points[195:192] <= randyboy;
//                49: points[199:196] <= randyboy;
//                50: points[203:200] <= randyboy;
//                51: points[207:204] <= randyboy;
//                52: points[211:208] <= randyboy;
//                53: points[215:212] <= randyboy;
//                54: points[219:216] <= randyboy;
//                55: points[223:220] <= randyboy;
//                56: points[227:224] <= randyboy;
//                57: points[231:228] <= randyboy;
//                58: points[235:232] <= randyboy;
//                59: points[239:236] <= randyboy;
//                60: points[243:240] <= randyboy;
//                61: points[247:244] <= randyboy;
//                62: points[251:248] <= randyboy;
//                63: points[255:252] <= randyboy;
//                64: points[259:256] <= randyboy;
//                65: points[263:260] <= randyboy;
//                66: points[267:264] <= randyboy;
//                67: points[271:268] <= randyboy;
//                68: points[275:272] <= randyboy;
//                69: points[279:276] <= randyboy;
//                70: points[283:280] <= randyboy;
//                71: points[287:284] <= randyboy;
//                72: points[291:288] <= randyboy;
//                73: points[295:292] <= randyboy;
//                74: points[299:296] <= randyboy;
//                75: points[303:300] <= randyboy;
//                76: points[307:304] <= randyboy;
//                77: points[311:308] <= randyboy;
//                78: points[315:312] <= randyboy;
//                79: points[319:316] <= randyboy;
//                80: points[323:320] <= randyboy;
//                81: points[327:324] <= randyboy;
//                82: points[331:328] <= randyboy;
//                83: points[335:332] <= randyboy;
//                84: points[339:336] <= randyboy;
//                85: points[343:340] <= randyboy;
//                86: points[347:344] <= randyboy;
//                87: points[351:348] <= randyboy;
//                88: points[355:352] <= randyboy;
//                89: points[359:356] <= randyboy;
//                90: points[363:360] <= randyboy;
//                91: points[367:364] <= randyboy;
//                92: points[371:368] <= randyboy;
//                93: points[375:372] <= randyboy;
//                94: points[379:376] <= randyboy;
//                95: points[383:380] <= randyboy;
//                96: points[387:384] <= randyboy;
//                97: points[391:388] <= randyboy;
//                98: points[395:392] <= randyboy;
//                99: points[399:396] <= randyboy;
//                100: points[403:400] <= randyboy;
//                101: points[407:404] <= randyboy;
//                102: points[411:408] <= randyboy;
//                103: points[415:412] <= randyboy;
//                104: points[419:416] <= randyboy;
//                105: points[423:420] <= randyboy;
//                106: points[427:424] <= randyboy;
//                107: points[431:428] <= randyboy;
//                108: points[435:432] <= randyboy;
//                109: points[439:436] <= randyboy;
//                110: points[443:440] <= randyboy;
//                111: points[447:444] <= randyboy;
//                112: points[451:448] <= randyboy;
//                113: points[455:452] <= randyboy;
//                114: points[459:456] <= randyboy;
//                115: points[463:460] <= randyboy;
//                116: points[467:464] <= randyboy;
//                117: points[471:468] <= randyboy;
//                118: points[475:472] <= randyboy;
//                119: points[479:476] <= randyboy;
//                120: points[483:480] <= randyboy;
//                121: points[487:484] <= randyboy;
//                122: points[491:488] <= randyboy;
//                123: points[495:492] <= randyboy;
//                124: points[499:496] <= randyboy;
//                125: points[503:500] <= randyboy;
//                126: points[507:504] <= randyboy;
//                127: points[511:508] <= randyboy;
//                128: points[515:512] <= randyboy;
//                129: points[519:516] <= randyboy;
//                130: points[523:520] <= randyboy;
//                131: points[527:524] <= randyboy;
//                132: points[531:528] <= randyboy;
//                133: points[535:532] <= randyboy;
//                134: points[539:536] <= randyboy;
//                135: points[543:540] <= randyboy;
//                136: points[547:544] <= randyboy;
//                137: points[551:548] <= randyboy;
//                138: points[555:552] <= randyboy;
//                139: points[559:556] <= randyboy;
//                140: points[563:560] <= randyboy;
//                141: points[567:564] <= randyboy;
//                142: points[571:568] <= randyboy;
//                143: points[575:572] <= randyboy;
//                144: points[579:576] <= randyboy;
//                145: points[583:580] <= randyboy;
//                146: points[587:584] <= randyboy;
//                147: points[591:588] <= randyboy;
//                148: points[595:592] <= randyboy;
//                149: points[599:596] <= randyboy;
//                150: points[603:600] <= randyboy;
//                151: points[607:604] <= randyboy;
//                152: points[611:608] <= randyboy;
//                153: points[615:612] <= randyboy;
//                154: points[619:616] <= randyboy;
//                155: points[623:620] <= randyboy;
//                156: points[627:624] <= randyboy;
//                157: points[631:628] <= randyboy;
//                158: points[635:632] <= randyboy;
//                159: points[639:636] <= randyboy;
//                160: points[643:640] <= randyboy;
//                161: points[647:644] <= randyboy;
//                162: points[651:648] <= randyboy;
//                163: points[655:652] <= randyboy;
//                164: points[659:656] <= randyboy;
//                165: points[663:660] <= randyboy;
//                166: points[667:664] <= randyboy;
//                167: points[671:668] <= randyboy;
//                168: points[675:672] <= randyboy;
//                169: points[679:676] <= randyboy;
//                170: points[683:680] <= randyboy;
//                171: points[687:684] <= randyboy;
//                172: points[691:688] <= randyboy;
//                173: points[695:692] <= randyboy;
//                174: points[699:696] <= randyboy;
//                175: points[703:700] <= randyboy;
//                176: points[707:704] <= randyboy;
//                177: points[711:708] <= randyboy;
//                178: points[715:712] <= randyboy;
//                179: points[719:716] <= randyboy;
//                180: points[723:720] <= randyboy;
//                181: points[727:724] <= randyboy;
//                182: points[731:728] <= randyboy;
//                183: points[735:732] <= randyboy;
//                184: points[739:736] <= randyboy;
//                185: points[743:740] <= randyboy;
//                186: points[747:744] <= randyboy;
//                187: points[751:748] <= randyboy;
//                188: points[755:752] <= randyboy;
//                189: points[759:756] <= randyboy;
//                190: points[763:760] <= randyboy;
//                191: points[767:764] <= randyboy;
//                192: points[771:768] <= randyboy;
//                193: points[775:772] <= randyboy;
//                194: points[779:776] <= randyboy;
//                195: points[783:780] <= randyboy;
//                196: points[787:784] <= randyboy;
//                197: points[791:788] <= randyboy;
//                198: points[795:792] <= randyboy;
//                199: points[799:796] <= randyboy;
//                200: points[803:800] <= randyboy;
//                201: points[807:804] <= randyboy;
//                202: points[811:808] <= randyboy;
//                203: points[815:812] <= randyboy;
//                204: points[819:816] <= randyboy;
//                205: points[823:820] <= randyboy;
//                206: points[827:824] <= randyboy;
//                207: points[831:828] <= randyboy;
//                208: points[835:832] <= randyboy;
//                209: points[839:836] <= randyboy;
//                210: points[843:840] <= randyboy;
//                211: points[847:844] <= randyboy;
//                212: points[851:848] <= randyboy;
//                213: points[855:852] <= randyboy;
//                214: points[859:856] <= randyboy;
//                215: points[863:860] <= randyboy;
//                216: points[867:864] <= randyboy;
//                217: points[871:868] <= randyboy;
//                218: points[875:872] <= randyboy;
//                219: points[879:876] <= randyboy;
//                220: points[883:880] <= randyboy;
//                221: points[887:884] <= randyboy;
//                222: points[891:888] <= randyboy;
//                223: points[895:892] <= randyboy;
//                224: points[899:896] <= randyboy;
//                225: points[903:900] <= randyboy;
//                226: points[907:904] <= randyboy;
//                227: points[911:908] <= randyboy;
//                228: points[915:912] <= randyboy;
//                229: points[919:916] <= randyboy;
//                230: points[923:920] <= randyboy;
//                231: points[927:924] <= randyboy;
//                232: points[931:928] <= randyboy;
//                233: points[935:932] <= randyboy;
//                234: points[939:936] <= randyboy;
//                235: points[943:940] <= randyboy;
//                236: points[947:944] <= randyboy;
//                237: points[951:948] <= randyboy;
//                238: points[955:952] <= randyboy;
//                239: points[959:956] <= randyboy;
//                240: points[963:960] <= randyboy;
//                241: points[967:964] <= randyboy;
//                242: points[971:968] <= randyboy;
//                243: points[975:972] <= randyboy;
//                244: points[979:976] <= randyboy;
//                245: points[983:980] <= randyboy;
//                246: points[987:984] <= randyboy;
//                247: points[991:988] <= randyboy;
//                248: points[995:992] <= randyboy;
//                249: points[999:996] <= randyboy;
//                250: points[1003:1000] <= randyboy;
//                251: points[1007:1004] <= randyboy;
//                252: points[1011:1008] <= randyboy;
//                253: points[1015:1012] <= randyboy;
//                254: points[1019:1016] <= randyboy;
//                255: points[1023:1020] <= randyboy;
//                256: points[1027:1024] <= randyboy;
//                257: points[1031:1028] <= randyboy;
//                258: points[1035:1032] <= randyboy;
//                259: points[1039:1036] <= randyboy;
//                260: points[1043:1040] <= randyboy;
//                261: points[1047:1044] <= randyboy;
//                262: points[1051:1048] <= randyboy;
//                263: points[1055:1052] <= randyboy;
//                264: points[1059:1056] <= randyboy;
//                265: points[1063:1060] <= randyboy;
//                266: points[1067:1064] <= randyboy;
//                267: points[1071:1068] <= randyboy;
//                268: points[1075:1072] <= randyboy;
//                269: points[1079:1076] <= randyboy;
//                270: points[1083:1080] <= randyboy;
//                271: points[1087:1084] <= randyboy;
//                272: points[1091:1088] <= randyboy;
//                273: points[1095:1092] <= randyboy;
//                274: points[1099:1096] <= randyboy;
//                275: points[1103:1100] <= randyboy;
//                276: points[1107:1104] <= randyboy;
//                277: points[1111:1108] <= randyboy;
//                278: points[1115:1112] <= randyboy;
//                279: points[1119:1116] <= randyboy;
//                280: points[1123:1120] <= randyboy;
//                281: points[1127:1124] <= randyboy;
//                282: points[1131:1128] <= randyboy;
//                283: points[1135:1132] <= randyboy;
//                284: points[1139:1136] <= randyboy;
//                285: points[1143:1140] <= randyboy;
//                286: points[1147:1144] <= randyboy;
//                287: points[1151:1148] <= randyboy;
//                288: points[1155:1152] <= randyboy;
//                289: points[1159:1156] <= randyboy;
//                290: points[1163:1160] <= randyboy;
//                291: points[1167:1164] <= randyboy;
//                292: points[1171:1168] <= randyboy;
//                293: points[1175:1172] <= randyboy;
//                294: points[1179:1176] <= randyboy;
//                295: points[1183:1180] <= randyboy;
//                296: points[1187:1184] <= randyboy;
//                297: points[1191:1188] <= randyboy;
//                298: points[1195:1192] <= randyboy;
//                299: points[1199:1196] <= randyboy;        
//            endcase
//        end
//    end
//endmodule

