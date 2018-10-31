`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2017 05:38:04 PM
// Design Name: 
// Module Name: Deserializer
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


module Deserializer #(
 parameter WORD_LENGTH = 16,
 parameter SYSTEM_FREQUENCY = 100000000,
 parameter SAMPLING_FREQUENCY = 1000000)
(
input clock_i, // 100 Mhz system clock
input enable_i, // Enable passed by Controller(~reset)
//output signals
output logic done_o, //Indicates that Data is ready
output logic [15:0] data_o, //Output 16-bit Word
//output logic [16:0] address,

//PDM Microphone related signals
output pdm_clk_o,
input pdm_data_i,
output logic pdm_lrsel_o
);
logic [4:0] count = 5'd0;

MHz_CLK MIC_CLK(
    .clk(clock_i),
    .en(enable_i),
    .MHz_CLK(pdm_clk_o)
);

initial begin
pdm_lrsel_o = 1'b1;
end

always_ff @ (posedge pdm_clk_o) 
    begin 
    if(count == 5'd15) begin
        count <= 5'b00000;
        done_o <= 1;
    end
    else begin
        data_o <= data_o >> 1'b1;
        data_o[15] <= pdm_data_i;
        count <= count + 1'b1;  
        done_o <= 0;
    end
end

endmodule
