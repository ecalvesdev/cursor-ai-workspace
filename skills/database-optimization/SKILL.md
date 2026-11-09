---
name: database-optimization
description: >-
  Improves query performance and integrity: indexes, N+1, select/prefetch,
  pagination, and explain plans. Use when fixing slow queries or designing
  data access paths.
---

# Database Optimization

## Objetivo
Consultas corretas e rápidas o bastante, medidas — não otimizadas por intuição.

## Procedimento
1. Reproduzir a consulta lenta ou o padrão N+1.
2. Buscar só colunas necessárias; paginar conjuntos grandes.
3. Eager load consciente (select_related/prefetch ou joins equivalentes).
4. Índices alinhados a filtros/joins/ordem; validar com EXPLAIN quando possível.
5. Transações curtas; cuidado com locks em migration/backfill.
6. Comparar antes/depois com métrica simples quando o risco justificar.

## Restrições
- Não criar índice “por precaução” em tudo.
- Não cachear resultado errado para esconder query ruim.
- Respeitar limites do SGBD do projeto.
