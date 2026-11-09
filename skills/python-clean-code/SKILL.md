---
name: python-clean-code
description: >-
  Applies clear Python style: typing where useful, explicit errors, small
  functions, and project lint/type tooling. Use when writing or refactoring
  Python backend code.
---

# Python Clean Code

## Objetivo
Código Python legível, tipado o suficiente e testável.

## Procedimento
1. Seguir versão e tooling do repo (Ruff, mypy/pyright, black/isort se existirem).
2. Tipar interfaces públicas e pontos de confusão; evitar `Any` amplo.
3. Funções curtas; nomes de domínio; erros explícitos (sem `except:` vazio).
4. Sem `eval`/`exec`/pickle inseguro sobre input externo.
5. Datas timezone-aware; dinheiro fora de `float`.
6. Remover dead code introduzido pela mudança.

## Restrições
- Não reformatar arquivos inteiros sem necessidade.
- Não adicionar dependência de produção sem necessidade/aprovação.
