REM Opsæt navne på log og error filer
set datex=%date: =0%
set timex=%time: =0%
set NAMELF="%~dpn0_%datex:~6%_%datex:~3,2%_%datex:~0,2%_%timex:~0,2%_%timex:~3,2%_%timex:~6,2%.log"

call "%~dp0ogr_eksempel" 1>> %NAMELF% 2>>&1

pause