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

## Uso

```powershell
.\scripts\validate.ps1
.\scripts\backup.ps1 -Label manual
.\scripts\install.ps1
.\scripts\validate.ps1 -CheckInstalled
.\scripts\homologate.ps1
.\scripts\update.ps1
```

Após instalar, abra um **novo** Agent chat no Cursor.

## O que este repo NÃO faz

- Não sobrescreve `skills-cursor/`
- Não versiona segredos nem conteúdo completo de skills de terceiros
- Não cria recursos cloud nem faz deploy
- Não substitui autorização humana em operações críticas
