# 快速启动脚本 - 使用免安装版Node.js

Write-Output "正在准备Node.js环境..."

# 设置临时目录
$tempDir = Join-Path $env:TEMP "NodeJSTemp"
if (-not (Test-Path $tempDir)) {
    New-Item -Path $tempDir -ItemType Directory | Out-Null
}

# Node.js下载链接 (免安装版)
$nodeDownloadUrl = "https://nodejs.org/dist/v20.11.0/node-v20.11.0-win-x64.zip"
$nodeZipPath = Join-Path $tempDir "node.zip"
$nodeExtractPath = Join-Path $tempDir "node"

# 下载Node.js
if (-not (Test-Path $nodeExtractPath)) {
    Write-Output "正在下载Node.js..."
    Invoke-WebRequest -Uri $nodeDownloadUrl -OutFile $nodeZipPath
    
    # 解压
    Write-Output "正在解压Node.js..."
    Expand-Archive -Path $nodeZipPath -DestinationPath $tempDir
    
    # 获取解压后的文件夹名
    $extractedFolder = Get-ChildItem -Path $tempDir -Directory | Where-Object { $_.Name -like "node-*" } | Select-Object -First 1
    if ($extractedFolder) {
        Move-Item -Path $extractedFolder.FullName -Destination $nodeExtractPath
    }
}

# 设置Node.js路径到环境变量
$nodeExePath = Join-Path $nodeExtractPath "bin"
$env:Path = "$nodeExePath;$env:Path"

# 验证Node.js和npm
Write-Output "Node.js版本: $(node --version)"
Write-Output "npm版本: $(npm --version)"

# 安装项目依赖
Write-Output "正在安装项目依赖..."
npm install

# 启动应用
Write-Output "正在启动应用..."
npm start

# 清理（可选）
# Write-Output "正在清理临时文件..."
# Remove-Item -Path $tempDir -Recurse -Force