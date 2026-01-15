@echo off
cls

echo 笔趣阁小说阅读桌面应用
======================

echo 检查Node.js环境...
node --version >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo 错误：未找到Node.js
    echo 请按照安装指南先安装Node.js：
    echo 1. 访问 https://nodejs.org/zh-cn/ 下载LTS版本
    echo 2. 安装完成后重启命令提示符
    echo 3. 再次运行此脚本
    pause
    exit /b 1
)

npm --version >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo 错误：未找到npm
    echo 请重新安装Node.js，确保包含npm组件
    pause
    exit /b 1
)

node --version
npm --version

echo

echo 安装项目依赖...
npm install
if %ERRORLEVEL% neq 0 (
    echo 依赖安装失败
    pause
    exit /b 1
)

echo

echo 启动应用...
npm start

pause