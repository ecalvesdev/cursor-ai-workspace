---
name: frontend-performance
description: >-
  Improves frontend load and runtime performance: bundles, images, fonts,
  rendering and motion cost. Use when optimizing Core Web Vitals or heavy UI.
---

# Frontend Performance

1. Medir antes de otimizar (bundle, rede, rendering).
2. Code-split rotas/componentes pesados; lazy quando fizer sentido.
3. Otimizar imagens/fontes; evitar JS/CSS morto novo.
4. Animar `transform`/`opacity`; respeitar `prefers-reduced-motion`.
5. Não sacrificar acessibilidade por microganhos.
