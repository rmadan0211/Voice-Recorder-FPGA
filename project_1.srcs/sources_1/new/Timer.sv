`timescale 1ns / 1ps
`define TCQ #1
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2017 05:22:46 PM
// Design Name: 
// Module Name: Timer
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


module Timer(
    input logic clk,
    input logic en,
    output logic flag
    );
    logic [27:0] count_mill = 28'd0;  
    
always_ff @ (posedge clk)
begin
    if(en) begin
        if(count_mill == 28'd199_999_999) begin
            count_mill = 28'd0;
            flag = 1;
        end
        else begin
            flag = 0;
            count_mill = count_mill + 1'b1;
        end
    end
    else begin
        flag = 0;
        count_mill = 28'd0; 
    end
end
endmodule

