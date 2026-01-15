@echo off

REM 设置临时目录
set NODEJS_TEMP_DIR=%temp%\nodejs_temp
mkdir %NODEJS_TEMP_DIR% 2>nul

REM 下载Node.js安装包
set NODEJS_VERSION=20.11.0
set NODEJS_INSTALLER=%NODEJS_TEMP_DIR%\node-v%NODEJS_VERSION%-x64.msi

echo 正在下载Node.js v%NODEJS_VERSION%...
powershell -Command "Invoke-WebRequest -Uri https://nodejs.org/dist/v%NODEJS_VERSION%/node-v%NODEJS_VERSION%-x64.msi -OutFile %NODEJS_INSTALLER%"

if not exist %NODEJS_INSTALLER% (
    echo 错误：Node.js安装包下载失败！
    echo 请手动访问 https://nodejs.org/zh-cn/download/ 下载LTS版本
    pause
    exit /b 1
)

echo Node.js安装包下载成功，开始安装...
echo 安装时请确保勾选"Add to PATH"选项

echo 正在运行Node.js安装程序...
msiexec /i %NODEJS_INSTALLER% /qb

if %errorlevel% neq 0 (
    echo 错误：Node.js安装失败！
    echo 请手动运行%NODEJS_INSTALLER%进行安装
    pause
    exit /b 1
)

echo Node.js安装成功！正在验证安装...

REM 刷新环境变量
call "%windir%\System32\cmd.exe" /c "node --version >nul 2>&1"

if %errorlevel% neq 0 (
    echo 警告：Node.js可能已安装但环境变量未更新，请重新打开命令提示符后运行node --version验证
) else (
    echo 检测到Node.js版本：
    node --version
    echo 检测到npm版本：
    npm --version
)

echo.
echo 安装完成！请重新打开命令提示符并导航到项目目录，运行以下命令：
echo 1. cd h:\编程项目\小说软件\electron_app
echo 2. npm install （安装项目依赖）
echo 3. npm start （启动应用）

pause