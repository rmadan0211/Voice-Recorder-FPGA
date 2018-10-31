`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 07:38:54 PM
// Design Name: 
// Module Name: main
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


module main(
    input clk,
    input record,
    input record_clip,
    input play,
    input play_clip,
    input reset,
    //PDM Microphone related signals
    output pdm_clk_o,
    input pdm_data_i,
    output logic pdm_lrsel_o,
    //my stuff
    output logic id,
    output logic re,
    output logic dn,
    // delete later
    output logic pwm_audio_o,
    output logic pwm_sdaudio_o,
    output logic [6:0] cathode,
    output logic A0, A1, A2, A3, A4, A5, A6, A7
    );
    logic en, en2, flag, done_o,done_o_ser,wea,en_ser, en_des, done_driver, en_driver;
    logic [15:0] Data_i;
    logic [15:0] Data_i2;
    logic [16:0] address;
    logic [16:0] addr_BRAM;
    logic [15:0] data_o;
    logic [15:0] Data_driver;
    logic record_1;
    logic record_2;
    logic play_1;
    logic play_2;

    
    Timer two_second_timer(
        .clk(clk),
        .en(en_driver),
        .flag(flag)
    );
    
    Counter my_count (
        .clock(clk),
        .en(en_driver),
        .CNT_EN(done_driver),
        .address(address)
    );
    
    Controller control (
        .clk(clk),
        .record_1(record_1),
        .record_2(record_2),
        .reset(reset),
        .flag(flag),
        .play_1(play_1),
        .play_2(play_2),
        .en_des(en_des),
        .en_ser(en_ser),
        .wea(wea),
        //output logic done,
        .id(id),
        .re(re),
        .dn(dn),
        .en(en),
        .en2(en2)
    );
    
    Deserializer decereal (
        .clock_i(clk), // 100 Mhz system clock
        .enable_i(en_des), // Enable passed by Controller(~reset)
        //output signals
        .done_o(done_o), //Indicates that Data is ready
        .data_o(data_o), //Output 16-bit Word
        //PDM Microphone related signals
        .pdm_clk_o(pdm_clk_o),
        .pdm_data_i(pdm_data_i),
        .pdm_lrsel_o(pdm_lrsel_o)
    );
    
    Serializer cereal (
        .clock_i(clk),
        .enable_i(en_ser),
        //output signals
        .done_o(done_o_ser), //Indicates that Data is sent
        .Data_i(Data_driver), //Input 16-bit word
        //.address(addr_ser),
        // PWM
        .pwm_audio_o, //Output audio data
        .pwm_sdaudio_o // Output audio enable (package pin D12),keep high
    );
   

    
    blk_mem_gen_0 recording_one (
        .clka(clk),    // input wire clka
        .ena(en),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addr_BRAM),  // input wire [16 : 0] addra
        .dina(data_o),   // input wire [15 : 0] dina
        .douta(Data_i)  // output wire [15 : 0] douta
    );
    
   blk_mem_gen_0 recording_two (
        .clka(clk),    // input wire clka
        .ena(en2),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addr_BRAM),  // input wire [16 : 0] addra
        .dina(data_o),   // input wire [15 : 0] dina
        .douta(Data_i2)  // output wire [15 : 0] douta
    );
    
    sync synchronizer (
        .clk(clk),
        .record(record),
        .play(play),
        .record_clip(record_clip),
        .play_clip(play_clip),
        .record_1(record_1),
        .record_2(record_2),
        .play_1(play_1),
        .play_2(play_2)
    );
    
    display seven_seg (
        .clock(clk),
        .cathode(cathode),
        .rec1(record_clip),
        .play1(play_clip),
        .A0(A0), 
        .A1(A1), 
        .A2(A2), 
        .A3(A3), 
        .A4(A4), 
        .A5(A5), 
        .A6(A6), 
        .A7(A7)
    );
    
    always_comb
    begin
    if(en) begin
    if(wea==1)begin
        en_driver = en;
        done_driver = done_o;
        addr_BRAM=address; 
        end
    else begin
        done_driver = done_o_ser;
        en_driver = en;
        addr_BRAM=address; 
        Data_driver = Data_i;
        end
    end
    else if(en2) begin
    // this is the stuff added
    if(wea==1)begin
        en_driver = en2;
        done_driver = done_o;
        addr_BRAM=address; 
        end
    else begin
        done_driver = done_o_ser;
        en_driver = en2;
        addr_BRAM=address; 
        Data_driver = Data_i2;
        end
    end
    else en_driver = 0;

    end
    
    
endmodule

