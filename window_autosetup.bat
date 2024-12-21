@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Define the download URL and output location
set TOR_URL=https://github.com/Kgsflink/Vpn_Extension/raw/main/tor.exe
set DOWNLOAD_DIR=C:\Tor
set TOR_PATH=%DOWNLOAD_DIR%\tor.exe

:: Create the download directory if it doesn't exist
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

:: Download Tor executable using PowerShell (Windows native)
echo Downloading Tor...
powershell -Command "Invoke-WebRequest -Uri %TOR_URL% -OutFile %TOR_PATH%"

:: Check if the download was successful
if exist "%TOR_PATH%" (
    echo Tor downloaded successfully.
) else (
    echo Failed to download Tor.
    exit /b 1
)

:: Add Tor to system path (for this session only)
setx PATH "%PATH%;%DOWNLOAD_DIR%"

:: Confirm if Tor is now in the path
echo Testing if Tor is in the path...
where tor.exe > nul
if %errorlevel% == 0 (
    echo Tor is now accessible from cmd.
) else (
    echo Error: Tor is not in the path.
    exit /b 1
)

:: Check if Tor is running or not
echo Checking if Tor is running...
tasklist /FI "IMAGENAME eq tor.exe" 2>NUL | find /I "tor.exe" > NUL
if %ERRORLEVEL% == 0 (
    echo Tor is already running.
) else (
    echo Tor is not running. Starting Tor...
    start "" "%TOR_PATH%"
)

:: Inform user to run the VPN extension
echo Tor is running and set up. You can now use your VPN extension.
pause
