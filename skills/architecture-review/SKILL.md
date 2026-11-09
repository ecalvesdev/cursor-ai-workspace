---
name: architecture-review
description: >-
  Reviews system architecture for cohesion, coupling, boundaries, scalability
  risks, and fit with existing patterns. Use when evaluating a design, PR with
  structural changes, or before approving a new module layout.
---

# Architecture Review

## Objetivo
Avaliar se o desenho é simples, coerente e sustentável no contexto do projeto.

## Procedimento
1. Identificar modo do projeto (A/B/C) e padrões já adotados.
2. Mapear limites: UI, domínio, infraestrutura, integrações.
3. Verificar acoplamento indevido, duplicação de responsabilidades e “camadas fantasma”.
4. Checar compatibilidade com stack/contratos existentes.
5. Listar riscos de evolução (schema, auth, deploy, observabilidade).
6. Recomendar: aceitar / ajustar / reduzir escopo — com justificativa curta.

## Critérios
- Coesão e baixo acoplamento
- YAGNI: sem microsserviço/abstração sem necessidade
- Caminho de teste e rollback pensados
- Segurança nas fronteiras (authn/authz, validação)

## Saída
Achados por severidade · recomendações · o que preservar · o que mudar.
