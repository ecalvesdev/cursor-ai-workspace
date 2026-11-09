---
name: test-strategy
description: >-
  Chooses proportional unit, integration and E2E tests based on risk and change
  impact. Use when planning verification for a feature or bugfix.
---

# Test Strategy

1. Mapear riscos: auth, dinheiro, PII, regressão de contrato.
2. Unitário para regra pura; integração para DB/API; E2E só jornadas críticas.
3. Determinismo: controlar tempo/rede/aleatoriedade.
4. Incluir caso negativo (ex.: usuário A não acessa dado de B).
5. Toda correção de bug, quando viável, ganha teste que falharia antes.
