---
name: nextjs-development
description: >-
  Implements Next.js apps with App Router or Pages conventions, server/client
  boundaries, routing, and data fetching. Use when working in Next.js codebases.
---

# Next.js Development

1. Detect App Router vs Pages e seguir o padrão do repo.
2. Server Components por default; Client só com estado/efeito/browser APIs.
3. Nunca importar segredo/SDK admin no cliente.
4. Respeitar caching/revalidate do projeto; evitar waterfalls.
5. Metadata, rotas de erro e loading conforme estrutura existente.
