---
name: encryption-key-management
description: >-
  Guides safe handling of secrets and keys: storage, rotation, hashing passwords
  and avoiding hardcoding. Use when adding crypto, secrets or credential flows.
---

# Encryption & Key Management

1. Sem hardcode de chave/senha/token.
2. Secret manager ou env por ambiente; rotação e menor privilégio.
3. Senhas: Argon2id/bcrypt — nunca hash rápido (MD5/SHA) para senha.
4. TLS em trânsito; cifrar em repouso campos/volumes conforme risco.
5. Não logar material criptográfico nem chaves.
