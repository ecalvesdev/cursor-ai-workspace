---
name: django-development
description: >-
  Implements Django features with project conventions: apps, ORM, forms/DRF,
  auth, admin, migrations, and tests. Use when working in Django or Django REST
  Framework codebases.
---

# Django Development

## Objetivo
Entregar mudanças Django alinhadas ao projeto, sem reinventar o framework.

## Procedimento
1. Respeitar versão do Django e apps existentes (URLconf, settings, apps.py).
2. Models: constraints no banco; `full_clean`/serializers na borda.
3. Views/ViewSets finas; regras em services/use-cases se o projeto já usa.
4. DRF: serializers, permissions, throttling conforme padrão local.
5. Migrations reversíveis quando possível; nunca editar migration já aplicada em compartilhado sem plano.
6. Testes com o runner do projeto (`pytest-django` ou `TestCase`).

## Restrições
- Sem `DEBUG`/credenciais em settings versionados.
- Sem raw SQL concatenado; ORM/params.
- Admin e APIs públicas seguem authz real, não “security by obscurity”.
