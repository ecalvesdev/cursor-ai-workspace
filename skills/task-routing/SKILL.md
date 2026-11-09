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

## Roteamento
1. Preferir skills/procedimentos ao criar subagente.
2. Subagente só se: isolamento de contexto, paralelismo seguro, auditoria independente ou expertise estreita.
3. Não paralelizar escritores nos mesmos arquivos sem isolamento (worktree se suportado).
4. Não convocar “toda a equipe” para tarefa simples.
5. Se TLC estiver instalada e a tarefa for complexa/nova: seguir Specify→Design→Tasks→Execute; não inventar metodologia paralela.
6. Se requisitos estiverem ambíguos e o impacto for alto: usar grill-me/grilling antes de codificar.

## Saída
Classe · skills a carregar · agentes (se houver) · aprovações necessárias · o que NÃO fazer agora.
