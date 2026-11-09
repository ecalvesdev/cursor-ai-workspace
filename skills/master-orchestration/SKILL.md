---
name: master-orchestration
description: >-
  Playbook for the chefe/master orchestrator to classify work and automatically
  launch specialist Cursor agents via Task. Use on every non-trivial request
  when coordinating architect, backend, frontend, design, automation, devops,
  security or QA agents.
---

# Master Orchestration

## Objetivo
Fazer o chefe **acionar sozinho** os agentes certos, com brief completo e integração final.

## Passos
1. **Classificar** (simples/média/complexa/crítica) e modo A/B/C (`project-governance`).
2. Se repo desconhecido e tarefa ≥ média: `repository-discovery` ou Task `explore`.
3. **Escolher equipe mínima** (evitar convocar todos):
   - Desenho aberto → `architect`
   - Servidor → `backend-engineer`
   - Cliente → `frontend-engineer` (± `ui-ux-designer` se visual novo)
   - RPA → `automation-engineer`
   - Ops → `devops-engineer`
   - Risco auth/PII/prod → `security-auditor`
   - Feature média+ → `qa-engineer` ao final
4. **Abrir Task** com `subagent_type` exato; prompt com: contexto, arquivos, restrições, DoD, o que NÃO fazer.
5. Paralelo apenas sem conflito de arquivos.
6. Integrar; se ambíguo e impacto alto → grill; se feature complexa nova → TLC.
7. Fechar com `completion-report`.

## Anti-padrões
- Pedir ao usuário “qual agente quer”
- Delegar typo/CSS trivial
- Task sem contexto suficiente
- Dois writers no mesmo arquivo em paralelo
