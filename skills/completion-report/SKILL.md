---
name: completion-report
description: >-
  Produces a compact delivery report with objective, changes, validation,
  security, and pendencies. Use at the end of implementation tasks or when the
  user asks for a handoff summary.
---

# Completion Report

## Objetivo
Fechar a tarefa com evidência, sem relatório inchado.

## Formato (obrigatório)
**Objetivo:** o que foi pedido.  
**Alterações:** o que realmente mudou (caminhos).  
**Validação:** comandos/testes rodados e resultado.  
**Segurança:** riscos ou controles relevantes (sem segredos).  
**Pendências:** o que ficou aberto.  
**Próximo passo:** só se necessário.

## Regras
- Não declarar teste executado se não rodou.
- Não declarar segurança/conformidade sem evidência.
- Não repetir o pedido inteiro.
- Preferir bullets curtos a prosa longa.
