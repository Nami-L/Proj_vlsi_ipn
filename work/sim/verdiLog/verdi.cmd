simSetSimulator "-vcssv" -exec "simv" -args "+ntb_random_seed=1"
debImport "-dbdir" "simv.daidir"
debLoadSimResult \
           /home/enrique.namigtle/Proyectos_UVM/Proj_vlsi_ipn/work/sim/novas.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "446" "210" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_contador_gray_detector" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector.uut" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector.uut" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector.uut" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector.uut" -win $_nTrace1
srcSetScope "tb_contador_gray_detector.uut" -delim "." -win $_nTrace1
srcSignalView -on
verdiSetActWin -dock widgetDock_<Signal_List>
srcHBSelect "tb_contador_gray_detector.uut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_contador_gray_detector.uut" -win $_nTrace1
srcHBSelect "tb_contador_gray_detector.uut" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("uut" 0)}
wvRenameGroup -win $_nWave2 {G1} {uut}
wvAddSignal -win $_nWave2 "/tb_contador_gray_detector/uut/clk" \
           "/tb_contador_gray_detector/uut/rst" \
           "/tb_contador_gray_detector/uut/enable" \
           "/tb_contador_gray_detector/uut/gray_out\[3:0\]" \
           "/tb_contador_gray_detector/uut/detector"
wvSetPosition -win $_nWave2 {("uut" 0)}
wvSetPosition -win $_nWave2 {("uut" 5)}
wvSetPosition -win $_nWave2 {("uut" 5)}
wvZoomIn -win $_nWave2
verdiSetActWin -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvSelectSignal -win $_nWave2 {( "uut" 1 2 3 4 5 )} 
wvSetRadix -win $_nWave2 -format Bin
wvZoomIn -win $_nWave2
verdiWindowResize -win $_Verdi_1 "832" "230" "1275" "824"
wvSetCursor -win $_nWave2 131054.523476 -snap {("G2" 0)}
