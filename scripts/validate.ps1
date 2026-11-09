<#
.SYNOPSIS
  Valida a estrutura do repositório cursor-ai-workspace e, opcionalmente, o destino ~/.cursor.

.PARAMETER CheckInstalled
  Também valida agents/skills/rules instalados no Cursor home.
#>
[CmdletBinding()]
param(
    [switch]$CheckInstalled
)

. (Join-Path $PSScriptRoot "_common.ps1")

$root = Get-WorkspaceRoot
$errors = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]

function Add-Err([string]$m) { [void]$errors.Add($m) }
function Add-Warn([string]$m) { [void]$warnings.Add($m) }

Write-Step "Validando repositório: $root"

foreach ($rel in @("agents", "skills", "rules", "scripts", "external-skills.json", ".gitignore", "README.md")) {
    $path = Join-Path $root $rel
    if (-not (Test-Path -LiteralPath $path)) {
        Add-Err "Falta item obrigatório: $rel"
    }
}

foreach ($script in @("backup.ps1", "install.ps1", "update.ps1", "validate.ps1", "_common.ps1")) {
    $path = Join-Path $root "scripts\$script"
    if (-not (Test-Path -LiteralPath $path)) {
        Add-Err "Script ausente: scripts\$script"
    }
}

# Skills versionadas
$skillsRoot = Join-Path $root "skills"
$skillNames = @(Get-SkillNames -SkillsRoot $skillsRoot)
if (@($skillNames).Count -eq 0) {
    Add-Warn "Nenhuma skill versionada em skills/ (esperado ao menos qa-audit na Fase 1)."
}
foreach ($name in $skillNames) {
    $skillPath = Join-Path $skillsRoot $name
    if (-not (Test-SkillLayout -SkillPath $skillPath)) {
        Add-Err "Skill inválida (falta SKILL.md): skills\$name"
    }
}

# Agents versionados (ignora .gitkeep)
$agentsRoot = Join-Path $root "agents"
$agentFiles = @()
if (Test-Path -LiteralPath $agentsRoot) {
    $agentFiles = @(Get-ChildItem -LiteralPath $agentsRoot -File -Filter "*.md")
}
foreach ($file in $agentFiles) {
    if (-not (Test-AgentLayout -AgentPath $file.FullName)) {
        Add-Err "Agente inválido (frontmatter name/description): agents\$($file.Name)"
    }
}

# Rules versionadas (.mdc / .md)
$rulesRoot = Join-Path $root "rules"
$ruleFiles = @()
if (Test-Path -LiteralPath $rulesRoot) {
    $ruleFiles = @(Get-ChildItem -LiteralPath $rulesRoot -File | Where-Object { $_.Extension -in ".md", ".mdc" })
}
foreach ($file in $ruleFiles) {
    $raw = Get-Content -LiteralPath $file.FullName -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($raw)) {
        Add-Err "Rule vazia: rules\$($file.Name)"
        continue
    }
    if ($file.Extension -eq ".mdc" -and $raw -notmatch '(?ms)^---\s*.*?---') {
        Add-Err "Rule .mdc sem frontmatter: rules\$($file.Name)"
    }
}

# Manifesto
$manifestPath = Join-Path $root "external-skills.json"
try {
    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    if (-not $manifest.skills) {
        Add-Err "external-skills.json sem array skills."
    }
}
catch {
    Add-Err "external-skills.json inválido: $($_.Exception.Message)"
}

# Proteção: não versionar skills-cursor
$forbidden = Join-Path $root "skills-cursor"
if (Test-Path -LiteralPath $forbidden) {
    Add-Err "Não versionar skills-cursor/ (diretório interno do Cursor)."
}

if ($CheckInstalled) {
    $targets = Get-CursorTargets
    Write-Step "Validando instalação em $($targets.Home)"
    if (-not (Test-Path -LiteralPath $targets.Home)) {
        Add-Err "Cursor home ausente: $($targets.Home)"
    }
    else {
        foreach ($name in $skillNames) {
            $installed = Join-Path $targets.Skills $name
            if (-not (Test-SkillLayout -SkillPath $installed)) {
                Add-Warn "Skill do repo não instalada/inválida em ~/.cursor/skills/$name"
            }
        }
        foreach ($file in $ruleFiles) {
            $installedRule = Join-Path $targets.Rules $file.Name
            if (-not (Test-Path -LiteralPath $installedRule)) {
                Add-Warn "Rule do repo não instalada em ~/.cursor/rules/$($file.Name)"
            }
        }
        if (Test-Path -LiteralPath (Join-Path $targets.Home "skills-cursor")) {
            Write-Step "skills-cursor presente (interno) — ok, não modificar."
        }

        $externalChecks = @(
            @{ Id = "tlc-spec-driven"; Path = (Join-Path $targets.Skills "tlc-spec-driven") },
            @{ Id = "grill-me"; Path = (Join-Path $env:USERPROFILE ".agents\skills\grill-me") },
            @{ Id = "grilling"; Path = (Join-Path $env:USERPROFILE ".agents\skills\grilling") }
        )
        foreach ($ext in $externalChecks) {
            if (-not (Test-SkillLayout -SkillPath $ext.Path)) {
                Add-Warn "Skill externa ausente/inválida: $($ext.Id) em $($ext.Path)"
            }
        }
    }
}

Write-Host ""
$skillCount = @($skillNames).Count
$agentCount = @($agentFiles).Count
$warnCount = @($warnings).Count
$errCount = @($errors).Count

$ruleCount = @($ruleFiles).Count

Write-Host "Resumo da validação"
Write-Host "  Skills versionadas: $skillCount ($($skillNames -join ', '))"
Write-Host "  Agents versionados: $agentCount"
Write-Host "  Rules versionadas: $ruleCount"
Write-Host "  Avisos: $warnCount"
Write-Host "  Erros: $errCount"

foreach ($w in $warnings) { Write-Host "  WARN: $w" -ForegroundColor Yellow }
foreach ($e in $errors) { Write-Host "  ERR:  $e" -ForegroundColor Red }

if ($errCount -gt 0) {
    exit 1
}

Write-Step "Validação OK."
exit 0
