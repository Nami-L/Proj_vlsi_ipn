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

`timescale 1ns / 1ps

module tb_contador_gray_detector();
    // Señales de entrada
    reg clk;
    reg rst;
    reg enable;
    
    // Señales de salida
    wire [3:0] gray_out;
    wire detector;
    
    // Instanciar el módulo bajo prueba
    contador_gray_detector uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .gray_out(gray_out),
        .detector(detector)
    );
    
    // Generador de reloj (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10ns (100MHz)
    end
    
    // Secuencia de prueba
    initial begin
        // Inicializar
        enable = 0;
        rst = 1;
        #20; // Mantener reset por 20ns
        
        // Liberar reset y activar enable
        rst = 0;
        enable = 1;
        
        // Esperar hasta que se detecte la transición
        wait(detector == 1);
        $display("[%0t] Detector activado! gray_out=4'b1100, gray_anterior=4'b0100", $time);
        
        // Continuar por unos ciclos más
        #100;
        
        // Desactivar enable y verificar
        enable = 0;
        #30;
        
        // Reactivar y continuar
        enable = 1;
        #100;
        
        // Finalizar simulación
        $display("[%0t] Fin de la simulación", $time);
        $finish;
    end
    
    // Monitoreo de señales
    initial begin
        $timeformat(-9, 1, "ns", 10);
        $monitor("[%0t] clk=%b rst=%b enable=%b gray_next=%4b  gray_anterior=%4b detector=%b",
        $time, clk, rst, enable, uut.gray_next, uut.gray_anterior, detector);
        $fsdbDumpvars;                // Synopsys VCS

    end
endmodule