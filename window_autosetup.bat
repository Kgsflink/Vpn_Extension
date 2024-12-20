@echo off
REM Set up the directory and files for the setup in C:\

set DOWNLOAD_URL=https://github.com/Kgsflink/Vpn_Extension/raw/main/IET_VPN.zip
set DOWNLOAD_DIR=C:\IET_VPN
set ZIP_FILE=IET_VPN.zip
set EXTRACT_DIR=C:\IET_VPN

echo Downloading IET_VPN.zip from GitHub...

REM Download the ZIP file using PowerShell
powershell -Command "Invoke-WebRequest -Uri %DOWNLOAD_URL% -OutFile %DOWNLOAD_DIR%\%ZIP_FILE%"

REM Check if the download was successful
if exist "%DOWNLOAD_DIR%\%ZIP_FILE%" (
    echo Download successful.
) else (
    echo Download failed. Exiting.
    exit /b
)

echo Extracting %ZIP_FILE% to %EXTRACT_DIR%...

REM Create the directory if it doesn't exist
if not exist "%EXTRACT_DIR%" (
    mkdir "%EXTRACT_DIR%"
)

REM Unzip the downloaded file using PowerShell
powershell -Command "Expand-Archive -Path %DOWNLOAD_DIR%\%ZIP_FILE% -DestinationPath %EXTRACT_DIR%"

REM Check if the extraction was successful
if exist "%EXTRACT_DIR%" (
    echo Extraction successful.
) else (
    echo Extraction failed. Exiting.
    exit /b
)

REM Set environment variables to run Tor from CMD
echo Setting PATH environment variable for Tor...

setx PATH "%PATH%;C:\IET_VPN\Tor\Browser\TorBrowser"

REM Check if the PATH variable was updated successfully
echo PATH updated. New PATH: %PATH%

echo Setup complete. Your IET_VPN has been downloaded, extracted to %EXTRACT_DIR%, and Tor is now available from the Command Prompt.

pause
