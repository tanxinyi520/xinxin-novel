# Simple Node.js Installer

# Check if Node.js is already installed
try {
    $nodeVersion = & node --version 2>$null
    if ($nodeVersion) {
        Write-Output "Node.js is already installed: $nodeVersion"
        exit 0
    }
} catch {
    # Node.js is not installed
}

Write-Output "Node.js not found. Starting installation..."

# Download Node.js LTS installer
$installerUrl = "https://nodejs.org/dist/v20.11.0/node-v20.11.0-x64.msi"
$installerPath = Join-Path $env:TEMP "nodejs-installer.msi"

Write-Output "Downloading Node.js installer from $installerUrl..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Install Node.js
Write-Output "Installing Node.js..."
Start-Process msiexec.exe -ArgumentList "/i", "`"$installerPath`"", "/qn", "/norestart" -Wait -NoNewWindow

# Cleanup
Remove-Item -Path $installerPath -Force

Write-Output "Node.js installation completed successfully!"
Write-Output "Please restart your terminal to use Node.js and npm."