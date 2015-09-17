REM ============================================================================================
REM == Fælles funtion, check af argumenter til selve uploud funktionen.                       ==
REM ==                                                                                        ==
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM =====================================================
REM Viser information i en evt. log fil
REM =====================================================
@echo.
@echo === Inddataparametre =======================================================================
@echo Kilde..... %1 / Lag... %2
@echo Database.. %3 
@echo Schema.... %4 / Tabel... %5 / Type... %6 
@echo.
@echo --- Log data -------------------------------------------------------------------------------
@echo Job startet %date% %time%

REM =====================================================
REM Sanitycheck af semipermanente environment variable, 
REM (burde være sat via ogr_environment.bat)
REM =====================================================
if #%ogr_geom%==# set ogr_geom=geom
if #%ogr_fid%==# set ogr_fid=fid
if #%ogr_epsg%==# set ogr_epsg=25832
if "%ogr_spatial%"=="" set "ogr_spatial=350000,6020000,950000,6450000"
if "%PGCLIENTENCODING%"=="" set "PGCLIENTENCODING=LATIN1"
if #%ogr_schema%==# set "ogr_schema=dbo"

REM =====================================================
REM Inddata check, alle 6 parametre *skal* være angivet
REM =====================================================

REM Parm. 1, OGR inddatakilde, f.eks wfs definition
set xp1="%~1" 

REM Parm. 2, Lag definition for inddatakilde; hvis den ikke benyttes (f.eks tab og shape), anvendes en * i kommandolinien som parameter
if #%~2==#* (set xp2=) else (set xp2="%~2")

REM Parm. 3, Definition af database forbindelse
set xp3="%~3" 

REM Parm. 4, Schema for tabel; angiv en "*" for default
if #%~4==#* (set xp4=%ogr_schema%) else (set xp4=%~4)

REM Parm. 5, Navn for ny tabel; angiv en "*" hvis lagnavn Ã¸nskes benyttet 
if #%~5==#* (set xp5=%xp2%) else (set xp5=%~5)

REM Tabelnavn renses for tumpetegn (Tilføjes efter behov)
set xp5=%xp5: =_% & set xp5=%xp5::=_%

REM Parm. 6, Objekttype, skal være enten PKT, MPKT, LIN, MLIN, POL, MPOL eller *

REM Konvertering af arg 6 til store bogstaver
set xp6=%~6
if not #%xp6%==# (
  set xp6=%xp6:p=P%
  set xp6=%xp6:k=K%
  set xp6=%xp6:t=T%
  set xp6=%xp6:m=M%
  set xp6=%xp6:l=L%
  set xp6=%xp6:i=I%
  set xp6=%xp6:n=N%
  set xp6=%xp6:o=O%
)

REM =====================================================
REM Generering af kommandolinie stumper til filtrering. xp10 indeholder 
REM del af -where filter udtryk og xp9 indeholder -nlt kommando 
REM =====================================================
set "xp8="
set "xp9="
set "xp10="
if #%xp6%==#PKT  ( set "xp8=OGR_GEOMETRY='POINT'" & set "xp9=")
if #%xp6%==#MPKT ( set "xp8=OGR_GEOMETRY='POINT' OR OGR_GEOMETRY='MULTIPOINT'" & set "xp9=-nlt PROMOTE_TO_MULTI")
if #%xp6%==#LIN  ( set "xp8=OGR_GEOMETRY='LINESTRING'" & set "xp9=")
if #%xp6%==#MLIN ( set "xp8=OGR_GEOMETRY='LINESTRING' OR OGR_GEOMETRY='MULTILINESTRING'" & set "xp9=-nlt PROMOTE_TO_MULTI")
if #%xp6%==#POL  ( set "xp8=OGR_GEOMETRY='POLYGON'" & set "xp9=")
if #%xp6%==#MPOL ( set "xp8=OGR_GEOMETRY='POLYGON' OR OGR_GEOMETRY='MULTIPOLYGON'" & set "xp9=-nlt PROMOTE_TO_MULTI" )

REM =====================================================
REM Opsætning og behandling af semipermanente variable
REM =====================================================

REM -where clause færdiggøres. Tilføjes evt. filter information fra ogr_where
if     "#%ogr_where%#"=="##" if "#%xp8%#"=="##" ( set "xp10=" ) else ( set xp10=-where "%xp8%" ) 
if not "#%ogr_where%#"=="##" if "#%xp8%#"=="##" ( set xp10=-where "%ogr_where%" ) else ( set xp10=-where "(%xp8%) AND (%ogr_where%)" )

REM Der genereres en evt. "bbox" clause
if not "%ogr_bbox%"=="" (set xp7=-spat %ogr_bbox%) else (set xp7=) 
