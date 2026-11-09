# QA Audit — referência

## Matriz de cobertura

Para cada item do inventário, registre uma linha:

| Área / fluxo | Método | Status | Notas |
|--------------|--------|--------|-------|
| Ex.: Auth login | código + teste HTTP | Verificado | CSRF + 403 viewer |
| Ex.: Job noturno | só código | Parcial | Sem runner local |
| Ex.: Pagamento prod | — | Bloqueado | Sem credenciais / sem ambiente |

**Status**

- **Verificado:** exercício ou prova forte no código + checagem adequada ao risco  
- **Parcial:** inspeção relevante, execução incompleta  
- **Bloqueado:** impossível no ambiente; motivo obrigatório  

Priorize profundidade por risco, mas percorra **todas** as áreas do inventário.

## Dimensões (orientadoras)

Aplicar onde couber; acrescentar o que o sistema exigir:

- Correção funcional  
- Coerência das regras de negócio  
- Integração entre componentes  
- Validação e tratamento de erros  
- Persistência e integridade dos dados  
- Transações, concorrência e idempotência  
- Autenticação, autorização e privacidade  
- Segurança de entradas, saídas, arquivos e configurações  
- Desempenho e consumo de recursos  
- Usabilidade, acessibilidade e responsividade  
- Compatibilidade entre ambientes  
- Resiliência e recuperação de falhas  
- Observabilidade e diagnóstico  
- Organização e manutenção do código  
- Dependências e código sem uso  
- Qualidade dos testes  
- Fidelidade da documentação  
- Build, implantação, migrações e retorno de versão  

## Modelo de achado

```markdown
### [P0|P1|P2|P3] Título curto
- **Tipo:** Falha confirmada | Suspeita | Melhoria
- **Áreas:** …
- **Evidência:** arquivo:linha, trecho, log, resposta HTTP, captura — o que for factual
- **Análise:** estática | execução | ambas
- **Reprodução:** passos mínimos (ou “caminho inequívoco no código: …”)
- **Impacto:** …
- **Condições:** auth, dados, feature flag, ambiente
- **Correção recomendada:** …
- **Verificação pendente:** (obrigatório se Suspeita)
```

## Prioridades

| Pri | Uso |
|-----|-----|
| P0 | Perda de dados, bypass de authz, dinheiro incorreto, RCE/secreto exposto, indisponibilidade ampla |
| P1 | Bug grave em fluxo principal, IDOR relevante, corrupção sob concorrência |
| P2 | Falha em fluxo secundário, validação frágil, regressão provável |
| P3 | Baixo impacto, edge case raro, dívida clara sem exploração imediata |

## Descoberta — pistas por stack (não exaustivo)

Use o que existir no repo; ignore o que não houver.

| Sinal | Investigar |
|-------|------------|
| `urls.py`, `routes/`, `app.get`, `@app.route` | Rotas HTTP |
| `templates/`, `*.tsx` pages, `views/` | UI |
| `models.py`, Prisma, migrations, schema | Persistência |
| `celery`, `bull`, `cron`, `manage.py` commands | Background / admin |
| `Dockerfile`, `railway.toml`, CI yaml | Deploy |
| `test_`, `spec.`, `e2e` | Testes existentes |

## Integração entre áreas

Sempre que uma operação mutar estado, pergunte:

1. O que mais lê esse estado?  
2. Contadores, saldos, caches e listagens ficam coerentes?  
3. Retry/idempotência evita duplicar efeito?  
4. Permissão na UI ≠ autorização no servidor?  

Documente falhas cruzadas numa seção própria do relatório.

## Limites honestos

No fechamento, liste explicitamente:

- Ambientes não exercitados  
- Contas/perfis não usados  
- Integrações mockadas ou ausentes  
- Dados de produção não tocados (e não devem ser)  
- Ferramentas desejáveis não disponíveis  

Nunca conclua segurança ou ausência de bugs com cobertura parcial.
