//=============================================================================
// [Filename]       Contador_gray_detector.v
// [Project]        Design for VLSI
// [Author]         Luis Enrique Namigtle Jiménez - enrique.namigtle@inaoe.edu.mx
// [Institution]   Instituto Nacional de Astrofísica, Óptica y Electrónica
// [Language]       Verilog
// [Created]        Jul 2025
// [Modified]       -
// [Description]    Desing of a Gray code counter with a detector for specific transitions.
// [Notes]          -
// [Status]         Successfully tested
// [Revisions]      -
//=============================================================================

// ===============================  VARIABLES  =================================
module contador_gray_detector 
(
input wire  clk,
input wire rst,
input wire enable,
output reg [3:0]gray_out,
output wire detector
);
reg [3:0]gray_next;
reg [3:0]gray_anterior;
always @(posedge clk or posedge rst) begin
    if(rst) begin
        gray_out <= 4'b0000;
        gray_next <= 4'b0000;
        gray_anterior <= 4'b0000;
    end else if (enable) begin
        gray_anterior <= gray_out;
        gray_next <= gray_next + 1;
        gray_out <= gray_next ^ (gray_next >> 1);

    end
    end


assign detector = (gray_anterior == 4'b0100 && gray_out == 4'b1100) ? 1'b1:1'b0;
endmodule

