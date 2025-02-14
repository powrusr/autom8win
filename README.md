# autom8win
pip install virtualenvwrapper-win
workon
Get-Command python


## create a profile (to put your functions in)

- view [functions file](Microsoft.PowerShell_profile.ps1)

```powershell
function Ensure-PowerShellProfile {
    if (-not (Test-Path $PROFILE)) {
        # Create the profile
        New-Item -Path $PROFILE -ItemType File -Force
        Write-Host "PowerShell profile created at: $PROFILE"
    } else {
        Write-Host "PowerShell profile already exists at: $PROFILE"
    }

    # Open the profile in Notepad
    notepad $PROFILE
}
```
```cmd
Ensure-PowerShellProfile
```

## give your user execution rights


```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
```

as function

```powershell
function Ensure-ExecutionPolicy {
    # Get the current execution policy for the current user
    $currentPolicy = Get-ExecutionPolicy -Scope CurrentUser

    Write-Host "Current User Execution Policy: $currentPolicy"

    # Check if the policy is not set to RemoteSigned
    if ($currentPolicy -ne 'RemoteSigned') {
        # Set the execution policy to RemoteSigned
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Write-Host "Execution policy set to RemoteSigned for the current user."
    } else {
        Write-Host "Execution policy is already set to RemoteSigned."
    }
}

```

## creating a repo and commit

```powershell
Install-Chocolatey                                                                                                                                                                                                                               
Install-Git
Install-GH                                                                                                                     
Reload-Path
gh auth login
```
```powershell
PS C:\Users\User\github\autom8win> gh.exe auth login
? Where do you use GitHub? GitHub.com
? What is your preferred protocol for Git operations on this host? SSH
? Upload your SSH public key to your GitHub account? C:\Users\User\.ssh\powrusr_github.pub
? Title for your SSH key: (GitHub CLI) PowrUsr gh

? Title for your SSH key: PowrUsr gh
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: 4378-942E
Press Enter to open github.com in your browser...
✓ Authentication complete.
- gh config set -h github.com git_protocol ssh
✓ Configured git protocol
✓ SSH key already existed on your GitHub account: C:\Users\User\.ssh\powrusr_github.pub
✓ Logged in as powrusr
PS C:\Users\User\github\autom8win>
```


