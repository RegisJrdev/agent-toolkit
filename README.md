# agent-toolkit

Um toolkit para todos os municípios. O agente lê as regras gerais, o perfil do município e a referência de API ou Web necessária à tarefa.

```text
agent-toolkit/
├── AGENTS.md              # instruções de desenvolvimento dos projetos ePublic
├── docs/
│   ├── arquitetura.md     # responsabilidades das camadas e integração API/Web
│   ├── api.md             # padrões compartilhados da API
│   └── web.md             # padrões compartilhados da Web
├── municipios/
│   ├── guaribas.md        # um arquivo curto por município
│   ├── vera-mendes.md
│   └── ...
├── .claude/               # hook de início, agente revisor e skills
└── atualizar-toolkit.sh   # atualização da main ao iniciar sessão
```

## Iniciar uma sessão

O toolkit fica fora dos repositórios de aplicação. Inicie a sessão nesta pasta para carregar suas instruções, skills e agentes. Ao abrir diretamente uma API ou Web, não presuma que estas instruções foram carregadas; forneça o `AGENTS.md` antes de trabalhar.

Informe o município na conversa, por exemplo: **“No município Guaribas, ajuste o relatório de planejamento semestral.”** Ele consulta [o perfil de Guaribas](municipios/guaribas.md), [as regras de API](docs/api.md) e os arquivos indicados.

Se não informar o município, o agente apresenta os perfis disponíveis em `municipios/*.md` e pergunta qual deseja usar antes de trabalhar na API ou na Web. Usa um seletor quando a ferramenta oferecer esse recurso; caso contrário, pergunta no chat. Mesmo com apenas uma opção, aguarda sua escolha.

A escolha vale durante a sessão e pode ser trocada pela conversa. Dois chats podem trabalhar em municípios diferentes. Cada nova sessão faz sua própria escolha, sem executar script nem gerar arquivo local. Tarefas gerais no toolkit não exigem município.

## Acesso aos projetos

Abra o Claude Code pela CLI na pasta do toolkit:

```bash
cd /caminho/para/agent-toolkit
claude
```

Informe o município na conversa, por exemplo: **“Vou trabalhar em Vera Mendes.”** O agente procura os projetos neste padrão:

```text
~/repositorios/<municipio>/<municipio>-api
~/repositorios/<municipio>/<municipio>-web
```

O nome do município é o slug do perfil. O agente valida os diretórios necessários e continua; só pergunta se o caminho esperado não existir ou não estiver acessível. Não procura nomes alternativos nem outras pastas por conta própria. Um caminho informado explicitamente por você continua tendo prioridade.

Os caminhos valem durante a sessão. As permissões de acesso continuam sendo controladas pelo agente utilizado; autorize o acesso à pasta do projeto quando solicitado. Em outro agente, forneça `AGENTS.md` e os caminhos locais. O Claude Code consulta atualizações do toolkit ao iniciar ou retomar a sessão, conforme a seção abaixo.

## Arquitetura comum

[docs/arquitetura.md](docs/arquitetura.md) define responsabilidades de Controllers, FormRequests, Actions, Services, models, páginas, componentes e services HTTP. Também cobre contexto escolar, transações, contrato API/Web e evolução do legado. É lida ao planejar, implementar ou revisar módulos novos ou mudar responsabilidades entre camadas; particularidades ficam no perfil municipal.

## O que vai em cada perfil

Caminhos de referência dos checkouts analisados, versões declaradas, ferramentas/comandos que variam, particularidades e referências ao código. Cada município mantém um único arquivo `municipios/<slug>.md`, incluindo [Vera Mendes](municipios/vera-mendes.md). O perfil descreve o checkout analisado; confirme diferenças quando mudar de revisão. Documentação extra e ADRs só são criadas quando solicitadas.

Para adicionar um município, crie `municipios/<slug>.md` seguindo um perfil existente. Mantenha seus repositórios em `~/repositorios/<slug>/<slug>-api` e `~/repositorios/<slug>/<slug>-web`. Não copie o toolkit.

## Agente revisor opcional

