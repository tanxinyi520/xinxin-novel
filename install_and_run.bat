@echo off

REM 检查Node.js是否安装
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：未检测到Node.js。请先手动安装Node.js。
    echo 安装步骤：
    echo 1. 访问 https://nodejs.org/zh-cn/download/ 下载LTS版本
    echo 2. 安装时确保勾选"Add to PATH"选项
    echo 3. 安装完成后重新打开命令提示符
    pause
    exit /b 1
)

REM 检查npm是否安装
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：npm未正确安装。请重新安装Node.js。
    pause
    exit /b 1
)

REM 显示Node.js和npm版本
echo 检测到Node.js版本：
node --version
echo 检测到npm版本：
npm --version

echo.
echo 开始安装项目依赖...
npm install

if %errorlevel% neq 0 (
    echo 错误：依赖安装失败。请检查网络连接或查看错误信息。
    pause
    exit /b 1
)

echo.
echo 依赖安装成功，开始启动应用...
npm start

if %errorlevel% neq 0 (
    echo 错误：应用启动失败。
    pause
    exit /b 1
)