@echo off

cls
echo ===================================================
echo          Biquge Novel App - Quick Start Guide
echo ===================================================
echo.

echo IMPORTANT NOTES:
echo 1. Please make sure you checked the "Add to PATH" option during Node.js installation (as shown in the screenshot)
echo 2. If you just installed Node.js, please close all command prompt windows first and then reopen

echo Press any key to check Node.js installation status...
pause >nul
echo.

echo Checking if Node.js and npm are properly installed...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js not detected. Please reinstall and make sure to check the "Add to PATH" option.
    echo Installer location: C:\Users\谭心怡\AppData\Local\Temp\nodejs_temp\nodejs_installer.msi
    echo After installation, please run this script again.
    pause
    exit /b 1
)

echo Node.js is successfully installed!
node --version
npm --version
echo.

echo Installing project dependencies (this may take a few minutes)...
npm install
if %errorlevel% neq 0 (
    echo ERROR: Dependency installation failed. Please check your network connection and try again.
    pause
    exit /b 1
)

echo Dependencies installed successfully, starting the application...
npm start

pause