function Add-SSHKey-PowrUsr {
    param (
        [string]$KeyPath = "$HOME\.ssh\powrusr_github"
    )

    if (Test-Path $KeyPath) {
        # Start the SSH agent
        Start-Service ssh-agent

        # Add the SSH key
        ssh-add $KeyPath
        Write-Host "SSH key added to the agent: $KeyPath"
    } else {
        Write-Host "Key not found: $KeyPath"
    }
}


function Install-GH {
    # Check if Chocolatey is installed
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is not installed. Installing Chocolatey..."
        Install-Chocolatey
    }

    # Install GitHub CLI using Chocolatey
    Write-Host "Installing GitHub CLI..."
    choco install gh -y

    # Check if gh is added to PATH
    $ghPath = "C:\ProgramData\chocolatey\bin"
    if (-not ($env:Path -contains $ghPath)) {
        $env:Path += ";$ghPath"

        # Optionally, add it to the user's PATH permanently
        $currentUserPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
        if (-not ($currentUserPath -contains $ghPath)) {
            [System.Environment]::SetEnvironmentVariable("Path", "$currentUserPath;$ghPath", [System.EnvironmentVariableTarget]::User)
        }

        Write-Host "GitHub CLI installed and added to PATH. Please restart your PowerShell for changes to take effect."
    } else {
        Write-Host "GitHub CLI is already installed and is in your PATH."
    }
}


function Install-Chocolatey {
    # Check if Chocolatey is already installed
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        # Set execution policy
        Set-ExecutionPolicy Bypass -Scope Process -Force

        # Install Chocolatey
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        # Add Chocolatey to PATH
        $chocoPath = "C:\ProgramData\chocolatey\bin"
        $env:Path += ";$chocoPath"

        # Optionally, add it to the user's PATH permanently
        $currentUserPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
        if (-not ($currentUserPath -contains $chocoPath)) {
            [System.Environment]::SetEnvironmentVariable("Path", "$currentUserPath;$chocoPath", [System.EnvironmentVariableTarget]::User)
        }

        Write-Host "Chocolatey installed and added to PATH. Please restart your PowerShell for changes to take effect."
    } else {
        Write-Host "Chocolatey is already installed."
    }
}


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


function Reload-Path {
    # Get both user and system PATH variables
    $userPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
    $systemPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

    # Combine both paths
    $env:Path = "$userPath;$systemPath;$env:Path"

    Write-Host "PATH variable reloaded for the current session."
}

