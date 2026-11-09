---
name: secure-session-cookies
description: >-
  Configures session cookies and CSRF protections safely (HttpOnly, Secure,
  SameSite, rotation). Use when implementing login sessions or cookie auth.
---

# Secure Session Cookies

1. `HttpOnly` + `Secure` em HTTPS + `SameSite` adequado ao fluxo.
2. Preferir `Strict` quando possível; `Lax` se OAuth/links exigirem.
3. Rotacionar id de sessão após login/elevação; expiração e revogação.
4. Proteger mutações cookie-based com CSRF.
5. Tokens de acesso curtos; evitar `localStorage` para sessão sensível sem análise.
