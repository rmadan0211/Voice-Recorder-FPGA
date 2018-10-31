`timescale 1ns / 1ps
`define TCQ #1
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2017 02:23:04 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
    input clk,
    input record_1,
    input record_2,
    input reset,
    input logic flag,
    input logic play_1,//To play the clip
    input logic play_2,
    //output logic done,
    output logic en_des,
    output logic en_ser,
    output logic wea,
    output logic id,
    output logic re,
    output logic dn,
    output logic en,
    output logic en2
    );
    
    logic [2:0] repeat1;
    logic [2:0] repeat2; 
    
//states
typedef enum logic [5:0] {idle = 6'b000001, record_clip_1 = 6'b000010, done_record = 6'b000100, 
                            output_clip_1 = 6'b001000, record_clip_2 = 6'b010000, output_clip_2 = 6'b100000}  states;
states state;
states next_state;
// clock behavior
always_ff @ (posedge clk)
begin
    if (reset)
        state <=  idle;
    else
        state <=  next_state;
end
// output logic
always_comb
begin
    case(state)
    idle: begin
        // turns off the 1 mhz clocks
        en = 0;
        // turns off block 2
        en2 = 0;
        // controls if deserializer works
        en_des=0;
        // controls if serializer works
        en_ser=0;
        // controls if we read or write, inititially set only to write
        wea=1'b0;
        // state lights
        id = 1;
        re = 0;
        dn = 0;
        //extra credit
        repeat1 = 3'd0;
        repeat2 = 3'd0;
        end
    record_clip_1: begin
        en = 1; 
        en_des=1;
        en_ser=0;
        wea=1'b1;
        id  = 0;
        re = 1;
        dn = 0;
        repeat1 = 3'd0;
        end
    done_record: begin
        en = 0;
        en2 = 0;
        en_des=0;
        en_ser=0;
        wea=1'b0;
        //done = 1; 
        id = 0;
        re = 0;
        dn = 1;
        end
     output_clip_1: begin
        en=1; 
        wea=0;
        en_des=0;
        en_ser=1;
        id = 0;
        re = 1;
        dn = 0;
        repeat1 = repeat1 + 1'b1;
        end   
    record_clip_2: begin
        en2 = 1;
        en_des=1;
        en_ser=0;
        wea=1'b1;
        id  = 0;
        re = 1;
        dn = 0;
        repeat2 = 3'd0;
        end
    output_clip_2: begin
        en2=1;
        wea=0;
        en_des=0;
        en_ser=1;
        id = 0;
        re = 1;
        dn = 0;
        repeat2 = repeat2 + 1'b1;
        end 
     
    endcase
end
// transition logic
always_comb
begin
    case (state)
    idle: begin
        if (record_1) next_state = record_clip_1;
        else if(record_2) next_state = record_clip_2;
        else next_state = state; end
    record_clip_1: begin
        if (flag) next_state = done_record;
        else next_state = state; 
        end
    done_record: begin
        if(repeat1 == 3'd7) next_state = idle;
        else if(repeat2 == 3'd7) next_state = idle;
        else if(play_1)next_state = output_clip_1;
        else if(play_2) next_state = output_clip_2;
        else if(record_1) next_state = record_clip_1;
        else if(record_2) next_state = record_clip_2;
        else next_state=state;
        end
    output_clip_1:begin
        if(flag) next_state=done_record;
        else next_state=state ;
        end
    record_clip_2: begin
        if(flag) next_state = done_record;
        else next_state = state;
    end    
    output_clip_2: begin
        if (flag) next_state = done_record;
        else next_state = state; 
        end
    endcase
end
endmodule


