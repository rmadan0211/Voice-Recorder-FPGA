`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2017 11:56:29 AM
// Design Name: 
// Module Name: sync
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


module sync(
    input clk,
    input record,
    input play,
    input record_clip,
    input play_clip,
    output logic record_1,
    output logic record_2,
    output logic play_1,
    output logic play_2
    );
    logic n = 0;
    
    always_ff @ (posedge clk) begin
        if(record) begin
            if(record_clip == 1) begin
                n <= 1;
                record_2 <= n;
                end
            else begin
                n <= 1;
                record_1 <= n;
                end
            end
        else if(play) begin
            if(play_clip == 1) begin
                n <= 1;
                play_2 <= n;
                end
            else begin
                n <= 1;
                play_1 <= n;
                end
            end
        else begin
            n = 0;
            record_1 <= 0;
            record_2 <= 0;
            play_1 <= 0;
            play_2 <= 0;
        end
    end
endmodule
