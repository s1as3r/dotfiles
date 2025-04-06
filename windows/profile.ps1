# aliases and wrapper functions
Set-Alias py python
Set-Alias ipy ipython
Set-Alias v nvim
Set-Alias c cargo
Set-Alias po poetry
Set-Alias g git
Set-Alias ls lsd
Set-Alias grep rg
Set-Alias touch New-Item
Set-Alias x FPilot

function gic() { git commit @args }
function gis() { git status @args }
function gil() { git log --oneline --graph @args }

function vsenv() {
  Launch-VsDevShell.ps1 -Arch amd64 -SkipAutomaticLocation
}

function mcd($dir) {
  New-Item -ItemType Directory $dir
  Set-Location $dir
}

function dfu() { pwsh -c { Set-Location "~/.dotfiles" && git pull --ff-only && ./install.ps1 -q } }

# omp
$OMP_THEME = "$env:USERPROFILE\Documents\PowerShell\theme.omp.json" 
oh-my-posh init pwsh --config $OMP_THEME | Invoke-Expression

# vim keybindings
Set-PSReadLineOption -EditMode vi
$env:SHELL_VI_MODE = "I"
Set-PSReadlineOption -ViModeIndicator Script -ViModeChangeHandler {
        Param([string]$mode)
        $env:SHELL_VI_MODE = $mode[0]
        [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

# FZF
$env:FZF_DEFAULT_OPTS = '--height 70% --layout=reverse --border'
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Zoxide
$env:_ZO_ECHO = '1'
Invoke-Expression (& { (zoxide init powershell --cmd j | Out-String) })

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
