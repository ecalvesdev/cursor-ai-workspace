# Funções compartilhadas pelos scripts do cursor-ai-workspace.
# Compatível com Windows PowerShell 5.1+.

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-WorkspaceRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Get-CursorHome {
    return (Join-Path $env:USERPROFILE ".cursor")
}

function Get-CursorTargets {
    $cursorHome = Get-CursorHome
    return [pscustomobject]@{
        Home    = $cursorHome
        Agents  = Join-Path $cursorHome "agents"
        Skills  = Join-Path $cursorHome "skills"
        Rules   = Join-Path $cursorHome "rules"
        Backups = Join-Path $cursorHome "backups"
    }
}

function Write-Step {
    param([string]$Message)
    Write-Host "[cursor-ai-workspace] $Message"
}

function Assert-PathExists {
    param([string]$Path, [string]$Label)
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "$Label não encontrado: $Path"
    }
}

function New-DirectoryIfMissing {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Force -Path $Path | Out-Null
    }
}

function Get-Timestamp {
    return (Get-Date -Format "yyyyMMdd-HHmmss")
}

function Copy-Tree {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination
    )
    if (-not (Test-Path -LiteralPath $Source)) {
        return
    }
    New-DirectoryIfMissing -Path $Destination
    Copy-Item -LiteralPath $Source -Destination $Destination -Recurse -Force
}

function Get-SkillNames {
    param([string]$SkillsRoot)
    $names = @()
    if (Test-Path -LiteralPath $SkillsRoot) {
        Get-ChildItem -LiteralPath $SkillsRoot -Directory | ForEach-Object {
            $names += $_.Name
        }
    }
    return $names
}

function Test-SkillLayout {
    param([string]$SkillPath)
    $skillMd = Join-Path $SkillPath "SKILL.md"
    return (Test-Path -LiteralPath $skillMd)
}

function Test-AgentLayout {
    param([string]$AgentPath)
    if (-not (Test-Path -LiteralPath $AgentPath)) {
        return $false
    }
    $item = Get-Item -LiteralPath $AgentPath
    if ($item.PSIsContainer) {
        return $false
    }
    if ($item.Extension -ne ".md") {
        return $false
    }
    $raw = Get-Content -LiteralPath $AgentPath -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($raw)) {
        return $false
    }
    return $raw -match '(?ms)^---\s*.*?\bname\s*:.*?\bdescription\s*:.*?---'
}
