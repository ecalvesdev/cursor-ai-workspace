---
name: api-development
description: >-
  Implements HTTP/RPC APIs with validation, authz, consistent errors, pagination,
  and tests. Use when creating or changing endpoints and server handlers.
---

# API Development

## Objetivo
Entregar endpoints corretos, seguros e alinhados ao contrato.

## Procedimento
1. Confirmar contrato (`api-contracts`) ou espelhar endpoints vizinhos.
2. Autenticar/autorizar no servidor por ação e objeto.
3. Validar tipo, tamanho, allowlist; rejeitar input inesperado.
4. Status HTTP semânticos; erros estáveis sem detalhes internos.
5. Paginação com teto; ordenação determinística.
6. Timeouts/retries só para falhas transitórias em IO externo.
7. Testar feliz, validação, 401/403 e caso IDOR quando houver objeto.

## Restrições
- Sem lógica de negócio pesada no controller se o projeto já separa serviços.
- Sem logar tokens, senhas ou PII desnecessária.
