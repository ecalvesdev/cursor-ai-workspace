<#
.SYNOPSIS
  Atualiza o workspace a partir do Git (se houver remoto) e reinstala no ~/.cursor.

.DESCRIPTION
  1) Backup
  2) git pull (se .git existir e houver tracking)
  3) validate
  4) install

.PARAMETER SkipPull
  Não executa git pull.

.PARAMETER SkipInstall
  Apenas atualiza o clone; não copia para ~/.cursor.
#>
[CmdletBinding()]
param(
    [switch]$SkipPull,
    [switch]$SkipInstall
)

. (Join-Path $PSScriptRoot "_common.ps1")

$root = Get-WorkspaceRoot
Set-Location -LiteralPath $root

Write-Step "Update em $root"

& (Join-Path $PSScriptRoot "backup.ps1") -Label "pre-update"
if ($LASTEXITCODE -ne 0) {
    throw "Backup pré-update falhou."
}

if (-not $SkipPull) {
    $gitDir = Join-Path $root ".git"
    if (Test-Path -LiteralPath $gitDir) {
        $branch = (git rev-parse --abbrev-ref HEAD 2>$null)
        $upstream = (git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>$null)
        if ($LASTEXITCODE -eq 0 -and $upstream) {
            Write-Step "git pull --ff-only ($branch <- $upstream)"
            git pull --ff-only
            if ($LASTEXITCODE -ne 0) {
                throw "git pull falhou. Resolva o remoto manualmente."
            }
        }
        else {
            Write-Step "Sem upstream configurado — pull ignorado."
        }
    }
    else {
        Write-Step "Repositório sem .git — pull ignorado."
    }
}

& (Join-Path $PSScriptRoot "validate.ps1")
if ($LASTEXITCODE -ne 0) {
    throw "Validação pós-update falhou."
}

if (-not $SkipInstall) {
    & (Join-Path $PSScriptRoot "install.ps1") -SkipBackup
    exit $LASTEXITCODE
}

Write-Step "Update concluído (install ignorado)."
exit 0
