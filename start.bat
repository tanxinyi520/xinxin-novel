@echo off

REM 检查Node.js是否已安装
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未检测到Node.js。请先安装Node.js（v14.0.0或更高版本）。
    echo 访问 https://nodejs.org/ 下载安装。
    pause
    exit /b 1
)

REM 检查npm是否已安装
npm -v >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未检测到npm。请先安装npm。
    pause
    exit /b 1
)

REM 显示菜单
:menu
cls
color 0a
echo. =====================================================
echo.                笔趣阁桌面版 - 启动工具
 echo. =====================================================
echo.
echo. 1. 安装依赖
 echo. 2. 启动开发模式
 echo. 3. 构建Windows应用
 echo. 4. 退出
 echo.
set /p choice= 请选择操作 [1-4]: 

echo.

if %choice% equ 1 (
    echo 正在安装依赖...
    npm install
    if %errorlevel% neq 0 (
        echo 安装依赖失败！
        pause
        goto menu
    )
    echo 依赖安装成功！
    pause
    goto menu
)

if %choice% equ 2 (
    echo 正在启动开发模式...
    npm start
    pause
    goto menu
)

if %choice% equ 3 (
    echo 正在构建Windows应用...
    npm run package
    if %errorlevel% neq 0 (
        echo 构建失败！
        pause
        goto menu
    )
    echo 构建成功！应用已保存到 dist 目录
    pause
    goto menu
)

if %choice% equ 4 (
    echo 感谢使用笔趣阁桌面版！
    exit /b 0
)

REM 无效选择
color 0c
echo 无效的选择，请重新输入。
pause
goto menu