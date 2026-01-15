@echo off

REM 验证Node.js和npm安装
echo 正在验证Node.js和npm安装...
echo.

node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：Node.js未正确安装或未添加到PATH。
    echo 请重新安装Node.js并确保勾选"Add to PATH"选项。
    pause
    exit /b 1
) else (
    node --version
    npm --version
    echo Node.js和npm安装成功！
)
echo.

REM 安装项目依赖
echo 正在安装项目依赖...
npm install
if %errorlevel% neq 0 (
    echo 错误：项目依赖安装失败。
    echo 请检查网络连接并手动运行：npm install
    pause
    exit /b 1
)
echo 项目依赖安装成功！
echo.

REM 启动应用
echo 正在启动应用...
npm start
if %errorlevel% neq 0 (
    echo 错误：应用启动失败。
    echo 请手动运行：npm start
    pause
    exit /b 1
)

pause