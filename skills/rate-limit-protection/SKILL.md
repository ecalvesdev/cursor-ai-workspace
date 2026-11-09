---
name: rate-limit-protection
description: >-
  Adds abuse protection via rate limits on login, recovery and sensitive APIs.
  Use when exposing authentication or costly endpoints.
---

# Rate Limit Protection

1. Limitar login, reset de senha e APIs caras por IP/identidade/rota.
2. Respostas seguras (sem vazar existência de conta além do necessário).
3. Observar bloqueios (métricas/logs sem PII).
4. App rate limit não substitui WAF/CDN contra DDoS.
5. Fail closed quando o risco for alto e o store de limite estiver fora.
