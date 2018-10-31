`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2017 10:17:52 PM
// Design Name: 
// Module Name: des_tb
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

//note to grader
// run for no less than 10k ns for outputs
module des_tb(

    );
    
logic clock_i; // 100 Mhz system clock
logic enable_i; // Enable passed by Controller(~reset)
    //output signals
logic done_o; //Indicates that Data is ready
logic [15:0] data_o; //Output 16-bit Word
    //output logic [16:0] address,
    
    //PDM Microphone related signals
logic pdm_clk_o;
logic pdm_data_i;
logic pdm_lrsel_o;


Deserializer DUT(
.clock_i(clock_i), // 100 Mhz system clock
.enable_i(enable_i), // Enable passed by Controller(~reset)
//output signals
.done_o(done_o), //Indicates that Data is ready
.data_o(data_o), //Output 16-bit Word
//output logic [16:0] address,

//PDM Microphone related signals
.pdm_clk_o(pdm_clk_o),
.pdm_data_i(pdm_data_i),
.pdm_lrsel_o(pdm_lrsel_o)
);

always #5 clock_i=!clock_i;

initial begin
#1
clock_i=0;
enable_i=1'b0;
#200
enable_i=1'b1;
#100


#20

pdm_data_i=1;
#5000

pdm_data_i=0;
#1000
pdm_data_i=1;

#1000
pdm_data_i=0;
#1000
pdm_data_i=1;

#1000
pdm_data_i=0;
#1000
pdm_data_i=1;

#1000
pdm_data_i=0;
#1000
pdm_data_i=1;

#1000
pdm_data_i=0;
#1000
pdm_data_i=1;

#5000
$finish;
end

endmodule
