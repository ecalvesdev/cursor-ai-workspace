---
name: browser-automation
description: >-
  Builds browser automation with Playwright or Selenium using stable selectors,
  explicit waits and authorized targets only. Use for UI automation scripts and
  RPA browser flows.
---

# Browser Automation

1. Preferir Playwright em automações novas; manter Selenium se o repo exigir.
2. Esperas por estado observável; evitar sleep fixo como mecanismo principal.
3. Seletores: test id → role/label → id estável → estrutural (último).
4. Timeout, evidência de falha (screenshot/log), cleanup do browser.
5. Nunca contornar CAPTCHA/MFA/antiabuso; parar e reportar bloqueios.
