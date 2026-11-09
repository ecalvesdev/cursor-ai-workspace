---
name: task-routing
description: >-
  Classifies request complexity and routes work to the right skills, specialists,
  or subagents. Use after understanding the ask and before multi-step
  implementation or delegation.
---

# Task Routing

## Objetivo
Escolher o caminho de menor custo que ainda cubra risco e qualidade.

## Classificação
| Classe | Exemplos | Fluxo |
|--------|----------|-------|
| Simples | texto, CSS pontual, bug isolado | Direto no agente principal |
| Média | form, endpoint, filtro | Spec enxuta → implementação → QA pontual |
| Complexa | módulo novo, auth, integração | grill/TLC conforme ambiguidade → especialistas |
| Crítica | migração, produção, irreversível | Aprovação + impacto + segurança + verificação |

## Roteamento (o chefe ACIONA — não pergunta qual agente usar)
1. Simples: executar no agente principal.
2. Média+: abrir Task nos líderes (`architect`, `backend-engineer`, `frontend-engineer`, `ui-ux-designer`, `automation-engineer`, `devops-engineer`, `security-auditor`, `qa-engineer`) conforme a tabela da rule `master-orchestrator`.
3. Subagente também quando: isolamento, paralelismo seguro, auditoria independente.
4. Não paralelizar writers nos mesmos arquivos.
5. Não convocar a equipe inteira por default — só os necessários.
6. Complexa/nova com TLC: Specify→Design→Tasks→Execute.
7. Ambíguo + impacto alto: grill-me/grilling antes de codificar.

## Saída
Classe · agentes a acionar (e por quê) · skills · aprovações · o que NÃO fazer agora.  
Em seguida **dispare os Tasks**; não pare no plano.
