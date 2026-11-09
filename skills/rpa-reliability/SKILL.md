---
name: rpa-reliability
description: >-
  Makes automations resumable and idempotent with retries, backoff and safe
  logging. Use when hardening batch RPA or flaky workflows.
---

# RPA Reliability

1. Projetar retomada por item/etapa com status persistido.
2. Retry só em falha transitória; limite + backoff.
3. Idempotência: reexecutar não duplica efeito colateral.
4. Logs: item, etapa, tentativa, duração, erro — sem segredos/PII.
5. Validar entradas de planilha (cabeçalho, tipos, vazios, duplicatas).
