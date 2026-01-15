@echo off

REM Set temporary directory
set NODEJS_TEMP_DIR=%temp%\nodejs_temp
mkdir %NODEJS_TEMP_DIR% 2>nul

REM Download Node.js installer
set NODEJS_VERSION=20.11.0
echo Downloading Node.js v%NODEJS_VERSION%...

powershell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.11.0/node-v20.11.0-x64.msi' -OutFile '%NODEJS_TEMP_DIR%\nodejs_installer.msi'"

if not exist "%NODEJS_TEMP_DIR%\nodejs_installer.msi" (
    echo ERROR: Failed to download Node.js installer!
    echo Please manually download from https://nodejs.org/en/download/
    pause
    exit /b 1
)

echo Node.js installer downloaded successfully.

echo Running Node.js installer...
start /wait msiexec /i "%NODEJS_TEMP_DIR%\nodejs_installer.msi" /qb ADDLOCAL="NodeRuntime, npm"

if %errorlevel% neq 0 (
    echo ERROR: Node.js installation failed!
    echo Please manually run the installer at %NODEJS_TEMP_DIR%\nodejs_installer.msi
    pause
    exit /b 1
)

echo Node.js installed successfully!

echo.
echo Installation complete!