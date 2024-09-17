# Ensure PowerShell is running as Administrator

# Function to check if a command exists
function Test-Command {
    param (
        [string]$command
    )
    return Get-Command $command -ErrorAction SilentlyContinue
}

# Enable WSL and Virtual Machine Platform features
Write-Output "Enabling WSL and Virtual Machine Platform features..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

# Set WSL2 as the default version
Write-Output "Setting WSL2 as the default version..."
wsl --set-default-version 2

# Install Ubuntu from the Microsoft Store
Write-Output "Installing Ubuntu from the Microsoft Store..."
Start-Process "ms-windows-store://pdp/?productid=9NBLGGH4MSV6" -Wait

# Install Docker Desktop
Write-Output "Downloading Docker Desktop..."
$dockerDesktopUrl = "https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe"
$dockerInstaller = "$env:TEMP\DockerDesktopInstaller.exe"
Invoke-WebRequest -Uri $dockerDesktopUrl -OutFile $dockerInstaller

Write-Output "Installing Docker Desktop..."
Start-Process -FilePath $dockerInstaller -Wait

# Cleanup
Remove-Item -Path $dockerInstaller -Force

# Inform the user
Write-Output "Installation complete. Please reboot your system to ensure all changes take effect."

# Optional: Provide instructions for post-installation
Write-Output "After rebooting, please set up Docker Desktop and configure WSL2 if needed."
