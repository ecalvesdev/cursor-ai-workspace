<#
.SYNOPSIS
  Instala agents, skills e rules deste repositório em ~/.cursor.

.DESCRIPTION
  Sempre cria backup antes de copiar.
  Não toca em ~/.cursor/skills-cursor.
  Não altera User Rules da conta Cursor (Customize → Rules).
  Por padrão faz merge: adiciona/atualiza itens do repo sem apagar skills extras já existentes.

.PARAMETER WhatIf
  Mostra o plano sem copiar.

.PARAMETER ReplaceManaged
  Substitui apenas os nomes presentes neste repositório (não apaga skills/agents extras).
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$SkipBackup,
    [switch]$ReplaceManaged
)

. (Join-Path $PSScriptRoot "_common.ps1")

$root = Get-WorkspaceRoot
$targets = Get-CursorTargets

Write-Step "Repo: $root"
Write-Step "Destino: $($targets.Home)"

# Validação prévia do repo
& (Join-Path $PSScriptRoot "validate.ps1")
if ($LASTEXITCODE -ne 0) {
    throw "Validação do repositório falhou. Abortando install."
}

if (-not $SkipBackup) {
    Write-Step "Criando backup pré-install..."
    & (Join-Path $PSScriptRoot "backup.ps1") -Label "pre-install"
    if ($LASTEXITCODE -ne 0) {
        throw "Backup falhou. Abortando install."
    }
}

New-DirectoryIfMissing -Path $targets.Agents
New-DirectoryIfMissing -Path $targets.Skills
New-DirectoryIfMissing -Path $targets.Rules

# Skills
$repoSkills = Join-Path $root "skills"
foreach ($skill in @(Get-SkillNames -SkillsRoot $repoSkills)) {
    $source = Join-Path $repoSkills $skill
    $dest = Join-Path $targets.Skills $skill
    if (-not (Test-SkillLayout -SkillPath $source)) {
        throw "Skill inválida no repo: $skill"
    }
    if ($PSCmdlet.ShouldProcess($dest, "Instalar skill $skill")) {
        if (Test-Path -LiteralPath $dest) {
            Remove-Item -LiteralPath $dest -Recurse -Force
        }
        Copy-Item -LiteralPath $source -Destination $dest -Recurse -Force
        Write-Step "Skill instalada: $skill"
    }
}

# Agents (.md)
$repoAgents = Join-Path $root "agents"
$agentFiles = @()
if (Test-Path -LiteralPath $repoAgents) {
    $agentFiles = @(Get-ChildItem -LiteralPath $repoAgents -File -Filter "*.md")
}
foreach ($file in $agentFiles) {
    if (-not (Test-AgentLayout -AgentPath $file.FullName)) {
        throw "Agente inválido no repo: $($file.Name)"
    }
    $dest = Join-Path $targets.Agents $file.Name
    if ($PSCmdlet.ShouldProcess($dest, "Instalar agente $($file.BaseName)")) {
        Copy-Item -LiteralPath $file.FullName -Destination $dest -Force
        Write-Step "Agente instalado: $($file.Name)"
    }
}

# Rules (.mdc ou .md) — só se existirem no repo
$repoRules = Join-Path $root "rules"
if (Test-Path -LiteralPath $repoRules) {
    $ruleFiles = @(Get-ChildItem -LiteralPath $repoRules -File | Where-Object { $_.Extension -in ".md", ".mdc" })
    foreach ($file in $ruleFiles) {
        $dest = Join-Path $targets.Rules $file.Name
        if ($PSCmdlet.ShouldProcess($dest, "Instalar rule $($file.Name)")) {
            New-DirectoryIfMissing -Path $targets.Rules
            Copy-Item -LiteralPath $file.FullName -Destination $dest -Force
            Write-Step "Rule instalada: $($file.Name)"
        }
    }
}

if ($ReplaceManaged) {
    Write-Step "ReplaceManaged: apenas itens do repo foram sobrescritos; extras locais preservados."
}

Write-Step "Install concluído."
Write-Step "Reinicie o Cursor ou abra um novo Agent chat para recarregar skills/agents."
& (Join-Path $PSScriptRoot "validate.ps1") -CheckInstalled
exit $LASTEXITCODE
