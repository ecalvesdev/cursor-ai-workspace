---
name: backend-architecture
description: >-
  Structures backend layers (transport, domain, persistence, integrations) and
  keeps boundaries clear. Use when adding modules, refactoring services, or
  deciding where business rules should live.
---

# Backend Architecture

## Objetivo
Colocar regras no lugar certo, com baixo acoplamento.

## Procedimento
1. Identificar o padrão já usado no repo (apps Django, routers FastAPI, handlers, etc.).
2. Separar: HTTP/RPC · validação de borda · domínio/caso de uso · persistência · integrações.
3. Evitar “god service” e model gordo que mistura transporte + regra + IO.
4. Preferir composição e dependências explícitas a estado global.
5. Só introduzir nova camada se reduzir complexidade real.

## Restrições
- Não impor Clean Architecture completa em app simples.
- Não quebrar organização compartilhada sem autorização.

## Saída
Onde cada peça vive · o que não misturar · pontos de extensão seguros.
