git status

REM kiasm switch --prefix def ..\
kiasm switch --prefix var2 ..\
kikit fab jlcpcb --no-drc --assembly --schematic ..\asmTest.kicad_sch ..\asmTest.kicad_pcb grb

git diff --no-index grb_var2\bom.csv grb\bom.csv
git diff --no-index grb_var2\pos.csv grb\pos.csv
rmdir /Q /s grb

kiasm switch --prefix def ..\
kikit fab jlcpcb --no-drc --assembly --schematic ..\asmTest.kicad_sch ..\asmTest.kicad_pcb grb
git diff --no-index grb_def\bom.csv grb\bom.csv
git diff --no-index grb_def\pos.csv grb\pos.csv
rmdir /Q /s grb

REM kiasm switch --prefix var2 ..\
kiasm switch --prefix var1 ..\
kikit fab jlcpcb --no-drc --assembly --schematic ..\asmTest.kicad_sch ..\asmTest.kicad_pcb grb
git diff --no-index grb_var1\bom.csv grb\bom.csv
git diff --no-index grb_var1\pos.csv grb\pos.csv
rmdir /Q /s grb

git status


REM git diff --no-index --color-words=. grb_var2\bom.csv grb\bom.csv
REM git diff --no-index --color-words grb_var2\bom.csv grb\bom.csv
