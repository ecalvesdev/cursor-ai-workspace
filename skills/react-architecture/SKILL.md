---
name: react-architecture
description: >-
  Structures React components, hooks and state with clear boundaries and
  reusable composition. Use when designing or refactoring React UI architecture.
---

# React Architecture

1. Componentes focados; extrair hooks para lógica reutilizável.
2. Estado o mais perto possível do uso; evitar prop drilling profundo sem necessidade.
3. Separar apresentação de acesso a dados quando o projeto já faz isso.
4. Listas com keys estáveis; efeitos com dependências corretas.
5. Não adicionar memoization por default se o projeto usa React Compiler / não precisa.
