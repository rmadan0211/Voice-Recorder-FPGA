`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2017 10:12:57 AM
// Design Name: 
// Module Name: display
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


module display(
   input logic clock,
   output logic [6:0] cathode,
   input logic rec1,
  
   input logic play1,
  
   output logic A0, 
    output logic A1, 
     output logic A2, 
      output logic A3, 
       output logic A4, 
        output logic A5, 
         output logic A6, 
          output logic A7
);

reg[23:0] clock_count = 0;
 wire clock_sig;
 reg [2:0] count = 3'b000;
 wire [6:0] Digit;


always@(posedge clock)
  begin
    clock_count <= clock_count + 1;
  end
  
 assign clock_sig = clock_count[17];
 
 always@(posedge clock_sig)
 begin
    count <= count + 1;
 end 
 
 always@(count)
 begin
    A0 <= 1'b1;
    A1 <= 1'b1;
    A2 <= 1'b1;
    A3 <= 1'b1;
    A4 <= 1'b1;
    A5 <= 1'b1;
    A6 <= 1'b1;
    A7 <= 1'b1;
   case(count)
       
        0:
        begin
          A0 <= 1'b0;  
          if ((rec1==1))
          cathode <= 7'b0100100;
          else if ((rec1==0))
          cathode <=7'b1111001;   
          else
          cathode<=7'b0001000;
        end
        
        1:
        begin
            A1 <= 1'b0;
           if ((play1==1))
                      cathode <= 7'b0100100;
                      else if ((play1==0))
                      cathode <=7'b1111001;
        end
        
        2:
        begin
            A2 <= 1'b0;
            cathode <= 7'b1111111;
        end
        
        3:
        begin
            A3 <= 1'b0;
            cathode <= 7'b1111111;
        end
       
        4:
        begin
            A4 <= 1'b0;
            cathode <= 7'b1111111;
        end
       
        5:
        begin
            A5 <= 1'b0;
            cathode <= 7'b1111111;
        end
       
        6:
        begin
            A6 <= 1'b0;
            cathode <= 7'b1111111;
        end
       
        7:
        begin
            A7 <= 1'b0;
            cathode <= 7'b1111111;
        end
    endcase
 end
 
endmodule