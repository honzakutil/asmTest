kiasm switch --prefix def ..\
kikit fab jlcpcb --no-drc --assembly --schematic ..\asmTest.kicad_sch ..\asmTest.kicad_pcb grb_def

kiasm switch --prefix def ..\
kiasm switch --prefix var1 ..\
kikit fab jlcpcb --no-drc --assembly --schematic ..\asmTest.kicad_sch ..\asmTest.kicad_pcb grb_var1

kiasm switch --prefix def ..\
kiasm switch --prefix var2 ..\
kikit fab jlcpcb --no-drc --assembly --schematic ..\asmTest.kicad_sch ..\asmTest.kicad_pcb grb_var2