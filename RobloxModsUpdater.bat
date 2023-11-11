:SETUP
setlocal EnableExtensions
@echo off
cls
set RETURN=:MAINMENU
set SingleSelection=""
set MultiSelection=""
goto :DETECT

:DETECT
rem cd /d %LOCALAPPDATA%\Roblox\Versions
rem for /f "delims=" %%i in ('dir /b /ad-h /t:c /od') do set a=%%i
rem echo Most recent subfolder: %a%
for /f "tokens=3" %%i in ('reg query "HKEY_CURRENT_USER\SOFTWARE\ROBLOX Corporation\Environments\roblox-player" /v version ^| find "version"') do set version=%%i
copy /y .\jq.exe %TEMP%\jq.exe
mkdir %LOCALAPPDATA%\Roblox\Versions\backup\
mkdir %LOCALAPPDATA%\Roblox\Versions\RMUtmp\
cd /d %LOCALAPPDATA%\Roblox\Versions\%version%
del /r /q %LOCALAPPDATA%\Roblox\Versions\RMUtmp\*
copy /y %TEMP%\jq.exe %LOCALAPPDATA%\Roblox\Versions\RMUtmp\jq.exe
rem dir

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
TIMEOUT /T -1
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
TITLE Install Section
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
set LINKOOF=curl "http://aasweb.epizy.com/download.php?file=ouch.ogg&i=1" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/119.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" -H "Accept-Language: es-MX,es;q=0.8,en-US;q=0.5,en;q=0.3" -H "Accept-Encoding: gzip, deflate, br" -H "DNT: 1" -H "Connection: keep-alive" -H "Referer: https://aasweb.epizy.com/download.php?file=ouch.ogg" -H "Cookie: __test=6b240188fb39e37b60774609b74dd197" -H "Upgrade-Insecure-Requests: 1" -H "Sec-Fetch-Dest: document" -H "Sec-Fetch-Mode: navigate" -H "Sec-Fetch-Site: same-origin" -H "TE: trailers" --output ..\RMUtmp\ouch.ogg

cls
title (1/3) [DOWNLOAD] Installing the OG Oof sound
echo Step (1/3)
echo Downloading the sound...
del ..\RMUtmp\ouch.ogg
%LINKOOF%

cls
title (2/3) [BACKUP  ] Installing the OG Oof sound
echo Step (2/3)
echo Making a backup of the awful modern sound...
copy .\content\sounds\ouch.ogg ..\backup\ouch.ogg

cls
title (3/3) [INSTALL ] Installing the OG Oof sound
echo Step (3/3)
echo Installing the og oof sound...
copy /y ..\RMUtmp\ouch.ogg .\content\sounds\ouch.ogg
echo Done.
TIMEOUT /T -1
goto %RETURN%

:RBXFPSUNLOCKER_install
cls
title (1/3) [DOWNLOAD] rbxfpsunlocker
echo Step (1/3)
echo Downloading lastest RBXFPSUNLOCKER zip
echo Since this one does "nasty" stuff to unlock the fps
echo your antivirus may get mad about it.
echo Press a key when ready.
mkdir ..\RMUtmp\fpsunlock\
TIMEOUT /T -1

REM GitHub repository URL of rbxfpsunlocker
set repo_url=https://api.github.com/repos/axstin/rbxfpsunlocker/releases/latest

REM Get the release information using the GitHub API
for /f "delims=" %%i in ('curl -s %repo_url% ^| ..\RMUtmp\jq -r ".assets[0].browser_download_url"') do set download_url=%%i

REM Extract the tag name for creating a directory
for /f "delims=" %%i in ('curl -s %repo_url% ^| ..\RMUtmp\jq -r ".tag_name"') do set tag_name=%%i

REM Download the zip file
echo %download_url%
curl -L %download_url% -o ..\RMUtmp\release.zip

cls
title (2/3) [EXTRACT ] rbxfpsunlocker
echo Step (2/3)
echo Extracting files
REM Unzip the contents
del /q ..\RMUtmp\fpsunlock\rbxfpsunlocker.exe
powershell Expand-Archive -Path ..\RMUtmp\release.zip -DestinationPath ..\RMUtmp\fpsunlock


REM Clean up the zip file
del /q ..\RMUtmp\release.zip
echo Downloaded and extracted the latest release to %tag_name% directory.

cls
title (3/3) [INSTALL ] rbxfpsunlocker
echo Step (2/3)
echo "Installing"(a.k.a adding to the startup)
dir ..\RMUtmp\fpsunlock\
copy /y ..\RMUtmp\fpsunlock\rbxfpsunlocker.exe "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\rbxfpsunlocker.exe"
echo Done.
TIMEOUT /T -1

rem goto %RETURN%

:END
endlocal