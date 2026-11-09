---
name: security-baseline
description: >-
  Applies a proportional security baseline: authn/authz, validation, secrets,
  headers and safe defaults. Use on every non-trivial feature and before release.
---

# Security Baseline

Checklist mínimo (adaptar ao risco):
1. Authn robusta; authz no servidor por ação/objeto.
2. Validação de entrada; queries parametrizadas; escaping XSS.
3. Segredos fora do código/git/logs/cliente.
4. Cookies de sessão seguros; CSRF quando aplicável.
5. Rate limit em login/recovery/APIs abusáveis.
6. Headers de segurança adequados ao app.
7. Dependências sem vulnerabilidade crítica conhecida no escopo.

Não declarar segurança absoluta.
