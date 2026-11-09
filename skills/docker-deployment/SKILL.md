---
name: docker-deployment
description: >-
  Creates and reviews Docker/Compose setups for app runtime, healthchecks and
  safe defaults. Use when containerizing services or fixing container deploys.
---

# Docker Deployment

1. Imagens oficiais mínimas; usuário não-root quando viável.
2. Não bakear segredos; usar env/secrets em runtime.
3. Healthcheck, porta, comando de start e volumes explícitos.
4. Multi-stage build quando reduzir imagem importar.
5. Compose: separar serviços; redes/portas mínimas expostas.