O [revisor](.claude/agents/revisor.md) chama um modelo OpenAI pelo Codex CLI para revisar as alterações locais, sem corrigir arquivos. No Claude, peça: **“Use o agente revisor com Codex para revisar estas alterações.”** Ele usa o município da sessão e usa por padrão `gpt-6.1-sol` com raciocínio `low` (leve). No Codex, peça para seguir o mesmo arquivo do agente; a definição em `.claude/agents/` é descoberta nativamente apenas pelo Claude.

É necessário ter Codex CLI instalado, autenticado e acesso ao modelo escolhido. Quem usa apenas Claude continua normalmente: não há instalação automática, hook de revisão nem revisão obrigatória. O padrão é Sol (`gpt-6.1-sol`) com raciocínio leve (`low`), podendo substituir o modelo por pedido explícito ou `CODEX_REVIEW_MODEL`. A chamada usa `codex exec --model` com sandbox `read-only`, conforme a [documentação de execução não interativa](https://learn.chatgpt.com/docs/non-interactive-mode).

O agente chama diretamente `codex exec`, passando pela entrada padrão o objetivo, o município confirmado, o escopo e o conteúdo das regras aplicáveis. Não há script intermediário. O modelo padrão pode ser substituído por pedido explícito ou pela variável `CODEX_REVIEW_MODEL`.

Erros de autenticação, modelo ou execução são reportados sem substituição silenciosa. A revisão cobre staged, unstaged e arquivos novos não ignorados. A execução consome o uso da conta configurada no Codex. Evite alterar os arquivos enquanto a revisão está em andamento.

## Publicar tarefa

A skill [publicar-tarefa](.claude/skills/publicar-tarefa/SKILL.md) confere o ticket, a branch municipal, as alterações e as validações; publica somente a tarefa e abre ou reutiliza o PR para `homologacao`. Não faz merge nem deploy manual.

No Claude Code, use `/publicar-tarefa` ou peça **“Publique a tarefa #7304”**. No Codex, peça **“Publique a tarefa #7304 seguindo a skill indicada no AGENTS.md”**; o arquivo fica em `.claude/skills/` e não é descoberto nativamente como skill pelo Codex. O AGENTS encaminha o pedido para o mesmo procedimento. O município e o repo são os confirmados na sessão.

## Aplicação das regras

A leitura das regras e a atualização da documentação são orientadas pelo `AGENTS.md` e executadas pelo agente durante a tarefa. Não há hooks de verificação das regras; o único hook é o de atualização do toolkit ao iniciar a sessão.

## Manutenção do toolkit

O `AGENTS.md` orienta o desenvolvimento dos projetos ePublic: visão geral, localização dos repos, comandos, validação e workflow. Este README explica como usar e manter a instalação compartilhada.

Mantenha os padrões comuns em `docs/api.md`, `docs/web.md` e `docs/arquitetura.md`. Cada município tem um único perfil em `municipios/<slug>.md`, sem repetir regras comuns. Não crie pastas municipais, documentação extra ou ADRs sem solicitação. Mudanças relevantes nas instruções devem atualizar o arquivo correspondente na mesma tarefa.

## Atualização automática

O hook `SessionStart` do Claude Code executa `atualizar-toolkit.sh` ao iniciar, retomar ou limpar uma sessão aberta nesta pasta. Ele busca `origin/main` e aplica somente fast-forward quando o checkout está na `main` e sem alterações locais. Não cria commits, não faz push e não descarta mudanças. Falhas de rede, divergências ou trabalho local fazem a atualização ser pulada com aviso.

A atualização vale apenas para este toolkit, não para APIs ou Webs municipais. O hook tem limite de 30 segundos. Se houver atualização, o agente recebe instrução para reler o AGENTS; alterações de hooks ou definições de agentes podem exigir reiniciar a sessão. A recarga de skills usa o recurso `reloadSkills` das versões compatíveis do Claude Code. Veja a [referência de SessionStart](https://code.claude.com/docs/en/hooks#sessionstart).

Para executar manualmente, use `bash atualizar-toolkit.sh`. O hook é específico do Claude Code; outros agentes podem executar esse comando manualmente. O arquivo precisa estar presente no clone para a atualização automática começar a funcionar.
