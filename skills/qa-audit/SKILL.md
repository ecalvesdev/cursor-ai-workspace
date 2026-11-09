---
name: qa-audit
description: >-
  Runs a full-system software QA audit by discovering entry points, modules,
  screens, APIs, data, auth, jobs, config, deploy, and tests from the real
  codebase, then investigating flows with evidence. Use when the user invokes
  $qa-audit, asks for a complete QA audit, system-wide bug hunt, security and
  integration review across the whole application, or full coverage matrix of
  an unknown stack.
disable-model-invocation: true
---

# QA Audit (sistema completo)

Auditoria independente de linguagem, framework e tipo de app. Descubra o sistema pelo código; não limite a uma lista predefinida de telas.

**Padrão:** auditar e entregar relatório **sem modificar** o produto.
**Correções:** só se o usuário pedir; preserve worktree; rode regressão.

Leia [reference.md](reference.md) para matriz, dimensões e modelo de achado.

## Workflow obrigatório

Copie e atualize:

```
QA Audit:
- [ ] 1. Contexto e limites do ambiente
- [ ] 2. Inventário do sistema (descoberta)
- [ ] 3. Matriz de cobertura
- [ ] 4. Verificações automáticas disponíveis
- [ ] 5. Análise por área + fluxos transversais
- [ ] 6. Achados classificados com evidência
- [ ] 7. Relatório final (todas as áreas com status)
```

### 1. Contexto e limites

- Leia README, docs, manifests, CI, scripts de start/deploy.
- Identifique stack, entrypoints, ambientes (dev/homolog/prod).
- Confirme o que pode executar (testes, app local, browser, DB).
- **Não** publicar, alterar produção, enviar comunicações ou operações destrutivas sem autorização explícita.
- Testes que mutam dados: só em ambiente isolado.
- Se faltar acesso, continue o restante e marque cobertura **bloqueada**.

### 2. Inventário (descoberta)

Mapeie pelo código e config (não por memória de produto):

- Pontos de entrada (HTTP, CLI, workers, mobile, desktop)
- Módulos e funcionalidades
- Telas, componentes, navegação
- Rotas, APIs, serviços
- Regras de negócio
- Perfis e permissões
- Modelos e armazenamento
- Integrações externas
- Jobs / filas / cron / background
- Comandos e tarefas administrativas
- Configuração e dependências
- Build, implantação e operação
- Testes e documentação
- Caminhos indiretos, admin, código fora do menu principal

Use esse inventário para a **matriz de cobertura**. Toda área recebe avaliação **ou** motivo explícito de não verificação.

### 3. Método por área

Para cada área descoberta:

1. Comportamento esperado (código, docs, contexto).
2. Implementação e dependências.
3. Entrada → processamento → persistência → resposta → UI.
4. Caminho feliz.
5. Entradas inválidas e limites.
6. Permissões e isolamento de dados.
7. Falhas, interrupções, repetição, concorrência.
8. Efeitos colaterais em outras áreas.
9. Evidências e status de cobertura.

Não audite só isolado: priorize **fluxos ponta a ponta** e impacto cruzado.

### 4. Execução

Na medida do ambiente:

- Testes/lint/typecheck/build do projeto
- Boot da aplicação e healthchecks
- Exercício de fluxos críticos (HTTP client, browser, CLI)
- Inspeção de schema/migrations quando seguro

Não declare que funciona só porque existe botão, handler ou teste com nome parecido. Siga o caminho completo até o resultado.

Ferramentas automáticas: valide achados antes de marcar como falha confirmada.

### 5. Classificação de registros

| Tipo | Critério |
|------|----------|
| **Falha confirmada** | Reproduzida ou caminho inequívoco no código |
| **Suspeita** | Indícios; falta verificação — diga qual |
| **Melhoria** | Oportunidade sem defeito demonstrado |

Prioridade **P0–P3** por impacto, alcance, probabilidade e condições. Consolide a mesma causa-raiz. Não invente achados, não infle gravidade, não trate preferência pessoal como defeito.

### 6. Encerramento

Só encerre depois que **todo o inventário** tiver status (verificado / parcial / bloqueado).

Não afirme “100% seguro”, “sem bugs” ou “totalmente validado” com cobertura parcial. Declare o alcance real.

Se pedirem correções: implemente, preserve alterações alheias, reexecute testes relevantes e documente no relatório.

## Relatório (obrigatório)

1. Visão breve do sistema identificado  
2. Matriz de cobertura (verificado / parcial / bloqueado)  
3. Achados por prioridade (P0→P3)  
4. Por achado: evidência, localização, reprodução, impacto, correção  
5. Testes e verificações executados  
6. Problemas de integração entre áreas  
7. Melhorias (separadas das falhas)  
8. Limitações e riscos não verificados  
9. Correções + regressão (somente se solicitadas)

Formato detalhado do achado e da matriz: [reference.md](reference.md).

## Anti-padrões

- Checklist genérico sem evidência do repositório real  
- Parar após os módulos mais óbvios  
- Marcar falha só por warning de linter sem validar  
- Escopo “só frontend” ou “só API” quando `$qa-audit` pediu o sistema  
- Mutar produção ou dados compartilhados sem autorização  
