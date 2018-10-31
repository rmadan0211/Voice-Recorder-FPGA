`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 07:48:46 PM
// Design Name: 
// Module Name: Serializer
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
module Serializer #(parameter WORD_LENGTH = 16,
 parameter SYSTEM_FREQUENCY = 100000000,
 parameter SAMPLING_FREQUENCY = 1000000)
 (
  input clock_i,
  input enable_i,
  //output signals
  output logic done_o, //Indicates that Data is sent
  input logic [15:0] Data_i, //Input 16-bit word
  //output logic [16:0] address,
  
  // PWM
  output logic pwm_audio_o, //Output audio data
  output logic pwm_sdaudio_o // Output audio enable (package pin D12),keep high
 );
 
 logic [4:0] count=5'd0;
 logic clock_ser;
 
 MHz_CLK MIC_CLK(
 .clk(clock_i),
 .en(enable_i),
 .MHz_CLK(clock_ser)
 );
 
 initial begin
 pwm_sdaudio_o = 1'b1;
 end
 
 always_ff @(posedge clock_ser)
 begin
    if(count==5'd15)
        begin 
            count <= 5'd0;
            done_o <= 1'b1;
  
        end
     else begin
        count <= count+1'b1;
        done_o <= 1'b0;
        pwm_audio_o <= Data_i[count];//>>1'b1;
        end
        
  end
  endmodule