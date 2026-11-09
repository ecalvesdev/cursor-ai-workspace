---
name: ci-cd
description: >-
  Designs CI/CD pipelines for lint, tests, build, security scans and controlled
  deploys. Use when adding or changing GitHub Actions or equivalent pipelines.
---

# CI/CD

1. Pipeline reproduzível: install → lint/type → test → build.
2. Segredos só em secrets do CI; least privilege nos tokens.
3. Gates em main/produção; deploy só com autorização do fluxo.
4. Artefatos imutáveis; rollback pensado.
5. Não pular hooks/testes para “ficar verde”.
