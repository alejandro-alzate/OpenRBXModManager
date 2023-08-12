:SETUP
setlocal EnableExtensions
@echo off
cls
set RETURN=:MAINMENU
set SingleSelection=""
set MultiSelection=""
goto :DETECT

:DETECT
cd /d %LOCALAPPDATA%\Roblox\Versions
for /f "delims=" %%i in ('dir /b /ad-h /t:c /od') do set a=%%i
echo Most recent subfolder: %a%

:SPLASH
title Roblox Quality Of life Additions Script
echo ***********************************************************
echo * Roblox Quality Of life Additions Script           - O X *
echo *---------------------------------------------------------*
echo * This is an free and open source project made by         *
echo * Alejandro Alzate at https://github.com/alejandro-alzate *
echo *                                                         *
echo * If you paid for this script STOP IT as you were scammed *
echo * And it could been maliciously infected.                 *
echo ***********************************************************
TIMEOUT /T 300
if %RETURN%=="" ( exit /b)
goto %RETURN%

:MAINMENU
cls
set SingleSelection=2
title Main Menu
echo Main Menu: What you want to do?
echo -----------------------------------------------------------
echo 1. Quit
echo 2. Install Additions (Default)
echo 3. Remove Additions (Not implemented yet)
set /p SingleSelection="Select an option: "

REM Check if the input is numeric
set "var="&for /f "delims=0123456789" %%i in ("%SingleSelection%") do set var=%%i
echo %var% %SingleSelection%
if not defined var (
	if %SingleSelection% == 1 ( goto :END     )
	if %SingleSelection% == 2 ( goto :INSTALL )
	if %SingleSelection% == 3 ( goto :REMOVE  )
)
goto :MAINMENU

:INSTALL
cls
set SingleSelection=1
title Install Section
echo Install Section:
echo ----------------------------------------------------------
echo 1. ^<-- Go back (default)
echo 2. Install the good 'ol Oof sound
echo 3. Install and configure Roblox FPS Unlocker
set /p SingleSelection="Select an option: "

REM Check if the input is numeric
SET "var="&for /f "delims=0123456789" %%i in ("%SingleSelection%") do set var=%%i
if not defined var (
	set RETURN=:INSTALL
	if %SingleSelection% == 1 ( goto :MAINMENU)
	if %SingleSelection% == 2 ( goto :OOF_install)
	if %SingleSelection% == 3 ( goto :RBXFPSUNLOCKER_install)
)
goto :MAINMENU

:OOF_install
cls
set LINKOOF=https://aasweb.epizy.com/static/ouch.ogg
title Installing the OG Oof sound

echo Step (1/3)
echo Downloading the sound...
powershell -c "Invoke-WebRequest -Uri '%LINKOOF%' -OutFile '%TEMP%\ouch.ogg'"
timeout /t 1 > nul

cls
echo Step (2/3)
echo Making a backup of the awful modern sound..

echo Installing the og oof sound...
goto %RETURN%

:RBXFPSUNLOCKER_install
goto %RETURN%

:END
endlocal