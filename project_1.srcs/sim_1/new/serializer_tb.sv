`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2017 10:17:06 PM
// Design Name: 
// Module Name: serializer_tb
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


module serializer_tb();
logic clk;
logic en;
  //output signals
logic done_o; //Indicates that Data is sent
logic [15:0] Data_i; //Input 16-bit word
  //output logic [16:0] address,
  // PWM
logic pwm_audio_o; //Output audio data
logic pwm_sdaudio_o; // Output audio enable (package pin D12),keep high


Serializer DUT(
    .clock_i(clk),
    .enable_i(en),
    //output signals
    .done_o(done_o), //Indicates that Data is sent
    .Data_i(Data_i), //Input 16-bit word
    //output logic [16:0] address,
  // PWM
    .pwm_audio_o(pwm_audio_o), //Output audio data
    .pwm_sdaudio_o(pwm_saudio_o) // Output audio enable (package pin D12),keep high
 );
 
 always #5 clk = ~clk;
                 
    initial 
    begin
     clk = 0;
     en = 0;
     #500
     en = 1;
     Data_i = 16'b0100111010101101;
     #15966
     Data_i = 16'b1111110000111101;
     $finish;
     end


endmodule