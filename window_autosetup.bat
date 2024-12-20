@echo off
:: ----------------------------------------
:: VPN and Tor Auto Setup Script
:: Created by Krishna Gopal Sahani
:: ----------------------------------------

:: Set script parameters
setlocal enabledelayedexpansion
set VPN_ZIP_URL=https://github.com/Kgsflink/Vpn_Extension/raw/main/IET_VPN.zip
set INSTALL_DIR=C:\IET_VPN
set TOR_PATH=%INSTALL_DIR%\tor.exe

echo ====================================================
echo        🌐 IET VPN & Tor Auto Setup Script 🌐
echo ----------------------------------------------------
echo This script will:
echo 1️⃣ Download and install IET VPN and Tor
echo 2️⃣ Set up the environment PATH for Tor
echo 3️⃣ Load the IET VPN Chrome extension
echo ----------------------------------------------------
echo Please wait while we complete the setup...
echo ====================================================

:: Step 1️⃣ - Create Directory for IET VPN
echo.
echo 🛠️  Creating directory for IET VPN and Tor...
mkdir "%INSTALL_DIR%"
echo ✔️ Directory created successfully.
echo.

:: Step 2️⃣ - Download and Extract IET VPN ZIP
echo 🚀 Downloading IET VPN from GitHub...
cd /d "%INSTALL_DIR%"
bitsadmin /transfer "VPNDownload" %VPN_ZIP_URL% "%INSTALL_DIR%\IET_VPN.zip"
if exist "%INSTALL_DIR%\IET_VPN.zip" (
    echo ✔️ VPN Extension downloaded successfully.
) else (
    echo ❌ Failed to download the VPN extension. Please check your internet connection.
    pause
    exit /b
)

echo 📂 Extracting VPN extension files...
tar -xf "%INSTALL_DIR%\IET_VPN.zip" -C "%INSTALL_DIR%"
if exist "%INSTALL_DIR%\manifest.json" (
    echo ✔️ VPN Extension extracted successfully.
) else (
    echo ❌ Failed to extract VPN Extension files.
    pause
    exit /b
)

echo 🔥 Cleaning up temporary files...
del /q "%INSTALL_DIR%\IET_VPN.zip"
echo ✔️ Temporary files removed.
echo.

:: Step 3️⃣ - Set Environment Variable for Tor Path
echo 🛠️  Adding Tor to the system PATH environment variable...
setx PATH "%PATH%;%INSTALL_DIR%"
echo ✔️ Tor path added successfully.
echo.

:: Step 4️⃣ - Check if Tor is available
if exist "%TOR_PATH%" (
    echo ✔️ Tor executable found.
) else (
    echo ❌ Tor executable not found in %INSTALL_DIR%.
    pause
    exit /b
)

:: Step 5️⃣ - Check if Tor is running
echo 🔎 Checking if Tor is running...
tasklist /fi "imagename eq tor.exe" | find /i "tor.exe" >nul
if %errorlevel%==0 (
    echo ✔️ Tor is already running.
) else (
    echo ⚠️  Tor is not running. Starting Tor now...
    start "" "%TOR_PATH%"
    timeout /t 10 /nobreak
    tasklist /fi "imagename eq tor.exe" | find /i "tor.exe" >nul
    if %errorlevel%==0 (
        echo ✔️ Tor started successfully.
    ) else (
        echo ❌ Failed to start Tor. Please start it manually by running "tor" in cmd.
    )
)
echo.

:: Step 6️⃣ - Load the VPN Extension into Chrome
echo 🚀 Loading IET VPN Extension into Chrome...
set CHROME_COMMAND="chrome.exe --load-extension=%INSTALL_DIR%"
start "" %CHROME_COMMAND%
echo ✔️ Chrome started with IET VPN Extension loaded.
echo.

:: Display completion message
echo ====================================================
echo 🎉 Setup Complete!
echo ----------------------------------------------------
echo You can now use the IET VPN extension in Chrome.
echo Tor is installed and accessible from the command prompt.
echo To start Tor manually, just type 'tor' in cmd.
echo ----------------------------------------------------
echo 💡 If you encounter any issues, re-run this script.
echo ====================================================

pause
exit /b
