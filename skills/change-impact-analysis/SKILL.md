---
name: change-impact-analysis
description: >-
  Analyzes blast radius of a proposed change across APIs, data, auth, UI, jobs,
  and deploy. Use before critical or complex changes, migrations, or shared
  architecture edits.
---

# Change Impact Analysis

## Objetivo
Estimar impacto e pré-condições antes de alterar.

## Procedimento
1. Declarar a mudança proposta em uma frase.
2. Mapear dependentes: callers, schemas, templates, jobs, configs, testes.
3. Classificar impacto: local | módulo | sistema | produção.
4. Listar riscos: dados, auth, compatibilidade, downtime, rollback.
5. Definir evidências mínimas (testes/comandos) para aceitar a mudança.
6. Se crítica: exigir aprovação explícita e plano de recuperação antes de executar.

## Saída
- Escopo afetado
- Riscos (com severidade)
- Aprovações necessárias
- Plano de validação
- Rollback / mitigação
- Recomendação: seguir / reduzir escopo / abortar

## Restrições
- Não implementar durante a análise, salvo pedido explícito.
- Não minimizar risco para “ganhar velocidade”.
