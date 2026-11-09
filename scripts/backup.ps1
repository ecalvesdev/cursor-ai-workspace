<#
.SYNOPSIS
  Cria backup local de agents, skills e rules do Cursor (~/.cursor).

.DESCRIPTION
  Não altera a configuração ativa. Grava em ~/.cursor/backups/<rótulo>-<timestamp>.
#>
[CmdletBinding()]
param(
    [string]$Label = "manual"
)

. (Join-Path $PSScriptRoot "_common.ps1")

$targets = Get-CursorTargets
New-DirectoryIfMissing -Path $targets.Backups

$stamp = Get-Timestamp
$safeLabel = ($Label -replace '[^a-zA-Z0-9_-]', '-').Trim('-')
if ([string]::IsNullOrWhiteSpace($safeLabel)) {
    $safeLabel = "manual"
}

$dest = Join-Path $targets.Backups ("{0}-{1}" -f $safeLabel, $stamp)
New-DirectoryIfMissing -Path $dest

Write-Step "Backup em $dest"

foreach ($name in @("agents", "skills", "rules")) {
    $source = Join-Path $targets.Home $name
    if (Test-Path -LiteralPath $source) {
        Copy-Item -LiteralPath $source -Destination (Join-Path $dest $name) -Recurse -Force
        Write-Step "Copiado: $name"
    }
    else {
        Write-Step "Ausente (ok): $name"
    }
}

$mcp = Join-Path $targets.Home "mcp.json"
if (Test-Path -LiteralPath $mcp) {
    Copy-Item -LiteralPath $mcp -Destination (Join-Path $dest "mcp.json") -Force
    Write-Step "Copiado: mcp.json"
}

Write-Output $dest
exit 0
