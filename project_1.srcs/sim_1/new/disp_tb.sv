`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2017 11:52:40 AM
// Design Name: 
// Module Name: disp_tb
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

// note to grader:
// run Tb for at least a few milliseconds
module disp_tb(

    );
   
    
    logic clock;
    logic [6:0] cathode;
    logic rec1;

    logic play1;
  
    logic A0; 
    logic A1; 
    logic A2; 
    logic A3; 
    logic A4; 
    logic A5; 
    logic A6; 
    logic A7;
    
    display DUT(
    .clock(clock),
    .cathode(cathode),
    .rec1(rec1),
    
    .play1(play1),
    
    .A0(A0), 
    .A1(A1), 
    .A2(A2), 
    .A3(A3), 
    .A4(A4), 
    .A5(A5), 
    .A6(A6), 
    .A7(A7)
    );
    
    always #5 clock=!clock;
    
    initial begin
    #1
    clock=0;
    #5000
    rec1=0;
    #5000000
    
    rec1=1;
    #5000000
    
    
    rec1=0;
    #5000000
   
    
    play1=0;
    #5000000
    
    play1=1;
    #5000000
    
    
    
    $finish;
    end
    
endmodule