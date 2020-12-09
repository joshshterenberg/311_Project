`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2020 07:43:33 AM
// Design Name: 
// Module Name: adder
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


module adder(
 input [12:0] A, B,
    output [12:0] result,
    output cout
    );
    
    // value passed into adder
    wire [2:0] carry;
    
    carry_lookahead #(.N(4)) cla1(A[3:0], B[3:0], carry[0], result[3:0], carry[1]);
    carry_lookahead #(.N(4)) cla2(A[7:4], B[7:4], carry[1], result[7:4], carry[2]);
    carry_lookahead #(.N(5)) cla3(A[12:8], B[12:8], carry[2], result[12:8], cout);
    

endmodule

module carry_lookahead #(parameter N = 4) (
    input [N - 1:0] A,
    input [N - 1:0] B,
    input cin, // Carry in
    output [N - 1:0] sum,
    output cout
    );
    
    wire[N:0] carry;
    wire [N - 1:0] p; // propogate
    wire [N - 1:0] g; // generate
    
    genvar i;
    
    generate
    for(i = 0; i < N; i = i + 1) begin : cla
        spg_cla_block spg(A[i], B[i], carry[i], sum[i], p[i], g[i]);
    end 
    endgenerate
    
    assign carry[0] = cin;
    assign carry[N:1] = g | (p & carry[3:0]);
    assign cout = carry[N];
    
endmodule

module spg_cla_block(
    
    input a,
    input b,
    input c, // carry in
    output sum, // sum
    output p, // propogate
    output g // generate
    );
    
    assign g = a & b;
    assign p = a ^ b;
    assign sum = c ^ p;
    
endmodule
