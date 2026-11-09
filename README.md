# cursor-ai-workspace

Configuração versionada do ambiente global de engenharia com agentes no Cursor IDE.

Objetivo: sincronizar **agents**, **skills próprias** e **rules** entre computadores Windows, com backup e validação, sem versionar segredos.

## Estado atual — Fases 1–10 concluídas (estrutural)

| Camada | Conteúdo |
|--------|----------|
| Rules | 5 (Master Orchestrator + governança + segurança + tokens + entrega) |
| Agents | 8 líderes técnicos |
| Skills próprias | 32 |
| Skills externas | `tlc-spec-driven`, `grill-me`, `grilling` (não versionar conteúdo) |
| Scripts | `backup`, `install`, `update`, `validate`, `homologate` |
| Remoto GitHub | **não criado** |
| Commit inicial | **não criado** (peça se quiser) |

Homologação estrutural: ver [HOMOLOGATION.md](HOMOLOGATION.md) (`.\scripts\homologate.ps1` → 45 pass).

## Agents

| Agente | Função |
|--------|--------|
| `architect` | Requisitos, desenho, dados, APIs, codebase |
| `backend-engineer` | APIs, domínio, persistência, auth, jobs |
| `frontend-engineer` | UI web, estado, integração, performance, a11y |
| `ui-ux-designer` | Hierarquia visual, design system, usabilidade |
| `automation-engineer` | Playwright/Selenium, RPA, batches |
| `devops-engineer` | Docker, CI/CD, deploy, ops |
| `security-auditor` | AppSec, LGPD técnica, segredos, auth |
| `qa-engineer` | Estratégia de testes, regressão, evidências |

## Skills próprias (resumo)

Orquestração: `project-governance`, `repository-discovery`, `task-routing`, `change-impact-analysis`, `completion-report`  
Arquitetura: `architecture-review`, `data-modeling`, `api-contracts`  
Backend: `backend-architecture`, `api-development`, `django-development`, `python-clean-code`, `database-optimization`  
Frontend: `nextjs-development`, `react-architecture`, `javascript-typescript`, `responsive-layout`, `frontend-performance`, `web-accessibility`, `design-system`  
Automação: `browser-automation`, `rpa-reliability`  
DevOps: `docker-deployment`, `ci-cd`  
Segurança: `security-baseline`, `lgpd-privacy-by-design`, `encryption-key-management`, `secure-session-cookies`, `rate-limit-protection`  
QA: `test-strategy`, `e2e-testing`, `qa-audit`

## Skills externas

| Skill | Caminho típico | Reinstall |
|-------|----------------|-----------|
| `tlc-spec-driven` | `~/.cursor/skills/tlc-spec-driven` | `npx @tech-leads-club/agent-skills install -s tlc-spec-driven -a cursor -g` |
| `grill-me` | `~/.agents/skills/grill-me` | `npx skills add https://github.com/mattpocock/skills -g -a cursor -s grill-me -y --copy` |
| `grilling` | `~/.agents/skills/grilling` | idem com `-s grilling` |

Detalhes em `external-skills.json`.

## Destinos no Cursor (Windows)

| Artefato | Caminho |
|----------|---------|
| Agents | `%USERPROFILE%\.cursor\agents\` |
| Skills próprias | `%USERPROFILE%\.cursor\skills\` |
| Rules em arquivo | `%USERPROFILE%\.cursor\rules\` |
| Skills internas | `%USERPROFILE%\.cursor\skills-cursor\` (**nunca modificar**) |

User Rules da **conta** (Customize → Rules) são separadas e sincronizam por login.

## Instalar em outro PC (Windows)

Requisitos: Git, Node.js (npx), Cursor instalado, login GitHub com acesso a este repo privado.

```powershell
# 1) Clonar
cd $env:USERPROFILE\Documents\Projetos
git clone https://github.com/ecalvesdev/cursor-ai-workspace.git
cd cursor-ai-workspace

# 2) Backup do Cursor atual + instalar agents/skills/rules deste repo
.\scripts\backup.ps1 -Label pre-install
.\scripts\install.ps1
.\scripts\homologate.ps1

# 3) Skills externas (não vão no git; reinstalar pelo manifesto)
npx --yes @tech-leads-club/agent-skills install -s tlc-spec-driven -a cursor -g
npx --yes skills add https://github.com/mattpocock/skills -g -a cursor -s grill-me -s grilling -y --copy

# 4) Conferir de novo
.\scripts\validate.ps1 -CheckInstalled
```

Abra um **novo** Agent chat no Cursor. User Rules da conta sincronizam pelo login Cursor; as rules em arquivo vêm do `install.ps1`.

## Atualizar um PC já instalado

```powershell
cd caminho\para\cursor-ai-workspace
.\scripts\update.ps1
# Se o manifesto de externas mudou, rode de novo os comandos npx da seção acima.
```

## Uso local (scripts)

```powershell
.\scripts\validate.ps1
.\scripts\backup.ps1 -Label manual
.\scripts\install.ps1
.\scripts\validate.ps1 -CheckInstalled
.\scripts\homologate.ps1
.\scripts\update.ps1
```

## O que este repo NÃO faz

- Não sobrescreve `skills-cursor/`
- Não versiona segredos nem conteúdo completo de skills de terceiros
- Não cria recursos cloud nem faz deploy
- Não substitui autorização humana em operações críticas
