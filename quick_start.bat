@echo off

cls
echo ===================================================
echo           笔趣阁小说应用 - 快速启动指南
echo ===================================================
echo.

echo 重要提示：
echo 1. 请确保您在Node.js安装过程中勾选了"Add to PATH"选项（如截图所示）
echo 2. 如果您刚安装完Node.js，请先关闭所有命令提示符窗口，然后重新打开
echo.

echo 请按任意键继续检查Node.js安装状态...
pause >nul
echo.

echo 正在检查Node.js和npm是否已正确安装...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：未检测到Node.js，请重新安装并确保勾选"Add to PATH"选项。
    echo 安装包位置：C:\Users\谭心怡\AppData\Local\Temp\nodejs_temp\nodejs_installer.msi
    echo 完成安装后，请重新运行此脚本。
    pause
    exit /b 1
)

echo Node.js已成功安装！
node --version
npm --version
echo.

echo 正在安装项目依赖（这可能需要几分钟时间）...
npm install
if %errorlevel% neq 0 (
    echo 错误：依赖安装失败，请检查网络连接并重试。
    pause
    exit /b 1
)

echo 依赖安装完成，正在启动应用...
npm start

pause