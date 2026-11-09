# Homologação — Fase 10

Data: 2026-11-09  
Comando: `.\scripts\homologate.ps1` → **45 pass / 0 fail**

## Verificado automaticamente

| # | Cenário | Resultado |
|---|---------|-----------|
| — | 8 agents instalados com frontmatter válido | PASS |
| — | 32 skills próprias instaladas | PASS |
| — | 5 rules `.mdc` | PASS |
| — | Externas TLC + grill-me + grilling | PASS |
| — | `skills-cursor/` preservado | PASS |
| — | `validate.ps1 -CheckInstalled` | PASS |

## Roteamento esperado (checklist manual em novo chat)

| # | Cenário | Rota esperada |
|---|---------|---------------|
| 1 | App novo Next.js + Python + PostgreSQL | grill/TLC se ambíguo → `architect` → `backend-engineer` + `frontend-engineer` |
| 2 | Stack diferente (ex.: Go/Vue) | Neutro; mesmos líderes, skills adaptadas — sem forçar Django/Next |
| 3 | Django existente | Modo B → `repository-discovery` → `backend-engineer` / `django-development` |
| 4 | Projeto compartilhado | Modo C → preservar convenções; aprovar mudanças estruturais |
| 5 | Correção simples | Agente principal só; sem multiagente |
| 6 | Feature complexa | TLC Spec-Driven + especialistas + `qa-engineer` |
| 7 | Auditoria de segurança | `security-auditor` (+ baseline/LGPD skills); readonly por default |
| 8 | Delegação entre agentes | Invocar `/architect`, `/backend-engineer`, etc. no Agent chat |
| 9 | Economia de tokens | Rules `token-efficiency` + `task-routing` |
| 10 | Outro PC Windows | Clonar repo → `.\scripts\backup.ps1` → `.\scripts\install.ps1` → reinstalar externas via `external-skills.json` |

## Pendências manuais

- Abrir **novo chat Agent** e confirmar descoberta de agents/skills.
- Criar remoto GitHub privado `cursor-ai-workspace` (requer `gh`/token com permissão).
- Commit inicial local (não feito automaticamente).
- Exercitar TLC/grill em uma feature real quando houver projeto.
