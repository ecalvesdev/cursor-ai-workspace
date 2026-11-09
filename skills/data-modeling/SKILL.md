---
name: data-modeling
description: >-
  Designs or reviews data models, schemas, migrations, indexes, and integrity
  rules for SQL and document stores. Use when creating tables, changing schema,
  or analyzing persistence trade-offs.
---

# Data Modeling

## Objetivo
Modelar dados a partir de casos de uso reais, com integridade e migração segura.

## Procedimento
1. Listar entidades, relações e invariantes do domínio.
2. Preferir normalização; desnormalizar só com justificativa.
3. Definir PKs, FKs, unique, NOT NULL e checks relevantes.
4. Indexar conforme filtros/joins/ordenação reais — validar necessidade.
5. Planejar migration: expand/contract, locks, backfill, rollback, compatibilidade no deploy.
6. Datas em UTC na persistência; dinheiro em decimal/inteiro (nunca float).

## Restrições
- Sem migration destrutiva sem aprovação.
- Sem expor PII demais; minimizar campos sensíveis.
- Respeitar engine/versão reais do projeto.

## Saída
Modelo (entidades/campos) · constraints · índices · plano de migration · riscos.
