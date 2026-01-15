# 检查Node.js是否已安装
try {
    node --version
    Write-Output "Node.js is already installed"
    exit 0
} catch {
    Write-Output "Node.js not found. Starting installation..."
}

# Download Node.js LTS installer
$installerUrl = "https://nodejs.org/dist/v20.11.0/node-v20.11.0-x64.msi"
$installerPath = "$env:TEMP\nodejs-installer.msi"

Write-Output "Downloading Node.js installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Install Node.js
Write-Output "Installing Node.js..."
Start-Process msiexec.exe -ArgumentList "/i $installerPath /qn /norestart" -Wait -NoNewWindow

# Cleanup
Remove-Item $installerPath

Write-Output "Node.js installation completed successfully!"
Write-Output "Please restart your terminal to use Node.js and npm."