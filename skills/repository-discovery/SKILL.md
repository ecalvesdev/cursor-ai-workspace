---
name: repository-discovery
description: >-
  Maps a repository quickly with targeted searches: entrypoints, apps,
  packages, configs, tests, and key domains. Use when exploring an unfamiliar
  codebase, preparing architecture work, or before broad changes.
---

# Repository Discovery

## Objetivo
Obter mapa útil do repositório com o mínimo de leitura.

## Procedimento
1. Listar raiz e manifests (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `composer.json`, etc.).
2. Identificar apps/pacotes (monorepo vs single-app).
3. Localizar entrypoints (web, API, workers, CLI).
4. Encontrar testes, CI, Docker, `.env.example`.
5. Buscar domínios pedidos pelo usuário com Grep/Glob direcionados — não varrer tudo.
6. Parar quando houver mapa suficiente para a tarefa; não continuar por curiosidade.

## Saída
- Tipo de repo
- Stack
- Entrypoints
- Áreas relevantes ao pedido
- Arquivos prioritários para a próxima leitura
- Lacunas (o que ainda não foi verificado)

## Restrições
- Não modificar arquivos.
- Não imprimir segredos de `.env`.
- Preferir caminhos absolutos nas referências.
