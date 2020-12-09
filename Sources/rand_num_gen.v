`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 04:20:20 PM
// Design Name: 
// Module Name: rand_num_gen
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


module rand_num_gen(
   #(parameter BITS = 6)(
    input             clk,
    input             rst_n,

    output reg [5:0] data
    );

   reg [5:0] data_next;
   always_comb begin
      data_next = data;
      repeat(BITS) begin
         data_next = {(data_next[5]^data_next[1]), data_next[5:1]};
      end
   end

   always_ff @(posedge clk or negedge reset) begin
      if(!rst_n)
         data <= 6'h1f;
      else
         data <= data_next;
      end
   end

endmodule
