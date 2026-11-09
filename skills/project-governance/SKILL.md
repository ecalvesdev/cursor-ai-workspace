---
name: project-governance
description: >-
  Detects project mode (new personal, existing personal, shared/corporate),
  inventories stack and conventions, and sets change boundaries before edits.
  Use at the start of non-trivial work, when opening an unfamiliar repo, or
  when the user mentions team/shared/corporate constraints.
---

# Project Governance

## Objetivo
Classificar o projeto e preservar padrões antes de qualquer alteração material.

## Quando usar
- Início de tarefa média/complexa/crítica.
- Repo desconhecido ou troca de contexto.
- Indícios de projeto compartilhado.

## Entradas
- Workspace aberto, README/docs, manifests, `.cursor/rules`, CI, histórico git se houver.

## Procedimento
1. **Modo**
   - A: pessoal novo (pouca/nenhuma estrutura de produto).
   - B: pessoal existente (código próprio com padrões locais).
   - C: compartilhado/corporativo (equipe, org, contratos estabelecidos). Na dúvida entre B e C, trate como C até prova em contrário.
2. **Inventário mínimo**: linguagem(ns), framework(s), banco, auth, layout de pastas, scripts de teste/lint/build, rules/skills do projeto.
3. **Contratos a preservar**: APIs públicas, schema, auth, padrões visuais, libs já adotadas.
4. **Limites da mudança**: o que pode mudar agora; o que exige aprovação.
5. **Declare em 3–6 linhas** o modo, a stack e as restrições antes de editar.

## Restrições
- Não refatore amplamente fora do escopo.
- Não converta stack sem autorização.
- Não invente convenções; derive do repo.

## Resultado
Resumo curto: modo · stack · preservar · escopo autorizado · riscos.
