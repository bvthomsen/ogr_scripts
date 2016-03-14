set cmdfile=%~f0
set logfile=%cmdfile:.cmd=%
set cmdfile=%cmdfile:.log=%
call %cmdfile% 1> %logfile% 2>&1
