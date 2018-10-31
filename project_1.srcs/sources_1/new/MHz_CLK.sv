`timescale 1ns / 1ps
`define TCQ #1

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2017 11:47:09 PM
// Design Name: 
// Module Name: MHz_CLK
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


module MHz_CLK(

    input logic clk,
    input logic en,
    output logic MHz_CLK
    );
    logic [5:0] count;
    always_ff @ (posedge clk)
    begin
        if ((en == 0) || (count == 6'd49))
            count <= `TCQ {6{1'b0}};
        else if (en)
        begin
            count <= `TCQ count + 1'b1;
            
        end
    end
    
    always_ff @ (posedge clk)
        begin
            if (en == 0)
                MHz_CLK <= `TCQ 1'b0;
            else if (count == 26'd49)
            begin
                MHz_CLK <= `TCQ ! MHz_CLK;
                
            end
        end


    
endmodule
