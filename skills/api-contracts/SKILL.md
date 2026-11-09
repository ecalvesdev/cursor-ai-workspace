---
name: api-contracts
description: >-
  Defines and reviews API contracts: resources, status codes, validation,
  errors, pagination, auth, and compatibility. Use when designing or changing
  HTTP/RPC APIs or integration boundaries.
---

# API Contracts

## Objetivo
Contratos claros, estáveis e seguros o bastante para implementar sem adivinhar.

## Procedimento
1. Definir recursos/operações, autenticação e autorização por ação.
2. Especificar request/response, campos obrigatórios, tipos e limites.
3. Padronizar erros (código estável, mensagem segura, sem stack trace).
4. Paginação com limite máximo; filtros allowlist; ordenação determinística.
5. Idempotência em mutações críticas quando repetição for perigosa.
6. Compatibilidade: não quebrar contrato público sem versão/aprovação.

## Restrições
- Authz no servidor; nunca só no cliente.
- Não vazar existência de dados sensíveis em mensagens.
- Respeitar contratos já publicados em projetos compartilhados.

## Saída
Endpoints · schemas · authz · erros · paginação · notas de compatibilidade · exemplos mínimos.
