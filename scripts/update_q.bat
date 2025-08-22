@echo off
setlocal enabledelayedexpansion

set "downloads=%USERPROFILE%\Downloads"

echo Downloading latest Q CLI release...
curl -s https://api.github.com/repos/DiscreteTom/amazon-q-developer-cli-for-windows/releases/latest > "%downloads%\latest.json"
if %errorlevel% neq 0 (
    echo Failed to download release info
    pause
    exit /b 1
)

echo Latest release info:
type "%downloads%\latest.json"
echo.
echo Found download URLs:
findstr "browser_download_url" "%downloads%\latest.json"
echo.

for /f "tokens=2 delims= " %%a in ('findstr "browser_download_url" "%downloads%\latest.json"') do (
    set "url=%%a"
    set "url=!url:"=!"
    set "url=!url:,=!"
    echo Selected download URL: !url!
    for %%f in ("!url!") do set "filename=%%~nxf"
    echo Archive filename: !filename!
    goto :download
)

echo No download URL found
pause
exit /b 1

:download
echo Downloading from !url!
echo Download location: %downloads%\!filename!
curl -L -o "%downloads%\!filename!" "!url!"
if %errorlevel% neq 0 (
    echo Failed to download file
    pause
    exit /b 1
)

echo Extracting...
powershell -command "Expand-Archive -Path '%downloads%\!filename!' -DestinationPath '%downloads%' -Force"
if %errorlevel% neq 0 (
    echo Failed to extract file
    pause
    exit /b 1
)

echo Updating q.exe...
move q.exe q.exe.bak 2>nul
move "%downloads%\q.exe" q.exe
if %errorlevel% neq 0 (
    echo Failed to update q.exe
    pause
    exit /b 1
)

echo Cleaning up...
del "%downloads%\latest.json"
del "%downloads%\!filename!"
del q.exe.bak 2>nul

echo Update successful! Current version:
q --version

pause
