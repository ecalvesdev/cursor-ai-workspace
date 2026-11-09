<#
.SYNOPSIS
  Homologação estrutural do cursor-ai-workspace (Fase 10).
#>
[CmdletBinding()]
param()

. (Join-Path $PSScriptRoot "_common.ps1")

$root = Get-WorkspaceRoot
$targets = Get-CursorTargets
$errors = New-Object System.Collections.Generic.List[string]
$pass = New-Object System.Collections.Generic.List[string]

function Ok([string]$m) { [void]$pass.Add($m); Write-Host "  PASS: $m" -ForegroundColor Green }
function Bad([string]$m) { [void]$errors.Add($m); Write-Host "  FAIL: $m" -ForegroundColor Red }

Write-Step "Homologação estrutural"

& (Join-Path $PSScriptRoot "validate.ps1") -CheckInstalled
if ($LASTEXITCODE -ne 0) {
    Bad "validate.ps1 falhou"
}
else {
    Ok "validate.ps1 -CheckInstalled"
}

$expectedAgents = @(
    "chefe",
    "architect",
    "backend-engineer",
    "frontend-engineer",
    "ui-ux-designer",
    "automation-engineer",
    "devops-engineer",
    "security-auditor",
    "qa-engineer"
)

foreach ($name in $expectedAgents) {
    $repoAgent = Join-Path $root "agents\$name.md"
    $installed = Join-Path $targets.Agents "$name.md"
    if (-not (Test-AgentLayout -AgentPath $repoAgent)) {
        Bad "Agent inválido no repo: $name"
        continue
    }
    if (-not (Test-AgentLayout -AgentPath $installed)) {
        Bad "Agent não instalado/inválido: $name"
        continue
    }
    Ok "Agent $name"
}

$expectedOwnSkills = @(
    "master-orchestration", "project-governance", "repository-discovery", "task-routing", "change-impact-analysis", "completion-report",
    "architecture-review", "data-modeling", "api-contracts",
    "backend-architecture", "api-development", "django-development", "python-clean-code", "database-optimization",
    "nextjs-development", "react-architecture", "javascript-typescript", "responsive-layout", "frontend-performance", "web-accessibility", "design-system",
    "browser-automation", "rpa-reliability",
    "docker-deployment", "ci-cd",
    "security-baseline", "lgpd-privacy-by-design", "encryption-key-management", "secure-session-cookies", "rate-limit-protection",
    "test-strategy", "e2e-testing", "qa-audit"
)

foreach ($name in $expectedOwnSkills) {
    $repoSkill = Join-Path $root "skills\$name"
    $installed = Join-Path $targets.Skills $name
    if (-not (Test-SkillLayout -SkillPath $repoSkill)) {
        Bad "Skill ausente/inválida no repo: $name"
        continue
    }
    if (-not (Test-SkillLayout -SkillPath $installed)) {
        Bad "Skill não instalada: $name"
        continue
    }
    Ok "Skill $name"
}

# Externas
if (Test-SkillLayout -SkillPath (Join-Path $targets.Skills "tlc-spec-driven")) { Ok "Externa tlc-spec-driven" } else { Bad "Externa tlc-spec-driven" }
if (Test-SkillLayout -SkillPath (Join-Path $env:USERPROFILE ".agents\skills\grill-me")) { Ok "Externa grill-me" } else { Bad "Externa grill-me" }
if (Test-SkillLayout -SkillPath (Join-Path $env:USERPROFILE ".agents\skills\grilling")) { Ok "Externa grilling" } else { Bad "Externa grilling" }

# Proteções
if (Test-Path (Join-Path $targets.Home "skills-cursor")) { Ok "skills-cursor preservado (não gerenciado pelo repo)" } else { Bad "skills-cursor ausente (inesperado)" }

Write-Host ""
Write-Host "Homologação: $($pass.Count) pass / $($errors.Count) fail"
if ($errors.Count -gt 0) {
    exit 1
}
Write-Step "Homologação estrutural OK. Testes de delegação/UI exigem novo chat no Cursor."
exit 0
