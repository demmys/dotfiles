[CmdletBinding()]
param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

function Ensure-Directory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        Write-Host "Creating directory: $Path"
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function New-SafeSymbolicLink {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination
    )

    if (-not (Test-Path -LiteralPath $Source)) {
        throw "Source path not found: $Source"
    }

    $destinationParent = Split-Path -Parent $Destination
    if ($destinationParent) {
        Ensure-Directory -Path $destinationParent
    }

    if (Test-Path -LiteralPath $Destination) {
        $existingItem = Get-Item -LiteralPath $Destination -Force
        $isSymlink = ($existingItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0

        if ($isSymlink) {
            try {
                $existingTarget = (Get-Item -LiteralPath $Destination -Force).Target
            } catch {
                $existingTarget = $null
            }

            $resolvedSource = (Resolve-Path -LiteralPath $Source).ProviderPath
            if ($existingTarget) {
                try {
                    $resolvedTarget = (Resolve-Path -LiteralPath $existingTarget).ProviderPath
                } catch {
                    $resolvedTarget = $existingTarget
                }
            } else {
                $resolvedTarget = $existingTarget
            }

            if ($resolvedSource -eq $resolvedTarget) {
                Write-Host "Skipping existing link: $Destination"
                return
            }
        }

        if (-not $Force) {
            throw "Destination already exists and differs: $Destination. Re-run with -Force to replace it."
        }

        Write-Host "Removing existing item: $Destination"
        if ($existingItem.PSIsContainer -and -not $isSymlink) {
            Remove-Item -LiteralPath $Destination -Recurse -Force
        } else {
            Remove-Item -LiteralPath $Destination -Force
        }
    }

    Write-Host "Linking $Destination -> $Source"
    New-Item -ItemType SymbolicLink -Path $Destination -Target $Source | Out-Null
}

$repoRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
$nvimConfigDir = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'nvim'
$nvimRcDir = Join-Path -Path $nvimConfigDir -ChildPath 'rc'

Ensure-Directory -Path $nvimConfigDir
Ensure-Directory -Path $nvimRcDir

$links = @(
    @{
        Source = Join-Path -Path $repoRoot -ChildPath 'init.vim'
        Destination = Join-Path -Path $nvimConfigDir -ChildPath 'init.vim'
    },
    @{
        Source = Join-Path -Path $repoRoot -ChildPath 'dein.toml'
        Destination = Join-Path -Path $nvimRcDir -ChildPath 'dein.toml'
    },
    @{
        Source = Join-Path -Path $repoRoot -ChildPath 'dein_lazy.toml'
        Destination = Join-Path -Path $nvimRcDir -ChildPath 'dein_lazy.toml'
    },
    @{
        Source = Join-Path -Path $repoRoot -ChildPath '.wezterm.lua'
        Destination = Join-Path -Path $HOME -ChildPath '.wezterm.lua'
    }
)

foreach ($link in $links) {
    New-SafeSymbolicLink -Source $link.Source -Destination $link.Destination
}

Write-Host 'Windows dotfiles installation complete.'
Write-Host 'Next steps:'
Write-Host '  - Launch Neovim to ensure dein installs plugins.'
Write-Host '  - Restart WezTerm to load the new configuration.'
