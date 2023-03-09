# asmTest
Kicad projekt pro test přepínání osazovacích variant pomocí pluginu kiAsm. Návrh není funkční (náhodné zapojení pinů procesoru, chybí mnoho součástek ...)

## osazovací varianty
- **def**: defaultní varianta. Pokud nejsou parametry součástky předefinovány v osazovací variantě, použije se to, co je v **def**
- **var1**: první osazovací varianta
- **var2**: druhá osazovací varianta

## test ručního přepínání variant - `kiAsm switch`
Před testem je projekt přepnutý do varianty **var1**, testovací posloupnost:
1) `git status`: zkontrolovat, že v repu nejsou necommitnuté změny - `kiAsm` mění soubory a opakované spuštění testu by mohlo dát jiný výsledek
2) přepnout na var2
3) vygenerovat podklady, porovnat se správnými daty (kontrola, jestli `kiAsm` přepíná přes **def** a nebo rovnou do **var2**)
4) přepnout na def
5) vygenerovat podkaldy, porovnat se správnými daty
6) přepnout na var1
7) vygenerovat podklady, porovnat se správnými daty
8) test začíná i končí **var1**, zkontrolovat pomocí `git status`, že není v souborech projektu rozdíl, případně vrátit testovací data do původního stavu - `git reset --hard HEAD`

## Jednotlivé součástky a co se jimi testuje
- R1 .. R6 - gate odpory výkonových tranzistorů, `Value` a `LCSC` jiné v každé variantě 
- Q1 .. Q6 - výkonové tranzistory, `Value` a `LCSC` jiné v každé variantě, se změnou varianty se mění i `Datasheet`
- R7, R8 - bočníky pro měření proudu, **var1** `Value` a **var1** `LCSC` nevyplněno, testuje se, že bude načteno z **def** i při přepnutí **var2** -> **var1**
- U1, U2, U3 - budiče driverů, obdobná situace jako R7, R8, ale **var1** `Value` a **var1** `LCSC` je změněné, kdežto **var2**  je shodné s **def**. Ve všech variantách je stejný `Datasheet` 
- FID1, FID2 - fiducial markery, nejsou v BOMu, ale jsou v PnP (aby si osazovači lehko zjistili souřadnice), s osazovací variantou se nemění
- LOGO1 - logo firmy jako součástka, nemá být v BOMu ani v PnP, se změnou osazovací varianty se nemění, řešeno pomocí `dnp`
- U4 - CAN driver - pro **var2** není osazený, testuje se funkce `dnp`. Pro **var2** se neobjeví v bomu ani v PnP, pro **def** a **var1** ano
- U5 - UART oddělovač - podobně jako U4, jenom prohozené **var1** a **var2**
- C10/C20 - kondenzátor pro test změny `Reference` - pro **var2** je přejmenovaný na C20, ve variantách **def** a **var1** je uvedený jako C10
- TODO: testování on_board a in_bom

## TODO: test správného zápisu změn z varianty do pracovních políček a zpátky
Před testem je projekt přepnutý do varianty **var1**, a má několik změn, které jsou jenom v pracovních políčkách kicadu a nejsou uložené do varianty. Pak následuje posloupnost:
1) gitem zkontrolovat, že v repu nejsou necommitnuté změny - `kiAsm` mění soubory a opakované spuštění testu by mohlo dát jiný výsledek
2) přepnout na var2
3) vygenerovat podklady, porovnat se správnými daty (kontrola, jestli `kiAsm` přepíná přes **def** a nebo rovnou do **var2**)
4) přepnout na def
5) vygenerovat podkaldy, porovnat se správnými daty (kontrola, co udělá prázdné a neexistující políčko u některých součástek pro varaintu **def**)
6) přepnout na var1
7) vygenerovat podklady, porovnat se správnými daty (kontrola, jestli se při přepnutí z **var1** uložila změněná data do varianty)
8) vrátit testovací data do původního stavu - `git reset --hard HEAD`

## TODO: součástky pro test práce s daty a udržování jejich konzistence
- C? C? C? - několik součástek přidaných bez zapnuté automatické anotace - TODO: jak by na to měl kiAsm reagovat?
- D1 - indikační dioda, pro **var1** je červená, jinak zelená - kromě změny `value` z red na green se testuje i změna custom políčka s (vymyšleným) LCSC katalogovým číslem. Red má katalogové číslo C12345, green má C67890
- R9 - druhý předřadný odpor pro diodu, pokud je dioda červená (**var1**), neosazuje se - vynechání z podkladů je řešeno přes JLCPCB_IGNORE, účelem je vyzkoušet, že kiAsm políčko JLCPCB_IGNORE z osatatních variant smaže, protože KiKit se rozhoduje podle existence tohoto políčka a ne podle jeho obsahu (prázdné políčko pořád existuje). Odpor se tedy musí objevit v datech **def** a **var2**, ale nesmí být ve **var1**
- U7 - LIN driver - ve **var2** se neosazuje, součástka přidaná do schématu později. Kromě políčka `var2 dnp` a `def Value` nemá žádná další políčka vytvořena - testuje se, jestli se kiAsm zachová správně k neexistujícím políčkům - tedy že si načte Value z **def** 


TODO: naroutovat a upravit sch i pcb tak, aby prošlo DRC a bylo možné generovat pohodlně bom, gerber data atd ...