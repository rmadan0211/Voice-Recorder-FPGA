`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 06:42:26 PM
// Design Name: 
// Module Name: Counter
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


module Counter(
    input logic clock,
    input logic CNT_EN,
    input logic en,
    input logic reset,
    output logic [16:0] address
    );
    logic[16:0] count = 0;
    logic el_clock;
    
MHz_CLK MIC_CLK(
    .clk(clock),
    .en(en),
    .MHz_CLK(el_clock)
);
// top level clock behavior
 
    always_ff @ (posedge el_clock) begin
        if(count==17'd124999) begin
            count<=17'd0;
            address <= count;
        end
        else if(CNT_EN == 1'b1) begin
            count <= count+1'b1;
            address <= count;
            //address <= address+1'b1;
        end
    end
//end of module
endmodule

