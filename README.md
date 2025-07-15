# Proj_vlsi_ipn--Convocatoria Silicluster 2025

- **Autor**: Luis Enrique Namigtle Jiménez  
- **Correo**: enrique.namigtle@inaoe.edu.mx  


Fecha límite: Domingo 3 de agosto de 2025
### Caracteristicas
Especificaciones del módulo:

- Área máxima: 150 × 150 µm
- Máximo 10 entradas, 10 salidas
- 1 señal de reloj
- Verilog 2005
- Sin bucles (for, generate, etc.)
- Tecnología de fabricación: PDK de Sky130
- Estimación: ~500 compuertas lógicas máximo

#### Descripción del modulo:

El módulo contador_gray_detector implementa un contador ascendente de 4 bits en código Gray, y detecta una transición específica entre dos valores consecutivos del contador. 

#### Funcionamiento detallado

- **Contador en código Gray:**
  - El módulo mantiene un contador binario interno de 4 bits.
  - En cada ciclo de reloj con `enable = 1`, este contador incrementa en 1.
  - Su valor se convierte a código Gray y se presenta por la salida `gray_out[3:0]`.

- **Condiciones de reinicio:**
  - Cuando `reset = 1`, el contador se reinicia a cero (`0000`) y la salida `detector` se desactiva.

- **Detección de transición:**
  - El módulo guarda internamente el valor de `gray_out` del ciclo anterior.
  - Si se detecta la transición exacta de `0111 → 0100` (en código Gray), la salida `detector` se activa a 1 por un solo ciclo.
  - En todos los demás casos, `detector = 0`.

- **Salida estable:**
  - `gray_out` refleja el valor actual del contador en código Gray.
  - `detector` solo se activa durante un ciclo de reloj al detectar la transición deseada.
