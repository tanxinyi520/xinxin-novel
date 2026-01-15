@echo off

REM Check if Node.js is installed
echo Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed.
    echo Please install Node.js first from https://nodejs.org/en/download/
    echo Make sure to check "Add to PATH" during installation.
    pause
    exit /b 1
)

REM Check if npm is installed
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: npm is not installed properly.
    echo Please reinstall Node.js.
    pause
    exit /b 1
)

REM Display versions
echo Node.js version: && node --version
echo npm version: && npm --version

REM Install dependencies
echo Installing project dependencies...
npm install

if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies.
    pause
    exit /b 1
)

REM Start application
echo Starting application...
npm start

if %errorlevel% neq 0 (
    echo ERROR: Failed to start application.
    pause
    exit /b 1
)